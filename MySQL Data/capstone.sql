use  health_insurance_anlysis;
show tables;
select * from hospitalisation_details;
select * from medical_examinations;

-- we have Customer ID common in both the table
-- adding primary key to both table

desc hospitalisation_details;

-- rename column to remove space between them for a better analysis

alter table hospitalisation_details
rename column `Customer ID` to customer_id;

alter table hospitalisation_details
rename column `Hospital tier` to hospital_tier;

alter table hospitalisation_details
rename column `City tier` to city_tier;

alter table hospitalisation_details
rename column `State ID` to state_id;

-- adding primary key to customer by checking null and duplicate values

select * from hospitalisation_details
where 'customer_id' is  null;

-- so there is not any null value in column Customer ID


delete from hospitalisation_details
where customer_id ='?';

delete from hospitalisation_details
where state_id ='?';

delete from hospitalisation_details
where hospital_tier ='?';

delete from hospitalisation_details
where city_tier ='?';

select distinct 'customer_id', count(*) from hospitalisation_details;

alter table hospitalisation_details
modify customer_id varchar(255);

-- now adding primary key to column customer_id

alter table hospitalisation_details
add constraint pk_hospitalisation_details primary key(customer_id);

-- some prior operation on table medical_examinations
select * from medical_examinations;
desc medical_examinations;

alter table medical_examinations
rename column `Customer ID` to customer_id;

alter table medical_examinations
rename column `Heart Issues` to heart_issue;

alter table medical_examinations
rename column `Any Transplants` to any_transplants;

alter table medical_examinations
rename column `Cancer history` to cancer_history;

alter table medical_examinations
modify customer_id varchar(255);

alter table medical_examinations
add constraint pk_medical_examinations primary key(customer_id);

-- merging two table for further analysis as per project requirement

select * from hospitalisation_details hd
inner join medical_examinations me on hd.customer_id = me.customer_id;

/* Q.2 - Retrieve information about people who are diabetic and have heart problems with their average age, the average number
 of dependent children, average BMI, and average hospitalization costs    */
 
select me.HBA1C, me.heart_issue, avg(me.BMI) , avg(hd.children), avg(hd.charges) from hospitalisation_details hd
inner join medical_examinations me on hd.customer_id = me.customer_id
where me.HBA1C > 6.5 and me.heart_issue = 'yes'
group by me.HBA1C , me.heart_issue;


/* Q.3 Find the average hospitalization cost for each hospital tier and each city level  */

select hospital_tier,city_tier, avg(charges) as average_cost from hospitalisation_details
group by hospital_tier,city_tier;

/* Q.4 Determine the number of people who have had major surgery with a history of cancer   */

select count(NumberOfMajorSurgeries) as number_of_people from medical_examinations
where cancer_history ='Yes';

/* Q.5-Determine the number of tier-1 hospitals in each state  */

select state_id, count(hospital_tier) as tier_1_hospital from hospitalisation_details
where hospital_tier = 'tier - 1'
group by state_id;

-- END OF SQL PART OF PROJECT --