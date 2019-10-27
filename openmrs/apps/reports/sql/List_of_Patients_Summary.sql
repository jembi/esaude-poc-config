select  distinct enc.identifier as NID, enc.full_name as Nome, enc.date_created as "Consulta Actual",appointment.next_consultation as "Próxima consulta", enc.age as "Idade",diastolic.value_numeric as "Tensão Arterial", pregnant as "Gravidez",breast_feeding_value as "Lactante",condom_value, weight.value_numeric as "Peso", bmi.value_numeric as "IMC", enc.encounter_id, modelos_diferenciados.modelos_diferenciados_list, mdc_elegibility.mdc_yes_no, modelos_diferenciados_estado.mdc_list_status, grupos_apoio_lista.suport_groups_list_coded, grupos_apoio_estado.sg_list_status
from (select identifier,person.person_id,full_name,date_created,TIMESTAMPDIFF(YEAR, person.birthdate, CURDATE()) as age, encounter_id,patient_id from encounter
inner join
(select identifier,concat(pn.given_name," ", COALESCE(pn.middle_name,'')," ", COALESCE(pn.family_name,'')) as full_name, pn.person_id, p.birthdate from person_name pn join patient_identifier pi on pn.person_id = pi.patient_id join person p on p.person_id = pn.person_id) person
on person_id=patient_id) enc
inner join obs on obs.encounter_id = enc.encounter_id

Left join
 (select value_text,value_numeric, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "BP_Diastolic_VSNormal") as diastolic on diastolic.encounter_id = obs.encounter_id

Left join
(SELECT
  DATE_FORMAT(start_date_time, "%d/%m/%Y") as next_consultation,
  p.person_id,
  pa.status
FROM
  patient_appointment pa
  JOIN person p ON p.person_id = pa.patient_id AND pa.voided IS FALSE
  JOIN appointment_service app_service
    ON app_service.appointment_service_id = pa.appointment_service_id AND app_service.voided IS FALSE
  LEFT JOIN provider prov ON prov.provider_id = pa.provider_id AND prov.retired IS FALSE
  LEFT JOIN person_name pn ON pn.person_id = prov.person_id AND pn.voided IS FALSE
  LEFT JOIN appointment_service_type app_service_type
    ON app_service_type.appointment_service_type_id = pa.appointment_service_type_id
WHERE start_date_time >= CURDATE() AND
      (app_service_type.voided IS FALSE OR app_service_type.voided IS NULL)
ORDER BY start_date_time desc limit 1) as appointment on appointment.person_id = enc.person_id

Left join
(select preg.obs_id,preg.encounter_id,
case
when
cn_pregnancy.name = "Pregnancy_Yes"
then 'SIM'
when
cn_pregnancy.name = "Pregnancy_No"
then 'NÃO'
end
as pregnant
 from (select value_text,value_numeric,value_coded, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "Pregnancy_Yes_No") preg
join (select name, concept_id from concept_name where concept_name_type = "FULLY_SPECIFIED" and locale = "en") cn_pregnancy on cn_pregnancy.concept_id = preg.value_coded) pregnancy_state on pregnancy_state.encounter_id = obs.encounter_id

Left join
(select breast_feeding.obs_id,breast_feeding.encounter_id,
case
when
cn_breast_feeding.name = "True"
then 'SIM'
when
cn_breast_feeding.name = "False"
then 'NÃO'
end
as breast_feeding_value
 from (select value_text,value_numeric,value_coded, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "Breastfeeding_ANA") breast_feeding
join (select name, concept_id from concept_name where concept_name_type = "FULLY_SPECIFIED" and locale = "en") cn_breast_feeding on cn_breast_feeding.concept_id = breast_feeding.value_coded) brestfeeding_state on brestfeeding_state.encounter_id = obs.encounter_id

Left Join
(select condom.obs_id,condom.encounter_id,
case
when
cn_condom.name = "Family_Planning_Contraceptive_Methods_PRES_Condom_button_Yes"
then 'SIM'
when
cn_condom.name = "Family_Planning_Contraceptive_Methods_PRES_Condom_button_No"
then 'NÃO'
end
as condom_value
 from (select value_text,value_numeric,value_coded, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "Family_Planning_Contraceptive_Methods_PRES_Condom_button") condom
join (select name, concept_id from concept_name where concept_name_type = "FULLY_SPECIFIED" and locale = "en") cn_condom on cn_condom.concept_id = condom.value_coded) condom_usage on condom_usage.encounter_id = obs.encounter_id

Left join
(select value_text,value_numeric, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "WEIGHT") weight on weight.encounter_id = obs.encounter_id

Left join
(select value_text,value_numeric, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "BMI") bmi on bmi.encounter_id = obs.encounter_id


LEFT JOIN
(SELECT GROUP_CONCAT(name SEPARATOR ', ') as modelos_diferenciados
FROM
      
	(SELECT obs_mdc.obs_id, obs_mdc.concept_id, obs_mdc.person_id, obs_mdc.value_coded
		FROM obs as obs_mdc
		WHERE obs_mdc.encounter_id = obs.encounter_id
	) mdc_obs
				
	JOIN
		(SELECT c_name_pt.concept_id, c_name_pt.name
			FROM concept_name AS c_name_pt
			WHERE c_name_pt.concept_id IN 
				(SELECT concept_id
					FROM concept_name
					WHERE name IN ("Reference_GA", "Reference_AF", "Reference_CA", "Reference_PU", "Reference_FR", "Reference_DT", "Reference_DC", "Reference_MDC_Other")
						AND concept_name_type = "FULLY_SPECIFIED"
						AND locale = "en"
						ORDER BY concept_id ASC)
				AND c_name_pt.concept_name_type = "SHORT"
                AND c_name_pt.locale = "pt"
		) mdc_shortname
		ON mdc_obs.concept_id = mdc_shortname.concept_id
) modelos_diferenciados_list

LEFT JOIN
(SELECT
	CASE
			WHEN mdc_obs.value_coded = 1 THEN "Sim"
			WHEN mdc_obs.value_coded = 2 THEN "Não"
	END AS mdc_yes_no
FROM
      
	(SELECT obs_mdc.obs_id, obs_mdc.concept_id, obs_mdc.person_id, obs_mdc.value_coded
		FROM obs as obs_mdc
		WHERE obs_mdc.encounter_id = obs.encounter_id
			AND obs_mdc.concept_id IN 
				(SELECT mdc_concept.concept_id
					FROM concept_name AS mdc_concept
					WHERE name IN ("Reference_Eligible")
						AND mdc_concept.concept_name_type = "FULLY_SPECIFIED"
						AND mdc_concept.locale = "en"
					ORDER BY mdc_concept.concept_id ASC)
	) AS mdc_obs
) mdc_elegibility

-- Lista de MDC seleccionados para o paciente e os seus estados
LEFT JOIN
(SELECT GROUP_CONCAT(mdc_result_status.mdc_list_with_states SEPARATOR ", ") AS mdc_list_status
FROM
	(SELECT CONCAT_WS(" - ", mdc_shortname.name, mdc_status.name) AS mdc_list_with_states
	FROM
		  
		(SELECT obs_mdc.obs_id, obs_mdc.concept_id, obs_mdc.person_id, obs_mdc.value_coded
			FROM obs as obs_mdc
			WHERE obs_mdc.encounter_id = obs.encounter_id
		) mdc_obs
					
		JOIN
			(SELECT c_name_pt.concept_id, c_name_pt.name
				FROM concept_name AS c_name_pt
				WHERE c_name_pt.concept_id IN 
					(SELECT concept_id
						FROM concept_name
						WHERE name IN ("Reference_GA", "Reference_AF", "Reference_CA", "Reference_PU", "Reference_FR", "Reference_DT", "Reference_DC", "Reference_MDC_Other")
							AND concept_name_type = "FULLY_SPECIFIED"
							AND locale = "en"
							ORDER BY concept_id ASC)
					AND c_name_pt.concept_name_type = "SHORT"
					AND c_name_pt.locale = "pt"
			) mdc_shortname
			ON mdc_obs.concept_id = mdc_shortname.concept_id
			
		JOIN
			(SELECT c_name_status.concept_id, c_name_status.name
				FROM concept_name AS c_name_status
				WHERE c_name_status.concept_id IN
					(SELECT concept_id
						FROM concept_name
						WHERE name IN ("Reference_Start", "Reference_In_Progress", "Reference_End")
							AND concept_name_type = "FULLY_SPECIFIED"
							AND locale = "en")
					AND c_name_status.concept_name_type = "SHORT"
					AND c_name_status.locale = "pt"
				) mdc_status
				ON mdc_status.concept_id = mdc_obs.value_coded
	) AS mdc_result_status
) modelos_diferenciados_estado

-- Lista de Grupos de Apoio
LEFT JOIN                   
(SELECT GROUP_CONCAT(name SEPARATOR ", ") AS suport_groups_list_coded
	FROM

		(SELECT sg_obs.obs_id, sg_obs.concept_id, sg_obs.person_id, sg_obs.value_coded
		FROM obs AS sg_obs
		WHERE sg_obs.encounter_id = enc.encounter_id
    ) as sg_obs
		
		JOIN
			(SELECT c_name_pt.concept_id, c_name_pt.name
				FROM concept_name AS c_name_pt
				WHERE c_name_pt.concept_id IN 
					(SELECT concept_id
						FROM concept_name
						WHERE name IN ("Reference_CR", "Reference_PC", "Reference_AR", "Reference_MPS") -- , "Reference_Other_Specify_Group_Other")
							AND concept_name_type = "FULLY_SPECIFIED"
							AND locale = "en"
							ORDER BY concept_id ASC)
					AND c_name_pt.concept_name_type = "SHORT"
					AND c_name_pt.locale = "pt"
			) sg_shortname
			ON sg_obs.concept_id = sg_shortname.concept_id
) grupos_apoio_lista

-- Lista de Grupos de Apoio com estado de progresso
LEFT JOIN
(SELECT GROUP_CONCAT(sg_result_status.sg_list_with_states SEPARATOR ", ") AS sg_list_status
FROM
(SELECT CONCAT_WS(" - ", sg_shortname.name, sg_status.name) AS sg_list_with_states
	FROM
		(SELECT sg_obs.obs_id, sg_obs.concept_id, sg_obs.person_id, sg_obs.value_coded
		FROM obs AS sg_obs
		WHERE sg_obs.person_id = 32942) as sg_obs
		
		JOIN
			(SELECT c_name_pt.concept_id, c_name_pt.name
				FROM concept_name AS c_name_pt
				WHERE c_name_pt.concept_id IN 
					(SELECT concept_id
						FROM concept_name
						WHERE name IN ("Reference_CR", "Reference_PC", "Reference_AR", "Reference_MPS") -- , "Reference_Other_Specify_Group_Other")
							AND concept_name_type = "FULLY_SPECIFIED"
							AND locale = "en"
							ORDER BY concept_id ASC)
					AND c_name_pt.concept_name_type = "SHORT"
					AND c_name_pt.locale = "pt"
			) sg_shortname
			ON sg_obs.concept_id = sg_shortname.concept_id
		
        JOIN
			(SELECT c_name_status.concept_id, c_name_status.name
				FROM concept_name AS c_name_status
				WHERE c_name_status.concept_id IN
					(SELECT concept_id
						FROM concept_name
						WHERE name IN ("Reference_Start", "Reference_In_Progress", "Reference_End")
							AND concept_name_type = "FULLY_SPECIFIED"
							AND locale = "en")
					AND c_name_status.concept_name_type = "SHORT"
					AND c_name_status.locale = "pt"
				) sg_status
				ON sg_status.concept_id = sg_obs.value_coded
) AS sg_result_status

) grupos_apoio_estado

order by enc.date_created desc;