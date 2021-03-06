(in-package :rtg-math.projection)

;;------------------------------------------------------------

(defn orthographic ((frame-width single-float) (frame-height single-float)
                    (near single-float) (far single-float))
    mat4
  (declare (optimize (speed 3) (safety 1) (debug 1)))
  (let ((left (- (/ frame-width 2.0)))
        (right (/ frame-width 2.0))
        (top (/ frame-height 2.0))
        (bottom (- (/ frame-height 2.0)))
        (result (m4:0!)))
    (setf (m4:melm result 0 0) (/ 2f0 (- right left))
          (m4:melm result 1 1) (/ 2f0 (- top bottom))
          (m4:melm result 0 3) (- (/ (+ right left) (- right left)))
          (m4:melm result 1 3) (- (/ (+ top bottom) (- top bottom)))
          (m4:melm result 2 2) (/ -2f0 (- far near))
          (m4:melm result 2 3) (- (/ (+ far near) (- far near)))
          (m4:melm result 3 3) 1f0)
    result))

(defn orthographic-v2 ((frame-size-v2 vec2)
                       (near single-float) (far single-float))
    mat4
  (declare (optimize (speed 3) (safety 1) (debug 1)))
  (orthographic (x frame-size-v2) (y frame-size-v2) near far))

;;------------------------------------------------------------
