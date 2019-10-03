SELECT DISTINCT
       pi.identifier AS NID,
       Concat(IFNULL(pn.given_name, ''),'', IFNULL(pn.middle_name,''), ' ', IFNULL(pn.family_name,'')) AS Nome,
       p.gender AS Sexo,
       floor(datediff(now(), p.birthdate)/365) AS Idade,
       contact.contact AS 'Contacto Principal',
       concat (pa.state_province, ',', pa.city_village) AS Endereço,
       (
        select 
        concat(case
      when
         pss.patient_state = 'ABANDONED'
      then
         'Abandono'
      when
         pss.patient_state = 'ACTIVE'
      then
         'Activo em'
      when
         pss.patient_state = 'INACTIVE_DEATH'
      then
         'Inactive - Óbito'
      when
         pss.patient_state = 'INACTIVE_TRANSFERRED_OUT'
      then
         'Inactivo - Transferido Para'
      when
         pss.patient_state = 'INACTIVE_SUSPENDED'
      then
         'Inactivo - Suspenso'
   end,' ',
   case
      when
         pss.patient_status = 'Pre TARV'
      then
         'Pre-TARV'
      when
         pss.patient_status = 'TARV'
      then
         'TARV'
      when
         pss.patient_status = 'TARV_ABANDONED'
      then
         'TARV-Abandono'
      when
         pss.patient_status = 'TARV_TREATMENT_SUSPENDED'
      then
         'TARV-Tratamento Suspenso'
      when
         pss.patient_status = 'TARV_RESTART'
      then
         'TARV-Reinício'
   end )
       from patient_status_state pss inner join obs 
       on obs.person_id = pss.patient_id where patient_id=p.person_id and pss.patient_status='TARV_ABANDONED' limit 1
      ) AS 'Estado do Paciente',
       max(DATE(eod.dispensed_date)) AS 'Último Levantamento',
       max(DATE(missed_pickup.date_created)) AS 'Último Levantamento Perdido'
FROM orders o
JOIN order_type ot ON o.order_type_id = ot.order_type_id AND ot.uuid='131168f4-15f5-102d-96e4-000c29c2a5d7'
JOIN person p ON o.patient_id = person_id
JOIN person_name pn ON p.person_id = pn.person_id
JOIN person_address pa ON p.person_id = pa.person_id
JOIN
  (SELECT pat.person_id,
          pat.value AS contact
   FROM person_attribute pat
   JOIN person_attribute_type patt ON pat.person_attribute_type_id = patt.person_attribute_type_id
   WHERE patt.name = 'PRIMARY_CONTACT_NUMBER_1') contact ON p.person_id = contact.person_id
JOIN patient_identifier pi ON p.person_id = pi.patient_id
JOIN
  (SELECT pss.patient_id,
          pss.patient_state,
          pss.patient_status,
          pss.date_created
      FROM patient_status_state pss
      WHERE pss.patient_status='TARV_ABANDONED' and pss.id=(select max(id) from patient_status_state where patient_id=pss.patient_id)) patient_state ON patient_state.patient_id = p.person_id
LEFT JOIN
  (SELECT eo.patient_id,
          eo.dispensed,
          eo.dispensed_date
  FROM erpdrug_order eo WHERE arv_dispensed = true) eod ON eod.patient_id = p.person_id
LEFT JOIN
  (SELECT o.order_id,
          o.date_created,
          o.patient_id
      FROM orders o
      WHERE o.order_id NOT  IN
                        (SELECT order_id
                          FROM erpdrug_order WHERE erpdrug_order.patient_id = o.patient_id and arv_dispensed = true)) missed_pickup
                          ON missed_pickup.patient_id = p.person_id AND missed_pickup.date_created > patient_state.date_created
      
      WHERE cast(patient_state.date_created AS date) BETWEEN '#startDate#' AND '#endDate#'
      group by missed_pickup.patient_id,eod.patient_id;
