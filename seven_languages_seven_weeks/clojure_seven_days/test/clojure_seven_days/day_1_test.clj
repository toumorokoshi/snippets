(ns clojure-seven-days.day_1-test
  (:require [clojure.test :refer :all]
            [clojure-seven-days.day_1 :refer :all]))



(deftest big-test (is (big "test" 1)))

(deftest collection-map-test
         (is (= :map (collection-type {:a 'a'}))))

(deftest collection-list-test
         (is (= :list(collection-type '(:a :b)))))

(deftest collection-vector-test
         (is (= :vector (collection-type [:a :b]))))

(deftest collection-nil-test
         (is (= nil (collection-type "test"))))