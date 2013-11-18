; the sleeping barber problem
(ns clojure_seven_days.barber)

(defn cut_hair
  "have <barber> cut the hair of a customer with name <name>"
  [barber barber_shop name]
  (do
    ; (print (str "Cutting " name "'s hair\n"))
    (Thread/sleep 20)
    (dosync (alter barber_shop pop))
    (inc barber)
  )
)

(def customer_names
  ["Randy"
   "Archer"
   "Mallory"
   "Lana"
   "Cyril"
   "Bob"
   "Linda"
   "Krieger"
   "Barry"
   "Roy"
   "Pam"
   "Kalli"
   "Kenan"
   "Pina"
   "Afres"
   "Stacy"
   "Tulsa"
   "Emmet"
   "Oscar"
   "Nima"]
)

(defn run_barber_experiment
  "run the barber shop experiment"
  []
  (let [barber_shop (ref [])
        barber (agent 0)
        end_time (+ (System/currentTimeMillis) (* 10 1000))]
    (do
      (while (< (System/currentTimeMillis) end_time)
        (do
          (let [time (rand-int 20)
                name (customer_names time)]
            (Thread/sleep (+ 10 time))
            (if (< (count @barber_shop) 4)
              (dosync
               (alter barber_shop conj name)
               (send barber cut_hair barber_shop name)
               )
            )
          )
        )
      )
      (print @barber "\n")
    )
  )
)

(defn -main
  []
  (do
    (print "starting!\n")
    (run_barber_experiment)
    (print "done!\n")
  )
)
