select distinct pi.identifier as NID
,concat(pn.given_name,' ',pn.family_name) as nome
,curdate() as consulta_atual
,date(prx.next_app) as proxima_consulta
,timestampdiff(YEAR, date(pr.birthdate), date(now())) as idade
,ch.pop_chave as populacao_chave
,cv.pop_vul as populacao_vulneravel
,rev.estado as estado_revelacao
,cons.tarv_cons as estado_aconselhamento
,rs.reason as fatores
,psb.pp1 as pp1
,psb2.pp2 as pp2
,psb3.pp3 as pp3
,psb4.pp4 as pp4
,psb5.pp5 as pp5
,psb6.pp6 as pp6
,psb7.pp7 as pp7
,ppl.lub as pop_chave_lub
,ppi.inf as informou_alguem
,ppr.rel as relacao
,ppad.pptype as outrem_administra
,ppname.name as nome
,ppp.pp_par as admin_relacao
,pad.pp_plan as plano_aderencia
,se.pp_se as efeitos_secundarios
,ptar.tarv_ad as aderencia_tarv
,ppv.pp_visit as motivo_visita
,refall.grupos as grupo_apoio
,refother.grupo as o_outro_grupo
,mdc.grupos as grupo_mdc
,mdc_o.other as outro_grupo_mdc
,model.dia as dia_cuidados_diferenciados
,prov.provider as provider
,conf.contact as confidente_concorda_c_contacto
,ctype.contact as tipo_de_contacto
,conf.last as dia_confidente
,care.contact as cuidador_concorda_c_contacto
,care.last as dia_cuidador
,cntype.contact as tipo_de_contacto_cuidador

from  
person pr

inner join (select e.patient_id,max(e.encounter_id) as encounter_id from encounter e
where e.encounter_datetime BETWEEN '#startDate' and '#endDate#' group by e.patient_id) as me on me.patient_id = pr.person_id

left join (select distinct patient_id from patient where voided = 0) as p on p.patient_id = pr.person_id
left join (select distinct patient_id,identifier,identifier_type from patient_identifier where voided = 0) as pi on pi.patient_id = p.patient_id
left join (select distinct person_id,given_name,family_name from person_name where voided = 0) as pn on pn.person_id = p.patient_id


left join (select patient_id,max(start_date_time) as  next_app
from patient_appointment group by patient_id) as prx on prx.patient_id = pr.person_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select case
 when name='PP_Key_population_Yes' then 'Sim' 
 when name = 'PP_Key_population_No' then 'Não'
 end as name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED') as pop_chave
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'PP_Key_population') as ch on ch.person_id = p.patient_id and ch.encounter_id = me.encounter_id

 left join (select e.encounter_id,ob.person_id,ob.value_coded,(select case
  when name='PP_Vulnerable_Population_Yes_Female_youths' then 'Rapariga entre 10-14 anos' 
when name='PP_Vulnerable_Population_Yes_Young woman' then 'Mulher jovem entre 15-24 anos' 
when name='PP_Vulnerable_Population_Yes_Serodiscordant_couples' then 'Casais serodiscordantes'
when name='PP_Vulnerable_Population_Yes_Orphans' then 'Criança Órfã'
when name='PP_Vulnerable_Population_Yes_Person_Disability' then 'Pessoa com deficiência'
when name='PP_Vulnerable_Population_Yes_Seasonal_Workers' then 'Trabalhadores sazonais'
when name='PP_Vulnerable_Population_Yes_Miner' then 'Mineiro'
when name='PP_Vulnerable_Population_Yes_Truck_driver' then 'Camionista'
 end as name 
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED') as pop_vul
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'PP_IF_Vulnerable_Population_Yes') as cv on cv.person_id = p.patient_id and cv.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select case
 when name='Apss_Disclosure_Diagnosis_results_child_adolescent_No' then 'Não'
 when name='Apss_Disclosure_Diagnosis_results_child_adolescent_Partial' then 'Parcial'
 when name='Apss_Disclosure_Diagnosis_results_child_adolescent_Total' then 'Total'
 end as name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED') as estado
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Disclosure_Diagnosis_results_child_adolescent') as rev on rev.person_id = p.patient_id and rev.encounter_id = me.encounter_id

left join (select e.encounter_id, ob.person_id,ob.value_coded,(select case
 when name='Apss_Pre_TARV_counselling_Yes' then 'Sim'
 when name='Apss_Pre_TARV_counselling_NO' then 'Não'
 end as name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED') as tarv_cons
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Pre_TARV_counselling') as cons on cons.person_id = p.patient_id and cons.encounter_id = me.encounter_id

left join (select e.encounter_id, ob.person_id,group_concat((select case
 when name='Apss_Psychosocial_factors_Alcohol_Drug_Abuse' then 'Q'
 when name='Apss_Psychosocial_factors_Cultural_Religious_Traditional_Aspects' then 'P'
 when name='Apss_Psychosocial_factors_Denial_of_positive_result' then 'A'
 when name='Apss_Psychosocial_factors_Feels_better' then 'E'
 when name='Apss_Psychosocial_factors_Feels_too_sick_ill' then 'B'
 when name='Apss_Psychosocial_factors_Gender_Based_Violence' then 'O'
 when name='Apss_Psychosocial_factors_Hard_disclose_to_partner_family' then 'I'
 when name='Apss_Psychosocial_factors_I_don_believe_ARV' then 'C'
 when name='Apss_Psychosocial_factors_It_lot_drugs' then 'D'
 when name='Apss_Psychosocial_factors_Lack_of_family_support' then 'G'
 when name='Apss_Psychosocial_factors_Lack_of_food' then 'F'
 when name='Apss_Psychosocial_factors_Lost_Forgot_Shared_drugs' then 'L'
 when name='Apss_Psychosocial_factors_Signs_depression_anxiety' then 'H'
 when name='Apss_Psychosocial_factors_Stigma_Discrimination' then 'M'
 when name='Apss_Psychosocial_factors_Toxicity_Fear_of_side_effects' then 'J'
 when name='Apss_Psychosocial_factors_Transport_Issues' then 'N'
 when name='Apss_Psychosocial_factors_Other_add_field_specify' then 'Outro'
 end as name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED')) as reason
from obs ob
, encounter e
, concept_name cn
where ob.encounter_id = e.encounter_id
and ob.person_id = e.patient_id
and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' 
and cn.locale = 'en'
and cn.name = 'Apss_Psychosocial_factors_Reasons'
) as rs on rs.person_id = p.patient_id and rs.encounter_id = me.encounter_id and rs.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select case
 when name='Apss_Positive_prevention_Sexual_behavior_Yes' then 'Sim'
 when name='Apss_Positive_prevention_Sexual_behavior_No' then 'Não'
 end as name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED') as pp1
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Positive_prevention_Sexual_behavior') as psb on psb.person_id = p.patient_id and psb.encounter_id = me.encounter_id 

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select case
 when name='Apss_Positive_prevention_Disclosure_HIV_status_partner_encouragement_test_Yes' then 'Sim'
 when name='Apss_Positive_prevention_Disclosure_HIV_status_partner_encouragement_test_No' then 'Não'
 end as name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED') as pp2
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Positive_prevention_Disclosure_HIV_status_partner_encouragement_test'
) as psb2 on psb2.person_id = p.patient_id and psb2.encounter_id = me.encounter_id 

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select case
 when name='Apss_Positive_prevention_importance_adherence_Yes' then 'Sim'
 when name='Apss_Positive_prevention_importance_adherence_No' then 'Não'
 end as name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED') as pp3
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Positive_prevention_importance_adherence'
) as psb3 on psb3.person_id = p.patient_id and psb3.encounter_id = me.encounter_id 

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select case
 when name='Apss_Positive_prevention_Sexually_Transmitted_Infections_Yes' then 'Sim'
 when name='Apss_Positive_prevention_Sexually_Transmitted_Infections_No' then 'Não'
 end as name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED') as pp4
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Positive_prevention_Sexually_Transmitted_Infections'
) as psb4 on psb4.person_id = p.patient_id and psb4.encounter_id = me.encounter_id 

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select case
 when name='Apss_Positive_prevention_Family_Planning_Yes' then 'Sim'
 when name='Apss_Positive_prevention_Family_Planning_No' then 'Não'
 end as name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED') as pp5
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Positive_prevention_Family_Planning'
) as psb5 on psb5.person_id = p.patient_id and psb5.encounter_id = me.encounter_id 

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as pp6
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Positive_prevention_Alcohol_other_Drugs_consumption') as psb6 on psb6.person_id = p.patient_id and psb6.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as pp7
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Positive_prevention_Need_community_support'
) as psb7 on psb7.person_id = p.patient_id and psb7.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as lub
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Positive_prevention_Key_Population'
) as ppl on ppl.person_id = p.patient_id and ppl.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as inf
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Adherence_follow_up_Has_informed_someone'
) as ppi on ppi.person_id = p.patient_id and ppi.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select case
 when name='REL_DAD' then 'Pai'
 when name='REL_MOM' then 'Mãe'
  when name='REL_STEPDAD' then 'Padrasto'
   when name='REL_STEPMOM' then 'Madrasta'
    when name='REL_FATHERINLAW' then 'Sogro(a)'
     when name='REL_GODFATHER' then 'Padrinho'
      when name='REL_GODMOTHER' then 'Madrinha'
       when name='REL_SON_DAUGHTER' then 'Filho(a)'
        when name='REL_BROTHER' then 'Irmão'
         when name='REL_SISTER' then 'Irmã'
         when name='REL_COUSIN' then 'Primo(a)'
          when name='REL_GODSON_DAUGHTER' then 'Afilhado(a)'
          when name='REL_NEPHEW' then 'Sobrinho(a)'
          when name='REL_BROTHERINLAW' then 'Cunhado(a)'
          when name='REL_SISTERINLAW' then 'Concunhado(a)'
          when name='REL_UNCLE_AUNT' then 'Tio(a)'
          when name='REL_GRANDFATHER_MOTHER' then 'Avo'
          when name='REL_SONINLAW' then 'Genro'
          when name='REL_DAUGHTERINLAW' then 'Nora'
          when name='REL_HUSBAND_WIFE' then 'Esposo(a)'
          when name='REL_GODSON_DAUGHTER' then 'Neto(a)'
           when name='REL_GRANDSON_DAUGHTER' then 'Neto(a)'
            when name='REL_NEIGHBOR' then 'Vizinho(a)'
             when name='REL_FRIEND' then 'Amigo(a)'
 end as name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED') as rel
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Adherence_follow_up_Has_informed_someone_RELATIONSHIP'
) as ppr on ppr.person_id = p.patient_id and ppr.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select case
 when name='Apss_Adherence_follow_up_If_Child_Adolescent_Elderly_Disabled_Yes' then 'Sim'
 when name='Apss_Adherence_follow_up_If_Child_Adolescent_Elderly_Disabled_No' then 'Não'
 end as name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED') as pptype
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Adherence_follow_up_If_Child_Adolescent_Elderly_Disabled'
) as ppad on ppad.person_id = p.patient_id and ppad.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_text as name
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Adherence_follow_up_Who_administers_Full_Name'
) as ppname on ppname.person_id = p.patient_id and ppname.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,(select case
when name='REL_DAD' then 'Pai'
 when name='REL_MOM' then 'Mãe'
  when name='REL_STEPDAD' then 'Padrasto'
   when name='REL_STEPMOM' then 'Madrasta'
    when name='REL_FATHERINLAW' then 'Sogro(a)'
     when name='REL_GODFATHER' then 'Padrinho'
      when name='REL_GODMOTHER' then 'Madrinha'
       when name='REL_SON_DAUGHTER' then 'Filho(a)'
        when name='REL_BROTHER' then 'Irmão'
         when name='REL_SISTER' then 'Irmã'
         when name='REL_COUSIN' then 'Primo(a)'
          when name='REL_GODSON_DAUGHTER' then 'Afilhado(a)'
          when name='REL_NEPHEW' then 'Sobrinho(a)'
          when name='REL_BROTHERINLAW' then 'Cunhado(a)'
          when name='REL_SISTERINLAW' then 'Concunhado(a)'
          when name='REL_UNCLE_AUNT' then 'Tio(a)'
          when name='REL_GRANDFATHER_MOTHER' then 'Avo'
          when name='REL_SONINLAW' then 'Genro'
          when name='REL_DAUGHTERINLAW' then 'Nora'
          when name='REL_HUSBAND_WIFE' then 'Esposo(a)'
          when name='REL_GODSON_DAUGHTER' then 'Neto(a)'
           when name='REL_GRANDSON_DAUGHTER' then 'Neto(a)'
            when name='REL_NEIGHBOR' then 'Vizinho(a)'
             when name='REL_FRIEND' then 'Amigo(a)'
 end as name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED') as pp_par
from obs ob, concept_name cn, encounter e
where 
 ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'CONFIDENT_RELATIONSHIP'
and ob.encounter_id = e.encounter_id
and ob.person_id = e.patient_id
) as ppp  on ppp.person_id = p.patient_id and ppp.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select case
 when name='Apss_Adherence_follow_up_Adherence_Plan_Yes' then 'Sim'
 when name='Apss_Adherence_follow_up_Adherence_Plan_No' then 'Não'
 end as name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED') as pp_plan
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Adherence_follow_up_Adherence_Plan') as pad on pad.person_id = p.patient_id and pad.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select case
 when name='Apss_Adherence_follow_up_Side_Effects_Yes' then 'Sim'
 when name='Apss_Adherence_follow_up_Side_Effects_No' then 'Não'
 end as name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED') as pp_se
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Adherence_follow_up_Side_Effects') as se on se.person_id = p.patient_id and se.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select case
 when name='Apss_Adherence_follow_up_Adherence_TARV_Good' then 'Boa'
 when name='Apss_Adherence_follow_up_Adherence_TARV_Risky' then 'Risco'
  when name='Apss_Adherence_follow_up_Adherence_TARV_Bad' then 'Má'
 end as name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED') as tarv_ad
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Adherence_follow_up_Adherence_TARV') as ptar on ptar.person_id = p.patient_id and ptar.encounter_id = me.encounter_id

left join (select e.encounter_id, ob.person_id,ob.value_coded,(select case
 when name='Apss_Reason_For_The_Visit_Normal' then 'Normal'
 when name='Apss_Reason_For_The_Visit_Faulty' then 'Faltoso'
  when name='Apss_Reason_For_The_Visit_Leave' then 'Abandono'
 end as name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED') as pp_visit
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Reason_For_The_Visit') as ppv on ppv.person_id = p.patient_id and ppv.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,group_concat(concat((select substr(name,1,2)
 from concept_name where concept_id = ob.concept_id and locale = 'pt' and concept_name_type = 'SHORT'),'-',(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT'))) as grupos
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name in ('Reference_Other_Specify_Group','Reference_MPS','Reference_PR','Reference_CR','Reference_CA','Reference_AR')
and ob.encounter_id in (select max(e.encounter_id) from encounter e,obs o, concept_name 
where o.concept_id = cn.concept_id and o.person_id = ob.person_id and e.patient_id = o.person_id and e.encounter_id = o.encounter_id
 and cn.name in ('Reference_Other_Specify_Group','Reference_MPS','Reference_PR','Reference_CR','Reference_CA','Reference_AR') group by e.patient_id)) 
 as refall on refall.person_id = p.patient_id and refall.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_text as grupo
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Reference_Other_Specify_Group_Other'
) as refother on refother.person_id = p.patient_id and refother.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,group_concat(concat(
(select substr(name,1,2)
 from concept_name 
where concept_id = ob.concept_id and locale = 'pt' and concept_name_type = 'SHORT'),'-',(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED'))) as grupos
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name in ('Reference_MDC_Other','Reference_DC','Reference_PU','Reference_CA','Reference_AF','Reference_GA')
) as mdc on mdc.person_id = p.patient_id and mdc.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_text as other
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Reference_MDC_Other_comments'
) as mdc_o on mdc_o.person_id = p.patient_id and mdc_o.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_datetime as dia
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Differentiated_Models_Date') as model on model.person_id = p.patient_id and model.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.creator,(select concat(given_name,family_name)
 from person_name 
where person_id = ob.creator) as provider
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name in ('Reference_Form','Apss_Section_II_form','Apss_Section_I_form','Apss_Section_III_form','Group_Priority_Population_obs_form')
) as prov on prov.person_id = p.patient_id and prov.encounter_id = me.encounter_id

left join (select e.encounter_id, ob.person_id,ob.value_coded,(select case
 when name='Apss_Agreement_Terms_Confidant_agrees_contacted_Yes' then 'Sim'
 when name='Apss_Agreement_Terms_Confidant_agrees_contacted_No' then 'Não'
 end as name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED') as contact,
e.encounter_datetime as last
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Agreement_Terms_Confidant_agrees_contacted'
) as conf on conf.person_id = p.patient_id and conf.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select case
 when name='Apss_Agreement_Terms_Type_Contact_Phone_call' then 'Chamada Telefônica'
 when name='Apss_Agreement_Terms_Type_Contact_SMS' then 'SMS'
  when name='Apss_Agreement_Terms_Type_Contact_House_Visits' then 'Visita Domiciliária'
 end as name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED') as contact
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Agreement_Terms_Type_Contact') as ctype on ctype.person_id = p.patient_id  and ctype.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select case
 when name='Apss_Agreement_Terms_Patient_Caregiver_agrees_contacted_Yes' then 'Sim'
 when name='Apss_Agreement_Terms_Patient_Caregiver_agrees_contacted_No' then 'Não'
 end as name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED') as contact
,e.encounter_datetime as last
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Agreement_Terms_Patient_Caregiver_agrees_contacted'
) as care on care.person_id = p.patient_id  and care.encounter_id = me.encounter_id


left join (select e.encounter_id,ob.person_id,ob.value_coded,(select case
 when name='Apss_Agreement_Terms_Confidant_agrees_contacted_TC_Phone_call' then 'Chamada Telefônica'
 when name='Apss_Agreement_Terms_Confidant_agrees_contacted_TC_SMS' then 'SMS'
  when name='Apss_Agreement_Terms_Confidant_agrees_contacted_TC_Visits' then 'Visita Domiciliária'
 end as name
 from concept_name 
where concept_id = ob.value_coded and locale = 'en' and concept_name_type = 'FULLY_SPECIFIED') as contact
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Agreement_Terms_Confidant_agrees_contacted_Type_of_TC_Contact') as cntype on cntype.person_id = p.patient_id  and cntype.encounter_id = me.encounter_id

where pi.identifier_type = 3;