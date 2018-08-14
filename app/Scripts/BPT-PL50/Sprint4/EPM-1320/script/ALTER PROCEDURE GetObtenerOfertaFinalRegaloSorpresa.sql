use belcorpchile
go
alter PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa] @CampaniaId INT
	,@ConsultoraId INT
AS
BEGIN
	IF (
			EXISTS (
				SELECT 1
				FROM ConfiguracionPais
				WHERE Codigo = 'OFC'
					AND Estado = 1
				)
			)
	BEGIN
		--crossselling
		SELECT ofe.CampaniaId
			,ofe.ConsultoraId
			,ofe.MontoPedido
			,ofe.GapMinimo
			,ofe.GapMaximo
			,ofe.GapAgregar
			,ofe.MontoMeta
			,ofe.Cuv
			,ofe.TipoRango
			,pc.Descripcion
			,prd.RegaloDescripcion
			,prd.RegaloImagenUrl
		FROM dbo.OfertaFinalMontoMeta ofe WITH (NOLOCK)
		INNER JOIN ProductoDescripcion prd WITH (NOLOCK) ON ofe.CampaniaId = prd.CampaniaID
			AND ofe.Cuv = prd.CUV
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pc.Cuv = ofe.Cuv
			AND pc.AnoCampania = ofe.CampaniaId
		WHERE ofe.CampaniaId = @CampaniaId
			AND ofe.ConsultoraId = @ConsultoraId;
	END
	ELSE
	BEGIN
		--upselling
		SELECT ofe.CampaniaId
			,ofe.ConsultoraId
			,ofe.MontoPedido
			,ofe.GapMinimo
			,ofe.GapMaximo
			,ofe.GapAgregar
			,ofe.MontoMeta
			,ofe.Cuv
			,ofe.TipoRango
			,ISNULL(ud.Nombre, '') AS Descripcion
			,ISNULL(ud.Descripcion, '') AS RegaloDescripcion
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
	END
END
GO
