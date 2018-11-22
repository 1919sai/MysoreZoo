----------SPECIES------------------
CREATE TABLE species (
species_id INT NOT NULL,
latin_name VARCHAR(50) NOT NULL,
common_name VARCHAR(50) NOT NULL,
quantity INT NOT NULL,
CONSTRAINT species_species_id_pk PRIMARY KEY (species_id)
);
-----------ANIMAL----------------
CREATE TABLE animal(
animal_id INT NOT NULL,
animal_name VARCHAR(25) NOT NULL,
DOB DATE NOT NULL,
species_id INT NOT NULL,
CONSTRAINT animal_animal_id_PK PRIMARY KEY (animal_id),
CONSTRAINT animal_species_id_fk FOREIGN KEY (species_id) REFERENCES species(species_id)
);
------------SUPPLIER-------------
CREATE TABLE supplr (
supplr_id INT NOT NULL,
supplrname VARCHAR(50) NOT NULL,
supplradrs VARCHAR(50) NOT NULL,
supplrcity VARCHAR(50) NOT NULL,
supplrstat CHAR(5) NOT NULL,
supplrctry VARCHAR(20) NOT NULL,
CONSTRAINT supplr_supplr_id_pk PRIMARY KEY (supplr_id)
);
-------------EXHIBIT-----------------
CREATE TABLE exhibit (
ex_id INT NOT NULL,
ex_name VARCHAR(50) NOT NULL,
ex_terrain VARCHAR(50) NOT NULL,
ex_description VARCHAR(75),
CONSTRAINT exhibit_ex_id_pk PRIMARY KEY (ex_id)
);
-----------------HABITAT---------------------
CREATE TABLE habitat (
habitat_id INT NOT NULL,
habitat_climate VARCHAR(50) NOT NULL,
habitat_avetemp INT NOT NULL,
CONSTRAINT habitat_habitat_id_pk PRIMARY KEY (habitat_id)
);
--------------------ANIMAL HOME-------------
CREATE TABLE an_home (
move_id INT NOT NULL,
move_qty INT NOT NULL,
date_entered DATE NOT NULL,
date_left DATE NOT NULL,
animal_id INT NOT NULL,
ex_id INT NOT NULL,
CONSTRAINT an_home_move_id_pk PRIMARY KEY (move_id),
CONSTRAINT an_home_animal_id_fk FOREIGN KEY (animal_id) REFERENCES animal(animal_id),
CONSTRAINT an_home_ex_id_fk FOREIGN KEY (ex_id) REFERENCES exhibit(ex_id)
);
-------------------HABITAT EXHIBIT--------------
CREATE TABLE habitat_exhibit (
habitat_id INT NOT NULL,
ex_id INT NOT NULL,
CONSTRAINT habitat_exhibit_habitat_id_pk PRIMARY KEY (habitat_id, ex_id),
CONSTRAINT habitat_exhibit_habitat_id_fk FOREIGN KEY (habitat_id) REFERENCES habitat(habitat_id),
CONSTRAINT habitat_exhibit_ex_id_fk FOREIGN KEY (ex_id) REFERENCES exhibit(ex_id)
);
------------------------SPECIES HABITAT---------------
CREATE TABLE species_habitat (
species_id INT NOT NULL,
habitat_id INT NOT NULL,
CONSTRAINT species_habitat_id_pk PRIMARY KEY (habitat_id, species_id),
CONSTRAINT species_habitat_id_fk FOREIGN KEY (habitat_id) REFERENCES habitat (habitat_id),
CONSTRAINT species_habitat_species_id_fk FOREIGN KEY (species_id) REFERENCES species(species_id)
);
---------------------SPECIES SUPPLIER--------------
CREATE TABLE species_supplier (
supplr_id INT NOT NULL,
species_id INT NOT NULL,
CONSTRAINT species_supplier_supplr_id_pk PRIMARY KEY (species_id, supplr_id),
CONSTRAINT species_supplier_supplr_id_fk FOREIGN KEY (supplr_id) REFERENCES supplr (supplr_id),
CONSTRAINT species_supplier_species_id_fk FOREIGN KEY (species_id) REFERENCES species
(species_id)
);
------------------------SHIPMENT-------------
CREATE TABLE shipment (
shipment_id INT NOT NULL,
ship_date DATE NOT NULL,
QTY INT NOT NULL,
supplr_id INT NOT NULL,
animal_id INT NOT NULL,
CONSTRAINT shipment_shipment_id_pk PRIMARY KEY (shipment_id),
CONSTRAINT shipment_animal_id_fk FOREIGN KEY (animal_id) REFERENCES animal (animal_id),
CONSTRAINT shipment_supplr_id_fk FOREIGN KEY (supplr_id) REFERENCES supplr (supplr_id)
);
--------------FOOD--------
CREATE TABLE food_inv (
food_id INT NOT NULL,
food_name VARCHAR(50) NOT NULL,
food_rop INT NOT NULL,
supplr_id INT NOT NULL,
CONSTRAINT food_inv_food_id_pk PRIMARY KEY (food_id),
CONSTRAINT food_inv_supplr_id_fk FOREIGN KEY (supplr_id) REFERENCES supplr (supplr_id)
);
------------------FEEDING SCHEDULE--------------
CREATE TABLE feeding_sched (
feed_id INT NOT NULL,
Time_Interval INT NOT NULL,
food_source VARCHAR(75) NOT NULL,
feed_amount VARCHAR(75) NOT NULL,
food_id INT NOT NULL,
animal_id INT NOT NULL,
CONSTRAINT feeding_sched_feeding_id_pk PRIMARY KEY (feed_id),
CONSTRAINT feeding_sched_animal_id_fk FOREIGN KEY (animal_id) REFERENCES animal (animal_id),
CONSTRAINT feeding_sched_food_id_fk FOREIGN KEY (food_id) REFERENCES food_inv (food_id)
);
-----------MAINTASK-----------
CREATE TABLE maintask (
main_id INT NOT NULL,
taskname VARCHAR(50) NOT NULL,
maindesc VARCHAR(50) NOT NULL,
CONSTRAINT maintask_main_id_pk PRIMARY KEY (main_id)
);
------------EMPLOYEE------------------------
CREATE TABLE employee(
emp_id INT,
emp_fName VARCHAR(25),
emp_lName VARCHAR(25),
CONSTRAINT employee_emp_id_PK PRIMARY KEY (emp_id)
);
-------------------EMPLOYEE MAINTAIN EXHIBIT------------
CREATE TABLE eme (
EME_id INT NOT NULL,
emp_id INT NOT NULL,
ex_id INT NOT NULL,
main_id INT NOT NULL,
day_maint VARCHAR(20) NOT NULL,
CONSTRAINT eme_eme_pk PRIMARY KEY (EME_id),
CONSTRAINT eme_employida_fk FOREIGN KEY (emp_id) REFERENCES employee (emp_id),
CONSTRAINT eme_exhibitida_fk FOREIGN KEY (ex_id) REFERENCES exhibit (ex_id),
CONSTRAINT eme_maintida_fk FOREIGN KEY (main_id) REFERENCES maintask (main_id)
);

----------------ZIPCODE------------------
CREATE TABLE zipcode (
zip_code VARCHAR(10) NOT NULL,
city VARCHAR(50) NOT NULL,
state CHAR(2) DEFAULT 'IL' NOT NULL,
CONSTRAINT zip_code_pk PRIMARY KEY (zip_code)
);

---------------------PERSON-----------------
CREATE TABLE person (
persid INT NOT NULL,
persfrst VARCHAR(50) NOT NULL,
perslast VARCHAR(50) NOT NULL,
persadrs VARCHAR(50) NOT NULL,
persdob DATE NOT NULL,
persemal VARCHAR(50) NOT NULL,
persmemb CHAR (1) NOT NULL,
zip_code VARCHAR(10) NOT NULL,
CONSTRAINT person_persid_pk PRIMARY KEY (persid),
CONSTRAINT person_persmemb_cc CHECK (persmemb IN ('Y', 'N')),
CONSTRAINT fk_person_zipcode FOREIGN KEY (zip_code) REFERENCES zipcode (zip_code)
);
---------------------DONATION---------------
CREATE TABLE donate (
donate_id INT NOT NULL,
amount INT NOT NULL,
donate_date DATE NOT NULL,
persid INT NOT NULL,
CONSTRAINT donate_donateid_pk PRIMARY KEY (donate_id),
CONSTRAINT fk_person_persid FOREIGN KEY (persid) REFERENCES person (persid)
);
-----------------------CONTACT(PERSON CONTACT)---------
CREATE TABLE contact (
contact_id INT NOT NULL,
contact_num INT NOT NULL,
contact_type VARCHAR(50) NOT NULL,
best_contact CHAR (2) NOT NULL,
persid INT NOT NULL,
CONSTRAINT contact_contactid_pk PRIMARY KEY (contact_id),
CONSTRAINT contact_bestcontact_cc CHECK (best_contact IN ('Y','N')),
CONSTRAINT fk_contact_persid FOREIGN KEY (persid) REFERENCES person (persid)
);
--------------------JOBS---------------
CREATE TABLE jobs(
jobid INT NOT NULL,
jobname VARCHAR(20) NOT NULL,
jobminage INT NOT NULL,
CONSTRAINT jobs_jobid_pk PRIMARY KEY (jobid)
);

-----------------VOLUNTEER INFO------------------
CREATE TABLE vol_info (
info_id INT NOT NULL,
start_date DATE NOT NULL,
howfindout VARCHAR(100) NOT NULL,
whyvolun VARCHAR(100) NOT NULL,
conserveorg VARCHAR(50) NOT NULL,
persid INT NOT NULL,
CONSTRAINT vol_infoz_sp_pk PRIMARY KEY (info_id),
CONSTRAINT fk_volinfo_persid FOREIGN KEY (persid) REFERENCES person (persid)
);
-----------------------JOB LOCATION-------------------
CREATE TABLE joblocate (
locateid INT NOT NULL,
locatename VARCHAR(25) NOT NULL,
CONSTRAINT joblocate_locateid_pk PRIMARY KEY (locateid)
);
-------------------WORK SCHEDULE---------------
CREATE TABLE wrksch(
wrkschid INT NOT NULL,
wrkstrd DATE NOT NULL,
wrkendd DATE NOT NULL,
persid INT NOT NULL,
jobid INT NOT NULL,
locateid INT NOT NULL,
CONSTRAINT wrksch_wrkschid_pk PRIMARY KEY (wrkschid),
CONSTRAINT fk_person_persidb FOREIGN KEY (persid) REFERENCES person (persid),
CONSTRAINT fk_jobs_jobidb FOREIGN KEY (jobid) REFERENCES jobs (jobid),
CONSTRAINT fk_joblocate_locateidb FOREIGN KEY (locateid) REFERENCES joblocate (locateid)
);









INSERT QUERIES-
insert into species values(1,'Pan Troglodytes', 'Common Chimpanzee', 12);
INSERT INTO species
VALUES (2, 'Panthera Tigris Tigris', 'Bengal Tiger', 6);
INSERT INTO species
VALUES (3 'Panthera Leo', 'Lion', 9);
INSERT INTO species
VALUES (4, 'UrsusMaritimus', 'Polar Bear', 7);
INSERT INTO species
VALUES (5, 'Loxodonta Africana', 'African Bush Elephant', 3);
INSERT INTO species
VALUES (6,'Tursiops truncatus', 'Bottlenosed Dolphin', 2);
---------------------------------------------
INSERT INTO animal
VALUES(11,'Chimpy','2016-09-15',1);
INSERT INTO animal
VALUES( 12,'Frisky Tiger','2016-02-10',2);
INSERT INTO animal
VALUES(13,'Lame Lion','2016-11-15',3);
INSERT INTO animal
VALUES(14, 'Polorizer','2016-01-09',4);
INSERT INTO animal
VALUES(15,'Egor the Elephant','2017-01-23',5);
INSERT INTO animal
VALUES(16,'Dolphy the Dolphin','2016-12-15' ,6);
--------------------------------------------
INSERT INTO supplr VALUES(21,'Animal Food and Stuff', '4780 Benz circle', 'vijayawada','AP','India')
INSERT INTO supplr
VALUES(22,'Random Supplier Person', '4827 Mlk street', 'Mysore',
'KT','India');
INSERT INTO supplr
VALUES(23,'Parvez.', '4561 GVS nagar', 'Hampi', 'KT','India');
INSERT INTO supplr
VALUES(324,'virat', '523 Kvp colony', 'Mysore', 'KT','India');
INSERT INTO supplr
VALUES(25,'Dhoni', '1277 Svp Street', 'Bengaluru', 'KT','India');
INSERT INTO supplr
VALUES(26,'chriss lynn', '3062 Gardens','Hyderabad', 'TL','India');
----------------------------------------------------
INSERT INTO exhibit
VALUES (31, 'Regenstein Wolf Woods', 'Forest', 'Wooded Forest');
INSERT INTO exhibit
VALUES (32, 'The Swamp', 'Swamp', 'low land swamp');
INSERT INTO exhibit
VALUES (33,'Australia House', 'Field', 'Flat Land Plains');
INSERT INTO exhibit
VALUES (34,'Hoofed Animals', 'Field', 'Flat Land Plains');
INSERT INTO exhibit
VALUES (35,'Salt Creek Wilderness', 'Wooded with Salt Water', 'Some wood area with a
salt water pond');
INSERT INTO exhibit
VALUES (36,'Pachyderm House', 'Indoor or Field', 'Come in during the winter when its
cold and in the field during the summer');
---------------------------------------------------------
INSERT INTO habitat
VALUES (41, 'Aquatic', '88');
INSERT INTO habitat
VALUES (42, 'Wetland', '65');
INSERT INTO habitat
VALUES (43, 'Swamp', '60');
INSERT INTO habitat
VALUES (44, 'Tropical', '90');
INSERT INTO habitat
VALUES (45, 'Desert', '99');
INSERT INTO habitat
VALUES (46, 'Pine Forest', '50');
------------------------------------------------------------
INSERT INTO an_home less values(2)
Values(52, 55,'2014-09-11','2016-09-07',12,32);
INSERT INTO an_home
Values(54, 72,'2013-10-10','2015-11-03',14,34);
INSERT INTO an_home
Values(55, 99,'2015-10-11','2016-11-01',15,35);
INSERT INTO an_home
Values(56, 28,'2014-12-10','2015-11-10',16,36);
------------------------------------
INSERT INTO habitat_exhibit
VALUES(41,31);
INSERT INTO habitat_exhibit
VALUES(42,32);
INSERT INTO habitat_exhibit
VALUES(43,33);
INSERT INTO habitat_exhibit
VALUES(44,34);
INSERT INTO habitat_exhibit
VALUES(45,35);
INSERT INTO habitat_exhibit
VALUES(46,36);
-----------------------------------------------
INSERT INTO species_habitat less values(1)
VALUES (1,41);
INSERT INTO species_habitat
VALUES (2,42);
INSERT INTO species_habitat
VALUES (4,44);
INSERT INTO species_habitat
VALUES (5,45);
INSERT INTO species_habitat
VALUES (6,46);
-------------------------------------------------------
INSERT INTO species_supplier
VALUES(21,1);
INSERT INTO species_supplier
VALUES(22,2);
INSERT INTO species_supplier
VALUES(23,3);
INSERT INTO species_supplier
VALUES(24,4);
INSERT INTO species_supplier
VALUES(25,5);
INSERT INTO species_supplier
VALUES(26,6);
--------------------------------------------------------
INSERT INTO shipment
VALUES(61,'2016-12-11',2300,21,11);
INSERT INTO shipment
VALUES(62,'2015-02-10',2300,22,12);
INSERT INTO shipment
VALUES(63,'2016-10-19',2300,23,13);
INSERT INTO shipment
VALUES(64,'2015-12-21',2300,24,14);
INSERT INTO shipment
VALUES(65,'2015-10-14',2300,25,15);
INSERT INTO shipment
VALUES(66,'2016-02-10',2300,26,16);
----------------------------------------------
INSERT INTO food_inv
VALUES (71, 'oats', 8000,21);
INSERT INTO food_inv
VALUES (72, 'peanuts', 6000,22);
INSERT INTO food_inv
VALUES (73, 'bananas', 6000,23);
INSERT INTO food_inv
VALUES (74, 'carrots', 3000,24);
INSERT INTO food_inv
VALUES (75, 'herring', 750,25);
INSERT INTO food_inv
VALUES (76, 'squid',750,26);
---------------------------------------------------------
INSERT INTO feeding_sched
VALUES (81, 3 , 'Warehouse 2', '3 pounds',71,11);
INSERT INTO feeding_sched
VALUES (82, 5 , 'Warehouse 5', '10pounds',72,12);
INSERT INTO feeding_sched
VALUES (83, 1 , 'Warehouse 2', '15pounds',73,13);
INSERT INTO feeding_sched
VALUES (84, 4 , 'Warehouse 3', '2 pounds',74,14);
INSERT INTO feeding_sched
VALUES (85, 1 , 'Warehouse 1', '25 pounds',75,15 );
INSERT INTO feeding_sched
VALUES (86, 2 , 'Warehouse 2', '4 pounds',76,16);
---------------------------------------------------
INSERT INTO maintask
VALUES (91, 'Waste Pickup', 'Discard animal waste');
INSERT INTO maintask
VALUES (92, 'Water Fill', 'Fill animal containters');
INSERT INTO maintask
VALUES (93, 'Welfare Check', 'Check all animals');
INSERT INTO maintask
VALUES (94, 'Lighting', 'Replace Bulbs');
INSERT INTO maintask
VALUES (95, 'Disinfect', 'Wipe all exhibits');
INSERT INTO maintask
VALUES (96, 'Clean', 'Wash Out animal feeding areas');
---------------------------------------------
INSERT INTO employee    
VALUES(101, 'arun', 'chakravarti');
INSERT INTO employee
VALUES(102, 'akhila', 'thota');
INSERT INTO employee
VALUES(103, 'shankar', 'bhavani');
INSERT INTO employee
VALUES(104, 'navya', 'krishna');
INSERT INTO employee
VALUES(105, 'krishna', 'sai');
INSERT INTO employee
VALUES(106, 'akhila', 'bezawada');
INSERT INTO employee    
VALUES(107, 'sai', 'pedavalli');
INSERT INTO employee
VALUES(108, 'vatsav', 'Chevuru');
INSERT INTO employee
VALUES(109, 'pranavi', 'Muvva');
INSERT INTO employee
VALUES(110, 'harikiran', 'vege');
INSERT INTO employee
VALUES(111, 'datta', 'madhira');
INSERT INTO employee
VALUES(112, 'akhil', 'maddu');
------------------------------------------------------
INSERT INTO eme
VALUES (111,101,31,91,'2016-09-12');
INSERT INTO eme
VALUES (112,102,32,92,'2016-10-01');
INSERT INTO eme
VALUES (113,103,33,93,'2015-12-26');
INSERT INTO eme
VALUES (114,104,34,94,'2016-08-11');
INSERT INTO eme
VALUES (115,105,35,95,'2017-01-11' );
INSERT INTO eme
VALUES (116,106,36,96,'2016-11-29');
-------------------------------------------------
INSERT INTO Zipcode
VALUES ('522509','Downing','WI');
INSERT INTO Zipcode
VALUES ('55555','Chicago','IL');
INSERT INTO Zipcode
VALUES ('60513','Brookfield','IL');
INSERT INTO Zipcode
VALUES ('77355','Minneapolis','MN');
INSERT INTO Zipcode
VALUES ('55098','Platt','WI');
INSERT INTO Zipcode
VALUES ('25434','Phoenix','AZ');
-----------------------------------------------------
INSERT INTO person 
VALUES (121,'koneru', 'harin', '224 7th Str','2016-03-23',
'kluniversity@gmail.com', 'Y','25434');
INSERT INTO person
VALUES (122,'kovvu', 'satyakalyan', '244 1st Str','2016-12-12',
'satyakalyan@gmail.com', 'Y','55098');
INSERT INTO person
VALUES (123,'vege', 'harikiran', '24 Main Str','2016-11-03',
'harikiranvege@gmail.com', 'N','55555');
INSERT INTO person
VALUES (124,'chevuru', 'vatsav', '371 Oak Ave Apt 3','2016-11-10',
'srivatsavchevuru@gmail.com', 'N','77355');
INSERT INTO person
VALUES (125,'muvva', 'pranavi', '872 Pennsylvania Ave','2016-12-22',
'pranavimuvva@gmail.com', 'Y','55098');
INSERT INTO person
VALUES (126,'pedavalli', 'sai', '6667 London Str','2017-01-23',
'sai@yahoo.com', 'N','55555');
-----------------------------------------------------------

INSERT INTO donate
VALUES (131,23000,'2015-12-12',121 );
INSERT INTO donate
VALUES (132,33000,'2016-11-10',122 );
INSERT INTO donate
VALUES (133,29500,'2017-01-12',123 );
INSERT INTO donate
VALUES (134,13000,'2016-09-21',124 );
INSERT INTO donate
VALUES (135,38000,'2015-01-19',125 );
INSERT INTO donate
VALUES (136,19000,'2016-11-10',126 );

-----------------------------------------------
INSERT INTO contact
VALUES (141,'88909855', 'Primary', 'Y',121);
INSERT INTO contact
VALUES (142,'91345678', 'Secondary', 'N',122);
INSERT INTO contact
VALUES (143,'99432312', 'Primary', 'Y',123);
INSERT INTO contact
VALUES (144,'87898909', 'Primary', 'Y',124);
INSERT INTO contact
VALUES (145,'73567898', 'Primary', 'Y',125);
INSERT INTO contact
VALUES (146,'86567854', 'Secondary', 'N',126);
-----------------------------------------------------------
INSERT INTO vol_info
VALUES (161,'2016-12-09','Newspaper Ad', 'I love animals', 'Yes, World
Wildlife Fund', 121);
INSERT INTO vol_info
VALUES (162,'2016-12-12','Word of Mouth', 'I need service learning for
school', 'Yes, Sierra Club',122);
INSERT INTO vol_info
VALUES (163,'2016-10-19','Internet', 'I''m trying to earn a merit badge',
'None',123);
INSERT INTO vol_info
VALUES (164,'2017-01-19','I''ve been coming to the zoo for years and asked', 'I
want to do something with my family', 'None',124);
INSERT INTO vol_info
VALUES (165,'2016-10-29','Reccommended by family', 'I love animals', 'Yes,
World Wildlife Fund and Sierra Club',125);
INSERT INTO vol_info
VALUES (166,'2016-01-11','Friend works at the zoo', 'I grew up at the zoo and
want to give back', 'None',126);
----------------------------------------------------
INSERT INTO jobs 
VALUES (151','Lead tours',18);
INSERT INTO jobs 
VALUES (152,'Clean exhibits', 18);
INSERT INTO jobs 
VALUES (153,'Kid supervision', 18);
INSERT INTO jobs 
VALUES (154,'Run Consessions', 18);
INSERT INTO jobs 
VALUES (155,'Career ladder', 14);
INSERT INTO jobs 
VALUES (156,'Train Animals',18);
-------------------------------------
INSERT INTO joblocate
VALUES (1171,'Great Bear Wilderness');
INSERT INTO joblocate
VALUES (1172,'Discovery Center');
INSERT INTO joblocate
VALUES (1173,'Wolf Woods');
INSERT INTO joblocate
VALUES (1174,'Seven Seas');
INSERT INTO joblocate
VALUES (1175,'Childrens Zoo');
INSERT INTO joblocate
VALUES (1176,'Tropic World');
--------------------------------------
INSERT INTO wrksch VALUES (181,'2016-12-13','2016-12-20',121,151,1171);
INSERT INTO wrksch VALUES (182,'2016-09-02','2016-09-09',122,152,1172);
INSERT INTO wrksch
VALUES (183,'2016-09-19','2016-09-25',123,153,1173);
INSERT INTO wrksch
VALUES (184,'2017-01-23','2017-01-30',124,154,1174);
INSERT INTO wrksch
VALUES (185,'2016-10-10','2016-10-27',125,155,175);
INSERT INTO wrksch
VALUES (186,'2016-11-20','2016-11-27',126,156,1176);
