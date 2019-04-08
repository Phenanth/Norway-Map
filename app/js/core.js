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

// Window 3 初始化的内容
var YEAR = "2012"
var MONTH = "6"
var DAY = "25"

var NUM_ENDPOINT = 21

$(init) 

function init() {
    initMap()
    initDateChart()
    initchart()
}

// Google Map & Markers
function initMap() {

    bounds  = new google.maps.LatLngBounds();
    map = new google.maps.Map(document.getElementById('container'), { mapTypeId: 'terrain' });

    // 修正演示数据
    $.each(datamap, function () {
        if (this.SAMPLE_YEAR == YEAR && this.SAMPLE_MONTH == MONTH && this.SAMPLE_DAY == DAY) {
            this.SUM = Math.sqrt(this.SUM)

            if (this.ENDPOINT === 'LC50')
            //if (this.SPECIES_GROUP === 'AHR' ) {
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

// HighCharts
function initchart() {
    // 测试地区较少，只有这五个
    area = ['HEIA', 'VASSHAGLONA', 'TIME', 'HOTRAN', 'SKUTERUD']
    chartdata = []


    $.each(datamap, function () {
        if (this.SAMPLE_YEAR == YEAR && this.SAMPLE_MONTH == MONTH && this.SAMPLE_DAY == DAY) {
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
            x: 10,
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
    })
}

// Window 3
function initDateChart() {
    date = []
    chart2data = []

    $.each(datamap, function () {

        // 只取SITE_NAME为HEIA的数据
        if (this.SITE_NAME == "HEIA") {
            var flag2 = 0

            for (var i = 0; i < date.length; i++) {
                // 因为天数的数据太多 只在一年里取一天的数据作为x轴
                if (date[i].substr(6, 9) == this.SAMPLE_DATE.substr(6, 9)) {
                    flag2 = 1
                    break
                }
            }
            // 当是第一次添加这个日期或者是再次遇到这个日期的数据
            if (flag2 == 0 || date[i] == this.SAMPLE_DATE) {
                if (flag2 == 0) { 
                    date.push(this.SAMPLE_DATE)
                    // 排序后数据顺序会不对 暂时不管
                    /*date.sort(function(a, b) {
                        return a.substr(6, 9) - b.substr(6, 9)
                    })*/
                }

                flag2 = 0
                var ret2 = Number(this.TOTAL)
                for (var i = 0; i < chart2data.length; i++) {
                    if (chart2data[i]["name"] == this.ENDPOINT) {
                        chart2data[i]["data"].push(ret2)
                        flag2 = 1
                        break
                    }
                }
                if (flag2 == 0) {
                    var obj = {
                        name: this.ENDPOINT,
                        data: []
                    }
                    obj.data.push(ret2)
                    chart2data.push(obj)
                }


            }

        }

    });

    // console.log(date)
    // console.log(chart2data)

    // 最大的问题在Window 2画出来了之后y轴的排序不对
    Highcharts.chart('cnt-date-charts', {
        title: {
            text: 'Window 3: TEMPORAL'
        },
        subtitle: {
            text: 'Source: NIVA RAdb'
        },
        /*xAxis: {
            categories: date
        },*/
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
                pointStart: 2012
            },
        },
        series: chart2data
    })
}