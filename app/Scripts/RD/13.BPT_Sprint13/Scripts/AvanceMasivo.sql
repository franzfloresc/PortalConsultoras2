DROP TYPE [dbo].[DescripcionEstrategiaType]
CREATE TYPE [dbo].[DescripcionEstrategiaType] AS TABLE(
	[Cuv] [varchar](5) NULL,
	[Descripcion] [varchar](800) NULL,
	[Estado] [int] NULL,
	[Mensaje] [varchar](500) NULL
)
GO

ALTER PROCEDURE dbo.ActualizarDescripcionEstrategia
	@DescripcionEstrategia dbo.DescripcionEstrategiaType readonly,
	@CampaniaId int,
	@TipoEstrategiaId int
AS
BEGIN
	declare @TableType dbo.DescripcionEstrategiaType;
	INSERT INTO @TableType SELECT * FROM @DescripcionEstrategia;

	UPDATE Estrategia 
	SET	DescripcionCUV2 = et.Descripcion
	FROM Estrategia e
	JOIN @DescripcionEstrategia et ON e.CUV2 = et.Cuv
	WHERE TipoEstrategiaID = @TipoEstrategiaId
	

	UPDATE @TableType 
	SET	Estado = 1, Mensaje = 'Actualizado'
	FROM Estrategia e
	JOIN @TableType et ON e.CUV2 = et.Cuv
	WHERE TipoEstrategiaID = @TipoEstrategiaId

	SELECT * FROM @TableType
END
GO

declare @TableType dbo.DescripcionEstrategiaType;
INSERT INTO @TableType values ('96053','Test1 - LBel Live Intense Eau de Parfum 50ml',0,'');
INSERT INTO @TableType values ('95859','Test1 - Ésika Grazzia Exotic Eau de Parfum Atomiseur 50ml',0,'');
INSERT INTO @TableType values ('3034','Test1 - LBel Devos Magnetic Sport Eau de Toilette 100ml',0,'');

exec ActualizarDescripcionEstrategia @TableType, 201716, 3009