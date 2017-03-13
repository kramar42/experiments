(ns euler.core
  (:require [clojure.math.numeric-tower :as math]))

(defn divisors
  ([^long n] (divisors n {} (long 2)))

  ([^long n divs ^long e]
   (cond
     (> e (+ (Math/sqrt n) 2)) divs
     (zero? (mod n e))         (recur (long (/ n e)) (update-in divs [e] (fnil inc 0)) e)
     :otherwise                (recur n divs (inc e)))))

(divisors 24)

(defn sigma [^long x ^long n]
  (apply *
         (map
          (fn [[^long p ^long t]]
            (apply + 1
                   (map (fn [^long i] (math/expt p (* i x)))
                        (range 1 (inc t)))))
          (divisors n))))

(sigma 2 24)

(def BIG_NUM 1000000000000000)
(def MODULO  1000000000)
(def BIG_NUM_ 1000000)

(defn sigma2 [^long n]
  (mod (sigma 2 n) MODULO))

(time (sigma2 454840285918294))

(defn SIGMA2 [^long n]
  (loop [i 1
         result 0]
    (if (= i n)
      result
      (recur (inc i) (+ result (sigma2 i))))))

(time (SIGMA2 100000))
