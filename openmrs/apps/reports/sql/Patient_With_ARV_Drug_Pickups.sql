SELECT DISTINCT
  @rownum:=(@rownum+1) AS "No",
  (pi.identifier) AS "NID",
  CONCAT( pn.given_name, " ", COALESCE( pn.middle_name, '' ), " ", COALESCE( pn.family_name, '' ) ) AS "Nome Completo ",
  cn.name AS "Medicamento ARV",
  CASE
  WHEN
  edo.dispensed_date IS NULL
  THEN
  'Não'
  ELSE
  'Sim'
END
AS "Levantou ARV (S/N)",
DATE_FORMAT(edo.dispensed_date,'%d-%m-%Y') AS "Data do Levantamento",
DATE_FORMAT(papp.start_date_time, '%d-%m-%Y') as "Data do Próximo Levantamento"
FROM
(SELECT @rownum:=0) as initialization,
person p
INNER JOIN
person_name pn
ON pn.person_id = p.person_id
INNER JOIN
patient_identifier pi
ON pi.patient_id = p.person_id
INNER JOIN
patient pt
on pt.patient_id = p.person_id
and pi.voided = 0
INNER JOIN
orders ords
ON ords.patient_id = pt.patient_id
inner join drug_order do
on do.order_id = ords.order_id
INNER JOIN concept_name cn
ON cn.concept_id = ords.concept_id
AND locale ='en'
INNER JOIN
erpdrug_order edo
ON edo.order_id = ords.order_id
and edo.dispensed=1
and edo.arv_dispensed=1
AND edo.dispensed_date IS NOT NULL
AND CAST(edo.dispensed_date AS DATE) BETWEEN '#startDate#' AND '#endDate#'
LEFT JOIN
patient_appointment papp
ON papp.patient_id = p.person_id
AND papp.appointment_service_id = 5
;
