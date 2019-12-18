;;;; finite-state-machine.asd

(asdf:defsystem #:finite-state-machine
  :description "An intuitive implementation of a finite state machine."
  :author "Isoraķatheð Zorethan <isoraqathedh.zorethan@gmail.com>"
  :license  "MIT"
  :version "1.0.0"
  :serial t
  :components ((:file "package")
               (:file "finite-state-machine")))
