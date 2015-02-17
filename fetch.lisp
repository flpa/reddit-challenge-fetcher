(in-package :cl-user)

(defpackage #:reddit-challenge-fetcher.fetch
  (:use #:cl
        #:cl-reddit
        #:cl-ppcre
        #:quickproject
        #:5am))

(in-package #:reddit-challenge-fetcher.fetch)

(defparameter *subreddit* "dailyprogrammer" 
  "The name of the DailyProgrammer subreddit.")

(defparameter *sample-challenge* (first (get-subreddit-new *subreddit*))
  "Challenge LINK object for test purposes.")

(defparameter *date-regex* "\\[([^\\]]+)\\]"
  ;;TODO: better solution only allowing digits
  "Regular expression for parsing the date portion of a challenge title, i.e.
   the date enclossed in brackets.")

(test date-regex
  ;;TODO: general workaround for group matching
  (flet ((dotest (input output)
           (if (scan *date-regex* input)
             (register-groups-bind (date) (*date-regex* input)
               (is (equal output date)))
             (fail (format nil "~a does not even match the regex!" input)))))
    (dotest "[2014-02-12]" "2014-02-12") ; new pattern
    (dotest "[10/31/2014]" "10/31/2014") ; old twodigit month 
    (dotest "[05/31/2014]" "05/31/2014") ; old twodigit singledigit month 
    (dotest "[7/7/2014]" "7/7/2014"))) ; old singledigit month 

(defparameter *number-regex* " Challenge #(\\d+)"
  "Regular expression for parsing the number of a challenge in a string like
   ' Challenge #200'.")
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

(defparameter *name-regex* " (.*)")
(test name-regex
  (register-groups-bind (name) (*name-regex* " Fun")
    (is (equal "Fun" name)))
  (register-groups-bind (name) (*name-regex* 
                                 " This will be [another] really great one!")
    (is (equal "This will be [another] really great one!" name))))

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
  (register-groups-bind (date number category name)
                        ((concatenate 'string 
                                      "^" 
                                      *date-regex* 
                                      *number-regex* 
                                      *category-regex* 
                                      *name-regex* 
                                      "$") 
                         title)
                        (values date number category name)))

;; TODO: override user agent?

;; prompt for project name 

(defun escape-name (name)
  "Escapes the name of a challenge so that it can be used as a system, package
   and directory name.
   That is:
   - convert to lowercase
   - replace blanks by dashes"
  (regex-replace-all "\\s" (string-downcase name) "-"))

(test escape-name
  (is (equal "mission" (escape-name "Mission")))
  (is (equal "mission-improbable" (escape-name "Mission Improbable"))))

(defparameter *author* "flpa <flpa.dev@zoho.com>")
(defparameter *license* "Public Domain")

(defparameter *solution-directory* "/tmp/sols/")

(defun make-challenge-project (link)
  (multiple-value-bind (date number category name) 
    (split-title (link-title link))
    (let ((escaped-title (escape-name name)))
      (make-project (merge-pathnames *solution-directory* 
                                     (format nil "~d_~a" number escaped-title))
                    :name escaped-title))))
