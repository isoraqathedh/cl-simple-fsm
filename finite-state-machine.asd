;;;; finite-state-machine.asd

(asdf:defsystem #:finite-state-machine
  :description "An intuitive implementation of a finite state machine."
  :author "Isoraķatheð Zorethan <isoraqathedh.zorethan@gmail.com>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :components ((:file "package")
               (:file "finite-state-machine")))
