(ns day2
  (:require [clojure.string :as str]))

(defn parse-round [round]
  (let [cubes (str/split round #",")]
    (->> cubes
         (map str/trim)
         (map #(str/split % #" "))
         (map #(vector
                 (second %)
                 (-> % first Integer/parseInt)))
         (into {}))))

(defn parse-game-id [game]
  (-> game
      (str/split #":")
      first
      (subs 5)
      (#(Integer/parseInt %))))

(comment
 (parse-round " 1 red, 2 green, 6 blue")
 (parse-game-id "Game 42: 10 red"))

(defn is-possible? [game]
  (let [[_ rest] (str/split game #":")
        rounds (str/split rest #";")]
    (->> rounds
      (map parse-round)
      (remove #(and
                 (<= (get % "red" 0)   12)
                 (<= (get % "green" 0) 13)
                 (<= (get % "blue" 0)  14)))
      empty?)))

(defn max-cubes [game]
  (let [[_ rest] (str/split game #":")
        rounds (str/split rest #";")]
    (->> rounds
      (map parse-round)
      (reduce (fn [acc x]
                {"red" (max (acc "red")
                            (get x "red" 0))
                 "green" (max (acc "green")
                            (get x "green" 0))
                 "blue" (max (acc "blue")
                            (get x "blue" 0))})
              {"red" 0 "green" 0 "blue" 0}))))

(reduce max [1 2 3])

(def games
  (-> "2.txt"
      slurp
      (str/split #"\n")))

(->> games
     (map max-cubes)
     (map #(* (% "red") (% "green") (% "blue")))
     (apply +)
     println)

