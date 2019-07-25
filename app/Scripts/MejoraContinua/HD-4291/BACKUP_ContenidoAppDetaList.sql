USE [BelcorpPeru_MC]
GO
/****** Object:  StoredProcedure [dbo].[ContenidoAppDetaList]    Script Date: 29/5/2019 18:17:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	SELECT  
			P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
			P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
			P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
			P.Seccion,Q.Codigo as DetaCodigo,
			Q.Descripcion as DetaAccionDescripcion,
			R.Descripcion as DetaCodigoDetalleDescripcion
	FROM dbo.ContenidoAppDeta AS P with(nolock)
	LEFT JOIN dbo.ContenidoAppDetaAct AS Q with(nolock) ON P.Accion = Q.Codigo
	LEFT JOIN dbo.ContenidoAppDetaAct AS R with(nolock) ON P.CodigoDetalle = R.Codigo
	WHERE
			P.IdContenido = @IdContenido AND
			P.Estado = 1
			order by P.Orden ASC;
END