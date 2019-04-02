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
