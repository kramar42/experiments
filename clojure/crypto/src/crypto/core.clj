(ns crypto.core)

(number? 3)
(- (int \a) (int \A))
(char? \+)

(concat '(1 2 3) '(4 5 6))
(defn- genCharSeq
  "Generate sequence of chars given range, step and starting point"
  ([from length]
   (genCharSeq from length 1))

  ([from length step]
   (map (fn [shift] (char (+ shift (int from)))) (range 0 length step))))

(def base64indexTable
    (concat (genCharSeq \A 26) (genCharSeq \a 26) (genCharSeq \0 10) '(\+ \/)))

(toBin \M)

(defn- toBin
  [chr]
  (let [binFormat (list (Integer/toString (int \M) 2))]
    (concat (repeat "0" (- 8 (count binFormat))) (list binFormat))))

