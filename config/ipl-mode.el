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

(defconst ipl-builtins-extra
  '("None"
    "Some"
    "add"
    "abs"
    "delete"
    "get"
    "getDefault"
    "insert"
    "intOfString"
    "mapAdd"
    "remove"
    "strLen"
    "subset"
    "toFloat"
    "toInt"
    "truncate"))

(defconst ipl-builtins
  '("false"
    "true"
    "||"
    "&&"
    "!"
    "="
    ">"
    "<"
    ";"))

(defconst ipl-keywords
  '(
    "TimeStampPrecisions"
    "VerificationPacks"
    "action"
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
    "description"
    "else"
    "enum"
    "events"
    "extend"
    "for"
    "forall"
    "function"
    "if"
    "ign"
    "ignore"
    "imandramarkets"
    "import"
    "in"
    "interLibraryCheck"
    "internal"
    "invalid"
    "invalidfield"
    "let"
    "library"
    "libraryMarker"
    "message"
    "messageFlows"
    "micro"
    "milli"
    "missingfield"
    "name"
    "opt"
    "optional"
    "outbound"
    "overloadFunction"
    "overrideFieldTypes"
    "precision"
    "present"
    "receive"
    "record"
    "reject"
    "repeating"
    "repeatingGroup"
    "req"
    "require"
    "return"
    "scenario"
    "send"
    "service"
    "template"
    "testfile"
    "then"
    "unique"
    "using"
    "valid"
    "validate"
    "when"
    "with"))

(define-derived-mode ipl-mode
  text-mode "IPL"
  "Major mode for Imandra Protocol Language."
  (progn
    (setq comment-start "//")
    (setq comment-start-skip "//\\s *")
    (setq ipl-highlights
          `(("//.+" . font-lock-comment-face)
            ("/\\*.+\\*/" . font-lock-comment-face)
            ("@+[A-Za-z.]+:?" . font-lock-preprocessor-face)
            ("function +\\([a-zA-Z0-9]+\\)" . ((1 font-lock-function-name-face)))
            ("\\(:\\) +\\([A-Za-z0-9. ]+\\)"
             . ((1 font-lock-builtin-face)
                ;; (2 font-lock-type-face)
                ;; conflicts with case syntax :/
                ;; we need to use a function to do this properly,
                ;; as emacs doesn't support look-behind
                ))
            ("\\(:[*?]\\) +\\([A-Za-z0-9. ]+\\)"
             . ((1 font-lock-builtin-face)
                (2 font-lock-type-face)
                ))
            ("\"[0-9]+\" +\\(:\\) +\\([A-Za-z0-9. ]+\\)"
             . ((1 font-lock-builtin-face)
                (2 font-lock-type-face)
                ))
            ("\"[^\"]+\"" . font-lock-string-face)
            ("[^A-Za-z0-9.]\\([A-Z][A-Za-z0-9.]+\\)\\." . ((1 font-lock-reference-face)))
            (,(regexp-opt ipl-keywords 'words) . font-lock-keyword-face)
            (,(regexp-opt ipl-builtins ) . font-lock-builtin-face)))
    (setq font-lock-defaults '(ipl-highlights))))

(provide 'ipl-mode)
