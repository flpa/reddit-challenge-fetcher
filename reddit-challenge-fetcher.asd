(asdf:defsystem #:reddit-challenge-fetcher
  :serial t
  :description "Describe reddit-challenge-fetcher here"
  :author "Florian Patzl"
  :license "GPLv3"
  :depends-on (#:cl-reddit
               #:quickproject
	       #:cl-ppcre
	       #:fiveam);temporary
  :components ((:file "core")
               (:file "fetch")))

(asdf:defsystem #:reddit-challenge-fetcher/test
  :serial t
  :description "Describe reddit-challenge-fetcher here"
  :author "Florian Patzl"
  :license "GPLv3"
  :depends-on (#:reddit-challenge-fetcher
               #:fiveam)
  :components ((:file "test/core")
               (:file "test/fetch")))
