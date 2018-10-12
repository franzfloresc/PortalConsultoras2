USE BelcorpPeru
GO

GO

ALTER PROCEDURE dbo.SelectProductoToKitInicio_SB2
	@CampaniaID int,
	@Cuv varchar(100)
AS
/*
dbo.SelectProductoToKitInicio_SB2 201609,'00025'
dbo.SelectProductoToKitInicio_SB2 201609,'02767'
*/
BEGIN
	
	DECLARE @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250)
	)

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion
	FROM OfertaProducto op
	inner join ods.Campania c on
	op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	select distinct 
	p.CUV,
	p.IndicadorMontoMinimo,
	p.MarcaID,
	coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
	coalesce(EST.DescripcionCUV2 + ' '+ tcc.Descripcion , est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion

	from ods.ProductoComercial p
	left join dbo.ProductoDescripcion pd 
		ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc 
		ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op 
		on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc 
		on p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST 
		ON EST.CampaniaID = p.AnoCampania 
		AND (EST.CUV2 = p.CUV 
			OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)
		) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID 
	--AND p.IndicadorDigitable = 1
	AND CHARINDEX(@Cuv,p.CUV)>0
END

GO

USE BelcorpMexico
GO

GO

ALTER PROCEDURE dbo.SelectProductoToKitInicio_SB2
	@CampaniaID int,
	@Cuv varchar(100)
AS
/*
dbo.SelectProductoToKitInicio_SB2 201609,'00025'
dbo.SelectProductoToKitInicio_SB2 201609,'02767'
*/
BEGIN
	
	DECLARE @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250)
	)

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion
	FROM OfertaProducto op
	inner join ods.Campania c on
	op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	select distinct 
	p.CUV,
	p.IndicadorMontoMinimo,
	p.MarcaID,
	coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
	coalesce(EST.DescripcionCUV2 + ' '+ tcc.Descripcion , est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion

	from ods.ProductoComercial p
	left join dbo.ProductoDescripcion pd 
		ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc 
		ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op 
		on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc 
		on p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST 
		ON EST.CampaniaID = p.AnoCampania 
		AND (EST.CUV2 = p.CUV 
			OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)
		) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID 
	--AND p.IndicadorDigitable = 1
	AND CHARINDEX(@Cuv,p.CUV)>0
END

GO

USE BelcorpColombia
GO

GO

ALTER PROCEDURE dbo.SelectProductoToKitInicio_SB2
	@CampaniaID int,
	@Cuv varchar(100)
AS
/*
dbo.SelectProductoToKitInicio_SB2 201609,'00025'
dbo.SelectProductoToKitInicio_SB2 201609,'02767'
*/
BEGIN
	
	DECLARE @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250)
	)

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion
	FROM OfertaProducto op
	inner join ods.Campania c on
	op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	select distinct 
	p.CUV,
	p.IndicadorMontoMinimo,
	p.MarcaID,
	coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
	coalesce(EST.DescripcionCUV2 + ' '+ tcc.Descripcion , est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion

	from ods.ProductoComercial p
	left join dbo.ProductoDescripcion pd 
		ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc 
		ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op 
		on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc 
		on p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST 
		ON EST.CampaniaID = p.AnoCampania 
		AND (EST.CUV2 = p.CUV 
			OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)
		) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID 
	--AND p.IndicadorDigitable = 1
	AND CHARINDEX(@Cuv,p.CUV)>0
END

GO

USE BelcorpVenezuela
GO

GO

ALTER PROCEDURE dbo.SelectProductoToKitInicio_SB2
	@CampaniaID int,
	@Cuv varchar(100)
AS
/*
dbo.SelectProductoToKitInicio_SB2 201609,'00025'
dbo.SelectProductoToKitInicio_SB2 201609,'02767'
*/
BEGIN
	
	DECLARE @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250)
	)

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion
	FROM OfertaProducto op
	inner join ods.Campania c on
	op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	select distinct 
	p.CUV,
	p.IndicadorMontoMinimo,
	p.MarcaID,
	coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
	coalesce(EST.DescripcionCUV2 + ' '+ tcc.Descripcion , est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion

	from ods.ProductoComercial p
	left join dbo.ProductoDescripcion pd 
		ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc 
		ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op 
		on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc 
		on p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST 
		ON EST.CampaniaID = p.AnoCampania 
		AND (EST.CUV2 = p.CUV 
			OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)
		) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID 
	--AND p.IndicadorDigitable = 1
	AND CHARINDEX(@Cuv,p.CUV)>0
END

GO

USE BelcorpSalvador
GO

GO

ALTER PROCEDURE dbo.SelectProductoToKitInicio_SB2
	@CampaniaID int,
	@Cuv varchar(100)
AS
/*
dbo.SelectProductoToKitInicio_SB2 201609,'00025'
dbo.SelectProductoToKitInicio_SB2 201609,'02767'
*/
BEGIN
	
	DECLARE @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250)
	)

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion
	FROM OfertaProducto op
	inner join ods.Campania c on
	op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	select distinct 
	p.CUV,
	p.IndicadorMontoMinimo,
	p.MarcaID,
	coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
	coalesce(EST.DescripcionCUV2 + ' '+ tcc.Descripcion , est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion

	from ods.ProductoComercial p
	left join dbo.ProductoDescripcion pd 
		ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc 
		ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op 
		on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc 
		on p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST 
		ON EST.CampaniaID = p.AnoCampania 
		AND (EST.CUV2 = p.CUV 
			OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)
		) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID 
	--AND p.IndicadorDigitable = 1
	AND CHARINDEX(@Cuv,p.CUV)>0
END

GO

USE BelcorpPuertoRico
GO

GO

ALTER PROCEDURE dbo.SelectProductoToKitInicio_SB2
	@CampaniaID int,
	@Cuv varchar(100)
AS
/*
dbo.SelectProductoToKitInicio_SB2 201609,'00025'
dbo.SelectProductoToKitInicio_SB2 201609,'02767'
*/
BEGIN
	
	DECLARE @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250)
	)

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion
	FROM OfertaProducto op
	inner join ods.Campania c on
	op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	select distinct 
	p.CUV,
	p.IndicadorMontoMinimo,
	p.MarcaID,
	coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
	coalesce(EST.DescripcionCUV2 + ' '+ tcc.Descripcion , est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion

	from ods.ProductoComercial p
	left join dbo.ProductoDescripcion pd 
		ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc 
		ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op 
		on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc 
		on p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST 
		ON EST.CampaniaID = p.AnoCampania 
		AND (EST.CUV2 = p.CUV 
			OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)
		) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID 
	--AND p.IndicadorDigitable = 1
	AND CHARINDEX(@Cuv,p.CUV)>0
END

GO

USE BelcorpPanama
GO

GO

ALTER PROCEDURE dbo.SelectProductoToKitInicio_SB2
	@CampaniaID int,
	@Cuv varchar(100)
AS
/*
dbo.SelectProductoToKitInicio_SB2 201609,'00025'
dbo.SelectProductoToKitInicio_SB2 201609,'02767'
*/
BEGIN
	
	DECLARE @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250)
	)

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion
	FROM OfertaProducto op
	inner join ods.Campania c on
	op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	select distinct 
	p.CUV,
	p.IndicadorMontoMinimo,
	p.MarcaID,
	coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
	coalesce(EST.DescripcionCUV2 + ' '+ tcc.Descripcion , est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion

	from ods.ProductoComercial p
	left join dbo.ProductoDescripcion pd 
		ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc 
		ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op 
		on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc 
		on p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST 
		ON EST.CampaniaID = p.AnoCampania 
		AND (EST.CUV2 = p.CUV 
			OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)
		) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID 
	--AND p.IndicadorDigitable = 1
	AND CHARINDEX(@Cuv,p.CUV)>0
END

GO

USE BelcorpGuatemala
GO

GO

ALTER PROCEDURE dbo.SelectProductoToKitInicio_SB2
	@CampaniaID int,
	@Cuv varchar(100)
AS
/*
dbo.SelectProductoToKitInicio_SB2 201609,'00025'
dbo.SelectProductoToKitInicio_SB2 201609,'02767'
*/
BEGIN
	
	DECLARE @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250)
	)

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion
	FROM OfertaProducto op
	inner join ods.Campania c on
	op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	select distinct 
	p.CUV,
	p.IndicadorMontoMinimo,
	p.MarcaID,
	coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
	coalesce(EST.DescripcionCUV2 + ' '+ tcc.Descripcion , est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion

	from ods.ProductoComercial p
	left join dbo.ProductoDescripcion pd 
		ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc 
		ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op 
		on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc 
		on p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST 
		ON EST.CampaniaID = p.AnoCampania 
		AND (EST.CUV2 = p.CUV 
			OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)
		) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID 
	--AND p.IndicadorDigitable = 1
	AND CHARINDEX(@Cuv,p.CUV)>0
END

GO

USE BelcorpEcuador
GO

GO

ALTER PROCEDURE dbo.SelectProductoToKitInicio_SB2
	@CampaniaID int,
	@Cuv varchar(100)
AS
/*
dbo.SelectProductoToKitInicio_SB2 201609,'00025'
dbo.SelectProductoToKitInicio_SB2 201609,'02767'
*/
BEGIN
	
	DECLARE @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250)
	)

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion
	FROM OfertaProducto op
	inner join ods.Campania c on
	op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	select distinct 
	p.CUV,
	p.IndicadorMontoMinimo,
	p.MarcaID,
	coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
	coalesce(EST.DescripcionCUV2 + ' '+ tcc.Descripcion , est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion

	from ods.ProductoComercial p
	left join dbo.ProductoDescripcion pd 
		ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc 
		ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op 
		on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc 
		on p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST 
		ON EST.CampaniaID = p.AnoCampania 
		AND (EST.CUV2 = p.CUV 
			OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)
		) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID 
	--AND p.IndicadorDigitable = 1
	AND CHARINDEX(@Cuv,p.CUV)>0
END

GO

USE BelcorpDominicana
GO

GO

ALTER PROCEDURE dbo.SelectProductoToKitInicio_SB2
	@CampaniaID int,
	@Cuv varchar(100)
AS
/*
dbo.SelectProductoToKitInicio_SB2 201609,'00025'
dbo.SelectProductoToKitInicio_SB2 201609,'02767'
*/
BEGIN
	
	DECLARE @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250)
	)

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion
	FROM OfertaProducto op
	inner join ods.Campania c on
	op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	select distinct 
	p.CUV,
	p.IndicadorMontoMinimo,
	p.MarcaID,
	coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
	coalesce(EST.DescripcionCUV2 + ' '+ tcc.Descripcion , est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion

	from ods.ProductoComercial p
	left join dbo.ProductoDescripcion pd 
		ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc 
		ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op 
		on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc 
		on p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST 
		ON EST.CampaniaID = p.AnoCampania 
		AND (EST.CUV2 = p.CUV 
			OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)
		) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID 
	--AND p.IndicadorDigitable = 1
	AND CHARINDEX(@Cuv,p.CUV)>0
END

GO

USE BelcorpCostaRica
GO

GO

ALTER PROCEDURE dbo.SelectProductoToKitInicio_SB2
	@CampaniaID int,
	@Cuv varchar(100)
AS
/*
dbo.SelectProductoToKitInicio_SB2 201609,'00025'
dbo.SelectProductoToKitInicio_SB2 201609,'02767'
*/
BEGIN
	
	DECLARE @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250)
	)

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion
	FROM OfertaProducto op
	inner join ods.Campania c on
	op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	select distinct 
	p.CUV,
	p.IndicadorMontoMinimo,
	p.MarcaID,
	coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
	coalesce(EST.DescripcionCUV2 + ' '+ tcc.Descripcion , est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion

	from ods.ProductoComercial p
	left join dbo.ProductoDescripcion pd 
		ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc 
		ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op 
		on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc 
		on p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST 
		ON EST.CampaniaID = p.AnoCampania 
		AND (EST.CUV2 = p.CUV 
			OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)
		) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID 
	--AND p.IndicadorDigitable = 1
	AND CHARINDEX(@Cuv,p.CUV)>0
END

GO

USE BelcorpChile
GO

GO

ALTER PROCEDURE dbo.SelectProductoToKitInicio_SB2
	@CampaniaID int,
	@Cuv varchar(100)
AS
/*
dbo.SelectProductoToKitInicio_SB2 201609,'00025'
dbo.SelectProductoToKitInicio_SB2 201609,'02767'
*/
BEGIN
	
	DECLARE @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250)
	)

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion
	FROM OfertaProducto op
	inner join ods.Campania c on
	op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	select distinct 
	p.CUV,
	p.IndicadorMontoMinimo,
	p.MarcaID,
	coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
	coalesce(EST.DescripcionCUV2 + ' '+ tcc.Descripcion , est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion

	from ods.ProductoComercial p
	left join dbo.ProductoDescripcion pd 
		ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc 
		ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op 
		on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc 
		on p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST 
		ON EST.CampaniaID = p.AnoCampania 
		AND (EST.CUV2 = p.CUV 
			OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)
		) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID 
	--AND p.IndicadorDigitable = 1
	AND CHARINDEX(@Cuv,p.CUV)>0
END

GO

USE BelcorpBolivia
GO

GO

ALTER PROCEDURE dbo.SelectProductoToKitInicio_SB2
	@CampaniaID int,
	@Cuv varchar(100)
AS
/*
dbo.SelectProductoToKitInicio_SB2 201609,'00025'
dbo.SelectProductoToKitInicio_SB2 201609,'02767'
*/
BEGIN
	
	DECLARE @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250)
	)

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion
	FROM OfertaProducto op
	inner join ods.Campania c on
	op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	select distinct 
	p.CUV,
	p.IndicadorMontoMinimo,
	p.MarcaID,
	coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
	coalesce(EST.DescripcionCUV2 + ' '+ tcc.Descripcion , est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion

	from ods.ProductoComercial p
	left join dbo.ProductoDescripcion pd 
		ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc 
		ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op 
		on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc 
		on p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST 
		ON EST.CampaniaID = p.AnoCampania 
		AND (EST.CUV2 = p.CUV 
			OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)
		) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID 
	--AND p.IndicadorDigitable = 1
	AND CHARINDEX(@Cuv,p.CUV)>0
END

GO

