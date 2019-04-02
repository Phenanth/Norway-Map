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

$(init) 

function init() {
    initMap()
    initchart()
}

// Google Map & Markers
function initMap() {

    bounds  = new google.maps.LatLngBounds();
    map = new google.maps.Map(document.getElementById('container'), { mapTypeId: 'terrain' });

    // 修正演示数据
    $.each(datamap, function () {
        this.SUM = Math.sqrt(this.SUM)

        if (this.SPECIES_GROUP === 'AHR' ) {
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
        infoHTML = infoHTML.format(this.SITE_NAME, this.CAMPAIGN, this.COUNTRY, this.SPECIES_GROUP, this.SUM, this.TOTAL)
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
    area = []
    chartdata = [{
        name: 'AHR',
        data: []
    }, {
        name: 'ER',
        data: []
    }, {
        name: 'AR',
        data: []        
    }, {
        name: 'TP53',
        data: []
    }]

    $.each(datamap, function () {
        ret = Number(this.SUM);
        if (this.SPECIES_GROUP === 'AHR') {
            chartdata[0].data.push(ret)
            area.push(this.SITE_NAME)
        } else if (this.SPECIES_GROUP === 'ER') {
            chartdata[1].data.push(ret)
        } else if (this.SPECIES_GROUP === 'AR') {
            chartdata[2].data.push(ret)
        } else if (this.SPECIES_GROUP === 'TP53') {
            chartdata[3].data.push(ret)
        }  
    });


    Highcharts.chart('cnt-charts', {
        chart: {
            type: 'bar'
        },
        title: {
            text: 'Cumulative Hazard/Risk'
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
            x: -40,
            y: 0,
            floating: true,
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
