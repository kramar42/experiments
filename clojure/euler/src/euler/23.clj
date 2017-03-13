(ns euler.core)

(defn isabundant? [n]
  (let [half (inc (/ n 2))
        sum (apply +
                   (filter #(zero? (mod n %1))
                           (range 1 half)))]
    (> sum n)))

(isabundant? 11)
