
USE BELCORPCHILE
go
IF (OBJECT_ID('dbo.GetObtenerOfertaFinalRegaloSorpresa', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetObtenerOfertaFinalRegaloSorpresa AS SET NOCOUNT ON;')
GO
ALTER  PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa] @CampaniaId INT

	,@ConsultoraId INT

AS

BEGIN

	SELECT ofe.CampaniaId

		,ofe.ConsultoraId

		,ofe.MontoPedido

		,ofe.GapMinimo

		,ofe.GapMaximo

		,ofe.GapAgregar

		,ofe.MontoMeta

		,ofe.Cuv

		,ofe.TipoRango

		,ISNULL(ud.Nombre,'') AS Descripcion

		,ISNULL(ud.Descripcion,'') AS RegaloDescripcion

		,ud.Imagen AS RegaloImagenUrl

		,ofe.MontoPedidoFinal

	FROM dbo.OfertaFinalMontoMeta ofe WITH (NOLOCK)

	INNER JOIN UpSelling u ON ofe.CampaniaId = u.CodigoCampana

		AND u.Activo = 1

	INNER JOIN UpSellingDetalle ud ON u.UpsellingId = ud.UpsellingId

		AND ud.CUV = ofe.Cuv

		AND ud.Activo = 1

	WHERE ofe.CampaniaId = @CampaniaId

		AND ofe.ConsultoraId = @ConsultoraId

		--AND ud.stock > 0;

END;


