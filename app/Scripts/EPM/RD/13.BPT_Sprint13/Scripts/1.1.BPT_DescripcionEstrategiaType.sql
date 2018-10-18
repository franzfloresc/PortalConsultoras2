USE BelcorpPeru
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

CREATE TYPE [dbo].[DescripcionEstrategiaType] AS TABLE(
	[Cuv] [varchar](20) NULL,
	[Descripcion] [varchar](800) NULL,
	[Estado] [int] NULL,
	[Mensaje] [varchar](500) NULL
)
GO

CREATE PROCEDURE dbo.ActualizarDescripcionEstrategia
	@DescripcionEstrategia dbo.DescripcionEstrategiaType readonly,
	@CampaniaId int,
	@TipoEstrategiaId int
AS
BEGIN
	DECLARE @TableType dbo.DescripcionEstrategiaType;
	INSERT INTO @TableType SELECT * FROM @DescripcionEstrategia;

	UPDATE Estrategia 
	SET	DescripcionCUV2 = et.Descripcion
	FROM Estrategia e
		JOIN @DescripcionEstrategia et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId 
		and e.TipoEstrategiaID = @TipoEstrategiaId
	
	UPDATE @TableType 
	SET	Estado = 1, Mensaje = 'Actualizado'
	FROM Estrategia e
		JOIN @TableType et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId
		and e.TipoEstrategiaID = @TipoEstrategiaId

	SELECT * FROM @TableType
END
GO

USE BelcorpMexico
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

CREATE TYPE [dbo].[DescripcionEstrategiaType] AS TABLE(
	[Cuv] [varchar](20) NULL,
	[Descripcion] [varchar](800) NULL,
	[Estado] [int] NULL,
	[Mensaje] [varchar](500) NULL
)
GO

CREATE PROCEDURE dbo.ActualizarDescripcionEstrategia
	@DescripcionEstrategia dbo.DescripcionEstrategiaType readonly,
	@CampaniaId int,
	@TipoEstrategiaId int
AS
BEGIN
	DECLARE @TableType dbo.DescripcionEstrategiaType;
	INSERT INTO @TableType SELECT * FROM @DescripcionEstrategia;

	UPDATE Estrategia 
	SET	DescripcionCUV2 = et.Descripcion
	FROM Estrategia e
		JOIN @DescripcionEstrategia et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId 
		and e.TipoEstrategiaID = @TipoEstrategiaId
	
	UPDATE @TableType 
	SET	Estado = 1, Mensaje = 'Actualizado'
	FROM Estrategia e
		JOIN @TableType et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId
		and e.TipoEstrategiaID = @TipoEstrategiaId

	SELECT * FROM @TableType
END
GO

USE BelcorpColombia
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

CREATE TYPE [dbo].[DescripcionEstrategiaType] AS TABLE(
	[Cuv] [varchar](20) NULL,
	[Descripcion] [varchar](800) NULL,
	[Estado] [int] NULL,
	[Mensaje] [varchar](500) NULL
)
GO

CREATE PROCEDURE dbo.ActualizarDescripcionEstrategia
	@DescripcionEstrategia dbo.DescripcionEstrategiaType readonly,
	@CampaniaId int,
	@TipoEstrategiaId int
AS
BEGIN
	DECLARE @TableType dbo.DescripcionEstrategiaType;
	INSERT INTO @TableType SELECT * FROM @DescripcionEstrategia;

	UPDATE Estrategia 
	SET	DescripcionCUV2 = et.Descripcion
	FROM Estrategia e
		JOIN @DescripcionEstrategia et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId 
		and e.TipoEstrategiaID = @TipoEstrategiaId
	
	UPDATE @TableType 
	SET	Estado = 1, Mensaje = 'Actualizado'
	FROM Estrategia e
		JOIN @TableType et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId
		and e.TipoEstrategiaID = @TipoEstrategiaId

	SELECT * FROM @TableType
END
GO

USE BelcorpVenezuela
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

CREATE TYPE [dbo].[DescripcionEstrategiaType] AS TABLE(
	[Cuv] [varchar](20) NULL,
	[Descripcion] [varchar](800) NULL,
	[Estado] [int] NULL,
	[Mensaje] [varchar](500) NULL
)
GO

CREATE PROCEDURE dbo.ActualizarDescripcionEstrategia
	@DescripcionEstrategia dbo.DescripcionEstrategiaType readonly,
	@CampaniaId int,
	@TipoEstrategiaId int
AS
BEGIN
	DECLARE @TableType dbo.DescripcionEstrategiaType;
	INSERT INTO @TableType SELECT * FROM @DescripcionEstrategia;

	UPDATE Estrategia 
	SET	DescripcionCUV2 = et.Descripcion
	FROM Estrategia e
		JOIN @DescripcionEstrategia et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId 
		and e.TipoEstrategiaID = @TipoEstrategiaId
	
	UPDATE @TableType 
	SET	Estado = 1, Mensaje = 'Actualizado'
	FROM Estrategia e
		JOIN @TableType et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId
		and e.TipoEstrategiaID = @TipoEstrategiaId

	SELECT * FROM @TableType
END
GO

USE BelcorpSalvador
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

CREATE TYPE [dbo].[DescripcionEstrategiaType] AS TABLE(
	[Cuv] [varchar](20) NULL,
	[Descripcion] [varchar](800) NULL,
	[Estado] [int] NULL,
	[Mensaje] [varchar](500) NULL
)
GO

CREATE PROCEDURE dbo.ActualizarDescripcionEstrategia
	@DescripcionEstrategia dbo.DescripcionEstrategiaType readonly,
	@CampaniaId int,
	@TipoEstrategiaId int
AS
BEGIN
	DECLARE @TableType dbo.DescripcionEstrategiaType;
	INSERT INTO @TableType SELECT * FROM @DescripcionEstrategia;

	UPDATE Estrategia 
	SET	DescripcionCUV2 = et.Descripcion
	FROM Estrategia e
		JOIN @DescripcionEstrategia et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId 
		and e.TipoEstrategiaID = @TipoEstrategiaId
	
	UPDATE @TableType 
	SET	Estado = 1, Mensaje = 'Actualizado'
	FROM Estrategia e
		JOIN @TableType et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId
		and e.TipoEstrategiaID = @TipoEstrategiaId

	SELECT * FROM @TableType
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

CREATE TYPE [dbo].[DescripcionEstrategiaType] AS TABLE(
	[Cuv] [varchar](20) NULL,
	[Descripcion] [varchar](800) NULL,
	[Estado] [int] NULL,
	[Mensaje] [varchar](500) NULL
)
GO

CREATE PROCEDURE dbo.ActualizarDescripcionEstrategia
	@DescripcionEstrategia dbo.DescripcionEstrategiaType readonly,
	@CampaniaId int,
	@TipoEstrategiaId int
AS
BEGIN
	DECLARE @TableType dbo.DescripcionEstrategiaType;
	INSERT INTO @TableType SELECT * FROM @DescripcionEstrategia;

	UPDATE Estrategia 
	SET	DescripcionCUV2 = et.Descripcion
	FROM Estrategia e
		JOIN @DescripcionEstrategia et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId 
		and e.TipoEstrategiaID = @TipoEstrategiaId
	
	UPDATE @TableType 
	SET	Estado = 1, Mensaje = 'Actualizado'
	FROM Estrategia e
		JOIN @TableType et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId
		and e.TipoEstrategiaID = @TipoEstrategiaId

	SELECT * FROM @TableType
END
GO

USE BelcorpPanama
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

CREATE TYPE [dbo].[DescripcionEstrategiaType] AS TABLE(
	[Cuv] [varchar](20) NULL,
	[Descripcion] [varchar](800) NULL,
	[Estado] [int] NULL,
	[Mensaje] [varchar](500) NULL
)
GO

CREATE PROCEDURE dbo.ActualizarDescripcionEstrategia
	@DescripcionEstrategia dbo.DescripcionEstrategiaType readonly,
	@CampaniaId int,
	@TipoEstrategiaId int
AS
BEGIN
	DECLARE @TableType dbo.DescripcionEstrategiaType;
	INSERT INTO @TableType SELECT * FROM @DescripcionEstrategia;

	UPDATE Estrategia 
	SET	DescripcionCUV2 = et.Descripcion
	FROM Estrategia e
		JOIN @DescripcionEstrategia et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId 
		and e.TipoEstrategiaID = @TipoEstrategiaId
	
	UPDATE @TableType 
	SET	Estado = 1, Mensaje = 'Actualizado'
	FROM Estrategia e
		JOIN @TableType et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId
		and e.TipoEstrategiaID = @TipoEstrategiaId

	SELECT * FROM @TableType
END
GO

USE BelcorpGuatemala
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

CREATE TYPE [dbo].[DescripcionEstrategiaType] AS TABLE(
	[Cuv] [varchar](20) NULL,
	[Descripcion] [varchar](800) NULL,
	[Estado] [int] NULL,
	[Mensaje] [varchar](500) NULL
)
GO

CREATE PROCEDURE dbo.ActualizarDescripcionEstrategia
	@DescripcionEstrategia dbo.DescripcionEstrategiaType readonly,
	@CampaniaId int,
	@TipoEstrategiaId int
AS
BEGIN
	DECLARE @TableType dbo.DescripcionEstrategiaType;
	INSERT INTO @TableType SELECT * FROM @DescripcionEstrategia;

	UPDATE Estrategia 
	SET	DescripcionCUV2 = et.Descripcion
	FROM Estrategia e
		JOIN @DescripcionEstrategia et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId 
		and e.TipoEstrategiaID = @TipoEstrategiaId
	
	UPDATE @TableType 
	SET	Estado = 1, Mensaje = 'Actualizado'
	FROM Estrategia e
		JOIN @TableType et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId
		and e.TipoEstrategiaID = @TipoEstrategiaId

	SELECT * FROM @TableType
END
GO

USE BelcorpEcuador
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

CREATE TYPE [dbo].[DescripcionEstrategiaType] AS TABLE(
	[Cuv] [varchar](20) NULL,
	[Descripcion] [varchar](800) NULL,
	[Estado] [int] NULL,
	[Mensaje] [varchar](500) NULL
)
GO

CREATE PROCEDURE dbo.ActualizarDescripcionEstrategia
	@DescripcionEstrategia dbo.DescripcionEstrategiaType readonly,
	@CampaniaId int,
	@TipoEstrategiaId int
AS
BEGIN
	DECLARE @TableType dbo.DescripcionEstrategiaType;
	INSERT INTO @TableType SELECT * FROM @DescripcionEstrategia;

	UPDATE Estrategia 
	SET	DescripcionCUV2 = et.Descripcion
	FROM Estrategia e
		JOIN @DescripcionEstrategia et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId 
		and e.TipoEstrategiaID = @TipoEstrategiaId
	
	UPDATE @TableType 
	SET	Estado = 1, Mensaje = 'Actualizado'
	FROM Estrategia e
		JOIN @TableType et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId
		and e.TipoEstrategiaID = @TipoEstrategiaId

	SELECT * FROM @TableType
END
GO

USE BelcorpDominicana
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

CREATE TYPE [dbo].[DescripcionEstrategiaType] AS TABLE(
	[Cuv] [varchar](20) NULL,
	[Descripcion] [varchar](800) NULL,
	[Estado] [int] NULL,
	[Mensaje] [varchar](500) NULL
)
GO

CREATE PROCEDURE dbo.ActualizarDescripcionEstrategia
	@DescripcionEstrategia dbo.DescripcionEstrategiaType readonly,
	@CampaniaId int,
	@TipoEstrategiaId int
AS
BEGIN
	DECLARE @TableType dbo.DescripcionEstrategiaType;
	INSERT INTO @TableType SELECT * FROM @DescripcionEstrategia;

	UPDATE Estrategia 
	SET	DescripcionCUV2 = et.Descripcion
	FROM Estrategia e
		JOIN @DescripcionEstrategia et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId 
		and e.TipoEstrategiaID = @TipoEstrategiaId
	
	UPDATE @TableType 
	SET	Estado = 1, Mensaje = 'Actualizado'
	FROM Estrategia e
		JOIN @TableType et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId
		and e.TipoEstrategiaID = @TipoEstrategiaId

	SELECT * FROM @TableType
END
GO

USE BelcorpCostaRica
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

CREATE TYPE [dbo].[DescripcionEstrategiaType] AS TABLE(
	[Cuv] [varchar](20) NULL,
	[Descripcion] [varchar](800) NULL,
	[Estado] [int] NULL,
	[Mensaje] [varchar](500) NULL
)
GO

CREATE PROCEDURE dbo.ActualizarDescripcionEstrategia
	@DescripcionEstrategia dbo.DescripcionEstrategiaType readonly,
	@CampaniaId int,
	@TipoEstrategiaId int
AS
BEGIN
	DECLARE @TableType dbo.DescripcionEstrategiaType;
	INSERT INTO @TableType SELECT * FROM @DescripcionEstrategia;

	UPDATE Estrategia 
	SET	DescripcionCUV2 = et.Descripcion
	FROM Estrategia e
		JOIN @DescripcionEstrategia et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId 
		and e.TipoEstrategiaID = @TipoEstrategiaId
	
	UPDATE @TableType 
	SET	Estado = 1, Mensaje = 'Actualizado'
	FROM Estrategia e
		JOIN @TableType et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId
		and e.TipoEstrategiaID = @TipoEstrategiaId

	SELECT * FROM @TableType
END
GO

USE BelcorpChile
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

CREATE TYPE [dbo].[DescripcionEstrategiaType] AS TABLE(
	[Cuv] [varchar](20) NULL,
	[Descripcion] [varchar](800) NULL,
	[Estado] [int] NULL,
	[Mensaje] [varchar](500) NULL
)
GO

CREATE PROCEDURE dbo.ActualizarDescripcionEstrategia
	@DescripcionEstrategia dbo.DescripcionEstrategiaType readonly,
	@CampaniaId int,
	@TipoEstrategiaId int
AS
BEGIN
	DECLARE @TableType dbo.DescripcionEstrategiaType;
	INSERT INTO @TableType SELECT * FROM @DescripcionEstrategia;

	UPDATE Estrategia 
	SET	DescripcionCUV2 = et.Descripcion
	FROM Estrategia e
		JOIN @DescripcionEstrategia et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId 
		and e.TipoEstrategiaID = @TipoEstrategiaId
	
	UPDATE @TableType 
	SET	Estado = 1, Mensaje = 'Actualizado'
	FROM Estrategia e
		JOIN @TableType et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId
		and e.TipoEstrategiaID = @TipoEstrategiaId

	SELECT * FROM @TableType
END
GO

USE BelcorpBolivia
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

CREATE TYPE [dbo].[DescripcionEstrategiaType] AS TABLE(
	[Cuv] [varchar](20) NULL,
	[Descripcion] [varchar](800) NULL,
	[Estado] [int] NULL,
	[Mensaje] [varchar](500) NULL
)
GO

CREATE PROCEDURE dbo.ActualizarDescripcionEstrategia
	@DescripcionEstrategia dbo.DescripcionEstrategiaType readonly,
	@CampaniaId int,
	@TipoEstrategiaId int
AS
BEGIN
	DECLARE @TableType dbo.DescripcionEstrategiaType;
	INSERT INTO @TableType SELECT * FROM @DescripcionEstrategia;

	UPDATE Estrategia 
	SET	DescripcionCUV2 = et.Descripcion
	FROM Estrategia e
		JOIN @DescripcionEstrategia et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId 
		and e.TipoEstrategiaID = @TipoEstrategiaId
	
	UPDATE @TableType 
	SET	Estado = 1, Mensaje = 'Actualizado'
	FROM Estrategia e
		JOIN @TableType et ON e.CUV2 = et.Cuv 
	WHERE e.CampaniaID = @CampaniaId
		and e.TipoEstrategiaID = @TipoEstrategiaId

	SELECT * FROM @TableType
END
GO

