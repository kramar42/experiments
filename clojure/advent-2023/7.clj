(ns day7
  (:require [clojure.string :as str]))

;; card values
;; A, K, Q, J, T, 9, 8, 7, 6, 5, 4, 3, 2
(def card->value
  (into {}
        (map-indexed #(vector %2 %1)
                     (reverse "AKQJT98765432"))))
(comment
  (card->value \A) ;; 12
  )

(defn hand->value [hand]
  (->> hand
       (map-indexed (fn [i c]
                      (*
                       (Math/pow 12 (- 5 i))
                       (card->value c))))
       (apply +)
       int))

(comment
  (hand->value "AA"))

;; hand types
;; 5 > 4+1 > 3+2 > 3+1+1 > 2+2+1 > 2+1+1+1 > 1+1+1+1+1
(defn hand->freq [hand]
  (let [freqs
        (->> hand frequencies vals sort reverse)]
    (vec (concat freqs
                 (repeat (- 5 (count freqs)) 0)
                 [(hand->value hand)]))))

(comment
  (hand->freq "AAAAA")
  (hand->freq "AA8AA"))

(def lines
  (-> "7.txt"
      slurp
      (str/split #"\n")))

(->> lines
     (map #(str/split % #" "))
     #_(map first)
     (sort-by (comp hand->freq first))
     (map second)
     (map #(Integer/parseInt %))
     (map-indexed #(* (inc %1) %2))
     (apply +)
     println)

