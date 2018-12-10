USE BelcorpBolivia
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(
	@Campania varchar(6),
	@Cuv varchar(6)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor
	from ods.GestionStock with(nolock)
	where
		CodPeriodo = @Campania and CodVenta = @Cuv and
		CodRegion is null and CodZona is null

	return @limMax;
END
GO
/*end*/

USE BelcorpChile
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(
	@Campania varchar(6),
	@Cuv varchar(6)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor
	from ods.GestionStock with(nolock)
	where
		CodPeriodo = @Campania and CodVenta = @Cuv and
		CodRegion is null and CodZona is null

	return @limMax;
END
GO
/*end*/

USE BelcorpColombia
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(
	@Campania varchar(6),
	@Cuv varchar(6)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor
	from ods.GestionStock with(nolock)
	where
		CodPeriodo = @Campania and CodVenta = @Cuv and
		CodRegion is null and CodZona is null

	return @limMax;
END
GO
/*end*/

USE BelcorpCostaRica
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(
	@Campania varchar(6),
	@Cuv varchar(6)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor
	from ods.GestionStock with(nolock)
	where
		CodPeriodo = @Campania and CodVenta = @Cuv and
		CodRegion is null and CodZona is null

	return @limMax;
END
GO
/*end*/

USE BelcorpDominicana
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(
	@Campania varchar(6),
	@Cuv varchar(6)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor
	from ods.GestionStock with(nolock)
	where
		CodPeriodo = @Campania and CodVenta = @Cuv and
		CodRegion is null and CodZona is null

	return @limMax;
END
GO
/*end*/

USE BelcorpEcuador
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(
	@Campania varchar(6),
	@Cuv varchar(6)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor
	from ods.GestionStock with(nolock)
	where
		CodPeriodo = @Campania and CodVenta = @Cuv and
		CodRegion is null and CodZona is null

	return @limMax;
END
GO
/*end*/

USE BelcorpGuatemala
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(
	@Campania varchar(6),
	@Cuv varchar(6)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor
	from ods.GestionStock with(nolock)
	where
		CodPeriodo = @Campania and CodVenta = @Cuv and
		CodRegion is null and CodZona is null

	return @limMax;
END
GO
/*end*/

USE BelcorpMexico
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(
	@Campania varchar(6),
	@Cuv varchar(6)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor
	from ods.GestionStock with(nolock)
	where
		CodPeriodo = @Campania and CodVenta = @Cuv and
		CodRegion is null and CodZona is null

	return @limMax;
END
GO
/*end*/

USE BelcorpPanama
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(
	@Campania varchar(6),
	@Cuv varchar(6)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor
	from ods.GestionStock with(nolock)
	where
		CodPeriodo = @Campania and CodVenta = @Cuv and
		CodRegion is null and CodZona is null

	return @limMax;
END
GO
/*end*/

USE BelcorpPeru
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(
	@Campania varchar(6),
	@Cuv varchar(6)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor
	from ods.GestionStock with(nolock)
	where
		CodPeriodo = @Campania and CodVenta = @Cuv and
		CodRegion is null and CodZona is null

	return @limMax;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(
	@Campania varchar(6),
	@Cuv varchar(6)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor
	from ods.GestionStock with(nolock)
	where
		CodPeriodo = @Campania and CodVenta = @Cuv and
		CodRegion is null and CodZona is null

	return @limMax;
END
GO
/*end*/

USE BelcorpSalvador
GO
if object_id('dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais') IS NOT NULL
	DROP FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais
GO
CREATE FUNCTION dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(
	@Campania varchar(6),
	@Cuv varchar(6)
)
RETURNS INT
AS
BEGIN
	declare @limMax int = -1;

	select top 1 @limMax = Valor
	from ods.GestionStock with(nolock)
	where
		CodPeriodo = @Campania and CodVenta = @Cuv and
		CodRegion is null and CodZona is null

	return @limMax;
END
GO