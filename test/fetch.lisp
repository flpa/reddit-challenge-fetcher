(in-package :cl-user)
(defpackage #:reddit-challenge-fetcher.fetch.test
  (:use :cl 
        #:reddit-challenge-fetcher.fetch
        #:5am))

(in-package #:reddit-challenge-fetcher.fetch.test)

(test split-title
      (multiple-value-bind (date number category name) 
        (reddit-challenge-fetcher.fetch::split-title 
          "[2015-02-13] Challenge #201 [Hard] Mission Improbable")
        (is (equal "2015-02-13" date))
        (is (equal "201" number))
        (is (equal "Hard" category))
        (is (equal "Mission Improbable" name))))
