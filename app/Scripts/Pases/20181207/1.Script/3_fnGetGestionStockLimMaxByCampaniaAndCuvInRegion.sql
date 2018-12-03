USE BelcorpBolivia
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor_LM
	from ods.GESTION_STOCK
	where
		Cod_Periodo = @Campania and Cod_Venta = @Cuv and
		Cod_Region = @CodigoRegion and Cod_Zona is null

	return @limMax;
END
GO

USE BelcorpChile
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor_LM
	from ods.GESTION_STOCK
	where
		Cod_Periodo = @Campania and Cod_Venta = @Cuv and
		Cod_Region = @CodigoRegion and Cod_Zona is null

	return @limMax;
END
GO

USE BelcorpColombia
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor_LM
	from ods.GESTION_STOCK
	where
		Cod_Periodo = @Campania and Cod_Venta = @Cuv and
		Cod_Region = @CodigoRegion and Cod_Zona is null

	return @limMax;
END
GO

USE BelcorpCostaRica
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor_LM
	from ods.GESTION_STOCK
	where
		Cod_Periodo = @Campania and Cod_Venta = @Cuv and
		Cod_Region = @CodigoRegion and Cod_Zona is null

	return @limMax;
END
GO

USE BelcorpDominicana
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor_LM
	from ods.GESTION_STOCK
	where
		Cod_Periodo = @Campania and Cod_Venta = @Cuv and
		Cod_Region = @CodigoRegion and Cod_Zona is null

	return @limMax;
END
GO

USE BelcorpEcuador
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor_LM
	from ods.GESTION_STOCK
	where
		Cod_Periodo = @Campania and Cod_Venta = @Cuv and
		Cod_Region = @CodigoRegion and Cod_Zona is null

	return @limMax;
END
GO

USE BelcorpGuatemala
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor_LM
	from ods.GESTION_STOCK
	where
		Cod_Periodo = @Campania and Cod_Venta = @Cuv and
		Cod_Region = @CodigoRegion and Cod_Zona is null

	return @limMax;
END
GO

USE BelcorpMexico
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor_LM
	from ods.GESTION_STOCK
	where
		Cod_Periodo = @Campania and Cod_Venta = @Cuv and
		Cod_Region = @CodigoRegion and Cod_Zona is null

	return @limMax;
END
GO

USE BelcorpPanama
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor_LM
	from ods.GESTION_STOCK
	where
		Cod_Periodo = @Campania and Cod_Venta = @Cuv and
		Cod_Region = @CodigoRegion and Cod_Zona is null

	return @limMax;
END
GO

USE BelcorpPeru
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor_LM
	from ods.GESTION_STOCK
	where
		Cod_Periodo = @Campania and Cod_Venta = @Cuv and
		Cod_Region = @CodigoRegion and Cod_Zona is null

	return @limMax;
END
GO

USE BelcorpPuertoRico
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor_LM
	from ods.GESTION_STOCK
	where
		Cod_Periodo = @Campania and Cod_Venta = @Cuv and
		Cod_Region = @CodigoRegion and Cod_Zona is null

	return @limMax;
END
GO

USE BelcorpSalvador
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor_LM
	from ods.GESTION_STOCK
	where
		Cod_Periodo = @Campania and Cod_Venta = @Cuv and
		Cod_Region = @CodigoRegion and Cod_Zona is null

	return @limMax;
END
GO