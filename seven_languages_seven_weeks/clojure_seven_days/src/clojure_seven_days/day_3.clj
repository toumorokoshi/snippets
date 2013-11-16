(ns clojure_seven_days.day_3)

(defn debit
  "remove an <amount> to <accounts> at index <n>"
  [accounts n amount]
  (dosync (alter accounts assoc n (- (@accounts n) amount)))
)

(defn credit
  "add an <amount> to <accounts> at index <n>"
  [accounts n amount]
  (dosync (alter accounts assoc n (+ (@accounts n) amount)))
)
