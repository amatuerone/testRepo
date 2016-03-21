; **************** BEGIN INITIALIZATION FOR ACL2s B MODE ****************** ;
; (Nothing to see here!  Your actual file is after this initialization code);

#|
Pete Manolios
Fri Jan 27 09:39:00 EST 2012
----------------------------

Made changes for spring 2012.


Pete Manolios
Thu Jan 27 18:53:33 EST 2011
----------------------------

The Beginner level is the next level after Bare Bones level.

|#

; Put CCG book first in order, since it seems this results in faster loading of this mode.
#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading the CCG book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "ccg/ccg" :uncertified-okp nil :dir :acl2s-modes :ttags ((:ccg)) :load-compiled-file nil);v4.0 change

;Common base theory for all modes.
#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s base theory book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "base-theory" :dir :acl2s-modes)

#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s customizations book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "custom" :dir :acl2s-modes :uncertified-okp nil :ttags :all)

;Settings common to all ACL2s modes
(acl2s-common-settings)

#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading trace-star and evalable-ld-printing books.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "trace-star" :uncertified-okp nil :dir :acl2s-modes :ttags ((:acl2s-interaction)) :load-compiled-file nil)
(include-book "hacking/evalable-ld-printing" :uncertified-okp nil :dir :system :ttags ((:evalable-ld-printing)) :load-compiled-file nil)

;theory for beginner mode
#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s beginner theory book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "beginner-theory" :dir :acl2s-modes :ttags :all)


#+acl2s-startup (er-progn (assign fmt-error-msg "Problem setting up ACL2s Beginner mode.") (value :invisible))
;Settings specific to ACL2s Beginner mode.
(acl2s-beginner-settings)

; why why why why 
(acl2::xdoc acl2s::defunc) ; almost 3 seconds

(cw "~@0Beginner mode loaded.~%~@1"
    #+acl2s-startup "${NoMoReSnIp}$~%" #-acl2s-startup ""
    #+acl2s-startup "${SnIpMeHeRe}$~%" #-acl2s-startup "")


(acl2::in-package "ACL2S B")

; ***************** END INITIALIZATION FOR ACL2s B MODE ******************* ;
;$ACL2s-SMode$;Beginner
#|
Arthur, Ryan and Richard


CS 2800 Homework 8 - Spring 2016

This homework is done in groups. The groups are normally the same ones as in 
Assignment #7.  Changes can be made on request.  However, all such requests
must be made at least two days before the assignment is due, and all the 
students involved must agree to the changes.  When making a request for a
change in the groups, please specify all of the changes, and remember that
a group cannot consist of a single student.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

For this homework you will need to use ACL2s.

Technical instructions:

- open this file in ACL2s as hw08.lisp

- make sure you are in BEGINNER mode. This is essential! Note that you can
  only change the mode when the session is not running, so set the correct
  mode before starting the session.

- insert your solutions into this file where indicated (usually as "...")

- only add to the file. If you comment out any pre-existing text in this
  file, then give a brief explanation, such as "The test failed".

- make sure the entire file is accepted by ACL2s. In particular, there must
  be no "..." left in the code. If you don't finish all problems, comment
  the unfinished ones out. If a test fails, comment it out but give a brief
  explanation such as "The test failed". Comments should also be used for
  any English text that you may add. This file already contains many
  comments, so you can see what the syntax is.

- when done, save your file and submit it as hw08.lisp

- do not submit the session file (which shows your interaction with the
  theorem prover). This is not part of your solution. Only submit the lisp
  file.

Instructions for programming problems:

For each function definition, you must provide both contracts and a body.
You may define helper functions. For such functions, you must provide 
contracts and tests the same as any other function.

In this assignment, all definitions must satisfy their contracts
and terminate, but we will use commands that do not require ACL2s
to prove that your functions are admissible, so check.

As in hw05, you will be programming some functions.  If one or more check=
tests are provided, then you must add more check= or test? tests.  Your 
check=/ test? tests are in addition to the check= tests provided.  Make 
sure you produce sufficiently many new test cases.  This means: 
cover at least the possible scenarios according to the data definitions 
of the involved types. For example, a function taking two lists should 
have at least 4 additional check= tests: all combinations of each list 
being empty and non-empty. Each datatype should have at least 2 additional 
tests.

Beyond that, the number of tests should reflect the difficulty of the
function. For very simple ones, the above coverage of the data definition
cases may be sufficient. For complex functions with numerical output, you
want to test whether it produces the correct output on a reasonable
number of inputs.

If the function asks for a test? or a thm, then follow the instructions
for that function.  If ACL2s fails to prove a thm form, but you think that 
it is actually valid, you can replace the thm with a test? and add a comment
explaining what you did.

IMPORTANT NOTICE ABOUT YOUR TEST CASES

It is a violation of academic integrity to publish or discuss your test
cases.  These are part of the solution to your assignment.  Copying or
allowing one to copy your test cases is therefore unacceptable.  Please
be careful to prevent your solutions from being seen by other students.

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Admissible or not?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

This problem set is about the "Definitional Principle".

For each of the definitions below, check whether it is admissible, i.e. it
satisfies all rules of the definitional principle. You can assume that Rule
1 is met: the symbol used in the defunc is a new function symbol in each
case.

If you claim admissibility,

1. Explain in English why the body contracts hold.
2. Explain in English why the contract theorem holds.
3. Suggest a measure function that can be used to show termination.
   (You DO NOT have to prove the measure function properties in this problem.)

Otherwise, identify a rule in the Definitional Principle that is violated.

If you blame one of the purely syntactic rules (variable names,
non-wellformed body etc), explain the violation in English.

If you blame one of the semantic rules (body contract, contract theorem or
termination), you must provide an input that satisfies the input contract, but
causes a violation in the body or violates the output contract or causes
non-termination.

Remember that the rules are not independent: if you claim the function does
not terminate, you must provide an input on which the function runs forever
*without* causing a body contract violation: a body contract violation is
not a counterexample to termination. Similarly, if you claim the function
fails the contract theorem, you must provide an input on which it
terminates and produces a value, which then violates the output contract.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

1.

(defunc f (x)
  :input-contract (posp x)
  :output-contract (integerp (f x))
  (if (equal x 1)
    9
    (- 10 (f (- x 1) 1) )))

Non-wellformed body
The function body calls  (f (- x 1) 1) which doesn't work because the function
f only takes in one perameter. 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

2.

(defunc f (x)
  :input-contract (posp x)
  :output-contract (posp (f x))
  (if (equal x 1)
    9
    (f (+ 10 (f (- x 1))))))

Non-termination.
(f x) where x is a positive number. 
This function doesn't terminate because it calls (f (+ 10 (f ...))).
We know that the innermost function call of f should return a posp (by the 
output-contracts of f) and adding a pos to the number 10 would increase the
value of the peramater. So each recersive call will increase x to infinity
instead of decreasing it to the base case of x = 1.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

3.

(defunc f (x)
  :input-contract (posp x)
  :output-contract (integerp (f x))
  (if (equal x 1)
    9
    (- 10 (f (- x 2)))))

Body-contract violation:
(f 2)
The function tries to call (f (- x 2)) but if x = 2 then it will try to call
(f 0) which is an input-contract violation (x must be a posp). 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

4.

(defunc f (x)
  :input-contract (integerp x)
  :output-contract (integerp (f x))
  (if (equal x 1)
    9
    (- 10 (f (- x 1)))))

Non-termination:
(f 0)
The function reversivly calls itself with the perameter (- x 1) decreasing x 
at each steep. But because the input-contract asks for an integerp there is 
no natural ending point or basecase for this function. Using  0 or negative 
number as the initial condition will result in non termination. 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

5.

(defunc f (x y)
  :input-contract (and (posp x) (posp y))
  :output-contract (integerp (f x y))
  (cond ((< x 1)     (f x y))
        ((equal x 1) 10)
        (t           (* 10 (f (- x 1) y)))))

1) All the body contracts hold:
(< x 1) x is a pos number.
(f x y) x and y are both pos numbers.
(equal x 1) x and 1 are both any (input-contract for equal is true).
(* 10 (f (- x 1) y)) 10 is a number and (f (- x 1) y) returns an interger
(f (- x 1) y) y is a posp. The only time (- x 1) would result in a non pos 
            number is if (equal x 1) but this base case is covered in the 
            cond brance above.
(- x 1) x and 1 are both numbers.

2) y never gets used in the function of f so we can ignore it. The first cond
branch will never be used because x must be a posp so we can ignore it. The 
second cond branch is our base case and returns an interger (10). The last
cond branch multiplies 10 by the recursive call, which will output an integer.
An integer times an integer equals an integer. 

3) 
(defunc measure (x y)
  :input-contract (and (posp x) (posp y))
  :output-contract (natp (measure x y))
  x)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

6.

(defunc f (x y)
  :input-contract (and (listp x) (posp y))
  :output-contract (listp (f x y))
  (cond ((equal y 1) nil)
        ((endp x)    (list y))
        (t           (f (cons (+ y 1) x) (- y 1)))))

1) All body contracts hold:
(equal y 1) y and 1 are both anything (ic for equal is true).
(endp x) x is a listp.
(list y) y is an any.
(+ y 1) y and 1 are both numbers.
(cons (+ y 1) x) (+ y 1) and x are both any (ic of cons is true). In this case 
                 This function also just so happens to be a list because x is a 
                 list.
(- y 1) y and 1 are both numbers.
(f (cons (+ y 1) x) (- y 1))
             (cons (+ y 1) x) is a list and (- y 1) is a number.

2) In this function we have 2 possible base cases: (equal y 1) or (endp x). 
Both of these are covered in the first and second cond branch respectivly, each
returning a list. The recursive steep increases the lenght of the list by 1 
(when it calls (cons (+ y 1) x)) but this is ok because y decreases getting 
closer to the first of the two base cases described above. 

3)
(defunc measure (x y)
  :input-contract (and (listp x) (posp y))
  :output-contract (natp (measure x y))
  y)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

7.

(defunc f (x y)
  :input-contract (and (listp x) (posp y))
  :output-contract (listp (f x y))
  (if (equal y 1)
    nil
    (f (list (first x)) (- y 1))))

Body contract violations:
x is a listp, so it can either be a (cons any list) or nil. If x is nil, the
function (first x) will break because nil doesn't have a first. 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

8.

(defunc f (x y)
  :input-contract (and (listp x) (posp y))
  :output-contract (posp (f x y))
  (if (endp x)
    y
    (+ 1 (f (rest x) y))))

1) All body contracts hold:
(endp x) x is an any.
(rest x) x is a list and at this point we know that it is not empty.
(f (rest x) y) y is a posp and (rest x) is a list.
(+ 1 (f (rest x) y)) 1 is a number and (f (rest x) y) returns a posp.
(if (endp x) y (+ 1 (f (rst x y))))
        (endp x) returns a boolean.
        
2) 
This function has the base case of (endp x). The recursive call (f (rest x) y)
makes x smaller because of the (rest x) call. 

3)
(defunc measure (x y)
  :input-contract (and (listp x) (posp y))
  :output-contract (posp (measure x y))
  (lenght x))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

9.

(defunc f (l)
  :input-contract (listp l)
  :output-contract (listp (f l))
  (if (endp l)
    nil
    (f (rest f))))


Non-wellformed body:
The function tries to call the variable f whih is undefined.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

10.

(defunc f (n x n)
  :input-contract (and (posp n) (listp x) (posp n))
  :output-contract (posp (f n x n))
  (if (endp x)
    0
    (f n (rest x) n)))

Non-wellformed body:
The function tries to define three distinct veriables but only uses two distinct
symbols (x and n)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

11.

(defunc f (x y)
  :input-contract (and (listp x) (listp y))
  :output-contract (posp (f x y))
  (if (endp x)
    0
    (f (rest x) y)))

1) All body-contracts hold:
(endp x) x is a list.
(rest x) x is a list and we know that it's not empty at this point.
(f (rest x) y) y is a list and (rest x) is also a list.
(if (endp x) ... ...) 
         (endp x) returns a boolean.

2) This function has the base case of (endp x). Otherwise, it will recur itself
and the call (rest x) causes the length of x to decrease to eventually 0.

3)
(defunc measure (x y)
  :input-contract (and (listp x) (listp y))
  :output-contract (natp (measure x y))
  (length x))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

12.

(defunc f (x g)
  :input-contract (and (listp x) (posp g))
  :output-contract (posp (f x g))
  (if (endp x)
    0
    (g (rest x) (+ g 1))))

Non-wellformed body
The function attempts to call a function (g ...) but that function has never
been defined. 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

13.

(defunc f (x y)
  :input-contract (and (integerp x) (integerp y))
  :output-contract (integerp (f x y))
  (if (equal x 0)
    0
    (+ (* 2 y) (f (+ x 1) y))))

Non-terminating:
(f 1 0)
In the body we call the function (f (+ x 1) y) which increases the value of x 
instead of decreasing it towards our base case of (equal x 0).

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

14.

(defunc f (x n)
  :input-contract (and (listp x) (posp n))
  :output-contract (listp (f x n))
  (if (equal n 0)
    (list n)
    (f (cons (rest x) (first x)) (- n 1))))

Non-wellformed body:
We try to call (rest x), but x is a list. It could be nil. In this case it would
result an inputcontract violation on the rest function.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

15.

(defunc f (a b)
  :input-contract  (and (posp a) (posp b))
  :output-contract (posp (f a b))
  (cond ((equal a b)                   1)
        ((> a b)                       (f b a))
        (t                             (f a (- b a)))))
        
1) All body-contracts hold:
(equal a b) a and b are both any (equal has an input contract of true).
(> a b) a and b are both numbers.
(f b a) b and a are both posp.
(- b a) b and a are both numbers.
(f a (- b a)) a and (- b a) are both posp (because by this point we know that
              b > a)
              
2) This program basically recursivly subtracts the smaller number from the biger
one. One of three things will happen in this case: the new b value will either 
be smaller than a, equal to a or bigger than a. If they are equal the function 
terminates. If b is smaller, then they switch positions so the smaller becomes
a and the lager becomes b. In the last case we subtract a from b to make b even 
smaller and recur. These steeps will repeat untill (equal a b). 
We know this case will eventuall be met because we know the function will only
produce a posp (because we subtract the small from the big) so even in the worst
case we will eventually get the smallest number to equal 1. From there we're
simply chipping away at the bigger number untill we get to 1 again. 

3)
(defucn measure (a b)
  :input-contract (and (posp a) (posp b))
  :output-contract (posp (measure a b))
  (+ a b))

^^^ this doesnt work because in the case where (> a b) the sum of the values
actually doesn't change. The second conditional branch mearly sets up the third
change the values. 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

16.

(defunc f (a b)
  :input-contract  (and (posp a) (posp b))
  :output-contract (posp (f a b))
  (cond ((and (equal a 1) (equal b 1)) 1)
        ((> a b)                       (f a (- b 1)))
        (t                             (f b a))))

Body-Contract violations:
In the second conditional branch (> a b) we subtract one from b. But b is the
smaller one in this case! So eventually b will be subtracted down to 0 and a
will always stay the bigger value. 
(f 2 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

17.

(defunc f (x)
  :input-contract (listp x)
  :output-contract (natp (f x))
  (cond ((endp y)  0)
        (t         (f (len x)))))

Non wellformed function:
The function never defined the variable y.

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; TERMINATION ARGUMENTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

For the following problems, whenever you are asked to prove termination of
some function f, provide a measure function m such that

Condition 1. m has the same arguments and the same input contract as f.
Condition 2. m's output contract is (natp (m ...))
Condition 3. m is admissible.
Condition 4. On every recursive call of f, given the input contract and 
   the conditions that lead to that call, m applied to the arguments in
   the call is less than m applied to the original inputs.

You should do this proof as shown in class (which is also the way we will
expect you to prove termination in exams):

- Write down the propositional logic formalization of the condition 4.
- Simplify the formula,
- Use equational reasoning to conclude the formula is valid.

Unless clearly stated otherwise, you need to follow these steps for EACH
recursive call separately.

Here is an example.

(defunc f (x y)
  :input-contract (and (listp x) (natp y))
  :output-contract (natp (f x y))
  (if (endp x)
    (cond ((equal y 0) 0)
          (t           (+ 1 (f x (- y 1)))))
    (+ 1 (f (rest x) y))))

The measure is

(defunc m (x y)
  :input-contract (and (listp x) (natp y))
  :output-contract (natp (m x y))
  (+ (len x) y))

Proof of Condition 4 for the first recursive call:

C1. (natlistp x)
C2. (natp y)
C3. (endp x)
C4. y > 0

(m x y-1)
= { Def m, C3, Arithmetic }
y-1
< { Arithmetic }
y
= { Def m, C3, Arithmetic }
(m x y)

QED

Proof of Condition 4 for the second recursive call:

C1. (natlistp x)
C2. (natp y)
C3. (not (endp x))

(m (rest x) y)
= { Def m, C3, length theorem for rest }
length(x) - 1 + y
< { Arithmetic }
length(x) + y
= { Def m }
(m x y)

QED

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

18. Prove termination for the following function:

(defdata natlist (listof nat))

(defunc f (x y)
  :input-contract (and (natlistp x) (natp y))
  :output-contract (natp (f x y))
  (if (endp x)
    (cond ((equal y 0) 0)
          (t           (+ 1 (f x (- y 1)))))
    (+ (first x) 
       (f (rest x) (+ 1 y)))))

    
'(a b c d)  2  => 10    
'(b c d)  3 => 9
'(c d) 4 => 8
'(d) 5 => 7
'() 6 => 6
'() 5 => 5
    
(defunc m (x y)
  :input-contract (and (natlistp x) (natp y))
  :output-contract (natp (m x y))
  (+ (* 2 (len x)) y))

C1) (natlistp x)
C2) (natp y)
C3) (endp x)
C4) (not (equal y 0))


(m x y-1)
= { Def m, C3, Arithmetic }
y-1
< { Arithmetic }
y
= { Def m, C3, Arithmetic }
(m x y)

QED

C1) (natlistp x)
C2) (natp y)
C3) (consp x)

(m (rest x) (+ 1 y))
= { Def m, C1, C2 }
(+ (* 2 (len (rest x))) (+ 1 y)))

= { length theorem for rest }
(+ (* 2 (length(x) - 1)) (+ 1 y)))

= { Arithmetic }
(2*lenght x) - (2) + 1 + y
(2*length x) - 1 + y

< { Arithmetic }

(+ (* 2 (len x)) y))
(2*lenght x) + y)
= { Def m, C3, Arithmetic }
(m x y)

QED

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

19. Prove termination for the following function:

(defunc raster (x y pixel)
  :input-contract (and (natp x) (natp y) (integerp pixel))
  :output-contract (integerp (raster x y pixel))
  (cond ((and (equal x 0) (equal y 0)) pixel)
        ((> x 0)                       (raster (- x 1) y (+ pixel 1)))
        (t                             (raster 1024 (- y 1) (- pixel 1)))))


        
(defunc m (x y pixel)
  :input-contract (and (natp x) (natp y) (integerp pixel))
  :output-contract (natp (m x y pixel))
 (+ x (* 1025 y)))

 
 
 C1) (natp x)
 C2) (natp y) 
 C3) (integerp pixel)
 C4) (> x 0)
 
 (m (- x 1) y (+ pixel 1))
 = { def m }
 (+ (x - 1) (* 1025 y))
 
 < { Arithmetic }
 
 (+ x (* 1025 y)
 = { def m }
 (m x y pixel)
 
 
 QED
 
 
 
 C1) (natp x)
 C2) (natp y) 
 C3) (integerp pixel)
 C4) (= x 0)
 
 (m 1024 (- y 1) (- pixel 1))
 = { def m }
 (+ 1024 (* 1025 (y - 1))
 (1024 + ( 1025 * ( y - 1)))
 
 = { Arithmetic }
 1024 + ((1025*y) - 1025)
 -1 + 1025*y
 
 < { Arithmetic }
 
 (1025 * y)
(+ 0 (* 1025 y))
 = { def m }
 (m x y pixel)
 
 QED
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

20. Prove termination for the following function:

(defunc g (p q)
  :input-contract (and (posp p) (posp q))
  :output-contract (posp (g p q))
  (cond ((> p q)     (g (- p q) q))
        ((< p q)     (g p (- q p)))
        (t           (+ p (* 1024 q)))))

        
        
(defunc m (p q)
  :input-contract (and (posp p) (posp q))
  :output-contract (natp (m p q))
  (+ p q))

C1) (posp p)
C2) (posp q)
C3) (> p q)

(m (- p q) q)
= { def m }
(+ (- p q) q)
((p - q) + q)
= { Arithmetic }
p

< { C2, Arithmetic }

(+ p q)
= { def m }
(m p q)

QED




C1) (posp p)
C2) (posp q)
C3) (< p q)

(m p (- q p))
= { def m }
(+ p (- q p))
(p + (q - p))
= { Arithmetic }
q

< { C1, Arithmetic }

(+ p q)
= { def m }
(m p q)

QED

  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

21. Prove termination for the following function:

(defunc q (r s)
  :input-contract (and (natlistp r) (natlistp s))
  :output-contract (natlistp (q r s))
  (cond ((endp r)   s)
        ((endp s)   (q nil (rest r)))
        (t          (q (rest r) (cons (first r) s)))))

        
        
        
(defunc m (r s)
  :input-contract (and (natlistp r) (natlistp s))
  :output-contract (natp (m r s))
  (len r))

  
C1) (natlistp r)
C2) (natlistp s)
C3) (not (endp r))
C4) (endp s)

(m nil (rest r))
= { def m }
(len nil)

= { def len }
0

< { C3 }

(len r)
= { def m }
(m r s)

QED


C1) (natlistp r)
C2) (natlistp s)
C3) (not (endp r))
C4) (not (endp s))

(m (rest r) (cons (first r) s))
= { def m }
(len (rest r))

= { length theorem for rest }
(len r) - 1

< { Arithmetic }

(len r)
= { def m }
(m r s)


QED
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

22. Prove termination for the following function:

(defunc f (x y)
  :input-contract (and (listp x) (integerp y))
  :output-contract (natp (f x y))
  (cond ((and (endp x) (< y 0))     (+ 1 (f x (+ 1 y))))
        ((and (endp x) (equal y 0)) (+ 1 (len x)))
        ((endp x)                   (+ 1 (f x (- y 1))))
        (t                          (+ 1 (f (rest x) (- 0 y))))))

        
        
(defunc m (x y)
  :input-contract (and (listp x) (integerp y))
  :output-contract (natp (f x y))
  (+ (len x) 
     (if (> y 0)
         y
         (* -1 y))))



C1) (listp x) 
C2) (integerp y)
C3) (endp x) 
C4) (< y 0)

(m x (+ 1 y))
= { def m, C4, if axiom }
(+ (len x) ((* -1 (+ 1 y)))
(len x) + |y + 1|

< { C4, Arithemitic }

(len x + |y|
(+ (len x) (* -1 y))
= { def m, if axiom, C4 }
(m x y)

QED




C1) (listp x) 
C2) (integerp y)
C3) (endp x) 
C4) (not (equal y 0))
C5) (not (< y 0))

(m x (- y 1))
= { def m, C4, C5, if axiom }
(+ (len x) (- y 1))
(len x) + |y - 1|

< { C5, Arithemitic }

(len x + |y|
(+ (len x) y)
= { def m, if axiom, C5 }
(m x y)

QED




Theorem 1:
C1) (listp x) 
C2) (integerp y)
C3) (not (endp x))
C4) (<= y 0)

(m (rest x) (- 0 y))
= { def m, C4, Arithmetic }
(+ (len (rest x)) (- 0 y))
(len (rest x)) + y

= { length theorem for rest }
(len x) - 1 + y

< { Arithemtic }

(len x) + y
(+ (len x) (* -1 y))
= { def m , C4}
(m x y)



Theorem 2:
C1) (listp x) 
C2) (integerp y)
C3) (not (endp x))
C4) (> y 0)

(m (rest x) (- 0 y))
= { def m, C4, Arithmetic }
(+ (len (rest x)) (* - 1 (- 0 y)))
(len (rest x)) + y

= { length theorem for rest }
(len x) - 1 + y

< { Arithemtic }

(len x) + y
(+ (len x) y)
= { def m , C4}
(m x y)



C1) (listp x) 
C2) (integerp y)
C3) (not (endp x))

T1 and T2 show that for any value of y, the measure function decreases. 
Therefore the folowing inequality is true:

(m (rest x) (- 0 y))
= { T1, T2 }
<
(m x y)

QED

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; A TERMINATION TESTER
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

The subject of this exercise is to study the problem of designing a
function that automatically checks whether another (recursively defined)
function terminates.

But wait -- we already know this problem is undecidable! That means there
is no ACL2s function that always determines correctly whether some given
other function f terminates.

We will therefore only solve a simple version of this problem: our function
will determine whether a given function f terminates in a predetermined
number of "steps". We will see shortly what "steps" means.

Define a function f that takes a positive natural number and is defined
mathematically as follows:

          /
          | 1              if n is 1
          |
f(m,n) = <  f(m,n/m)       if n is divisible by m
          |
          | f(m,n+(n+p)/m) if n is greater than 1 and not divisible by m
          \                and p is the smallest positive integer
                           such that n+p is divisible by m

Here is how to read that notation: first observe that the three cases on
the right are mutually exclusive, i.e. every positive natural number fits
into exactly one case. Given n, determine which case it fits in. The
expression associated with that case determines f(m,n).

Define this function in ACL2s, in :program mode. Recall that (posp n)
recognizes positive natural numbers.

|#

(set-defunc-termination-strictp nil)
(set-defunc-function-contract-strictp nil)
(set-defunc-body-contracts-strictp nil)


; findq: Pos x Pos x Pos -> Nat
; Finds q, which is defined as q >= p and n+q is divisible by m.
(defunc findq (n m p)
  :input-contract (and (posp n) (posp m) (posp p))
  :output-contract (natp (findq n m p))
  (if (integerp (/ (+ n p) m))
    p
    (findq n m (+ 1 p))))

(check= (findq 1 4 1) 3)
(check= (findq 5 8 13) 19)
(check= (findq 3 8 2) 5)


; Define:
; divide-evenly: Pos x Pos x Pos -> Nat
; (divide-evenly n m p) is (n+q)/m where q is the smallest positive
; integer such that q >= p and n+q is divisible by m.
; If p equals 1 then this function simply divides n/m and rounds up.
(defunc divide-evenly (n m p)
  :input-contract (and (posp n) (posp m) (posp p))
  :output-contract (natp (divide-evenly n m p))
  (let* ((q (findq n m p)))
        (/ (+ n q) m)))

(check= (divide-evenly 11 2 1) 6)
(check= (divide-evenly 3 8 2) 1)
(check= (divide-evenly 6 21 22) 2)
(check= (divide-evenly 48 10 1) 5)

(defunc f (m n)
  :input-contract (and (posp m) (posp n))
  :output-contract (posp (f m n))
  (cond ((equal n 1)        1)
        ((integerp (/ n m)) (f m (/ n m)))
        (t                  (f m (+ n (divide-evenly n m 1))))))
(check= (f 1 1) 1)
(check= (f 10 1) 1)
(check= (f 10 10) 1)
(check= (f 11 10) 1)
(check= (f 20 10) 1)
(check= (f 16 1) 1)
;(check= (f 3 10) ...)
(check= (f 3 12) 1)
(check= (f 3 13) 1)


; What does this function return, if anything?
; If the function terminates then it returns 1, otherwise it has a stack overflow.

; For m=2, it seems it always returns 1 

; Write at least 3 additional check= tests that (should) confirm 
; this conjecture for m=2:

(check= (f 2 8) 1)
(check= (f 2 7) 1)
(check= (f 2 1) 1)
(check= (f 2 2) 1)
(check= (f 5 7) 1)
(check= (f 2 10) 1)

; For m=3, the function will not terminate in general.
; If you try this, it may cause a stack overflow.
; We now discuss how one can deal with this.

#|

You can think of this function as generating a sequence of positive natural
numbers, namely the numbers that f is called on recursively. For example:

f(2,8) = f(2,4) = f(2,2) = f(2,1) = 1

To get a feel for f, write down the call sequences for the following
initial arguments, until the recursion ends:

f(2,10) = f(2,5) = f(2,8) = f(2,4) = f(2,2) = f(2,1) = 1
f(2,7) = f(2,11) = f(2,17) = f(2,26) = f(2,13) = f(2,20) = f(2,10) =
  f(2,5) = f(2,8) = f(2,4) = f(2,2) = f(2,1) = 1

Hint: try out (acl2::trace! f)

The reason we have defined this function in :program mode is that it
does not terminate in general.  Even for the special case of m=2, it
is not known whether it will terminate.

We would like to study this function for different values of m to see
which ones appear to terminate and which ones do not appear to terminate.

2. Modify f into a function g that takes not only m and n but also two
other arguments, count and limit, which are natural numbers such that
the count argument is no larger than the limit argument.  The idea is
that if the number of calls to g exceeds the limit, then we stop
recursively computing g and return the symbol '?. Like the argument m,
the argument limit is a constant: it is not changed in recursive
calls. The count argument is the number of recursive calls to g that
were performed when g was called.

|#

; Define
; g: Pos x Pos x Nat x Nat -> Pos union {'?}

(defunc g (m n count limit)
  :input-contract (and (posp m) (posp n) (natp count) (natp limit))
  :output-contract (or (equal '? (g m n count limit))
                       (posp (g m n count limit)))
  (if (> count limit)
    '?
    (cond ((equal n 1)        1)
          ((integerp (/ n m)) (g m (/ n m) (+ count 1) limit))
          (t                  (g m (+ n (divide-evenly n m 1))
                                   (+ count 1) limit)))))

(check= (g 2 16 0 2) '?)
(check= (g 2 16 0 3) '?)
(check= (g 2 16 0 4)  1)
(check= (g 3 10 0 1000) '?)
(check= (g 2 8 0 5) 1)
(check= (g 2 184 0 10000) 1)

; Write at least 3 more tests for m=2:


#|

3. Define a function f-terminates that takes three arguments: positive
natural numbers m, n and natural number limit, and checks whether
(f m n) returns after at most limit recursive calls.
Note that f-terminates returns a Boolean.
Obviously, in the body of f-terminates use g instead of f.

|#

; Define:
; f-terminates: Pos x Pos x Nat -> Boolean

(defunc f-terminates (m n limit)
  :input-contract (and (posp m) (posp n) (natp limit))
  :output-contract (booleanp (f-terminates m n limit))
  (equal 1 (g m n 0 limit)))

(check= (f-terminates 2 8 2) nil)
(check= (f-terminates 2 8 3) t)
(check= (f-terminates 2 8 4) t)
(check= (f-terminates 3 7 999) nil)
(check= (f-terminates 2 8129 9999999) t)
(check= (f-terminates 3 42345 9999) nil)

; Write at least 3 more check= tests for m=2:

; Now use test? to determine the behavior for m=2 with a high limit:

(test? (implies (posp n) (f-terminates 2 n 99999999)))

; Try at least 5 other values of m.
;(test? (implies (posp n) (not (f-terminates 3 n 99999999))))
(test? (implies (posp n) (f-terminates 5 n 99999999)))
(test? (implies (posp n) (f-terminates 7 n 99999999)))
(test? (implies (posp n) (f-terminates 8 n 99999999)))
(test? (implies (posp n) (f-terminates 12 n 99999999)))
(test? (implies (posp n) (f-terminates 13 n 99999999)))

#|

4. Find the number *limit* of recursive calls that it takes for f to
terminate on input

(f 13 940142)

That is, the following two tests must pass with your number *limit*,
which you should enter in place of the ... below:

|#
(defunc howManyRecur (m n count limit)
  :input-contract (and (posp m) (posp n) (natp count) (natp limit))
  :output-contract (or (equal '? (howManyRecur m n count limit))
                       (posp (howManyRecur m n count limit)))
  (if (> count limit)
    '?
    (cond ((equal n 1)        count)
          ((integerp (/ n m)) (howManyRecur m (/ n m) (+ count 1) limit))
          (t                  (howManyRecur m (+ n (divide-evenly n m 1))
                                   (+ count 1) limit)))))
(check= (howManyRecur 2 8 0 10) 3)
(check= (howManyRecur 3 142 0 9999) '?)
(check= (howManyRecur 4 17 0 10) 8)




(defconst *limit* (howManyRecur 13 940142 0 9999999999999999999999))

(check= (f-terminates 13 940142 (- *limit* 1)) nil)
(check= (f-terminates 13 940142 *limit*) t)

#|

Hint: to determine *limit*, consider the trace mechanism mentioned above,
or binary search for the optimal parameters to f-terminates.

5. The function f-terminates shows how one can modify a function so that
one can test it even though the original function f does not
terminate. How would you modify a function that has several recursive
calls, like fib shown below, in a manner analogous to what we did to f,
with arguments count and limit, such that evaluation is aborted when
count reaches limit?

(defunc fib (n)
  :input-contract (natp n)
  :output-contract (natp (fib n))
  (if (<= n 1)
    1
    (+ (fib (- n 1)) (fib (- n 2)))))

Explain in plain English. You don't need to write function code.

I would have to add two more input paramaters to the function count and limit
such that (and (natp count) (natp limit)). I would add 1 to count each time I
recurred and leave limit exactly as it is. Once count > limit I would kill the
stack or abort the function calls and return a '?.



We need to add the recursive call counts across all recursive calls
that contribute towards evaluating (fib n).


|#

