;;;; finite-state-machine.lisp

(in-package #:info.isoraqathedh.finite-state-machine)

(defclass finite-state-machine ()
  ((all-states :accessor states-of
               :initarg :states
               :initform ())
   (accepting-states :accessor accepting-states
                     :initarg :accepting-states
                     :initform ())
   (state-history :accessor state-history
                  :initform ())
   (state=-test :accessor state=-test
                :initarg :test
                :initform #'eql)))

;; (defgeneric add-state (state-machine state)
;;   (:documentation "Add the state STATE to STATE-MACHINE.")
;;   (:method ((fsm finite-state-machine) state)
;;     (pushnew state (states-of fsm) :test (state=-test fsm))))

;; (defgeneric delete-state (state-machine state)
;;   (:documentation "Delete STATE from STATE-MACHINE.

;; If your states are not comparable by default,
;; you can provide your own equality predicate using TEST.")
;;   (:method ((fsm finite-state-machine) state)
;;     (delete state (states-of fsm) :test (state=-test fsm))))

(defgeneric statep (state-machine possible-state)
  (:documentation "Check if a POSSIBLE-STATE is a state in STATE-MACHINE.")
  (:method ((fsm finite-state-machine) possible-state)
    (member possible-state (states-of fsm) :test (state=-test fsm))))

(defgeneric state (state-machine)
  (:documentation "Return the current state of the machine.")
  (:method ((fsm finite-state-machine))
    (car (state-history fsm))))

(defgeneric (setf state) (new-state state-machine)
  (:documentation "Set the new state of the state-machine.")
  (:method (new-state (state-machine finite-state-machine))
    (if (statep state-machine new-state)
        (push new-state (state-history state-machine))
        (error "Invalid state to transition to."))))

(defgeneric acceptingp (state-machine)
  (:documentation "Check if the STATE-MACHINE is in an accepting state.")
  (:method ((fsm finite-state-machine))
    (member (state fsm) (accepting-states fsm))))

(defgeneric next-state (state-machine event)
  (:documentation "Name the correct next state of STATE-MACHINE given event EVENT."))

(defgeneric next-state! (state-machine event)
  (:documentation "Move to the correct next state of STATE-MACHINE given event EVENT.")
  (:method ((state-machine finite-state-machine) event)
    (setf (state state-machine) (next-state state-machine event))))

(defgeneric previous-state (state-machine)
  (:documentation "Peek at the previous state.")
  (:method ((fsm finite-state-machine))
    (if (<= 1 (length (state-history fsm)))
        (second (state-history fsm))
        (error "No previous state to return to."))))

(defgeneric previous-state! (state-machine)
  (:documentation "Return the machine to a previous state.")
  (:method ((fsm finite-state-machine))
    (if (<= 1 (length (state-history fsm)))
        (pop (state-history fsm))
        (error "No previous state to return to."))))

(defmethod print-object ((object finite-state-machine) stream)
  (print-unreadable-object (object stream :type t :identity t)
    (format stream "@ ~s" (state object))))

(defmethod initialize-instance :after
    ((instance finite-state-machine)
     &key states
          (start-state nil start-state-supplied-p))
  (setf (state instance)
        (cond ((not start-state-supplied-p)
               (first states))
              ((statep instance start-state)
               start-state)
              ((null (states-of instance))
               (error "Must provide a list of states of the state machine."))
              (t
               (error "Must provide a valid starting state.")))))
