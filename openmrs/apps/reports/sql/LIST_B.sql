SELECT pi.identifier as NID,CONCAT(COALESCE(pn.given_name,''),' ', COALESCE(pn.middle_name,''),' ',COALESCE(pn.family_name,'')) as "Nome Completo",TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) as "Idade", type_of_registration.registration_type AS "Tipo de Registo",
p.date_created as "Data de Registo", CONCAT('ACTIVO EM ',p_state.patient_status) as "Estado de Permanência",p_state.date_created as "Data do Estado de Permanência", p_status.patient_status as "Estado do Paciente", p_status.p_status_date as "Data do Estado do Paciente",
pfx_start_encs.pfx_start_date as "Data de Inicio da Profilaxia com Isoniazida", TB_encs.has_TB_symptoms as "Diagnostico de TB", diagnosis_encs.diagnosis_date as "Data do Diagnóstico de TB" from person p
join person_name pn  on p.person_id = pn.person_id
join patient_identifier pi on pi.patient_id = pn.person_id
join (SELECT person_id, cn.name as registration_type FROM person_attribute pa JOIN person_attribute_type pat on pa.person_attribute_type_id= pat.person_attribute_type_id JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND pat.name = "TYPE_OF_REGISTRATION") type_of_registration ON type_of_registration.person_id = p.person_id
JOIN (SELECT person_id, cn.name as patient_status, pa.date_created as p_status_date FROM person_attribute pa JOIN person_attribute_type pat on pa.person_attribute_type_id= pat.person_attribute_type_id JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND pat.name = "PATIENT_STATUS") p_status ON p_status.person_id= p.person_id
JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id)) p_state ON p_state.patient_id= p.person_id
LEFT JOIN
(SELECT * FROM (SELECT patient_id, encounter_datetime, encounter.encounter_id,TB_symptoms.symptoms_value as has_TB_symptoms FROM encounter JOIN obs on obs.encounter_id = encounter.encounter_id
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
         (SELECT name, concept_id FROM concept_name WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en')cn_symptoms ON cn_symptoms.concept_id = symptoms.value_coded) TB_symptoms on TB_symptoms.encounter_id = encounter.encounter_id GROUP BY encounter_id ORDER BY encounter_id desc) TB_encounters GROUP BY patient_id) TB_encs on TB_encs.patient_id = p.person_id
	LEFT JOIN
         (SELECT * FROM (SELECT patient_id, encounter_datetime, encounter.encounter_id,TB_diagnosis_date.diagnosis_date as diagnosis_date FROM encounter JOIN obs on obs.encounter_id = encounter.encounter_id
      JOIN
      (SELECT
		TB_diagnosis.obs_id,TB_diagnosis.encounter_id, TB_diagnosis.value_datetime as diagnosis_date
       FROM
       (SELECT value_text, value_numeric,value_coded, value_datetime, concept_name_type, name,locale,encounter_id,obs_id FROM obs JOIN concept_name c ON c.concept_id = obs.concept_id
       WHERE
       concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND name = 'Date of Diagnosis') TB_diagnosis) TB_diagnosis_date on TB_diagnosis_date.encounter_id = encounter.encounter_id GROUP BY encounter_id ORDER BY encounter_id desc) TB_diagnosis_encounters GROUP BY patient_id) diagnosis_encs on diagnosis_encs.patient_id = p.person_id


       LEFT JOIN
         (SELECT * FROM (SELECT patient_id, encounter_datetime, encounter.encounter_id,pfx_start_date.pfx_start_date as pfx_start_date FROM encounter JOIN obs on obs.encounter_id = encounter.encounter_id
      JOIN
      (SELECT
		pfx_start.obs_id,pfx_start.encounter_id, pfx_start.value_datetime as pfx_start_date
       FROM
       (SELECT value_text, value_numeric,value_coded, value_datetime, concept_name_type, name,locale,encounter_id,obs_id FROM obs JOIN concept_name c ON c.concept_id = obs.concept_id
       WHERE
       concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND name = 'Start_Date_Prophylaxis_INH') pfx_start) pfx_start_date on pfx_start_date.encounter_id = encounter.encounter_id GROUP BY encounter_id ORDER BY encounter_id desc) pfx_start_encounters GROUP BY patient_id) pfx_start_encs on pfx_start_encs.patient_id = p.person_id