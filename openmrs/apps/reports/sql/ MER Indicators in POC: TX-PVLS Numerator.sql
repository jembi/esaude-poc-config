
select 
    count(*) As "Total",
   -- -- "Routine Breastfeeding"
    (
    select count(distinct p.person_id)
    from 
    person p
    inner join
    obs o
    on p.person_id=o.person_id
    inner join 
    obs o1
    on o1.person_id = p.person_id
    inner join
    obs ob
    on p.person_id=ob.person_id
    and 
             ob.obs_id = ( 
                        select max(inob.obs_id) from obs inob 
                        inner join 
                        concept_view cv
                        on cv.concept_id = inob.concept_id
                        where (cv.concept_full_name = 'CARGA VIRAL (Absoluto-Rotina)' or cv.concept_full_name = 'CARGA VIRAL (Absoluto-Suspeita)' )
                        and inob.value_numeric < 1000 
                        and (o.date_created >= DATE_SUB('#endDate#', INTERVAL 12 MONTH))
                        and inob.person_id=p.person_id)
    
    inner join
    concept_view cv
    on cv.concept_id = ob.concept_id
    and cv.concept_full_name = 'CARGA VIRAL (Absoluto-Rotina)'
    inner join
    erpdrug_order erp1
    on erp1.patient_id=o.person_id
    and erp1.id = (select max(id) from erpdrug_order 
                      where
                         (ob.date_created <= DATE_SUB(erp1.dispensed_date, INTERVAL 3 MONTH))
                        and erpdrug_order.dispensed=1
                            and erpdrug_order.arv_dispensed=1
                            and erpdrug_order.first_arv_dispensed=1 and erpdrug_order.patient_id=erp1.patient_id)
    and 
    (
        (
            (o1.value_datetime >= DATE_SUB('#endDate#', INTERVAL 18 MONTH)) 
            and
        o1.obs_id = (
                    select max(obs_id) from obs 
                                                      inner join
                                                      concept_name conname
                                                      on obs.concept_id=conname.concept_id
                                                      where conname.name = 'Date of Delivery' and concept_name_type ='FULLY_SPECIFIED' and conname.locale ='en'                                                     
                                                      and conname.voided = 0  
                                                      and obs.voided = 0
                                                      and obs.person_id=o1.person_id

                    )
        )
        OR
        (
             (o1.date_created >= DATE_SUB('#endDate#', INTERVAL 18 MONTH))
             and
        o1.obs_id = (
                        select max(obs_id) from obs 
                                                      inner join
                                                      concept_name conname
                                                      on obs.concept_id=conname.concept_id
                                                      where conname.name = 'Breastfeeding_ANA' and concept_name_type ='FULLY_SPECIFIED' and conname.locale ='en'                                                      
                                                      and obs.value_coded = 1
                                                      and conname.voided = 0
                                                      and obs.voided = 0
                                                      and obs.person_id=o1.person_id
                    )
        )
    )
    ) as "Routine Breastfeeding",
    -- -- "Targeted Breastfeeding"
    (
    select count(distinct p.person_id)
from 
    person p
    inner join
    obs o
    on p.person_id=o.person_id
    inner join 
    obs o1
    on o1.person_id = p.person_id
    inner join
    obs ob
    on p.person_id=ob.person_id
    and 
             ob.obs_id = ( 
                        select max(inob.obs_id) from obs inob 
                        inner join 
                        concept_view cv
                        on cv.concept_id = inob.concept_id
                        where (cv.concept_full_name = 'CARGA VIRAL (Absoluto-Rotina)' or cv.concept_full_name = 'CARGA VIRAL (Absoluto-Suspeita)' )
                        and inob.value_numeric < 1000 
                        and (o.date_created >= DATE_SUB('#endDate#', INTERVAL 12 MONTH))
                        and inob.person_id=p.person_id)
    
    inner join
    concept_view cv
    on cv.concept_id = ob.concept_id
    and cv.concept_full_name = 'CARGA VIRAL (Absoluto-Suspeita)'
    inner join
    erpdrug_order erp1
    on erp1.patient_id=o.person_id
    and erp1.id = (select max(id) from erpdrug_order 
                      where
                        (ob.date_created <= DATE_SUB(erp1.dispensed_date, INTERVAL 3 MONTH))
                        and erpdrug_order.dispensed=1
                            and erpdrug_order.arv_dispensed=1
                            and erpdrug_order.first_arv_dispensed=1 and erpdrug_order.patient_id=erp1.patient_id)
    and 
    (
        ((o1.value_datetime >= DATE_SUB('#endDate#', INTERVAL 18 MONTH)) 
        and
        o1.obs_id = (
                    select max(obs_id) from obs 
                                                      inner join
                                                      concept_name conname
                                                      on obs.concept_id=conname.concept_id
                                                      where conname.name = 'Date of Delivery' and concept_name_type ='FULLY_SPECIFIED' and conname.locale ='en'                                                     
                                                      and conname.voided = 0  
                                                      and obs.voided = 0
                                                      and obs.person_id=o1.person_id

                    )
        )
        OR
        (
            (o1.date_created >= DATE_SUB('#endDate#', INTERVAL 18 MONTH))
             and
        o1.obs_id = (
                        select max(obs_id) from obs 
                                                      inner join
                                                      concept_name conname
                                                      on obs.concept_id=conname.concept_id
                                                      where conname.name = 'Breastfeeding_ANA' and concept_name_type ='FULLY_SPECIFIED' and conname.locale ='en'                                                      
                                                      and obs.value_coded = 1
                                                      and conname.voided = 0
                                                      and obs.voided = 0
                                                      and obs.person_id=o1.person_id
                    )
        )
    )
    ) as "Targeted Breastfeeding",
    -- -- "Routine Pregnant"
    (
        select count(distinct p.person_id)
    from 
    person p
    inner join
    obs o
    on p.person_id=o.person_id
    inner join 
    obs o1
    on o1.person_id = p.person_id
    inner join
    obs ob
    on p.person_id=ob.person_id
    and 
             ob.obs_id = ( 
                        select max(inob.obs_id) from obs inob 
                        inner join 
                        concept_view cv
                        on cv.concept_id = inob.concept_id
                        where (cv.concept_full_name = 'CARGA VIRAL (Absoluto-Rotina)' or cv.concept_full_name = 'CARGA VIRAL (Absoluto-Suspeita)' )
                        and inob.value_numeric < 1000 
                        and (o.date_created >= DATE_SUB('#endDate#', INTERVAL 12 MONTH))
                        and inob.person_id=p.person_id)
    
    inner join
    concept_view cv
    on cv.concept_id = ob.concept_id
    and cv.concept_full_name = 'CARGA VIRAL (Absoluto-Rotina)'
    inner join
    erpdrug_order erp1
    on erp1.patient_id=o.person_id
    and erp1.id = (select max(id) from erpdrug_order 
                      where
                        (ob.date_created <= DATE_SUB(erp1.dispensed_date, INTERVAL 3 MONTH))
                        and erpdrug_order.dispensed=1
                            and erpdrug_order.arv_dispensed=1
                            and erpdrug_order.first_arv_dispensed=1 and erpdrug_order.patient_id=erp1.patient_id)
    and 
    (
        (
            (o1.date_created >= DATE_SUB('#endDate#', INTERVAL 9 MONTH)) 
            and
            
        o1.obs_id = (
                    select max(obs_id) from obs 
                                                      inner join
                                                      concept_name conname
                                                      on obs.concept_id=conname.concept_id
                                                      where conname.name = 'Probable delivery date' and concept_name_type ='FULLY_SPECIFIED' and conname.locale ='en'                                                     
                                                      and conname.voided = 0 
                                                      and obs.voided = 0 
                                                      and obs.person_id=o1.person_id

                    )
        )
        OR
        (
             (o1.date_created >= DATE_SUB('#endDate#', INTERVAL 9 MONTH))
             and
        o1.obs_id = (
                        select max(obs_id) from obs 
                                                      inner join
                                                      concept_name conname
                                                      on obs.concept_id=conname.concept_id
                                                      where conname.name = 'Pregnancy_Yes_No' and concept_name_type ='FULLY_SPECIFIED' and conname.locale ='en'                                                      
                                                      and obs.value_coded = (select concept_id from concept_view where concept_full_name = 'Pregnancy_Yes')
                                                      and conname.voided = 0
                                                      and obs.voided = 0
                                                      and obs.person_id=o1.person_id
                    )
        )
    )
    ) "Routine Pregnant",
 -- -- "Targeted Pregnant"
    (
        select count(distinct p.person_id)
    from 
    person p
    inner join
    obs o
    on p.person_id=o.person_id
    inner join 
    obs o1
    on o1.person_id = p.person_id
    inner join
    obs ob
    on p.person_id=ob.person_id
    and 
             ob.obs_id = ( 
                        select max(inob.obs_id) from obs inob 
                        inner join 
                        concept_view cv
                        on cv.concept_id = inob.concept_id
                        where (cv.concept_full_name = 'CARGA VIRAL (Absoluto-Rotina)' or cv.concept_full_name = 'CARGA VIRAL (Absoluto-Suspeita)' )
                        and inob.value_numeric < 1000 
                        and (o.date_created >= DATE_SUB('#endDate#', INTERVAL 12 MONTH))
                        and inob.person_id=p.person_id)
    
    inner join
    concept_view cv
    on cv.concept_id = ob.concept_id
    and cv.concept_full_name = 'CARGA VIRAL (Absoluto-Suspeita)'
    
    inner join
    erpdrug_order erp1
    on erp1.patient_id=o.person_id
    and erp1.id = (select max(id) from erpdrug_order 
                      where
                         (ob.date_created <= DATE_SUB(erp1.dispensed_date, INTERVAL 3 MONTH))
                        and erpdrug_order.dispensed=1
                            and erpdrug_order.arv_dispensed=1
                            and erpdrug_order.first_arv_dispensed=1 and erpdrug_order.patient_id=erp1.patient_id)
    and 
    (
        (
            (o1.date_created >= DATE_SUB('#endDate#', INTERVAL 9 MONTH)) 
            and
        o1.obs_id = (
                    select max(obs_id) from obs 
                                                      inner join
                                                      concept_name conname
                                                      on obs.concept_id=conname.concept_id
                                                      where conname.name = 'Probable delivery date' and concept_name_type ='FULLY_SPECIFIED' and conname.locale ='en'                                                     
                                                      and conname.voided = 0  
                                                      and obs.voided = 0
                                                      and obs.person_id=o1.person_id

                    )
        )
        OR
        (
             (o1.date_created >= DATE_SUB('#endDate#', INTERVAL 9 MONTH))
             and
        o1.obs_id = (
                        select max(obs_id) from obs 
                                                      inner join
                                                      concept_name conname
                                                      on obs.concept_id=conname.concept_id
                                                      where conname.name = 'Pregnancy_Yes_No' and concept_name_type ='FULLY_SPECIFIED' and conname.locale ='en'                                                      
                                                      and obs.value_coded = (select concept_id from concept_view where concept_full_name = 'Pregnancy_Yes')
                                                      and conname.voided = 0
                                                       and obs.voided = 0
                                                      and obs.person_id=o1.person_id
                    )
        )
    )
    ) "Targeted Pregnant",

--  CARGA VIRAL (Absoluto-Rotina)
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') < 1 ) then 1 else NULL END) as "Routine M <1",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 1 and 4 ) then 1 else NULL END) as "Routine M 1-4",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 5 and 9 ) then 1 else NULL END) as "Routine M 5-9",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' AND p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 10 and 14 ) then 1 else NULL END) as "Routine M 10-14",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 15 and 19 ) then 1 else NULL END) as "Routine M 15-19",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 20 and 24 ) then 1 else NULL END) as "Routine M 20-24",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 25 and 29 ) then 1 else NULL END) as "Routine M 25-29",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 30 and 34 ) then 1 else NULL END) as "Routine M 30-34",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 35 and 39 ) then 1 else NULL END) as "Routine M 35-39",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 40 and 44 ) then 1 else NULL END) as "Routine M 40-44",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 45 and 49 ) then 1 else NULL END) as "Routine M 45-49",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') >= 50 ) then 1 else NULL END) as "Routine M >=50",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'M' and p.birthdate is NULL) then 1 else NULL END) as "Routine M Unknown age",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'M') then 1 else NULL END) as "Routine Male Subtotal",

   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') < 1 ) then 1 else NULL END) as "Routine F <1",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 1 and 4 ) then 1 else NULL END) as "Routine F 1-4",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 5 and 9 ) then 1 else NULL END) as "Routine F 5-9",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 10 and 14 ) then 1 else NULL END) as "Routine F 10-14",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 15 and 19 ) then 1 else NULL END) as "Routine F 15-19",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 20 and 24 ) then 1 else NULL END) as "Routine F 20-24",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 25 and 29 ) then 1 else NULL END) as "Routine F 25-29",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 30 and 34 ) then 1 else NULL END) as "Routine F 30-34",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 35 and 39 ) then 1 else NULL END) as "Routine F 35-39",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 40 and 44 ) then 1 else NULL END) as "Routine F 40-44",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 45 and 49 ) then 1 else NULL END) as "Routine F 45-49",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') >= 50 ) then 1 else NULL END) as "Routine F >=50" ,
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'F' and (p.birthdate is NULL)) then 1 else NULL END) as "Routine F Unknown age",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Rotina)' and p.gender = 'F') then 1 else NULL END) as "Routine Female Subtotal",

--  'CARGA VIRAL (Absoluto-Suspeita)'

   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') < 1 ) then 1 else NULL END) as "Targeted M <1",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 1 and 4 ) then 1 else NULL END) as "Targeted M 1-4",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 5 and 9 ) then 1 else NULL END) as "Targeted M 5-9",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 10 and 14 ) then 1 else NULL END) as "Targeted M 10-14",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 15 and 19 ) then 1 else NULL END) as "Targeted M 15-19",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 20 and 24 ) then 1 else NULL END) as "Targeted M 20-24",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 25 and 29 ) then 1 else NULL END) as "Targeted M 25-29",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 30 and 34 ) then 1 else NULL END) as "Targeted M 30-34",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 35 and 39 ) then 1 else NULL END) as "Targeted M 35-39",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 40 and 44 ) then 1 else NULL END) as "Targeted M 40-44",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 45 and 49 ) then 1 else NULL END) as "Targeted M 45-49",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'M' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') >= 50 ) then 1 else NULL END) as "Targeted M >=50",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'M' and p.birthdate is NULL) then 1 else NULL END) as "Targeted M Unknown age",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'M') then 1 else NULL END) as "Male Subtotal",

   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') < 1 ) then 1 else NULL END) as "Targeted F <1",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 1 and 4 ) then 1 else NULL END) as "Targeted F 1-4",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 5 and 9 ) then 1 else NULL END) as "Targeted F 5-9",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 10 and 14 ) then 1 else NULL END) as "Targeted F 10-14",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 15 and 19 ) then 1 else NULL END) as "Targeted F 15-19",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 20 and 24 ) then 1 else NULL END) as "Targeted F 20-24",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 25 and 29 ) then 1 else NULL END) as "Targeted F 25-29",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 30 and 34 ) then 1 else NULL END) as "Targeted F 30-34",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 35 and 39 ) then 1 else NULL END) as "Targeted F 35-39",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 40 and 44 ) then 1 else NULL END) as "Targeted F 40-44",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') BETWEEN 45 and 49 ) then 1 else NULL END) as "Targeted F 45-49",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'F' and TIMESTAMPDIFF( YEAR, p.birthdate, '#endDate#') >= 50 ) then 1 else NULL END) as "Targeted F >=50" ,
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'F' and (p.birthdate is NULL)) then 1 else NULL END) as "Targeted F Unknown age",
   count(case when  ( Viralload.test_name = 'CARGA VIRAL (Absoluto-Suspeita)' and p.gender = 'F') then 1 else NULL END) as "Female Subtotal",
   "" as "Data Check"
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
     Inner Join
      obs o 
      on o.person_id = p.person_id
      and o.voided = 0        
   Inner JOIN
      (
         select
            max(o.obs_id) as obs_id,o.date_created as viralCreateddate,
            cv.concept_full_name as "test_name"
         from
            person p
            Inner Join
               obs o
               on o.person_id = p.person_id
               and o.voided = 0
            Inner Join
               concept_view cv
               on o.concept_id = cv.concept_id
               and cv.retired = 0
               and (cv.concept_full_name = 'CARGA VIRAL (Absoluto-Rotina)' or cv.concept_full_name = 'CARGA VIRAL (Absoluto-Suspeita)')
               and o.value_numeric < 1000
               and (o.date_created >= DATE_SUB('#endDate#', INTERVAL 12 MONTH))
            
         group by
            p.person_id
      )
      as Viralload
      on Viralload.obs_id = o.obs_id
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
      and (Viralload.viralCreateddate <= DATE_SUB(erp.dispensed_date, INTERVAL 3 MONTH))
      where erp.id = (select max(id) from erpdrug_order 
                      where erpdrug_order.dispensed=1
                            and erpdrug_order.arv_dispensed=1
                            and erpdrug_order.first_arv_dispensed=1 and erpdrug_order.patient_id=erp.patient_id); 