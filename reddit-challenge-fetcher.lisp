;;;; reddit-challenge-fetcher.lisp

(in-package #:reddit-challenge-fetcher)

(defvar *solutions-directory* "~/code/misc/reddit-daily/")

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

(defstruct challenge "Basic structure specifying a challenge."
  name
  number
  difficulty ;;enum via init arg checking? actually, there also others: All, Practical Exercise ... Raise condition to be handled with restart?
  description
  )



