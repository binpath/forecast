$.import("sap.hana.xs.libs.dbutils", "xsds");

var XSDS = $.sap.hana.xs.libs.dbutils.xsds;

var Forecast = XSDS.$importEntity("ServiceNS.services.sd.forecast.data", "forecastVentas.forecast");

$.response.contentType = "text/html";

//var oForecast = Forecast.$get({ VENDEDOR: '0007000383', GRUPO: '87', YEAR: 2020, MONTH: 4, WEEK: 14, WEEKNUMBER: 1 });

var currentWeekForecast = Forecast.$findAll({ YEAR: 2020, MONTH: 4, WEEK: 14, WEEKNUMBER: 1 });

//remove duplicates
var str = "";
var index = 0;
currentWeekForecast.forEach(function(item) {
     index++;
     str = str + "BEFORE=> INDEX: " + index + " SALESREP: " + item.VENDEDOR + " GRUPO: " + item.GRUPO + " F_MES: " + item.F_MES + " STATUS: " + item.STATUS + "<br>";
     item.STATUS = 'A';
     item.$save();
     str = str + "AFTER => INDEX: " + index + " SALESREP: " + item.VENDEDOR + " GRUPO: " + item.GRUPO + " F_MES: " + item.F_MES + " STATUS: " + item.STATUS + "<br>";
     
     var newWeekForecast = new Forecast({ VENDEDOR: item.VENDEDOR, 
                                          GRUPO: item.GRUPO, 
                                          YEAR: item.YEAR, 
                                          MONTH: item.MONTH, 
                                          WEEK: 15, 
                                          WEEKNUMBER: 2, 
                                          F_MES: item.F_MES, 
                                          F_FORWARD: item.F_FORWARD, 
                                          STATUS: 'B', 
                                          CURRENCY: 'USD' } );
     newWeekForecast.$save();
     
     str = str + "NEW => INDEX: " + index + " SALESREP: " + newWeekForecast.VENDEDOR + " GRUPO: " + newWeekForecast.GRUPO + " F_MES: " + newWeekForecast.F_MES + " STATUS: " + newWeekForecast.STATUS + "<br><br>";
     
});

$.response.setBody( str );	









