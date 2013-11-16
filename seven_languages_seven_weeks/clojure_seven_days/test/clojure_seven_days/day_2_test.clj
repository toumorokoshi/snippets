(ns clojure-seven-days.day_2-test
  (:require [clojure.test :refer :all]
            [clojure_seven_days.day_2 :refer :all])
)

(import clojure_seven_days.day_2.Kalli)



(deftest test-unless (is (= 1 (unless false 1 0))))
(deftest test-unless-false (is (= 0 (unless true 1 0))))

(deftest test-kalli (is
                     (=
                      "moo" (meow (Kalli. "moo" "salmon"))
                      )
                     )
)
