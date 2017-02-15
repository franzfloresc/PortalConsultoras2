USE [BelcorpPeru]
GO


IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 98)
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion) VALUES (98, 'Validación para determinar desde que campaña se realizará la búsqueda de la información de la estrategia.')
END

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 9802)
BEGIN
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) VALUES (9802, 98, '201704', 'Campaña para la busqueda.')
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
go


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

