;;; ipl-mode.el --- Emacs mode for Imandra Protocol Language
;;
;; Copyright (c) 2020 Imandra, Inc.
;;
;; Author: Matt Bray <matt@imandra.ai>
;; URL: https://github.com/aestheticintegration/ipl-spacemacs-layer
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst ipl-keywords
  '("None"
    "Some"
    "TimeStampPrecisions"
    "VerificationPacks"
    "abs"
    "action"
    "add"
    "alias"
    "anonymous"
    "assignFrom"
    "assignable"
    "break"
    "case"
    "dataset"
    "datatype"
    "declare"
    "default"
    "delete"
    "description"
    "else"
    "enum"
    "events"
    "extend"
    "false"
    "for"
    "forall"
    "function"
    "get"
    "getDefault"
    "if"
    "ign"
    "ignore"
    "imandramarkets"
    "import"
    "in"
    "insert"
    "intOfString"
    "interLibraryCheck"
    "internal"
    "invalid"
    "invalidfield"
    "let"
    "library"
    "libraryMarker"
    "list"
    "map"
    "mapAdd"
    "message"
    "micro"
    "milli"
    "missingfield"
    "name"
    "opt"
    "option"
    "optional"
    "outbound"
    "overloadFunction"
    "overrideFieldTypes"
    "precision"
    "present"
    "receive"
    "record"
    "reject"
    "remove"
    "repeating"
    "repeatingGroup"
    "req"
    "require"
    "return"
    "scenario"
    "send"
    "service"
    "set"
    "strLen"
    "subset"
    "testfile"
    "then"
    "toFloat"
    "toInt"
    "true"
    "truncate"
    "unique"
    "valid"
    "validate"
    "when"
    "with"
    ))


(define-derived-mode ipl-mode
  text-mode "IPL"
  "Major mode for Imandra Protocol Language."
  (progn
    (setq comment-start "//")
    (setq comment-start-skip "//\\s *")
    (setq ipl-highlights
          `(("//.+" . font-lock-comment-face)
            (,(regexp-opt ipl-keywords 'words) . font-lock-keyword-face)))
    (setq font-lock-defaults '(ipl-highlights))))

(provide 'ipl-mode)
