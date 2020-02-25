SELECT pi.identifier as NID,CONCAT(COALESCE(pn.given_name,''),' ', COALESCE(pn.middle_name,''),' ',COALESCE(pn.family_name,'')) as "Nome Completo",TIMESTAMPDIFF(YEAR, p.birthdate, CURDATE()) as "Idade", type_of_registration.registration_type AS "Tipo de Registo",
p.date_created as "Data de Registo", CONCAT('ACTIVO EM ',p_state.patient_status) as "Estado de Permanência",p_state.date_created as "Data do Estado de Permanência", p_status.patient_status as "Estado do Paciente", p_status.p_status_date as "Data do Estado do Paciente",
 encounter.encounter_datetime as "Data da Consulta",lab_tests.lab_tests as "Tipo de Exame Laboratorial", lab_tests.lab_tests_date as "Data da Requisição do Exame Laboratorial", lab_results.res as "Resultado do Exame Laboratorial", lab_results.result_date as "Data do Resultado do Exame Laboratorial" from person p  
join person_name pn  on p.person_id = pn.person_id 
join patient_identifier pi on pi.patient_id = pn.person_id
join (SELECT person_id, cn.name as registration_type FROM person_attribute pa JOIN person_attribute_type pat on pa.person_attribute_type_id= pat.person_attribute_type_id JOIN concept_name cn ON cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND pat.name = "TYPE_OF_REGISTRATION") type_of_registration ON type_of_registration.person_id = p.person_id
JOIN (SELECT person_id, cn.name as patient_status, pa.date_created as p_status_date FROM person_attribute pa JOIN person_attribute_type pat on pa.person_attribute_type_id= pat.person_attribute_type_id JOIN concept_name cn on cn.concept_id = pa.value AND cn.locale="en" AND  cn.concept_name_type = "FULLY_SPECIFIED" AND pat.name = "PATIENT_STATUS") p_status ON p_status.person_id= p.person_id
JOIN (SELECT patient_id,date_created,patient_status FROM patient_status_state WHERE id IN (SELECT MAX(id) FROM patient_status_state GROUP BY patient_id)) p_state ON p_state.patient_id= p.person_id
LEFT JOIN encounter on encounter.patient_id = p.person_id and encounter_type <> 2
LEFT JOIN 
(SELECT
        concept_name_type,
            GROUP_CONCAT(name) AS lab_tests,
            locale,
            encounter_id,
            orders.concept_id,
            orders.date_created AS lab_tests_date
    FROM
        orders
    JOIN concept_name c ON c.concept_id = orders.concept_id
    WHERE
        concept_name_type = 'SHORT'
            AND locale = 'pt'
    GROUP BY encounter_id) lab_tests on lab_tests.encounter_id = encounter.encounter_id
LEFT JOIN
(SELECT
        GROUP_CONCAT(CONCAT(co_name.name, '-', value_numeric)) AS res,
            encounter_id,result_date
    FROM
        (SELECT
        value_numeric,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id,
            obs.concept_id,
            obs.date_created as result_date
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name IN ('LO_ViralLoad' , 'LO_CD4', 'LO_HB', 'LO_AST', 'LO_ALT', 'LO_ViralLoad', 'LO_GLYCEMIA(3.05-6.05mmol/L)', 'LO_AMILASE(600-1600/UL)', 'LO_CREATININE(4.2-132Hmol/L)', 'LO_Other')
            AND obs.value_numeric <> 0) res_table
    JOIN concept_name co_name ON co_name.concept_id = res_table.concept_id
        AND co_name.concept_name_type = 'SHORT'
        AND co_name.locale = 'pt'
    GROUP BY encounter_id) lab_results on lab_results.encounter_id = encounter.encounter_id

