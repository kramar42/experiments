(ns euler.core)

(defn gen-hamming [type]
  (fn [n]
    (let [half (inc (/ n 2))
          dividers (filter (fn [d] (and (> d type)
                                        (zero? (mod n d))))
                           (range 1 half))]
      (empty? dividers))))

(count (map (gen-hamming 100) (range 1 1000000001)))
