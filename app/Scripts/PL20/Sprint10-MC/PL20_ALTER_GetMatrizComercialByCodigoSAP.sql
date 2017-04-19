USE [BelcorpCostaRica]
GO
/****** Object:  StoredProcedure [dbo].[GetMatrizComercialByCodigoSAP]    Script Date: 19/04/2017 3:22:03 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[GetMatrizComercialByCodigoSAP]
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			PC.CUV as CUV,
			MC.FechaRegistro as FechaRegistro
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FechaRegistro desc
END
