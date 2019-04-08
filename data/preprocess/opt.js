const mysql = require('mysql')

var fs = require('fs')
var path = require('path')

const connection = mysql.createConnection({
	host: 'localhost',
	user: 'root',
	password: 'charlotte2',
	database: 'norway'
});

console.log('Database connected.');

var data = {data:[]}
var queryString = 'SELECT * FROM NORWAY_DATA'

connection.query(queryString, function(error, results, fields) {
	if (results) {
		for (i = 0; i < results.length; i++) {

			// 处理日期
			var date_str = results[i]["SAMPLE_DATE"].substr(1, results[i]["SAMPLE_DATE"].length-2)
			var splited = date_str.split(".")
			if (splited[1][0] == "0") {
				splited[1] = splited[1].substr(1, splited[1].length-1)
			}
			if (splited[0][0] == "0") {
				splited[0] = splited[0].substr(1, splited[0].length-1)
			}

			// 处理双引号
			var obj = {
				"CAMPAIGN": results[i]["CAMPAIGN"].substr(1, results[i]["CAMPAIGN"].length-2),
				"COUNTRY": results[i]["COUNTRY"],
				"SITE_CODE": ""+results[i]["SITE_CODE"],
				"ENDPOINT": results[i]["ENDPOINT"].substr(1, results[i]["ENDPOINT"].length-2),
				"SAMPLE_DATE": results[i]["SAMPLE_DATE"].substr(1, results[i]["SAMPLE_DATE"].length-2),
				"SAMPLE_DAY": splited[0],
				"SAMPLE_MONTH": splited[1],
				"SAMPLE_YEAR": splited[2],
				"SUM": ""+results[i]["SUM"],
				"TOTAL": ""+results[i]["TOTAL"],
				"SITE_NAME": results[i]["SITE_NAME"].substr(1, results[i]["SITE_NAME"].length-2),
				"lat": ""+results[i]["lat"],
				"lon": ""+results[i]["lon"]
			}
			//console.log(obj)
			data.data.push(obj)
		}
		//console.log(data)

		connection.end()

		var content = JSON.stringify(data)
		var file = path.join(__dirname, 'test.json')

		fs.writeFile(file, content, function(err) {
			if (err) {
				return console.log(err)
			}
			console.log("文件" + file + "创建成功。")
		});

	}
});


/*
// 截取字符串测试

var date_str = "27.05.2013"

var splited = date_str.split(".")

var date = {
	"day": splited[0],
	"month": splited[1],
	"year": splited[2]
}


console.log(date)

*/