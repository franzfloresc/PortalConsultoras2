USE [BelcorpPeru_MC]
GO
/****** Object:  StoredProcedure [dbo].[ContenidoAppDetaList]    Script Date: 22/5/2019 17:33:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
Declare @numReg AS int;
	set @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P WHERE P.IdContenido = @IdContenido);

	SELECT 
	top (@numReg) P.*,
			Q.Codigo as DetaCodigo,
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