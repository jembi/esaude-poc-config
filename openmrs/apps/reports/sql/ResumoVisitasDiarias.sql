select (@rownum:=@rownum+1) as No,
t.identifier as NID, 
t.given_name as Nome,
t.middle_name as 'Nome do Meio',
t.family_name as Apelido,
t.data1 as 'Data de Visita'
from (select @rownum:=0) as init,
(select distinct
a.identifier, 
b.given_name,
b.middle_name,
b.family_name, d.visit_id,
date(c.encounter_datetime) as data1
from (select @rownum:=0) as init,patient_identifier a, person_name b, encounter c, visit d 
 where a.patient_id = b.person_id and b.person_id = c.patient_id and a.identifier_type = 3
 and a.preferred = 1 
 and a.voided = 0
 and b.voided = 0
 and c.visit_id = d.visit_id
 and c.encounter_type = 1
 and date(c.encounter_datetime) between '#startDate#' and '#endDate#'
 order by c.encounter_datetime desc) as t;
