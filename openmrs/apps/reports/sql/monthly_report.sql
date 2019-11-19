SELECT
(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) AS A11,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) > 4 AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) < 10) AS A12,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 10 AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) < 15 AND p.gender = 'F') AS A13,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 10 AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) < 15 AND p.gender = 'M') AS A14,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 15 AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) < 20 AND p.gender = 'F') AS A15,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 15 AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) < 20 AND p.gender = 'M') AS A16,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20  AND p.gender = 'F') AS A17,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) < '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20  AND p.gender = 'M') AS A18,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) AS A21,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 5 AND 9) AS A22,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'F') AS A23,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'M') AS A24,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'F') AS A25,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'M') AS A26,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) BETWEEN '#startDate#' AND '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND p.gender = 'F') AS A27,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND p.gender = 'F') AS A28,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) AS B11,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 5 AND 9) AS B12,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'F') AS B13,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'M') AS B14,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'F') AS B15,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'M') AS B16,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND  p.gender = 'F') AS B17,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND  p.gender = 'M') AS B18,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'TRANSFERRED_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) AS B21,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'TRANSFERRED_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 5 AND 9) AS B22,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'TRANSFERRED_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'F' ) AS B23,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'TRANSFERRED_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'M' ) AS B24,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'TRANSFERRED_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'F' ) AS B25,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'TRANSFERRED_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'M' ) AS B26,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'TRANSFERRED_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND p.gender = 'F' ) AS B27,

(SELECT count(p.person_id) AS "a-1" FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Tarv') p_status ON p_status.person_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'TRANSFERRED_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND p.gender = 'M' ) AS B28,


(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_RESTART') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) AS B31,


(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_RESTART') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 5 AND 9) AS B32,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_RESTART') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'F') AS B33,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_RESTART') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'M') AS B34,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_RESTART') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'F') AS B35,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_RESTART') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'M') AS B36,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_RESTART') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND p.gender = 'F') AS B37,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_RESTART') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'NEW_PATIENT') type_of_registration ON type_of_registration.person_id = p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND p.gender = 'M') AS B38,


(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_state = 'INACTIVE_TRANSFERRED_OUT') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) AS B51,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_state = 'INACTIVE_TRANSFERRED_OUT') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 5 AND 9) AS B52,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_state = 'INACTIVE_TRANSFERRED_OUT') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'F') AS B53,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_state = 'INACTIVE_TRANSFERRED_OUT') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'M') AS B54,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_state = 'INACTIVE_TRANSFERRED_OUT') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'F') AS B55,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_state = 'INACTIVE_TRANSFERRED_OUT') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'M') AS B56,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_state = 'INACTIVE_TRANSFERRED_OUT') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND p.gender = 'F') AS B57,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_state = 'INACTIVE_TRANSFERRED_OUT') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND p.gender = 'M') AS B58,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_TREATMENT_SUSPENDED') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) AS B61,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_TREATMENT_SUSPENDED') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 5 AND 9) AS B62,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_TREATMENT_SUSPENDED') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender='F') AS B63,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_TREATMENT_SUSPENDED') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender='M') AS B64,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_TREATMENT_SUSPENDED') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender='F') AS B65,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_TREATMENT_SUSPENDED') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender='M') AS B66,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_TREATMENT_SUSPENDED') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND p.gender='F') AS B67,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_TREATMENT_SUSPENDED') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND p.gender='M') AS B68,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_ABANDONED') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) AS B71,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_ABANDONED') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 5 AND 9) AS B72,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_ABANDONED') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'F') AS B73,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_ABANDONED') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'M') AS B74,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_ABANDONED') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'F') AS B75,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_ABANDONED') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'M') AS B76,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_ABANDONED') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND p.gender = 'F') AS B77,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV_ABANDONED') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND p.gender = 'M') AS B78,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_state = 'INACTIVE_DEATH') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) AS B81,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_state = 'INACTIVE_DEATH') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 5 AND 9) AS B82,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_state = 'INACTIVE_DEATH') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'F') AS B83,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_state = 'INACTIVE_DEATH') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'M') AS B84,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_state = 'INACTIVE_DEATH') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'F') AS B85,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_state = 'INACTIVE_DEATH') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'M') AS B86,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_state = 'INACTIVE_DEATH') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND p.gender = 'F') AS B87,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_state = 'INACTIVE_DEATH') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p_status.date_created) BETWEEN '#startDate#' AND '#endDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND p.gender = 'M') AS B88,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT patient_id,dispensed_date from erpdrug_order WHERE id IN (SELECT MAX(id) FROM erpdrug_order GROUP BY patient_id)) erp_drugorder ON erp_drugorder.patient_id = p.person_id
AND  (DATE(erp_drugorder.dispensed_date) <  '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) AS B101,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT patient_id,dispensed_date from erpdrug_order WHERE id IN (SELECT MAX(id) FROM erpdrug_order GROUP BY patient_id)) erp_drugorder ON erp_drugorder.patient_id = p.person_id
AND  (DATE(erp_drugorder.dispensed_date) <  '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 5 AND 9) AS B102,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT patient_id,dispensed_date from erpdrug_order WHERE id IN (SELECT MAX(id) FROM erpdrug_order GROUP BY patient_id)) erp_drugorder ON erp_drugorder.patient_id = p.person_id
AND  (DATE(erp_drugorder.dispensed_date) <  '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'F') AS B103,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT patient_id,dispensed_date from erpdrug_order WHERE id IN (SELECT MAX(id) FROM erpdrug_order GROUP BY patient_id)) erp_drugorder ON erp_drugorder.patient_id = p.person_id
AND  (DATE(erp_drugorder.dispensed_date) <  '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14 AND p.gender = 'M') AS B104,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT patient_id,dispensed_date from erpdrug_order WHERE id IN (SELECT MAX(id) FROM erpdrug_order GROUP BY patient_id)) erp_drugorder ON erp_drugorder.patient_id = p.person_id
AND  (DATE(erp_drugorder.dispensed_date) <  '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'F') AS B105,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT patient_id,dispensed_date from erpdrug_order WHERE id IN (SELECT MAX(id) FROM erpdrug_order GROUP BY patient_id)) erp_drugorder ON erp_drugorder.patient_id = p.person_id
AND  (DATE(erp_drugorder.dispensed_date) <  '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19 AND p.gender = 'M') AS B106,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT patient_id,dispensed_date from erpdrug_order WHERE id IN (SELECT MAX(id) FROM erpdrug_order GROUP BY patient_id)) erp_drugorder ON erp_drugorder.patient_id = p.person_id
AND  (DATE(erp_drugorder.dispensed_date) <  '2019-11-31') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND p.gender = 'F') AS B107,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
JOIN (SELECT patient_id,dispensed_date from erpdrug_order WHERE id IN (SELECT MAX(id) FROM erpdrug_order GROUP BY patient_id)) erp_drugorder ON erp_drugorder.patient_id = p.person_id
AND  (DATE(erp_drugorder.dispensed_date) <  '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND p.gender = 'M') AS B108,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p.date_created) <  '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) <= 4) AS B121,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p.date_created) <  '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 5 AND 9) AS B122,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p.date_created) <  '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14  AND p.gender = 'F') AS B123,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p.date_created) <  '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14  AND p.gender = 'M') AS B124,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p.date_created) <  '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 10 AND 14  AND p.gender = 'F') AS B125,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p.date_created) <  '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) BETWEEN 15 AND 19  AND p.gender = 'M') AS B126,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p.date_created) <  '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND p.gender = 'F') AS B127,

(SELECT count(p.person_id) AS "b-1" FROM person p JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id
AND  (DATE(p.date_created) <  '#startDate#') AND TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) >= 20 AND p.gender = 'M') AS B128,

(SELECT COUNT(person_id) FROM (SELECT p.person_id, p.gender, p.date_created as register_date  FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
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
       DATE(encounters_TB.encounter_datetime) BETWEEN '#startDate#' AND '#endDate#') AS C1 ,

(SELECT COUNT(person_id) FROM (SELECT p.person_id, p.gender, p.date_created as register_date  FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
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
) AS C2,

(SELECT COUNT(person_id) FROM (SELECT p.person_id, p.gender, p.date_created as register_date  FROM person p JOIN (SELECT person_id, cn.name FROM person_attribute pa JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND cn.name = 'Pre Tarv') p_status ON p_status.person_id= p.person_id
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
) AS C3,

(SELECT COUNT(lab_orders.patient_id) FROM (SELECT * FROM (SELECT orders.encounter_id, encounter.patient_id,encounter.encounter_datetime AS consultation_date,concept_name.name AS test_name FROM orders JOIN concept_name ON concept_name.concept_id = orders.concept_id AND concept_name.locale = 'en' AND concept_name.name = 'LO_ViralLoad'
JOIN encounter ON encounter.encounter_id = orders.encounter_id ORDER BY encounter.encounter_id DESC) ords GROUP BY ords.patient_id) lab_orders
JOIN
(SELECT * FROM person p JOIN (SELECT patient_id,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id) tarv_patients on tarv_patients.person_id = lab_orders.patient_id
AND DATE(lab_orders.consultation_date) BETWEEN '#startDate#' AND '#endDate#' AND TIMESTAMPDIFF(YEAR, tarv_patients.birthdate, CURDATE()) <= 14
AND
(SELECT COUNT(lab_orders.patient_id) FROM (SELECT * FROM (SELECT orders.encounter_id, encounter.patient_id,encounter.encounter_datetime AS consultation_date,concept_name.name AS test_name FROM orders JOIN concept_name ON concept_name.concept_id = orders.concept_id AND concept_name.locale = 'en' AND concept_name.name = 'LO_ViralLoad'
JOIN encounter ON encounter.encounter_id = orders.encounter_id ORDER BY encounter.encounter_id DESC) ords GROUP BY ords.patient_id) lab_orders
JOIN
(SELECT * FROM person p JOIN (SELECT patient_id,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id) tarv_patients on tarv_patients.person_id = lab_orders.patient_id
AND DATE(lab_orders.consultation_date) BETWEEN CONCAT((YEAR('#startDate#')-1),'-12-20') AND '#startDate#') = 0) AS E11,


(SELECT COUNT(lab_orders.patient_id) FROM (SELECT * FROM (SELECT orders.encounter_id, encounter.patient_id,encounter.encounter_datetime AS consultation_date,concept_name.name AS test_name FROM orders JOIN concept_name ON concept_name.concept_id = orders.concept_id AND concept_name.locale = 'en' AND concept_name.name = 'LO_ViralLoad'
JOIN encounter ON encounter.encounter_id = orders.encounter_id ORDER BY encounter.encounter_id DESC) ords GROUP BY ords.patient_id) lab_orders
JOIN
(SELECT * FROM person p JOIN (SELECT patient_id,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id) tarv_patients on tarv_patients.person_id = lab_orders.patient_id
AND DATE(lab_orders.consultation_date) BETWEEN '#startDate#' AND '#endDate#' AND TIMESTAMPDIFF(YEAR, tarv_patients.birthdate, CURDATE()) >= 15
AND
(SELECT COUNT(lab_orders.patient_id) FROM (SELECT * FROM (SELECT orders.encounter_id, encounter.patient_id,encounter.encounter_datetime AS consultation_date,concept_name.name AS test_name FROM orders JOIN concept_name ON concept_name.concept_id = orders.concept_id AND concept_name.locale = 'en' AND concept_name.name = 'LO_ViralLoad'
JOIN encounter ON encounter.encounter_id = orders.encounter_id ORDER BY encounter.encounter_id DESC) ords GROUP BY ords.patient_id) lab_orders
JOIN
(SELECT * FROM person p JOIN (SELECT patient_id,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id) AND patient_status = 'TARV') p_status ON p_status.patient_id= p.person_id) tarv_patients on tarv_patients.person_id = lab_orders.patient_id
AND DATE(lab_orders.consultation_date) BETWEEN CONCAT((YEAR('#startDate#')-1),'-12-20') AND '#startDate#') = 0) AS E12,


(SELECT COUNT(vl_results.patient_id) FROM (SELECT observation.encounter_id, encounter.patient_id,encounter.encounter_datetime as consultation_date, observation.value_numeric, observation.concept_name_type,observation.name FROM (SELECT value_numeric, concept_name_type, name,locale, encounter_id, obs_id,obs.concept_id FROM obs
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
AND DATE(vl_results.consultation_date) BETWEEN CONCAT((YEAR('#startDate#')-1),'-12-20') AND '#endDate#') = 0) AS E21,



(SELECT COUNT(vl_results.patient_id) FROM (SELECT observation.encounter_id, encounter.patient_id,encounter.encounter_datetime as consultation_date, observation.value_numeric, observation.concept_name_type,observation.name FROM (SELECT value_numeric, concept_name_type, name,locale, encounter_id, obs_id,obs.concept_id FROM obs
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
AND DATE(vl_results.consultation_date) BETWEEN CONCAT((YEAR('#startDate#')-1),'-12-20') AND '#startDate#') = 0) AS E22,



(SELECT COUNT(vl_results.patient_id) FROM (SELECT observation.encounter_id, encounter.patient_id,encounter.encounter_datetime as consultation_date, observation.value_numeric, observation.concept_name_type,observation.name FROM (SELECT value_numeric, concept_name_type, name,locale, encounter_id, obs_id,obs.concept_id FROM obs
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
AND DATE(vl_results.consultation_date) BETWEEN CONCAT((YEAR('#startDate#')-1),'-12-20') AND '#endDate#') = 0) AS E31,


(SELECT COUNT(vl_results.patient_id) FROM (SELECT observation.encounter_id, encounter.patient_id,encounter.encounter_datetime as consultation_date, observation.value_numeric, observation.concept_name_type,observation.name FROM (SELECT value_numeric, concept_name_type, name,locale, encounter_id, obs_id,obs.concept_id FROM obs
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
AND DATE(vl_results.consultation_date) BETWEEN CONCAT((YEAR('#startDate#')-1),'-12-20') AND '#endDate#') = 0) AS E32,


(SELECT COUNT(patient_id) FROM (SELECT * FROM (SELECT patient_id, encounter_datetime, encounter_id FROM encounter WHERE encounter_type = 1 AND DATE(encounter_datetime) BETWEEN '#startDate#' AND '#endDate#' ORDER BY encounter_id DESC) enc GROUP BY patient_id) encs) AS F1,

(
SELECT COUNT(patient_id) FROM (SELECT patient_id FROM (SELECT * FROM (SELECT patient_id, encounter_datetime, encounter_id FROM encounter WHERE encounter_type = 1 AND DATE(encounter_datetime) BETWEEN '#startDate#' AND '#startDate#') enc
JOIN
(SELECT value_text, value_numeric,value_coded, concept_name_type, name,locale,obs.encounter_id as enc_id,obs_id FROM obs JOIN concept_name c ON c.concept_id = obs.concept_id
        WHERE
        concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND name = 'Has TB Symptoms') symptoms ON symptoms.enc_id = enc.encounter_id ORDER BY enc.encounter_id DESC) gen_table_TB GROUP BY patient_id) tb_gen_table

        WHERE

        (SELECT COUNT(patient_id) FROM (SELECT patient_id FROM (SELECT * FROM (SELECT patient_id, encounter_datetime, encounter_id FROM encounter WHERE encounter_type = 1 AND DATE(encounter_datetime) BETWEEN CONCAT((YEAR('#startDate#')-1),'-12-20') AND '#startDate#') enc
JOIN
(SELECT value_text, value_numeric,value_coded, concept_name_type, name,locale,obs.encounter_id as enc_id,obs_id FROM obs JOIN concept_name c ON c.concept_id = obs.concept_id
        WHERE
        concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND name = 'Has TB Symptoms') symptoms ON symptoms.enc_id = enc.encounter_id ORDER BY enc.encounter_id DESC) gen_table_TB GROUP BY patient_id) tb_gen_table) =0) AS F2,

(SELECT COUNT(patient_id) FROM (SELECT patient_id FROM encounter WHERE encounter_type = 1 AND DATE (encounter_datetime) <= '#endDate#' AND (SELECT COUNT(patient_id) FROM encounter WHERE encounter_type = 1 AND DATE (encounter_datetime) BETWEEN CONCAT((YEAR('#startDate#')-1),'-12-20') AND '#startDate#') = 0 GROUP BY patient_id) encs) AS F3,

(SELECT REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(property_value,',',1),':',-1),'\"','')FROM global_property WHERE property = 'healthFacility.info' LIMIT 1) AS NID,
(SELECT REPLACE(REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(property_value,',',-1),':',-1),'\"',''),'}','')FROM global_property WHERE property = 'healthFacility.info' LIMIT 1) AS hf_name,
(SELECT YEAR('#startDate#')) AS rep_year,
(SELECT MONTHNAME('#startDate#')) AS rep_month,
(select  name from address_hierarchy_entry WHERE address_hierarchy_entry_id = (select parent_id from address_hierarchy_entry join (SELECT REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(property_value,',',1),':',-1),'\"','') as nid FROM global_property WHERE property = 'healthFacility.info' LIMIT 1) NID_table ON address_hierarchy_entry.name Like CONCAT('%',NID_table.nid,'%'))) AS hf_district,
(SELECT address_hierarchy_entry.name FROM address_hierarchy_entry WHERE address_hierarchy_entry_id =(select parent_id from address_hierarchy_entry WHERE address_hierarchy_entry_id = (select parent_id from address_hierarchy_entry join (SELECT REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(property_value,',',1),':',-1),'\"','') as nid FROM global_property WHERE property = 'healthFacility.info' LIMIT 1) NID_table ON address_hierarchy_entry.name Like CONCAT('%',NID_table.nid,'%')))) AS hf_province;


