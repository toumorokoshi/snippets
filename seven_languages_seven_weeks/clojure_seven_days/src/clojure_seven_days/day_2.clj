(ns clojure_seven_days.day_2)

(defmacro unless [test then else]
          (list 'if (list 'not test) then else))


; defining a protocol first

(defprotocol Cat
  (meow [c])
  (eat [c])
  (purr [c])
)

(defrecord Kalli [sound food] Cat
    (meow [this] sound)
    (eat [this] (str "eating " food))
    (purr [this] "purr!")
)
