USE BelcorpPeru
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetCuvSuscripcionSE] AS'
END
GO

ALTER PROCEDURE [dbo].[GetCuvSuscripcionSE]
	@CampaniaID int,
	@CodigoConsultora varchar(25)

AS
BEGIN
SET NOCOUNT ON;

	declare @tblSuscripcionSE table
	(
		CUV varchar(6),
		Cantidad int,
		CampaniaID int
	)

	insert into @tblSuscripcionSE
	(CUV,
	Cantidad,
	CampaniaID)
	select  se.CUV,
			se.Cantidad,
			c.CampaniaID
	from ods.SuscripcionExclusivosSE se
	inner join ods.Campania c on se.Campania = c.Codigo
	where se.CodigoCliente = @CodigoConsultora

	select distinct
		p.CUV,
		p.IndicadorMontoMinimo,
		p.MarcaID,
		est.TipoEstrategiaID,
		coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo,
		coalesce(est.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		se.Cantidad
	from ods.ProductoComercial p
	inner join @tblSuscripcionSE se
		on  se.CampaniaID = P.CampaniaID AND se.CUV = p.CUV
	left join dbo.ProductoDescripcion pd
		on  p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc
		on  p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join MatrizComercial mc
		on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia est
		on EST.CampaniaID = p.AnoCampania
		and (est.CUV2 = p.CUV
			or est.CUV2 = (select CUVPadre from TallaColorCUV TCC where TCC.CUV = p.CUV)
		)
		and EST.Activo = 1
	left join dbo.TallaColorCUV tcc
		on tcc.CUV = p.CUV
		and tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID


SET NOCOUNT OFF;
END


GO

GO
USE BelcorpMexico
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetCuvSuscripcionSE] AS'
END
GO

ALTER PROCEDURE [dbo].[GetCuvSuscripcionSE]
	@CampaniaID int,
	@CodigoConsultora varchar(25)

AS
BEGIN
SET NOCOUNT ON;

	declare @tblSuscripcionSE table
	(
		CUV varchar(6),
		Cantidad int,
		CampaniaID int
	)

	insert into @tblSuscripcionSE
	(CUV,
	Cantidad,
	CampaniaID)
	select  se.CUV,
			se.Cantidad,
			c.CampaniaID
	from ods.SuscripcionExclusivosSE se
	inner join ods.Campania c on se.Campania = c.Codigo
	where se.CodigoCliente = @CodigoConsultora

	select distinct
		p.CUV,
		p.IndicadorMontoMinimo,
		p.MarcaID,
		est.TipoEstrategiaID,
		coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo,
		coalesce(est.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		se.Cantidad
	from ods.ProductoComercial p
	inner join @tblSuscripcionSE se
		on  se.CampaniaID = P.CampaniaID AND se.CUV = p.CUV
	left join dbo.ProductoDescripcion pd
		on  p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc
		on  p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join MatrizComercial mc
		on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia est
		on EST.CampaniaID = p.AnoCampania
		and (est.CUV2 = p.CUV
			or est.CUV2 = (select CUVPadre from TallaColorCUV TCC where TCC.CUV = p.CUV)
		)
		and EST.Activo = 1
	left join dbo.TallaColorCUV tcc
		on tcc.CUV = p.CUV
		and tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID


SET NOCOUNT OFF;
END


GO

GO
USE BelcorpColombia
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetCuvSuscripcionSE] AS'
END
GO

ALTER PROCEDURE [dbo].[GetCuvSuscripcionSE]
	@CampaniaID int,
	@CodigoConsultora varchar(25)

AS
BEGIN
SET NOCOUNT ON;

	declare @tblSuscripcionSE table
	(
		CUV varchar(6),
		Cantidad int,
		CampaniaID int
	)

	insert into @tblSuscripcionSE
	(CUV,
	Cantidad,
	CampaniaID)
	select  se.CUV,
			se.Cantidad,
			c.CampaniaID
	from ods.SuscripcionExclusivosSE se
	inner join ods.Campania c on se.Campania = c.Codigo
	where se.CodigoCliente = @CodigoConsultora

	select distinct
		p.CUV,
		p.IndicadorMontoMinimo,
		p.MarcaID,
		est.TipoEstrategiaID,
		coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo,
		coalesce(est.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		se.Cantidad
	from ods.ProductoComercial p
	inner join @tblSuscripcionSE se
		on  se.CampaniaID = P.CampaniaID AND se.CUV = p.CUV
	left join dbo.ProductoDescripcion pd
		on  p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc
		on  p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join MatrizComercial mc
		on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia est
		on EST.CampaniaID = p.AnoCampania
		and (est.CUV2 = p.CUV
			or est.CUV2 = (select CUVPadre from TallaColorCUV TCC where TCC.CUV = p.CUV)
		)
		and EST.Activo = 1
	left join dbo.TallaColorCUV tcc
		on tcc.CUV = p.CUV
		and tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID


SET NOCOUNT OFF;
END


GO

GO
USE BelcorpSalvador
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetCuvSuscripcionSE] AS'
END
GO

ALTER PROCEDURE [dbo].[GetCuvSuscripcionSE]
	@CampaniaID int,
	@CodigoConsultora varchar(25)

AS
BEGIN
SET NOCOUNT ON;

	declare @tblSuscripcionSE table
	(
		CUV varchar(6),
		Cantidad int,
		CampaniaID int
	)

	insert into @tblSuscripcionSE
	(CUV,
	Cantidad,
	CampaniaID)
	select  se.CUV,
			se.Cantidad,
			c.CampaniaID
	from ods.SuscripcionExclusivosSE se
	inner join ods.Campania c on se.Campania = c.Codigo
	where se.CodigoCliente = @CodigoConsultora

	select distinct
		p.CUV,
		p.IndicadorMontoMinimo,
		p.MarcaID,
		est.TipoEstrategiaID,
		coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo,
		coalesce(est.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		se.Cantidad
	from ods.ProductoComercial p
	inner join @tblSuscripcionSE se
		on  se.CampaniaID = P.CampaniaID AND se.CUV = p.CUV
	left join dbo.ProductoDescripcion pd
		on  p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc
		on  p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join MatrizComercial mc
		on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia est
		on EST.CampaniaID = p.AnoCampania
		and (est.CUV2 = p.CUV
			or est.CUV2 = (select CUVPadre from TallaColorCUV TCC where TCC.CUV = p.CUV)
		)
		and EST.Activo = 1
	left join dbo.TallaColorCUV tcc
		on tcc.CUV = p.CUV
		and tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID


SET NOCOUNT OFF;
END


GO

GO
USE BelcorpPuertoRico
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetCuvSuscripcionSE] AS'
END
GO

ALTER PROCEDURE [dbo].[GetCuvSuscripcionSE]
	@CampaniaID int,
	@CodigoConsultora varchar(25)

AS
BEGIN
SET NOCOUNT ON;

	declare @tblSuscripcionSE table
	(
		CUV varchar(6),
		Cantidad int,
		CampaniaID int
	)

	insert into @tblSuscripcionSE
	(CUV,
	Cantidad,
	CampaniaID)
	select  se.CUV,
			se.Cantidad,
			c.CampaniaID
	from ods.SuscripcionExclusivosSE se
	inner join ods.Campania c on se.Campania = c.Codigo
	where se.CodigoCliente = @CodigoConsultora

	select distinct
		p.CUV,
		p.IndicadorMontoMinimo,
		p.MarcaID,
		est.TipoEstrategiaID,
		coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo,
		coalesce(est.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		se.Cantidad
	from ods.ProductoComercial p
	inner join @tblSuscripcionSE se
		on  se.CampaniaID = P.CampaniaID AND se.CUV = p.CUV
	left join dbo.ProductoDescripcion pd
		on  p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc
		on  p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join MatrizComercial mc
		on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia est
		on EST.CampaniaID = p.AnoCampania
		and (est.CUV2 = p.CUV
			or est.CUV2 = (select CUVPadre from TallaColorCUV TCC where TCC.CUV = p.CUV)
		)
		and EST.Activo = 1
	left join dbo.TallaColorCUV tcc
		on tcc.CUV = p.CUV
		and tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID


SET NOCOUNT OFF;
END


GO

GO
USE BelcorpPanama
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetCuvSuscripcionSE] AS'
END
GO

ALTER PROCEDURE [dbo].[GetCuvSuscripcionSE]
	@CampaniaID int,
	@CodigoConsultora varchar(25)

AS
BEGIN
SET NOCOUNT ON;

	declare @tblSuscripcionSE table
	(
		CUV varchar(6),
		Cantidad int,
		CampaniaID int
	)

	insert into @tblSuscripcionSE
	(CUV,
	Cantidad,
	CampaniaID)
	select  se.CUV,
			se.Cantidad,
			c.CampaniaID
	from ods.SuscripcionExclusivosSE se
	inner join ods.Campania c on se.Campania = c.Codigo
	where se.CodigoCliente = @CodigoConsultora

	select distinct
		p.CUV,
		p.IndicadorMontoMinimo,
		p.MarcaID,
		est.TipoEstrategiaID,
		coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo,
		coalesce(est.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		se.Cantidad
	from ods.ProductoComercial p
	inner join @tblSuscripcionSE se
		on  se.CampaniaID = P.CampaniaID AND se.CUV = p.CUV
	left join dbo.ProductoDescripcion pd
		on  p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc
		on  p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join MatrizComercial mc
		on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia est
		on EST.CampaniaID = p.AnoCampania
		and (est.CUV2 = p.CUV
			or est.CUV2 = (select CUVPadre from TallaColorCUV TCC where TCC.CUV = p.CUV)
		)
		and EST.Activo = 1
	left join dbo.TallaColorCUV tcc
		on tcc.CUV = p.CUV
		and tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID


SET NOCOUNT OFF;
END


GO

GO
USE BelcorpGuatemala
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetCuvSuscripcionSE] AS'
END
GO

ALTER PROCEDURE [dbo].[GetCuvSuscripcionSE]
	@CampaniaID int,
	@CodigoConsultora varchar(25)

AS
BEGIN
SET NOCOUNT ON;

	declare @tblSuscripcionSE table
	(
		CUV varchar(6),
		Cantidad int,
		CampaniaID int
	)

	insert into @tblSuscripcionSE
	(CUV,
	Cantidad,
	CampaniaID)
	select  se.CUV,
			se.Cantidad,
			c.CampaniaID
	from ods.SuscripcionExclusivosSE se
	inner join ods.Campania c on se.Campania = c.Codigo
	where se.CodigoCliente = @CodigoConsultora

	select distinct
		p.CUV,
		p.IndicadorMontoMinimo,
		p.MarcaID,
		est.TipoEstrategiaID,
		coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo,
		coalesce(est.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		se.Cantidad
	from ods.ProductoComercial p
	inner join @tblSuscripcionSE se
		on  se.CampaniaID = P.CampaniaID AND se.CUV = p.CUV
	left join dbo.ProductoDescripcion pd
		on  p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc
		on  p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join MatrizComercial mc
		on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia est
		on EST.CampaniaID = p.AnoCampania
		and (est.CUV2 = p.CUV
			or est.CUV2 = (select CUVPadre from TallaColorCUV TCC where TCC.CUV = p.CUV)
		)
		and EST.Activo = 1
	left join dbo.TallaColorCUV tcc
		on tcc.CUV = p.CUV
		and tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID


SET NOCOUNT OFF;
END


GO

GO
USE BelcorpEcuador
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetCuvSuscripcionSE] AS'
END
GO

ALTER PROCEDURE [dbo].[GetCuvSuscripcionSE]
	@CampaniaID int,
	@CodigoConsultora varchar(25)

AS
BEGIN
SET NOCOUNT ON;

	declare @tblSuscripcionSE table
	(
		CUV varchar(6),
		Cantidad int,
		CampaniaID int
	)

	insert into @tblSuscripcionSE
	(CUV,
	Cantidad,
	CampaniaID)
	select  se.CUV,
			se.Cantidad,
			c.CampaniaID
	from ods.SuscripcionExclusivosSE se
	inner join ods.Campania c on se.Campania = c.Codigo
	where se.CodigoCliente = @CodigoConsultora

	select distinct
		p.CUV,
		p.IndicadorMontoMinimo,
		p.MarcaID,
		est.TipoEstrategiaID,
		coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo,
		coalesce(est.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		se.Cantidad
	from ods.ProductoComercial p
	inner join @tblSuscripcionSE se
		on  se.CampaniaID = P.CampaniaID AND se.CUV = p.CUV
	left join dbo.ProductoDescripcion pd
		on  p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc
		on  p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join MatrizComercial mc
		on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia est
		on EST.CampaniaID = p.AnoCampania
		and (est.CUV2 = p.CUV
			or est.CUV2 = (select CUVPadre from TallaColorCUV TCC where TCC.CUV = p.CUV)
		)
		and EST.Activo = 1
	left join dbo.TallaColorCUV tcc
		on tcc.CUV = p.CUV
		and tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID


SET NOCOUNT OFF;
END


GO

GO
USE BelcorpDominicana
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetCuvSuscripcionSE] AS'
END
GO

ALTER PROCEDURE [dbo].[GetCuvSuscripcionSE]
	@CampaniaID int,
	@CodigoConsultora varchar(25)

AS
BEGIN
SET NOCOUNT ON;

	declare @tblSuscripcionSE table
	(
		CUV varchar(6),
		Cantidad int,
		CampaniaID int
	)

	insert into @tblSuscripcionSE
	(CUV,
	Cantidad,
	CampaniaID)
	select  se.CUV,
			se.Cantidad,
			c.CampaniaID
	from ods.SuscripcionExclusivosSE se
	inner join ods.Campania c on se.Campania = c.Codigo
	where se.CodigoCliente = @CodigoConsultora

	select distinct
		p.CUV,
		p.IndicadorMontoMinimo,
		p.MarcaID,
		est.TipoEstrategiaID,
		coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo,
		coalesce(est.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		se.Cantidad
	from ods.ProductoComercial p
	inner join @tblSuscripcionSE se
		on  se.CampaniaID = P.CampaniaID AND se.CUV = p.CUV
	left join dbo.ProductoDescripcion pd
		on  p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc
		on  p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join MatrizComercial mc
		on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia est
		on EST.CampaniaID = p.AnoCampania
		and (est.CUV2 = p.CUV
			or est.CUV2 = (select CUVPadre from TallaColorCUV TCC where TCC.CUV = p.CUV)
		)
		and EST.Activo = 1
	left join dbo.TallaColorCUV tcc
		on tcc.CUV = p.CUV
		and tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID


SET NOCOUNT OFF;
END


GO

GO
USE BelcorpCostaRica
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetCuvSuscripcionSE] AS'
END
GO

ALTER PROCEDURE [dbo].[GetCuvSuscripcionSE]
	@CampaniaID int,
	@CodigoConsultora varchar(25)

AS
BEGIN
SET NOCOUNT ON;

	declare @tblSuscripcionSE table
	(
		CUV varchar(6),
		Cantidad int,
		CampaniaID int
	)

	insert into @tblSuscripcionSE
	(CUV,
	Cantidad,
	CampaniaID)
	select  se.CUV,
			se.Cantidad,
			c.CampaniaID
	from ods.SuscripcionExclusivosSE se
	inner join ods.Campania c on se.Campania = c.Codigo
	where se.CodigoCliente = @CodigoConsultora

	select distinct
		p.CUV,
		p.IndicadorMontoMinimo,
		p.MarcaID,
		est.TipoEstrategiaID,
		coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo,
		coalesce(est.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		se.Cantidad
	from ods.ProductoComercial p
	inner join @tblSuscripcionSE se
		on  se.CampaniaID = P.CampaniaID AND se.CUV = p.CUV
	left join dbo.ProductoDescripcion pd
		on  p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc
		on  p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join MatrizComercial mc
		on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia est
		on EST.CampaniaID = p.AnoCampania
		and (est.CUV2 = p.CUV
			or est.CUV2 = (select CUVPadre from TallaColorCUV TCC where TCC.CUV = p.CUV)
		)
		and EST.Activo = 1
	left join dbo.TallaColorCUV tcc
		on tcc.CUV = p.CUV
		and tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID


SET NOCOUNT OFF;
END


GO

GO
USE BelcorpChile
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetCuvSuscripcionSE] AS'
END
GO

ALTER PROCEDURE [dbo].[GetCuvSuscripcionSE]
	@CampaniaID int,
	@CodigoConsultora varchar(25)

AS
BEGIN
SET NOCOUNT ON;

	declare @tblSuscripcionSE table
	(
		CUV varchar(6),
		Cantidad int,
		CampaniaID int
	)

	insert into @tblSuscripcionSE
	(CUV,
	Cantidad,
	CampaniaID)
	select  se.CUV,
			se.Cantidad,
			c.CampaniaID
	from ods.SuscripcionExclusivosSE se
	inner join ods.Campania c on se.Campania = c.Codigo
	where se.CodigoCliente = @CodigoConsultora

	select distinct
		p.CUV,
		p.IndicadorMontoMinimo,
		p.MarcaID,
		est.TipoEstrategiaID,
		coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo,
		coalesce(est.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		se.Cantidad
	from ods.ProductoComercial p
	inner join @tblSuscripcionSE se
		on  se.CampaniaID = P.CampaniaID AND se.CUV = p.CUV
	left join dbo.ProductoDescripcion pd
		on  p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc
		on  p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join MatrizComercial mc
		on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia est
		on EST.CampaniaID = p.AnoCampania
		and (est.CUV2 = p.CUV
			or est.CUV2 = (select CUVPadre from TallaColorCUV TCC where TCC.CUV = p.CUV)
		)
		and EST.Activo = 1
	left join dbo.TallaColorCUV tcc
		on tcc.CUV = p.CUV
		and tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID


SET NOCOUNT OFF;
END


GO

GO
USE BelcorpBolivia
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetCuvSuscripcionSE] AS'
END
GO

ALTER PROCEDURE [dbo].[GetCuvSuscripcionSE]
	@CampaniaID int,
	@CodigoConsultora varchar(25)

AS
BEGIN
SET NOCOUNT ON;

	declare @tblSuscripcionSE table
	(
		CUV varchar(6),
		Cantidad int,
		CampaniaID int
	)

	insert into @tblSuscripcionSE
	(CUV,
	Cantidad,
	CampaniaID)
	select  se.CUV,
			se.Cantidad,
			c.CampaniaID
	from ods.SuscripcionExclusivosSE se
	inner join ods.Campania c on se.Campania = c.Codigo
	where se.CodigoCliente = @CodigoConsultora

	select distinct
		p.CUV,
		p.IndicadorMontoMinimo,
		p.MarcaID,
		est.TipoEstrategiaID,
		coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo,
		coalesce(est.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		se.Cantidad
	from ods.ProductoComercial p
	inner join @tblSuscripcionSE se
		on  se.CampaniaID = P.CampaniaID AND se.CUV = p.CUV
	left join dbo.ProductoDescripcion pd
		on  p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join ProductoComercialConfiguracion pcc
		on  p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join MatrizComercial mc
		on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia est
		on EST.CampaniaID = p.AnoCampania
		and (est.CUV2 = p.CUV
			or est.CUV2 = (select CUVPadre from TallaColorCUV TCC where TCC.CUV = p.CUV)
		)
		and EST.Activo = 1
	left join dbo.TallaColorCUV tcc
		on tcc.CUV = p.CUV
		and tcc.CampaniaID = p.AnoCampania
	where p.AnoCampania = @CampaniaID


SET NOCOUNT OFF;
END


GO

GO
