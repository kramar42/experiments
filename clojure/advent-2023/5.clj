(ns day5
  (:require [clojure.string :as str]))

(def maps
  (let [[seeds & other] (-> "5.txt" slurp (str/split #"\n"))]
    (loop [maps {}
           current nil
           lines (remove empty? other)]
      (cond
        (empty? lines) maps
        ;; new map starts
        (str/ends-with? (first lines) " map:")
        (let [map-name (-> lines first (str/split #" ") first)]
          (recur (assoc maps map-name [])
                 map-name
                 (rest lines)))
        :otherwise (recur (update maps current conj (first lines))
                          current
                          (rest lines))))))

(defn parse-map-line [line]
  (let [[dst src len] (map #(Long/parseLong %) (str/split line #" "))]
    [[src (+ src (dec len))] (- dst src)]))

(defn map->fn [map-name]
  (let [ranges
        (->> map-name
             maps
             (map parse-map-line)
             (sort-by ffirst))]
    (fn [x]
      (loop [ranges ranges]
        (let [[[start end] delta] (first ranges)]
          (cond
            (<= start x end)
            (+ x delta)
            (< x start)
            x
            (-> ranges rest empty?)
            x
            :otherwise
            (recur (rest ranges))))))))

(def seed->location
  (let [->soil (map->fn "seed-to-soil")
        ->fertilizer (map->fn "soil-to-fertilizer")
        ->water (map->fn "fertilizer-to-water")
        ->light (map->fn "water-to-light")
        ->temp (map->fn "light-to-temperature")
        ->humidity (map->fn "temperature-to-humidity")
        ->location (map->fn "humidity-to-location")]
    (comp ->location ->humidity ->temp ->light ->water ->fertilizer ->soil)))

(comment
  ((map->fn "seed-to-soil") 1000000)
  (seed->location 100)
  (maps "seed-to-soil"))

(let [seed-strings
      (-> "5.txt"
          slurp
          (str/split #"\n")
          first
          (subs 7)
          (str/split #" "))]
  (->> seed-strings
       (map #(Long/parseLong %))
       (partition 2)
       (mapcat #(range (first %) (apply + %)))
       (pmap seed->location)
       (reduce min)
       println))

