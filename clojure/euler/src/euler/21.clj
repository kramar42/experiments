(ns euler.core)

(defn amicable-sum [n]
  (let [half (inc (/ n 2))
        sum (apply +
                   (filter #(zero? (mod n %1))
                           (range 1 half)))]
    (if (= sum n)
      0
      sum)))

(defn isamicable? [n]
  (= (amicable-sum (amicable-sum n))
     n))

(def bound 10000)

(apply + (filter isamicable? (range 1 (inc bound))))
