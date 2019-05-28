USE [BelcorpPeru_APP]
GO
/****** Object:  StoredProcedure [dbo].[ContenidoAppDetaList]    Script Date: 17/5/2019 12:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
Declare @numReg AS int;
set @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = @IdContenido);
	SELECT
		top (@numReg)
		*	
	FROM dbo.ContenidoAppDeta AS P
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;

END
