select
(select count(p.person_id) as "a-1" from person p join (select person_id, cn.name from person_attribute pa join concept_name cn on cn.concept_id = pa.value and cn.locale="en" and  cn.concept_name_type = "FULLY_SPECIFIED" and cn.name = 'Pre Tarv') p_status on p_status.person_id= p.person_id and  DATE(p.date_created) BETWEEN DATE_SUB(NOW(), INTERVAL 1 MONTH) AND NOW() ) as A11,
2 as A12,3 as A13,0 as A14,5 as A15,1 as A16,4 as A17,5 as A18,
(select count(p.person_id) as "a-1" from person p join (select person_id, cn.name from person_attribute pa join concept_name cn on cn.concept_id = pa.value and cn.locale="en" and  cn.concept_name_type = "FULLY_SPECIFIED" and cn.name = 'Pre Tarv') p_status on p_status.person_id= p.person_id and  DATE(p.date_created) BETWEEN  NOW() AND DATE_ADD(NOW(), INTERVAL 1 MONTH)) as A21,
2 as A22,3 as A23,0 as A24,5 as A25,1 as A26,4 as A27,5 as A28;
