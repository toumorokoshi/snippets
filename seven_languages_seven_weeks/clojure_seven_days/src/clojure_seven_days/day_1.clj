(ns clojure-seven-days.day_1)

(defn big
      "Return true if st has more than twice n characters"
      [st n]
      (> (count st) (* n 2))
)

(defn collection-type
      "returns :list, :map, or :vector based on the type of collection"
      [col]
      (if (map? col) :map
        (if (list? col) :list
          (if (vector? col) :vector nil)
        )
      )
)