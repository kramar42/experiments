(ns euler.core
  (:require [clojure.math.combinatorics :as cb]))

(defn gen-pandigital
  [] (gen-pandigital [])
  [res] ()))

(defn test-pan [num]
  (let [divisibles [2 3 5 7 11 13 17]
        ranges (map #(range % (+ 3 %)) (range 1 8))
        paired (map vector divisibles ranges)]
    (every? identity
            (map (fn [[divides positions]]
                   (zero?
                    (rem
                     (reduce
                      #(+ (* 10 %1) %2)
                      (map (partial nth num) positions))
                     divides)))
                 paired))))
  
(def pans (filter test-pan (cb/permutations [0 1 2 3 4 5 6 7 8 9])))
