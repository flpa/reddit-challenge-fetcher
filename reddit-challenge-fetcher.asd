;;;; reddit-challenge-fetcher.asd

(asdf:defsystem #:reddit-challenge-fetcher
  :serial t
  :description "Describe reddit-challenge-fetcher here"
  :author "Florian Patzl"
  :license "GPLv3"
  :depends-on (#:cl-reddit
               #:quickproject)
  :components ((:file "package")
               (:file "reddit-challenge-fetcher")))

