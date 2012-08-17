(cl:eval-when (:load-toplevel :execute)
  (asdf:operate 'asdf:load-op 'cffi-grovel))

(defsystem "cl-enet"
   :description "wrapper for libenet"
   :version "0.1"
   :author "aclarke"
   :licence "BSD"
   :depends-on (cffi)
   :serial t
   :components ((:file "package")
                (cffi-grovel:grovel-file "grovel")
                (:file "libenet")))
