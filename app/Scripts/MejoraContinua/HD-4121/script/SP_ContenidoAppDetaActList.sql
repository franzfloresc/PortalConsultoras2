USE [BelcorpPeru_MC]
GO
/****** Object:  StoredProcedure [dbo].[ContenidoAppDetaActList]    Script Date: 17/5/2019 12:29:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaActList]
AS
BEGIN
	
	SELECT
		P.IdContenidoAct,
		P.Codigo,
		P.Descripcion,
		P.Parent,
		P.Orden,
		P.Activo		
	FROM dbo.ContenidoAppDetaAct AS P with(nolock)
	WHERE
		P.Activo = 1
		order by P.Orden ASC;
END
