(in-package :rtg-math.matrix3.non-consing)

;;----------------------------------------------------------------

(defn set-components ((a single-float) (b single-float) (c single-float)
                      (d single-float) (e single-float) (f single-float)
                      (g single-float) (h single-float) (i single-float)
                      (mat3-to-mutate mat3)) mat3
  "Make a 3x3 matrix. Data must be provided in row major order"
  (declare (optimize (speed 3) (safety 1) (debug 1)))
  (setf (melm mat3-to-mutate 0 0) a)
  (setf (melm mat3-to-mutate 0 1) b)
  (setf (melm mat3-to-mutate 0 2) c)
  (setf (melm mat3-to-mutate 1 0) d)
  (setf (melm mat3-to-mutate 1 1) e)
  (setf (melm mat3-to-mutate 1 2) f)
  (setf (melm mat3-to-mutate 2 0) g)
  (setf (melm mat3-to-mutate 2 1) h)
  (setf (melm mat3-to-mutate 2 2) i)
  mat3-to-mutate)

;;----------------------------------------------------------------

(defn %* ((mat-accum mat3) (to-multiply-mat mat3)) mat3
  "Multiplies 2 matrices and returns the result as a new
   matrix"
  (declare (optimize (speed 3) (safety 1) (debug 1)))
  (let ((a (cl:+ (cl:* (melm mat-accum 0 0) (melm to-multiply-mat 0 0))
                 (cl:* (melm mat-accum 0 1) (melm to-multiply-mat 1 0))
                 (cl:* (melm mat-accum 0 2) (melm to-multiply-mat 2 0))))
        (b (cl:+ (cl:* (melm mat-accum 1 0) (melm to-multiply-mat 0 0))
                 (cl:* (melm mat-accum 1 1) (melm to-multiply-mat 1 0))
                 (cl:* (melm mat-accum 1 2) (melm to-multiply-mat 2 0))))
        (c (cl:+ (cl:* (melm mat-accum 2 0) (melm to-multiply-mat 0 0))
                 (cl:* (melm mat-accum 2 1) (melm to-multiply-mat 1 0))
                 (cl:* (melm mat-accum 2 2) (melm to-multiply-mat 2 0))))
        (d (cl:+ (cl:* (melm mat-accum 0 0) (melm to-multiply-mat 0 1))
                 (cl:* (melm mat-accum 0 1) (melm to-multiply-mat 1 1))
                 (cl:* (melm mat-accum 0 2) (melm to-multiply-mat 2 1))))
        (e (cl:+ (cl:* (melm mat-accum 1 0) (melm to-multiply-mat 0 1))
                 (cl:* (melm mat-accum 1 1) (melm to-multiply-mat 1 1))
                 (cl:* (melm mat-accum 1 2) (melm to-multiply-mat 2 1))))
        (f (cl:+ (cl:* (melm mat-accum 2 0) (melm to-multiply-mat 0 1))
                 (cl:* (melm mat-accum 2 1) (melm to-multiply-mat 1 1))
                 (cl:* (melm mat-accum 2 2) (melm to-multiply-mat 2 1))))
        (g (cl:+ (cl:* (melm mat-accum 0 0) (melm to-multiply-mat 0 2))
                 (cl:* (melm mat-accum 0 1) (melm to-multiply-mat 1 2))
                 (cl:* (melm mat-accum 0 2) (melm to-multiply-mat 2 2))))
        (h (cl:+ (cl:* (melm mat-accum 0 1) (melm to-multiply-mat 0 2))
                 (cl:* (melm mat-accum 1 1) (melm to-multiply-mat 1 2))
                 (cl:* (melm mat-accum 1 2) (melm to-multiply-mat 2 2))))
        (i (cl:+ (cl:* (melm mat-accum 2 0) (melm to-multiply-mat 0 2))
                 (cl:* (melm mat-accum 2 1) (melm to-multiply-mat 1 2))
                 (cl:* (melm mat-accum 2 2) (melm to-multiply-mat 2 2)))))
    (setf (melm mat-accum 0 0) a)
    (setf (melm mat-accum 0 1) b)
    (setf (melm mat-accum 0 2) c)
    (setf (melm mat-accum 1 0) d)
    (setf (melm mat-accum 1 1) e)
    (setf (melm mat-accum 1 2) f)
    (setf (melm mat-accum 2 0) g)
    (setf (melm mat-accum 2 1) h)
    (setf (melm mat-accum 2 2) i)
    mat-accum))

(defn * ((accum-mat mat3) &rest (mat3s mat3)) mat3
  (reduce #'%* mat3s :initial-value accum-mat))

(define-compiler-macro * (&whole whole accum-mat &rest mat4s)
  (assert accum-mat)
  (case= (cl:length mat4s)
    (0 accum-mat)
    (1 `(%* ,accum-mat ,(first mat4s)))
    (otherwise whole)))

;;----------------------------------------------------------------