(ns clojure-seven-days.day_3-test
  (:require [clojure.test :refer :all]
            [clojure_seven_days.day_3 :refer :all])
)


(deftest test-credit (let [accounts (ref (vector 1))]
                      (is (= (vector 2) (credit accounts 0 1)))
                      )
)

(deftest test-debit (let [accounts (ref (vector 3))]
                      (is (= (vector 1) (debit accounts 0 2)))
                      )
)
