(ns day6
  (:require [clojure.string :as str]))

(defn calc-distance [total-time hold-time]
  (* (- total-time hold-time)
     hold-time))

(defn count-wins [[time distance]]
  (->> (range 1 time)
       (map (partial calc-distance time))
       (filter #(> % distance))
       count))

(def input
  (let [[time distance]
        (-> "6.txt"
            slurp
            (str/split #"\n"))
        times (-> time str/trim (str/replace #"\W+" "") (subs 4))
        distances (-> distance str/trim (str/replace #"\W+" "") (subs 8))]
    [(Long/parseLong times)
     (Long/parseLong distances)]
    #_(map vector
         (map #(Integer/parseInt %) times)
         (map #(Integer/parseInt %) distances))))

(-> input count-wins println)

