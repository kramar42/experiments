(ns euler.core)

(def words-filename "resources/p042_words.txt")
(def raw-words (slurp words-filename))
(def words (map (fn [word] (.substring word 1 (dec (count word))))
     (.split raw-words ",")))

(defn chr [chr]
  (- (int chr) 64))

(defn triangle [word]
  (apply + (map chr word)))

(defn int? [num]
  (== num (Math/round num)))

(defn triangle? [num]
  (let [D (Math/sqrt (inc (* 8 num)))]
    (and
     (int? D)
     (odd? (Math/round D)))))

(count (->> words (map triangle) (filter triangle?)))
