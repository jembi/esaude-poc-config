select  distinct enc.identifier as NID, enc.full_name as Nome, enc.date_created as "Cons. Actual",appointment.next_consultation as "Próx. Cons", enc.age as "Idade",diastolic.value_numeric as "T. Art", pregnant as "Gravidez",breast_feeding_value as "Lact",condom_value, weight.value_numeric as "Peso",
height.value_numeric as "Alt",bperimeter.value_numeric as "PB",bmi.value_numeric as "IMC", nutritional_eval as "Aval. Nut",odema.odemas_value as "Edema",nutritional_education.received as "Ed. Nut", nutritional_supplement.supplement as "Supl", suppl_quant.value_numeric as "Supl. Quant",has_symptoms.symptoms_value as "Tem Sintomas",
symptoms_list.symptoms as "Sintomas",date_of_diagnosis.value_datetime as "Data Diag. TB",date_of_TB_start.value_datetime,date_of_TB_start.value_datetime,state_of_TB.state,type_of_prophilaxis.type_of_pfx,state_of_prophylaxis.state,sec_efects.has_sec_efects as SEF_INH,sec_efects_ctz.has_sec_efects_ctz as SEF_CTZ, enc.encounter_id
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
LEFT JOIN
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
LEFT JOIN
(select value_text,value_numeric, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "WEIGHT") weight on weight.encounter_id = obs.encounter_id
LEFT JOIN
(select value_text,value_numeric, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "HEIGHT") height on height.encounter_id = obs.encounter_id
LEFT JOIN
(select value_text,value_numeric, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "BMI") bmi on bmi.encounter_id = obs.encounter_id
LEFT JOIN
(select value_text,value_numeric, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "Brachial_perimeter_new") bperimeter on bperimeter.encounter_id = obs.encounter_id
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
join (select name, concept_id from concept_name where concept_name_type = "FULLY_SPECIFIED" and locale = "en") cn_odemas on cn_odemas.concept_id = odemas.value_coded) odema on odema.encounter_id = obs.encounter_id
LEFT JOIN
(select nutritional_education.obs_id,nutritional_education.encounter_id,
case
when
cn_nutritional_education.name = "True"
then 'SIM'
when
cn_nutritional_education.name = "False"
then 'NÃO'
end
as received
 from (select value_text,value_numeric,value_coded, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "Received nutritional education") nutritional_education
join (select name, concept_id from concept_name where concept_name_type = "FULLY_SPECIFIED" and locale = "en") cn_nutritional_education on cn_nutritional_education.concept_id = nutritional_education.value_coded) nutritional_education on nutritional_education.encounter_id = obs.encounter_id
LEFT JOIN
(select nutrition_supplement.obs_id,nutrition_supplement.encounter_id,
case
when
cn_nutrition_supplement.name = "Soya__Prophylaxis"
then 'Soja'
when
cn_nutrition_supplement.name = "ATPUS__Prophylaxis"
then 'ATPUS'
when
cn_nutrition_supplement.name = "Other__Prophylaxis"
then 'Outro'
end
as supplement
 from (select value_text,value_numeric,value_coded, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "Nutrition Supplement") nutrition_supplement
join (select name, concept_id from concept_name where concept_name_type = "FULLY_SPECIFIED" and locale = "en") cn_nutrition_supplement on cn_nutrition_supplement.concept_id = nutrition_supplement.value_coded) nutritional_supplement on nutritional_supplement.encounter_id = obs.encounter_id
LEFT JOIN
 (select value_text,value_numeric, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "BP_Diastolic_VSNormal") as suppl_quant on suppl_quant.encounter_id = obs.encounter_id
 Left join
(select symptoms.obs_id,symptoms.encounter_id,
case
when
cn_symptoms.name = "True"
then 'SIM'
when
cn_symptoms.name = "False"
then 'NÃO'
end
as symptoms_value
 from (select value_text,value_numeric,value_coded, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "Breastfeeding_ANA") symptoms
join (select name, concept_id from concept_name where concept_name_type = "FULLY_SPECIFIED" and locale = "en") cn_symptoms on cn_symptoms.concept_id = symptoms.value_coded) has_symptoms on has_symptoms.encounter_id = obs.encounter_id
LEFT JOIN
(select encounter_id, GROUP_CONCAT(supplement) as symptoms from (select symptomslist.obs_id,symptomslist.encounter_id,
case
when
cn_symptomslist.name = "Fever_PL"
then 'Febre'
when
cn_symptomslist.name = "Recent weight loss"
then 'Emagrecimento Recente'
when
cn_symptomslist.name = "Cough with blood_Prophylaxis"
then 'Tosse com Sangue'
when
cn_symptomslist.name = "Cough without blood_Prophylaxis"
then 'Tosse sem Sangue'
when
cn_symptomslist.name = "Asthenia"
then 'Astenia'
when
cn_symptomslist.name = "Recent contact with Tuberculosis"
then 'Contacto Recente com TB'
end
as supplement
 from (select value_text,value_numeric,value_coded, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "Symptoms Prophylaxis_New") symptomslist
join (select name, concept_id from concept_name where concept_name_type = "FULLY_SPECIFIED" and locale = "en") cn_symptomslist on cn_symptomslist.concept_id = symptomslist.value_coded) list_of_symptoms group by encounter_id) symptoms_list on symptoms_list.encounter_id = obs.encounter_id
LEFT JOIN
 (select value_datetime,concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "Date of Diagnosis") as date_of_diagnosis on date_of_diagnosis.encounter_id = obs.encounter_id
 LEFT JOIN
 (select value_datetime,concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "SP_Treatment Start Date") as date_of_TB_start on date_of_TB_start.encounter_id = obs.encounter_id
  LEFT JOIN
 (select value_datetime,concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "SP_Treatment End Date") as date_of_TB_end on date_of_TB_end.encounter_id = obs.encounter_id
LEFT JOIN
 (select TB_state.obs_id,TB_state.encounter_id,
case
when
cn_TB_state.name = "Start_SP"
then 'Início'
when
cn_TB_state.name = "Em Curso"
then 'Em curso'
when
cn_TB_state.name = "End"
then 'Fim'
end
as state
 from (select value_text,value_numeric,value_coded, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "SP_Treatment State") TB_state
join (select name, concept_id from concept_name where concept_name_type = "FULLY_SPECIFIED" and locale = "en") cn_TB_state on cn_TB_state.concept_id = TB_state.value_coded) state_of_TB on state_of_TB.encounter_id = obs.encounter_id

LEFT JOIN
 (select prophilaxis_type.obs_id,prophilaxis_type.encounter_id,cn_prophilaxis_type.name as type_of_pfx
 from (select value_text,value_numeric,value_coded, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "Type_Prophylaxis") prophilaxis_type
join (select name, concept_id from concept_name where concept_name_type = "FULLY_SPECIFIED" and locale = "en") cn_prophilaxis_type on cn_prophilaxis_type.concept_id = prophilaxis_type.value_coded) type_of_prophilaxis on type_of_prophilaxis.encounter_id = obs.encounter_id

LEFT JOIN
 (select prophylaxis_state.obs_id,prophylaxis_state.encounter_id,
case
when
cn_prophylaxis_state.name = "Inicio_Prophylaxis"
then 'Início'
when
cn_prophylaxis_state.name = "Em Curso_Prophylaxis"
then 'Em curso'
when
cn_prophylaxis_state.name = "Fim_Prophylaxis"
then 'Fim'
end
as state
 from (select value_text,value_numeric,value_coded, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "SP_Side_Effects_INH") prophylaxis_state
join (select name, concept_id from concept_name where concept_name_type = "FULLY_SPECIFIED" and locale = "en") cn_prophylaxis_state on cn_prophylaxis_state.concept_id = prophylaxis_state.value_coded) state_of_prophylaxis on state_of_prophylaxis.encounter_id = obs.encounter_id
LEFT JOIN
(select secondary_efects.obs_id,secondary_efects.encounter_id,
case
when
cn_secondary_efects.name = "True"
then 'SIM'
when
cn_secondary_efects.name = "False"
then 'NÃO'
end
as has_sec_efects
 from (select value_text,value_numeric,value_coded, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "SP_Side_Effects_INH") secondary_efects
join (select name, concept_id from concept_name where concept_name_type = "FULLY_SPECIFIED" and locale = "en") cn_secondary_efects on cn_secondary_efects.concept_id = secondary_efects.value_coded) sec_efects on sec_efects.encounter_id = obs.encounter_id
LEFT JOIN
(select secondary_efects_ctz.obs_id,secondary_efects_ctz.encounter_id,
case
when
cn_secondary_efects_ctz.name = "True"
then 'SIM'
when
cn_secondary_efects_ctz.name = "False"
then 'NÃO'
end
as has_sec_efects_ctz
 from (select value_text,value_numeric,value_coded, concept_name_type, name, locale, encounter_id, obs_id from obs  join concept_name c on c.concept_id = obs.concept_id where concept_name_type = "FULLY_SPECIFIED" and locale = "en" and name = "SP_Side_Effects_CTZ") secondary_efects_ctz
join (select name, concept_id from concept_name where concept_name_type = "FULLY_SPECIFIED" and locale = "en") cn_secondary_efects_ctz on cn_secondary_efects_ctz.concept_id = secondary_efects_ctz.value_coded) sec_efects_ctz on sec_efects_ctz.encounter_id = obs.encounter_id