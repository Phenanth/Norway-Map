分析参考数据

不同SPECIES_GROUP的分类下分别有多少条数据
SELECT SPECIES_GROUP, count(SPECIES_GROUP) FROM Site_Jova 
WHERE SPECIES_GROUP IN (SELECT DISTINCT SPECIES_GROUP FROM Site_Jova)
GROUP BY SPECIES_GROUP;

```
mysql> SELECT SPECIES_GROUP, count(SPECIES_GROUP) FROM Site_Jova
    -> WHERE SPECIES_GROUP IN (SELECT DISTINCT SPECIES_GROUP FROM Site_Jova)
    -> GROUP BY SPECIES_GROUP;
+---------------------------------+----------------------+
| SPECIES_GROUP                   | count(SPECIES_GROUP) |
+---------------------------------+----------------------+
| "Algae, Moss, Fungi"            |               356722 |
| "Amphibians"                    |               344030 |
| "Bacteria"                      |                15416 |
| "Coelenterates"                 |                 3706 |
| "Crustaceans"                   |               490636 |
| "Fish"                          |               715120 |
| "Flowers, Trees, Shrubs, Ferns" |               275046 |
| "Insects/Spiders"               |               325962 |
| "Invertebrates"                 |               163878 |
| "Miscellaneous"                 |                62554 |
| "Molluscs"                      |               321194 |
| "Protozoans"                    |                 7892 |
| "Worms"                         |               130460 |
+---------------------------------+----------------------+
```

不同SITE_CODE的分类下分别有多少条数据
SELECT SITE_CODE, count(SITE_CODE) FROM Site_Jova 
WHERE SITE_CODE IN (SELECT DISTINCT SITE_CODE FROM Site_Jova)
GROUP BY SITE_CODE;
```
mysql> SELECT SITE_CODE, count(SITE_CODE) FROM Site_Jova
    -> WHERE SITE_CODE IN (SELECT DISTINCT SITE_CODE FROM Site_Jova)
    -> GROUP BY SITE_CODE;
+---------------+------------------+
| SITE_CODE     | count(SITE_CODE) |
+---------------+------------------+
| "HEIA"        |           540522 |
| "HOTRAN"      |           482324 |
| "M?RDRE"      |           526962 |
| "SKUTERUD"    |           581114 |
| "TIME"        |           540274 |
| "VASSHAGLONA" |           541420 |
+---------------+------------------+
```

SITE_CODE对应的SITE_ID
SELECT DISTINCT SITE_CODE, SITE_ID FROM Site_Jova;
```
mysql> SELECT DISTINCT SITE_CODE, SITE_ID FROM Site_Jova;
+---------------+---------+
| SITE_CODE     | SITE_ID |
+---------------+---------+
| "HEIA"        |     261 |
| "HOTRAN"      |     262 |
| "M?RDRE"      |     263 |
| "SKUTERUD"    |     264 |
| "TIME"        |     265 |
| "VASSHAGLONA" |     266 |
+---------------+---------+
6 rows in set (3.47 sec)
```

每个ENDPOINT对应的SPECIES_GROUP
SELECT SITE_CODE, ENDPOINT, SPECIES_GROUP FROM Site_Jova WHERE ENDPOINT IN (SELECT DISTINCT ENDPOINT FROM Site_Jova) GROUP BY ENDPOINT, SITE_CODE, ENDPOINT;
```
> 太长了不复制了
```


每个ENDPOINT对应的SPECIES_GROUP的种类有几种
SELECT count(DISTINCT SPECIES_GROUP), ENDPOINT FROM Site_Jova WHERE ENDPOINT IN (SELECT DISTINCT ENDPOINT FROM Site_Jova) GROUP BY ENDPOINT;
```
mysql> SELECT count(DISTINCT SPECIES_GROUP), ENDPOINT FROM Site_Jova WHERE ENDPOINT IN (SELECT DISTINCT ENDPOINT FROM Site_Jova) GROUP BY ENDPOINT;
+-------------------------------+-----------+
| count(DISTINCT SPECIES_GROUP) | ENDPOINT  |
+-------------------------------+-----------+
|                             9 | "BCF"     |
|                             1 | "EC0"     |
|                             6 | "EC10"    |
|                             1 | "EC100"   |
|                             1 | "EC25"    |
|                            12 | "EC50"    |
|                             3 | "EC90"    |
|                             1 | "ET50"    |
|                             1 | "IC10"    |
|                             3 | "IC25"    |
|                             4 | "IC50"    |
|                             6 | "LC0"     |
|                             1 | "LC01"    |
|                             2 | "LC05"    |
|                             4 | "LC10"    |
|                             8 | "LC100"   |
|                             3 | "LC20"    |
|                             1 | "LC25"    |
|                            10 | "LC50"    |
|                             1 | "LC70"    |
|                             2 | "LC80"    |
|                             2 | "LC90"    |
|                             1 | "LC95"    |
|                             1 | "LC99"    |
|                             5 | "LD50"    |
|                             1 | "LETC"    |
|                            10 | "LOEC"    |
|                             9 | "LOEL"    |
|                             1 | "LT10"    |
|                             7 | "LT50"    |
|                             1 | "LT90"    |
|                             3 | "MATC"    |
|                            13 | "NOEC"    |
|                            10 | "NOEL"    |
|                            10 | "NR"      |
|                            10 | "NR-LETH" |
|                             8 | "NR-ZERO" |
+-------------------------------+-----------+
```


mysql> select distinct CAMPAIGN from site_jova;
+----------+
| CAMPAIGN |
+----------+
| "JOVA"   |
+----------+
1 row in set (5.02 sec)

mysql> select distinct SITE_CODE, SITE_ID from site_jova group by SITE_CODE;
+---------------+---------+
| SITE_CODE     | SITE_ID |
+---------------+---------+
| "HEIA"        |     261 |
| "HOTRAN"      |     262 |
| "M?RDRE"      |     263 |
| "SKUTERUD"    |     264 |
| "TIME"        |     265 |
| "VASSHAGLONA" |     266 |
+---------------+---------+
6 rows in set (4.83 sec)

mysql> select distinct ENDPOINT from site_jova;
+-----------+
| ENDPOINT  |
+-----------+
| "EC50"    |
| "LC50"    |
| "NOEC"    |
| "NOEL"    |
| "NR"      |
| "NR-LETH" |
| "BCF"     |
| "LOEC"    |
| "LOEL"    |
| "LC95"    |
| "IC50"    |
| "NR-ZERO" |
| "LD50"    |
| "MATC"    |
| "LC10"    |
| "IC10"    |
| "EC100"   |
| "LC100"   |
| "LC0"     |
| "EC10"    |
| "LC05"    |
| "LT50"    |
| "LC20"    |
| "ET50"    |
| "LC80"    |
| "LC25"    |
| "EC25"    |
| "LT90"    |
| "EC90"    |
| "LC99"    |
| "IC25"    |
| "LC90"    |
| "LT10"    |
| "LC70"    |
| "LETC"    |
| "EC0"     |
| "LC01"    |
+-----------+
37 rows in set (4.79 sec)

select distinct SAMPLE_DATE from site_jova;
省略
218 rows in set (4.76 sec)

mysql> select distinct SPECIES_GROUP from site_jova;
+---------------------------------+
| SPECIES_GROUP                   |
+---------------------------------+
| "Algae, Moss, Fungi"            |
| "Amphibians"                    |
| "Crustaceans"                   |
| "Fish"                          |
| "Insects/Spiders"               |
| "Molluscs"                      |
| "Worms"                         |
| "Flowers, Trees, Shrubs, Ferns" |
| "Invertebrates"                 |
| "Miscellaneous"                 |
| "Bacteria"                      |
| "Coelenterates"                 |
| "Protozoans"                    |
+---------------------------------+
13 rows in set (4.24 sec)

mysql> select distinct EFFECT_TYPE from site_jova;
+-------------+
| EFFECT_TYPE |
+-------------+
| "CHRONIC"   |
| "ACUTE"     |
| "MOA"       |
| "ADME"      |
| "BEHAVIOR"  |
| "NC"        |
+-------------+
6 rows in set (4.88 sec)

mysql> select distinct TREND from site_jova;
+-------+
| TREND |
+-------+
| "DEC" |
| "INC" |
| "NC"  |
| "NEF" |
| "NR"  |
| "CHG" |
+-------+
6 rows in set (4.83 sec)


SELECT count(DISTINCT ENDPOINT), SPECIES_GROUP FROM Site_Jova WHERE SPECIES_GROUP IN (SELECT DISTINCT SPECIES_GROUP FROM Site_Jova) GROUP BY SPECIES_GROUP;
```
mysql> SELECT count(DISTINCT ENDPOINT), SPECIES_GROUP FROM Site_Jova WHERE SPECIES_GROUP IN (SELECT DISTINCT SPECIES_GROUP FROM Site_Jova) GROUP BY SPECIES_GROUP;
+--------------------------+---------------------------------+
| count(DISTINCT ENDPOINT) | SPECIES_GROUP                   |
+--------------------------+---------------------------------+
|                       15 | "Algae, Moss, Fungi"            |
|                       14 | "Amphibians"                    |
|                        2 | "Bacteria"                      |
|                        1 | "Coelenterates"                 |
|                       25 | "Crustaceans"                   |
|                       26 | "Fish"                          |
|                       15 | "Flowers, Trees, Shrubs, Ferns" |
|                       18 | "Insects/Spiders"               |
|                       13 | "Invertebrates"                 |
|                        8 | "Miscellaneous"                 |
|                       17 | "Molluscs"                      |
|                        2 | "Protozoans"                    |
|                       16 | "Worms"                         |
+--------------------------+---------------------------------+
13 rows in set (26.22 sec)
```
Fish最多，为26种，SPECIES_GROUP定为Fish


SELECT count(DISTINCT ENDPOINT), EFFECT_TYPE FROM Site_Jova WHERE EFFECT_TYPE IN (SELECT DISTINCT EFFECT_TYPE FROM Site_Jova) GROUP BY EFFECT_TYPE;
```
mysql> SELECT count(DISTINCT ENDPOINT), TREND FROM Site_Jova WHERE TREND IN (SELECT DISTINCT TREND FROM Site_Jova) GROUP BY TREND;
+--------------------------+-------+
| count(DISTINCT ENDPOINT) | TREND |
+--------------------------+-------+
|                        8 | "CHG" |
|                       18 | "DEC" |
|                       27 | "INC" |
|                       10 | "NC"  |
|                        5 | "NEF" |
|                       23 | "NR"  |
+--------------------------+-------+
6 rows in set (18.08 sec)
```
INC最多，为27，定为INC

SELECT count(DISTINCT ENDPOINT), EFFECT_TYPE FROM Site_Jova WHERE EFFECT_TYPE IN (SELECT DISTINCT EFFECT_TYPE FROM Site_Jova) GROUP BY EFFECT_TYPE;
```
mysql> SELECT count(DISTINCT ENDPOINT), EFFECT_TYPE FROM Site_Jova WHERE EFFECT_TYPE IN (SELECT DISTINCT EFFECT_TYPE FROM Site_Jova) GROUP BY EFFECT_TYPE;
+--------------------------+-------------+
| count(DISTINCT ENDPOINT) | EFFECT_TYPE |
+--------------------------+-------------+
|                       29 | "ACUTE"     |
|                        5 | "ADME"      |
|                        6 | "BEHAVIOR"  |
|                       14 | "CHRONIC"   |
|                       10 | "MOA"       |
|                        1 | "NC"        |
+--------------------------+-------------+
6 rows in set (18.06 sec)
```
ACUTE最多，为29，定为ACUTE

?这三个field之间没有相关性吗

SELECT count(DISTINCT ENDPOINT), SPECIES_GROUP, EFFECT_TYPE, TREND
FROM Site_Jova
WHERE SPECIES_GROUP IN (SELECT DISTINCT SPECIES_GROUP FROM Site_Jova)
AND EFFECT_TYPE IN (SELECT DISTINCT EFFECT_TYPE FROM Site_Jova)
AND TREND IN (SELECT DISTINCT TREND FROM Site_Jova)
GROUP BY SPECIES_GROUP, EFFECT_TYPE, TREND;
```
+--------------------------+---------------------------------+-------------+-------+
| count(DISTINCT ENDPOINT) | SPECIES_GROUP                   | EFFECT_TYPE | TREND |
+--------------------------+---------------------------------+-------------+-------+
|                        2 | "Algae, Moss, Fungi"            | "ACUTE"     | "DEC" |
|                        4 | "Algae, Moss, Fungi"            | "ACUTE"     | "INC" |
|                        3 | "Algae, Moss, Fungi"            | "ACUTE"     | "NR"  |
|                        2 | "Algae, Moss, Fungi"            | "ADME"      | "CHG" |
|                        2 | "Algae, Moss, Fungi"            | "ADME"      | "INC" |
|                        2 | "Algae, Moss, Fungi"            | "ADME"      | "NR"  |
|                        1 | "Algae, Moss, Fungi"            | "BEHAVIOR"  | "DEC" |
|                        1 | "Algae, Moss, Fungi"            | "BEHAVIOR"  | "NR"  |
|                        2 | "Algae, Moss, Fungi"            | "CHRONIC"   | "CHG" |
|                       10 | "Algae, Moss, Fungi"            | "CHRONIC"   | "DEC" |
|                        6 | "Algae, Moss, Fungi"            | "CHRONIC"   | "INC" |
|                        4 | "Algae, Moss, Fungi"            | "CHRONIC"   | "NC"  |
|                        3 | "Algae, Moss, Fungi"            | "CHRONIC"   | "NEF" |
|                        9 | "Algae, Moss, Fungi"            | "CHRONIC"   | "NR"  |
|                        3 | "Algae, Moss, Fungi"            | "MOA"       | "CHG" |
|                        6 | "Algae, Moss, Fungi"            | "MOA"       | "DEC" |
|                        5 | "Algae, Moss, Fungi"            | "MOA"       | "INC" |
|                        2 | "Algae, Moss, Fungi"            | "MOA"       | "NC"  |
|                        2 | "Algae, Moss, Fungi"            | "MOA"       | "NEF" |
|                        5 | "Algae, Moss, Fungi"            | "MOA"       | "NR"  |
|                        5 | "Amphibians"                    | "ACUTE"     | "DEC" |
|                        9 | "Amphibians"                    | "ACUTE"     | "INC" |
|                        3 | "Amphibians"                    | "ACUTE"     | "NC"  |
|                        4 | "Amphibians"                    | "ACUTE"     | "NEF" |
|                        6 | "Amphibians"                    | "ACUTE"     | "NR"  |
|                        1 | "Amphibians"                    | "ADME"      | "INC" |
|                        1 | "Amphibians"                    | "ADME"      | "NR"  |
|                        2 | "Amphibians"                    | "BEHAVIOR"  | "INC" |
|                        1 | "Amphibians"                    | "BEHAVIOR"  | "NEF" |
|                        2 | "Amphibians"                    | "CHRONIC"   | "CHG" |
|                        5 | "Amphibians"                    | "CHRONIC"   | "DEC" |
|                        5 | "Amphibians"                    | "CHRONIC"   | "INC" |
|                        2 | "Amphibians"                    | "CHRONIC"   | "NC"  |
|                        3 | "Amphibians"                    | "CHRONIC"   | "NEF" |
|                        2 | "Amphibians"                    | "CHRONIC"   | "NR"  |
|                        2 | "Amphibians"                    | "MOA"       | "CHG" |
|                        5 | "Amphibians"                    | "MOA"       | "DEC" |
|                        6 | "Amphibians"                    | "MOA"       | "INC" |
|                        2 | "Amphibians"                    | "MOA"       | "NC"  |
|                        3 | "Amphibians"                    | "MOA"       | "NEF" |
|                        2 | "Amphibians"                    | "MOA"       | "NR"  |
|                        2 | "Bacteria"                      | "ACUTE"     | "DEC" |
|                        1 | "Bacteria"                      | "CHRONIC"   | "DEC" |
|                        1 | "Coelenterates"                 | "ACUTE"     | "INC" |
|                        2 | "Crustaceans"                   | "ACUTE"     | "CHG" |
|                       11 | "Crustaceans"                   | "ACUTE"     | "DEC" |
|                       17 | "Crustaceans"                   | "ACUTE"     | "INC" |
|                        7 | "Crustaceans"                   | "ACUTE"     | "NC"  |
|                        3 | "Crustaceans"                   | "ACUTE"     | "NEF" |
|                       13 | "Crustaceans"                   | "ACUTE"     | "NR"  |
|                        1 | "Crustaceans"                   | "ADME"      | "CHG" |
|                        2 | "Crustaceans"                   | "ADME"      | "DEC" |
|                        2 | "Crustaceans"                   | "ADME"      | "INC" |
|                        1 | "Crustaceans"                   | "ADME"      | "NC"  |
|                        2 | "Crustaceans"                   | "ADME"      | "NR"  |
|                        3 | "Crustaceans"                   | "BEHAVIOR"  | "CHG" |
|                        4 | "Crustaceans"                   | "BEHAVIOR"  | "DEC" |
|                        3 | "Crustaceans"                   | "BEHAVIOR"  | "INC" |
|                        2 | "Crustaceans"                   | "BEHAVIOR"  | "NEF" |
|                        1 | "Crustaceans"                   | "BEHAVIOR"  | "NR"  |
|                        2 | "Crustaceans"                   | "CHRONIC"   | "CHG" |
|                        9 | "Crustaceans"                   | "CHRONIC"   | "DEC" |
|                        5 | "Crustaceans"                   | "CHRONIC"   | "INC" |
|                        3 | "Crustaceans"                   | "CHRONIC"   | "NC"  |
|                        2 | "Crustaceans"                   | "CHRONIC"   | "NEF" |
|                        7 | "Crustaceans"                   | "CHRONIC"   | "NR"  |
|                        2 | "Crustaceans"                   | "MOA"       | "CHG" |
|                        7 | "Crustaceans"                   | "MOA"       | "DEC" |
|                        5 | "Crustaceans"                   | "MOA"       | "INC" |
|                        1 | "Crustaceans"                   | "MOA"       | "NC"  |
|                        3 | "Crustaceans"                   | "MOA"       | "NR"  |
|                        1 | "Crustaceans"                   | "NC"        | "CHG" |
|                        1 | "Crustaceans"                   | "NC"        | "NR"  |
|                        1 | "Fish"                          | "ACUTE"     | "CHG" |
|                        7 | "Fish"                          | "ACUTE"     | "DEC" |
|                       21 | "Fish"                          | "ACUTE"     | "INC" |
|                        7 | "Fish"                          | "ACUTE"     | "NC"  |
|                        4 | "Fish"                          | "ACUTE"     | "NEF" |
|                       14 | "Fish"                          | "ACUTE"     | "NR"  |
|                        1 | "Fish"                          | "ADME"      | "CHG" |
|                        1 | "Fish"                          | "ADME"      | "DEC" |
|                        3 | "Fish"                          | "ADME"      | "INC" |
|                        1 | "Fish"                          | "ADME"      | "NC"  |
|                        1 | "Fish"                          | "ADME"      | "NEF" |
|                        2 | "Fish"                          | "ADME"      | "NR"  |
|                        2 | "Fish"                          | "BEHAVIOR"  | "CHG" |
|                        4 | "Fish"                          | "BEHAVIOR"  | "DEC" |
|                        4 | "Fish"                          | "BEHAVIOR"  | "INC" |
|                        1 | "Fish"                          | "BEHAVIOR"  | "NC"  |
|                        1 | "Fish"                          | "BEHAVIOR"  | "NEF" |
|                        2 | "Fish"                          | "BEHAVIOR"  | "NR"  |
|                        4 | "Fish"                          | "CHRONIC"   | "CHG" |
|                        8 | "Fish"                          | "CHRONIC"   | "DEC" |
|                        4 | "Fish"                          | "CHRONIC"   | "INC" |
|                        3 | "Fish"                          | "CHRONIC"   | "NC"  |
|                        2 | "Fish"                          | "CHRONIC"   | "NEF" |
|                        5 | "Fish"                          | "CHRONIC"   | "NR"  |
|                        3 | "Fish"                          | "MOA"       | "CHG" |
|                        6 | "Fish"                          | "MOA"       | "DEC" |
|                        6 | "Fish"                          | "MOA"       | "INC" |
|                        2 | "Fish"                          | "MOA"       | "NC"  |
|                        3 | "Fish"                          | "MOA"       | "NEF" |
|                        5 | "Fish"                          | "MOA"       | "NR"  |
|                        6 | "Flowers, Trees, Shrubs, Ferns" | "ACUTE"     | "INC" |
|                        1 | "Flowers, Trees, Shrubs, Ferns" | "ACUTE"     | "NEF" |
|                        4 | "Flowers, Trees, Shrubs, Ferns" | "ACUTE"     | "NR"  |
|                        1 | "Flowers, Trees, Shrubs, Ferns" | "ADME"      | "CHG" |
|                        2 | "Flowers, Trees, Shrubs, Ferns" | "ADME"      | "INC" |
|                        2 | "Flowers, Trees, Shrubs, Ferns" | "ADME"      | "NR"  |
|                        2 | "Flowers, Trees, Shrubs, Ferns" | "BEHAVIOR"  | "CHG" |
|                        1 | "Flowers, Trees, Shrubs, Ferns" | "CHRONIC"   | "CHG" |
|                       10 | "Flowers, Trees, Shrubs, Ferns" | "CHRONIC"   | "DEC" |
|                        5 | "Flowers, Trees, Shrubs, Ferns" | "CHRONIC"   | "INC" |
|                        5 | "Flowers, Trees, Shrubs, Ferns" | "CHRONIC"   | "NC"  |
|                        2 | "Flowers, Trees, Shrubs, Ferns" | "CHRONIC"   | "NEF" |
|                        5 | "Flowers, Trees, Shrubs, Ferns" | "CHRONIC"   | "NR"  |
|                        2 | "Flowers, Trees, Shrubs, Ferns" | "MOA"       | "CHG" |
|                        8 | "Flowers, Trees, Shrubs, Ferns" | "MOA"       | "DEC" |
|                        3 | "Flowers, Trees, Shrubs, Ferns" | "MOA"       | "INC" |
|                        1 | "Flowers, Trees, Shrubs, Ferns" | "MOA"       | "NC"  |
|                        1 | "Flowers, Trees, Shrubs, Ferns" | "MOA"       | "NEF" |
|                        4 | "Flowers, Trees, Shrubs, Ferns" | "MOA"       | "NR"  |
|                        1 | "Insects/Spiders"               | "ACUTE"     | "CHG" |
|                        5 | "Insects/Spiders"               | "ACUTE"     | "DEC" |
|                       15 | "Insects/Spiders"               | "ACUTE"     | "INC" |
|                        4 | "Insects/Spiders"               | "ACUTE"     | "NC"  |
|                        3 | "Insects/Spiders"               | "ACUTE"     | "NEF" |
|                        6 | "Insects/Spiders"               | "ACUTE"     | "NR"  |
|                        1 | "Insects/Spiders"               | "ADME"      | "CHG" |
|                        2 | "Insects/Spiders"               | "ADME"      | "INC" |
|                        1 | "Insects/Spiders"               | "ADME"      | "NC"  |
|                        2 | "Insects/Spiders"               | "ADME"      | "NR"  |
|                        3 | "Insects/Spiders"               | "BEHAVIOR"  | "CHG" |
|                        1 | "Insects/Spiders"               | "BEHAVIOR"  | "DEC" |
|                        2 | "Insects/Spiders"               | "BEHAVIOR"  | "INC" |
|                        2 | "Insects/Spiders"               | "BEHAVIOR"  | "NEF" |
|                        2 | "Insects/Spiders"               | "BEHAVIOR"  | "NR"  |
|                        1 | "Insects/Spiders"               | "CHRONIC"   | "CHG" |
|                        6 | "Insects/Spiders"               | "CHRONIC"   | "DEC" |
|                        5 | "Insects/Spiders"               | "CHRONIC"   | "INC" |
|                        1 | "Insects/Spiders"               | "CHRONIC"   | "NC"  |
|                        2 | "Insects/Spiders"               | "CHRONIC"   | "NEF" |
|                        3 | "Insects/Spiders"               | "CHRONIC"   | "NR"  |
|                        3 | "Insects/Spiders"               | "MOA"       | "CHG" |
|                        5 | "Insects/Spiders"               | "MOA"       | "DEC" |
|                        5 | "Insects/Spiders"               | "MOA"       | "INC" |
|                        2 | "Insects/Spiders"               | "MOA"       | "NC"  |
|                        1 | "Insects/Spiders"               | "MOA"       | "NEF" |
|                        3 | "Invertebrates"                 | "ACUTE"     | "DEC" |
|                        6 | "Invertebrates"                 | "ACUTE"     | "INC" |
|                        2 | "Invertebrates"                 | "ACUTE"     | "NEF" |
|                        5 | "Invertebrates"                 | "ACUTE"     | "NR"  |
|                        1 | "Invertebrates"                 | "ADME"      | "CHG" |
|                        2 | "Invertebrates"                 | "ADME"      | "INC" |
|                        1 | "Invertebrates"                 | "ADME"      | "NEF" |
|                        2 | "Invertebrates"                 | "ADME"      | "NR"  |
|                        1 | "Invertebrates"                 | "BEHAVIOR"  | "CHG" |
|                        2 | "Invertebrates"                 | "BEHAVIOR"  | "NR"  |
|                        1 | "Invertebrates"                 | "CHRONIC"   | "CHG" |
|                        7 | "Invertebrates"                 | "CHRONIC"   | "DEC" |
|                        5 | "Invertebrates"                 | "CHRONIC"   | "INC" |
|                        3 | "Invertebrates"                 | "CHRONIC"   | "NC"  |
|                        2 | "Invertebrates"                 | "CHRONIC"   | "NEF" |
|                        4 | "Invertebrates"                 | "CHRONIC"   | "NR"  |
|                        3 | "Invertebrates"                 | "MOA"       | "NC"  |
|                        1 | "Miscellaneous"                 | "ACUTE"     | "INC" |
|                        2 | "Miscellaneous"                 | "ACUTE"     | "NR"  |
|                        1 | "Miscellaneous"                 | "CHRONIC"   | "CHG" |
|                        5 | "Miscellaneous"                 | "CHRONIC"   | "DEC" |
|                        4 | "Miscellaneous"                 | "CHRONIC"   | "INC" |
|                        1 | "Miscellaneous"                 | "CHRONIC"   | "NR"  |
|                        2 | "Miscellaneous"                 | "MOA"       | "DEC" |
|                        1 | "Miscellaneous"                 | "MOA"       | "INC" |
|                        1 | "Miscellaneous"                 | "MOA"       | "NC"  |
|                        1 | "Miscellaneous"                 | "MOA"       | "NEF" |
|                        1 | "Miscellaneous"                 | "MOA"       | "NR"  |
|                        3 | "Molluscs"                      | "ACUTE"     | "DEC" |
|                       10 | "Molluscs"                      | "ACUTE"     | "INC" |
|                        9 | "Molluscs"                      | "ACUTE"     | "NC"  |
|                        3 | "Molluscs"                      | "ACUTE"     | "NEF" |
|                        6 | "Molluscs"                      | "ACUTE"     | "NR"  |
|                        1 | "Molluscs"                      | "ADME"      | "CHG" |
|                        2 | "Molluscs"                      | "ADME"      | "INC" |
|                        1 | "Molluscs"                      | "ADME"      | "NC"  |
|                        2 | "Molluscs"                      | "ADME"      | "NR"  |
|                        1 | "Molluscs"                      | "BEHAVIOR"  | "CHG" |
|                        2 | "Molluscs"                      | "BEHAVIOR"  | "DEC" |
|                        1 | "Molluscs"                      | "BEHAVIOR"  | "INC" |
|                        1 | "Molluscs"                      | "BEHAVIOR"  | "NEF" |
|                        2 | "Molluscs"                      | "BEHAVIOR"  | "NR"  |
|                        1 | "Molluscs"                      | "CHRONIC"   | "CHG" |
|                        6 | "Molluscs"                      | "CHRONIC"   | "DEC" |
|                        3 | "Molluscs"                      | "CHRONIC"   | "INC" |
|                        3 | "Molluscs"                      | "CHRONIC"   | "NC"  |
|                        2 | "Molluscs"                      | "CHRONIC"   | "NEF" |
|                        4 | "Molluscs"                      | "CHRONIC"   | "NR"  |
|                        1 | "Molluscs"                      | "MOA"       | "CHG" |
|                        6 | "Molluscs"                      | "MOA"       | "DEC" |
|                        4 | "Molluscs"                      | "MOA"       | "INC" |
|                        1 | "Molluscs"                      | "MOA"       | "NC"  |
|                        2 | "Molluscs"                      | "MOA"       | "NEF" |
|                        3 | "Molluscs"                      | "MOA"       | "NR"  |
|                        2 | "Protozoans"                    | "ACUTE"     | "INC" |
|                        1 | "Worms"                         | "ACUTE"     | "DEC" |
|                        8 | "Worms"                         | "ACUTE"     | "INC" |
|                        3 | "Worms"                         | "ACUTE"     | "NC"  |
|                        1 | "Worms"                         | "ACUTE"     | "NEF" |
|                        8 | "Worms"                         | "ACUTE"     | "NR"  |
|                        2 | "Worms"                         | "ADME"      | "INC" |
|                        1 | "Worms"                         | "ADME"      | "NC"  |
|                        2 | "Worms"                         | "ADME"      | "NR"  |
|                        2 | "Worms"                         | "BEHAVIOR"  | "DEC" |
|                        1 | "Worms"                         | "CHRONIC"   | "CHG" |
|                        5 | "Worms"                         | "CHRONIC"   | "DEC" |
|                        2 | "Worms"                         | "CHRONIC"   | "INC" |
|                        2 | "Worms"                         | "CHRONIC"   | "NR"  |
|                        1 | "Worms"                         | "MOA"       | "INC" |
|                        1 | "Worms"                         | "MOA"       | "NC"  |
+--------------------------+---------------------------------+-------------+-------+
218 rows in set (31.46 sec)
```
最大的还是
```
21 | "Fish" | "ACUTE" | "INC"
```

缩小范围后的数据条数
```
mysql> select count(*) from site_jova where SPECIES_GROUP="\"Fish\"" AND EFFECT_TYPE="\"ACUTE\"" AND TREND="\"INC\"";
+----------+
| count(*) |
+----------+
|    77130 |
+----------+
1 row in set (2.15 sec)
```

SELECT DISTINCT CAMPAIGN, SITE_ID, SITE_CODE, ENDPOINT, SAMPLE_DATE, SUM_Q_AVG, TOTAL FROM Site_Jova WHERE SPECIES_GROUP="\"Fish\"" AND EFFECT_TYPE="\"ACUTE\"" AND TREND="\"INC\"" AND ENDPOINT IN (SELECT DISTINCT ENDPOINT FROM Site_Jova LIMIT 5);

这边有个很神奇的现象...2015年8月9月里有的时候SUM会变得很大：208333.33645110956
做一个视图然后把SUM_Q_AVG过大的设置为1应该可以。

SELECT count(*) FROM site_jova
WHERE SPECIES_GROUP="\"Fish\"" AND EFFECT_TYPE="\"ACUTE\"" AND TREND="\"INC\""
AND (ENDPOINT="\"NOEC\"" OR ENDPOINT="\"EC50\"")
AND (SAMPLE_DATE="\"14.08.2015\"" OR SAMPLE_DATE = "\"26.09.2016\"" OR SAMPLE_DATE = "\"16.06.2014\"" OR SAMPLE_DATE = "\"27.05.2013\"");
```
mysql> select count(*) from site_jova where SPECIES_GROUP="\"Fish\"" AND EFFECT_TYPE="\"ACUTE\"" AND TREND="\"INC\"" AND (ENDPOINT="\"NOEC\"" OR ENDPOINT="\"EC50\"") AND (SAMPLE_DATE="\"14.08.2015\"" OR SAMPLE_DATE = "\"26.09.2016\"" OR SAMPLE_DATE = "\"16.06.2014\"" OR SAMPLE_DATE = "\"27.05.2013\"");
+----------+
| count(*) |
+----------+
|      242 |
+----------+
1 row in set (2.15 sec)
```

SELECT count(*) FROM site_jova
WHERE SPECIES_GROUP="\"Fish\"" AND EFFECT_TYPE="\"ACUTE\"" AND TREND="\"INC\""
AND (SAMPLE_DATE="\"14.08.2015\"" OR SAMPLE_DATE = "\"26.09.2016\"" OR SAMPLE_DATE = "\"16.06.2014\"" OR SAMPLE_DATE = "\"27.05.2013\"");
取全部ENDPOINT是1586条记录，也可以接受。



新建了一个Sample_Jova用来做连接
INSERT INTO Sample_Jova values("NORWAY", 22.782167, 44.1723, "\"HEIA\"");
INSERT INTO Sample_Jova values("NORWAY", 12.332483, 48.97915, "\"HOTRAN\"");
INSERT INTO Sample_Jova values("NORWAY", 18.91515, 45.54585, "\"MØRDRE\"");
INSERT INTO Sample_Jova values("NORWAY", 19.8013, 45.221717, "\"SKUTERUD\"");
INSERT INTO Sample_Jova values("NORWAY", 18.86405, 47.8149, "\"TIME\"");
INSERT INTO Sample_Jova values("NORWAY", 15.545778, 48.387203, "\"VASSHAGLONA\"");


使用两个表连接并创建视图
CREATE VIEW NORWAY_DATA AS (
SELECT CAMPAIGN, COUNTRY, SITE_ID AS SITE_CODE, ENDPOINT, SAMPLE_DATE, SUM_Q_AVG AS SUM, TOTAL, SITE_CODE AS SITE_NAME, lat, lon
FROM Site_Jova, Sample_Jova
WHERE SITE_NAME=SITE_CODE AND SPECIES_GROUP="\"Fish\"" AND EFFECT_TYPE="\"ACUTE\"" AND TREND="\"INC\""
AND (SAMPLE_DATE="\"14.08.2015\"" OR SAMPLE_DATE = "\"26.09.2016\"" OR SAMPLE_DATE = "\"16.06.2014\"" OR SAMPLE_DATE = "\"27.05.2013\"")
);

