(ns day3
  (:require [clojure.string :as str]))

(defn is-digit? [c]
  (<= (int \0) (int c) (int \9)))

(defn is-symbol? [c]
  (and (not= c \.)
       (not (is-digit? c))))

(def in
  (-> "3"
      slurp
      (str/split #"\n")
      #_(mapv vec)
      ))

(for [i (-> in count range)]
  (loop [nums {}
         j (-> in (nth i) count range)]
    j))

