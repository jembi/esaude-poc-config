select distinct
(pi.identifier) as "NID",
   CONCAT( pn.given_name, " ", COALESCE( pn.middle_name, '' ), " ", COALESCE( pn.family_name, '' ) )as "Nome Completo ",
   case
      when
         p.gender = 'M' 
      then
         'Masculino' 
      when
         p.gender = 'F' 
      then
         'Feminino' 
      when
         p.gender = 'O' 
      then
         'Outra' 
   end
   as "Sexo", TIMESTAMPDIFF( YEAR, p.birthdate, CURDATE() ) as "Idade",
   personAttributesonRegistration.value as "Contacto",
   paddress.state_province as "Província",
   paddress.city_village AS "Distrito",
   paddress.address1 AS "Localidade/Bairro",
   paddress.address3 AS "Quarteirão",
   paddress.address4 AS "Avenida/Rua",
   paddress.address5 AS "Nº da Casa",
   paddress.postal_code AS "Perto De",
   " " as "Estado Paciente",
   max(cast(o.date_created as date)) as "Data Último Levantamento",
   max(cast(pappointment.start_date_time as date)) as "Data Último Levantamento Perdido"
   
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
   LEFT JOIN
      person_attribute personAttributesonRegistration 
      on personAttributesonRegistration.person_id = p.person_id 
      and personAttributesonRegistration.voided = 0 
   INNER JOIN
      person_attribute_type personAttributeTypeonRegistration 
      on personAttributesonRegistration.person_attribute_type_id = personAttributeTypeonRegistration.person_attribute_type_id 
      and personAttributeTypeonRegistration.name = 'PRIMARY_CONTACT_NUMBER_1' 
   LEFT JOIN
      person_attribute pa 
      on pa.person_id = p.person_id 
      and pa.voided = 0 
   INNER JOIN
      person_attribute_type pat 
      on pa.person_attribute_type_id = pat.person_attribute_type_id 
      and personAttributeTypeonRegistration.name = 'PRIMARY_CONTACT_NUMBER_1' 
   inner JOIN
      concept_view cv 
      on pa.value = cv.concept_id 
      AND cv.retired = 0 
      and cv.concept_full_name = 'NEW_PATIENT'  
    LEFT OUTER JOIN
      person_address paddress 
      ON p.person_id = paddress.person_id 
      AND paddress.voided is false
    inner join 
        patient_appointment pappointment
        on pappointment.patient_id=pt.patient_id
        and pappointment.voided = 0
        and cast(pappointment.start_date_time as date) BETWEEN '#startDate#' and '#endDate#'
    left join
        appointment_service aservice
        on aservice.appointment_service_id = pappointment.appointment_service_id
        and aservice.name = 'Farmácia' 
        and pappointment.status <> 'CheckedIn'
        and pappointment.status <> 'Completed'
        and pappointment.status <> 'Scheduled'
        and aservice.voided = 0
        and aservice.appointment_service_id is null
    INNER JOIN
      obs o
      on p.person_id=o.person_id 
      and o.voided = 0
    inner join
        concept con
        on con.concept_id = o.concept_id
        and con.retired=0
    inner join
        concept_name conname
        on con.concept_id=conname.concept_id
        and conname.name = 'Dispensed'
        and conname.voided = 0
         group by o.person_id;