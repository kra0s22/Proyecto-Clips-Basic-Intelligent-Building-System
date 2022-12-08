; Basic Intelligent Building System

(deftemplate person
    (slot id_card (type STRING))
    (slot key_level (type STRING))
    (slot name (type STRING)) 
    (slot surname (type STRING))
    (slot location)
    (slot cellphone (type STRING))
)

(deftemplate location    
    (slot name (type STRING)) 
    (slot description (type STRING))
    (slot utility (type STRING))
    (slot telephone (type STRING))
    (slot admission_level (type STRING))
    (slot smokesensor)
)

(deftemplate watersensor
    (slot name (type STRING))
    (slot activated (type STRING)) ; "true" or "false"
    (slot water_level (type STRING)); empty, low, medium, high
    (slot revision (type INTEGER)) 
)


(deftemplate smokesensor
    (slot name (type STRING))
    (slot description (type STRING))
    (slot activated (type INTEGER)) ; mirarlo en clips
    (slot revision (type INTEGER)) ; date last revision
    (slot smoke (type INTEGER))
)

(deffacts main_facts
    ; ********************************
    ; PEOPLE
    ; ********************************
    (person
        (id_card "42888777R")
        (name "Juan") 
        (surname "Fernandez")
        (cellphone "666666666")
        (location "Administracion")
        (key_level "T1")
    )
    (person
        (id_card "42888777R")
        (name "Julian") 
        (surname "Pérez")
        (cellphone "619123456")
        (location "Administracion")
        (key_level "T1")
    )
    (person
        (id_card "42888777R")
        (name "Paco") 
        (surname "Sirtez")
        (cellphone "619123456")
        (location "Administracion")
        (key_level "T1")
    )
    (person
        (id_card "42888777R")
        (name "Sergio") 
        (surname "Sánchez")
        (cellphone "619123456")
        (location "Sala de Juntas")
        (key_level "T1")
    )
    (person
        (id_card "44555666L")
        (name "Laura") 
        (surname "Martínez")
        (cellphone "616778899")
        (location "Sala de Juntas")
    )

    (person
        (id_card "43999000L")
        (name "Antonio") 
        (surname "Hernández")
        (location "Administracion")
    )

    (person
        (id_card "45333444K")
        (name "Luis") 
        (surname "Sosa")   
        (location "Informacion")     
    )

    ; ********************************
    ; PLACES
    ; ********************************
    (location
        (name "Pasillo del primer piso")
        (utility "Initial")
        (telephone "928458899")
        (smokesensor "Sensor del pasillo del primer piso")
    )

    (smokesensor
        (name "Sensor del pasillo del primer piso")
        (description "")
        (activated 1)
        (revision 0)
        (smoke 0)
    )

    (location
        (name "Pasillo del segundo piso")
        (utility "Initial")
        (telephone "928458899")
        (smokesensor "Sensor del pasillo del segundo piso")
    )

    (smokesensor
        (name "Sensor del pasillo del segundo piso")
        (description "")
        (activated 0)
        (revision 0)
        (smoke 0)
    )

    (location
        (name "Sala de Juntas")
        (utility "Room")
        (telephone "928458899")
        (smokesensor "Sensor de la sala de Juntas")
    )

    (smokesensor
        (name "Sensor de la sala de Juntas")
        (description "")
        (activated 1)
        (revision 0)
        (smoke 0)
    )

    (location
        (name "Administracion")
        (utility "Room")
        (telephone "928111222")
        (smokesensor "Sensor de Administracion")
    )
    (smokesensor
        (name "Sensor de Administracion")
        (description "")
        (activated 1)
        (revision 0)
        (smoke 0)
    )

    (location
        (name "Almacen")
        (utility "Room")
        (telephone "928000888")
        (admission_level "T1");codigo identificacion
        (smokesensor "Sensor del Almacen")
    )
    (smokesensor
        (name "Sensor del Almacen")
        (description "")
        (activated 1)
        (revision 0)
        (smoke 1)
    )

    (location
        (name "Informacion")
        (utility "Room")
        (telephone "928000888")
        (smokesensor "Sensor del Informacion")
    )

    (smokesensor
        (name "Sensor de Informacion")
        (description "")
        (activated 1)
        (revision 30)
        (smoke 1)
    )

    (watersensor
        (name "Tanque del techo 1")
        (activated "true")
        (revision 0)
        (water_level "high"); empty, low, medium, high
    )

    (watersensor
        (name "Tanque del techo 2")
        (activated "true")
        (revision 30)
        (water_level "medium"); empty, low, medium, high
    )

    ; ********************************
    ; CONDITIONS
    ; ********************************
    (temperature 29)
    (raining "yes") 
    (day "work_day") ; work_day/week_end
    (time_day "work_morning") ; work_morning/work_evening/work_night

)


; ********* BUILDING CLOSING *********

(defrule building_closed
    (day ?d)
    (test (eq ?d "work_day"))
    (location (name ?l) (utility ?u))
    (test (eq ?u "Initial"))
    (time_day ?t)
    (test (eq ?t "working_night"))
    =>
    (printout t "Cierre del edificio: apagado de la luz de " ?l crlf)
)

; ********* BUILDING OPENING *********
(defrule building_open
    (day ?d)
    (test (eq ?d "work_day"))
    (location (name ?l) (utility ?u))
    (test (eq ?u "Initial"))
    (time_day ?t)
    (test (neq ?t "working_night"))
    =>
    (printout t "Apertura del edificio: encendido de la luz de " ?l crlf)
)

; ********* WATERTANK *********

(defrule water_tank_check_activated
    (watersensor (name ?n) (activated ?a) (revision ?r) (water_level ?w))
    (test (neq ?a "true"))
    =>
    (printout t "Sensor tanque desactivado: " ?n " está desactivado" crlf)
    (modify ?a (activated "true"))
)

(defrule water_tank_is_activated
    (watersensor (name ?n) (activated ?a) (revision ?r) (water_level ?w))
    (test (eq ?a "true"))
    =>
    (printout t "Sensor tanque activado: " ?n " está activado" crlf)
)


(defrule water_tank_reset_revision
    ?i <- (watersensor (name ?n) (activated ?a) (revision ?r) )
    (test (eq ?a "true"))
    (test (> ?r 29))
    =>
    (printout t "Sensor tanque revisión: " ?n " necesita revisión" crlf)
    (modify ?i (revision 0))
)

(defrule water_tank_increase_revision
    ?i <- (watersensor (name ?n) (activated ?a) (revision ?r) )
    (test (eq ?a "true"))
    (time_day ?t)
    (test (eq ?t "work_night"))
    (test (< ?r 29))
    =>
    (modify ?i (revision (+ ?r 1)))
)

(defrule water_tank_check_water_level
    ?i <-(watersensor (name ?n) (activated ?a) (revision ?r) (water_level ?w))
    (test (eq ?a "true"))
    (test (eq ?w "high"))
    =>
    (printout t "Tanque de agua: " ?n " esta a " ?w ", necesita vaciado" crlf)
    (modify ?i (water_level "low"))
)

(defrule water_tank_check_is_raining
    (raining ?r)
    (test (eq ?r "yes"))
    =>
    ; for each person find the location and test if it is equal to ?l
    (do-for-all-facts ((?w watersensor)) 
        (eq ?w:activated "true")
        (neq ?w:water_level "high")
        (printout t "Apertura de tanque de agua: la compuerta del " ?w:name " se abre"crlf)
    )
)


; ********* SMOKE SENSOR *********
;check if a person is in a room with a sensor and if the sensor is activated, print a message

(defrule smoke_sensor_check_activated
    (location (name ?l) (utility ?u) (smokesensor ?s))
    ?i <- (smokesensor (name ?n) (activated ?a) (revision ?r))
    (test (eq ?s ?n))
    (test (neq ?a 1))
    =>
    (printout t "Sensor detector de humos desactivado: " ?s "está desactivado" crlf)
    (modify ?i (activated 1))
)

(defrule smoke_sensor_is_activated
    (location (name ?l) (utility ?u) (smokesensor ?s))
    (smokesensor (name ?n) (activated ?a))
    (test (eq ?s ?n))
    (test (eq ?a 1))
    =>
    (printout t "Sensor detector de humos activado: " ?s " está activado" crlf)
)


(defrule smoke_sensor_reset_revision
    (location (name ?l) (utility ?u) (smokesensor ?s))
    ?i <- (smokesensor (name ?n) (activated ?a) (revision ?r) )
    (test (eq ?s ?n))
    (test (eq ?a 1))
    (test (> ?r 29))
    =>
    (printout t "Sensor detector de humos revisión: " ?n " necesita revisión" crlf)
    (modify ?i (revision 0))
)

(defrule smoke_sensor_increase_revision
    (location (name ?l) (utility ?u) (smokesensor ?s))
    ?i <- (smokesensor (name ?n) (activated ?a) (revision ?r) )
    (test (eq ?s ?n))
    (test (eq ?a 1))
    (time_day ?t)
    (test (eq ?t "work_night"))
    (test (< ?r 29))
    =>
    (modify ?i (revision (+ ?r 1)))
)

(defrule smoke_sensor_check_detect_smoke
    (location (name ?l) (utility ?u) (smokesensor ?s))
    (smokesensor (name ?n) (activated ?a) (revision ?r) (smoke ?w))
    (test (eq ?s ?n))
    (test (eq ?a 1))
    (test (eq ?w 1))
    =>
    (printout t "Detección de humo: " ?n ", activando aspersor y llamado a los bomberos" crlf)
)

; ********* LIGHTS *********
(defrule turn_light_on
    (time_day ?t)
    (or (test (eq ?t "work_morning")) (test (eq ?t "work_evening")))
    (location (name ?l) (utility ?u))
    (test (eq ?u "Room"))
    (day ?d)
    (test (eq ?d "work_day"))
    (exists (person (location ?l)))
    =>
    (printout t "Luz encendida: se enciende la luz de " ?l crlf)
)

(defrule turn_light_off
    (time_day ?t)
    (test (eq ?t "work_night"))
    (location (name ?l) (utility ?u))
    (test (eq ?u "Room"))
    (day ?d)
    (test (eq ?d "work_day"))
    (not (exists (person (location ?l))))
    (test (neq ?u "Initial"))
    =>
    (printout t "Luz apagada: se apaga la luz de " ?l crlf)
)

; ********* AIRCONDITIONING *********
;switch on airconditioning when temperature is higher than 28ºC and there are 2 people in the room
(defrule airconditioning_on
    (temperature ?te)
    (test (> ?te 28))
    (time_day ?t)
    (or (test (eq ?t "work_morning")) (test (eq ?t "work_evening")))
    (location (name ?l) (utility ?u))
    (day ?d)
    (test (eq ?d "work_day"))
    =>
    ; for each person find the location and test if it is equal to ?l
    (bind ?counter 0)
    (do-for-all-facts ((?p person)) 
        (eq ?p:location ?l)
        (bind ?counter (+ ?counter 1))
    )
    (if (> ?counter 1)
        then
        (printout t "Aire acondicionado encendido: el aire acondicionado de " ?l " se enciede"crlf)
    )
)

; ********* HEATINGUNIT *********
(defrule heattingunit_on
    (temperature ?te)
    (test (< ?te 15))
    (time_day ?t)
    (or (test (eq ?t "work_morning")) (test (eq ?t "work_evening")))
    (location (name ?l) (utility ?u))
    (day ?d)
    (test (eq ?d "work_day"))
    =>
    ; for each person find the location and test if it is equal to ?l
    (bind ?counter 0)
    (do-for-all-facts ((?p person)) 
        (eq ?p:location ?l) 
        (bind ?counter (+ ?counter 1))
    )
    (if (> ?counter 1)
        then
        (printout t "Calefacción encendida: la calefacción de " ?l " se enciede"crlf)
    )
)

; ********* MOVEMENT *********
(defrule movement
    (person (name ?n) (surname ?s) (location ?lp))
    (location (name ?lo)) 
    (test (eq ?lp ?lo))
    =>
    (printout t "Movimiento: " ?n " " ?s " está en " ?lo crlf)
)

