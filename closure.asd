;;; -*- Mode: Lisp; Syntax: Common-Lisp; Package: CL-USER; Encoding: utf-8; -*-

;; commit test
(defpackage :closure-system (:use #:asdf #:cl))
(in-package :closure-system)

;;; Random early Lisp Implementation-specific fix ups:

(eval-when (compile eval load)
  (pushnew :DEBUG-CLOSURE *features*))

;;;;
;;;; Optimization levels:
;;;;

;; FIXME: This is not exactly the right place!

;; We choose to make them constants for read-time evaluation, since we
;; want the presence of the :DEBUG-CLOSURE feature to override any
;; (saftey 0) declaration.

(defparameter +optimize-very-fast+
  '(optimize (safety #.(or #+:DEBUG-CLOSURE 3 0)) (speed 3) #+:DEBUG-CLOSURE (debug 3)))

(defparameter +optimize-very-fast-trusted+
  '(optimize (safety #.(or #+:DEBUG-CLOSURE 3 0)) (speed 3) #+:DEBUG-CLOSURE (debug 3)))

(defparameter +optimize-fast+
  '(optimize (safety #.(or #+:DEBUG-CLOSURE 3 1)) (speed 3) #+:DEBUG-CLOSURE (debug 3)))

(defparameter +optimize-normal+
  '(optimize (safety #.(or #+:DEBUG-CLOSURE 3 2)) (speed 1) #+:DEBUG-CLOSURE (debug 3)))

(export '+optimize-very-fast-trusted+)
(export '+optimize-very-fast+)
(export '+optimize-fast+)
(export '+optimize-normal+)

;; Finally declaim normal optimization level
(declaim #.+optimize-normal+)

(defpackage :glisp (:use))
(asdf:defsystem glisp
    :pathname (merge-pathnames "src/glisp/"
			       (make-pathname :name nil :type nil
					      :defaults *load-truename*))
    :components
    ((:file dependent
	    :pathname
	    #+CLISP                             "dep-clisp"
	    #+(AND :CMU (NOT :PTHREAD))         "dep-cmucl"
	    #+sbcl                              "dep-sbcl"
	    #+(AND :CMU :PTHREAD)               "dep-cmucl-dtc"
	    #+(AND ALLEGRO ALLEGRO-V5.0)        "dep-acl5"
	    #+(AND ALLEGRO (NOT ALLEGRO-V5.0))  "dep-acl"
	    #+GCL                               "dep-gcl"
	    #-(OR sbcl CLISP CMU ALLEGRO GCL) #.(error "Configure!"))
     (:file "package"
	    :depends-on (dependent))
     (:file "runes"
	    :depends-on ("package" dependent))
     (:file "util"
	    :depends-on ("package" dependent "runes"))
     (:file "match"
	    :depends-on ("package" dependent "runes" "util"))))


(asdf:defsystem closure
    :depends-on (:clx
                 :clim
                 :clim-clx
                 :glisp)
    :components
    ((:module src
	      :serial t
	      :components 
	      (;;; Patches
	       (:module patches
			:components
			((:file  "clx-patch")))
	       
	       ;; Images
     
	       (:module imagelib
			:serial t
			:components
			((:file "package")
			 (:file "basic")
			 (:file "deflate")
			 (:file  "png")))
	       
	       ;; Early package definitions
	       
	       (:file "defpack")
     
	       ;; Closure Protocol Declarations first
     
	       (:module protocols
			:serial t
			:components
			((:file "package")
			 (:file "element")
			 (:file "css-support")))

	       ;; Libraries
	       
	       (:module xml
			:components
			((:file "package")
			 (:file "encodings"       :depends-on ("package"))
			 (:file "encodings-data"  :depends-on ("package" "encodings"))
			 (:file "dompack")
			 (:file "dom-impl"        :depends-on ("dompack"))
			 (:file "xml-stream"      :depends-on ("package"))
			 (:file "xml-name-rune-p" :depends-on ("package"))
			 (:file "xml-parse"       :depends-on ("package" "dompack"))
			 (:file "xml-canonic"     :depends-on ("package" "dompack" "xml-parse"))  ))

	       ;; CLEX and LALR
	       
	       (:module clex
			:pathname "util/"
			:components
			((:file "clex") ))
               
	       (:module lalr
			:pathname "util/"
			:components
			((:file "lalr") ))

	       ;; Networking stuff
     
	       (:module net
			:components
			((:file "package"       :depends-on ("url"))
			 (:file "common-parse"  :depends-on ("package"))
			 (:file "mime"          :depends-on ("package"))
			 (:file "url"           :depends-on ())
			 (:file "http"          :depends-on ("package" "url"))
			 (:file "ftp"           :depends-on ("package" "url")) ))

	       ;; The HTML parser
     
	       (:module parse
			:depends-on (clex lalr)
			:components
			((:file "package")
			 (:file "pt"              :depends-on ("package"))
			 (:file "sgml-dtd"        :depends-on ("package"))
			 (:file "sgml-parse"      :depends-on ("package" "sgml-dtd")) ))

	       ;; More Random Utilities
     
	       (:module util
			:components
			((:file "character-set")
			 (:file  "xterm")))

	       ;; CSS

	       (:module css
			:depends-on (net  ;needs URL package
				     "defpack")
			:serial t
			:components
			((:file "package")
			 (:file "css-support")
			 (:file "css-parse")
			 (:file "css-selector")
			 (:file "css-setup")
			 (:file "css-properties")))

	       ;; Renderer
     
	       (:module renderer
			:serial t
			:components
			(
			 (:file "package")

			 (:file "device") ;Declaration of the device abstraction
			 (:file "fonts")	;Font Databases
         
			 (:file "texpara")
			 (:file "images")
			 (:file "x11")
			 (:file "r-struct")
			 (:file "document")
			 (:file "raux")
			 (:file "renderer")
			 (:file "hyphenation")	;Hyphenation of words
			 (:file "clim-draw") ;some drawing "primitives" for the clim device
			 (:file "renderer2")
			 (:file "list-item")     
					; "tables"
			 (:file "clim-device")))

	       ;; HTML
     
	       (:module html
			:components
			((:file "html-style")))

	       ;; GUI

	       (:module gui
			:serial t
			:components
			((:file "gui") (:file "clue-gui")
			 (:file "dce-and-pce") (:file "clue-input")
			 (:file "clim-gui")) )

	       ;; Patches

	       (:file "patch")
	       ))
     
     ;; Some resources
     
     (:module resources
	      :components
	      ((:file "resources")) )))

(in-package :cl-user)

(import '(CLOSURE-SYSTEM:+OPTIMIZE-VERY-FAST+
	 CLOSURE-SYSTEM:+OPTIMIZE-NORMAL+
	 CLOSURE-SYSTEM:+OPTIMIZE-VERY-FAST-TRUSTED+
	 CLOSURE-SYSTEM:+OPTIMIZE-FAST+))
(export '(CLOSURE-SYSTEM:+OPTIMIZE-VERY-FAST+
	  CLOSURE-SYSTEM:+OPTIMIZE-NORMAL+
	  CLOSURE-SYSTEM:+OPTIMIZE-VERY-FAST-TRUSTED+
	  CLOSURE-SYSTEM:+OPTIMIZE-FAST+))