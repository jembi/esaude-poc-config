select distinct
(pi.identifier) as "NID",
   CONCAT( pn.given_name, " ", COALESCE( pn.middle_name, '' ), " ", COALESCE( pn.family_name, '' ) )as "Nome Completo",
   case
      when
         p.gender = 'M' 
      then
         'Male' 
      when
         p.gender = 'F' 
      then
         'Female' 
      when
         p.gender = 'O' 
      then
         'Other' 
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
   " " as "Treatment Line", 
   cast(o.value_numeric as char)as "Value of the last Result of Viral Load",
   cast(o.date_created as date) as "Date of the last Result of Viral Load"
   
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
   Inner Join 
      obs o 
      on o.person_id=p.person_id and o.voided=0
       
   Inner JOIN (select max(o.obs_id) as obs_id
from person p Inner Join obs o on o.person_id=p.person_id and o.voided=0
   Inner Join concept_view cv on o.concept_id=cv.concept_id and cv.retired=0 
   and cv.concept_full_name = 'LO_ViralLoad' and o.value_numeric > 1000 
   and cast(o.date_created as date) <= '#endDate#'
   group by p.person_id) as Viralload on Viralload.obs_id=o.obs_id 
   LEFT OUTER JOIN
      person_address paddress 
      ON p.person_id = paddress.person_id 
      AND paddress.voided is false;
