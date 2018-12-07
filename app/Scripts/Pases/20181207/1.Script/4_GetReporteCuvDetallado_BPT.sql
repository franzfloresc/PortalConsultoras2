USE [BelcorpPeru]
GO

ALTER PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		ISNULL(estp.ImagenProducto,'') AS ImagenTipos,
		ISNULL(estp.ImagenBulk,'') AS ImagenTonos,
		ISNULL(estp.NombreBulk,'') AS NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

USE [BelcorpBolivia]
GO

ALTER PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

USE [BelcorpChile]
GO

ALTER PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

USE [BelcorpColombia]
GO

ALTER PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

USE [BelcorpCostaRica]
GO

ALTER PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

USE [BelcorpDominicana]
GO

ALTER PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

USE [BelcorpEcuador]
GO

ALTER PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

USE [BelcorpGuatemala]
GO

ALTER PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

USE [BelcorpMexico]
GO

ALTER PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

USE [BelcorpPanama]
GO

ALTER PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

USE [BelcorpPuertoRico]
GO

ALTER PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

USE [BelcorpSalvador]
GO

ALTER PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO
