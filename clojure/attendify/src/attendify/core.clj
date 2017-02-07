(ns attendify.core
  (:gen-class)
  ;; becasue clj-http doesn't work with https://api.dribbble hostname
  (:require [clj-http.lite.client :as client])
  (:require [clojure.data.json :as json])
  (:require [clojure.string :as str]))

;;;;
; dribbble task
;;;;

(def auth-header
  {:headers
   {"Authorization"
    "Bearer 41adcfed5a46d4c1a6f0446dc304fad1b4cb59a723f12082c7b877847c5ab252"}})

; make api requests every second
(def interval 1000)

(defn get-followers
  [username & [link followers]]
  (Thread/sleep interval)
  (let [link (or link (str "http://api.dribbble.com/v1/users/" username "/followers"))
        response (client/get link auth-header)
        link (get-in response [:headers "link"])
        parsed-link (str/replace link #".*<(.*)>; rel=\"next\".*" "$1")
        body (json/read-str (:body response))
        followers (concat followers (map #(get-in % ["follower" "username"]) body))]
    (if (.contains link "next")
      (recur username [parsed-link followers])
      followers)))

;(def followers (get-followers "skilz"))

(defn get-shots
  [username]
  (Thread/sleep interval)
  (let [link (str "http://api.dribbble.com/v1/users/" username "/shots")
        response (client/get link auth-header)
        body (json/read-str (:body response))]
    (println "Getting shots from" username)
    (map #(get % "id") body)))

;(def shots (get-shots "romavrs"))

(defn get-shot-likers
  [shot-id]
  (Thread/sleep interval)
  (let [link (str "http://api.dribbble.com/v1/shots/" shot-id "/likes")
        response (client/get link auth-header)
        body (json/read-str (:body response))]
    (println "Getting likers for shot" shot-id)
    (map #(get-in % ["user" "username"]) body)))

(defn get-top10
  [username]
  (println "Getting top 10 shot likers from" username "followers")
  (let [followers (get-followers username)
        shots (distinct (apply concat (map get-shots followers)))
        users (frequencies (apply concat (map get-shot-likers shots)))]
    (println "Top 10 likers are:")
    (take 10 (sort-by second users))))

;;;;
; url matcher task
;;;;

(def input "host(twitter.com); path(?user/status/?id); queryparam(offset=?offset); queryparam(limit=?limit);")
(def input2 "host(twitter.com); path(?user/status/?id); queryparam(offset=?offset);")
(def input3 "host(twitter.com); path(?user/status/?id);")

(defn to-pairs
  "Parse input string into pairs of [:key 'value']"
  [input]
  (for [value (str/split input #";")
        :let [value (str/trim value)
              open-per (str/index-of value "(")
              close-per (str/index-of value ")")
              key (.substring value 0 open-per)
              value (.substring value (inc open-per) close-per)]]
        [(keyword key) value]))

(defn to-map
  [pairs]
  (apply merge-with conj {:queryparam []}
         (map #(into {} [%]) pairs)))

(defn map-path-params
  [params]
  (update params :path
          (fn [value]
            [value
             ; save them as keywords
             (into [] (map #(keyword (.substring % 1))
                           ; find all binds
                           (filter #(str/starts-with? % "?")
                                   (str/split value #"\/"))))])))

(defn map-query-params
  [params]
  (update params :queryparam
          (fn [val]
            (into []
                  (for [value val
                        :let [[k v] (str/split value #"\?")]]
                    [k (keyword v)])))))

(defrecord Pattern [host path queryparam])
(defn pattern
  [value]
  (let [{host :host
         path :path
         params :queryparam} (-> value
                                 to-pairs
                                 to-map
                                 map-path-params
                                 map-query-params)]
    (->Pattern host path params)))

(def p (pattern input))

(defn path2re
  [[path values]]
  (str/replace (str/replace path #"\?[^\/]+" "(.*)")
               "/" "\\/"))

(defn params2re
  [params]
  (map #(str (first %) "([^&]+)") params))

(defn recognize
  [pattern string]
  (into {}
        ; first three nils
        (drop 3
            ; make a pairs of :key "re-group matches"
            (map vector
                 (concat [nil nil nil :host]
                     ; bindings in path
                     (second (:path pattern))
                     ; bindings in query params
                     (map second (:queryparam pattern)))
                 (concat (re-matches (re-pattern
                                   ; optional protocol
                              (str "(https?:\\/\\/)?(www\\.)?("
                                   ; host with escaped dots
                                   (str/replace (:host pattern) "." "\\.")
                                   ")\\/"
                                   ; binds in path
                                   (path2re (:path pattern))
                                   ; trailing question mark
                                   (if (empty? (:queryparam pattern))
                                       ""
                                       "\\?")
                                   ".*"))
                               string)
                         (map #(let [pattern (re-pattern %)
                                     result (re-find pattern string)]
                                 ; return only found string or nil
                                 (if result
                                    (second result)
                                    nil))
                              (params2re (:queryparam pattern))))))))

;;;
; i know that writing parsers using regexp's isn't best idea (more like the worst),
; but i've already tried parsing files using simpler way and i wanted to try some
; new approach. here is more conventional way:
; https://github.com/kramar42/diploma/blob/master/code/src/sgfc/sgf.clj
;;;


(def twitter (pattern "host(twitter.com); path(?user/status/?id);"))
(recognize twitter "http://twitter.com/bradfitz/status/562360748727611392")

(def dribbble (pattern "host(dribbble.com); path(shots/?id); queryparam(offset=?offset);"))
(def dribbble2 (pattern "host(dribbble.com); path(shots/?id); queryparam(offset=?offset); queryparam(list=?type);"))

(recognize dribbble "https://dribbble.com/shots/1905065-Travel-Icons-pack?list=users&offset=1")
(recognize dribbble "https://twitter.com/shots/1905065-Travel-Icons-pack?list=users&offset=1")
(recognize dribbble2 "https://dribbble.com/shots/1905065-Travel-Icons-pack?list=users")
