String.prototype.format = function() {
    var formatted = this;
    for (var i = 0; i < arguments.length; i++) {
        var regexp = new RegExp('\\{'+i+'\\}', 'gi');
        formatted = formatted.replace(regexp, arguments[i]);
    }
    return formatted;
};


var mapdata = []
var map

var DATE = "30.04.2012"
var SITE_NAME = "TIME"


$(init) 

function init() {
    data = initData()
    initMap()
    initDateChart(data.date, data.chart2data, data.dateStart)
    initBarChart(data.area, data.chartdata)
}



function initData() {

    date = []
    chart2data = []

    area = []
    chartdata = []



    $.each(datamap, function () {

        // Window 2
        if (this.SITE_NAME == SITE_NAME) {
            var flag2 = 0

            for (var i = 0; i < date.length; i++) {
                if (date[i] == this.SAMPLE_DATE) {
                    flag2 = 1
                    break
                }
            }
            // 当是第一次添加这个日期或者是再次遇到这个日期的数据
            if (flag2 == 0 || date[i] == this.SAMPLE_DATE) {
                if (flag2 == 0) { 
                    date.push(this.SAMPLE_DATE)
                    
                }

                flag2 = 0
                var ret2 = Number(this.TOTAL)
                for (var i = 0; i < chart2data.length; i++) {
                    if (chart2data[i]["name"] == this.ENDPOINT) {
                        var obj_data = []
                        obj_data.push(Date.UTC(Number(this.SAMPLE_YEAR), Number(this.SAMPLE_MONTH-1), Number(this.SAMPLE_DAY)))
                        obj_data.push(ret2)
                        chart2data[i]["data"].push(obj_data)
                        flag2 = 1
                        break
                    }
                }
                if (flag2 == 0) {
                    var obj = {
                        name: this.ENDPOINT,
                        data: []
                    }
                    var obj_data = []
                    obj_data.push(Date.UTC(Number(this.SAMPLE_YEAR), Number(this.SAMPLE_MONTH-1), Number(this.SAMPLE_DAY)))
                    obj_data.push(ret2)
                    obj.data.push(obj_data)
                    chart2data.push(obj)
                }


            }

        }

        // Window 2 X轴数据根据日期排序
        for (i = 0; i < chart2data.length; i++) {
            chart2data[i].data.sort(function(a, b) {
                return a[0] - b[0]
            })
        }

        // 对日期数据按照机器时间从早到晚排序
        date.sort(function(a, b) {
            return Date.UTC(Number(a.substr(6, 9)), Number(a.substr(3, 4)), Number(a.substr(0, 1))) - Date.UTC(Number(b.substr(6, 9)), Number(b.substr(3, 4)), Number(b.substr(0, 1)))
        })


        // Window 3
        if (this.SAMPLE_DATE == DATE) {

            var flag = 0

            for (var i = 0; i < area.length; i++) {
                if (area[i] == this.SITE_NAME) {
                    flag = 1
                    break
                }
            }

            if (flag == 0) {
                    area.push(this.SITE_NAME)
            }

            ret = Number(this.SUM);

            flag = 0
            for (i = 0; i < chartdata.length; i++) {
                if (chartdata[i]["name"] == this.ENDPOINT) {
                    chartdata[i]["data"].push(ret)
                    flag = 1
                    break
                }
            }
            if (flag == 0) {
                var obj = {
                    name: this.ENDPOINT,
                    data: []
                }
                obj.data.push(ret)
                chartdata.push(obj)
            }
        }



    });

    // console.log(area)
    // console.log(date)
    // console.log(chartdata)
    // console.log(chart2data[0])


    // 将全局变量改为第一个地区与最早的日期
    // 需要注意这里，因为window 1是根据这里初始化的
    // 但window 2和window 3用的是用户指定的初始数据
    DATE = date[0]
    SITE_NAME = area[0]

    var data = {
        date: date,
        area: area,
        chartdata: chartdata,
        chart2data: chart2data,
        dateStart: Number(date[0].substr(6, 9))
    }

    return data

}

// Window 3
function initBarChart(area, chartdata) {

    Highcharts.chart('cnt-charts', {
        chart: {
            type: 'bar'
        },
        title: {
            text: 'Window 3: CRA/CHA'
        },
        subtitle: {
            text: 'Source: NIVA RAdb'
        },
        xAxis: {
            categories:area
        },
        yAxis: {
            min: 0,
            title: {
                text: '',
                align: 'high'
            }
        },
        tooltip: {
            valueSuffix: ''
        },
        plotOptions: {
            series: {
                stacking: 'normal'
            },
            bar: {
                point: {
                    events: {
                        click: function (e) {
                            $.each(mapdata, function () {
                                if (this.SITE_NAME === e.point.category) {
                                    map.setCenter({lat: Number(this.lat), lng: Number(this.lon)});
                                    map.setZoom(12);
                                }
                            })
                            
                        },
                        mouseOver: function(e) {
                            $.each(mapdata, function () {
                                if (this.SITE_NAME === e.target.category) {
                                    google.maps.event.trigger(this.marker, 'mouseover');
                                }
                            })
                        },
                        mouseOut: function(e) {
                            $.each(mapdata, function () {
                                if (this.SITE_NAME === e.target.category) {
                                    google.maps.event.trigger(this.marker, 'mouseout');
                                }
                            })
                        }

                    }
                }
            }
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            x: 0,
            y: 0,
            floating: false,
            borderWidth: 1,
            backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
            shadow: true
        },
        credits: {
            enabled: false
        },

        series: chartdata
    });

}

// Window 2
function initDateChart(date, chart2data, dateStart) {

    Highcharts.chart('cnt-date-charts', {
        title: {
            text: 'Window 2: TEMPORAL'
        },
        subtitle: {
            text: 'Source: NIVA RAdb'
        },
        /*xAxis: {
            categories: date
        },*/
        xAxis: {
            type: 'datetime',
            title: {
                text: 'Date'
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Total'
            }
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle'
        },
        plotOptions: {
            series: {
                label: {
                    connectorAllowed: false
                },
                pointStart: dateStart
            },
        },
        series: chart2data
    });

}

// Google Map & Markers
function initMap() {

    bounds  = new google.maps.LatLngBounds();
    map = new google.maps.Map(document.getElementById('container'), { mapTypeId: 'terrain' });

    // 修正演示数据
    $.each(datamap, function () {
        if (this.SAMPLE_DATE == DATE && this.ENDPOINT == 'LC50') {

            this.SUM = Math.sqrt(this.SUM)
            mapdata.push(this)
            
        }
    });

    // 为每个数据采集点设置Marker
    $.each(mapdata, function () {

        lat = Number(this.lat)
        lon = Number(this.lon)
        val = 10;
        loc = new google.maps.LatLng(lat, lon);
        bounds.extend(loc);

        var marker = new google.maps.Marker({
            map: map,
            position: {lat: lat, lng: lon},
            icon: {
              strokeColor: '#FF6600',
              strokeOpacity: .8,
              strokeWeight: 1,
              fillColor: '#FF6600',
              fillOpacity: .35,
              path: google.maps.SymbolPath.CIRCLE,
              scale: val,
              anchor: new google.maps.Point(0, 0)
            },
            zIndex: Math.round(lat * -100000) << 5
        });

        this.marker = marker;

        // Marker的鼠标悬浮窗口信息定义
        var infoHTML = '<div class="infobox"><div class="infocnt"><div class="title">{0}</div><div class="cnt"><span class="v-tl">CAMPAIGN</span><span class="v-cnt">{1}</span></div><div class="cnt"><span class="v-tl">COUNTRY</span><span class="v-cnt">{2}</span></div><div class="cnt"><span class="v-tl">ENDPOINT</span><span class="v-cnt">{3}</span></div><div class="cnt"><span class="v-tl">SUM</span><span class="v-cnt">{4}</span></div><div class="cnt"><span class="v-tl">TOTAL</span><span class="v-cnt">{5}</span></div></div><div class="marker"></div></div>';
        // infoHTML = infoHTML.format(this.SITE_NAME, this.CAMPAIGN, this.COUNTRY, this.SPECIES_GROUP, this.SUM, this.TOTAL)
        infoHTML = infoHTML.format(this.SITE_NAME, this.CAMPAIGN, this.COUNTRY, this.ENDPOINT, this.SUM, this.TOTAL)
        var infoOpt = {
            content: infoHTML, 
            disableAutoPan: false,
            zIndex: null,
            alignBottom: true,
            enableEventPropagation: true,
            infoBoxClearance: new google.maps.Size(1, 1)
        };
        var infowindow = new InfoBox(infoOpt);

        marker.addListener('mouseover', function() {
            infowindow.open(map, this);
        });

        marker.addListener('mouseout', function() {
            infowindow.close();
        });

    });

    map.fitBounds(bounds);     
    map.panToBounds(bounds);

}
