(in-package :cl-user)

(defpackage #:reddit-challenge-fetcher.fetch
  (:use #:cl
        #:cl-reddit
        #:cl-ppcre))

(in-package #:reddit-challenge-fetcher.fetch)

(defparameter *sample-challenge* (first (get-subreddit-new "dailyprogrammer")))

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
                        ("^\\[(\\d{4}-\\d{2}-\\d{2})\\] Challenge #(\\d+)" title)
                        (values date number))
  )

;; TODO: override user agent?

