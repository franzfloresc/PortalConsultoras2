USE [BelcorpBolivia];
GO
declare @TablaLogicaID int = '24'
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
	insert into TablaLogica(TablaLogicaID, Descripcion) values (@TablaLogicaID, 'Catalogos y Revistas Piloto');
GO

USE [BelcorpChile];
GO
declare @TablaLogicaID int = '24'
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
	insert into TablaLogica values (@TablaLogicaID, 'Catalogos y Revistas Piloto');
if not exists (select 1 from TablaLogicaDatos where TablaLogicaID = @TablaLogicaID)
	insert into TablaLogicaDatos(TablaLogicaDatosID, TablaLogicaID, Codigo, Valor, Descripcion) values
	(@TablaLogicaID + '01', @TablaLogicaID, 'RevistaPiloto_Grupos_CL201903', 'ESCrdr', ''),
	(@TablaLogicaID + '02', @TablaLogicaID, 'RevistaPiloto_Zonas_CL201903_ESCrdr', '1110,1112,1511,1609,1707', ''),
	(@TablaLogicaID + '03', @TablaLogicaID, 'Catalogo_Marca_Piloto_CL201906', 'Esika', ''),
	(@TablaLogicaID + '04', @TablaLogicaID, 'Catalogo_Piloto_Grupos_Esika_CL201906', 'ESCrdr1,ESCrdr2', ''),
	(@TablaLogicaID + '05', @TablaLogicaID, 'Catalogo_Piloto_Zonas_Esika_CL201906_ESCrdr1', '1106,1207,1222,1514,1516', ''),
	(@TablaLogicaID + '06', @TablaLogicaID, 'Catalogo_Piloto_Zonas_Esika_CL201906_ESCrdr2', '1215,1314,1322,1509,1702', ''),
	(@TablaLogicaID + '07', @TablaLogicaID, 'RevistaPiloto_Grupos_CL201907', 'ESCrdr1,ESCrdr2', ''),
	(@TablaLogicaID + '08', @TablaLogicaID, 'RevistaPiloto_Zonas_CL201907_ESCrdr1', '1413,1607,1711,1713,1714', ''),
	(@TablaLogicaID + '09', @TablaLogicaID, 'RevistaPiloto_Zonas_CL201907_ESCrdr2', '1115,1221,1321,1412,1703', '');
GO

USE [BelcorpColombia];
GO
declare @TablaLogicaID int = '24'
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
	insert into TablaLogica(TablaLogicaID, Descripcion) values (@TablaLogicaID, 'Catalogos y Revistas Piloto');

if not exists (select 1 from TablaLogicaDatos where TablaLogicaID = @TablaLogicaID)
    insert into TablaLogicaDatos(TablaLogicaDatosID, TablaLogicaID, Codigo, Valor, Descripcion) values 
    (CONCAT(@TablaLogicaID,'01'), @TablaLogicaID, 'Catalogo_Marca_Piloto_CO201904', 'Esika', ''),
    (CONCAT(@TablaLogicaID,'02'), @TablaLogicaID, 'Catalogo_Piloto_Grupos_Esika_CO201904', 'ESCrdr', ''),
    (CONCAT(@TablaLogicaID,'03'), @TablaLogicaID, 'Catalogo_Piloto_Zonas_Esika_CO201904_ESCrdr', '0814,0834,1504,2003,2021', ''),
	(CONCAT(@TablaLogicaID,'04'), @TablaLogicaID, 'Catalogo_Marca_Piloto_CO201905', 'Esika', ''),
	(CONCAT(@TablaLogicaID,'05'), @TablaLogicaID, 'Catalogo_Piloto_Grupos_Esika_CO201905', 'ESCrdr', ''),
	(CONCAT(@TablaLogicaID,'06'), @TablaLogicaID, 'Catalogo_Piloto_Zonas_Esika_CO201905_ESCrdr', '0814,0834,1504,2003,2021', ''),
	(CONCAT(@TablaLogicaID,'07'), @TablaLogicaID, 'Catalogo_Marca_Piloto_CO201906', 'Esika', ''),
	(CONCAT(@TablaLogicaID,'08'), @TablaLogicaID, 'Catalogo_Piloto_Grupos_Esika_CO201906', 'ESCrdr', ''),
	(CONCAT(@TablaLogicaID,'09'), @TablaLogicaID, 'Catalogo_Piloto_Zonas_Esika_CO201906_ESCrdr', '0814,0834,1504,2003,2021', '')
	(CONCAT(@TablaLogicaID,'10'), @TablaLogicaID, 'RevistaPiloto_Zonas_RDR_2_CO', '2604,2606,2610,2625,2612,2613,2614,2623', '');
GO

USE [BelcorpCostaRica];
GO
declare @TablaLogicaID int = '24'
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
	insert into TablaLogica(TablaLogicaID, Descripcion) values (@TablaLogicaID, 'Catalogos y Revistas Piloto');
GO

USE [BelcorpDominicana];
GO
declare @TablaLogicaID int = '24'
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
	insert into TablaLogica(TablaLogicaID, Descripcion) values (@TablaLogicaID, 'Catalogos y Revistas Piloto');
GO

USE [BelcorpEcuador];
GO
declare @TablaLogicaID int = '24'
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
	insert into TablaLogica(TablaLogicaID, Descripcion) values (@TablaLogicaID, 'Catalogos y Revistas Piloto');

if not exists (select 1 from TablaLogicaDatos where TablaLogicaID = @TablaLogicaID)
    insert into TablaLogicaDatos(TablaLogicaDatosID, TablaLogicaID, Codigo, Valor, Descripcion) values 
    (CONCAT(@TablaLogicaID,'01'), @TablaLogicaID, 'Catalogo_Marca_Piloto_EC201903', 'Esika', ''),
    (CONCAT(@TablaLogicaID,'02'), @TablaLogicaID, 'Catalogo_Piloto_Grupos_Esika_EC201903', 'ESCrdr', ''),
    (CONCAT(@TablaLogicaID,'03'), @TablaLogicaID, 'Catalogo_Piloto_Zonas_Esika_EC201903_ESCrdr', '1824,1912,2217,2219,2220', ''),
	(CONCAT(@TablaLogicaID,'04'), @TablaLogicaID, 'Catalogo_Marca_Piloto_EC201906', 'Esika', ''),
	(CONCAT(@TablaLogicaID,'05'), @TablaLogicaID, 'Catalogo_Piloto_Grupos_Esika_EC201906', 'ESCrdr', ''),
	(CONCAT(@TablaLogicaID,'06'), @TablaLogicaID, 'Catalogo_Piloto_Zonas_Esika_EC201906_ESCrdr', '1625,1916,1919,2308,1806', ''),
	(CONCAT(@TablaLogicaID,'07'), @TablaLogicaID, 'Catalogo_Marca_Piloto_EC201907', 'Cyzone', ''),
	(CONCAT(@TablaLogicaID,'08'), @TablaLogicaID, 'Catalogo_Piloto_Grupos_Cyzone_EC201907', 'ESCrdr1,ESCrdr2', ''),
	(CONCAT(@TablaLogicaID,'09'), @TablaLogicaID, 'Catalogo_Piloto_Zonas_Cyzone_EC201907_ESCrdr1', '1807,1819,2103,2110,2319', ''),
	(CONCAT(@TablaLogicaID,'10'), @TablaLogicaID, 'Catalogo_Piloto_Zonas_Cyzone_EC201907_ESCrdr2', '1631,1815,2011,2105,2302', '');
GO

USE [BelcorpGuatemala];
GO
declare @TablaLogicaID int = '24'
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
	insert into TablaLogica(TablaLogicaID, Descripcion) values (@TablaLogicaID, 'Catalogos y Revistas Piloto');
GO

USE [BelcorpMexico];
GO
declare @TablaLogicaID int = '24'
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
	insert into TablaLogica(TablaLogicaID, Descripcion) values (@TablaLogicaID, 'Catalogos y Revistas Piloto');
GO

USE [BelcorpPanama];
GO
declare @TablaLogicaID int = '24'
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
	insert into TablaLogica(TablaLogicaID, Descripcion) values (@TablaLogicaID, 'Catalogos y Revistas Piloto');
GO

USE [BelcorpPeru];
GO
declare @TablaLogicaID int = '24'
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
	insert into TablaLogica(TablaLogicaID, Descripcion) values (@TablaLogicaID, 'Catalogos y Revistas Piloto');
GO

USE [BelcorpPuertoRico];
GO
declare @TablaLogicaID int = '24'
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
	insert into TablaLogica(TablaLogicaID, Descripcion) values (@TablaLogicaID, 'Catalogos y Revistas Piloto');
GO


USE [BelcorpSalvador];
GO
declare @TablaLogicaID int = '24'
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
	insert into TablaLogica(TablaLogicaID, Descripcion) values (@TablaLogicaID, 'Catalogos y Revistas Piloto');
GO
