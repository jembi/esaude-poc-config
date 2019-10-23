select (
SELECT Substring(property_value, ( Position('name"' IN property_value) + 7 ), ( 
              Position('"}' IN property_value) - Position( 
              'name"' IN property_value) ) 
              - 7) AS ExtractString 
FROM   global_property 
WHERE  property = "healthfacility.info"
)
as "Health Facility",
count(distinct p.person_id ) As "Total",
   (
      select count(distinct o.person_id ) from obs o 
       inner join
      erpdrug_order erp1
      on erp1.patient_id=o.person_id
      where erp1.id = (select max(id) from erpdrug_order 
                      where
                        cast(erp1.dispensed_date as date) BETWEEN '#startDate#' and '#endDate#' 
                        and erpdrug_order.dispensed=1
                            and erpdrug_order.arv_dispensed=1
                            and erpdrug_order.first_arv_dispensed=1 and erpdrug_order.patient_id=erp1.patient_id)                            
                            and (
                                  (
                                  cast(o.value_datetime as date) BETWEEN '#startDate#' and '#endDate#' 
                                  and (o.obs_id = (select max(obs_id) from obs 
                                                      inner join
                                                      concept_name conname
                                                      on obs.concept_id=conname.concept_id
                                                      where conname.name = 'Date of Delivery' and concept_name_type ='FULLY_SPECIFIED' and conname.locale ='en'
                                                      and conname.voided = 0
                                                      and obs.voided = 0  
                                                      and obs.person_id=o.person_id)))
                                  OR
                                  (cast(o.date_created as date) BETWEEN '#startDate#' and '#endDate#'
                                  and (o.obs_id = (select max(obs_id) from obs 
                                                      inner join
                                                      concept_name conname
                                                      on obs.concept_id=conname.concept_id
                                                      where conname.name = 'Breastfeeding_ANA' and concept_name_type ='FULLY_SPECIFIED' and conname.locale ='en'
                                                      and conname.voided = 0
                                                      and obs.voided = 0
                                                      and obs.person_id=o.person_id)))
                                 )
   ) as "Breastfeeding",
   

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
   count(case when  (p.gender = 'F') then 1 else NULL END) as "Female Subtotal",
   " " as "Data Check"
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

  
   Inner JOIN
      person_attribute pa 
      on pa.person_id = p.person_id 
      and pa.voided = 0 
   JOIN
      concept_view cv 
      on pa.value = cv.concept_id 
      AND cv.retired = 0 
      and cv.concept_full_name = 'NEW_PATIENT'
    inner join
      erpdrug_order erp
      on erp.patient_id=pt.patient_id
      and cast(erp.dispensed_date as date) BETWEEN '#startDate#' and '#endDate#'
      where erp.id = (select max(id) from erpdrug_order 
                      where erpdrug_order.dispensed=1
                            and erpdrug_order.arv_dispensed=1
                            and erpdrug_order.first_arv_dispensed=1 and erpdrug_order.patient_id=erp.patient_id);