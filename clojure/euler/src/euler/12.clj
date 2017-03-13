(ns euler.core)

(defn triangle-number [n]
  (* n (/ (inc n) 2)))

(def triangles (map triangle-number (iterate inc 1)))

(defn dividers [n]
  (let [divides? (fn [n m]
                   (zero? (rem n m)))
        sqrtn    (Math/sqrt n)
        divide   (fn [n m r]
                   (cond
                     (<= n 1) r

                     (> m sqrtn) (conj r n)

                     (divides? n m) (recur (/ n m) m (conj r m))

                     :else (recur n (inc m) r)))]
    (divide n 2 [])))

(first (drop-while #(> 500 (count (dividers %))) triangles))

(defn collatz-next [n]
  (if (even? n)
    (/ n 2)
    (inc (* 3 n))))

(defn collatz [n]
  (iterate collatz-next n))

(defn collatz-length [n]
  (inc (count (take-while #(not= 1 %) (collatz n)))))

(defn collatz-length-r [n c]
   (if (= n 1) c
       (recur (collatz-next n) (inc c))))

(first (apply max-key second
              (map #(list % (collatz-length-r % 0)) (range 1 1000000))))

