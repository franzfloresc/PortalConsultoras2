USE BelcorpPeru
GO

IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 98)
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion) VALUES (98, 'Plan 20 - Activación')
END

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 9802)
BEGIN
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) VALUES (9802, 98, '2017XX', 'OPT Tonos')
END

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.EstrategiaProducto')) = 0
 begin

CREATE TABLE [dbo].[EstrategiaProducto](
	[EstrategiaProductoId] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaId] int NOT null,
	[Campania] [int] NOT NULL,
	[CUV] [nvarchar](20) NOT NULL,
	[CodigoEstrategia] [nvarchar](100) NOT NULL,
	[Grupo] [nvarchar](20) NULL,
	[Orden] int NULL,
	[CUV2] [nvarchar](20) NULL,
	[SAP] [nvarchar](50) NULL,
	[Cantidad] INT NULL,
	[Precio] MONEY NULL,
	[PrecioValorizado] MONEY NULL,
	[Digitable] int NULL,
	[CodigoError] [nvarchar](100) NULL,
	[CodigoErrorObs] [nvarchar](4000) NULL
)

end
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Estrategia') and SYSCOLUMNS.NAME = N'CodigoEstrategia') = 0
	ALTER TABLE dbo.Estrategia ADD CodigoEstrategia varchar(100)
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertEstrategiaProducto
GO

CREATE PROCEDURE dbo.InsertEstrategiaProducto
	@Retorno int output
	,@EstrategiaProductoId int 
	,@EstrategiaId int
	,@Campania int
	,@CUV nvarchar(20)
	,@CodigoEstrategia nvarchar(100)
	,@Grupo nvarchar(20)
	,@Orden int
	,@CUV2 nvarchar(20)
	,@SAP nvarchar(50)
	,@Cantidad int
	,@Precio money
	,@PrecioValorizado money
	,@Digitable int
	,@CodigoError nvarchar(100)
	,@CodigoErrorObs nvarchar(4000)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
	
	set @existe = isnull(@existe, 0)

	-- select * from EstrategiaProducto
	if @existe = 0
	begin
			INSERT INTO EstrategiaProducto(
				EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
			)VALUES(
				@EstrategiaId
				,@Campania
				,@CUV
				,@CodigoEstrategia
				,@Grupo
				,@Orden
				,@CUV2
				,@SAP
				,@Cantidad
				,@Precio
				,@PrecioValorizado
				,@Digitable
				,@CodigoError
				,@CodigoErrorObs
			)

			set @Retorno = @@IDENTITY
	end
	else
	begin
		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end
go


GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEstrategiaProducto
GO

CREATE PROCEDURE dbo.GetEstrategiaProducto
	 @EstrategiaId int
AS
begin

	SELECT 
	 EstrategiaProductoId
	,EstrategiaId
	,Campania
	,CUV
	,CodigoEstrategia
	,Grupo
	,Orden
	,CUV2
	,SAP
	,Cantidad
	,Precio
	,PrecioValorizado
	,Digitable
	,CodigoError
	,CodigoErrorObs
	FROM EstrategiaProducto
	WHERE EstrategiaId = @EstrategiaId
	
end

GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.TipoEstrategia') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE dbo.TipoEstrategia ADD Codigo varchar(100)
go


go



ALTER PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion, sp.CodigoSap
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END

GO

/*end*/

USE BelcorpMexico
GO

IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 98)
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion) VALUES (98, 'Plan 20 - Activación')
END

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 9802)
BEGIN
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) VALUES (9802, 98, '2017XX', 'OPT Tonos')
END

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.EstrategiaProducto')) = 0
 begin

CREATE TABLE [dbo].[EstrategiaProducto](
	[EstrategiaProductoId] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaId] int NOT null,
	[Campania] [int] NOT NULL,
	[CUV] [nvarchar](20) NOT NULL,
	[CodigoEstrategia] [nvarchar](100) NOT NULL,
	[Grupo] [nvarchar](20) NULL,
	[Orden] int NULL,
	[CUV2] [nvarchar](20) NULL,
	[SAP] [nvarchar](50) NULL,
	[Cantidad] INT NULL,
	[Precio] MONEY NULL,
	[PrecioValorizado] MONEY NULL,
	[Digitable] int NULL,
	[CodigoError] [nvarchar](100) NULL,
	[CodigoErrorObs] [nvarchar](4000) NULL
)

end
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Estrategia') and SYSCOLUMNS.NAME = N'CodigoEstrategia') = 0
	ALTER TABLE dbo.Estrategia ADD CodigoEstrategia varchar(100)
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertEstrategiaProducto
GO

CREATE PROCEDURE dbo.InsertEstrategiaProducto
	@Retorno int output
	,@EstrategiaProductoId int 
	,@EstrategiaId int
	,@Campania int
	,@CUV nvarchar(20)
	,@CodigoEstrategia nvarchar(100)
	,@Grupo nvarchar(20)
	,@Orden int
	,@CUV2 nvarchar(20)
	,@SAP nvarchar(50)
	,@Cantidad int
	,@Precio money
	,@PrecioValorizado money
	,@Digitable int
	,@CodigoError nvarchar(100)
	,@CodigoErrorObs nvarchar(4000)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
	
	set @existe = isnull(@existe, 0)

	-- select * from EstrategiaProducto
	if @existe = 0
	begin
			INSERT INTO EstrategiaProducto(
				EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
			)VALUES(
				@EstrategiaId
				,@Campania
				,@CUV
				,@CodigoEstrategia
				,@Grupo
				,@Orden
				,@CUV2
				,@SAP
				,@Cantidad
				,@Precio
				,@PrecioValorizado
				,@Digitable
				,@CodigoError
				,@CodigoErrorObs
			)

			set @Retorno = @@IDENTITY
	end
	else
	begin
		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end
go


GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEstrategiaProducto
GO

CREATE PROCEDURE dbo.GetEstrategiaProducto
	 @EstrategiaId int
AS
begin

	SELECT 
	 EstrategiaProductoId
	,EstrategiaId
	,Campania
	,CUV
	,CodigoEstrategia
	,Grupo
	,Orden
	,CUV2
	,SAP
	,Cantidad
	,Precio
	,PrecioValorizado
	,Digitable
	,CodigoError
	,CodigoErrorObs
	FROM EstrategiaProducto
	WHERE EstrategiaId = @EstrategiaId
	
end

GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.TipoEstrategia') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE dbo.TipoEstrategia ADD Codigo varchar(100)
go


go



ALTER PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion, sp.CodigoSap
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END

GO

/*end*/

USE BelcorpColombia
GO

IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 98)
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion) VALUES (98, 'Plan 20 - Activación')
END

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 9802)
BEGIN
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) VALUES (9802, 98, '2017XX', 'OPT Tonos')
END

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.EstrategiaProducto')) = 0
 begin

CREATE TABLE [dbo].[EstrategiaProducto](
	[EstrategiaProductoId] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaId] int NOT null,
	[Campania] [int] NOT NULL,
	[CUV] [nvarchar](20) NOT NULL,
	[CodigoEstrategia] [nvarchar](100) NOT NULL,
	[Grupo] [nvarchar](20) NULL,
	[Orden] int NULL,
	[CUV2] [nvarchar](20) NULL,
	[SAP] [nvarchar](50) NULL,
	[Cantidad] INT NULL,
	[Precio] MONEY NULL,
	[PrecioValorizado] MONEY NULL,
	[Digitable] int NULL,
	[CodigoError] [nvarchar](100) NULL,
	[CodigoErrorObs] [nvarchar](4000) NULL
)

end
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Estrategia') and SYSCOLUMNS.NAME = N'CodigoEstrategia') = 0
	ALTER TABLE dbo.Estrategia ADD CodigoEstrategia varchar(100)
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertEstrategiaProducto
GO

CREATE PROCEDURE dbo.InsertEstrategiaProducto
	@Retorno int output
	,@EstrategiaProductoId int 
	,@EstrategiaId int
	,@Campania int
	,@CUV nvarchar(20)
	,@CodigoEstrategia nvarchar(100)
	,@Grupo nvarchar(20)
	,@Orden int
	,@CUV2 nvarchar(20)
	,@SAP nvarchar(50)
	,@Cantidad int
	,@Precio money
	,@PrecioValorizado money
	,@Digitable int
	,@CodigoError nvarchar(100)
	,@CodigoErrorObs nvarchar(4000)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
	
	set @existe = isnull(@existe, 0)

	-- select * from EstrategiaProducto
	if @existe = 0
	begin
			INSERT INTO EstrategiaProducto(
				EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
			)VALUES(
				@EstrategiaId
				,@Campania
				,@CUV
				,@CodigoEstrategia
				,@Grupo
				,@Orden
				,@CUV2
				,@SAP
				,@Cantidad
				,@Precio
				,@PrecioValorizado
				,@Digitable
				,@CodigoError
				,@CodigoErrorObs
			)

			set @Retorno = @@IDENTITY
	end
	else
	begin
		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end
go


GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEstrategiaProducto
GO

CREATE PROCEDURE dbo.GetEstrategiaProducto
	 @EstrategiaId int
AS
begin

	SELECT 
	 EstrategiaProductoId
	,EstrategiaId
	,Campania
	,CUV
	,CodigoEstrategia
	,Grupo
	,Orden
	,CUV2
	,SAP
	,Cantidad
	,Precio
	,PrecioValorizado
	,Digitable
	,CodigoError
	,CodigoErrorObs
	FROM EstrategiaProducto
	WHERE EstrategiaId = @EstrategiaId
	
end

GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.TipoEstrategia') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE dbo.TipoEstrategia ADD Codigo varchar(100)
go


go



ALTER PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion, sp.CodigoSap
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END

GO

/*end*/

USE BelcorpVenezuela
GO

IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 98)
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion) VALUES (98, 'Plan 20 - Activación')
END

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 9802)
BEGIN
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) VALUES (9802, 98, '2017XX', 'OPT Tonos')
END

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.EstrategiaProducto')) = 0
 begin

CREATE TABLE [dbo].[EstrategiaProducto](
	[EstrategiaProductoId] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaId] int NOT null,
	[Campania] [int] NOT NULL,
	[CUV] [nvarchar](20) NOT NULL,
	[CodigoEstrategia] [nvarchar](100) NOT NULL,
	[Grupo] [nvarchar](20) NULL,
	[Orden] int NULL,
	[CUV2] [nvarchar](20) NULL,
	[SAP] [nvarchar](50) NULL,
	[Cantidad] INT NULL,
	[Precio] MONEY NULL,
	[PrecioValorizado] MONEY NULL,
	[Digitable] int NULL,
	[CodigoError] [nvarchar](100) NULL,
	[CodigoErrorObs] [nvarchar](4000) NULL
)

end
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Estrategia') and SYSCOLUMNS.NAME = N'CodigoEstrategia') = 0
	ALTER TABLE dbo.Estrategia ADD CodigoEstrategia varchar(100)
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertEstrategiaProducto
GO

CREATE PROCEDURE dbo.InsertEstrategiaProducto
	@Retorno int output
	,@EstrategiaProductoId int 
	,@EstrategiaId int
	,@Campania int
	,@CUV nvarchar(20)
	,@CodigoEstrategia nvarchar(100)
	,@Grupo nvarchar(20)
	,@Orden int
	,@CUV2 nvarchar(20)
	,@SAP nvarchar(50)
	,@Cantidad int
	,@Precio money
	,@PrecioValorizado money
	,@Digitable int
	,@CodigoError nvarchar(100)
	,@CodigoErrorObs nvarchar(4000)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
	
	set @existe = isnull(@existe, 0)

	-- select * from EstrategiaProducto
	if @existe = 0
	begin
			INSERT INTO EstrategiaProducto(
				EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
			)VALUES(
				@EstrategiaId
				,@Campania
				,@CUV
				,@CodigoEstrategia
				,@Grupo
				,@Orden
				,@CUV2
				,@SAP
				,@Cantidad
				,@Precio
				,@PrecioValorizado
				,@Digitable
				,@CodigoError
				,@CodigoErrorObs
			)

			set @Retorno = @@IDENTITY
	end
	else
	begin
		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end
go


GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEstrategiaProducto
GO

CREATE PROCEDURE dbo.GetEstrategiaProducto
	 @EstrategiaId int
AS
begin

	SELECT 
	 EstrategiaProductoId
	,EstrategiaId
	,Campania
	,CUV
	,CodigoEstrategia
	,Grupo
	,Orden
	,CUV2
	,SAP
	,Cantidad
	,Precio
	,PrecioValorizado
	,Digitable
	,CodigoError
	,CodigoErrorObs
	FROM EstrategiaProducto
	WHERE EstrategiaId = @EstrategiaId
	
end

GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.TipoEstrategia') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE dbo.TipoEstrategia ADD Codigo varchar(100)
go


go



ALTER PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion, sp.CodigoSap
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END

GO

/*end*/

USE BelcorpSalvador
GO

IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 98)
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion) VALUES (98, 'Plan 20 - Activación')
END

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 9802)
BEGIN
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) VALUES (9802, 98, '2017XX', 'OPT Tonos')
END

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.EstrategiaProducto')) = 0
 begin

CREATE TABLE [dbo].[EstrategiaProducto](
	[EstrategiaProductoId] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaId] int NOT null,
	[Campania] [int] NOT NULL,
	[CUV] [nvarchar](20) NOT NULL,
	[CodigoEstrategia] [nvarchar](100) NOT NULL,
	[Grupo] [nvarchar](20) NULL,
	[Orden] int NULL,
	[CUV2] [nvarchar](20) NULL,
	[SAP] [nvarchar](50) NULL,
	[Cantidad] INT NULL,
	[Precio] MONEY NULL,
	[PrecioValorizado] MONEY NULL,
	[Digitable] int NULL,
	[CodigoError] [nvarchar](100) NULL,
	[CodigoErrorObs] [nvarchar](4000) NULL
)

end
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Estrategia') and SYSCOLUMNS.NAME = N'CodigoEstrategia') = 0
	ALTER TABLE dbo.Estrategia ADD CodigoEstrategia varchar(100)
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertEstrategiaProducto
GO

CREATE PROCEDURE dbo.InsertEstrategiaProducto
	@Retorno int output
	,@EstrategiaProductoId int 
	,@EstrategiaId int
	,@Campania int
	,@CUV nvarchar(20)
	,@CodigoEstrategia nvarchar(100)
	,@Grupo nvarchar(20)
	,@Orden int
	,@CUV2 nvarchar(20)
	,@SAP nvarchar(50)
	,@Cantidad int
	,@Precio money
	,@PrecioValorizado money
	,@Digitable int
	,@CodigoError nvarchar(100)
	,@CodigoErrorObs nvarchar(4000)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
	
	set @existe = isnull(@existe, 0)

	-- select * from EstrategiaProducto
	if @existe = 0
	begin
			INSERT INTO EstrategiaProducto(
				EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
			)VALUES(
				@EstrategiaId
				,@Campania
				,@CUV
				,@CodigoEstrategia
				,@Grupo
				,@Orden
				,@CUV2
				,@SAP
				,@Cantidad
				,@Precio
				,@PrecioValorizado
				,@Digitable
				,@CodigoError
				,@CodigoErrorObs
			)

			set @Retorno = @@IDENTITY
	end
	else
	begin
		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end
go


GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEstrategiaProducto
GO

CREATE PROCEDURE dbo.GetEstrategiaProducto
	 @EstrategiaId int
AS
begin

	SELECT 
	 EstrategiaProductoId
	,EstrategiaId
	,Campania
	,CUV
	,CodigoEstrategia
	,Grupo
	,Orden
	,CUV2
	,SAP
	,Cantidad
	,Precio
	,PrecioValorizado
	,Digitable
	,CodigoError
	,CodigoErrorObs
	FROM EstrategiaProducto
	WHERE EstrategiaId = @EstrategiaId
	
end

GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.TipoEstrategia') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE dbo.TipoEstrategia ADD Codigo varchar(100)
go


go



ALTER PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion, sp.CodigoSap
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END

GO

/*end*/

USE BelcorpPuertoRico
GO

IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 98)
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion) VALUES (98, 'Plan 20 - Activación')
END

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 9802)
BEGIN
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) VALUES (9802, 98, '2017XX', 'OPT Tonos')
END

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.EstrategiaProducto')) = 0
 begin

CREATE TABLE [dbo].[EstrategiaProducto](
	[EstrategiaProductoId] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaId] int NOT null,
	[Campania] [int] NOT NULL,
	[CUV] [nvarchar](20) NOT NULL,
	[CodigoEstrategia] [nvarchar](100) NOT NULL,
	[Grupo] [nvarchar](20) NULL,
	[Orden] int NULL,
	[CUV2] [nvarchar](20) NULL,
	[SAP] [nvarchar](50) NULL,
	[Cantidad] INT NULL,
	[Precio] MONEY NULL,
	[PrecioValorizado] MONEY NULL,
	[Digitable] int NULL,
	[CodigoError] [nvarchar](100) NULL,
	[CodigoErrorObs] [nvarchar](4000) NULL
)

end
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Estrategia') and SYSCOLUMNS.NAME = N'CodigoEstrategia') = 0
	ALTER TABLE dbo.Estrategia ADD CodigoEstrategia varchar(100)
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertEstrategiaProducto
GO

CREATE PROCEDURE dbo.InsertEstrategiaProducto
	@Retorno int output
	,@EstrategiaProductoId int 
	,@EstrategiaId int
	,@Campania int
	,@CUV nvarchar(20)
	,@CodigoEstrategia nvarchar(100)
	,@Grupo nvarchar(20)
	,@Orden int
	,@CUV2 nvarchar(20)
	,@SAP nvarchar(50)
	,@Cantidad int
	,@Precio money
	,@PrecioValorizado money
	,@Digitable int
	,@CodigoError nvarchar(100)
	,@CodigoErrorObs nvarchar(4000)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
	
	set @existe = isnull(@existe, 0)

	-- select * from EstrategiaProducto
	if @existe = 0
	begin
			INSERT INTO EstrategiaProducto(
				EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
			)VALUES(
				@EstrategiaId
				,@Campania
				,@CUV
				,@CodigoEstrategia
				,@Grupo
				,@Orden
				,@CUV2
				,@SAP
				,@Cantidad
				,@Precio
				,@PrecioValorizado
				,@Digitable
				,@CodigoError
				,@CodigoErrorObs
			)

			set @Retorno = @@IDENTITY
	end
	else
	begin
		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end
go


GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEstrategiaProducto
GO

CREATE PROCEDURE dbo.GetEstrategiaProducto
	 @EstrategiaId int
AS
begin

	SELECT 
	 EstrategiaProductoId
	,EstrategiaId
	,Campania
	,CUV
	,CodigoEstrategia
	,Grupo
	,Orden
	,CUV2
	,SAP
	,Cantidad
	,Precio
	,PrecioValorizado
	,Digitable
	,CodigoError
	,CodigoErrorObs
	FROM EstrategiaProducto
	WHERE EstrategiaId = @EstrategiaId
	
end

GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.TipoEstrategia') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE dbo.TipoEstrategia ADD Codigo varchar(100)
go


go



ALTER PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion, sp.CodigoSap
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END

GO

/*end*/

USE BelcorpPanama
GO

IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 98)
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion) VALUES (98, 'Plan 20 - Activación')
END

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 9802)
BEGIN
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) VALUES (9802, 98, '2017XX', 'OPT Tonos')
END

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.EstrategiaProducto')) = 0
 begin

CREATE TABLE [dbo].[EstrategiaProducto](
	[EstrategiaProductoId] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaId] int NOT null,
	[Campania] [int] NOT NULL,
	[CUV] [nvarchar](20) NOT NULL,
	[CodigoEstrategia] [nvarchar](100) NOT NULL,
	[Grupo] [nvarchar](20) NULL,
	[Orden] int NULL,
	[CUV2] [nvarchar](20) NULL,
	[SAP] [nvarchar](50) NULL,
	[Cantidad] INT NULL,
	[Precio] MONEY NULL,
	[PrecioValorizado] MONEY NULL,
	[Digitable] int NULL,
	[CodigoError] [nvarchar](100) NULL,
	[CodigoErrorObs] [nvarchar](4000) NULL
)

end
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Estrategia') and SYSCOLUMNS.NAME = N'CodigoEstrategia') = 0
	ALTER TABLE dbo.Estrategia ADD CodigoEstrategia varchar(100)
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertEstrategiaProducto
GO

CREATE PROCEDURE dbo.InsertEstrategiaProducto
	@Retorno int output
	,@EstrategiaProductoId int 
	,@EstrategiaId int
	,@Campania int
	,@CUV nvarchar(20)
	,@CodigoEstrategia nvarchar(100)
	,@Grupo nvarchar(20)
	,@Orden int
	,@CUV2 nvarchar(20)
	,@SAP nvarchar(50)
	,@Cantidad int
	,@Precio money
	,@PrecioValorizado money
	,@Digitable int
	,@CodigoError nvarchar(100)
	,@CodigoErrorObs nvarchar(4000)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
	
	set @existe = isnull(@existe, 0)

	-- select * from EstrategiaProducto
	if @existe = 0
	begin
			INSERT INTO EstrategiaProducto(
				EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
			)VALUES(
				@EstrategiaId
				,@Campania
				,@CUV
				,@CodigoEstrategia
				,@Grupo
				,@Orden
				,@CUV2
				,@SAP
				,@Cantidad
				,@Precio
				,@PrecioValorizado
				,@Digitable
				,@CodigoError
				,@CodigoErrorObs
			)

			set @Retorno = @@IDENTITY
	end
	else
	begin
		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end
go


GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEstrategiaProducto
GO

CREATE PROCEDURE dbo.GetEstrategiaProducto
	 @EstrategiaId int
AS
begin

	SELECT 
	 EstrategiaProductoId
	,EstrategiaId
	,Campania
	,CUV
	,CodigoEstrategia
	,Grupo
	,Orden
	,CUV2
	,SAP
	,Cantidad
	,Precio
	,PrecioValorizado
	,Digitable
	,CodigoError
	,CodigoErrorObs
	FROM EstrategiaProducto
	WHERE EstrategiaId = @EstrategiaId
	
end

GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.TipoEstrategia') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE dbo.TipoEstrategia ADD Codigo varchar(100)
go


go



ALTER PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion, sp.CodigoSap
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END

GO

/*end*/

USE BelcorpGuatemala
GO

IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 98)
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion) VALUES (98, 'Plan 20 - Activación')
END

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 9802)
BEGIN
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) VALUES (9802, 98, '2017XX', 'OPT Tonos')
END

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.EstrategiaProducto')) = 0
 begin

CREATE TABLE [dbo].[EstrategiaProducto](
	[EstrategiaProductoId] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaId] int NOT null,
	[Campania] [int] NOT NULL,
	[CUV] [nvarchar](20) NOT NULL,
	[CodigoEstrategia] [nvarchar](100) NOT NULL,
	[Grupo] [nvarchar](20) NULL,
	[Orden] int NULL,
	[CUV2] [nvarchar](20) NULL,
	[SAP] [nvarchar](50) NULL,
	[Cantidad] INT NULL,
	[Precio] MONEY NULL,
	[PrecioValorizado] MONEY NULL,
	[Digitable] int NULL,
	[CodigoError] [nvarchar](100) NULL,
	[CodigoErrorObs] [nvarchar](4000) NULL
)

end
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Estrategia') and SYSCOLUMNS.NAME = N'CodigoEstrategia') = 0
	ALTER TABLE dbo.Estrategia ADD CodigoEstrategia varchar(100)
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertEstrategiaProducto
GO

CREATE PROCEDURE dbo.InsertEstrategiaProducto
	@Retorno int output
	,@EstrategiaProductoId int 
	,@EstrategiaId int
	,@Campania int
	,@CUV nvarchar(20)
	,@CodigoEstrategia nvarchar(100)
	,@Grupo nvarchar(20)
	,@Orden int
	,@CUV2 nvarchar(20)
	,@SAP nvarchar(50)
	,@Cantidad int
	,@Precio money
	,@PrecioValorizado money
	,@Digitable int
	,@CodigoError nvarchar(100)
	,@CodigoErrorObs nvarchar(4000)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
	
	set @existe = isnull(@existe, 0)

	-- select * from EstrategiaProducto
	if @existe = 0
	begin
			INSERT INTO EstrategiaProducto(
				EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
			)VALUES(
				@EstrategiaId
				,@Campania
				,@CUV
				,@CodigoEstrategia
				,@Grupo
				,@Orden
				,@CUV2
				,@SAP
				,@Cantidad
				,@Precio
				,@PrecioValorizado
				,@Digitable
				,@CodigoError
				,@CodigoErrorObs
			)

			set @Retorno = @@IDENTITY
	end
	else
	begin
		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end
go


GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEstrategiaProducto
GO

CREATE PROCEDURE dbo.GetEstrategiaProducto
	 @EstrategiaId int
AS
begin

	SELECT 
	 EstrategiaProductoId
	,EstrategiaId
	,Campania
	,CUV
	,CodigoEstrategia
	,Grupo
	,Orden
	,CUV2
	,SAP
	,Cantidad
	,Precio
	,PrecioValorizado
	,Digitable
	,CodigoError
	,CodigoErrorObs
	FROM EstrategiaProducto
	WHERE EstrategiaId = @EstrategiaId
	
end

GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.TipoEstrategia') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE dbo.TipoEstrategia ADD Codigo varchar(100)
go


go



ALTER PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion, sp.CodigoSap
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END

GO

/*end*/

USE BelcorpEcuador
GO

IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 98)
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion) VALUES (98, 'Plan 20 - Activación')
END

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 9802)
BEGIN
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) VALUES (9802, 98, '2017XX', 'OPT Tonos')
END

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.EstrategiaProducto')) = 0
 begin

CREATE TABLE [dbo].[EstrategiaProducto](
	[EstrategiaProductoId] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaId] int NOT null,
	[Campania] [int] NOT NULL,
	[CUV] [nvarchar](20) NOT NULL,
	[CodigoEstrategia] [nvarchar](100) NOT NULL,
	[Grupo] [nvarchar](20) NULL,
	[Orden] int NULL,
	[CUV2] [nvarchar](20) NULL,
	[SAP] [nvarchar](50) NULL,
	[Cantidad] INT NULL,
	[Precio] MONEY NULL,
	[PrecioValorizado] MONEY NULL,
	[Digitable] int NULL,
	[CodigoError] [nvarchar](100) NULL,
	[CodigoErrorObs] [nvarchar](4000) NULL
)

end
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Estrategia') and SYSCOLUMNS.NAME = N'CodigoEstrategia') = 0
	ALTER TABLE dbo.Estrategia ADD CodigoEstrategia varchar(100)
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertEstrategiaProducto
GO

CREATE PROCEDURE dbo.InsertEstrategiaProducto
	@Retorno int output
	,@EstrategiaProductoId int 
	,@EstrategiaId int
	,@Campania int
	,@CUV nvarchar(20)
	,@CodigoEstrategia nvarchar(100)
	,@Grupo nvarchar(20)
	,@Orden int
	,@CUV2 nvarchar(20)
	,@SAP nvarchar(50)
	,@Cantidad int
	,@Precio money
	,@PrecioValorizado money
	,@Digitable int
	,@CodigoError nvarchar(100)
	,@CodigoErrorObs nvarchar(4000)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
	
	set @existe = isnull(@existe, 0)

	-- select * from EstrategiaProducto
	if @existe = 0
	begin
			INSERT INTO EstrategiaProducto(
				EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
			)VALUES(
				@EstrategiaId
				,@Campania
				,@CUV
				,@CodigoEstrategia
				,@Grupo
				,@Orden
				,@CUV2
				,@SAP
				,@Cantidad
				,@Precio
				,@PrecioValorizado
				,@Digitable
				,@CodigoError
				,@CodigoErrorObs
			)

			set @Retorno = @@IDENTITY
	end
	else
	begin
		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end
go


GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEstrategiaProducto
GO

CREATE PROCEDURE dbo.GetEstrategiaProducto
	 @EstrategiaId int
AS
begin

	SELECT 
	 EstrategiaProductoId
	,EstrategiaId
	,Campania
	,CUV
	,CodigoEstrategia
	,Grupo
	,Orden
	,CUV2
	,SAP
	,Cantidad
	,Precio
	,PrecioValorizado
	,Digitable
	,CodigoError
	,CodigoErrorObs
	FROM EstrategiaProducto
	WHERE EstrategiaId = @EstrategiaId
	
end

GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.TipoEstrategia') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE dbo.TipoEstrategia ADD Codigo varchar(100)
go


go



ALTER PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion, sp.CodigoSap
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END

GO

/*end*/

USE BelcorpDominicana
GO

IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 98)
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion) VALUES (98, 'Plan 20 - Activación')
END

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 9802)
BEGIN
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) VALUES (9802, 98, '2017XX', 'OPT Tonos')
END

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.EstrategiaProducto')) = 0
 begin

CREATE TABLE [dbo].[EstrategiaProducto](
	[EstrategiaProductoId] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaId] int NOT null,
	[Campania] [int] NOT NULL,
	[CUV] [nvarchar](20) NOT NULL,
	[CodigoEstrategia] [nvarchar](100) NOT NULL,
	[Grupo] [nvarchar](20) NULL,
	[Orden] int NULL,
	[CUV2] [nvarchar](20) NULL,
	[SAP] [nvarchar](50) NULL,
	[Cantidad] INT NULL,
	[Precio] MONEY NULL,
	[PrecioValorizado] MONEY NULL,
	[Digitable] int NULL,
	[CodigoError] [nvarchar](100) NULL,
	[CodigoErrorObs] [nvarchar](4000) NULL
)

end
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Estrategia') and SYSCOLUMNS.NAME = N'CodigoEstrategia') = 0
	ALTER TABLE dbo.Estrategia ADD CodigoEstrategia varchar(100)
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertEstrategiaProducto
GO

CREATE PROCEDURE dbo.InsertEstrategiaProducto
	@Retorno int output
	,@EstrategiaProductoId int 
	,@EstrategiaId int
	,@Campania int
	,@CUV nvarchar(20)
	,@CodigoEstrategia nvarchar(100)
	,@Grupo nvarchar(20)
	,@Orden int
	,@CUV2 nvarchar(20)
	,@SAP nvarchar(50)
	,@Cantidad int
	,@Precio money
	,@PrecioValorizado money
	,@Digitable int
	,@CodigoError nvarchar(100)
	,@CodigoErrorObs nvarchar(4000)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
	
	set @existe = isnull(@existe, 0)

	-- select * from EstrategiaProducto
	if @existe = 0
	begin
			INSERT INTO EstrategiaProducto(
				EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
			)VALUES(
				@EstrategiaId
				,@Campania
				,@CUV
				,@CodigoEstrategia
				,@Grupo
				,@Orden
				,@CUV2
				,@SAP
				,@Cantidad
				,@Precio
				,@PrecioValorizado
				,@Digitable
				,@CodigoError
				,@CodigoErrorObs
			)

			set @Retorno = @@IDENTITY
	end
	else
	begin
		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end
go


GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEstrategiaProducto
GO

CREATE PROCEDURE dbo.GetEstrategiaProducto
	 @EstrategiaId int
AS
begin

	SELECT 
	 EstrategiaProductoId
	,EstrategiaId
	,Campania
	,CUV
	,CodigoEstrategia
	,Grupo
	,Orden
	,CUV2
	,SAP
	,Cantidad
	,Precio
	,PrecioValorizado
	,Digitable
	,CodigoError
	,CodigoErrorObs
	FROM EstrategiaProducto
	WHERE EstrategiaId = @EstrategiaId
	
end

GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.TipoEstrategia') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE dbo.TipoEstrategia ADD Codigo varchar(100)
go


go



ALTER PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion, sp.CodigoSap
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END

GO

/*end*/

USE BelcorpCostaRica
GO

IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 98)
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion) VALUES (98, 'Plan 20 - Activación')
END

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 9802)
BEGIN
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) VALUES (9802, 98, '2017XX', 'OPT Tonos')
END

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.EstrategiaProducto')) = 0
 begin

CREATE TABLE [dbo].[EstrategiaProducto](
	[EstrategiaProductoId] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaId] int NOT null,
	[Campania] [int] NOT NULL,
	[CUV] [nvarchar](20) NOT NULL,
	[CodigoEstrategia] [nvarchar](100) NOT NULL,
	[Grupo] [nvarchar](20) NULL,
	[Orden] int NULL,
	[CUV2] [nvarchar](20) NULL,
	[SAP] [nvarchar](50) NULL,
	[Cantidad] INT NULL,
	[Precio] MONEY NULL,
	[PrecioValorizado] MONEY NULL,
	[Digitable] int NULL,
	[CodigoError] [nvarchar](100) NULL,
	[CodigoErrorObs] [nvarchar](4000) NULL
)

end
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Estrategia') and SYSCOLUMNS.NAME = N'CodigoEstrategia') = 0
	ALTER TABLE dbo.Estrategia ADD CodigoEstrategia varchar(100)
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertEstrategiaProducto
GO

CREATE PROCEDURE dbo.InsertEstrategiaProducto
	@Retorno int output
	,@EstrategiaProductoId int 
	,@EstrategiaId int
	,@Campania int
	,@CUV nvarchar(20)
	,@CodigoEstrategia nvarchar(100)
	,@Grupo nvarchar(20)
	,@Orden int
	,@CUV2 nvarchar(20)
	,@SAP nvarchar(50)
	,@Cantidad int
	,@Precio money
	,@PrecioValorizado money
	,@Digitable int
	,@CodigoError nvarchar(100)
	,@CodigoErrorObs nvarchar(4000)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
	
	set @existe = isnull(@existe, 0)

	-- select * from EstrategiaProducto
	if @existe = 0
	begin
			INSERT INTO EstrategiaProducto(
				EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
			)VALUES(
				@EstrategiaId
				,@Campania
				,@CUV
				,@CodigoEstrategia
				,@Grupo
				,@Orden
				,@CUV2
				,@SAP
				,@Cantidad
				,@Precio
				,@PrecioValorizado
				,@Digitable
				,@CodigoError
				,@CodigoErrorObs
			)

			set @Retorno = @@IDENTITY
	end
	else
	begin
		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end
go


GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEstrategiaProducto
GO

CREATE PROCEDURE dbo.GetEstrategiaProducto
	 @EstrategiaId int
AS
begin

	SELECT 
	 EstrategiaProductoId
	,EstrategiaId
	,Campania
	,CUV
	,CodigoEstrategia
	,Grupo
	,Orden
	,CUV2
	,SAP
	,Cantidad
	,Precio
	,PrecioValorizado
	,Digitable
	,CodigoError
	,CodigoErrorObs
	FROM EstrategiaProducto
	WHERE EstrategiaId = @EstrategiaId
	
end

GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.TipoEstrategia') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE dbo.TipoEstrategia ADD Codigo varchar(100)
go


go



ALTER PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion, sp.CodigoSap
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END

GO

/*end*/

USE BelcorpChile
GO

IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 98)
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion) VALUES (98, 'Plan 20 - Activación')
END

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 9802)
BEGIN
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) VALUES (9802, 98, '2017XX', 'OPT Tonos')
END

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.EstrategiaProducto')) = 0
 begin

CREATE TABLE [dbo].[EstrategiaProducto](
	[EstrategiaProductoId] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaId] int NOT null,
	[Campania] [int] NOT NULL,
	[CUV] [nvarchar](20) NOT NULL,
	[CodigoEstrategia] [nvarchar](100) NOT NULL,
	[Grupo] [nvarchar](20) NULL,
	[Orden] int NULL,
	[CUV2] [nvarchar](20) NULL,
	[SAP] [nvarchar](50) NULL,
	[Cantidad] INT NULL,
	[Precio] MONEY NULL,
	[PrecioValorizado] MONEY NULL,
	[Digitable] int NULL,
	[CodigoError] [nvarchar](100) NULL,
	[CodigoErrorObs] [nvarchar](4000) NULL
)

end
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Estrategia') and SYSCOLUMNS.NAME = N'CodigoEstrategia') = 0
	ALTER TABLE dbo.Estrategia ADD CodigoEstrategia varchar(100)
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertEstrategiaProducto
GO

CREATE PROCEDURE dbo.InsertEstrategiaProducto
	@Retorno int output
	,@EstrategiaProductoId int 
	,@EstrategiaId int
	,@Campania int
	,@CUV nvarchar(20)
	,@CodigoEstrategia nvarchar(100)
	,@Grupo nvarchar(20)
	,@Orden int
	,@CUV2 nvarchar(20)
	,@SAP nvarchar(50)
	,@Cantidad int
	,@Precio money
	,@PrecioValorizado money
	,@Digitable int
	,@CodigoError nvarchar(100)
	,@CodigoErrorObs nvarchar(4000)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
	
	set @existe = isnull(@existe, 0)

	-- select * from EstrategiaProducto
	if @existe = 0
	begin
			INSERT INTO EstrategiaProducto(
				EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
			)VALUES(
				@EstrategiaId
				,@Campania
				,@CUV
				,@CodigoEstrategia
				,@Grupo
				,@Orden
				,@CUV2
				,@SAP
				,@Cantidad
				,@Precio
				,@PrecioValorizado
				,@Digitable
				,@CodigoError
				,@CodigoErrorObs
			)

			set @Retorno = @@IDENTITY
	end
	else
	begin
		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end
go


GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEstrategiaProducto
GO

CREATE PROCEDURE dbo.GetEstrategiaProducto
	 @EstrategiaId int
AS
begin

	SELECT 
	 EstrategiaProductoId
	,EstrategiaId
	,Campania
	,CUV
	,CodigoEstrategia
	,Grupo
	,Orden
	,CUV2
	,SAP
	,Cantidad
	,Precio
	,PrecioValorizado
	,Digitable
	,CodigoError
	,CodigoErrorObs
	FROM EstrategiaProducto
	WHERE EstrategiaId = @EstrategiaId
	
end

GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.TipoEstrategia') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE dbo.TipoEstrategia ADD Codigo varchar(100)
go


go



ALTER PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion, sp.CodigoSap
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END

GO

/*end*/

USE BelcorpBolivia
GO

IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 98)
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion) VALUES (98, 'Plan 20 - Activación')
END

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 9802)
BEGIN
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) VALUES (9802, 98, '2017XX', 'OPT Tonos')
END

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.EstrategiaProducto')) = 0
 begin

CREATE TABLE [dbo].[EstrategiaProducto](
	[EstrategiaProductoId] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaId] int NOT null,
	[Campania] [int] NOT NULL,
	[CUV] [nvarchar](20) NOT NULL,
	[CodigoEstrategia] [nvarchar](100) NOT NULL,
	[Grupo] [nvarchar](20) NULL,
	[Orden] int NULL,
	[CUV2] [nvarchar](20) NULL,
	[SAP] [nvarchar](50) NULL,
	[Cantidad] INT NULL,
	[Precio] MONEY NULL,
	[PrecioValorizado] MONEY NULL,
	[Digitable] int NULL,
	[CodigoError] [nvarchar](100) NULL,
	[CodigoErrorObs] [nvarchar](4000) NULL
)

end
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Estrategia') and SYSCOLUMNS.NAME = N'CodigoEstrategia') = 0
	ALTER TABLE dbo.Estrategia ADD CodigoEstrategia varchar(100)
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertEstrategiaProducto
GO

CREATE PROCEDURE dbo.InsertEstrategiaProducto
	@Retorno int output
	,@EstrategiaProductoId int 
	,@EstrategiaId int
	,@Campania int
	,@CUV nvarchar(20)
	,@CodigoEstrategia nvarchar(100)
	,@Grupo nvarchar(20)
	,@Orden int
	,@CUV2 nvarchar(20)
	,@SAP nvarchar(50)
	,@Cantidad int
	,@Precio money
	,@PrecioValorizado money
	,@Digitable int
	,@CodigoError nvarchar(100)
	,@CodigoErrorObs nvarchar(4000)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
	
	set @existe = isnull(@existe, 0)

	-- select * from EstrategiaProducto
	if @existe = 0
	begin
			INSERT INTO EstrategiaProducto(
				EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
			)VALUES(
				@EstrategiaId
				,@Campania
				,@CUV
				,@CodigoEstrategia
				,@Grupo
				,@Orden
				,@CUV2
				,@SAP
				,@Cantidad
				,@Precio
				,@PrecioValorizado
				,@Digitable
				,@CodigoError
				,@CodigoErrorObs
			)

			set @Retorno = @@IDENTITY
	end
	else
	begin
		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end
go


GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEstrategiaProducto
GO

CREATE PROCEDURE dbo.GetEstrategiaProducto
	 @EstrategiaId int
AS
begin

	SELECT 
	 EstrategiaProductoId
	,EstrategiaId
	,Campania
	,CUV
	,CodigoEstrategia
	,Grupo
	,Orden
	,CUV2
	,SAP
	,Cantidad
	,Precio
	,PrecioValorizado
	,Digitable
	,CodigoError
	,CodigoErrorObs
	FROM EstrategiaProducto
	WHERE EstrategiaId = @EstrategiaId
	
end

GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.TipoEstrategia') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE dbo.TipoEstrategia ADD Codigo varchar(100)
go


go



ALTER PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion, sp.CodigoSap
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END

GO
