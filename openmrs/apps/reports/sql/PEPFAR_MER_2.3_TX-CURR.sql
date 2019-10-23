select
   count(distinct p.person_id ) As "Total",
   count(case when  (p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') < 1 ) then 1 else NULL END) as "M <1",
   count(case when  (p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 1 and 4 ) then 1 else NULL END) as "M 1-4",
   count(case when  (p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 5 and 9 ) then 1 else NULL END) as "M 5-9",
   count(case when  (p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 10 and 14 ) then 1 else NULL END) as "M 10-14",
   count(case when  (p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 15 and 19 ) then 1 else NULL END) as "M 15-19",
   count(case when  (p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 20 and 24 ) then 1 else NULL END) as "M 20-24",
   count(case when  (p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 25 and 29 ) then 1 else NULL END) as "M 25-29",
   count(case when  (p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 30 and 34 ) then 1 else NULL END) as "M 30-34",
   count(case when  (p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 35 and 39 ) then 1 else NULL END) as "M 35-39",
   count(case when  (p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 40 and 44 ) then 1 else NULL END) as "M 40-44",
   count(case when  (p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 45 and 49 ) then 1 else NULL END) as "M 45-49",
   count(case when  (p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') >= 50 ) then 1 else NULL END) as "M >=50",
   count(case when  (p.gender = 'M' and p.birthdate is NULL) then 1 else NULL END) as "M Unknown age",
   count(case when  (p.gender = 'M') then 1 else NULL END) as "Male Subtotal",

   count(case when  (p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') < 1 ) then 1 else NULL END) as "F <1",
   count(case when  (p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 1 and 4 ) then 1 else NULL END) as "F 1-4",
   count(case when  (p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 5 and 9 ) then 1 else NULL END) as "F 5-9",
   count(case when  (p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 10 and 14 ) then 1 else NULL END) as "F 10-14",
   count(case when  (p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 15 and 19 ) then 1 else NULL END) as "F 15-19",
   count(case when  (p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 20 and 24 ) then 1 else NULL END) as "F 20-24",
   count(case when  (p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 25 and 29 ) then 1 else NULL END) as "F 25-29",
   count(case when  (p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 30 and 34 ) then 1 else NULL END) as "F 30-34",
   count(case when  (p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 35 and 39 ) then 1 else NULL END) as "F 35-39",
   count(case when  (p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 40 and 44 ) then 1 else NULL END) as "F 40-44",
   count(case when  (p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 45 and 49 ) then 1 else NULL END) as "F 45-49",
   count(case when  (p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') >= 50 ) then 1 else NULL END) as "F >=50" ,
   count(case when  (p.gender = 'F' and (p.birthdate is NULL)) then 1 else NULL END) as "F Unknown age",
   count(case when  (p.gender = 'F') then 1 else NULL END) as "Female Subtotal"
from
      person p
   inner join
      person_name pn
      on pn.person_id = p.person_id
      and p.voided = 0
      and pn.voided = 0
   inner join
      patient_identifier pi
      on pi.patient_id = p.person_id
      and pi.voided = 0
   inner join
      patient pt
      on pt.patient_id = p.person_id
      and pi.voided = 0
	left JOIN
      person_attribute tdate
      on tdate.person_id=p.person_id
      and tdate.person_attribute_type_id = (
      select person_attribute_type_id from person_attribute_type patype where patype.name='Transfer_Date')
	left JOIN
      person_attribute sdate
      on sdate.person_id=p.person_id
      and sdate.person_attribute_type_id = (
      select person_attribute_type_id from person_attribute_type patype where patype.name='DATE_OF_SUSPENSION')
	left JOIN
      person_attribute ddate
      on ddate.person_id=p.person_id
      and ddate.person_attribute_type_id = (
      select person_attribute_type_id from person_attribute_type patype where patype.name='DATE_OF_DEATH')
	inner join
	    erpdrug_order erp
	    on erp.patient_id=pt.patient_id
	    and cast(erp.dispensed_date as date) BETWEEN '#startDate#' and '#endDate#'
	    and erp.id = (select max(id) from erpdrug_order
                    where erpdrug_order.dispensed=1
                    and erpdrug_order.arv_dispensed=1
                    and erpdrug_order.patient_id=erp.patient_id)
  inner join
	drug_order dor
      on dor.order_id=erp.order_id
  left join patient_status_state pss
      on pss.patient_id=pt.patient_id
	    and DATE(pss.date_created) <= DATE('#endDate#')
      and pss.id= (select  max(id) from patient_status_state
                  where patient_status_state.patient_id=pss.patient_id)
  where (tdate.value is null or DATE(tdate.value) > DATE('#endDate#'))
  and (sdate.value is null or DATE(sdate.value) > DATE('#endDate#'))
  and (ddate.value is null or DATE(ddate.value) > DATE('#endDate#'))
  and ((date_add(date_add(erp.dispensed_date, interval dor.quantity DAY ), interval 31 DAY)) > DATE('#endDate#'))
  and pss.patient_status is null or pss.patient_status<>'TARV_TREATMENT_SUSPENDED';
