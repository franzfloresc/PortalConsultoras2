USE [BelcorpPeru]
GO

ALTER PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO

USE [BelcorpBolivia]
GO

ALTER PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO

USE [BelcorpChile]
GO

ALTER PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO

USE [BelcorpColombia]
GO

ALTER PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO

USE [BelcorpCostaRica]
GO

ALTER PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO

USE [BelcorpDominicana]
GO

ALTER PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO

USE [BelcorpEcuador]
GO

ALTER PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO

USE [BelcorpGuatemala]
GO

ALTER PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO

USE [BelcorpMexico]
GO

ALTER PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO

USE [BelcorpPanama]
GO

ALTER PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO

USE [BelcorpPuertoRico]
GO

ALTER PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO

USE [BelcorpSalvador]
GO

ALTER PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO


