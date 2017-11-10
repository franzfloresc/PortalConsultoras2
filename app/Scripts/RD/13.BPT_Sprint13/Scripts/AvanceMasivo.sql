
USE BelcorpPeru_BPT
GO 
DROP TYPE [dbo].[DescripcionEstrategiaType]
IF NOT EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
CREATE TYPE [dbo].[DescripcionEstrategiaType] AS TABLE(
	[Cuv] [varchar](5) NULL,
	[Descripcion] [varchar](800) NULL,
	[Estado] [int] NULL,
	[Mensaje] [varchar](500) NULL
)
GO

DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO
CREATE PROCEDURE dbo.ActualizarDescripcionEstrategia
	@DescripcionEstrategia dbo.DescripcionEstrategiaType readonly,
	@CampaniaId int,
	@TipoEstrategiaId int
AS
BEGIN
	declare @TableType dbo.DescripcionEstrategiaType;
	INSERT INTO @TableType SELECT * FROM @DescripcionEstrategia;
	select * from @TableType
	print @TipoEstrategiaId

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

DECLARE @TableType dbo.DescripcionEstrategiaType;
INSERT INTO @TableType values ('96053','Test1 - LBel Live Intense Eau de Parfum 50ml',0,'');
INSERT INTO @TableType values ('96044','Test1 - Ésika Grazzia Exotic Eau de Parfum Atomiseur 50ml',0,'');
INSERT INTO @TableType values ('96058','Test1 - LBel Devos Magnetic Sport Eau de Toilette 100ml',0,'');

EXEC ActualizarDescripcionEstrategia @TableType, 201716, 3014