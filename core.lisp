(defpackage #:reddit-challenge-fetcher.core
  (:use #:cl)) 

(in-package #:reddit-challenge-fetcher.core)

(defvar *solutions-directory* "~/code/misc/reddit-daily/")

(defstruct challenge "Basic structure specifying a challenge."
  name
  number
  difficulty ;;enum via init arg checking? actually, there also others: All, Practical Exercise ... Raise condition to be handled with restart?
  description)
