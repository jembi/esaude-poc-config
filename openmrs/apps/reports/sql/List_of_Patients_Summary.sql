select  distinct enc.identifier as NID, enc.full_name as Nome, enc.date_created as "Consulta Actual",appointment.next_consultation as "Próxima consulta", enc.age as "Idade",diastolic.value_numeric as "Tensão Arterial", pregnant as "Gravidez",breast_feeding_value as "Lactante",condom_value, weight.value_numeric as "Peso", height.value_numeric as "Altura",bmi.value_numeric as "IMC", nutritional_eval as "Aval. Nutricional",odema.odemas_value as "Edema", enc.encounter_id  from (select identifier,person.person_id,full_name,date_created,TIMESTAMPDIFF(YEAR, person.birthdate, CURDATE()) as age, encounter_id,patient_id from encounter
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
(select value_text,value_numeric, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "HEIGHT") height on height.encounter_id = obs.encounter_id
Left join
(select value_text,value_numeric, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "BMI") bmi on bmi.encounter_id = obs.encounter_id
LEFT JOIN
(select nutritional_eval.obs_id,nutritional_eval.encounter_id,
case
when
cn_nutritional_eval.name = "CO_SAM"
then 'Desnutrição aguda grave'
when
cn_nutritional_eval.name = "CO_Normal"
then 'Normal'
when
cn_nutritional_eval.name = "CO_MAM"
then 'Desnutrição aguda moderada'
when
cn_nutritional_eval.name = "CO_LAM"
then 'Desnutrição aguda ligeira'
when
cn_nutritional_eval.name = "CO_Overweight"
then 'Sobrepeso'
when
cn_nutritional_eval.name = "CO_OneDO"
then 'Obesidade grau 1'
when
cn_nutritional_eval.name = "CO_TwoDO"
then 'Obesidade grau 2'
when
cn_nutritional_eval.name = "CO_ThreeDO"
then 'Obesidade grau 3'
when
cn_nutritional_eval.name = "CO_Obese"
then 'Obesidade'
end
as nutritional_eval
 from (select value_text,value_numeric,value_coded, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "Nutritional_States_new") nutritional_eval
join (select name, concept_id from concept_name where concept_name_type = "FULLY_SPECIFIED" and locale = "en") cn_nutritional_eval on cn_nutritional_eval.concept_id = nutritional_eval.value_coded) imc_eval on imc_eval.encounter_id = obs.encounter_id
Left Join
(select odemas.obs_id,odemas.encounter_id,
case
when
cn_odemas.name = "Infants Odema_O"
then 'O'
when
cn_odemas.name = "Infants Odema_+"
then '+'
when
cn_odemas.name = "Infants Odema_++"
then '++'
when
cn_odemas.name = "Infants Odema_+++"
then '+++'
end
as odemas_value
 from (select value_text,value_numeric,value_coded, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "Infants Odema_Prophylaxis") odemas
join (select name, concept_id from concept_name where concept_name_type = "FULLY_SPECIFIED" and locale = "en") cn_odemas on cn_odemas.concept_id = odemas.value_coded) odema on odema.encounter_id = obs.encounter_id;