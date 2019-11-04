select (@rownum:=@rownum+1) as No,
t.identifier as NID, 
t.given_name as Nome, 
t.family_name as Apelido,
t.data1 as 'Data de Visita'
from (select @rownum:=0) as init,
(select
a.identifier, 
b.given_name, 
b.family_name,
date(c.encounter_datetime) as data1
from (select @rownum:=0) as init,patient_identifier a, person_name b, encounter c 
 where a.patient_id = b.person_id and b.person_id = c.patient_id and a.identifier_type = 3 
 and date(c.encounter_datetime) between '#startDate#' and '#endDate#'
 order by c.encounter_datetime desc) as t;