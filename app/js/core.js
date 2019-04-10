String.prototype.format = function() {
    var formatted = this;
    for (var i = 0; i < arguments.length; i++) {
        var regexp = new RegExp('\\{'+i+'\\}', 'gi');
        formatted = formatted.replace(regexp, arguments[i]);
    }
    return formatted;
};

// 清除Google Map上的Markers
google.maps.Map.prototype.clearMarkers = function() {
    for(var i=0; i < markersArray.length; i++){
        markersArray[i].setMap(null);
    }
    // markersArray = new Array();
    // bounds  = new google.maps.LatLngBounds();
};

// 根据字符串计算对应的机器时间
function calMachineTime(str) {
    return Date.UTC(Number(str.substr(6, 10)), Number(str.substr(3, 5)) - 1, Number(str.substr(0, 2)))
}


var mapdata = []
var map
var bounds
var markersArray = []

// 网站初始化用的数据
// 后期根据在窗口中的选择会被更改为其他的值
var DATE = "30.04.2012"
var SITE_NAME = "TIME"
 // 如果是仅按照年份选取数据的话，这句话在Highcharts里才有用。
var dateStart = Number(2012)

date = []
area = []

chartdata = []
chart2data = []



$(init)

function init() {
    initData()
    initMap()
    initDateChart()
    initBarChart()
}


// Initialize the web site
function initData() {

    bounds  = new google.maps.LatLngBounds();
    map = new google.maps.Map(document.getElementById('container'), { mapTypeId: 'terrain' });

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
            return  calMachineTime(a) - calMachineTime(b)
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

    // console.log('initData:', area)
    // console.log('initData:', date)
    // console.log('initData:', chartdata)
    // console.log('initData:', chart2data[0])


}

// When chose a new site from window 3, init the data
function initWindow2Data() {

    chart2data = []

    $.each(datamap, function () {

        // Window 2
        if (this.SITE_NAME == SITE_NAME) {
            var flag2 = 0

            for (var i = 0; i < date.length; i++) {
                if (date[i] == this.SAMPLE_DATE) {
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
                    break
                }
            }

        }

        // Window 2 X轴数据根据日期排序
        for (i = 0; i < chart2data.length; i++) {
            chart2data[i].data.sort(function(a, b) {
                return a[0] - b[0]
            })
        }
    })

    // console.log('initWindow2Data:', chart2data[0])

}

// When chose a new date from window 2, init the data
function initWindow3Data() {

    area = []
    chartdata = []

    $.each(datamap, function () {

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

    })

    // console.log('initWindow3Data:', area)
    // console.log('initWindow3Data:', chartdata)

}

// Window 3
function initBarChart() {

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

                                    // 点击某地刷新Window 2数据
                                    SITE_NAME = this.SITE_NAME
                                    initWindow2Data()
                                    initDateChart()
                                    initMap()

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
function initDateChart() {

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
                point: {
                    events: {
                        click: function(e) {
                            $.each(date, function () {
                                var machineTime = calMachineTime(this)
                                if (machineTime == e.point.category) {
                                    // 点击某日更换 Window 3数据
                                    DATE = this
                                    initWindow3Data()
                                    initBarChart()
                                    initMap()
                                }
                            })
                        }
                    }
                },
                pointStart: dateStart
            },
        },
        series: chart2data
    });

}

// Google Map & Markers
function initMap() {


    // 修正演示数据
    $.each(datamap, function () {
        if (this.SAMPLE_DATE == DATE && this.ENDPOINT == 'LC50') {

            this.SUM = Math.sqrt(this.SUM)
            mapdata.push(this)
            
        }
    });

    // 清空Marker 用于点击事件后的初始化
    // $.each(mapdata, function () {
    //     this.marker = null
    // })


    map.clearMarkers()

    // console.log('Before InitMap: ', markersArray, bounds)

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

        // this.marker = marker;
        markersArray.push(marker)
        google.maps.event.addListener(marker, "click", function(){})

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

    // console.log('After InitMap: ', markersArray, bounds)

}
