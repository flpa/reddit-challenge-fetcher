(defpackage #:reddit-challenge-fetcher.fetch
  (:use #:cl
        #:cl-reddit) 

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
  title)

;; TODO: override user agent?

