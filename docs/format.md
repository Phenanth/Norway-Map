# Format

## mark

- CAMPAIGN
- COUNTRY
- ENDPOINT(SPECIES_GROUP?ENDPOINT)
- SUM(Average of SUM_Q_AVG)
- TOTAL(Sum of SPECIES_GROUP)


## mapdata数据项与数据库表对应关系

- [x] CAMPAIGN
`"JOVA"`
- [x] SITE_CODE
`"ENDPOINT"`
- [ ] SPECIES_GROUP / ENDPOINT
`mysql> SELECT distinct SPECIES_GROUP from Site_Jova;`
- [ ] SUM
`"SUM_Q_AVG"`
- [ ] TOTAL
`"TOTAL"`
- [ ] lat
经度
- [ ] lon
纬度
- [x] COUNTRY
`Norway`
- [ ] SITE_NAME

修改后：

- [x] CAMPAIGN
`"JOVA"`
- [x] SITE_CODE
`"ENDPOINT"`
- [ ] **SPECIES_GROUP**
- [ ] **ENDPOINT**
- [ ] SUM
`"SUM_Q_AVG"`
- [ ] TOTAL
`"TOTAL"`
- [ ] lat
经度
- [ ] lon
纬度
- [x] COUNTRY
`Norway`
- [ ] SITE_NAME
- [ ] **SAMPLE_DATE**


### 数据分析记录
见隔壁`select.sql`

### 疑问

1. 为什么生成Highcharts里面的ENDPOINT用到的数据在mapdata里的标签是SPECIES_GROUP
> 这个会导致计算SUM和TOTAL时的计算标准有歧义，到底要用ENDPOINT还是SPECIES_GROUP做分类的标准呢。
2. ENDPOINT的意义究竟是什么
3. SPECIES_GROUP的值要如何设置（怎么从那么长的名称变成简写）
4. window 2 没做，如果需要的话是不是还需要关于某个地区（SITE_CODE）的某个物种（SPECIES）的关于时间轴的数据。而且还有一个time slider需要window1、3和4实时变化...不过我觉得跟随时间变化，win1圈大小变化其实没什么太大用处。
5. 系统还说要做点击地图相应圈改变其他三个窗口显示的数据的功能，还没实现
6. window 3 展示数据这样就好了吗？（PPT里说要SPECIES、ENPOINT、EFFECT）


总结一下：
1. 【需求确认】
- 每个图需要的数据是不是如下呢？
- 原来的系统和目前的数据吻合度并不高，可以修改吗？
- mapdata对于win1和win3里面表达SPECIES和ENDPOINT的标签是不是还是细化成ENDPOINT和SPECIES两种比较好呢？
2. 【需求划分】
- window2和window4的具体需要做到什么程度？（还不是很清楚win4要怎么做，不懂的名词很多）
3. 【数据缺失】
- 每个ENDPOINT的经度/纬度是什么？
- 每个ENDPOINT对应的名字是什么？

## SUM与TOTAL计算

### 分类标准
- SITE_CODE(JDS1, JDS2, JDS3.../261, 262...)
SITE_ID
- SPECIES_GROUP(ER, AR, AHR.../EC50, BCF...?/Algae, Moss, Fungi...)
从现存的SPECIES_GROUP的名称定义相对应的简写?
> 先要解决上面说的那个对SPECIES_GROUP的疑问。

### SUM计算
根据不同的ENDPOINT、SPECIES_GROUP分类并计算对应的SUM_Q_AVG的平均值
对应的意义是每个ENDPOINT下的平均值是多少

### TOTAL计算
根据不同的ENDPOINT、SPECIES_GROUP分类并计算对应的TOTAL值。
对应的意义是每个ENDPOINT下一共有几种SPECIES

> 还不确定要不要用ENDPOINT代替SITE_CODE。看了一下还是不替代了，有的ENDPOINT并不是每种SPECIES都有的。
> 但是又看了一下需求PPT，这边的Window3好像就是SPECIES/ENDPOINT数据展示...
> 所以做了替换，遇到没有的SPECIES应该需要修正数据


## 写完文档后的调整

### 数据方面
- mapdata加入`SAMPLE_DATE`和`ENDPOINT`还有`TOTAL`，原来的`TOTAL`改名`TOTAL_SUM`
- `SUM`和`TOTAL_SUM`值需要根据`SAMPLE_DATE`重新计算

```
- CAMPAIGN ('JOVA')
- SITE_CODE (Data from `ENDPOINT` column)
- SPECIES_GROUP (Data from `SPECIES_GROUP` column)
- ENDPOINT (Data from `ENDPOINT` column, currently a missing column but will be added if necessary, explaination is below in `Requirement Confirmation - Window 3`)
- TOTAL (Data from `TOTAL` column, currently a missing column but will be added if necessary.)
- SUM (Calculated value)
- TOTAL_SUM (Calculated value)
- lat (Latitudes of each `ENDPOINT`)
- lon (Longtitude of each `ENDPOINT`)
- COUNTRY ('NORWAY')
- SITE_NAME (Names of each `ENDPOINGT`)
```

### 算法调整

SUM和TOTAL_SUM算法调整。

#### SUM

Average of values from `SUM_Q_AVG` column of this `ENDPOINT` in different `SAMPLE_DATE`.
Each `SPECIES_GROUP` will be independent. (Since it is the sum of a single `SPECIES_GROUP`?)
When displaying in window 1, all `SUM` value in datasets of each `SPECIES_GROUP` would be added together.

#### TOTAL_SUM

Average of the sum of the values from `TOTAL` column of this `ENDPOINT` in different  `SAMPLE_DATE`.
Would add up all the `SPECIES_GROUP` together. (Since it is the sum of all the `SPECIES_GROUP` in this `ENDPOINT`?)


### 页面构成调整

不懂怎么搞。

