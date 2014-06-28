(ns qsort.core
  (:gen-class))

(defn less-or-more
  ([coll elem] (less-or-more coll elem [] []))
  ([coll elem less more]
   (if (empty? coll)
     [less more]
     (let [head (first coll)]
       (if (> head elem)
         (less-or-more (rest coll) elem
                       less (conj more head))
         (less-or-more (rest coll) elem
                       (conj less head)  more))))))

(defn qsort [coll]
  (if (empty? coll)
    []
    (let [x (first coll)
          xs (rest coll)
          [less more] (less-or-more xs x)]
      (concat (qsort less) (list x) (qsort more)))))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "Hello, World!"))
