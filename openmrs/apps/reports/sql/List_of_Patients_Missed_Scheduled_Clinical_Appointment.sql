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
  DATE_FORMAT(papResult1.start_date_time,'%d-%m-%Y') AS "Data da Última Consulta",
  DATE_FORMAT(papResult2.end_date_time,'%d-%m-%Y') AS "Data da Última Consulta Clínica Perdida"
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
    INNER JOIN (SELECT patient_id, appointment_service_id, start_date_time FROM patient_appointment pap1
                WHERE start_date_time = (SELECT MAX(start_date_time) FROM patient_appointment pap2
                                         WHERE appointment_service_id = 3 AND pap1.patient_id = pap2.patient_id)) papResult1
               ON p.person_id = papResult1.patient_id
                 AND CAST(papResult1.start_date_time AS DATE) BETWEEN '#startDate#' AND '#endDate#'
    INNER JOIN (SELECT patient_id, appointment_service_id, end_date_time FROM patient_appointment pap1
                WHERE end_date_time = (SELECT MAX(end_date_time) FROM patient_appointment pap2
                                       WHERE status = 'Missed'
                                         AND pap1.patient_id = pap2.patient_id)) papResult2
               ON p.person_id = papResult2.patient_id
                 AND CAST(papResult2.end_date_time AS DATE) BETWEEN '#startDate#' AND '#endDate#'

UNION

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
  DATE_FORMAT(v.date_started, '%d-%m-%Y') AS "Data da Última Consulta",
  DATE_FORMAT(v.date_stopped, '%d-%m-%Y') AS "Data da Última Consulta Clínica Perdida"
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
    INNER JOIN (SELECT visit_id, patient_id, date_started, date_stopped FROM visit v1
            WHERE date_started = (SELECT MAX(date_started) FROM visit v2
            WHERE date_stopped IS NOT NULL AND v1.patient_id = v2.patient_id)
              AND visit_id NOT IN (SELECT visit_id FROM encounter) AND date_stopped = (SELECT MAX(date_stopped) FROM visit v3 WHERE v3.patient_id = v1.patient_id)) v
               ON p.person_id = v.patient_id
                 AND CAST(v.date_started AS DATE) BETWEEN '#startDate#' AND '#endDate#'
                 AND CAST(v.date_stopped AS DATE) BETWEEN '#startDate#' AND '#endDate#'
UNION

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
  DATE_FORMAT(v.date_started, '%d-%m-%Y') AS "Data da Última Consulta",
  DATE_FORMAT(v.date_stopped, '%d-%m-%Y') AS "Data da Última Consulta Clínica Perdida"
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
    INNER JOIN (SELECT visit_id, patient_id, date_started, date_stopped FROM visit v1
            WHERE date_started = (SELECT MAX(date_started) FROM visit v2
            WHERE date_stopped IS NOT NULL AND v1.patient_id = v2.patient_id)
            AND date_stopped = (SELECT MAX(date_stopped) FROM visit v3 WHERE v3.patient_id = v1.patient_id)) v
               ON p.person_id = v.patient_id
                 AND CAST(v.date_started AS DATE) BETWEEN '#startDate#' AND '#endDate#'
                 AND CAST(v.date_stopped AS DATE) BETWEEN '#startDate#' AND '#endDate#'
    INNER JOIN (SELECT patient_id, encounter_type FROM encounter en WHERE en.encounter_type = (select encounter_type_id from encounter_type where name = 'REG')) enResult
    ON enResult.patient_id = p.person_id
;