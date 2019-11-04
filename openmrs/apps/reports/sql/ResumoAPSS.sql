select  @rownum:=(@rownum+1) as 'No', 
t.identifier as '1.NID'
,t.nome as '1.Nome'
,t.pop_chave as '2.População Chave'
,t.pop_vul as '2.População Vulnerável (Especifique)'
,t.data1  as '3.Consulta Atual'
,t.data2  as '3.Consulta Proxima'
,t.estado as '4.ESTADO DA REVELAÇÃO DO DIAGNÓSTICO à Criança/Adolescente?'
,t.tarv_cons as '5.ACONSELHAMENTO PRÉ-TARV'
,t.reason as '6.FACTORES PSICO-SOCIAIS que afectam a adesão'
,t.pp1 as '7.PP1'
,t.pp2 as '7.PP2'
,t.pp3 as '7.PP3'
,t.pp4 as '7.PP4'
,t.pp5 as '7.PP5'
,t.pp6 as '7.PP6'
,t.pp7 as '7.PP7'
,t.lub as '8.POPULAÇÕES CHAVE - Oferta de lubrificantes (S/N)'
,t.inf as '9.Informou alguém sobre o seu seroestado?'
,t.rel as '9.(Parentesco)'
,t.pptype as '9.Se criança, adolescente, idoso, se tem deficiência física ou mental - Quem administra os ARVS?'
,t.name as '9.(Nome/ Próprio)'
,t.pp_par as '9.(Parentesco)'
,t.pp_plan as '9.PLANO DE ADESÃO - Horário; Dose; Esquecimento da dose; Viagem - (S/N)'
,t.pp_se as '9.EFEITOS SECUNDÁRIOS - O que pode ocorrer; Como manejar efeitos secundários -  (S/N)'
,t.tarv_ad as '9.ADESÃO ao TARV - Boa; Risco; Má;'
,t.pp_visit as '10.MOTIVO da consulta'
,t.grupos as '11.GRUPOS DE APOIO'
,t.gruposm as '12.Modelos Diferenciados de Cuidados (MDC)'
,t.prep as '13.Está preparado para iniciar o TARV'
,t.data3 as '13.DATA'
,t.provider as '14.Provedor'
,t.contactc as ' 14.O paciente/ cuidador concorda em ser contactado, se necessário? '
,t.contact as '14.Contacto'
,t.data4 as '14.Data'
,t.contactcr as '14.O confidente concorda em ser contactado, se necessário?'
,t.contactcn as '14.Contacto'
,t.data5 as '14.Data'

from (select @rownum:=0) as init, 

(select
 pi.identifier 
,concat(pn.given_name,' ',pn.family_name) as nome
,ch.pop_chave 
,cv.pop_vul 
,date_format(date(prt.date_app),'%d-%m-%Y') as data1
,date_format(date(prx.next_app),'%d-%m-%Y')  as data2
,rev.estado 
,cons.tarv_cons 
,rs.reason 
,psb.pp1 
,psb2.pp2 
,psb3.pp3 
,psb4.pp4 
,psb5.pp5 
,psb6.pp6 
,psb7.pp7 
,ppl.lub 
,ppi.inf 
,ppr.rel 
,ppad.pptype 
,ppname.name 
,ppp.pp_par 
,pad.pp_plan 
,se.pp_se 
,ptar.tarv_ad 
,ppv.pp_visit 
,refall.grupos 
,mdc.gruposm
,prp.prep 
,date_format(date(model.dia),'%d-%m-%Y') as data3
,prov.provider 
,conf.contactc 
,ctype.contact 
,date_format(date(conf.last),'%d-%m-%Y')  as data4
,care.contactcr 
,cntype.contactcn 
,date_format(date(care.last),'%d-%m-%Y') as data5

from  
person as pr

inner join (select e.patient_id,e.encounter_id as encounter_id from encounter e
where date(e.encounter_datetime) BETWEEN '#startDate#' and '#endDate#') as me on me.patient_id = pr.person_id

left join (select distinct patient_id from patient where voided = 0) as p on p.patient_id = pr.person_id
left join (select distinct patient_id,identifier,identifier_type from patient_identifier where voided = 0) as pi on pi.patient_id = p.patient_id
left join (select distinct person_id,given_name,family_name from person_name where voided = 0) as pn on pn.person_id = p.patient_id

left join (select encounter_id,patient_id,(encounter_datetime) as  date_app
from encounter) as prt on prt.patient_id = pr.person_id and prt.encounter_id = me.encounter_id

left join (select patient_id,max(start_date_time) as  next_app
from patient_appointment group by patient_id) as prx on prx.patient_id = pr.person_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as pop_chave
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'PP_If_Key_population_yes') as ch on ch.person_id = p.patient_id and ch.encounter_id = me.encounter_id

 left join (select e.encounter_id,ob.person_id,ob.value_coded,(select name 
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as pop_vul
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'PP_IF_Vulnerable_Population_Yes') as cv on cv.person_id = p.patient_id and cv.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as estado
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Disclosure_Diagnosis_results_child_adolescent' 
group by ob.person_id,e.encounter_id) as rev 
on rev.person_id = p.patient_id and rev.encounter_id = me.encounter_id

left join (select e.encounter_id, ob.person_id,ob.value_coded,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as tarv_cons
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Pre_TARV_counselling') as cons on cons.person_id = p.patient_id and cons.encounter_id = me.encounter_id

left join (select e.encounter_id, ob.person_id,group_concat((select substr(name,1,1)
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT')) as reason
from obs ob
, encounter e
, concept_name cn
where ob.encounter_id = e.encounter_id
and ob.person_id = e.patient_id
and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' 
and cn.locale = 'en'
and cn.name = 'Apss_Psychosocial_factors_Reasons'
group by ob.person_id,e.encounter_id) as rs on rs.person_id = p.patient_id and rs.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as pp1
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Positive_prevention_Sexual_behavior') as psb on psb.person_id = p.patient_id and psb.encounter_id = me.encounter_id 

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as pp2
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Positive_prevention_Disclosure_HIV_status_partner_encouragement_test'
) as psb2 on psb2.person_id = p.patient_id and psb2.encounter_id = me.encounter_id 

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as pp3
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Positive_prevention_importance_adherence'
) as psb3 on psb3.person_id = p.patient_id and psb3.encounter_id = me.encounter_id 

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as pp4
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Positive_prevention_Sexually_Transmitted_Infections'
) as psb4 on psb4.person_id = p.patient_id and psb4.encounter_id = me.encounter_id 

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as pp5
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

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as rel
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Adherence_follow_up_Has_informed_someone_RELATIONSHIP'
) as ppr on ppr.person_id = p.patient_id and ppr.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as pptype
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

left join (select e.encounter_id,ob.person_id,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as pp_par
from obs ob, concept_name cn, encounter e
where 
 ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'CONFIDENT_RELATIONSHIP'
and ob.encounter_id = e.encounter_id
and ob.person_id = e.patient_id
) as ppp  on ppp.person_id = p.patient_id and ppp.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as pp_plan
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Adherence_follow_up_Adherence_Plan') as pad on pad.person_id = p.patient_id and pad.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as pp_se
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Adherence_follow_up_Side_Effects') as se on se.person_id = p.patient_id and se.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select  name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as tarv_ad
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Adherence_follow_up_Adherence_TARV') as ptar on ptar.person_id = p.patient_id and ptar.encounter_id = me.encounter_id

left join (select e.encounter_id, ob.person_id,ob.value_coded,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as pp_visit
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Reason_For_The_Visit') as ppv on ppv.person_id = p.patient_id and ppv.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,group_concat(concat( case when name='Reference_Other_Specify_Group' then 'Outro' else (select substr(name,1,2)
 from concept_name where concept_id = ob.concept_id and locale = 'pt' and concept_name_type = 'SHORT') end,'-',(select name
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

left join (select e.encounter_id,ob.person_id,group_concat(concat( case when name='Reference_MDC_Other' then 'Outro' else
(select substr(name,1,2)
 from concept_name 
where concept_id = ob.concept_id and locale = 'pt' and concept_name_type = 'SHORT') end,'-',(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT'))) as gruposm
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name in ('Reference_MDC_Other','Reference_DC','Reference_PU','Reference_CA','Reference_AF','Reference_GA')
group by ob.person_id,e.encounter_id) as mdc on mdc.person_id = p.patient_id and mdc.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select name 
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as prep
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Prepared_start_ARV_treatment') as prp on prp.person_id = p.patient_id and prp.encounter_id = me.encounter_id


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

left join (select e.encounter_id, ob.person_id,ob.value_coded,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as contactc,
e.encounter_datetime as last
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Agreement_Terms_Confidant_agrees_contacted'
) as conf on conf.person_id = p.patient_id and conf.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as contact
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Agreement_Terms_Type_Contact') as ctype on ctype.person_id = p.patient_id  and ctype.encounter_id = me.encounter_id

left join (select e.encounter_id,ob.person_id,ob.value_coded,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as contactcr
,e.encounter_datetime as last
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Agreement_Terms_Patient_Caregiver_agrees_contacted'
) as care on care.person_id = p.patient_id  and care.encounter_id = me.encounter_id


left join (select e.encounter_id,ob.person_id,ob.value_coded,(select name
 from concept_name 
where concept_id = ob.value_coded and locale = 'pt' and concept_name_type = 'SHORT') as contactcn
from obs ob, encounter e, concept_name cn
where ob.person_id = e.patient_id and ob.encounter_id = e.encounter_id and ob.concept_id = cn.concept_id
and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
and cn.name = 'Apss_Agreement_Terms_Confidant_agrees_contacted_Type_of_TC_Contact') as cntype on cntype.person_id = p.patient_id  and cntype.encounter_id = me.encounter_id

where pi.identifier_type = 3
group by prt.date_app
order by prt.date_app desc) as t
-- order by @rownum desc
;