USE [BelcorpPeru_APP]
GO
/****** Object:  StoredProcedure [dbo].[ContenidoAppGet]    Script Date: 17/5/2019 12:34:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

ALTER PROCEDURE [dbo].[ContenidoAppGet]
	@Codigo varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		IdContenido, Codigo, Descripcion, UrlMiniatura, Estado, DesdeCampania, CantidadContenido, RutaImagen
	FROM ContenidoApp AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

