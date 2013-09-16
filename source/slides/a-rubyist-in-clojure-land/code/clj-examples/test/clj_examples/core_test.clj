(ns clj-examples.core-test
  (:use jry)
  (:require [clojure.test :refer :all]
            [clj-examples.core :refer :all]))

(defn chop [str]
  (subs str 0 (dec (count str))))

(defn to-sentence [strs]
  (if (> 2 (count strs))
    (first strs)
    (clojure.string/join " and " [(clojure.string/join ", " (butlast strs)) (last strs)])))

(defn to-consolidated-map [parts]
  (reduce (fn [h [k v]]
            (assoc h k (+ (get h k 0) v)))
          {}
          parts))

(defn order-of-units [[u _]]
  (.indexOf [:years :months :days :hours :minutes :seconds] u))

(defn format-unit [[u v]]
  (if (= 1 v) [v (chop (name u))] [v (name u)]))

(def format-unit-val-pair
  (partial clojure.string/join " "))


(defn format-duration [parts]
  (->> parts
       (map (partial apply hash-map))
       (apply merge-with +)
       (sort-by order-of-units)
       (map format-unit)
       (map format-unit-val-pair)
       (to-sentence)))

(deftest test-format-duration
  (is (= "1 year, 2 months and 3 days" (format-duration [[:years 1] [:months 2] [:days 3]])))
  (is (= "1 year, 2 months and 3 days" (format-duration [[:days 1] [:years 1] [:months 2] [:days 2]])))
  (is (= "2 months and 3 days" (format-duration [[:days 1] [:months 2] [:days 2]])))
  (is (= "0 seconds" (format-duration [[:seconds 0]])))
  )

(deftest test-to-consolidated-map
  (is (= {:years 4 :months 2} (to-consolidated-map [[:years 1] [:months 2] [:years 3]]))))
