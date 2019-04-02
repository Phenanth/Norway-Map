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