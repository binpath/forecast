SELECT SUM(F_MES) FROM "NSAGRO"."ServiceNS.services.sd.forecast.data::forecastVentas.forecast" 
    WHERE VENDEDOR = '0007000383' 
      AND MONTH = '4'
      AND WEEK = '14';
      
SELECT * FROM "NSAGRO"."ServiceNS.services.sd.forecast.data::forecastVentas.forecast" 
    WHERE VENDEDOR = '0007000383'
      AND "GRUPO" = 1165
      AND MONTH = '4'
      AND WEEK = '14';
      