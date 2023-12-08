(ns day4
  (:require [clojure.string :as str]))

(defn card->matches [card]
  (let [[winning have] (str/split card #"\|")
        wins (-> winning str/trim (str/split #" "))
        haves (-> have str/trim (str/split #" "))]
    (count
      (filter (into #{} wins)
              haves))))

(defn card->value [card]
  (let [matches (card->matches card)]
    (if (zero? matches)
      0
      (int (Math/pow 2 (dec matches))))))

(def lines
  (-> "4.txt"
      slurp
      (str/split #"\n")))

(->> lines
     (map #(str/split % #":"))
     (map second)
     (map card->value)
     (apply +)
     println)

