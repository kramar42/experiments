(ns euler.core)

(def names-file "resources/p022_names.txt")
(def names-str (slurp names-file))
(def names (sort (map (fn [word] (.substring word 1 (dec (count word))))
                (.split names-str ","))))

(apply +
       (map (fn [word pos]
              (* pos (apply + (map #(- (int %) 64) word))))
            names
            (range 1 (inc (count names)))))
