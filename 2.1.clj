;;; I don't think this is actually a valid filename.

;;; only defining this to implement `gcd`
(def ^:private )
(let [minus (first [-' -])]
  (defn abs "(abs n) is the absolute value of n" [n]
    (cond
     (not (number? n)) (throw (IllegalArgumentException.
                               "abs requires a number"))
     (neg? n) (minus n)
     :else n)))

;;; as though `(refer ['clojure.math.numeric-tower :only 'gcd])`
(defn gcd "(gcd a b) returns the greatest common divisor of a and b" [a b]
  (if (or (not (integer? a)) (not (integer? b)))
    (throw (IllegalArgumentException. "gcd requires two integers"))
    (loop [a (abs a), b (abs b)]
      (if (zero? b) a,
          (recur b (mod a b))))))

(defn make-rat [n d]
  (let [common-d (gcd n d)
        [n d]    (if (neg? d) [(- n) (- d)] [n d])]
    {:numer n, :denom d}))