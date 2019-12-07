;;;; package.lisp

(defpackage #:info.isoraqathedh.finite-state-machine
  (:use #:cl)
  (:export #:finite-state-machine
           #:state #:statep #:acceptingp

           #:next-state #:next-state!
           #:previous-state #:previous-state!))
