SELECT * FROM (SELECT
               COUNT(CASE WHEN ((DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) THEN 1 ELSE NULL END) AS A11,
               COUNT(CASE WHEN ((DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) > 4 AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) < 10) THEN 1 ELSE NULL END) AS A12,
               COUNT(CASE WHEN ((DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 10 AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) < 15 AND p.gender = 'F') THEN 1 ELSE NULL END) AS A13,
               COUNT(CASE WHEN ((DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 10 AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) < 15 AND p.gender = 'M') THEN 1 ELSE NULL END) AS A14,
               COUNT(CASE WHEN ((DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 15 AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) < 20 AND p.gender = 'F') THEN 1 ELSE NULL END) AS A15,
               COUNT(CASE WHEN ((DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 15 AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) < 20 AND p.gender = 'M') THEN 1 ELSE NULL END) AS A16,
               COUNT(CASE WHEN ((DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20  AND p.gender = 'F') THEN 1 ELSE NULL END) AS A17,
               COUNT(CASE WHEN ((DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20  AND p.gender = 'M') THEN 1 ELSE NULL END) AS A18,
               COUNT(CASE WHEN ((DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) THEN 1 ELSE NULL END) AS A21,
               COUNT(CASE WHEN ((DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) > 4 AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) < 10) THEN 1 ELSE NULL END) AS A22,
               COUNT(CASE WHEN ((DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 10 AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) < 15 AND p.gender = 'F') THEN 1 ELSE NULL END) AS A23,
               COUNT(CASE WHEN ((DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 10 AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) < 15 AND p.gender = 'M') THEN 1 ELSE NULL END) AS A24,
               COUNT(CASE WHEN ((DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 15 AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) < 20 AND p.gender = 'F') THEN 1 ELSE NULL END) AS A25,
               COUNT(CASE WHEN ((DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 15 AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) < 20 AND p.gender = 'M') THEN 1 ELSE NULL END) AS A26,
               COUNT(CASE WHEN ((DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20  AND p.gender = 'F') THEN 1 ELSE NULL END) AS A27,
               COUNT(CASE WHEN ((DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20  AND p.gender = 'M') THEN 1 ELSE NULL END) AS A28
               FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
                 JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id) A

  JOIN
  (SELECT
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) THEN 1 ELSE NULL END) AS B11,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 5 AND 9) THEN 1 ELSE NULL END) AS B12,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'F') THEN 1 ELSE NULL END) AS B13,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'M') THEN 1 ELSE NULL END) AS B14,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'F') THEN 1 ELSE NULL END) AS B15,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'M') THEN 1 ELSE NULL END) AS B16,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND  p.gender = 'F') THEN 1 ELSE NULL END) AS B17,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND  p.gender = 'M') THEN 1 ELSE NULL END) AS B18
   FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
     JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id) B1

  JOIN
  (SELECT
           COUNT(CASE WHEN ((DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) THEN 1 ELSE NULL END) AS B21,
           COUNT(CASE WHEN ((DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 5 AND 9) THEN 1 ELSE NULL END) AS B22,
           COUNT(CASE WHEN ((DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'F') THEN 1 ELSE NULL END) AS B23,
           COUNT(CASE WHEN ((DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'M') THEN 1 ELSE NULL END) AS B24,
           COUNT(CASE WHEN ((DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'F') THEN 1 ELSE NULL END) AS B25,
           COUNT(CASE WHEN ((DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'M') THEN 1 ELSE NULL END) AS B26,
           COUNT(CASE WHEN ((DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND  p.gender = 'F') THEN 1 ELSE NULL END) AS B27,
           COUNT(CASE WHEN ((DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND  p.gender = 'M') THEN 1 ELSE NULL END) AS B28
   FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Tarv') p_status ON p_status.person_id= p.person_id
     JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'TRANSFERRED_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id) B2

  JOIN
  (SELECT
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) THEN 1 ELSE NULL END) AS B31,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 5 AND 9) THEN 1 ELSE NULL END) AS B32,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'F') THEN 1 ELSE NULL END) AS B33,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'M') THEN 1 ELSE NULL END) AS B34,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'F') THEN 1 ELSE NULL END) AS B35,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'M') THEN 1 ELSE NULL END) AS B36,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND  p.gender = 'F') THEN 1 ELSE NULL END) AS B37,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND  p.gender = 'M') THEN 1 ELSE NULL END) AS B38
   FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_RESTART') p_status ON p_status.patient_id= p.person_id
     JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id) B3

  JOIN
  (SELECT
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) THEN 1 ELSE NULL END) AS B51,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 5 AND 9) THEN 1 ELSE NULL END) AS B52,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'F') THEN 1 ELSE NULL END) AS B53,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'M') THEN 1 ELSE NULL END) AS B54,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'F') THEN 1 ELSE NULL END) AS B55,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'M') THEN 1 ELSE NULL END) AS B56,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND  p.gender = 'F') THEN 1 ELSE NULL END) AS B57,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND  p.gender = 'M') THEN 1 ELSE NULL END) AS B58
   FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_state = 'INACTIVE_TRANSFERRED_OUT') p_status ON p_status.patient_id= p.person_id) B5

  JOIN
  (SELECT
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) THEN 1 ELSE NULL END) AS B61,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 5 AND 9) THEN 1 ELSE NULL END) AS B62,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'F') THEN 1 ELSE NULL END) AS B63,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'M') THEN 1 ELSE NULL END) AS B64,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'F') THEN 1 ELSE NULL END) AS B65,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'M') THEN 1 ELSE NULL END) AS B66,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND  p.gender = 'F') THEN 1 ELSE NULL END) AS B67,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND  p.gender = 'M') THEN 1 ELSE NULL END) AS B68
   FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_TREATMENT_SUSPENDED') p_status ON p_status.patient_id= p.person_id) B6

  JOIN
  (SELECT
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) THEN 1 ELSE NULL END) AS B71,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 5 AND 9) THEN 1 ELSE NULL END) AS B72,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'F') THEN 1 ELSE NULL END) AS B73,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'M') THEN 1 ELSE NULL END) AS B74,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'F') THEN 1 ELSE NULL END) AS B75,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'M') THEN 1 ELSE NULL END) AS B76,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND  p.gender = 'F') THEN 1 ELSE NULL END) AS B77,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND  p.gender = 'M') THEN 1 ELSE NULL END) AS B78
   FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_ABANDONED') p_status ON p_status.patient_id= p.person_id) B7

  JOIN
  (SELECT
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) THEN 1 ELSE NULL END) AS B81,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 5 AND 9) THEN 1 ELSE NULL END) AS B82,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'F') THEN 1 ELSE NULL END) AS B83,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'M') THEN 1 ELSE NULL END) AS B84,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'F') THEN 1 ELSE NULL END) AS B85,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'M') THEN 1 ELSE NULL END) AS B86,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND  p.gender = 'F') THEN 1 ELSE NULL END) AS B87,
           COUNT(CASE WHEN ((DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND  p.gender = 'M') THEN 1 ELSE NULL END) AS B88
   FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_state = 'INACTIVE_DEATH') p_status ON p_status.patient_id= p.person_id) B8

  JOIN
  (SELECT
           COUNT(CASE WHEN ((DATE(erp_drugorder.dispensed_date) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) THEN 1 ELSE NULL END) AS B101,
           COUNT(CASE WHEN ((DATE(erp_drugorder.dispensed_date) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 5 AND 9) THEN 1 ELSE NULL END) AS B102,
           COUNT(CASE WHEN ((DATE(erp_drugorder.dispensed_date) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'F') THEN 1 ELSE NULL END) AS B103,
           COUNT(CASE WHEN ((DATE(erp_drugorder.dispensed_date) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'M') THEN 1 ELSE NULL END) AS B104,
           COUNT(CASE WHEN ((DATE(erp_drugorder.dispensed_date) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'F') THEN 1 ELSE NULL END) AS B105,
           COUNT(CASE WHEN ((DATE(erp_drugorder.dispensed_date) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'M') THEN 1 ELSE NULL END) AS B106,
           COUNT(CASE WHEN ((DATE(erp_drugorder.dispensed_date) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND  p.gender = 'F') THEN 1 ELSE NULL END) AS B107,
           COUNT(CASE WHEN ((DATE(erp_drugorder.dispensed_date) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND  p.gender = 'M') THEN 1 ELSE NULL END) AS B108
   FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
     JOIN (SELECT patient_id,dispensed_date from erpdrug_order WHERE id IN (SELECT MAX(id) FROM erpdrug_order GROUP BY patient_id)) erp_drugorder ON erp_drugorder.patient_id = p.person_id) B10

  JOIN
  (SELECT
           COUNT(CASE WHEN ((DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) THEN 1 ELSE NULL END) AS B121,
           COUNT(CASE WHEN ((DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 5 AND 9) THEN 1 ELSE NULL END) AS B122,
           COUNT(CASE WHEN ((DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'F') THEN 1 ELSE NULL END) AS B123,
           COUNT(CASE WHEN ((DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'M') THEN 1 ELSE NULL END) AS B124,
           COUNT(CASE WHEN ((DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'F') THEN 1 ELSE NULL END) AS B125,
           COUNT(CASE WHEN ((DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'M') THEN 1 ELSE NULL END) AS B126,
           COUNT(CASE WHEN ((DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND  p.gender = 'F') THEN 1 ELSE NULL END) AS B127,
           COUNT(CASE WHEN ((DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND  p.gender = 'M') THEN 1 ELSE NULL END) AS B128
   FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id) B12

  JOIN
  (SELECT COUNT(person_id) AS C1 FROM (SELECT p.person_id, p.gender, p.date_created as register_date  FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
    JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id) generic
    JOIN
    (SELECT * FROM (SELECT patient_id, encounter_datetime, encounter.encounter_id FROM encounter JOIN obs on obs.encounter_id = encounter.encounter_id
      JOIN
      (SELECT
                                                                                                                                         symptoms.obs_id,symptoms.encounter_id,
                                                                                                                                         CASE
                                                                                                                                         WHEN cn_symptoms.name = 'True' THEN 'SIM'
                                                                                                                                         WHEN cn_symptoms.name = 'False' THEN 'NÃO'
                                                                                                                                         END
                                                                                                                                         AS symptoms_value
      FROM
       (SELECT value_text, value_numeric,value_coded, concept_name_type, name,locale,encounter_id,obs_id FROM obs JOIN concept_name c ON c.concept_id = obs.concept_id
       WHERE
       concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND name = 'Has TB Symptoms') symptoms
         JOIN
         (SELECT name, concept_id FROM concept_name WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en')cn_symptoms ON cn_symptoms.concept_id = symptoms.value_coded) TB_symptoms on TB_symptoms.encounter_id = encounter.encounter_id GROUP BY encounter_id ORDER BY encounter_id desc) TB_encounters GROUP BY patient_id) encounters_TB on generic.person_id = encounters_TB.patient_id
    AND
    DATE(generic.register_date) BETWEEN '#startDate#' AND '#endDate#'
    AND
    DATE(encounters_TB.encounter_datetime) BETWEEN '#startDate#' AND '#endDate#') C1

  JOIN

  (SELECT COUNT(person_id) AS C2 FROM (SELECT p.person_id, p.gender, p.date_created as register_date  FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
    JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id) generic
    JOIN
    (SELECT * FROM (SELECT encounter.patient_id, prophilaxis_type.obs_id,prophilaxis_type.encounter_id,pfx_start_date.value_datetime as start_date_prophilaxis,pfx_end_date.value_datetime as end_date_prophilaxis, cn_prophilaxis_type.name AS type_of_pfx
                                                                                                                          FROM
                                                                                                                          (SELECT value_text,value_numeric,value_coded,concept_name_type, name,locale,obs.encounter_id,obs_id FROM obs
                                                                                                                            JOIN concept_name c ON c.concept_id = obs.concept_id WHERE concept_name_type = 'FULLY_SPECIFIED'
                                                                                                                          AND locale = 'en'
                                                                                                                          AND name = 'Type_Prophylaxis') prophilaxis_type
                                                                                                                            JOIN encounter on encounter.encounter_id = prophilaxis_type.encounter_id
                                                                                                                            JOIN (SELECT name, concept_id FROM concept_name WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en') cn_prophilaxis_type ON cn_prophilaxis_type.concept_id = prophilaxis_type.value_coded AND cn_prophilaxis_type.name = 'INH'
                                                                                                                            JOIN
                                                                                                                            (SELECT value_datetime, concept_name_type,name,locale,obs.encounter_id, obs_id FROM obs JOIN concept_name c ON c.concept_id = obs.concept_id
       WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND name = 'Start Date_Prophylaxis') pfx_start_date on pfx_start_date.encounter_id = prophilaxis_type.encounter_id
                                                                                                                            JOIN
                                                                                                                            (SELECT value_datetime, concept_name_type,name,locale,obs.encounter_id, obs_id FROM obs JOIN concept_name c ON c.concept_id = obs.concept_id
       WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND name = 'End Date') pfx_end_date on pfx_end_date.encounter_id = prophilaxis_type.encounter_id ORDER BY encounter_id DESC) gen_table GROUP BY patient_id) INH_encounters on INH_encounters.patient_id = generic.person_id
    AND
    DATE(generic.register_date) BETWEEN '#startDate#' AND '#endDate#'
    AND
    DATE(INH_encounters.start_date_prophilaxis) BETWEEN '#startDate#' AND '#endDate#'
  ) AS C2

  JOIN

  (SELECT COUNT(person_id) AS C3 FROM (SELECT p.person_id, p.gender, p.date_created as register_date  FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
    JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id) generic
    JOIN
    (SELECT * FROM (SELECT encounter.patient_id, has_TB_symptoms.obs_id,has_TB_symptoms.encounter_id,pfx_start_date.value_datetime as TB_diagnosis_date, cn_has_TB_symptoms.name AS has_tb_symptoms
                                                                                                                          FROM
                                                                                                                          (SELECT value_text,value_numeric,value_coded,concept_name_type, name,locale,obs.encounter_id,obs_id FROM obs
                                                                                                                            JOIN concept_name c ON c.concept_id = obs.concept_id WHERE concept_name_type = 'FULLY_SPECIFIED'
                                                                                                                          AND locale = 'en'
                                                                                                                          AND name = 'Has TB Symptoms') has_TB_symptoms
                                                                                                                            JOIN encounter on encounter.encounter_id = has_TB_symptoms.encounter_id
                                                                                                                            JOIN (SELECT name, concept_id FROM concept_name WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en') cn_has_TB_symptoms ON cn_has_TB_symptoms.concept_id = has_TB_symptoms.value_coded AND cn_has_TB_symptoms.name = 'True'
                                                                                                                            JOIN
                                                                                                                            (SELECT value_datetime, concept_name_type,name,locale,obs.encounter_id, obs_id FROM obs JOIN concept_name c ON c.concept_id = obs.concept_id
       WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND name = 'Date of Diagnosis') pfx_start_date on pfx_start_date.encounter_id = has_TB_symptoms.encounter_id
                                                                                                                          ORDER BY encounter_id DESC) gen_table GROUP BY patient_id
    ) TB_tab_encounters on TB_tab_encounters.patient_id = generic.person_id
    AND
    DATE(generic.register_date) BETWEEN '#startDate#' AND '#endDate#'
    AND
    DATE(TB_tab_encounters.TB_diagnosis_date) BETWEEN '#startDate#' AND '#endDate#'
  ) AS C3

  JOIN

  (SELECT COUNT(lab_orders.patient_id) AS E11 FROM (SELECT * FROM (SELECT orders.encounter_id, encounter.patient_id,encounter.encounter_datetime AS consultation_date,concept_name.name AS test_name FROM orders JOIN concept_name ON concept_name.concept_id = orders.concept_id AND concept_name.locale = 'en' AND concept_name.name = 'LO_ViralLoad'
    JOIN encounter ON encounter.encounter_id = orders.encounter_id ORDER BY encounter.encounter_id DESC) ords GROUP BY ords.patient_id) lab_orders
    JOIN
    (SELECT * FROM person p JOIN (SELECT patient_id,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id) tarv_patients on tarv_patients.person_id = lab_orders.patient_id
    AND DATE(lab_orders.consultation_date) BETWEEN '#startDate#' AND '#endDate#' AND TIMESTAMPDIFF(YEAR, tarv_patients.birthdate, CURDATE()) <= 14
    AND
    (SELECT COUNT(lab_orders.patient_id) FROM (SELECT * FROM (SELECT orders.encounter_id, encounter.patient_id,encounter.encounter_datetime AS consultation_date,concept_name.name AS test_name FROM orders JOIN concept_name ON concept_name.concept_id = orders.concept_id AND concept_name.locale = 'en' AND concept_name.name = 'LO_ViralLoad'
      JOIN encounter ON encounter.encounter_id = orders.encounter_id ORDER BY encounter.encounter_id DESC) ords GROUP BY ords.patient_id) lab_orders
      JOIN
      (SELECT * FROM person p JOIN (SELECT patient_id,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id) tarv_patients on tarv_patients.person_id = lab_orders.patient_id
      AND DATE(lab_orders.consultation_date) BETWEEN CONCAT((YEAR('#startDate#')-1),'-12-20') AND '#startDate#') = 0) AS E11

  JOIN

  (SELECT COUNT(lab_orders.patient_id) AS E12 FROM (SELECT * FROM (SELECT orders.encounter_id, encounter.patient_id,encounter.encounter_datetime AS consultation_date,concept_name.name AS test_name FROM orders JOIN concept_name ON concept_name.concept_id = orders.concept_id AND concept_name.locale = 'en' AND concept_name.name = 'LO_ViralLoad'
    JOIN encounter ON encounter.encounter_id = orders.encounter_id ORDER BY encounter.encounter_id DESC) ords GROUP BY ords.patient_id) lab_orders
    JOIN
    (SELECT * FROM person p JOIN (SELECT patient_id,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id) tarv_patients on tarv_patients.person_id = lab_orders.patient_id
    AND DATE(lab_orders.consultation_date) BETWEEN '#startDate#' AND '#endDate#' AND TIMESTAMPDIFF(YEAR, tarv_patients.birthdate, CURDATE()) >= 15
    AND
    (SELECT COUNT(lab_orders.patient_id) FROM (SELECT * FROM (SELECT orders.encounter_id, encounter.patient_id,encounter.encounter_datetime AS consultation_date,concept_name.name AS test_name FROM orders JOIN concept_name ON concept_name.concept_id = orders.concept_id AND concept_name.locale = 'en' AND concept_name.name = 'LO_ViralLoad'
      JOIN encounter ON encounter.encounter_id = orders.encounter_id ORDER BY encounter.encounter_id DESC) ords GROUP BY ords.patient_id) lab_orders
      JOIN
      (SELECT * FROM person p JOIN (SELECT patient_id,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id) tarv_patients on tarv_patients.person_id = lab_orders.patient_id
      AND DATE(lab_orders.consultation_date) BETWEEN CONCAT((YEAR('#startDate#')-1),'-12-20') AND '#startDate#') = 0) AS E12

  JOIN

  (SELECT COUNT(vl_results.patient_id) AS E21 FROM (SELECT observation.encounter_id, encounter.patient_id,encounter.encounter_datetime as consultation_date, observation.value_numeric, observation.concept_name_type,observation.name FROM (SELECT value_numeric, concept_name_type, name,locale, encounter_id, obs_id,obs.concept_id FROM obs
    JOIN concept_name c ON c.concept_id = obs.concept_id WHERE concept_name_type = 'FULLY_SPECIFIED'
  AND locale = 'en' AND name = 'LO_ViralLoad'  AND obs.value_numeric <> 0 ORDER BY encounter_id DESC) observation
    JOIN
    encounter ON encounter.encounter_id = observation.encounter_id GROUP BY patient_id) vl_results
    JOIN
    (SELECT * FROM person p JOIN (SELECT patient_id,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id) tarv_patients on tarv_patients.person_id = vl_results.patient_id
    AND DATE(vl_results.consultation_date) BETWEEN '#startDate#' AND '#endDate#' AND TIMESTAMPDIFF(YEAR, tarv_patients.birthdate, CURDATE()) <= 14
    AND
    (SELECT COUNT(vl_results.patient_id) FROM (SELECT observation.encounter_id, encounter.patient_id,encounter.encounter_datetime as consultation_date, observation.value_numeric, observation.concept_name_type,observation.name FROM (SELECT value_numeric, concept_name_type, name,locale, encounter_id, obs_id,obs.concept_id FROM obs
      JOIN concept_name c ON c.concept_id = obs.concept_id WHERE concept_name_type = 'FULLY_SPECIFIED'
    AND locale = 'en' AND name = 'LO_ViralLoad'  AND obs.value_numeric <> 0 ORDER BY encounter_id DESC) observation
      JOIN
      encounter ON encounter.encounter_id = observation.encounter_id GROUP BY patient_id) vl_results
      JOIN
      (SELECT * FROM person p JOIN (SELECT patient_id,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id) tarv_patients on tarv_patients.person_id = vl_results.patient_id
      AND DATE(vl_results.consultation_date) BETWEEN CONCAT((YEAR('#startDate#')-1),'-12-20') AND '#endDate#') = 0) AS E21

  JOIN

  (SELECT COUNT(vl_results.patient_id) AS E22 FROM (SELECT observation.encounter_id, encounter.patient_id,encounter.encounter_datetime as consultation_date, observation.value_numeric, observation.concept_name_type,observation.name FROM (SELECT value_numeric, concept_name_type, name,locale, encounter_id, obs_id,obs.concept_id FROM obs
    JOIN concept_name c ON c.concept_id = obs.concept_id WHERE concept_name_type = 'FULLY_SPECIFIED'
  AND locale = 'en' AND name = 'LO_ViralLoad'  AND obs.value_numeric <> 0 ORDER BY encounter_id DESC) observation
    JOIN
    encounter ON encounter.encounter_id = observation.encounter_id GROUP BY patient_id) vl_results
    JOIN
    (SELECT * FROM person p JOIN (SELECT patient_id,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id) tarv_patients on tarv_patients.person_id = vl_results.patient_id
    AND DATE(vl_results.consultation_date) BETWEEN '#startDate#' AND '#endDate#' AND TIMESTAMPDIFF(YEAR, tarv_patients.birthdate, CURDATE()) >= 15
    AND
    (SELECT COUNT(vl_results.patient_id) FROM (SELECT observation.encounter_id, encounter.patient_id,encounter.encounter_datetime as consultation_date, observation.value_numeric, observation.concept_name_type,observation.name FROM (SELECT value_numeric, concept_name_type, name,locale, encounter_id, obs_id,obs.concept_id FROM obs
      JOIN concept_name c ON c.concept_id = obs.concept_id WHERE concept_name_type = 'FULLY_SPECIFIED'
    AND locale = 'en' AND name = 'LO_ViralLoad'  AND obs.value_numeric <> 0 ORDER BY encounter_id DESC) observation
      JOIN
      encounter ON encounter.encounter_id = observation.encounter_id GROUP BY patient_id) vl_results
      JOIN
      (SELECT * FROM person p JOIN (SELECT patient_id,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id) tarv_patients on tarv_patients.person_id = vl_results.patient_id
      AND DATE(vl_results.consultation_date) BETWEEN CONCAT((YEAR('#startDate#')-1),'-12-20') AND '#startDate#') = 0) AS E22

  JOIN

  (SELECT COUNT(vl_results.patient_id) AS E31 FROM (SELECT observation.encounter_id, encounter.patient_id,encounter.encounter_datetime as consultation_date, observation.value_numeric, observation.concept_name_type,observation.name FROM (SELECT value_numeric, concept_name_type, name,locale, encounter_id, obs_id,obs.concept_id FROM obs
    JOIN concept_name c ON c.concept_id = obs.concept_id WHERE concept_name_type = 'FULLY_SPECIFIED'
  AND locale = 'en' AND name = 'LO_ViralLoad'  AND obs.value_numeric <> 0  AND obs.value_numeric < 1000 ORDER BY encounter_id DESC) observation
    JOIN
    encounter ON encounter.encounter_id = observation.encounter_id GROUP BY patient_id) vl_results
    JOIN
    (SELECT * FROM person p JOIN (SELECT patient_id,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id) tarv_patients on tarv_patients.person_id = vl_results.patient_id
    AND DATE(vl_results.consultation_date) BETWEEN '#startDate#' AND '#endDate#' AND TIMESTAMPDIFF(YEAR, tarv_patients.birthdate, CURDATE()) <= 14
    AND
    (SELECT COUNT(vl_results.patient_id) FROM (SELECT observation.encounter_id, encounter.patient_id,encounter.encounter_datetime as consultation_date, observation.value_numeric, observation.concept_name_type,observation.name FROM (SELECT value_numeric, concept_name_type, name,locale, encounter_id, obs_id,obs.concept_id FROM obs
      JOIN concept_name c ON c.concept_id = obs.concept_id WHERE concept_name_type = 'FULLY_SPECIFIED'
    AND locale = 'en' AND name = 'LO_ViralLoad'  AND obs.value_numeric <> 0 ORDER BY encounter_id DESC) observation
      JOIN
      encounter ON encounter.encounter_id = observation.encounter_id GROUP BY patient_id) vl_results
      JOIN
      (SELECT * FROM person p JOIN (SELECT patient_id,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id) tarv_patients on tarv_patients.person_id = vl_results.patient_id
      AND DATE(vl_results.consultation_date) BETWEEN CONCAT((YEAR('#startDate#')-1),'-12-20') AND '#endDate#') = 0) AS E31

  JOIN

  (SELECT COUNT(vl_results.patient_id) AS E32 FROM (SELECT observation.encounter_id, encounter.patient_id,encounter.encounter_datetime as consultation_date, observation.value_numeric, observation.concept_name_type,observation.name FROM (SELECT value_numeric, concept_name_type, name,locale, encounter_id, obs_id,obs.concept_id FROM obs
    JOIN concept_name c ON c.concept_id = obs.concept_id WHERE concept_name_type = 'FULLY_SPECIFIED'
  AND locale = 'en' AND name = 'LO_ViralLoad'  AND obs.value_numeric <> 0  AND obs.value_numeric < 1000 ORDER BY encounter_id DESC) observation
    JOIN
    encounter ON encounter.encounter_id = observation.encounter_id GROUP BY patient_id) vl_results
    JOIN
    (SELECT * FROM person p JOIN (SELECT patient_id,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id) tarv_patients on tarv_patients.person_id = vl_results.patient_id
    AND DATE(vl_results.consultation_date) BETWEEN '#startDate#' AND '#endDate#' AND TIMESTAMPDIFF(YEAR, tarv_patients.birthdate, CURDATE()) >= 15
    AND
    (SELECT COUNT(vl_results.patient_id) FROM (SELECT observation.encounter_id, encounter.patient_id,encounter.encounter_datetime as consultation_date, observation.value_numeric, observation.concept_name_type,observation.name FROM (SELECT value_numeric, concept_name_type, name,locale, encounter_id, obs_id,obs.concept_id FROM obs
      JOIN concept_name c ON c.concept_id = obs.concept_id WHERE concept_name_type = 'FULLY_SPECIFIED'
    AND locale = 'en' AND name = 'LO_ViralLoad'  AND obs.value_numeric <> 0 ORDER BY encounter_id DESC) observation
      JOIN
      encounter ON encounter.encounter_id = observation.encounter_id GROUP BY patient_id) vl_results
      JOIN
      (SELECT * FROM person p JOIN (SELECT patient_id,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id) tarv_patients on tarv_patients.person_id = vl_results.patient_id
      AND DATE(vl_results.consultation_date) BETWEEN CONCAT((YEAR('#startDate#')-1),'-12-20') AND '#endDate#') = 0) AS E32

  JOIN

  (SELECT COUNT(patient_id) AS F1 FROM (SELECT * FROM (SELECT patient_id, encounter_datetime, encounter_id FROM encounter WHERE encounter_type = 1 AND DATE(encounter_datetime) BETWEEN '#startDate#' AND '#endDate#' ORDER BY encounter_id DESC) enc GROUP BY patient_id) encs) AS F1

  JOIN

  (SELECT COUNT(patient_id) AS F2 FROM (SELECT patient_id FROM (SELECT * FROM (SELECT patient_id, encounter_datetime, encounter_id FROM encounter WHERE encounter_type = 1 AND DATE(encounter_datetime) BETWEEN '#startDate#' AND '#startDate#') enc
    JOIN
    (SELECT value_text, value_numeric,value_coded, concept_name_type, name,locale,obs.encounter_id as enc_id,obs_id FROM obs JOIN concept_name c ON c.concept_id = obs.concept_id
                                                                                                                           WHERE
                                                                                                                           concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND name = 'Has TB Symptoms') symptoms ON symptoms.enc_id = enc.encounter_id ORDER BY enc.encounter_id DESC) gen_table_TB GROUP BY patient_id) tb_gen_table

   WHERE

   (SELECT COUNT(patient_id) FROM (SELECT patient_id FROM (SELECT * FROM (SELECT patient_id, encounter_datetime, encounter_id FROM encounter WHERE encounter_type = 1 AND DATE(encounter_datetime) BETWEEN CONCAT((YEAR('#startDate#')-1),'-12-20') AND '#startDate#') enc
     JOIN
     (SELECT value_text, value_numeric,value_coded, concept_name_type, name,locale,obs.encounter_id as enc_id,obs_id FROM obs JOIN concept_name c ON c.concept_id = obs.concept_id
     WHERE
     concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND name = 'Has TB Symptoms') symptoms ON symptoms.enc_id = enc.encounter_id ORDER BY enc.encounter_id DESC) gen_table_TB GROUP BY patient_id) tb_gen_table) =0) AS F2

  JOIN
  (SELECT COUNT(patient_id) AS F3 FROM (SELECT patient_id FROM encounter WHERE encounter_type = 1 AND DATE (encounter_datetime) <= '#endDate#' AND (SELECT COUNT(patient_id) FROM encounter WHERE encounter_type = 1 AND DATE (encounter_datetime) BETWEEN CONCAT((YEAR('#startDate#')-1),'-12-20') AND '#startDate#') = 0 GROUP BY patient_id) encs) AS F3
  JOIN
  (SELECT REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(property_value,',',1),':',-1),'\"','') AS NID FROM global_property WHERE property = 'healthFacility.info' LIMIT 1) AS NID
  JOIN
  (SELECT REPLACE(REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(property_value,',',-1),':',-1),'\"',''),'}','') AS hf_name FROM global_property WHERE property = 'healthFacility.info' LIMIT 1) AS hf_name
  JOIN
  (SELECT YEAR('#startDate#') AS rep_year) AS rep_year
  JOIN
  (SELECT MONTHNAME('#startDate#') AS rep_month) AS rep_month
  JOIN
  (SELECT IFNULL((SELECT  name AS hf_district from address_hierarchy_entry WHERE address_hierarchy_entry_id = (select parent_id from address_hierarchy_entry join (SELECT REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(property_value,',',1),':',-1),'\"','') as nid FROM global_property WHERE property = 'healthFacility.info' LIMIT 1) NID_table ON address_hierarchy_entry.name Like CONCAT('%',SUBSTRING(NID_table.nid,2),'%'))),'--')AS hf_district) AS hf_district
  JOIN
  (SELECT IFNULL((SELECT address_hierarchy_entry.name AS hf_province FROM address_hierarchy_entry WHERE address_hierarchy_entry_id =(select parent_id from address_hierarchy_entry WHERE address_hierarchy_entry_id = (select parent_id from address_hierarchy_entry join (SELECT REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(property_value,',',1),':',-1),'\"','') as nid FROM global_property WHERE property = 'healthFacility.info' LIMIT 1) NID_table ON address_hierarchy_entry.name Like CONCAT('%',SUBSTRING(NID_table.nid,2),'%')))),'--') AS hf_province) AS hf_province;