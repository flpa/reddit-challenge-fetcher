(in-package :cl-user)

(defpackage #:reddit-challenge-fetcher.fetch
  (:use #:cl
        #:cl-reddit
        #:cl-ppcre
        #:5am))

(in-package #:reddit-challenge-fetcher.fetch)

(defparameter *sample-challenge* (first (get-subreddit-new "dailyprogrammer")))

;; regex: YYYY-MM-DD enclosed in brackets
(defparameter *date-regex* "\\[(\\d{4}-\\d{2}-\\d{2})\\]")
(test date-regex
  (register-groups-bind (date) (*date-regex* "[1234-34-12]")
    (is (equal "1234-34-12" date))))

(defparameter *number-regex* " Challenge #(\\d+)")
(test number-regex
  (register-groups-bind (number) (*number-regex* " Challenge #1")
    (is (equal "1" number))) 
  (register-groups-bind (number) (*number-regex* " Challenge #201")
    (is (equal "201" number))) 
  (register-groups-bind (number) (*number-regex* " Challenge #1001")
    (is (equal "1001" number))))

;; regex: space, bracket, everything except closing bracket, closing bracket
(defparameter *category-regex* " \\[([^\\]]+)\\]")
(test category-regex
  (register-groups-bind (category) (*category-regex* " [Easy]")
    (is (equal "Easy" category)))
  ;; wtf: register-groups-bind problem breaks test so it doesn't even report?
  (register-groups-bind (category) (*category-regex* " [Hard]")
    (is (equal "Hard" category))) 
  (register-groups-bind (category) (*category-regex* " [Practical Exercise]")
    (is (equal "Practical Exercise" category))))

(defun split-title (title)
  "Split the TITLE string of a challenge into the various components and
   returns them as multple values.
   The components are (in this order): 
   - Date (YYYY-MM-DD)
   - Number
   - Category (e.g. Easy)
   - Name"
  ;;todo: rename to extract-title-info
  ;;todo: another cl-ppcre method to directly return (not capture in local vars) ?
  ;;todo: extract year, month, day separately to combine them to a proper date?
  (register-groups-bind (date number)
                        ((concatenate 'string "^" *date-regex* *number-regex* *category-regex*) title)
                        (values date number))
  )

;; TODO: override user agent?

