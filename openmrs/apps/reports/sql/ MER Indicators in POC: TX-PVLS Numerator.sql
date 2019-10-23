
SELECT count(*) AS "Total", -- -- "Routine Breastfeeding"

  (SELECT count(DISTINCT p.person_id)
   FROM person p
   INNER JOIN obs o ON p.person_id=o.person_id
   INNER JOIN obs o1 ON o1.person_id = p.person_id
   INNER JOIN obs ob ON p.person_id=ob.person_id
   AND ob.obs_id =
     (SELECT max(inob.obs_id)
      FROM obs inob
      INNER JOIN concept_view cv ON cv.concept_id = inob.concept_id
      WHERE (cv.concept_full_name = 'CARGA VIRAL (Absoluto-Rotina)'
             OR cv.concept_full_name = 'CARGA VIRAL (Absoluto-Suspeita)')
        AND inob.value_numeric < 1000
        AND (o.date_created >= DATE_SUB('#endDate#', INTERVAL 1 YEAR))
        AND inob.person_id=p.person_id)
   INNER JOIN concept_view cv ON cv.concept_id = ob.concept_id
   AND cv.concept_full_name = 'CARGA VIRAL (Absoluto-Rotina)'
   INNER JOIN erpdrug_order erp1 ON erp1.patient_id=o.person_id
   AND erp1.id =
     (SELECT max(id)
      FROM erpdrug_order
      WHERE (ob.date_created <= DATE_SUB(erp1.dispensed_date, INTERVAL 3 MONTH))
        AND erpdrug_order.dispensed=1
        AND erpdrug_order.arv_dispensed=1
        AND erpdrug_order.first_arv_dispensed=1
        AND erpdrug_order.patient_id=erp1.patient_id)
   AND (((o1.value_datetime >= DATE_SUB('#endDate#', INTERVAL 18 MONTH))
         AND o1.obs_id =
           (SELECT max(obs_id)
            FROM obs
            INNER JOIN concept_name conname ON obs.concept_id=conname.concept_id
            WHERE conname.name = 'Date of Delivery'
              AND concept_name_type ='FULLY_SPECIFIED'
              AND conname.locale ='en'
              AND conname.voided = 0
              AND obs.voided = 0
              AND obs.person_id=o1.person_id ))
        OR ((o1.date_created >= DATE_SUB('#endDate#', INTERVAL 18 MONTH))
            AND o1.obs_id =
              (SELECT max(obs_id)
               FROM obs
               INNER JOIN concept_name conname ON obs.concept_id=conname.concept_id
               WHERE conname.name = 'Breastfeeding_ANA'
                 AND concept_name_type ='FULLY_SPECIFIED'
                 AND conname.locale ='en'
                 AND obs.value_coded = 1
                 AND conname.voided = 0
                 AND obs.voided = 0
                 AND obs.person_id=o1.person_id )))) AS "Routine Breastfeeding", -- -- "Targeted Breastfeeding"

  (SELECT count(DISTINCT p.person_id)
   FROM person p
   INNER JOIN obs o ON p.person_id=o.person_id
   INNER JOIN obs o1 ON o1.person_id = p.person_id
   INNER JOIN obs ob ON p.person_id=ob.person_id
   AND ob.obs_id =
     (SELECT max(inob.obs_id)
      FROM obs inob
      INNER JOIN concept_view cv ON cv.concept_id = inob.concept_id
      WHERE (cv.concept_full_name = 'CARGA VIRAL (Absoluto-Rotina)'
             OR cv.concept_full_name = 'CARGA VIRAL (Absoluto-Suspeita)')
        AND inob.value_numeric < 1000
        AND (o.date_created >= DATE_SUB('#endDate#', INTERVAL 1 YEAR))
        AND inob.person_id=p.person_id)
   INNER JOIN concept_view cv ON cv.concept_id = ob.concept_id
   AND cv.concept_full_name = 'CARGA VIRAL (Absoluto-Suspeita)'
   INNER JOIN erpdrug_order erp1 ON erp1.patient_id=o.person_id
   AND erp1.id =
     (SELECT max(id)
      FROM erpdrug_order
      WHERE (ob.date_created <= DATE_SUB(erp1.dispensed_date, INTERVAL 3 MONTH))
        AND erpdrug_order.dispensed=1
        AND erpdrug_order.arv_dispensed=1
        AND erpdrug_order.first_arv_dispensed=1
        AND erpdrug_order.patient_id=erp1.patient_id)
   AND (((o1.value_datetime >= DATE_SUB('#endDate#', INTERVAL 18 MONTH))
         AND o1.obs_id =
           (SELECT max(obs_id)
            FROM obs
            INNER JOIN concept_name conname ON obs.concept_id=conname.concept_id
            WHERE conname.name = 'Date of Delivery'
              AND concept_name_type ='FULLY_SPECIFIED'
              AND conname.locale ='en'
              AND conname.voided = 0
              AND obs.voided = 0
              AND obs.person_id=o1.person_id ))
        OR ((o1.date_created >= DATE_SUB('#endDate#', INTERVAL 18 MONTH))
            AND o1.obs_id =
              (SELECT max(obs_id)
               FROM obs
               INNER JOIN concept_name conname ON obs.concept_id=conname.concept_id
               WHERE conname.name = 'Breastfeeding_ANA'
                 AND concept_name_type ='FULLY_SPECIFIED'
                 AND conname.locale ='en'
                 AND obs.value_coded = 1
                 AND conname.voided = 0
                 AND obs.voided = 0
                 AND obs.person_id=o1.person_id )))) AS "Targeted Breastfeeding", -- -- "Routine Pregnant"

  (SELECT count(DISTINCT p.person_id)
   FROM person p
   INNER JOIN obs o ON p.person_id=o.person_id
   INNER JOIN obs o1 ON o1.person_id = p.person_id
   INNER JOIN obs ob ON p.person_id=ob.person_id
   AND ob.obs_id =
     (SELECT max(inob.obs_id)
      FROM obs inob
      INNER JOIN concept_view cv ON cv.concept_id = inob.concept_id
      WHERE (cv.concept_full_name = 'CARGA VIRAL (Absoluto-Rotina)'
             OR cv.concept_full_name = 'CARGA VIRAL (Absoluto-Suspeita)')
        AND inob.value_numeric < 1000
        AND (o.date_created >= DATE_SUB('#endDate#', INTERVAL 1 YEAR))
        AND inob.person_id=p.person_id)
   INNER JOIN concept_view cv ON cv.concept_id = ob.concept_id
   AND cv.concept_full_name = 'CARGA VIRAL (Absoluto-Rotina)'
   INNER JOIN erpdrug_order erp1 ON erp1.patient_id=o.person_id
   AND erp1.id =
     (SELECT max(id)
      FROM erpdrug_order
      WHERE (ob.date_created <= DATE_SUB(erp1.dispensed_date, INTERVAL 3 MONTH))
        AND erpdrug_order.dispensed=1
        AND erpdrug_order.arv_dispensed=1
        AND erpdrug_order.first_arv_dispensed=1
        AND erpdrug_order.patient_id=erp1.patient_id)
   AND (((o1.date_created >= DATE_SUB('#endDate#', INTERVAL 9 MONTH))
         AND o1.obs_id =
           (SELECT max(obs_id)
            FROM obs
            INNER JOIN concept_name conname ON obs.concept_id=conname.concept_id
            WHERE conname.name = 'Probable delivery date'
              AND concept_name_type ='FULLY_SPECIFIED'
              AND conname.locale ='en'
              AND conname.voided = 0
              AND obs.voided = 0
              AND obs.person_id=o1.person_id ))
        OR ((o1.date_created >= DATE_SUB('#endDate#', INTERVAL 9 MONTH))
            AND o1.obs_id =
              (SELECT max(obs_id)
               FROM obs
               INNER JOIN concept_name conname ON obs.concept_id=conname.concept_id
               WHERE conname.name = 'Pregnancy_Yes_No'
                 AND concept_name_type ='FULLY_SPECIFIED'
                 AND conname.locale ='en'
                 AND obs.value_coded =
                   (SELECT concept_id
                    FROM concept_view
                    WHERE concept_full_name = 'Pregnancy_Yes')
                 AND conname.voided = 0
                 AND obs.voided = 0
                 AND obs.person_id=o1.person_id )))) "Routine Pregnant", -- -- "Targeted Pregnant"

  (SELECT count(DISTINCT p.person_id)
   FROM person p
   INNER JOIN obs o ON p.person_id=o.person_id
   INNER JOIN obs o1 ON o1.person_id = p.person_id
   INNER JOIN obs ob ON p.person_id=ob.person_id
   AND ob.obs_id =
     (SELECT max(inob.obs_id)
      FROM obs inob
      INNER JOIN concept_view cv ON cv.concept_id = inob.concept_id
      WHERE (cv.concept_full_name = 'CARGA VIRAL (Absoluto-Rotina)'
             OR cv.concept_full_name = 'CARGA VIRAL (Absoluto-Suspeita)')
        AND inob.value_numeric < 1000
        AND (o.date_created >= DATE_SUB('#endDate#', INTERVAL 1 YEAR))
        AND inob.person_id=p.person_id)
   INNER JOIN concept_view cv ON cv.concept_id = ob.concept_id
   AND cv.concept_full_name = 'CARGA VIRAL (Absoluto-Suspeita)'
   INNER JOIN erpdrug_order erp1 ON erp1.patient_id=o.person_id
   AND erp1.id =
     (SELECT max(id)
      FROM erpdrug_order
      WHERE (ob.date_created <= DATE_SUB(erp1.dispensed_date, INTERVAL 3 MONTH))
        AND erpdrug_order.dispensed=1
        AND erpdrug_order.arv_dispensed=1
        AND erpdrug_order.first_arv_dispensed=1
        AND erpdrug_order.patient_id=erp1.patient_id)
   AND (((o1.date_created >= DATE_SUB('#endDate#', INTERVAL 9 MONTH))
         AND o1.obs_id =
           (SELECT max(obs_id)
            FROM obs
            INNER JOIN concept_name conname ON obs.concept_id=conname.concept_id
            WHERE conname.name = 'Probable delivery date'
              AND concept_name_type ='FULLY_SPECIFIED'
              AND conname.locale ='en'
              AND conname.voided = 0
              AND obs.voided = 0
              AND obs.person_id=o1.person_id ))
        OR ((o1.date_created >= DATE_SUB('#endDate#', INTERVAL 9 MONTH))
            AND o1.obs_id =
              (SELECT max(obs_id)
               FROM obs
               INNER JOIN concept_name conname ON obs.concept_id=conname.concept_id
               WHERE conname.name = 'Pregnancy_Yes_No'
                 AND concept_name_type ='FULLY_SPECIFIED'
                 AND conname.locale ='en'
                 AND obs.value_coded =
                   (SELECT concept_id
                    FROM concept_view
                    WHERE concept_full_name = 'Pregnancy_Yes')
                 AND conname.voided = 0
                 AND obs.voided = 0
                 AND obs.person_id=o1.person_id )))) "Targeted Pregnant", --  CARGA VIRAL (Absoluto-Rotina)
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') < 1) THEN 1
           ELSE NULL
       END) AS "Routine M <1",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 1 AND 4) THEN 1
           ELSE NULL
       END) AS "Routine M 1-4",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 5 AND 9) THEN 1
           ELSE NULL
       END) AS "Routine M 5-9",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 10 AND 14) THEN 1
           ELSE NULL
       END) AS "Routine M 10-14",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 15 AND 19) THEN 1
           ELSE NULL
       END) AS "Routine M 15-19",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 20 AND 24) THEN 1
           ELSE NULL
       END) AS "Routine M 20-24",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 25 AND 29) THEN 1
           ELSE NULL
       END) AS "Routine M 25-29",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 30 AND 34) THEN 1
           ELSE NULL
       END) AS "Routine M 30-34",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 35 AND 39) THEN 1
           ELSE NULL
       END) AS "Routine M 35-39",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 40 AND 44) THEN 1
           ELSE NULL
       END) AS "Routine M 40-44",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 45 AND 49) THEN 1
           ELSE NULL
       END) AS "Routine M 45-49",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') >= 50) THEN 1
           ELSE NULL
       END) AS "Routine M >=50",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'M'
                 AND p.birthdate IS NULL) THEN 1
           ELSE NULL
       END) AS "Routine M Unknown age",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'M') THEN 1
           ELSE NULL
       END) AS "Routine Male Subtotal",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') < 1) THEN 1
           ELSE NULL
       END) AS "Routine F <1",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 1 AND 4) THEN 1
           ELSE NULL
       END) AS "Routine F 1-4",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 5 AND 9) THEN 1
           ELSE NULL
       END) AS "Routine F 5-9",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 10 AND 14) THEN 1
           ELSE NULL
       END) AS "Routine F 10-14",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 15 AND 19) THEN 1
           ELSE NULL
       END) AS "Routine F 15-19",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 20 AND 24) THEN 1
           ELSE NULL
       END) AS "Routine F 20-24",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 25 AND 29) THEN 1
           ELSE NULL
       END) AS "Routine F 25-29",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 30 AND 34) THEN 1
           ELSE NULL
       END) AS "Routine F 30-34",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 35 AND 39) THEN 1
           ELSE NULL
       END) AS "Routine F 35-39",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 40 AND 44) THEN 1
           ELSE NULL
       END) AS "Routine F 40-44",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 45 AND 49) THEN 1
           ELSE NULL
       END) AS "Routine F 45-49",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') >= 50) THEN 1
           ELSE NULL
       END) AS "Routine F >=50",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'F'
                 AND (p.birthdate IS NULL)) THEN 1
           ELSE NULL
       END) AS "Routine F Unknown age",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)'
                 AND p.gender = 'F') THEN 1
           ELSE NULL
       END) AS "Routine Female Subtotal", --  'CARGA VIRAL (Absoluto-Suspeita)'
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') < 1) THEN 1
           ELSE NULL
       END) AS "Targeted M <1",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 1 AND 4) THEN 1
           ELSE NULL
       END) AS "Targeted M 1-4",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 5 AND 9) THEN 1
           ELSE NULL
       END) AS "Targeted M 5-9",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 10 AND 14) THEN 1
           ELSE NULL
       END) AS "Targeted M 10-14",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 15 AND 19) THEN 1
           ELSE NULL
       END) AS "Targeted M 15-19",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 20 AND 24) THEN 1
           ELSE NULL
       END) AS "Targeted M 20-24",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 25 AND 29) THEN 1
           ELSE NULL
       END) AS "Targeted M 25-29",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 30 AND 34) THEN 1
           ELSE NULL
       END) AS "Targeted M 30-34",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 35 AND 39) THEN 1
           ELSE NULL
       END) AS "Targeted M 35-39",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 40 AND 44) THEN 1
           ELSE NULL
       END) AS "Targeted M 40-44",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 45 AND 49) THEN 1
           ELSE NULL
       END) AS "Targeted M 45-49",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'M'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') >= 50) THEN 1
           ELSE NULL
       END) AS "Targeted M >=50",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'M'
                 AND p.birthdate IS NULL) THEN 1
           ELSE NULL
       END) AS "Targeted M Unknown age",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'M') THEN 1
           ELSE NULL
       END) AS "Male Subtotal",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') < 1) THEN 1
           ELSE NULL
       END) AS "Targeted F <1",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 1 AND 4) THEN 1
           ELSE NULL
       END) AS "Targeted F 1-4",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 5 AND 9) THEN 1
           ELSE NULL
       END) AS "Targeted F 5-9",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 10 AND 14) THEN 1
           ELSE NULL
       END) AS "Targeted F 10-14",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 15 AND 19) THEN 1
           ELSE NULL
       END) AS "Targeted F 15-19",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 20 AND 24) THEN 1
           ELSE NULL
       END) AS "Targeted F 20-24",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 25 AND 29) THEN 1
           ELSE NULL
       END) AS "Targeted F 25-29",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 30 AND 34) THEN 1
           ELSE NULL
       END) AS "Targeted F 30-34",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 35 AND 39) THEN 1
           ELSE NULL
       END) AS "Targeted F 35-39",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 40 AND 44) THEN 1
           ELSE NULL
       END) AS "Targeted F 40-44",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') BETWEEN 45 AND 49) THEN 1
           ELSE NULL
       END) AS "Targeted F 45-49",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'F'
                 AND TIMESTAMPDIFF(YEAR, p.birthdate, '#endDate#') >= 50) THEN 1
           ELSE NULL
       END) AS "Targeted F >=50",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'F'
                 AND (p.birthdate IS NULL)) THEN 1
           ELSE NULL
       END) AS "Targeted F Unknown age",
 count(CASE
           WHEN (Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)'
                 AND p.gender = 'F') THEN 1
           ELSE NULL
       END) AS "Female Subtotal",
 "" AS "Data Check"
FROM person p
INNER JOIN person_name pn ON pn.person_id = p.person_id
AND p.voided = 0
AND pn.voided = 0
INNER JOIN patient_identifier pi ON pi.patient_id = p.person_id
AND pi.voided = 0
INNER JOIN patient pt ON pt.patient_id = p.person_id
AND pi.voided = 0
INNER JOIN obs o ON o.person_id = p.person_id
AND o.voided = 0
INNER JOIN
  (SELECT max(o.obs_id) AS obs_id,
          o.date_created AS viralCreateddate,
          cv.concept_full_name AS "test_name"
   FROM person p
   INNER JOIN obs o ON o.person_id = p.person_id
   AND o.voided = 0
   INNER JOIN concept_view cv ON o.concept_id = cv.concept_id
   AND cv.retired = 0
   AND (cv.concept_full_name = 'CARGA VIRAL (Absoluto-Rotina)'
        OR cv.concept_full_name = 'CARGA VIRAL (Absoluto-Suspeita)')
   AND o.value_numeric < 1000
   AND (o.date_created >= DATE_SUB('#endDate#', INTERVAL 12 MONTH))
   GROUP BY p.person_id) AS Viralload ON Viralload.obs_id = o.obs_id
INNER JOIN person_attribute pa ON pa.person_id = p.person_id
AND pa.voided = 0
JOIN concept_view cv ON pa.value = cv.concept_id
AND cv.retired = 0
AND cv.concept_full_name = 'NEW_PATIENT'
INNER JOIN erpdrug_order erp ON erp.patient_id=pt.patient_id
AND (Viralload.viralCreateddate <= DATE_SUB(erp.dispensed_date, INTERVAL 3 MONTH))
WHERE erp.id =
    (SELECT max(id)
     FROM erpdrug_order
     WHERE erpdrug_order.dispensed=1
       AND erpdrug_order.arv_dispensed=1
       AND erpdrug_order.first_arv_dispensed=1
       AND erpdrug_order.patient_id=erp.patient_id);