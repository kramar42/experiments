(defproject attendify "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.8.0"]
                 [clj-http "2.3.0"]
                 [clj-http-lite "0.3.0"]
                 [org.clojure/data.json "0.2.6"]]
  :main ^:skip-aot attendify.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}})
