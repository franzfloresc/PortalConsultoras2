USE BelcorpPeru
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_ProductoComercial]   
AS  
BEGIN   
SET NOCOUNT ON;  
  
--------------------------------------  
declare @cteCampanias table  
(  
 CampaniaID int  
)  
  
insert into @cteCampanias  
select distinct TOP 8 CampaniaID   
FROM ods.ProductoComercial PM with(nolock)  
order by 1 desc  
--------------------------------------  
  
CREATE TABLE #ProductoTemporal (    
  CampaniaId   int    
  ,CodigoCampania int  
  ,CUV    varchar(50)    
  ,DescripcionCUV varchar(100)  
  ,CodigoProducto varchar(10)  
  ,PrecioUnitario  numeric(12,2)    
  ,IndicadorPreUni numeric(12,2)  
  ,PrecioPublico  numeric(12,2)   
  ,PrecioOferta  numeric(12,2)    
  ,PrecioTachado  numeric(12,2)     
  ,Ganancia  numeric(12,2)     
  ,IndicadorMontoMinimo int   
  ,IndicadorDigitable int   
  ,EstrategiaIdSicc int    
  ,CodigoOferta  int    
  ,NumeroGrupo  int    
  ,NumeroNivel  int    
  ,MarcaId int  
  ,MarcaDescripcion varchar(50)  
  ,IdMatrizComercial int  
  ,ImagenURL varchar(150)  
  ,Niveles varchar(200)  
  ,CodigoCatalogo varchar(6)  
  ,Categoria varchar(200)  
  ,GrupoArticulo varchar(200)  
  ,Linea varchar(200)  
  ,PrecioCatalogo  numeric(12,2)  
  ,PrecioValorizado  numeric(12,2)  
  ,FactorRepeticion int  
  ,CodigoTipoOferta varchar(6)  
 )   
 INSERT INTO #ProductoTemporal  
 SELECT   
 p.CampaniaID,  
 p.AnoCampania,  
 p.CUV,  
 REPLACE(COALESCE(mci.DescripcionComercial, pd.Descripcion,p.Descripcion),'"',char(39)) as DescripcionCUV,   
 p.CodigoProducto,  
 p.PrecioUnitario,  
 p.IndicadorPreUni,  
 0,  
 0,  
 0,  
 0,  
 p.IndicadorMontoMinimo,  
 p.IndicadorDigitable,     
 p.EstrategiaIdSicc,    
 p.CodigoOferta,    
 p.NumeroGrupo,    
 p.NumeroNivel,    
 p.MarcaID,   
 m.Descripcion,   
 mc.IdMatrizComercial,  
 mci.Foto AS ImagenURL,  
 '',  
 RTRIM(p.CodigoCatalago) AS CodigoCatalago,  
 fb.Nombre,  
 ga.DescripcionCorta,  
 sl.DescripcionLarga,  
 p.PrecioCatalogo,  
 p.PrecioValorizado,  
 p.FactorRepeticion,  
 RTRIM(p.CodigoTipoOferta) AS CodigoTipoOferta  
FROM ods.ProductoComercial p WITH (NOLOCK)   
 INNER JOIN dbo.Marca m WITH (NOLOCK) on m.MarcaId = p.MarcaID   
 LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON p.CodigoProducto = sp.CodigoSap  
 LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo  
 LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo  
 LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo  
 LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo  
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) on p.AnoCampania = pd.CampaniaID and p.CUV = pd.CUV   
 LEFT JOIN dbo.MatrizComercial mc WITH (NOLOCK) on p.CodigoProducto = mc.CodigoSAP   
 LEFT JOIN dbo.MatrizComercialImagen mci WITH (NOLOCK) on mci.IdMatrizComercial = mc.IdMatrizComercial AND mci.NemoTecnico IS NOT NULL   
 WHERE p.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)  
  
CREATE TABLE #ProductoComercial(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioUnitario  numeric(12,2)    
 ,FactorRepeticion int    
 ,IndicadorDigitable bit    
 ,AnoCampania  int    
 ,IndicadorPreUni numeric(12,2)    
 ,CodigoFactorCuadre numeric(12,2)    
 ,EstrategiaIdSicc int    
 ,CodigoOferta  int    
 ,NumeroGrupo  int    
 ,NumeroNivel  int    
)    
INSERT INTO #ProductoComercial    
SELECT    
 PC.CampaniaID    
 ,PC.CUV    
 ,PC.PrecioUnitario    
 ,PC.FactorRepeticion    
 ,PC.IndicadorDigitable    
 ,PC.AnoCampania    
 ,PC.IndicadorPreUni    
 ,PC.CodigoFactorCuadre    
 ,PC.EstrategiaIdSicc    
 ,PC.CodigoOferta    
 ,PC.NumeroGrupo    
 ,PC.NumeroNivel    
FROM ods.ProductoComercial PC WITH (NOLOCK)   
WHERE PC.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)   
  
CREATE TABLE #ProductoNivel(    
 CUV   varchar(5)    
 ,Campana INT  
 ,Nivel  int    
 ,Precio  numeric(12,2)    
)    
INSERT INTO #ProductoNivel    
SELECT    
 PC.CUV    
 ,PC.AnoCampania  
 ,Nivel = PN.FactorCuadre    
 ,Precio = PN.PrecioUnitario    
FROM #ProductoComercial PC     
 JOIN ods.ProductoNivel PN   ON PC.NumeroNivel = PN.NumeroNivel AND PN.FactorCuadre > 1  --and PC.AnoCampania = pn.campana  
GROUP BY    
 PC.CUV    
 ,PC.AnoCampania  
 ,PN.FactorCuadre    
 ,PN.PrecioUnitario  
   
CREATE TABLE #ProductoTemporal_2001(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioPublico   decimal(18,2)    
 ,Ganancia    decimal(18,2)    
)    
INSERT INTO #ProductoTemporal_2001    
SELECT    
 PC.CampaniaID, PC.CUV  
 ,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion    
 ,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion    
FROM #ProductoComercial PC    
 WHERE (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)  
 AND PC.FactorRepeticion >= 1    
   
CREATE TABLE #ProductoTemporal_2002(    
 CodigoOferta int  
 ,CampaniaId  int   
 ,PrecioPublico decimal(18,2)  
 ,Ganancia  decimal(18,2)  
)  
 INSERT INTO #ProductoTemporal_2002    
 SELECT  
  PC.CodigoOferta  
  ,PC.CampaniaId  
  ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)  
  ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)  
FROM  #ProductoComercial PC  
WHERE PC.EstrategiaIdSicc = 2002  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta    
   
 CREATE TABLE #ProductoTemporal_2003(    
 CodigoOferta int  
  ,CampaniaId  int   
  ,PrecioPublico decimal(18,2)  
  ,Ganancia  decimal(18,2)  
 )    
 INSERT INTO #ProductoTemporal_2003    
 SELECT  
 PC.CodigoOferta  
 ,PC.CampaniaId  
 ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
 ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
FROM (SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, MAX(IndicadorPreUni) AS IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre   
  FROM #ProductoComercial   
  WHERE EstrategiaIdSicc = 2003  
  GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario,  FactorRepeticion, CodigoFactorCuadre) PC  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta   
    
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2001   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CUV = PT.CUV   
 AND EstrategiaIdSicc = 2001  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2002   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2002  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2003  PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2003  
  
UPDATE PT    
SET PT.Ganancia = 0    
FROM #ProductoTemporal PT  
WHERE PT.Ganancia < 0    
    
UPDATE PT    
SET PT.PrecioOferta = PT.PrecioPublico    
FROM #ProductoTemporal PT   
WHERE PT.PrecioPublico > 0    
  
UPDATE PT    
SET PT.PrecioTachado = PT.PrecioPublico + PT.Ganancia    
FROM #ProductoTemporal PT   
WHERE PT.Ganancia > 0    
UPDATE PN    
SET Precio = PN.Nivel * PN.Precio    
FROM #ProductoNivel PN    
  
CREATE TABLE #ProductoNiveles(    
CUV   varchar(5)    
,Campana INT  
,Niveles varchar(200)    
)    
INSERT INTO #ProductoNiveles    
SELECT   
 PN.CUV,    
 PN.Campana,  
 Niveles = ( SELECT STUFF( (SELECT '|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)    
   FROM #ProductoNivel    
   WHERE CUV = PN.CUV  and CAMPANA = PN.CAMPANA  
   FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),    
   1,    
   1,    
   ''    
   )    
  )    
FROM #ProductoNivel PN    
GROUP BY PN.CUV  , PN.Campana  
UPDATE PT    
SET    
 PT.Niveles = PNS.Niveles    
FROM #ProductoTemporal PT    
 JOIN #ProductoNiveles PNS ON PT.CUV = PNS.CUV  and PT.CodigoCampania = PNS.Campana  
SELECT * FROM #ProductoTemporal  
DROP TABLE #ProductoComercial    
DROP TABLE #ProductoNivel    
DROP TABLE #ProductoNiveles   
    
DROP TABLE #ProductoTemporal_2001    
DROP TABLE #ProductoTemporal_2002    
DROP TABLE #ProductoTemporal_2003    
DROP TABLE #ProductoTemporal  
END  

GO

USE BelcorpMexico
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_ProductoComercial]   
AS  
BEGIN   
SET NOCOUNT ON;  
  
--------------------------------------  
declare @cteCampanias table  
(  
 CampaniaID int  
)  
  
insert into @cteCampanias  
select distinct TOP 8 CampaniaID   
FROM ods.ProductoComercial PM with(nolock)  
order by 1 desc  
--------------------------------------  
  
CREATE TABLE #ProductoTemporal (    
  CampaniaId   int    
  ,CodigoCampania int  
  ,CUV    varchar(50)    
  ,DescripcionCUV varchar(100)  
  ,CodigoProducto varchar(10)  
  ,PrecioUnitario  numeric(12,2)    
  ,IndicadorPreUni numeric(12,2)  
  ,PrecioPublico  numeric(12,2)   
  ,PrecioOferta  numeric(12,2)    
  ,PrecioTachado  numeric(12,2)     
  ,Ganancia  numeric(12,2)     
  ,IndicadorMontoMinimo int   
  ,IndicadorDigitable int   
  ,EstrategiaIdSicc int    
  ,CodigoOferta  int    
  ,NumeroGrupo  int    
  ,NumeroNivel  int    
  ,MarcaId int  
  ,MarcaDescripcion varchar(50)  
  ,IdMatrizComercial int  
  ,ImagenURL varchar(150)  
  ,Niveles varchar(200)  
  ,CodigoCatalogo varchar(6)  
  ,Categoria varchar(200)  
  ,GrupoArticulo varchar(200)  
  ,Linea varchar(200)  
  ,PrecioCatalogo  numeric(12,2)  
  ,PrecioValorizado  numeric(12,2)  
  ,FactorRepeticion int  
  ,CodigoTipoOferta varchar(6)  
 )   
 INSERT INTO #ProductoTemporal  
 SELECT   
 p.CampaniaID,  
 p.AnoCampania,  
 p.CUV,  
 REPLACE(COALESCE(mci.DescripcionComercial, pd.Descripcion,p.Descripcion),'"',char(39)) as DescripcionCUV,   
 p.CodigoProducto,  
 p.PrecioUnitario,  
 p.IndicadorPreUni,  
 0,  
 0,  
 0,  
 0,  
 p.IndicadorMontoMinimo,  
 p.IndicadorDigitable,     
 p.EstrategiaIdSicc,    
 p.CodigoOferta,    
 p.NumeroGrupo,    
 p.NumeroNivel,    
 p.MarcaID,   
 m.Descripcion,   
 mc.IdMatrizComercial,  
 mci.Foto AS ImagenURL,  
 '',  
 RTRIM(p.CodigoCatalago) AS CodigoCatalago,  
 fb.Nombre,  
 ga.DescripcionCorta,  
 sl.DescripcionLarga,  
 p.PrecioCatalogo,  
 p.PrecioValorizado,  
 p.FactorRepeticion,  
 RTRIM(p.CodigoTipoOferta) AS CodigoTipoOferta  
FROM ods.ProductoComercial p WITH (NOLOCK)   
 INNER JOIN dbo.Marca m WITH (NOLOCK) on m.MarcaId = p.MarcaID   
 LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON p.CodigoProducto = sp.CodigoSap  
 LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo  
 LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo  
 LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo  
 LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo  
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) on p.AnoCampania = pd.CampaniaID and p.CUV = pd.CUV   
 LEFT JOIN dbo.MatrizComercial mc WITH (NOLOCK) on p.CodigoProducto = mc.CodigoSAP   
 LEFT JOIN dbo.MatrizComercialImagen mci WITH (NOLOCK) on mci.IdMatrizComercial = mc.IdMatrizComercial AND mci.NemoTecnico IS NOT NULL   
 WHERE p.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)  
  
CREATE TABLE #ProductoComercial(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioUnitario  numeric(12,2)    
 ,FactorRepeticion int    
 ,IndicadorDigitable bit    
 ,AnoCampania  int    
 ,IndicadorPreUni numeric(12,2)    
 ,CodigoFactorCuadre numeric(12,2)    
 ,EstrategiaIdSicc int    
 ,CodigoOferta  int    
 ,NumeroGrupo  int    
 ,NumeroNivel  int    
)    
INSERT INTO #ProductoComercial    
SELECT    
 PC.CampaniaID    
 ,PC.CUV    
 ,PC.PrecioUnitario    
 ,PC.FactorRepeticion    
 ,PC.IndicadorDigitable    
 ,PC.AnoCampania    
 ,PC.IndicadorPreUni    
 ,PC.CodigoFactorCuadre    
 ,PC.EstrategiaIdSicc    
 ,PC.CodigoOferta    
 ,PC.NumeroGrupo    
 ,PC.NumeroNivel    
FROM ods.ProductoComercial PC WITH (NOLOCK)   
WHERE PC.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)   
  
CREATE TABLE #ProductoNivel(    
 CUV   varchar(5)    
 ,Campana INT  
 ,Nivel  int    
 ,Precio  numeric(12,2)    
)    
INSERT INTO #ProductoNivel    
SELECT    
 PC.CUV    
 ,PC.AnoCampania  
 ,Nivel = PN.FactorCuadre    
 ,Precio = PN.PrecioUnitario    
FROM #ProductoComercial PC     
 JOIN ods.ProductoNivel PN   ON PC.NumeroNivel = PN.NumeroNivel AND PN.FactorCuadre > 1  --and PC.AnoCampania = pn.campana  
GROUP BY    
 PC.CUV    
 ,PC.AnoCampania  
 ,PN.FactorCuadre    
 ,PN.PrecioUnitario  
   
CREATE TABLE #ProductoTemporal_2001(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioPublico   decimal(18,2)    
 ,Ganancia    decimal(18,2)    
)    
INSERT INTO #ProductoTemporal_2001    
SELECT    
 PC.CampaniaID, PC.CUV  
 ,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion    
 ,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion    
FROM #ProductoComercial PC    
 WHERE (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)  
 AND PC.FactorRepeticion >= 1    
   
CREATE TABLE #ProductoTemporal_2002(    
 CodigoOferta int  
 ,CampaniaId  int   
 ,PrecioPublico decimal(18,2)  
 ,Ganancia  decimal(18,2)  
)  
 INSERT INTO #ProductoTemporal_2002    
 SELECT  
  PC.CodigoOferta  
  ,PC.CampaniaId  
  ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)  
  ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)  
FROM  #ProductoComercial PC  
WHERE PC.EstrategiaIdSicc = 2002  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta    
   
 CREATE TABLE #ProductoTemporal_2003(    
 CodigoOferta int  
  ,CampaniaId  int   
  ,PrecioPublico decimal(18,2)  
  ,Ganancia  decimal(18,2)  
 )    
 INSERT INTO #ProductoTemporal_2003    
 SELECT  
 PC.CodigoOferta  
 ,PC.CampaniaId  
 ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
 ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
FROM (SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, MAX(IndicadorPreUni) AS IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre   
  FROM #ProductoComercial   
  WHERE EstrategiaIdSicc = 2003  
  GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario,  FactorRepeticion, CodigoFactorCuadre) PC  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta   
    
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2001   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CUV = PT.CUV   
 AND EstrategiaIdSicc = 2001  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2002   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2002  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2003  PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2003  
  
UPDATE PT    
SET PT.Ganancia = 0    
FROM #ProductoTemporal PT  
WHERE PT.Ganancia < 0    
    
UPDATE PT    
SET PT.PrecioOferta = PT.PrecioPublico    
FROM #ProductoTemporal PT   
WHERE PT.PrecioPublico > 0    
  
UPDATE PT    
SET PT.PrecioTachado = PT.PrecioPublico + PT.Ganancia    
FROM #ProductoTemporal PT   
WHERE PT.Ganancia > 0    
UPDATE PN    
SET Precio = PN.Nivel * PN.Precio    
FROM #ProductoNivel PN    
  
CREATE TABLE #ProductoNiveles(    
CUV   varchar(5)    
,Campana INT  
,Niveles varchar(200)    
)    
INSERT INTO #ProductoNiveles    
SELECT   
 PN.CUV,    
 PN.Campana,  
 Niveles = ( SELECT STUFF( (SELECT '|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)    
   FROM #ProductoNivel    
   WHERE CUV = PN.CUV  and CAMPANA = PN.CAMPANA  
   FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),    
   1,    
   1,    
   ''    
   )    
  )    
FROM #ProductoNivel PN    
GROUP BY PN.CUV  , PN.Campana  
UPDATE PT    
SET    
 PT.Niveles = PNS.Niveles    
FROM #ProductoTemporal PT    
 JOIN #ProductoNiveles PNS ON PT.CUV = PNS.CUV  and PT.CodigoCampania = PNS.Campana  
SELECT * FROM #ProductoTemporal  
DROP TABLE #ProductoComercial    
DROP TABLE #ProductoNivel    
DROP TABLE #ProductoNiveles   
    
DROP TABLE #ProductoTemporal_2001    
DROP TABLE #ProductoTemporal_2002    
DROP TABLE #ProductoTemporal_2003    
DROP TABLE #ProductoTemporal  
END  

GO

USE BelcorpColombia
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_ProductoComercial]   
AS  
BEGIN   
SET NOCOUNT ON;  
  
--------------------------------------  
declare @cteCampanias table  
(  
 CampaniaID int  
)  
  
insert into @cteCampanias  
select distinct TOP 8 CampaniaID   
FROM ods.ProductoComercial PM with(nolock)  
order by 1 desc  
--------------------------------------  
  
CREATE TABLE #ProductoTemporal (    
  CampaniaId   int    
  ,CodigoCampania int  
  ,CUV    varchar(50)    
  ,DescripcionCUV varchar(100)  
  ,CodigoProducto varchar(10)  
  ,PrecioUnitario  numeric(12,2)    
  ,IndicadorPreUni numeric(12,2)  
  ,PrecioPublico  numeric(12,2)   
  ,PrecioOferta  numeric(12,2)    
  ,PrecioTachado  numeric(12,2)     
  ,Ganancia  numeric(12,2)     
  ,IndicadorMontoMinimo int   
  ,IndicadorDigitable int   
  ,EstrategiaIdSicc int    
  ,CodigoOferta  int    
  ,NumeroGrupo  int    
  ,NumeroNivel  int    
  ,MarcaId int  
  ,MarcaDescripcion varchar(50)  
  ,IdMatrizComercial int  
  ,ImagenURL varchar(150)  
  ,Niveles varchar(200)  
  ,CodigoCatalogo varchar(6)  
  ,Categoria varchar(200)  
  ,GrupoArticulo varchar(200)  
  ,Linea varchar(200)  
  ,PrecioCatalogo  numeric(12,2)  
  ,PrecioValorizado  numeric(12,2)  
  ,FactorRepeticion int  
  ,CodigoTipoOferta varchar(6)  
 )   
 INSERT INTO #ProductoTemporal  
 SELECT   
 p.CampaniaID,  
 p.AnoCampania,  
 p.CUV,  
 REPLACE(COALESCE(mci.DescripcionComercial, pd.Descripcion,p.Descripcion),'"',char(39)) as DescripcionCUV,   
 p.CodigoProducto,  
 p.PrecioUnitario,  
 p.IndicadorPreUni,  
 0,  
 0,  
 0,  
 0,  
 p.IndicadorMontoMinimo,  
 p.IndicadorDigitable,     
 p.EstrategiaIdSicc,    
 p.CodigoOferta,    
 p.NumeroGrupo,    
 p.NumeroNivel,    
 p.MarcaID,   
 m.Descripcion,   
 mc.IdMatrizComercial,  
 mci.Foto AS ImagenURL,  
 '',  
 RTRIM(p.CodigoCatalago) AS CodigoCatalago,  
 fb.Nombre,  
 ga.DescripcionCorta,  
 sl.DescripcionLarga,  
 p.PrecioCatalogo,  
 p.PrecioValorizado,  
 p.FactorRepeticion,  
 RTRIM(p.CodigoTipoOferta) AS CodigoTipoOferta  
FROM ods.ProductoComercial p WITH (NOLOCK)   
 INNER JOIN dbo.Marca m WITH (NOLOCK) on m.MarcaId = p.MarcaID   
 LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON p.CodigoProducto = sp.CodigoSap  
 LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo  
 LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo  
 LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo  
 LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo  
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) on p.AnoCampania = pd.CampaniaID and p.CUV = pd.CUV   
 LEFT JOIN dbo.MatrizComercial mc WITH (NOLOCK) on p.CodigoProducto = mc.CodigoSAP   
 LEFT JOIN dbo.MatrizComercialImagen mci WITH (NOLOCK) on mci.IdMatrizComercial = mc.IdMatrizComercial AND mci.NemoTecnico IS NOT NULL   
 WHERE p.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)  
  
CREATE TABLE #ProductoComercial(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioUnitario  numeric(12,2)    
 ,FactorRepeticion int    
 ,IndicadorDigitable bit    
 ,AnoCampania  int    
 ,IndicadorPreUni numeric(12,2)    
 ,CodigoFactorCuadre numeric(12,2)    
 ,EstrategiaIdSicc int    
 ,CodigoOferta  int    
 ,NumeroGrupo  int    
 ,NumeroNivel  int    
)    
INSERT INTO #ProductoComercial    
SELECT    
 PC.CampaniaID    
 ,PC.CUV    
 ,PC.PrecioUnitario    
 ,PC.FactorRepeticion    
 ,PC.IndicadorDigitable    
 ,PC.AnoCampania    
 ,PC.IndicadorPreUni    
 ,PC.CodigoFactorCuadre    
 ,PC.EstrategiaIdSicc    
 ,PC.CodigoOferta    
 ,PC.NumeroGrupo    
 ,PC.NumeroNivel    
FROM ods.ProductoComercial PC WITH (NOLOCK)   
WHERE PC.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)   
  
CREATE TABLE #ProductoNivel(    
 CUV   varchar(5)    
 ,Campana INT  
 ,Nivel  int    
 ,Precio  numeric(12,2)    
)    
INSERT INTO #ProductoNivel    
SELECT    
 PC.CUV    
 ,PC.AnoCampania  
 ,Nivel = PN.FactorCuadre    
 ,Precio = PN.PrecioUnitario    
FROM #ProductoComercial PC     
 JOIN ods.ProductoNivel PN   ON PC.NumeroNivel = PN.NumeroNivel AND PN.FactorCuadre > 1  --and PC.AnoCampania = pn.campana  
GROUP BY    
 PC.CUV    
 ,PC.AnoCampania  
 ,PN.FactorCuadre    
 ,PN.PrecioUnitario  
   
CREATE TABLE #ProductoTemporal_2001(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioPublico   decimal(18,2)    
 ,Ganancia    decimal(18,2)    
)    
INSERT INTO #ProductoTemporal_2001    
SELECT    
 PC.CampaniaID, PC.CUV  
 ,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion    
 ,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion    
FROM #ProductoComercial PC    
 WHERE (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)  
 AND PC.FactorRepeticion >= 1    
   
CREATE TABLE #ProductoTemporal_2002(    
 CodigoOferta int  
 ,CampaniaId  int   
 ,PrecioPublico decimal(18,2)  
 ,Ganancia  decimal(18,2)  
)  
 INSERT INTO #ProductoTemporal_2002    
 SELECT  
  PC.CodigoOferta  
  ,PC.CampaniaId  
  ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)  
  ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)  
FROM  #ProductoComercial PC  
WHERE PC.EstrategiaIdSicc = 2002  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta    
   
 CREATE TABLE #ProductoTemporal_2003(    
 CodigoOferta int  
  ,CampaniaId  int   
  ,PrecioPublico decimal(18,2)  
  ,Ganancia  decimal(18,2)  
 )    
 INSERT INTO #ProductoTemporal_2003    
 SELECT  
 PC.CodigoOferta  
 ,PC.CampaniaId  
 ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
 ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
FROM (SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, MAX(IndicadorPreUni) AS IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre   
  FROM #ProductoComercial   
  WHERE EstrategiaIdSicc = 2003  
  GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario,  FactorRepeticion, CodigoFactorCuadre) PC  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta   
    
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2001   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CUV = PT.CUV   
 AND EstrategiaIdSicc = 2001  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2002   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2002  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2003  PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2003  
  
UPDATE PT    
SET PT.Ganancia = 0    
FROM #ProductoTemporal PT  
WHERE PT.Ganancia < 0    
    
UPDATE PT    
SET PT.PrecioOferta = PT.PrecioPublico    
FROM #ProductoTemporal PT   
WHERE PT.PrecioPublico > 0    
  
UPDATE PT    
SET PT.PrecioTachado = PT.PrecioPublico + PT.Ganancia    
FROM #ProductoTemporal PT   
WHERE PT.Ganancia > 0    
UPDATE PN    
SET Precio = PN.Nivel * PN.Precio    
FROM #ProductoNivel PN    
  
CREATE TABLE #ProductoNiveles(    
CUV   varchar(5)    
,Campana INT  
,Niveles varchar(200)    
)    
INSERT INTO #ProductoNiveles    
SELECT   
 PN.CUV,    
 PN.Campana,  
 Niveles = ( SELECT STUFF( (SELECT '|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)    
   FROM #ProductoNivel    
   WHERE CUV = PN.CUV  and CAMPANA = PN.CAMPANA  
   FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),    
   1,    
   1,    
   ''    
   )    
  )    
FROM #ProductoNivel PN    
GROUP BY PN.CUV  , PN.Campana  
UPDATE PT    
SET    
 PT.Niveles = PNS.Niveles    
FROM #ProductoTemporal PT    
 JOIN #ProductoNiveles PNS ON PT.CUV = PNS.CUV  and PT.CodigoCampania = PNS.Campana  
SELECT * FROM #ProductoTemporal  
DROP TABLE #ProductoComercial    
DROP TABLE #ProductoNivel    
DROP TABLE #ProductoNiveles   
    
DROP TABLE #ProductoTemporal_2001    
DROP TABLE #ProductoTemporal_2002    
DROP TABLE #ProductoTemporal_2003    
DROP TABLE #ProductoTemporal  
END  

GO

USE BelcorpSalvador
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_ProductoComercial]   
AS  
BEGIN   
SET NOCOUNT ON;  
  
--------------------------------------  
declare @cteCampanias table  
(  
 CampaniaID int  
)  
  
insert into @cteCampanias  
select distinct TOP 8 CampaniaID   
FROM ods.ProductoComercial PM with(nolock)  
order by 1 desc  
--------------------------------------  
  
CREATE TABLE #ProductoTemporal (    
  CampaniaId   int    
  ,CodigoCampania int  
  ,CUV    varchar(50)    
  ,DescripcionCUV varchar(100)  
  ,CodigoProducto varchar(10)  
  ,PrecioUnitario  numeric(12,2)    
  ,IndicadorPreUni numeric(12,2)  
  ,PrecioPublico  numeric(12,2)   
  ,PrecioOferta  numeric(12,2)    
  ,PrecioTachado  numeric(12,2)     
  ,Ganancia  numeric(12,2)     
  ,IndicadorMontoMinimo int   
  ,IndicadorDigitable int   
  ,EstrategiaIdSicc int    
  ,CodigoOferta  int    
  ,NumeroGrupo  int    
  ,NumeroNivel  int    
  ,MarcaId int  
  ,MarcaDescripcion varchar(50)  
  ,IdMatrizComercial int  
  ,ImagenURL varchar(150)  
  ,Niveles varchar(200)  
  ,CodigoCatalogo varchar(6)  
  ,Categoria varchar(200)  
  ,GrupoArticulo varchar(200)  
  ,Linea varchar(200)  
  ,PrecioCatalogo  numeric(12,2)  
  ,PrecioValorizado  numeric(12,2)  
  ,FactorRepeticion int  
  ,CodigoTipoOferta varchar(6)  
 )   
 INSERT INTO #ProductoTemporal  
 SELECT   
 p.CampaniaID,  
 p.AnoCampania,  
 p.CUV,  
 REPLACE(COALESCE(mci.DescripcionComercial, pd.Descripcion,p.Descripcion),'"',char(39)) as DescripcionCUV,   
 p.CodigoProducto,  
 p.PrecioUnitario,  
 p.IndicadorPreUni,  
 0,  
 0,  
 0,  
 0,  
 p.IndicadorMontoMinimo,  
 p.IndicadorDigitable,     
 p.EstrategiaIdSicc,    
 p.CodigoOferta,    
 p.NumeroGrupo,    
 p.NumeroNivel,    
 p.MarcaID,   
 m.Descripcion,   
 mc.IdMatrizComercial,  
 mci.Foto AS ImagenURL,  
 '',  
 RTRIM(p.CodigoCatalago) AS CodigoCatalago,  
 fb.Nombre,  
 ga.DescripcionCorta,  
 sl.DescripcionLarga,  
 p.PrecioCatalogo,  
 p.PrecioValorizado,  
 p.FactorRepeticion,  
 RTRIM(p.CodigoTipoOferta) AS CodigoTipoOferta  
FROM ods.ProductoComercial p WITH (NOLOCK)   
 INNER JOIN dbo.Marca m WITH (NOLOCK) on m.MarcaId = p.MarcaID   
 LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON p.CodigoProducto = sp.CodigoSap  
 LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo  
 LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo  
 LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo  
 LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo  
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) on p.AnoCampania = pd.CampaniaID and p.CUV = pd.CUV   
 LEFT JOIN dbo.MatrizComercial mc WITH (NOLOCK) on p.CodigoProducto = mc.CodigoSAP   
 LEFT JOIN dbo.MatrizComercialImagen mci WITH (NOLOCK) on mci.IdMatrizComercial = mc.IdMatrizComercial AND mci.NemoTecnico IS NOT NULL   
 WHERE p.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)  
  
CREATE TABLE #ProductoComercial(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioUnitario  numeric(12,2)    
 ,FactorRepeticion int    
 ,IndicadorDigitable bit    
 ,AnoCampania  int    
 ,IndicadorPreUni numeric(12,2)    
 ,CodigoFactorCuadre numeric(12,2)    
 ,EstrategiaIdSicc int    
 ,CodigoOferta  int    
 ,NumeroGrupo  int    
 ,NumeroNivel  int    
)    
INSERT INTO #ProductoComercial    
SELECT    
 PC.CampaniaID    
 ,PC.CUV    
 ,PC.PrecioUnitario    
 ,PC.FactorRepeticion    
 ,PC.IndicadorDigitable    
 ,PC.AnoCampania    
 ,PC.IndicadorPreUni    
 ,PC.CodigoFactorCuadre    
 ,PC.EstrategiaIdSicc    
 ,PC.CodigoOferta    
 ,PC.NumeroGrupo    
 ,PC.NumeroNivel    
FROM ods.ProductoComercial PC WITH (NOLOCK)   
WHERE PC.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)   
  
CREATE TABLE #ProductoNivel(    
 CUV   varchar(5)    
 ,Campana INT  
 ,Nivel  int    
 ,Precio  numeric(12,2)    
)    
INSERT INTO #ProductoNivel    
SELECT    
 PC.CUV    
 ,PC.AnoCampania  
 ,Nivel = PN.FactorCuadre    
 ,Precio = PN.PrecioUnitario    
FROM #ProductoComercial PC     
 JOIN ods.ProductoNivel PN   ON PC.NumeroNivel = PN.NumeroNivel AND PN.FactorCuadre > 1  --and PC.AnoCampania = pn.campana  
GROUP BY    
 PC.CUV    
 ,PC.AnoCampania  
 ,PN.FactorCuadre    
 ,PN.PrecioUnitario  
   
CREATE TABLE #ProductoTemporal_2001(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioPublico   decimal(18,2)    
 ,Ganancia    decimal(18,2)    
)    
INSERT INTO #ProductoTemporal_2001    
SELECT    
 PC.CampaniaID, PC.CUV  
 ,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion    
 ,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion    
FROM #ProductoComercial PC    
 WHERE (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)  
 AND PC.FactorRepeticion >= 1    
   
CREATE TABLE #ProductoTemporal_2002(    
 CodigoOferta int  
 ,CampaniaId  int   
 ,PrecioPublico decimal(18,2)  
 ,Ganancia  decimal(18,2)  
)  
 INSERT INTO #ProductoTemporal_2002    
 SELECT  
  PC.CodigoOferta  
  ,PC.CampaniaId  
  ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)  
  ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)  
FROM  #ProductoComercial PC  
WHERE PC.EstrategiaIdSicc = 2002  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta    
   
 CREATE TABLE #ProductoTemporal_2003(    
 CodigoOferta int  
  ,CampaniaId  int   
  ,PrecioPublico decimal(18,2)  
  ,Ganancia  decimal(18,2)  
 )    
 INSERT INTO #ProductoTemporal_2003    
 SELECT  
 PC.CodigoOferta  
 ,PC.CampaniaId  
 ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
 ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
FROM (SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, MAX(IndicadorPreUni) AS IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre   
  FROM #ProductoComercial   
  WHERE EstrategiaIdSicc = 2003  
  GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario,  FactorRepeticion, CodigoFactorCuadre) PC  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta   
    
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2001   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CUV = PT.CUV   
 AND EstrategiaIdSicc = 2001  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2002   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2002  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2003  PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2003  
  
UPDATE PT    
SET PT.Ganancia = 0    
FROM #ProductoTemporal PT  
WHERE PT.Ganancia < 0    
    
UPDATE PT    
SET PT.PrecioOferta = PT.PrecioPublico    
FROM #ProductoTemporal PT   
WHERE PT.PrecioPublico > 0    
  
UPDATE PT    
SET PT.PrecioTachado = PT.PrecioPublico + PT.Ganancia    
FROM #ProductoTemporal PT   
WHERE PT.Ganancia > 0    
UPDATE PN    
SET Precio = PN.Nivel * PN.Precio    
FROM #ProductoNivel PN    
  
CREATE TABLE #ProductoNiveles(    
CUV   varchar(5)    
,Campana INT  
,Niveles varchar(200)    
)    
INSERT INTO #ProductoNiveles    
SELECT   
 PN.CUV,    
 PN.Campana,  
 Niveles = ( SELECT STUFF( (SELECT '|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)    
   FROM #ProductoNivel    
   WHERE CUV = PN.CUV  and CAMPANA = PN.CAMPANA  
   FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),    
   1,    
   1,    
   ''    
   )    
  )    
FROM #ProductoNivel PN    
GROUP BY PN.CUV  , PN.Campana  
UPDATE PT    
SET    
 PT.Niveles = PNS.Niveles    
FROM #ProductoTemporal PT    
 JOIN #ProductoNiveles PNS ON PT.CUV = PNS.CUV  and PT.CodigoCampania = PNS.Campana  
SELECT * FROM #ProductoTemporal  
DROP TABLE #ProductoComercial    
DROP TABLE #ProductoNivel    
DROP TABLE #ProductoNiveles   
    
DROP TABLE #ProductoTemporal_2001    
DROP TABLE #ProductoTemporal_2002    
DROP TABLE #ProductoTemporal_2003    
DROP TABLE #ProductoTemporal  
END  

GO

USE BelcorpPuertoRico
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_ProductoComercial]   
AS  
BEGIN   
SET NOCOUNT ON;  
  
--------------------------------------  
declare @cteCampanias table  
(  
 CampaniaID int  
)  
  
insert into @cteCampanias  
select distinct TOP 8 CampaniaID   
FROM ods.ProductoComercial PM with(nolock)  
order by 1 desc  
--------------------------------------  
  
CREATE TABLE #ProductoTemporal (    
  CampaniaId   int    
  ,CodigoCampania int  
  ,CUV    varchar(50)    
  ,DescripcionCUV varchar(100)  
  ,CodigoProducto varchar(10)  
  ,PrecioUnitario  numeric(12,2)    
  ,IndicadorPreUni numeric(12,2)  
  ,PrecioPublico  numeric(12,2)   
  ,PrecioOferta  numeric(12,2)    
  ,PrecioTachado  numeric(12,2)     
  ,Ganancia  numeric(12,2)     
  ,IndicadorMontoMinimo int   
  ,IndicadorDigitable int   
  ,EstrategiaIdSicc int    
  ,CodigoOferta  int    
  ,NumeroGrupo  int    
  ,NumeroNivel  int    
  ,MarcaId int  
  ,MarcaDescripcion varchar(50)  
  ,IdMatrizComercial int  
  ,ImagenURL varchar(150)  
  ,Niveles varchar(200)  
  ,CodigoCatalogo varchar(6)  
  ,Categoria varchar(200)  
  ,GrupoArticulo varchar(200)  
  ,Linea varchar(200)  
  ,PrecioCatalogo  numeric(12,2)  
  ,PrecioValorizado  numeric(12,2)  
  ,FactorRepeticion int  
  ,CodigoTipoOferta varchar(6)  
 )   
 INSERT INTO #ProductoTemporal  
 SELECT   
 p.CampaniaID,  
 p.AnoCampania,  
 p.CUV,  
 REPLACE(COALESCE(mci.DescripcionComercial, pd.Descripcion,p.Descripcion),'"',char(39)) as DescripcionCUV,   
 p.CodigoProducto,  
 p.PrecioUnitario,  
 p.IndicadorPreUni,  
 0,  
 0,  
 0,  
 0,  
 p.IndicadorMontoMinimo,  
 p.IndicadorDigitable,     
 p.EstrategiaIdSicc,    
 p.CodigoOferta,    
 p.NumeroGrupo,    
 p.NumeroNivel,    
 p.MarcaID,   
 m.Descripcion,   
 mc.IdMatrizComercial,  
 mci.Foto AS ImagenURL,  
 '',  
 RTRIM(p.CodigoCatalago) AS CodigoCatalago,  
 fb.Nombre,  
 ga.DescripcionCorta,  
 sl.DescripcionLarga,  
 p.PrecioCatalogo,  
 p.PrecioValorizado,  
 p.FactorRepeticion,  
 RTRIM(p.CodigoTipoOferta) AS CodigoTipoOferta  
FROM ods.ProductoComercial p WITH (NOLOCK)   
 INNER JOIN dbo.Marca m WITH (NOLOCK) on m.MarcaId = p.MarcaID   
 LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON p.CodigoProducto = sp.CodigoSap  
 LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo  
 LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo  
 LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo  
 LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo  
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) on p.AnoCampania = pd.CampaniaID and p.CUV = pd.CUV   
 LEFT JOIN dbo.MatrizComercial mc WITH (NOLOCK) on p.CodigoProducto = mc.CodigoSAP   
 LEFT JOIN dbo.MatrizComercialImagen mci WITH (NOLOCK) on mci.IdMatrizComercial = mc.IdMatrizComercial AND mci.NemoTecnico IS NOT NULL   
 WHERE p.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)  
  
CREATE TABLE #ProductoComercial(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioUnitario  numeric(12,2)    
 ,FactorRepeticion int    
 ,IndicadorDigitable bit    
 ,AnoCampania  int    
 ,IndicadorPreUni numeric(12,2)    
 ,CodigoFactorCuadre numeric(12,2)    
 ,EstrategiaIdSicc int    
 ,CodigoOferta  int    
 ,NumeroGrupo  int    
 ,NumeroNivel  int    
)    
INSERT INTO #ProductoComercial    
SELECT    
 PC.CampaniaID    
 ,PC.CUV    
 ,PC.PrecioUnitario    
 ,PC.FactorRepeticion    
 ,PC.IndicadorDigitable    
 ,PC.AnoCampania    
 ,PC.IndicadorPreUni    
 ,PC.CodigoFactorCuadre    
 ,PC.EstrategiaIdSicc    
 ,PC.CodigoOferta    
 ,PC.NumeroGrupo    
 ,PC.NumeroNivel    
FROM ods.ProductoComercial PC WITH (NOLOCK)   
WHERE PC.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)   
  
CREATE TABLE #ProductoNivel(    
 CUV   varchar(5)    
 ,Campana INT  
 ,Nivel  int    
 ,Precio  numeric(12,2)    
)    
INSERT INTO #ProductoNivel    
SELECT    
 PC.CUV    
 ,PC.AnoCampania  
 ,Nivel = PN.FactorCuadre    
 ,Precio = PN.PrecioUnitario    
FROM #ProductoComercial PC     
 JOIN ods.ProductoNivel PN   ON PC.NumeroNivel = PN.NumeroNivel AND PN.FactorCuadre > 1  --and PC.AnoCampania = pn.campana  
GROUP BY    
 PC.CUV    
 ,PC.AnoCampania  
 ,PN.FactorCuadre    
 ,PN.PrecioUnitario  
   
CREATE TABLE #ProductoTemporal_2001(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioPublico   decimal(18,2)    
 ,Ganancia    decimal(18,2)    
)    
INSERT INTO #ProductoTemporal_2001    
SELECT    
 PC.CampaniaID, PC.CUV  
 ,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion    
 ,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion    
FROM #ProductoComercial PC    
 WHERE (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)  
 AND PC.FactorRepeticion >= 1    
   
CREATE TABLE #ProductoTemporal_2002(    
 CodigoOferta int  
 ,CampaniaId  int   
 ,PrecioPublico decimal(18,2)  
 ,Ganancia  decimal(18,2)  
)  
 INSERT INTO #ProductoTemporal_2002    
 SELECT  
  PC.CodigoOferta  
  ,PC.CampaniaId  
  ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)  
  ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)  
FROM  #ProductoComercial PC  
WHERE PC.EstrategiaIdSicc = 2002  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta    
   
 CREATE TABLE #ProductoTemporal_2003(    
 CodigoOferta int  
  ,CampaniaId  int   
  ,PrecioPublico decimal(18,2)  
  ,Ganancia  decimal(18,2)  
 )    
 INSERT INTO #ProductoTemporal_2003    
 SELECT  
 PC.CodigoOferta  
 ,PC.CampaniaId  
 ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
 ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
FROM (SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, MAX(IndicadorPreUni) AS IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre   
  FROM #ProductoComercial   
  WHERE EstrategiaIdSicc = 2003  
  GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario,  FactorRepeticion, CodigoFactorCuadre) PC  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta   
    
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2001   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CUV = PT.CUV   
 AND EstrategiaIdSicc = 2001  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2002   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2002  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2003  PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2003  
  
UPDATE PT    
SET PT.Ganancia = 0    
FROM #ProductoTemporal PT  
WHERE PT.Ganancia < 0    
    
UPDATE PT    
SET PT.PrecioOferta = PT.PrecioPublico    
FROM #ProductoTemporal PT   
WHERE PT.PrecioPublico > 0    
  
UPDATE PT    
SET PT.PrecioTachado = PT.PrecioPublico + PT.Ganancia    
FROM #ProductoTemporal PT   
WHERE PT.Ganancia > 0    
UPDATE PN    
SET Precio = PN.Nivel * PN.Precio    
FROM #ProductoNivel PN    
  
CREATE TABLE #ProductoNiveles(    
CUV   varchar(5)    
,Campana INT  
,Niveles varchar(200)    
)    
INSERT INTO #ProductoNiveles    
SELECT   
 PN.CUV,    
 PN.Campana,  
 Niveles = ( SELECT STUFF( (SELECT '|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)    
   FROM #ProductoNivel    
   WHERE CUV = PN.CUV  and CAMPANA = PN.CAMPANA  
   FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),    
   1,    
   1,    
   ''    
   )    
  )    
FROM #ProductoNivel PN    
GROUP BY PN.CUV  , PN.Campana  
UPDATE PT    
SET    
 PT.Niveles = PNS.Niveles    
FROM #ProductoTemporal PT    
 JOIN #ProductoNiveles PNS ON PT.CUV = PNS.CUV  and PT.CodigoCampania = PNS.Campana  
SELECT * FROM #ProductoTemporal  
DROP TABLE #ProductoComercial    
DROP TABLE #ProductoNivel    
DROP TABLE #ProductoNiveles   
    
DROP TABLE #ProductoTemporal_2001    
DROP TABLE #ProductoTemporal_2002    
DROP TABLE #ProductoTemporal_2003    
DROP TABLE #ProductoTemporal  
END  

GO

USE BelcorpPanama
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_ProductoComercial]   
AS  
BEGIN   
SET NOCOUNT ON;  
  
--------------------------------------  
declare @cteCampanias table  
(  
 CampaniaID int  
)  
  
insert into @cteCampanias  
select distinct TOP 8 CampaniaID   
FROM ods.ProductoComercial PM with(nolock)  
order by 1 desc  
--------------------------------------  
  
CREATE TABLE #ProductoTemporal (    
  CampaniaId   int    
  ,CodigoCampania int  
  ,CUV    varchar(50)    
  ,DescripcionCUV varchar(100)  
  ,CodigoProducto varchar(10)  
  ,PrecioUnitario  numeric(12,2)    
  ,IndicadorPreUni numeric(12,2)  
  ,PrecioPublico  numeric(12,2)   
  ,PrecioOferta  numeric(12,2)    
  ,PrecioTachado  numeric(12,2)     
  ,Ganancia  numeric(12,2)     
  ,IndicadorMontoMinimo int   
  ,IndicadorDigitable int   
  ,EstrategiaIdSicc int    
  ,CodigoOferta  int    
  ,NumeroGrupo  int    
  ,NumeroNivel  int    
  ,MarcaId int  
  ,MarcaDescripcion varchar(50)  
  ,IdMatrizComercial int  
  ,ImagenURL varchar(150)  
  ,Niveles varchar(200)  
  ,CodigoCatalogo varchar(6)  
  ,Categoria varchar(200)  
  ,GrupoArticulo varchar(200)  
  ,Linea varchar(200)  
  ,PrecioCatalogo  numeric(12,2)  
  ,PrecioValorizado  numeric(12,2)  
  ,FactorRepeticion int  
  ,CodigoTipoOferta varchar(6)  
 )   
 INSERT INTO #ProductoTemporal  
 SELECT   
 p.CampaniaID,  
 p.AnoCampania,  
 p.CUV,  
 REPLACE(COALESCE(mci.DescripcionComercial, pd.Descripcion,p.Descripcion),'"',char(39)) as DescripcionCUV,   
 p.CodigoProducto,  
 p.PrecioUnitario,  
 p.IndicadorPreUni,  
 0,  
 0,  
 0,  
 0,  
 p.IndicadorMontoMinimo,  
 p.IndicadorDigitable,     
 p.EstrategiaIdSicc,    
 p.CodigoOferta,    
 p.NumeroGrupo,    
 p.NumeroNivel,    
 p.MarcaID,   
 m.Descripcion,   
 mc.IdMatrizComercial,  
 mci.Foto AS ImagenURL,  
 '',  
 RTRIM(p.CodigoCatalago) AS CodigoCatalago,  
 fb.Nombre,  
 ga.DescripcionCorta,  
 sl.DescripcionLarga,  
 p.PrecioCatalogo,  
 p.PrecioValorizado,  
 p.FactorRepeticion,  
 RTRIM(p.CodigoTipoOferta) AS CodigoTipoOferta  
FROM ods.ProductoComercial p WITH (NOLOCK)   
 INNER JOIN dbo.Marca m WITH (NOLOCK) on m.MarcaId = p.MarcaID   
 LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON p.CodigoProducto = sp.CodigoSap  
 LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo  
 LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo  
 LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo  
 LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo  
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) on p.AnoCampania = pd.CampaniaID and p.CUV = pd.CUV   
 LEFT JOIN dbo.MatrizComercial mc WITH (NOLOCK) on p.CodigoProducto = mc.CodigoSAP   
 LEFT JOIN dbo.MatrizComercialImagen mci WITH (NOLOCK) on mci.IdMatrizComercial = mc.IdMatrizComercial AND mci.NemoTecnico IS NOT NULL   
 WHERE p.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)  
  
CREATE TABLE #ProductoComercial(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioUnitario  numeric(12,2)    
 ,FactorRepeticion int    
 ,IndicadorDigitable bit    
 ,AnoCampania  int    
 ,IndicadorPreUni numeric(12,2)    
 ,CodigoFactorCuadre numeric(12,2)    
 ,EstrategiaIdSicc int    
 ,CodigoOferta  int    
 ,NumeroGrupo  int    
 ,NumeroNivel  int    
)    
INSERT INTO #ProductoComercial    
SELECT    
 PC.CampaniaID    
 ,PC.CUV    
 ,PC.PrecioUnitario    
 ,PC.FactorRepeticion    
 ,PC.IndicadorDigitable    
 ,PC.AnoCampania    
 ,PC.IndicadorPreUni    
 ,PC.CodigoFactorCuadre    
 ,PC.EstrategiaIdSicc    
 ,PC.CodigoOferta    
 ,PC.NumeroGrupo    
 ,PC.NumeroNivel    
FROM ods.ProductoComercial PC WITH (NOLOCK)   
WHERE PC.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)   
  
CREATE TABLE #ProductoNivel(    
 CUV   varchar(5)    
 ,Campana INT  
 ,Nivel  int    
 ,Precio  numeric(12,2)    
)    
INSERT INTO #ProductoNivel    
SELECT    
 PC.CUV    
 ,PC.AnoCampania  
 ,Nivel = PN.FactorCuadre    
 ,Precio = PN.PrecioUnitario    
FROM #ProductoComercial PC     
 JOIN ods.ProductoNivel PN   ON PC.NumeroNivel = PN.NumeroNivel AND PN.FactorCuadre > 1  --and PC.AnoCampania = pn.campana  
GROUP BY    
 PC.CUV    
 ,PC.AnoCampania  
 ,PN.FactorCuadre    
 ,PN.PrecioUnitario  
   
CREATE TABLE #ProductoTemporal_2001(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioPublico   decimal(18,2)    
 ,Ganancia    decimal(18,2)    
)    
INSERT INTO #ProductoTemporal_2001    
SELECT    
 PC.CampaniaID, PC.CUV  
 ,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion    
 ,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion    
FROM #ProductoComercial PC    
 WHERE (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)  
 AND PC.FactorRepeticion >= 1    
   
CREATE TABLE #ProductoTemporal_2002(    
 CodigoOferta int  
 ,CampaniaId  int   
 ,PrecioPublico decimal(18,2)  
 ,Ganancia  decimal(18,2)  
)  
 INSERT INTO #ProductoTemporal_2002    
 SELECT  
  PC.CodigoOferta  
  ,PC.CampaniaId  
  ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)  
  ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)  
FROM  #ProductoComercial PC  
WHERE PC.EstrategiaIdSicc = 2002  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta    
   
 CREATE TABLE #ProductoTemporal_2003(    
 CodigoOferta int  
  ,CampaniaId  int   
  ,PrecioPublico decimal(18,2)  
  ,Ganancia  decimal(18,2)  
 )    
 INSERT INTO #ProductoTemporal_2003    
 SELECT  
 PC.CodigoOferta  
 ,PC.CampaniaId  
 ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
 ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
FROM (SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, MAX(IndicadorPreUni) AS IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre   
  FROM #ProductoComercial   
  WHERE EstrategiaIdSicc = 2003  
  GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario,  FactorRepeticion, CodigoFactorCuadre) PC  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta   
    
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2001   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CUV = PT.CUV   
 AND EstrategiaIdSicc = 2001  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2002   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2002  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2003  PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2003  
  
UPDATE PT    
SET PT.Ganancia = 0    
FROM #ProductoTemporal PT  
WHERE PT.Ganancia < 0    
    
UPDATE PT    
SET PT.PrecioOferta = PT.PrecioPublico    
FROM #ProductoTemporal PT   
WHERE PT.PrecioPublico > 0    
  
UPDATE PT    
SET PT.PrecioTachado = PT.PrecioPublico + PT.Ganancia    
FROM #ProductoTemporal PT   
WHERE PT.Ganancia > 0    
UPDATE PN    
SET Precio = PN.Nivel * PN.Precio    
FROM #ProductoNivel PN    
  
CREATE TABLE #ProductoNiveles(    
CUV   varchar(5)    
,Campana INT  
,Niveles varchar(200)    
)    
INSERT INTO #ProductoNiveles    
SELECT   
 PN.CUV,    
 PN.Campana,  
 Niveles = ( SELECT STUFF( (SELECT '|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)    
   FROM #ProductoNivel    
   WHERE CUV = PN.CUV  and CAMPANA = PN.CAMPANA  
   FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),    
   1,    
   1,    
   ''    
   )    
  )    
FROM #ProductoNivel PN    
GROUP BY PN.CUV  , PN.Campana  
UPDATE PT    
SET    
 PT.Niveles = PNS.Niveles    
FROM #ProductoTemporal PT    
 JOIN #ProductoNiveles PNS ON PT.CUV = PNS.CUV  and PT.CodigoCampania = PNS.Campana  
SELECT * FROM #ProductoTemporal  
DROP TABLE #ProductoComercial    
DROP TABLE #ProductoNivel    
DROP TABLE #ProductoNiveles   
    
DROP TABLE #ProductoTemporal_2001    
DROP TABLE #ProductoTemporal_2002    
DROP TABLE #ProductoTemporal_2003    
DROP TABLE #ProductoTemporal  
END  

GO

USE BelcorpGuatemala
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_ProductoComercial]   
AS  
BEGIN   
SET NOCOUNT ON;  
  
--------------------------------------  
declare @cteCampanias table  
(  
 CampaniaID int  
)  
  
insert into @cteCampanias  
select distinct TOP 8 CampaniaID   
FROM ods.ProductoComercial PM with(nolock)  
order by 1 desc  
--------------------------------------  
  
CREATE TABLE #ProductoTemporal (    
  CampaniaId   int    
  ,CodigoCampania int  
  ,CUV    varchar(50)    
  ,DescripcionCUV varchar(100)  
  ,CodigoProducto varchar(10)  
  ,PrecioUnitario  numeric(12,2)    
  ,IndicadorPreUni numeric(12,2)  
  ,PrecioPublico  numeric(12,2)   
  ,PrecioOferta  numeric(12,2)    
  ,PrecioTachado  numeric(12,2)     
  ,Ganancia  numeric(12,2)     
  ,IndicadorMontoMinimo int   
  ,IndicadorDigitable int   
  ,EstrategiaIdSicc int    
  ,CodigoOferta  int    
  ,NumeroGrupo  int    
  ,NumeroNivel  int    
  ,MarcaId int  
  ,MarcaDescripcion varchar(50)  
  ,IdMatrizComercial int  
  ,ImagenURL varchar(150)  
  ,Niveles varchar(200)  
  ,CodigoCatalogo varchar(6)  
  ,Categoria varchar(200)  
  ,GrupoArticulo varchar(200)  
  ,Linea varchar(200)  
  ,PrecioCatalogo  numeric(12,2)  
  ,PrecioValorizado  numeric(12,2)  
  ,FactorRepeticion int  
  ,CodigoTipoOferta varchar(6)  
 )   
 INSERT INTO #ProductoTemporal  
 SELECT   
 p.CampaniaID,  
 p.AnoCampania,  
 p.CUV,  
 REPLACE(COALESCE(mci.DescripcionComercial, pd.Descripcion,p.Descripcion),'"',char(39)) as DescripcionCUV,   
 p.CodigoProducto,  
 p.PrecioUnitario,  
 p.IndicadorPreUni,  
 0,  
 0,  
 0,  
 0,  
 p.IndicadorMontoMinimo,  
 p.IndicadorDigitable,     
 p.EstrategiaIdSicc,    
 p.CodigoOferta,    
 p.NumeroGrupo,    
 p.NumeroNivel,    
 p.MarcaID,   
 m.Descripcion,   
 mc.IdMatrizComercial,  
 mci.Foto AS ImagenURL,  
 '',  
 RTRIM(p.CodigoCatalago) AS CodigoCatalago,  
 fb.Nombre,  
 ga.DescripcionCorta,  
 sl.DescripcionLarga,  
 p.PrecioCatalogo,  
 p.PrecioValorizado,  
 p.FactorRepeticion,  
 RTRIM(p.CodigoTipoOferta) AS CodigoTipoOferta  
FROM ods.ProductoComercial p WITH (NOLOCK)   
 INNER JOIN dbo.Marca m WITH (NOLOCK) on m.MarcaId = p.MarcaID   
 LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON p.CodigoProducto = sp.CodigoSap  
 LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo  
 LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo  
 LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo  
 LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo  
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) on p.AnoCampania = pd.CampaniaID and p.CUV = pd.CUV   
 LEFT JOIN dbo.MatrizComercial mc WITH (NOLOCK) on p.CodigoProducto = mc.CodigoSAP   
 LEFT JOIN dbo.MatrizComercialImagen mci WITH (NOLOCK) on mci.IdMatrizComercial = mc.IdMatrizComercial AND mci.NemoTecnico IS NOT NULL   
 WHERE p.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)  
  
CREATE TABLE #ProductoComercial(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioUnitario  numeric(12,2)    
 ,FactorRepeticion int    
 ,IndicadorDigitable bit    
 ,AnoCampania  int    
 ,IndicadorPreUni numeric(12,2)    
 ,CodigoFactorCuadre numeric(12,2)    
 ,EstrategiaIdSicc int    
 ,CodigoOferta  int    
 ,NumeroGrupo  int    
 ,NumeroNivel  int    
)    
INSERT INTO #ProductoComercial    
SELECT    
 PC.CampaniaID    
 ,PC.CUV    
 ,PC.PrecioUnitario    
 ,PC.FactorRepeticion    
 ,PC.IndicadorDigitable    
 ,PC.AnoCampania    
 ,PC.IndicadorPreUni    
 ,PC.CodigoFactorCuadre    
 ,PC.EstrategiaIdSicc    
 ,PC.CodigoOferta    
 ,PC.NumeroGrupo    
 ,PC.NumeroNivel    
FROM ods.ProductoComercial PC WITH (NOLOCK)   
WHERE PC.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)   
  
CREATE TABLE #ProductoNivel(    
 CUV   varchar(5)    
 ,Campana INT  
 ,Nivel  int    
 ,Precio  numeric(12,2)    
)    
INSERT INTO #ProductoNivel    
SELECT    
 PC.CUV    
 ,PC.AnoCampania  
 ,Nivel = PN.FactorCuadre    
 ,Precio = PN.PrecioUnitario    
FROM #ProductoComercial PC     
 JOIN ods.ProductoNivel PN   ON PC.NumeroNivel = PN.NumeroNivel AND PN.FactorCuadre > 1  --and PC.AnoCampania = pn.campana  
GROUP BY    
 PC.CUV    
 ,PC.AnoCampania  
 ,PN.FactorCuadre    
 ,PN.PrecioUnitario  
   
CREATE TABLE #ProductoTemporal_2001(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioPublico   decimal(18,2)    
 ,Ganancia    decimal(18,2)    
)    
INSERT INTO #ProductoTemporal_2001    
SELECT    
 PC.CampaniaID, PC.CUV  
 ,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion    
 ,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion    
FROM #ProductoComercial PC    
 WHERE (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)  
 AND PC.FactorRepeticion >= 1    
   
CREATE TABLE #ProductoTemporal_2002(    
 CodigoOferta int  
 ,CampaniaId  int   
 ,PrecioPublico decimal(18,2)  
 ,Ganancia  decimal(18,2)  
)  
 INSERT INTO #ProductoTemporal_2002    
 SELECT  
  PC.CodigoOferta  
  ,PC.CampaniaId  
  ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)  
  ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)  
FROM  #ProductoComercial PC  
WHERE PC.EstrategiaIdSicc = 2002  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta    
   
 CREATE TABLE #ProductoTemporal_2003(    
 CodigoOferta int  
  ,CampaniaId  int   
  ,PrecioPublico decimal(18,2)  
  ,Ganancia  decimal(18,2)  
 )    
 INSERT INTO #ProductoTemporal_2003    
 SELECT  
 PC.CodigoOferta  
 ,PC.CampaniaId  
 ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
 ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
FROM (SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, MAX(IndicadorPreUni) AS IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre   
  FROM #ProductoComercial   
  WHERE EstrategiaIdSicc = 2003  
  GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario,  FactorRepeticion, CodigoFactorCuadre) PC  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta   
    
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2001   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CUV = PT.CUV   
 AND EstrategiaIdSicc = 2001  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2002   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2002  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2003  PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2003  
  
UPDATE PT    
SET PT.Ganancia = 0    
FROM #ProductoTemporal PT  
WHERE PT.Ganancia < 0    
    
UPDATE PT    
SET PT.PrecioOferta = PT.PrecioPublico    
FROM #ProductoTemporal PT   
WHERE PT.PrecioPublico > 0    
  
UPDATE PT    
SET PT.PrecioTachado = PT.PrecioPublico + PT.Ganancia    
FROM #ProductoTemporal PT   
WHERE PT.Ganancia > 0    
UPDATE PN    
SET Precio = PN.Nivel * PN.Precio    
FROM #ProductoNivel PN    
  
CREATE TABLE #ProductoNiveles(    
CUV   varchar(5)    
,Campana INT  
,Niveles varchar(200)    
)    
INSERT INTO #ProductoNiveles    
SELECT   
 PN.CUV,    
 PN.Campana,  
 Niveles = ( SELECT STUFF( (SELECT '|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)    
   FROM #ProductoNivel    
   WHERE CUV = PN.CUV  and CAMPANA = PN.CAMPANA  
   FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),    
   1,    
   1,    
   ''    
   )    
  )    
FROM #ProductoNivel PN    
GROUP BY PN.CUV  , PN.Campana  
UPDATE PT    
SET    
 PT.Niveles = PNS.Niveles    
FROM #ProductoTemporal PT    
 JOIN #ProductoNiveles PNS ON PT.CUV = PNS.CUV  and PT.CodigoCampania = PNS.Campana  
SELECT * FROM #ProductoTemporal  
DROP TABLE #ProductoComercial    
DROP TABLE #ProductoNivel    
DROP TABLE #ProductoNiveles   
    
DROP TABLE #ProductoTemporal_2001    
DROP TABLE #ProductoTemporal_2002    
DROP TABLE #ProductoTemporal_2003    
DROP TABLE #ProductoTemporal  
END  

GO

USE BelcorpEcuador
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_ProductoComercial]   
AS  
BEGIN   
SET NOCOUNT ON;  
  
--------------------------------------  
declare @cteCampanias table  
(  
 CampaniaID int  
)  
  
insert into @cteCampanias  
select distinct TOP 8 CampaniaID   
FROM ods.ProductoComercial PM with(nolock)  
order by 1 desc  
--------------------------------------  
  
CREATE TABLE #ProductoTemporal (    
  CampaniaId   int    
  ,CodigoCampania int  
  ,CUV    varchar(50)    
  ,DescripcionCUV varchar(100)  
  ,CodigoProducto varchar(10)  
  ,PrecioUnitario  numeric(12,2)    
  ,IndicadorPreUni numeric(12,2)  
  ,PrecioPublico  numeric(12,2)   
  ,PrecioOferta  numeric(12,2)    
  ,PrecioTachado  numeric(12,2)     
  ,Ganancia  numeric(12,2)     
  ,IndicadorMontoMinimo int   
  ,IndicadorDigitable int   
  ,EstrategiaIdSicc int    
  ,CodigoOferta  int    
  ,NumeroGrupo  int    
  ,NumeroNivel  int    
  ,MarcaId int  
  ,MarcaDescripcion varchar(50)  
  ,IdMatrizComercial int  
  ,ImagenURL varchar(150)  
  ,Niveles varchar(200)  
  ,CodigoCatalogo varchar(6)  
  ,Categoria varchar(200)  
  ,GrupoArticulo varchar(200)  
  ,Linea varchar(200)  
  ,PrecioCatalogo  numeric(12,2)  
  ,PrecioValorizado  numeric(12,2)  
  ,FactorRepeticion int  
  ,CodigoTipoOferta varchar(6)  
 )   
 INSERT INTO #ProductoTemporal  
 SELECT   
 p.CampaniaID,  
 p.AnoCampania,  
 p.CUV,  
 REPLACE(COALESCE(mci.DescripcionComercial, pd.Descripcion,p.Descripcion),'"',char(39)) as DescripcionCUV,   
 p.CodigoProducto,  
 p.PrecioUnitario,  
 p.IndicadorPreUni,  
 0,  
 0,  
 0,  
 0,  
 p.IndicadorMontoMinimo,  
 p.IndicadorDigitable,     
 p.EstrategiaIdSicc,    
 p.CodigoOferta,    
 p.NumeroGrupo,    
 p.NumeroNivel,    
 p.MarcaID,   
 m.Descripcion,   
 mc.IdMatrizComercial,  
 mci.Foto AS ImagenURL,  
 '',  
 RTRIM(p.CodigoCatalago) AS CodigoCatalago,  
 fb.Nombre,  
 ga.DescripcionCorta,  
 sl.DescripcionLarga,  
 p.PrecioCatalogo,  
 p.PrecioValorizado,  
 p.FactorRepeticion,  
 RTRIM(p.CodigoTipoOferta) AS CodigoTipoOferta  
FROM ods.ProductoComercial p WITH (NOLOCK)   
 INNER JOIN dbo.Marca m WITH (NOLOCK) on m.MarcaId = p.MarcaID   
 LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON p.CodigoProducto = sp.CodigoSap  
 LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo  
 LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo  
 LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo  
 LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo  
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) on p.AnoCampania = pd.CampaniaID and p.CUV = pd.CUV   
 LEFT JOIN dbo.MatrizComercial mc WITH (NOLOCK) on p.CodigoProducto = mc.CodigoSAP   
 LEFT JOIN dbo.MatrizComercialImagen mci WITH (NOLOCK) on mci.IdMatrizComercial = mc.IdMatrizComercial AND mci.NemoTecnico IS NOT NULL   
 WHERE p.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)  
  
CREATE TABLE #ProductoComercial(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioUnitario  numeric(12,2)    
 ,FactorRepeticion int    
 ,IndicadorDigitable bit    
 ,AnoCampania  int    
 ,IndicadorPreUni numeric(12,2)    
 ,CodigoFactorCuadre numeric(12,2)    
 ,EstrategiaIdSicc int    
 ,CodigoOferta  int    
 ,NumeroGrupo  int    
 ,NumeroNivel  int    
)    
INSERT INTO #ProductoComercial    
SELECT    
 PC.CampaniaID    
 ,PC.CUV    
 ,PC.PrecioUnitario    
 ,PC.FactorRepeticion    
 ,PC.IndicadorDigitable    
 ,PC.AnoCampania    
 ,PC.IndicadorPreUni    
 ,PC.CodigoFactorCuadre    
 ,PC.EstrategiaIdSicc    
 ,PC.CodigoOferta    
 ,PC.NumeroGrupo    
 ,PC.NumeroNivel    
FROM ods.ProductoComercial PC WITH (NOLOCK)   
WHERE PC.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)   
  
CREATE TABLE #ProductoNivel(    
 CUV   varchar(5)    
 ,Campana INT  
 ,Nivel  int    
 ,Precio  numeric(12,2)    
)    
INSERT INTO #ProductoNivel    
SELECT    
 PC.CUV    
 ,PC.AnoCampania  
 ,Nivel = PN.FactorCuadre    
 ,Precio = PN.PrecioUnitario    
FROM #ProductoComercial PC     
 JOIN ods.ProductoNivel PN   ON PC.NumeroNivel = PN.NumeroNivel AND PN.FactorCuadre > 1  --and PC.AnoCampania = pn.campana  
GROUP BY    
 PC.CUV    
 ,PC.AnoCampania  
 ,PN.FactorCuadre    
 ,PN.PrecioUnitario  
   
CREATE TABLE #ProductoTemporal_2001(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioPublico   decimal(18,2)    
 ,Ganancia    decimal(18,2)    
)    
INSERT INTO #ProductoTemporal_2001    
SELECT    
 PC.CampaniaID, PC.CUV  
 ,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion    
 ,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion    
FROM #ProductoComercial PC    
 WHERE (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)  
 AND PC.FactorRepeticion >= 1    
   
CREATE TABLE #ProductoTemporal_2002(    
 CodigoOferta int  
 ,CampaniaId  int   
 ,PrecioPublico decimal(18,2)  
 ,Ganancia  decimal(18,2)  
)  
 INSERT INTO #ProductoTemporal_2002    
 SELECT  
  PC.CodigoOferta  
  ,PC.CampaniaId  
  ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)  
  ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)  
FROM  #ProductoComercial PC  
WHERE PC.EstrategiaIdSicc = 2002  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta    
   
 CREATE TABLE #ProductoTemporal_2003(    
 CodigoOferta int  
  ,CampaniaId  int   
  ,PrecioPublico decimal(18,2)  
  ,Ganancia  decimal(18,2)  
 )    
 INSERT INTO #ProductoTemporal_2003    
 SELECT  
 PC.CodigoOferta  
 ,PC.CampaniaId  
 ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
 ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
FROM (SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, MAX(IndicadorPreUni) AS IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre   
  FROM #ProductoComercial   
  WHERE EstrategiaIdSicc = 2003  
  GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario,  FactorRepeticion, CodigoFactorCuadre) PC  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta   
    
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2001   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CUV = PT.CUV   
 AND EstrategiaIdSicc = 2001  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2002   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2002  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2003  PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2003  
  
UPDATE PT    
SET PT.Ganancia = 0    
FROM #ProductoTemporal PT  
WHERE PT.Ganancia < 0    
    
UPDATE PT    
SET PT.PrecioOferta = PT.PrecioPublico    
FROM #ProductoTemporal PT   
WHERE PT.PrecioPublico > 0    
  
UPDATE PT    
SET PT.PrecioTachado = PT.PrecioPublico + PT.Ganancia    
FROM #ProductoTemporal PT   
WHERE PT.Ganancia > 0    
UPDATE PN    
SET Precio = PN.Nivel * PN.Precio    
FROM #ProductoNivel PN    
  
CREATE TABLE #ProductoNiveles(    
CUV   varchar(5)    
,Campana INT  
,Niveles varchar(200)    
)    
INSERT INTO #ProductoNiveles    
SELECT   
 PN.CUV,    
 PN.Campana,  
 Niveles = ( SELECT STUFF( (SELECT '|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)    
   FROM #ProductoNivel    
   WHERE CUV = PN.CUV  and CAMPANA = PN.CAMPANA  
   FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),    
   1,    
   1,    
   ''    
   )    
  )    
FROM #ProductoNivel PN    
GROUP BY PN.CUV  , PN.Campana  
UPDATE PT    
SET    
 PT.Niveles = PNS.Niveles    
FROM #ProductoTemporal PT    
 JOIN #ProductoNiveles PNS ON PT.CUV = PNS.CUV  and PT.CodigoCampania = PNS.Campana  
SELECT * FROM #ProductoTemporal  
DROP TABLE #ProductoComercial    
DROP TABLE #ProductoNivel    
DROP TABLE #ProductoNiveles   
    
DROP TABLE #ProductoTemporal_2001    
DROP TABLE #ProductoTemporal_2002    
DROP TABLE #ProductoTemporal_2003    
DROP TABLE #ProductoTemporal  
END  

GO

USE BelcorpDominicana
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_ProductoComercial]   
AS  
BEGIN   
SET NOCOUNT ON;  
  
--------------------------------------  
declare @cteCampanias table  
(  
 CampaniaID int  
)  
  
insert into @cteCampanias  
select distinct TOP 8 CampaniaID   
FROM ods.ProductoComercial PM with(nolock)  
order by 1 desc  
--------------------------------------  
  
CREATE TABLE #ProductoTemporal (    
  CampaniaId   int    
  ,CodigoCampania int  
  ,CUV    varchar(50)    
  ,DescripcionCUV varchar(100)  
  ,CodigoProducto varchar(10)  
  ,PrecioUnitario  numeric(12,2)    
  ,IndicadorPreUni numeric(12,2)  
  ,PrecioPublico  numeric(12,2)   
  ,PrecioOferta  numeric(12,2)    
  ,PrecioTachado  numeric(12,2)     
  ,Ganancia  numeric(12,2)     
  ,IndicadorMontoMinimo int   
  ,IndicadorDigitable int   
  ,EstrategiaIdSicc int    
  ,CodigoOferta  int    
  ,NumeroGrupo  int    
  ,NumeroNivel  int    
  ,MarcaId int  
  ,MarcaDescripcion varchar(50)  
  ,IdMatrizComercial int  
  ,ImagenURL varchar(150)  
  ,Niveles varchar(200)  
  ,CodigoCatalogo varchar(6)  
  ,Categoria varchar(200)  
  ,GrupoArticulo varchar(200)  
  ,Linea varchar(200)  
  ,PrecioCatalogo  numeric(12,2)  
  ,PrecioValorizado  numeric(12,2)  
  ,FactorRepeticion int  
  ,CodigoTipoOferta varchar(6)  
 )   
 INSERT INTO #ProductoTemporal  
 SELECT   
 p.CampaniaID,  
 p.AnoCampania,  
 p.CUV,  
 REPLACE(COALESCE(mci.DescripcionComercial, pd.Descripcion,p.Descripcion),'"',char(39)) as DescripcionCUV,   
 p.CodigoProducto,  
 p.PrecioUnitario,  
 p.IndicadorPreUni,  
 0,  
 0,  
 0,  
 0,  
 p.IndicadorMontoMinimo,  
 p.IndicadorDigitable,     
 p.EstrategiaIdSicc,    
 p.CodigoOferta,    
 p.NumeroGrupo,    
 p.NumeroNivel,    
 p.MarcaID,   
 m.Descripcion,   
 mc.IdMatrizComercial,  
 mci.Foto AS ImagenURL,  
 '',  
 RTRIM(p.CodigoCatalago) AS CodigoCatalago,  
 fb.Nombre,  
 ga.DescripcionCorta,  
 sl.DescripcionLarga,  
 p.PrecioCatalogo,  
 p.PrecioValorizado,  
 p.FactorRepeticion,  
 RTRIM(p.CodigoTipoOferta) AS CodigoTipoOferta  
FROM ods.ProductoComercial p WITH (NOLOCK)   
 INNER JOIN dbo.Marca m WITH (NOLOCK) on m.MarcaId = p.MarcaID   
 LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON p.CodigoProducto = sp.CodigoSap  
 LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo  
 LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo  
 LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo  
 LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo  
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) on p.AnoCampania = pd.CampaniaID and p.CUV = pd.CUV   
 LEFT JOIN dbo.MatrizComercial mc WITH (NOLOCK) on p.CodigoProducto = mc.CodigoSAP   
 LEFT JOIN dbo.MatrizComercialImagen mci WITH (NOLOCK) on mci.IdMatrizComercial = mc.IdMatrizComercial AND mci.NemoTecnico IS NOT NULL   
 WHERE p.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)  
  
CREATE TABLE #ProductoComercial(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioUnitario  numeric(12,2)    
 ,FactorRepeticion int    
 ,IndicadorDigitable bit    
 ,AnoCampania  int    
 ,IndicadorPreUni numeric(12,2)    
 ,CodigoFactorCuadre numeric(12,2)    
 ,EstrategiaIdSicc int    
 ,CodigoOferta  int    
 ,NumeroGrupo  int    
 ,NumeroNivel  int    
)    
INSERT INTO #ProductoComercial    
SELECT    
 PC.CampaniaID    
 ,PC.CUV    
 ,PC.PrecioUnitario    
 ,PC.FactorRepeticion    
 ,PC.IndicadorDigitable    
 ,PC.AnoCampania    
 ,PC.IndicadorPreUni    
 ,PC.CodigoFactorCuadre    
 ,PC.EstrategiaIdSicc    
 ,PC.CodigoOferta    
 ,PC.NumeroGrupo    
 ,PC.NumeroNivel    
FROM ods.ProductoComercial PC WITH (NOLOCK)   
WHERE PC.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)   
  
CREATE TABLE #ProductoNivel(    
 CUV   varchar(5)    
 ,Campana INT  
 ,Nivel  int    
 ,Precio  numeric(12,2)    
)    
INSERT INTO #ProductoNivel    
SELECT    
 PC.CUV    
 ,PC.AnoCampania  
 ,Nivel = PN.FactorCuadre    
 ,Precio = PN.PrecioUnitario    
FROM #ProductoComercial PC     
 JOIN ods.ProductoNivel PN   ON PC.NumeroNivel = PN.NumeroNivel AND PN.FactorCuadre > 1  --and PC.AnoCampania = pn.campana  
GROUP BY    
 PC.CUV    
 ,PC.AnoCampania  
 ,PN.FactorCuadre    
 ,PN.PrecioUnitario  
   
CREATE TABLE #ProductoTemporal_2001(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioPublico   decimal(18,2)    
 ,Ganancia    decimal(18,2)    
)    
INSERT INTO #ProductoTemporal_2001    
SELECT    
 PC.CampaniaID, PC.CUV  
 ,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion    
 ,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion    
FROM #ProductoComercial PC    
 WHERE (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)  
 AND PC.FactorRepeticion >= 1    
   
CREATE TABLE #ProductoTemporal_2002(    
 CodigoOferta int  
 ,CampaniaId  int   
 ,PrecioPublico decimal(18,2)  
 ,Ganancia  decimal(18,2)  
)  
 INSERT INTO #ProductoTemporal_2002    
 SELECT  
  PC.CodigoOferta  
  ,PC.CampaniaId  
  ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)  
  ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)  
FROM  #ProductoComercial PC  
WHERE PC.EstrategiaIdSicc = 2002  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta    
   
 CREATE TABLE #ProductoTemporal_2003(    
 CodigoOferta int  
  ,CampaniaId  int   
  ,PrecioPublico decimal(18,2)  
  ,Ganancia  decimal(18,2)  
 )    
 INSERT INTO #ProductoTemporal_2003    
 SELECT  
 PC.CodigoOferta  
 ,PC.CampaniaId  
 ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
 ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
FROM (SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, MAX(IndicadorPreUni) AS IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre   
  FROM #ProductoComercial   
  WHERE EstrategiaIdSicc = 2003  
  GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario,  FactorRepeticion, CodigoFactorCuadre) PC  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta   
    
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2001   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CUV = PT.CUV   
 AND EstrategiaIdSicc = 2001  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2002   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2002  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2003  PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2003  
  
UPDATE PT    
SET PT.Ganancia = 0    
FROM #ProductoTemporal PT  
WHERE PT.Ganancia < 0    
    
UPDATE PT    
SET PT.PrecioOferta = PT.PrecioPublico    
FROM #ProductoTemporal PT   
WHERE PT.PrecioPublico > 0    
  
UPDATE PT    
SET PT.PrecioTachado = PT.PrecioPublico + PT.Ganancia    
FROM #ProductoTemporal PT   
WHERE PT.Ganancia > 0    
UPDATE PN    
SET Precio = PN.Nivel * PN.Precio    
FROM #ProductoNivel PN    
  
CREATE TABLE #ProductoNiveles(    
CUV   varchar(5)    
,Campana INT  
,Niveles varchar(200)    
)    
INSERT INTO #ProductoNiveles    
SELECT   
 PN.CUV,    
 PN.Campana,  
 Niveles = ( SELECT STUFF( (SELECT '|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)    
   FROM #ProductoNivel    
   WHERE CUV = PN.CUV  and CAMPANA = PN.CAMPANA  
   FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),    
   1,    
   1,    
   ''    
   )    
  )    
FROM #ProductoNivel PN    
GROUP BY PN.CUV  , PN.Campana  
UPDATE PT    
SET    
 PT.Niveles = PNS.Niveles    
FROM #ProductoTemporal PT    
 JOIN #ProductoNiveles PNS ON PT.CUV = PNS.CUV  and PT.CodigoCampania = PNS.Campana  
SELECT * FROM #ProductoTemporal  
DROP TABLE #ProductoComercial    
DROP TABLE #ProductoNivel    
DROP TABLE #ProductoNiveles   
    
DROP TABLE #ProductoTemporal_2001    
DROP TABLE #ProductoTemporal_2002    
DROP TABLE #ProductoTemporal_2003    
DROP TABLE #ProductoTemporal  
END  

GO

USE BelcorpCostaRica
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_ProductoComercial]   
AS  
BEGIN   
SET NOCOUNT ON;  
  
--------------------------------------  
declare @cteCampanias table  
(  
 CampaniaID int  
)  
  
insert into @cteCampanias  
select distinct TOP 8 CampaniaID   
FROM ods.ProductoComercial PM with(nolock)  
order by 1 desc  
--------------------------------------  
  
CREATE TABLE #ProductoTemporal (    
  CampaniaId   int    
  ,CodigoCampania int  
  ,CUV    varchar(50)    
  ,DescripcionCUV varchar(100)  
  ,CodigoProducto varchar(10)  
  ,PrecioUnitario  numeric(12,2)    
  ,IndicadorPreUni numeric(12,2)  
  ,PrecioPublico  numeric(12,2)   
  ,PrecioOferta  numeric(12,2)    
  ,PrecioTachado  numeric(12,2)     
  ,Ganancia  numeric(12,2)     
  ,IndicadorMontoMinimo int   
  ,IndicadorDigitable int   
  ,EstrategiaIdSicc int    
  ,CodigoOferta  int    
  ,NumeroGrupo  int    
  ,NumeroNivel  int    
  ,MarcaId int  
  ,MarcaDescripcion varchar(50)  
  ,IdMatrizComercial int  
  ,ImagenURL varchar(150)  
  ,Niveles varchar(200)  
  ,CodigoCatalogo varchar(6)  
  ,Categoria varchar(200)  
  ,GrupoArticulo varchar(200)  
  ,Linea varchar(200)  
  ,PrecioCatalogo  numeric(12,2)  
  ,PrecioValorizado  numeric(12,2)  
  ,FactorRepeticion int  
  ,CodigoTipoOferta varchar(6)  
 )   
 INSERT INTO #ProductoTemporal  
 SELECT   
 p.CampaniaID,  
 p.AnoCampania,  
 p.CUV,  
 REPLACE(COALESCE(mci.DescripcionComercial, pd.Descripcion,p.Descripcion),'"',char(39)) as DescripcionCUV,   
 p.CodigoProducto,  
 p.PrecioUnitario,  
 p.IndicadorPreUni,  
 0,  
 0,  
 0,  
 0,  
 p.IndicadorMontoMinimo,  
 p.IndicadorDigitable,     
 p.EstrategiaIdSicc,    
 p.CodigoOferta,    
 p.NumeroGrupo,    
 p.NumeroNivel,    
 p.MarcaID,   
 m.Descripcion,   
 mc.IdMatrizComercial,  
 mci.Foto AS ImagenURL,  
 '',  
 RTRIM(p.CodigoCatalago) AS CodigoCatalago,  
 fb.Nombre,  
 ga.DescripcionCorta,  
 sl.DescripcionLarga,  
 p.PrecioCatalogo,  
 p.PrecioValorizado,  
 p.FactorRepeticion,  
 RTRIM(p.CodigoTipoOferta) AS CodigoTipoOferta  
FROM ods.ProductoComercial p WITH (NOLOCK)   
 INNER JOIN dbo.Marca m WITH (NOLOCK) on m.MarcaId = p.MarcaID   
 LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON p.CodigoProducto = sp.CodigoSap  
 LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo  
 LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo  
 LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo  
 LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo  
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) on p.AnoCampania = pd.CampaniaID and p.CUV = pd.CUV   
 LEFT JOIN dbo.MatrizComercial mc WITH (NOLOCK) on p.CodigoProducto = mc.CodigoSAP   
 LEFT JOIN dbo.MatrizComercialImagen mci WITH (NOLOCK) on mci.IdMatrizComercial = mc.IdMatrizComercial AND mci.NemoTecnico IS NOT NULL   
 WHERE p.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)  
  
CREATE TABLE #ProductoComercial(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioUnitario  numeric(12,2)    
 ,FactorRepeticion int    
 ,IndicadorDigitable bit    
 ,AnoCampania  int    
 ,IndicadorPreUni numeric(12,2)    
 ,CodigoFactorCuadre numeric(12,2)    
 ,EstrategiaIdSicc int    
 ,CodigoOferta  int    
 ,NumeroGrupo  int    
 ,NumeroNivel  int    
)    
INSERT INTO #ProductoComercial    
SELECT    
 PC.CampaniaID    
 ,PC.CUV    
 ,PC.PrecioUnitario    
 ,PC.FactorRepeticion    
 ,PC.IndicadorDigitable    
 ,PC.AnoCampania    
 ,PC.IndicadorPreUni    
 ,PC.CodigoFactorCuadre    
 ,PC.EstrategiaIdSicc    
 ,PC.CodigoOferta    
 ,PC.NumeroGrupo    
 ,PC.NumeroNivel    
FROM ods.ProductoComercial PC WITH (NOLOCK)   
WHERE PC.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)   
  
CREATE TABLE #ProductoNivel(    
 CUV   varchar(5)    
 ,Campana INT  
 ,Nivel  int    
 ,Precio  numeric(12,2)    
)    
INSERT INTO #ProductoNivel    
SELECT    
 PC.CUV    
 ,PC.AnoCampania  
 ,Nivel = PN.FactorCuadre    
 ,Precio = PN.PrecioUnitario    
FROM #ProductoComercial PC     
 JOIN ods.ProductoNivel PN   ON PC.NumeroNivel = PN.NumeroNivel AND PN.FactorCuadre > 1  --and PC.AnoCampania = pn.campana  
GROUP BY    
 PC.CUV    
 ,PC.AnoCampania  
 ,PN.FactorCuadre    
 ,PN.PrecioUnitario  
   
CREATE TABLE #ProductoTemporal_2001(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioPublico   decimal(18,2)    
 ,Ganancia    decimal(18,2)    
)    
INSERT INTO #ProductoTemporal_2001    
SELECT    
 PC.CampaniaID, PC.CUV  
 ,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion    
 ,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion    
FROM #ProductoComercial PC    
 WHERE (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)  
 AND PC.FactorRepeticion >= 1    
   
CREATE TABLE #ProductoTemporal_2002(    
 CodigoOferta int  
 ,CampaniaId  int   
 ,PrecioPublico decimal(18,2)  
 ,Ganancia  decimal(18,2)  
)  
 INSERT INTO #ProductoTemporal_2002    
 SELECT  
  PC.CodigoOferta  
  ,PC.CampaniaId  
  ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)  
  ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)  
FROM  #ProductoComercial PC  
WHERE PC.EstrategiaIdSicc = 2002  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta    
   
 CREATE TABLE #ProductoTemporal_2003(    
 CodigoOferta int  
  ,CampaniaId  int   
  ,PrecioPublico decimal(18,2)  
  ,Ganancia  decimal(18,2)  
 )    
 INSERT INTO #ProductoTemporal_2003    
 SELECT  
 PC.CodigoOferta  
 ,PC.CampaniaId  
 ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
 ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
FROM (SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, MAX(IndicadorPreUni) AS IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre   
  FROM #ProductoComercial   
  WHERE EstrategiaIdSicc = 2003  
  GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario,  FactorRepeticion, CodigoFactorCuadre) PC  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta   
    
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2001   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CUV = PT.CUV   
 AND EstrategiaIdSicc = 2001  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2002   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2002  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2003  PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2003  
  
UPDATE PT    
SET PT.Ganancia = 0    
FROM #ProductoTemporal PT  
WHERE PT.Ganancia < 0    
    
UPDATE PT    
SET PT.PrecioOferta = PT.PrecioPublico    
FROM #ProductoTemporal PT   
WHERE PT.PrecioPublico > 0    
  
UPDATE PT    
SET PT.PrecioTachado = PT.PrecioPublico + PT.Ganancia    
FROM #ProductoTemporal PT   
WHERE PT.Ganancia > 0    
UPDATE PN    
SET Precio = PN.Nivel * PN.Precio    
FROM #ProductoNivel PN    
  
CREATE TABLE #ProductoNiveles(    
CUV   varchar(5)    
,Campana INT  
,Niveles varchar(200)    
)    
INSERT INTO #ProductoNiveles    
SELECT   
 PN.CUV,    
 PN.Campana,  
 Niveles = ( SELECT STUFF( (SELECT '|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)    
   FROM #ProductoNivel    
   WHERE CUV = PN.CUV  and CAMPANA = PN.CAMPANA  
   FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),    
   1,    
   1,    
   ''    
   )    
  )    
FROM #ProductoNivel PN    
GROUP BY PN.CUV  , PN.Campana  
UPDATE PT    
SET    
 PT.Niveles = PNS.Niveles    
FROM #ProductoTemporal PT    
 JOIN #ProductoNiveles PNS ON PT.CUV = PNS.CUV  and PT.CodigoCampania = PNS.Campana  
SELECT * FROM #ProductoTemporal  
DROP TABLE #ProductoComercial    
DROP TABLE #ProductoNivel    
DROP TABLE #ProductoNiveles   
    
DROP TABLE #ProductoTemporal_2001    
DROP TABLE #ProductoTemporal_2002    
DROP TABLE #ProductoTemporal_2003    
DROP TABLE #ProductoTemporal  
END  

GO

USE BelcorpChile
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_ProductoComercial]   
AS  
BEGIN   
SET NOCOUNT ON;  
  
--------------------------------------  
declare @cteCampanias table  
(  
 CampaniaID int  
)  
  
insert into @cteCampanias  
select distinct TOP 8 CampaniaID   
FROM ods.ProductoComercial PM with(nolock)  
order by 1 desc  
--------------------------------------  
  
CREATE TABLE #ProductoTemporal (    
  CampaniaId   int    
  ,CodigoCampania int  
  ,CUV    varchar(50)    
  ,DescripcionCUV varchar(100)  
  ,CodigoProducto varchar(10)  
  ,PrecioUnitario  numeric(12,2)    
  ,IndicadorPreUni numeric(12,2)  
  ,PrecioPublico  numeric(12,2)   
  ,PrecioOferta  numeric(12,2)    
  ,PrecioTachado  numeric(12,2)     
  ,Ganancia  numeric(12,2)     
  ,IndicadorMontoMinimo int   
  ,IndicadorDigitable int   
  ,EstrategiaIdSicc int    
  ,CodigoOferta  int    
  ,NumeroGrupo  int    
  ,NumeroNivel  int    
  ,MarcaId int  
  ,MarcaDescripcion varchar(50)  
  ,IdMatrizComercial int  
  ,ImagenURL varchar(150)  
  ,Niveles varchar(200)  
  ,CodigoCatalogo varchar(6)  
  ,Categoria varchar(200)  
  ,GrupoArticulo varchar(200)  
  ,Linea varchar(200)  
  ,PrecioCatalogo  numeric(12,2)  
  ,PrecioValorizado  numeric(12,2)  
  ,FactorRepeticion int  
  ,CodigoTipoOferta varchar(6)  
 )   
 INSERT INTO #ProductoTemporal  
 SELECT   
 p.CampaniaID,  
 p.AnoCampania,  
 p.CUV,  
 REPLACE(COALESCE(mci.DescripcionComercial, pd.Descripcion,p.Descripcion),'"',char(39)) as DescripcionCUV,   
 p.CodigoProducto,  
 p.PrecioUnitario,  
 p.IndicadorPreUni,  
 0,  
 0,  
 0,  
 0,  
 p.IndicadorMontoMinimo,  
 p.IndicadorDigitable,     
 p.EstrategiaIdSicc,    
 p.CodigoOferta,    
 p.NumeroGrupo,    
 p.NumeroNivel,    
 p.MarcaID,   
 m.Descripcion,   
 mc.IdMatrizComercial,  
 mci.Foto AS ImagenURL,  
 '',  
 RTRIM(p.CodigoCatalago) AS CodigoCatalago,  
 fb.Nombre,  
 ga.DescripcionCorta,  
 sl.DescripcionLarga,  
 p.PrecioCatalogo,  
 p.PrecioValorizado,  
 p.FactorRepeticion,  
 RTRIM(p.CodigoTipoOferta) AS CodigoTipoOferta  
FROM ods.ProductoComercial p WITH (NOLOCK)   
 INNER JOIN dbo.Marca m WITH (NOLOCK) on m.MarcaId = p.MarcaID   
 LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON p.CodigoProducto = sp.CodigoSap  
 LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo  
 LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo  
 LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo  
 LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo  
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) on p.AnoCampania = pd.CampaniaID and p.CUV = pd.CUV   
 LEFT JOIN dbo.MatrizComercial mc WITH (NOLOCK) on p.CodigoProducto = mc.CodigoSAP   
 LEFT JOIN dbo.MatrizComercialImagen mci WITH (NOLOCK) on mci.IdMatrizComercial = mc.IdMatrizComercial AND mci.NemoTecnico IS NOT NULL   
 WHERE p.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)  
  
CREATE TABLE #ProductoComercial(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioUnitario  numeric(12,2)    
 ,FactorRepeticion int    
 ,IndicadorDigitable bit    
 ,AnoCampania  int    
 ,IndicadorPreUni numeric(12,2)    
 ,CodigoFactorCuadre numeric(12,2)    
 ,EstrategiaIdSicc int    
 ,CodigoOferta  int    
 ,NumeroGrupo  int    
 ,NumeroNivel  int    
)    
INSERT INTO #ProductoComercial    
SELECT    
 PC.CampaniaID    
 ,PC.CUV    
 ,PC.PrecioUnitario    
 ,PC.FactorRepeticion    
 ,PC.IndicadorDigitable    
 ,PC.AnoCampania    
 ,PC.IndicadorPreUni    
 ,PC.CodigoFactorCuadre    
 ,PC.EstrategiaIdSicc    
 ,PC.CodigoOferta    
 ,PC.NumeroGrupo    
 ,PC.NumeroNivel    
FROM ods.ProductoComercial PC WITH (NOLOCK)   
WHERE PC.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)   
  
CREATE TABLE #ProductoNivel(    
 CUV   varchar(5)    
 ,Campana INT  
 ,Nivel  int    
 ,Precio  numeric(12,2)    
)    
INSERT INTO #ProductoNivel    
SELECT    
 PC.CUV    
 ,PC.AnoCampania  
 ,Nivel = PN.FactorCuadre    
 ,Precio = PN.PrecioUnitario    
FROM #ProductoComercial PC     
 JOIN ods.ProductoNivel PN   ON PC.NumeroNivel = PN.NumeroNivel AND PN.FactorCuadre > 1  --and PC.AnoCampania = pn.campana  
GROUP BY    
 PC.CUV    
 ,PC.AnoCampania  
 ,PN.FactorCuadre    
 ,PN.PrecioUnitario  
   
CREATE TABLE #ProductoTemporal_2001(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioPublico   decimal(18,2)    
 ,Ganancia    decimal(18,2)    
)    
INSERT INTO #ProductoTemporal_2001    
SELECT    
 PC.CampaniaID, PC.CUV  
 ,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion    
 ,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion    
FROM #ProductoComercial PC    
 WHERE (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)  
 AND PC.FactorRepeticion >= 1    
   
CREATE TABLE #ProductoTemporal_2002(    
 CodigoOferta int  
 ,CampaniaId  int   
 ,PrecioPublico decimal(18,2)  
 ,Ganancia  decimal(18,2)  
)  
 INSERT INTO #ProductoTemporal_2002    
 SELECT  
  PC.CodigoOferta  
  ,PC.CampaniaId  
  ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)  
  ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)  
FROM  #ProductoComercial PC  
WHERE PC.EstrategiaIdSicc = 2002  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta    
   
 CREATE TABLE #ProductoTemporal_2003(    
 CodigoOferta int  
  ,CampaniaId  int   
  ,PrecioPublico decimal(18,2)  
  ,Ganancia  decimal(18,2)  
 )    
 INSERT INTO #ProductoTemporal_2003    
 SELECT  
 PC.CodigoOferta  
 ,PC.CampaniaId  
 ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
 ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
FROM (SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, MAX(IndicadorPreUni) AS IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre   
  FROM #ProductoComercial   
  WHERE EstrategiaIdSicc = 2003  
  GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario,  FactorRepeticion, CodigoFactorCuadre) PC  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta   
    
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2001   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CUV = PT.CUV   
 AND EstrategiaIdSicc = 2001  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2002   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2002  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2003  PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2003  
  
UPDATE PT    
SET PT.Ganancia = 0    
FROM #ProductoTemporal PT  
WHERE PT.Ganancia < 0    
    
UPDATE PT    
SET PT.PrecioOferta = PT.PrecioPublico    
FROM #ProductoTemporal PT   
WHERE PT.PrecioPublico > 0    
  
UPDATE PT    
SET PT.PrecioTachado = PT.PrecioPublico + PT.Ganancia    
FROM #ProductoTemporal PT   
WHERE PT.Ganancia > 0    
UPDATE PN    
SET Precio = PN.Nivel * PN.Precio    
FROM #ProductoNivel PN    
  
CREATE TABLE #ProductoNiveles(    
CUV   varchar(5)    
,Campana INT  
,Niveles varchar(200)    
)    
INSERT INTO #ProductoNiveles    
SELECT   
 PN.CUV,    
 PN.Campana,  
 Niveles = ( SELECT STUFF( (SELECT '|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)    
   FROM #ProductoNivel    
   WHERE CUV = PN.CUV  and CAMPANA = PN.CAMPANA  
   FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),    
   1,    
   1,    
   ''    
   )    
  )    
FROM #ProductoNivel PN    
GROUP BY PN.CUV  , PN.Campana  
UPDATE PT    
SET    
 PT.Niveles = PNS.Niveles    
FROM #ProductoTemporal PT    
 JOIN #ProductoNiveles PNS ON PT.CUV = PNS.CUV  and PT.CodigoCampania = PNS.Campana  
SELECT * FROM #ProductoTemporal  
DROP TABLE #ProductoComercial    
DROP TABLE #ProductoNivel    
DROP TABLE #ProductoNiveles   
    
DROP TABLE #ProductoTemporal_2001    
DROP TABLE #ProductoTemporal_2002    
DROP TABLE #ProductoTemporal_2003    
DROP TABLE #ProductoTemporal  
END  

GO

USE BelcorpBolivia
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_ProductoComercial]   
AS  
BEGIN   
SET NOCOUNT ON;  
  
--------------------------------------  
declare @cteCampanias table  
(  
 CampaniaID int  
)  
  
insert into @cteCampanias  
select distinct TOP 8 CampaniaID   
FROM ods.ProductoComercial PM with(nolock)  
order by 1 desc  
--------------------------------------  
  
CREATE TABLE #ProductoTemporal (    
  CampaniaId   int    
  ,CodigoCampania int  
  ,CUV    varchar(50)    
  ,DescripcionCUV varchar(100)  
  ,CodigoProducto varchar(10)  
  ,PrecioUnitario  numeric(12,2)    
  ,IndicadorPreUni numeric(12,2)  
  ,PrecioPublico  numeric(12,2)   
  ,PrecioOferta  numeric(12,2)    
  ,PrecioTachado  numeric(12,2)     
  ,Ganancia  numeric(12,2)     
  ,IndicadorMontoMinimo int   
  ,IndicadorDigitable int   
  ,EstrategiaIdSicc int    
  ,CodigoOferta  int    
  ,NumeroGrupo  int    
  ,NumeroNivel  int    
  ,MarcaId int  
  ,MarcaDescripcion varchar(50)  
  ,IdMatrizComercial int  
  ,ImagenURL varchar(150)  
  ,Niveles varchar(200)  
  ,CodigoCatalogo varchar(6)  
  ,Categoria varchar(200)  
  ,GrupoArticulo varchar(200)  
  ,Linea varchar(200)  
  ,PrecioCatalogo  numeric(12,2)  
  ,PrecioValorizado  numeric(12,2)  
  ,FactorRepeticion int  
  ,CodigoTipoOferta varchar(6)  
 )   
 INSERT INTO #ProductoTemporal  
 SELECT   
 p.CampaniaID,  
 p.AnoCampania,  
 p.CUV,  
 REPLACE(COALESCE(mci.DescripcionComercial, pd.Descripcion,p.Descripcion),'"',char(39)) as DescripcionCUV,   
 p.CodigoProducto,  
 p.PrecioUnitario,  
 p.IndicadorPreUni,  
 0,  
 0,  
 0,  
 0,  
 p.IndicadorMontoMinimo,  
 p.IndicadorDigitable,     
 p.EstrategiaIdSicc,    
 p.CodigoOferta,    
 p.NumeroGrupo,    
 p.NumeroNivel,    
 p.MarcaID,   
 m.Descripcion,   
 mc.IdMatrizComercial,  
 mci.Foto AS ImagenURL,  
 '',  
 RTRIM(p.CodigoCatalago) AS CodigoCatalago,  
 fb.Nombre,  
 ga.DescripcionCorta,  
 sl.DescripcionLarga,  
 p.PrecioCatalogo,  
 p.PrecioValorizado,  
 p.FactorRepeticion,  
 RTRIM(p.CodigoTipoOferta) AS CodigoTipoOferta  
FROM ods.ProductoComercial p WITH (NOLOCK)   
 INNER JOIN dbo.Marca m WITH (NOLOCK) on m.MarcaId = p.MarcaID   
 LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON p.CodigoProducto = sp.CodigoSap  
 LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo  
 LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo  
 LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo  
 LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo  
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) on p.AnoCampania = pd.CampaniaID and p.CUV = pd.CUV   
 LEFT JOIN dbo.MatrizComercial mc WITH (NOLOCK) on p.CodigoProducto = mc.CodigoSAP   
 LEFT JOIN dbo.MatrizComercialImagen mci WITH (NOLOCK) on mci.IdMatrizComercial = mc.IdMatrizComercial AND mci.NemoTecnico IS NOT NULL   
 WHERE p.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)  
  
CREATE TABLE #ProductoComercial(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioUnitario  numeric(12,2)    
 ,FactorRepeticion int    
 ,IndicadorDigitable bit    
 ,AnoCampania  int    
 ,IndicadorPreUni numeric(12,2)    
 ,CodigoFactorCuadre numeric(12,2)    
 ,EstrategiaIdSicc int    
 ,CodigoOferta  int    
 ,NumeroGrupo  int    
 ,NumeroNivel  int    
)    
INSERT INTO #ProductoComercial    
SELECT    
 PC.CampaniaID    
 ,PC.CUV    
 ,PC.PrecioUnitario    
 ,PC.FactorRepeticion    
 ,PC.IndicadorDigitable    
 ,PC.AnoCampania    
 ,PC.IndicadorPreUni    
 ,PC.CodigoFactorCuadre    
 ,PC.EstrategiaIdSicc    
 ,PC.CodigoOferta    
 ,PC.NumeroGrupo    
 ,PC.NumeroNivel    
FROM ods.ProductoComercial PC WITH (NOLOCK)   
WHERE PC.CampaniaID IN (SELECT CampaniaID FROM @cteCampanias)   
  
CREATE TABLE #ProductoNivel(    
 CUV   varchar(5)    
 ,Campana INT  
 ,Nivel  int    
 ,Precio  numeric(12,2)    
)    
INSERT INTO #ProductoNivel    
SELECT    
 PC.CUV    
 ,PC.AnoCampania  
 ,Nivel = PN.FactorCuadre    
 ,Precio = PN.PrecioUnitario    
FROM #ProductoComercial PC     
 JOIN ods.ProductoNivel PN   ON PC.NumeroNivel = PN.NumeroNivel AND PN.FactorCuadre > 1  --and PC.AnoCampania = pn.campana  
GROUP BY    
 PC.CUV    
 ,PC.AnoCampania  
 ,PN.FactorCuadre    
 ,PN.PrecioUnitario  
   
CREATE TABLE #ProductoTemporal_2001(    
 CampaniaID   int    
 ,CUV    varchar(50)    
 ,PrecioPublico   decimal(18,2)    
 ,Ganancia    decimal(18,2)    
)    
INSERT INTO #ProductoTemporal_2001    
SELECT    
 PC.CampaniaID, PC.CUV  
 ,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion    
 ,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion    
FROM #ProductoComercial PC    
 WHERE (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)  
 AND PC.FactorRepeticion >= 1    
   
CREATE TABLE #ProductoTemporal_2002(    
 CodigoOferta int  
 ,CampaniaId  int   
 ,PrecioPublico decimal(18,2)  
 ,Ganancia  decimal(18,2)  
)  
 INSERT INTO #ProductoTemporal_2002    
 SELECT  
  PC.CodigoOferta  
  ,PC.CampaniaId  
  ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)  
  ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)  
FROM  #ProductoComercial PC  
WHERE PC.EstrategiaIdSicc = 2002  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta    
   
 CREATE TABLE #ProductoTemporal_2003(    
 CodigoOferta int  
  ,CampaniaId  int   
  ,PrecioPublico decimal(18,2)  
  ,Ganancia  decimal(18,2)  
 )    
 INSERT INTO #ProductoTemporal_2003    
 SELECT  
 PC.CodigoOferta  
 ,PC.CampaniaId  
 ,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
 ,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)  
FROM (SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, MAX(IndicadorPreUni) AS IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre   
  FROM #ProductoComercial   
  WHERE EstrategiaIdSicc = 2003  
  GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario,  FactorRepeticion, CodigoFactorCuadre) PC  
GROUP BY PC.CampaniaId, PC.CodigoOferta  
ORDER BY PC.CampaniaId, PC.CodigoOferta   
    
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2001   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CUV = PT.CUV   
 AND EstrategiaIdSicc = 2001  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2002   PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2002  
  
UPDATE PT   
SET    
 PT.PrecioPublico = PT_GAN.PrecioPublico    
 ,PT.Ganancia = PT_GAN.Ganancia    
FROM #ProductoTemporal PT  
 JOIN #ProductoTemporal_2003  PT_GAN ON PT_GAN.CampaniaID = PT.CampaniaID   
 AND PT_GAN.CodigoOferta = PT.CodigoOferta   
 AND EstrategiaIdSicc = 2003  
  
UPDATE PT    
SET PT.Ganancia = 0    
FROM #ProductoTemporal PT  
WHERE PT.Ganancia < 0    
    
UPDATE PT    
SET PT.PrecioOferta = PT.PrecioPublico    
FROM #ProductoTemporal PT   
WHERE PT.PrecioPublico > 0    
  
UPDATE PT    
SET PT.PrecioTachado = PT.PrecioPublico + PT.Ganancia    
FROM #ProductoTemporal PT   
WHERE PT.Ganancia > 0    
UPDATE PN    
SET Precio = PN.Nivel * PN.Precio    
FROM #ProductoNivel PN    
  
CREATE TABLE #ProductoNiveles(    
CUV   varchar(5)    
,Campana INT  
,Niveles varchar(200)    
)    
INSERT INTO #ProductoNiveles    
SELECT   
 PN.CUV,    
 PN.Campana,  
 Niveles = ( SELECT STUFF( (SELECT '|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)    
   FROM #ProductoNivel    
   WHERE CUV = PN.CUV  and CAMPANA = PN.CAMPANA  
   FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),    
   1,    
   1,    
   ''    
   )    
  )    
FROM #ProductoNivel PN    
GROUP BY PN.CUV  , PN.Campana  
UPDATE PT    
SET    
 PT.Niveles = PNS.Niveles    
FROM #ProductoTemporal PT    
 JOIN #ProductoNiveles PNS ON PT.CUV = PNS.CUV  and PT.CodigoCampania = PNS.Campana  
SELECT * FROM #ProductoTemporal  
DROP TABLE #ProductoComercial    
DROP TABLE #ProductoNivel    
DROP TABLE #ProductoNiveles   
    
DROP TABLE #ProductoTemporal_2001    
DROP TABLE #ProductoTemporal_2002    
DROP TABLE #ProductoTemporal_2003    
DROP TABLE #ProductoTemporal  
END  

GO

