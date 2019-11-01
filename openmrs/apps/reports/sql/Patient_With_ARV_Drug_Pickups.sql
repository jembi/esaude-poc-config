SELECT DISTINCT
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
  DATE_FORMAT(edo.dispensed_date,'%d-%m-%Y') AS "Data do Levantamento"

FROM
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
    inner join drug_order_relationship dor
    on dor.drug_order_id = do.order_id
    inner join concept_view  cv
    on cv.concept_id = dor.category_id
    AND cv.concept_full_name = 'Antirretrovirals'
    INNER JOIN concept_name cn
    ON cn.concept_id = ords.concept_id
      AND locale ='en'
    LEFT JOIN
    erpdrug_order edo
    ON edo.patient_id = ords.patient_id
;