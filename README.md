# Norway-Map-Master

## Data
需要显示在网站上的数据项内容，罗列如下：
1. CAMPAIGN
2. SITE_CODE（来自SITE_ID）
3. ENDPOINT
4. DATE（来自SAMPLE_DATE）
5. SUM（来自SUM_Q_AVG）
6. TOTAL
7. lat（经度）
8. lon（纬度）
9. COUNTRY（国家，都是"NORWAY"）
10. SITE_NAME（来自SITE_CODE）

## Windows
> 这里只写出需要更改的功能。 基础功能参照PPT。

## General
- [ ] 在每个窗口的中上方显示窗口标题
- [ ] 每个窗口放到做大的按钮
- [ ] 初始化显示最新日期的数据

### Window 1
- [ ] 显示的圈，pop-up窗口内数据根据Window 2选择的日期进行变化

### Window 2
- [ ] High Charts绘制化学元素根据时间轴变化的图表

### Window 3
- [ ] 显示的数据根据Window 2选择的日期进行变化

### Window 4
> 暂时不清楚需求是什么，不过首先需要弄明白柱状图的算法是什么，然后绘制柱状图即可。

## Note

### 190402开会记录
表数据定义
- ENDPOINT: 化学元素简写
- SPECIES_GROUP：化学元素属于什么生物分类
- SITE_ID：SITE_CODE
- SITE_CODE：SITE_NAME
- 经纬度：目前缺少，需要后续补充数据

需求修改
- 在每个窗口的中上位置显示一个标题
- 完成每个窗口的最大化
- TOTAL先去掉

需要明确的事项
- Window 4怎么做
- 固定site date endpoint时具体要依照哪个标准下的数据进行统计（15-17field的固定值是什么）

目前的首要任务：
- 随便首先确定一个模型（固定"SPECIES_GROUP"&"EFFECT_TYPE"&"TREND"），并根据每个日期筛选出一条记录作为显示的标本。
- 创建一个具有Data部分描述的数据的表，导出数据作为测试展示数据。

### 190404每日记录

统计了一下field15-17，决定一个模型为：
SPECIES_GROUP = Fish
EFFECT_TYPE = ACUTE
TREND = INC

发现可能存在的问题：
SAMPLE_DATE的数值过多，200多天的样本一共会有7w条
> 暂时在每年挑了一天，一共四天的数据

有些日期的SUM_Q_AVG会过于大，有208333.33645110956这种数据，但是大部分的数据的范围都在0-0.2之间，可能在显示之前需要处理这一项数据，否则画图会造成过大的效果。
> 暂时想到的处理方法是先做一个视图，然后把SUM_Q_AVG过大的数据调整成1，可能需要normalize函数之类的。

### 190407每日记录

#### 筛选Data

因为缺少经纬度的数据，自己另外建了一个表随便编造了一点数据。

建立视图的SQL文：
```SQL
CREATE VIEW NORWAY_DATA2 AS (
SELECT CAMPAIGN, COUNTRY, SITE_ID AS SITE_CODE, ENDPOINT, SAMPLE_DATE, SUM_Q_AVG AS SUM, TOTAL, SITE_CODE AS SITE_NAME, lat, lon
FROM Site_Jova, Sample_Jova
WHERE SITE_NAME=SITE_CODE AND SPECIES_GROUP="\"Fish\"" AND EFFECT_TYPE="\"ACUTE\"" AND TREND="\"INC\""
AND (SAMPLE_DATE="\"14.08.2015\"" OR SAMPLE_DATE = "\"26.09.2016\"" OR SAMPLE_DATE = "\"16.06.2014\"" OR SAMPLE_DATE = "\"27.05.2013\"")
AND (ENDPOINT="\"LC50\"" OR ENDPOINT="\"LOEC\"" OR ENDPOINT="\"NOEC\"")
);

mysql> SELECT * FROM NORWAY_DATA LIMIT 5;
+----------+---------+-----------+----------+--------------+----------------------------------+-------+---------------+--------------+--------------+
| CAMPAIGN | COUNTRY | SITE_CODE | ENDPOINT | SAMPLE_DATE  | SUM                              | TOTAL | SITE_NAME     | lat          | lon          |
+----------+---------+-----------+----------+--------------+----------------------------------+-------+---------------+--------------+--------------+
| "JOVA"   | NORWAY  |       261 | "LC50"   | "14.08.2015" | 0.000422975406134160700000000000 |     8 | "HEIA"        | 44.172300000 | 22.782167000 |
| "JOVA"   | NORWAY  |       266 | "LC50"   | "26.09.2016" | 0.000000129032258064516110000000 |     1 | "VASSHAGLONA" | 48.387203000 | 15.545778000 |
| "JOVA"   | NORWAY  |       266 | "EC50"   | "26.09.2016" | 0.036527595456880314000000000000 |     1 | "VASSHAGLONA" | 48.387203000 | 15.545778000 |
| "JOVA"   | NORWAY  |       266 | "EC50"   | "27.05.2013" | 0.000000137500000000000000000000 |     1 | "VASSHAGLONA" | 48.387203000 | 15.545778000 |
| "JOVA"   | NORWAY  |       266 | "LC50"   | "27.05.2013" | 0.000082448349245183240000000000 |     3 | "VASSHAGLONA" | 48.387203000 | 15.545778000 |
+----------+---------+-----------+----------+--------------+----------------------------------+-------+---------------+--------------+--------------+
10 rows in set (0.01 sec)
```
> 总天数有两百多天，数量太多了。所以挑选了四天，一共1300多条数据做开发数据。
接下来需要把数据库的数据处理成js的数组格式，参考`mapdata.js`的内容即可。

#### 数据处理

同日晚上，写了个简单的脚本生成了数据文件`data.js`，在数据项方面做了以下调整：
- 去除数据库内数据自带的双引号
- 将日期处理成日-月-年的形式（包括去除月份前的`0`）
具体可以参考`/Data/preprocess/data/data.js`内容。

### 190408每日记录

#### 完成内容

- Window 3 数据的显示
- Window 2 数据的显示


#### 有待解决的问题

- Window 2根据最早的开始年份动态改变x轴始点
- Window 3没有的采集点也需要出现在图表中
- 修改`core.js`，取消使用拆开后的年月日字段的判断语句。

#### 进一步需要完成的需求

- Window 2点击互动效果
- Windows的点击放大效果

> Highcharts加了个`startPoint`Window 2就好了耶好快乐噢
但是想想如果有不存在年份的数据...oh想想就自闭了


#### 过程

在除了上面提到的规定的三列以外，又规定了三列让每个地区、每种化合物在指定日期里只有一条对应数据。
最终所有日期的所有化学物的数据停留在5000条左右。

但是发现存在一个严重的问题就是在选定了标准的参数之后，数据是十分稀疏的，对于测试而言很不利。直接体现就是化学物从一开始37变成只有21种，地点上直接少掉了一个地点，对于大多数日子里也没办法在同一张图上体现出五个地点。

```SQL
mysql> select site_code, SUM_Q_AVG from site_jova where sample_date="\"25.06.2012\"" and endpoint="\"LC90\"" and SPECIES_GROUP="\"Fish\"" AND EFFECT_TYPE="\"ACUTE\"" AND TREND="\"INC\"" and EFFECT_DESCRIPTION = "\"Mortality\"" AND Q_TYPE = "\"HQ\"" AND Q_SELECT = "\"P_CONC\"";
+---------------+----------------------------------+
| site_code     | SUM_Q_AVG                        |
+---------------+----------------------------------+
| "HEIA"        | 0.000022233091787439610000000000 |
| "SKUTERUD"    | 0.000022233091787439610000000000 |
| "TIME"        | 0.000022233091787439610000000000 |
| "VASSHAGLONA" | 0.000022233091787439610000000000 |
+---------------+----------------------------------+
4 rows in set (1.89 sec)
```
> 重新看了一下 有的ENDPOINT就是一模一样...
不是一模一样但是很相近的：LC50，至少可以用来测试代码效果...

之后再用改过的数据data_all2.js重新显示一次。
然后就要开始考虑Window 2怎么做了。
> 感觉切换日期更改其他的窗口的内容是个蛮烦人的事情...

[Highcharts参考网站](https://www.highcharts.com/demo/line-basic)
