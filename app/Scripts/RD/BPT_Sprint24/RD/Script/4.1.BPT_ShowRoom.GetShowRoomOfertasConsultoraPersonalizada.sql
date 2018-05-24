GO
--[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] 201804, '000001740'
ALTER PROCEDURE ShowRoom.GetShowRoomOfertasConsultoraPersonalizada
	@CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
AS
BEGIN
/*Validacion FaltanteAnunciado y ProductoFaltante*/
	DECLARE @ZonaID INT
	DECLARE @CodigoRegion VARCHAR(2)
	DECLARE @CodigoZona VARCHAR(4)
	SELECT TOP 1 @ZonaID = z.ZonaID
		,@CodigoRegion = r.Codigo
		,@CodigoZona = z.Codigo
	FROM ods.Consultora c
		INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
		INNER JOIN ods.Region r ON c.RegionID = r.RegionID
	WHERE c.Codigo = @CodigoConsultora

	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	INSERT INTO @tablaFaltante
	SELECT DISTINCT LTRIM(RTRIM(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID

	UNION ALL
	SELECT DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
		INNER JOIN ods.Campania c(NOLOCK)
		ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			RTRIM(fa.CodigoRegion) = @CodigoRegion
			OR fa.CodigoRegion IS NULL
		)
		AND (
			RTRIM(fa.CodigoZona) = @CodigoZona
			OR fa.CodigoZona IS NULL
		)

	/*consultora generica*/
	IF NOT EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op
					WHERE op.CodConsultora= @CodigoConsultora
					AND op.AnioCampanaVenta= @CampaniaID
					AND op.TipoPersonalizacion= 'SR')
	BEGIN
			SELECT @CodigoConsultora = Codigo
			FROM TablaLogicaDatos
			WHERE TablaLogicaDatosID = 10001
	END
	/*end generica*/
	/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/
	SELECT DISTINCT
		 e.EstrategiaID
		,c.CampaniaID
		,e.CUV2 AS CUV
		,e.DescripcionCUV2 AS Descripcion
		,e.Precio AS PrecioValorizado --tachado
		,COALESCE(e.Precio2, pc.PrecioCatalogo) AS PrecioOferta
		,e.Cantidad AS Stock
		,e.ImagenURL AS ImagenProducto
		,e.LimiteVenta AS UnidadesPermitidas
		,e.Activo AS FlagHabilitarProducto
		,e.UsuarioCreacion AS UsuarioRegistro
		,e.FechaCreacion AS FechaRegistro
		,e.UsuarioModificacion
		,e.FechaModificacion
		,e.ImagenMiniaturaURL AS ImagenMini
		,pc.MarcaID
		,op.Orden
		,e.TextoLibre AS TipNegocio
		,pc.CodigoProducto
		,e.EsSubCampania
		,ISNULL(e.CodigoEstrategia,0) AS
		'CodigoEstrategia'
		,ISNULL(e.TieneVariedad,0) AS 'TieneVariedad'
		,e.TipoEstrategiaId AS ConfiguracionOfertaID
		,op.FlagRevista
	FROM Estrategia e
		INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
		INNER JOIN ods.ProductoComercial pc ON e.CUV2 = pc.CUV
			AND pc.CampaniaID = c.CampaniaID
		INNER JOIN ods.OfertasPersonalizadas op ON c.codigo = op.anioCampanaVenta
			AND e.CUV2 = op.CUV
			AND op.TipoPersonalizacion = 'SR'
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.Codigo = @CampaniaID
		AND op.CodConsultora = @CodigoConsultora
		AND e.Activo = 1
		AND e.CUV2 NOT IN (
			SELECT CUV FROM @tablaFaltante
		)
	ORDER BY op.Orden

END;
GO