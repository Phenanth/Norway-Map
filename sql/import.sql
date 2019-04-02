mysqlimport --ignore-lines=1 --fields-terminated-by=| --columns='CAMPAIGN,SITE_ID,SITE_CODE,SAMPLE_DATE,SAMPLE_MATRIX,FRACTION,CHEMICAL_ID,CHEMICAL_NAME,ORGANISM_EXP,ORGANISM_TAX_ID_EXP,ORGANISM_GROUP_EXP,ORGANISM_GENDER_EXP,ORGANISM_LIFESTAGE_EXP,TISSUE_EXP,SPECIES_GROUP,ENDPOINT,EFFECT_DESCRIPTION,EFFECT_TYPE,TREND,CONC_MEDIAN_M,CONC_MEDIAN_G,CONC_COUNT,EC_RESPONSE_5P_M,EC_RESPONSE_5P_G,EC_RESPONSE_COUNT,Q_5P,Q_95P,Q_95CI,Q_MEDIAN,Q_AVG,Q_STDEV,Q_MAX,Q_MIN,CONC_DATA_TYPE,EFFECT_DATA_TYPE,AF,Q_LEVEL,Q_TYPE' --local -u root -p norway MV_ET_ENV_RQ_ALL_JOVA.dsv;

mysqlimport --ignore-lines=1 --fields-terminated-by='|' --local -u root -p norway MV_ET_ENV_RQ_ALL_JOVA.dsv;

create table `All_Jova` (id INT) ENGINE=MYISAM;
ALTER table All_Jova add column CAMPAIGN varchar(20);
ALTER table All_Jova add column SITE_ID decimal(10);
ALTER table All_Jova add column SITE_CODE varchar(20);
ALTER table All_Jova add column SAMPLE_DATE varchar(20);
ALTER table All_Jova add column SAMPLE_MATRIX varchar(20);
ALTER table All_Jova add column FRACTION varchar(20);
ALTER table All_Jova add column CHEMICAL_ID decimal(10);
ALTER table All_Jova add column CHEMICAL_NAME varchar(100);
ALTER table All_Jova add column ORGANISM_EXP varchar(20);
ALTER table All_Jova add column ORGANISM_TAX_ID_EXP varchar(20);
ALTER table All_Jova add column ORGANISM_GROUP_EXP varchar(20);
ALTER table All_Jova add column ORGANISM_GENDER_EXP varchar(20);
ALTER table All_Jova add column ORGANISM_LIFESTAGE_EXP varchar(20);
ALTER table All_Jova add column TISSUE_EXP varchar(20);
ALTER table All_Jova add column SPECIES_GROUP varchar(50);
ALTER table All_Jova add column ENDPOINT varchar(20);
ALTER table All_Jova add column EFFECT_DESCRIPTION varchar(20);
ALTER table All_Jova add column EFFECT_TYPE varchar(20);
ALTER table All_Jova add column TREND varchar(20);
ALTER table All_Jova add column CONC_MEDIAN_M decimal(64,30);
ALTER table All_Jova add column CONC_MEDIAN_G decimal(64,30);
ALTER table All_Jova add column CONC_COUNT decimal(10);
ALTER table All_Jova add column EC_RESPONSE_5P_M decimal(64,30);
ALTER table All_Jova add column EC_RESPONSE_5P_G decimal(64,30);
ALTER table All_Jova add column EC_RESPONSE_COUNT decimal(10);
ALTER table All_Jova add column Q_5P decimal(64,30);
ALTER table All_Jova add column Q_95P decimal(64,30);
ALTER table All_Jova add column Q_95CI varchar(50);
ALTER table All_Jova add column Q_MEDIAN decimal(64,30);
ALTER table All_Jova add column Q_AVG decimal(64,30);
ALTER table All_Jova add column Q_STDEV varchar(50);
ALTER table All_Jova add column Q_MAX decimal(64,30);
ALTER table All_Jova add column Q_MIN decimal(64,30);
ALTER table All_Jova add column CONC_DATA_TYPE varchar(20);
ALTER table All_Jova add column EFFECT_DATA_TYPE varchar(20);
ALTER table All_Jova add column AF decimal(64,30);
ALTER table All_Jova add column Q_LEVEL varchar(20);
ALTER table All_Jova add column Q_TYPE varchar(20);
alter table All_Jova drop column id;

select CAMPAIGN,SITE_ID,SITE_CODE,SAMPLE_DATE,SAMPLE_MATRIX from All_Jova;
select FRACTION,CHEMICAL_ID,CHEMICAL_NAME,ORGANISM_EXP,ORGANISM_TAX_ID_EXP from All_Jova;
select ORGANISM_GROUP_EXP,ORGANISM_GENDER_EXP,ORGANISM_LIFESTAGE_EXP,TISSUE_EXP,SPECIES_GROUP from All_Jova;
select ENDPOINT,EFFECT_DESCRIPTION,EFFECT_TYPE,TREND,CONC_MEDIAN_M from All_Jova;
select CONC_MEDIAN_G,CONC_COUNT,EC_RESPONSE_5P_M,EC_RESPONSE_5P_G,EC_RESPONSE_COUNT from All_Jova;
select Q_5P,Q_95P,Q_95CI,Q_MEDIAN,Q_AVG from All_Jova;
select Q_STDEV,Q_MAX,Q_MIN,CONC_DATA_TYPE,EFFECT_DATA_TYPE from All_Jova;
select AF,Q_LEVEL,Q_TYPE from All_Jova;

drop table All_Jova;

SET CHARACTER SET utf8;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 5.6\\Uploads\\MV_ET_ENV_RQ_ALL_JOVA.dsv"
INTO TABLE All_Jova
COLUMNS TERMINATED BY '|'
IGNORE 1 LINES;


COLUMNS TERMINATED BY '|'
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;


create table `Site_Jova` (id INT) ENGINE=MYISAM;
ALTER table Site_Jova add column CAMPAIGN varchar(20);
ALTER table Site_Jova add column SITE_ID decimal(10);
ALTER table Site_Jova add column SITE_CODE varchar(20);
ALTER table Site_Jova add column SAMPLE_DATE varchar(20);
ALTER table Site_Jova add column SAMPLE_MATRIX varchar(20);

ALTER table Site_Jova add column FRACTION varchar(20);
ALTER table Site_Jova add column ORGANISM_EXP varchar(20);
ALTER table Site_Jova add column ORGANISM_TAX_ID_EXP varchar(20);
ALTER table Site_Jova add column ORGANISM_GROUP_EXP varchar(20);
ALTER table Site_Jova add column ORGANISM_GENDER_EXP varchar(20);

ALTER table Site_Jova add column ORGANISM_LIFESTAGE_EXP varchar(20);
ALTER table Site_Jova add column TISSUE_EXP varchar(20);
ALTER table Site_Jova add column SPECIES_GROUP varchar(50);
ALTER table Site_Jova add column ENDPOINT varchar(20);
ALTER table Site_Jova add column EFFECT_DESCRIPTION varchar(20);

ALTER table Site_Jova add column EFFECT_TYPE varchar(20);
ALTER table Site_Jova add column TREND varchar(20);
ALTER table Site_Jova add column Q_TYPE varchar(20);
ALTER table Site_Jova add column Q_SELECT varchar(20);
ALTER table Site_Jova add column SUM_Q_5P decimal(64,30);

ALTER table Site_Jova add column SUM_Q_95P decimal(64,30);
ALTER table Site_Jova add column SUM_Q_95CI decimal(64,30);
ALTER table Site_Jova add column SUM_Q_MEDIAN decimal(64,30);
ALTER table Site_Jova add column SUM_Q_AVG decimal(64,30);
ALTER table Site_Jova add column SUM_Q_STDEV decimal(64,30);


ALTER table Site_Jova add column SUM_Q_MAX decimal(64,30);
ALTER table Site_Jova add column SUM_Q_MIN decimal(64,30);
ALTER table Site_Jova add column NO_OF_Q1 decimal(10);
ALTER table Site_Jova add column NO_OF_Q2 decimal(10);
ALTER table Site_Jova add column NO_OF_Q3 decimal(10);

ALTER table Site_Jova add column NO_OF_Q4 decimal(10);
ALTER table Site_Jova add column TOTAL decimal(10);
alter table Site_Jova drop column id;

drop table Site_Jova;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 5.6\\MV_ET_ENV_RQ_SITE_JOVA.dsv"
INTO TABLE Site_Jova
COLUMNS TERMINATED BY '|'
IGNORE 1 LINES;

select CAMPAIGN,SITE_ID,SITE_CODE,SAMPLE_DATE,SAMPLE_MATRIX from Site_Jova;
select FRACTION,ORGANISM_EXP,ORGANISM_TAX_ID_EXP,ORGANISM_GROUP_EXP,ORGANISM_GENDER_EXP from Site_Jova;
select ORGANISM_LIFESTAGE_EXP,TISSUE_EXP,SPECIES_GROUP,ENDPOINT,EFFECT_DESCRIPTION from Site_Jova;
select EFFECT_TYPE,TREND,Q_TYPE,Q_SELECT,SUM_Q_5P from Site_Jova;
select SUM_Q_95P,SUM_Q_95CI,SUM_Q_MEDIAN,SUM_Q_AVG,SUM_Q_STDEV from Site_Jova;
select SUM_Q_MAX,SUM_Q_MIN,NO_OF_Q1,NO_OF_Q2,NO_OF_Q3 from Site_Jova;
select NO_OF_Q4,TOTAL from Site_Jova;

truncate table Site_Jova;