select 
        usuario_del_vendedor_en_scp.KUNVE as KUNNR,
        usuario_del_vendedor_en_scp.USUARIO,
        usuario_del_vendedor_en_scp.TUSUARIO,
        usuario_del_vendedor_en_scp.EMAIL,
        zonal_del_vendedor_en_scp.KUNN2,
        usuario_zonal.USUARIO as UZONAL,
        usuario_zonal.NOMBRE as NZONAL,
        usuario_zonal.EMAIL as EZONAL,
        usuario_del_vendedor_en_scp.KUNZO as KUNZO,
        usuario_del_vendedor_en_scp.KUNVE as KUNVE,
        usuario_del_vendedor_en_scp.KUNJO as KUNJO,
        usuario_del_vendedor_en_scp.ACTIVO as ACTIVO,
        vendedores.NAME1 as NOMBRE,
        --resumen.CURRENT_MONTH,
        --resumen.CURRENT_WEEK,
        --resumen.F_MES
        SUM(resumen.F_MES)
    from 
        NSAGRO64.KNA1 as vendedores
    left outer join  
        NSAGRO64.ZSCP_USUARIO as usuario_del_vendedor_en_scp
    on  vendedores.KUNNR = usuario_del_vendedor_en_scp.KUNVE
    left outer join  
        NSAGRO64.KNVP as zonal_del_vendedor_en_scp
        on  zonal_del_vendedor_en_scp.KUNNR = usuario_del_vendedor_en_scp.KUNVE and zonal_del_vendedor_en_scp.PARVW = 'JZ'
    left outer join  
        NSAGRO64.ZSCP_USUARIO as usuario_zonal
        on  zonal_del_vendedor_en_scp.KUNN2 = usuario_zonal.KUNNR and usuario_zonal.ACTIVO = 'X' 
    inner join "NSAGRO64"."ServiceNS.services.sd.forecast.data::forecastcal.vw_ventas_forecast" as resumen
        on  vendedores.KUNNR = resumen.VENDEDOR 
    where 
    vendedores.KTOKD = 'ZD07' and
    vendedores.NODEL <> 'X' and
    usuario_del_vendedor_en_scp.ACTIVO = 'X' and 
    ( usuario_del_vendedor_en_scp.TUSUARIO2 = 'VE' OR usuario_del_vendedor_en_scp.TUSUARIO2 = 'ZO')
    and zonal_del_vendedor_en_scp.VKORG = '1000'
    and vendedores.KUNNR = '0007000387'
    GROUP BY 
        usuario_del_vendedor_en_scp.KUNVE, 
        vendedores.NAME1, 
        usuario_del_vendedor_en_scp.USUARIO, 
        usuario_del_vendedor_en_scp.TUSUARIO,
        usuario_del_vendedor_en_scp.EMAIL,
        zonal_del_vendedor_en_scp.KUNN2,
        usuario_zonal.USUARIO,
        usuario_zonal.NOMBRE,
        usuario_zonal.EMAIL,
        usuario_del_vendedor_en_scp.KUNZO, 
        usuario_del_vendedor_en_scp.KUNVE, 
        usuario_del_vendedor_en_scp.KUNJO, 
        usuario_del_vendedor_en_scp.ACTIVO,
        resumen.CURRENT_MONTH,
        resumen.CURRENT_WEEK;


SELECT * FROM NSAGRO64.KNVP WHERE KUNNR = '0007000387' AND PARVW = 'JZ';

--SELECT SUM(F_MES) FROM "NSAGRO64"."ServiceNS.services.sd.forecast.data::forecastcal.vw_ventas_forecast" 
--WHERE VENDEDOR = '0007000387' AND CURRENT_MONTH = '4' AND CURRENT_WEEK = WEEK(CURRENT_DATE); 