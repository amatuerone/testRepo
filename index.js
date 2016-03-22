
var githubapi = require('github'),
	async = require('async')


var AWS = require('aws-sdk');

console.log("starting handler function.");

exports.handler = function(event, context){
	console.log("getting bucket and file...")
	var bucket = event.Records[0].s3.bucket.name;
	var file = event.Records[0].s3.object.key;
	console.log(bucket + "..." + "file: " + file);

	var s3 = new AWS.S3({apiVersion: '2006-03-01'});
	AWS.config.loadFromPath('./s3-config.json');
	
	console.log("here reached.");
	var referenceCommitSha, newTreeSha, newCommitSha, code;
	var params = {
	  Bucket: bucket,
	  Key: file
	}


// uploading to github part of work.
	var name = 'amatuerone',
		password = 'password',
		repo     = 'testRepo',
		commitMessage = 'commit from AWS lambda.'

	var github = new githubapi({version: "3.0.0"});	
	github.authenticate({
		type: "basic",
		username: name,
		password: password
	});
	async.waterfall([
		function(callback){
			console.log("getting code from s3.");
			s3.getObject(params, function(err, data) {
			if (err)
				 console.log(err, err.stack);
			else
				{
			     code = data.Body.toString('utf8');
			 	 callback(null);
			 	}
			});
		},

		function(callback){
			console.log("getting reference...");
			github.gitdata.getReference({
				user: name,
				repo: repo,
				ref: 'heads/master'}, function(err, data){
					if (err)
						console.log("error in referencing." + err)
					if (!err) {
						console.log("commit - " + data.object);
						referenceCommitSha = data.object.sha;
						callback(null);
					};
				});
		},

		function(callback){
			console.log('creating tree...');
			var files = [];
			files.push({
				path: file,
				mode: '100644',
				type: 'blob',
				content: code
			});
			github.gitdata.createTree({
				user: name,
				repo: repo,
				tree: files,
				base_tree: referenceCommitSha
			}, function(err, data){
				if (err)
					console.log(err);
				if (!err) 
					{
						newTreeSha = data.sha;
						callback(null);
					};
			});
		},

		function(callback){
			console.log("creating the commit..");
			github.gitdata.createCommit({
				user: name,
				repo: repo,
				message: commitMessage,
				tree : newTreeSha,
				parents: [referenceCommitSha]
			}, function(err, data){
				if (err)
					console.log(err);
				if (!err) {
					newCommitSha= data.sha;
					callback(null);
				};
			});	
		},
		function(callback){
			console.log("updating reference..");
			github.gitdata.updateReference({
				user: name,
				repo: repo,
				ref: 'heads/master',
				sha: newCommitSha,
				force: true
			}, function(err, data){
				if (err)
					console.log(err);
				if (!err) {
					callback(null, 'done');
				};
			});
		}
		], function(err, data){
			if (err) 
				context.done(err, "Damnn error!");
			if (!err) 
				context.done(null, "code succussfully pushed to github.")
		});
}