SELECT DISTINCT
  (pi.identifier) AS "NID",
  CONCAT( pn.given_name, " ", COALESCE( pn.middle_name, '' ), " ", COALESCE( pn.family_name, '' ) ) AS "Nome Completo ",
  CASE
    WHEN
        p.gender = 'M'
      THEN
      'Masculino'
    WHEN
        p.gender = 'F'
      THEN
      'Feminino'
    WHEN
        p.gender = 'O'
      THEN
      'Outro'
    END
    AS "Sexo", TIMESTAMPDIFF( YEAR, p.birthdate, CURDATE() ) AS "Idade",
  personAttributesonRegistration.value AS "Contacto",
  paddress.state_province AS "Província",
  paddress.city_village AS "Distrito",
  paddress.address1 AS "Localidade/Bairro",
  paddress.address3 AS "Quarteirão",
  paddress.address4 AS "Avenida/Rua",
  paddress.address5 AS "Nº da Casa",
  paddress.postal_code AS "Perto De",
  cn.name AS "Estado do Paciente",
  CAST(pap.start_date_time AS DATE) AS "Data da Última Consulta",
  CAST(papp.end_date_time AS DATE) AS "Data da Última Consulta Clínica Perdida"
FROM
    person p
      INNER JOIN
      person_name pn
      ON pn.person_id = p.person_id
      INNER JOIN
      patient_identifier pi
      ON pi.patient_id = p.person_id
      LEFT JOIN
      person_attribute personAttributesonRegistration
      ON personAttributesonRegistration.person_id = p.person_id
      INNER JOIN
      person_attribute_type personAttributeTypeonRegistration
      ON personAttributesonRegistration.person_attribute_type_id = personAttributeTypeonRegistration.person_attribute_type_id
        AND personAttributeTypeonRegistration.name = 'PRIMARY_CONTACT_NUMBER_1'
      LEFT JOIN
      person_address paddress
      ON p.person_id = paddress.person_id
        AND paddress.voided is false
      LEFT JOIN
      person_attribute pa
      on pa.person_id = p.person_id
      INNER JOIN
      person_attribute_type pat
      ON pa.person_attribute_type_id = pat.person_attribute_type_id
        AND pat.name = 'PATIENT_STATUS'
      INNER JOIN
      concept_name cn
      ON pa.value = cn.concept_id
        AND cn.concept_name_type = 'FULLY_SPECIFIED'
      INNER JOIN (SELECT patient_appointment_id, appointment_service_id, patient_id, start_date_time FROM patient_appointment GROUP BY patient_id) pap
      ON p.person_id = pap.patient_id
      AND CAST(pap.start_date_time AS DATE) BETWEEN '#startDate#' AND '#endDate#'
      LEFT JOIN
      patient_appointment papp
      ON papp.patient_appointment_id = pap.patient_appointment_id
      AND papp.status = 'Missed'
      AND CAST(papp.end_date_time AS DATE) BETWEEN '#startDate#' AND '#endDate#'
;
