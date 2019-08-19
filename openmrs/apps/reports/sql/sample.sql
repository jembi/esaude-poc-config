select
   patient_identity.identity_data  as "NID",
   CONCAT( person.first_name, ' ', COALESCE( person.middle_name, '' ), ' ', COALESCE( person.last_name, '' ) )as "Nome Completo ",
   case
      when
         patient.gender = 'M' 
      then
         'Male' 
      when
         patient.gender = 'F' 
      then
         'Female' 
      when
         patient.gender = 'O' 
      then
         'Other' 
   end
   as "Sexo",
   date_part('year',AGE(patient.birth_date)) as "Idade",
   person.Cell_phone AS "Contacto Principal",
   concat(GetProvince(person.id),' ',COALESCE(GetDistrict(person.id))) as "Morada(Província,Distrito)"
 
from
         person
         inner join 
         patient 
            on person.id=patient.person_id
         inner join
            sample_human 
            on patient.id = sample_human.patient_id 
         inner join
            patient_identity 
            on patient_identity.patient_id = patient.id
        inner join 
            patient_identity_type 
            on (patient_identity.identity_type_id = patient_identity_type.id 
            and patient_identity_type.identity_type = 'ST')
         inner join
            sample 
            on sample.id = sample_human.samp_id 
            and sample.accession_number != '' 
           
         inner join
            sample_item 
            on sample.id = sample_item.samp_id 
         inner join
            analysis 
            on analysis.sampitem_id = sample_item.id 
           
   left join
      (
         select
            analysis_id as rstID 
         from
            result 
      )
      as result2 
      on analysis.id = result2.rstID 
where
   result2.rstId is null;
   