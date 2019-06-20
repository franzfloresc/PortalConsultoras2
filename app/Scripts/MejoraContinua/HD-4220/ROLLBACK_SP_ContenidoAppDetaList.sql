USE [BelcorpPeru_MC]
GO
/****** Object:  StoredProcedure [dbo].[ContenidoAppDetaList]    Script Date: 22/5/2019 17:18:11 ******/
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
		top (@numReg)
		*	
	FROM dbo.ContenidoAppDeta AS P
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;

END
