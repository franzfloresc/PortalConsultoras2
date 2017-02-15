USE [BelcorpSalvador]

GO

ALTER PROCEDURE [dbo].[InsertarEstrategia_SB2]
	@EstrategiaID int,
	@TipoEstrategiaID int,
	@CampaniaID int,
	@CampaniaIDFin int,
	@NumeroPedido int,
	@Activo bit,
	@ImagenURL varchar(800),
	@LimiteVenta int,
	@DescripcionCUV2 varchar(800),
	@FlagDescripcion bit,
	@CUV varchar(20),
	@EtiquetaID int,
	@Precio numeric(12,2),
	@FlagCEP bit,
	@CUV2 varchar(20),
	@EtiquetaID2 int,
	@Precio2 numeric(12,2),
	@FlagCEP2 bit,
	@TextoLibre varchar(800),
	@FlagTextoLibre bit,
	@Cantidad int,
	@FlagCantidad bit,
	@Zona varchar(8000),
	@Orden int,
	@UsuarioCreacion varchar(100),
	@UsuarioModificacion varchar(100),
	@ColorFondo varchar(20),
	@FlagEstrella bit	
AS
BEGIN

	SET NOCOUNT ON
		BEGIN TRY

		DECLARE @TipoEstrategiaIDPackNueva INT = 0, @TipoEstrategiaIDOfertaDia INT = 0
		
		-- Para calcular la etiqueta para pack nuevas
		SELECT	@TipoEstrategiaIDPackNueva = COUNT( TipoEstrategiaID) 
		FROM	TipoEstrategia 
		WHERE	TipoEstrategiaId = @TipoEstrategiaID AND  flagnueva = 1

		-- Para calcular la etiqueta Oferta del día
		SELECT	@TipoEstrategiaIDOfertaDia = COUNT( TipoEstrategiaID) 
		FROM	TipoEstrategia 
		WHERE	TipoEstrategiaId = @TipoEstrategiaID AND  DescripcionEstrategia like '%'+ UPPER('OFERTA DEL')+'%'

		-- Obtener el EtiquetaID2 de Precio para TI
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
		
		-- Obtener el EtiquetaID de Precio Catalogo.	
		if isnull(@CUV,'') != ''
			SELECT @EtiquetaID = EtiquetaID FROM Etiqueta 
			WHERE Descripcion like '%' + UPPER('Precio Cat') + '%'
		else
			set @EtiquetaID = 0

		-- Obtener el EtiquetaID de Ganancia
		IF @TipoEstrategiaIDPackNueva > 0
		BEGIN
			SELECT @EtiquetaID = EtiquetaID from Etiqueta 
			WHERE Descripcion like '%' + UPPER('Ganancia') + '%'
		END
		-- Obtener el EtiquetaID de la Oferta del día.
		IF @TipoEstrategiaIDOfertaDia > 0
		BEGIN
			SELECT @EtiquetaID2 = EtiquetaID from Etiqueta 
			WHERE Descripcion like '%' + UPPER('OFERTA DEL') + '%'
		END		

			IF NOT EXISTS(SELECT 1 FROM Estrategia WHERE EstrategiaID = @EstrategiaID)
			BEGIN
				IF EXISTS(SELECT 1 FROM ESTRATEGIA WHERE CUV2 = @CUV2 AND CAMPANIAID = @CampaniaID AND TIPOESTRATEGIAID = @TipoEstrategiaID AND NUMEROPEDIDO = @NumeroPedido)
				BEGIN
					RAISERROR('El valor de cuv2 a registrar ya existe para el tipo de estrategia y campaña seleccionado.', 16, 1)
				END

				IF (@TipoEstrategiaID NOT IN (3009) AND ISNULL(@Orden,0) > 0)	-- SB20-312
				BEGIN
					IF EXISTS(SELECT 1 FROM ESTRATEGIA WHERE Orden = @Orden AND CAMPANIAID = @CampaniaID AND TIPOESTRATEGIAID = @TipoEstrategiaID AND NUMEROPEDIDO = @NumeroPedido)
					BEGIN
						RAISERROR('El orden ingresado para la estrategia ya está siendo utilizado.', 16, 1)
					END
				END							
				
			    INSERT INTO dbo.Estrategia
			    (TipoEstrategiaID, CampaniaID, CampaniaIDFin, NumeroPedido, Activo, ImagenURL, LimiteVenta, DescripcionCUV2
				,FlagDescripcion, CUV, EtiquetaID, Precio, FlagCEP, CUV2, EtiquetaID2, Precio2
				,FlagCEP2, TextoLibre, FlagTextoLibre, Cantidad, FlagCantidad, Zona, Orden, UsuarioCreacion, FechaCreacion, ColorFondo, FlagEstrella )
				VALUES
			   (@TipoEstrategiaID,@CampaniaID,@CampaniaIDFin,@NumeroPedido,@Activo,@ImagenURL,@LimiteVenta,@DescripcionCUV2
				,@FlagDescripcion,@CUV,@EtiquetaID,@Precio,@FlagCEP,@CUV2,@EtiquetaID2,@Precio2
				,@FlagCEP2,@TextoLibre,@FlagTextoLibre,@Cantidad,@FlagCantidad,@Zona,@Orden,@UsuarioCreacion,GETDATE(), @ColorFondo, @FlagEstrella)

			END
			ELSE
			BEGIN			

				IF EXISTS(SELECT 1 FROM ESTRATEGIA WHERE CUV2 = @CUV2 AND CAMPANIAID = @CampaniaID AND TIPOESTRATEGIAID = @TipoEstrategiaID AND ESTRATEGIAID <> @EstrategiaID  AND NUMEROPEDIDO = @NumeroPedido)
				BEGIN
					RAISERROR('El valor de cuv2 a registrar ya existe para el tipo de estrategia y campaña seleccionado.', 16, 1)
				END								 
				
				IF (@TipoEstrategiaID NOT IN (3009) AND ISNULL(@Orden,0) > 0) -- SB20-312
				BEGIN

					IF EXISTS(SELECT 1 FROM ESTRATEGIA WHERE Orden = @Orden AND CAMPANIAID = @CampaniaID AND TIPOESTRATEGIAID = @TipoEstrategiaID  AND ESTRATEGIAID <> @EstrategiaID AND NUMEROPEDIDO = @NumeroPedido)
					BEGIN
						RAISERROR('El orden ingresado para la estrategia ya está siendo utilizado.', 16, 1)
					END
				END
				
				--DECLARE @CantidadYaSolicitada INT
				--SELECT @CantidadYaSolicitada = Cantidad FROM PEDIDOWEBDETALLE WHERE CUV = @CUV AND CampaniaID = @CampaniaID
				--IF @LimiteVenta < @CantidadYaSolicitada
				--BEGIN
				--	DECLARE @mensaje VARCHAR(2000)
				--	SET @mensaje = 'No se puede reducir el limite de venta por que ya se hicieron ' + convert(varchar, @CantidadYaSolicitada) + ' pedido(s) de éste producto.'
				--	RAISERROR(@mensaje, 16, 1)
				--END			

				UPDATE Estrategia SET
					TipoEstrategiaID= @TipoEstrategiaID,
					CampaniaID= 	  @CampaniaID,
					CampaniaIDFin= 	  @CampaniaIDFin,
					NumeroPedido= 	  @NumeroPedido,
					Activo= 		  @Activo,
					ImagenURL= 		  @ImagenURL,
					LimiteVenta= 	  @LimiteVenta, 
					DescripcionCUV2=  @DescripcionCUV2,
					FlagDescripcion=  @FlagDescripcion ,
					CUV= 			  @CUV,
					EtiquetaID= 	  @EtiquetaID,
					Precio= 		  @Precio,
					FlagCEP= 		  @FlagCEP, 
					CUV2= 			  @CUV2,
					EtiquetaID2= 	  @EtiquetaID2,
					Precio2=		  @Precio2,
					FlagCEP2= 		  @FlagCEP2, 
					TextoLibre= 	  @TextoLibre, 
					FlagTextoLibre=   @FlagTextoLibre,
					Cantidad= 		  @Cantidad,
					FlagCantidad= 	  @FlagCantidad,
					Zona= 			  @Zona,
					Orden= 			  @Orden,
					UsuarioModificacion	=  @UsuarioModificacion,
					FechaModificacion	= GETDATE(),
					ColorFondo			= @ColorFondo, 
					FlagEstrella		= @FlagEstrella
				WHERE EstrategiaID = @EstrategiaID
			END
		END TRY
		
		BEGIN CATCH
			DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
			SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
			RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
		END CATCH

	SET NOCOUNT OFF
END


GO

ALTER PROCEDURE [dbo].[ListarEstrategiasPedido_SB2]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@CUV VARCHAR(20),
	@ZonaID VARCHAR(20)
AS
/*
dbo.ListarEstrategiasPedido_SB2 201612,'2','','2161'
*/
BEGIN
	SET NOCOUNT ON;

	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID

	DECLARE @CuvReco VARCHAR(20)
	SELECT @CuvReco = CSA.CUV
	FROM CrossSellingAsociacion CSA
	INNER JOIN ods.Campania CA ON CSA.CampaniaID = CA.CampaniaID
	WHERE
		CA.Codigo = @CampaniaID
		AND (CUVAsociado = @CUV OR CUVAsociado2 = @CUV OR CUV = @CUV)

	/* RECOMENDACION POR CUV - INICIO */
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		E.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		te.Orden Orden1,
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		TE.FlagNueva,
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		1 as TipoEstrategiaImagenMostrar	--CrossSelling
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
	INTO #TEMPORAL
	FROM Estrategia E
	INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo
	INNER JOIN CrossSellingAsociacion CSA ON CSA.CampaniaID = CA.CampaniaID AND (E.CUV2 = CSA.CUVAsociado OR E.CUV2 = CSA.CUVAsociado2 )
	INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	WHERE
		E.Activo = 1
		AND TE.flagRecoProduc = 1
		AND TE.FlagActivo = 1
		AND CSA.CUV IS NOT NULL
		AND CA.Codigo = @CampaniaID
		AND CSA.CUV = @CuvReco
		AND E.Zona LIKE '%' + @ZonaID + '%'
	ORDER BY
		te.Orden ASC,
		e.Orden ASC
	/* RECOMENDACION POR CUV - FIN */

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT

	SELECT
		@NumeroPedido = consecutivonueva + 1,
		@CodigoConsultora = codigo
	FROM ods.Consultora
	WHERE
		ConsultoraID=@ConsultoraID

	-- Obtener estrategias de Pack Nuevas.
	INSERT INTO #TEMPORAL
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		te.Orden Orden1,
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar	-- Pack Nuevas
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
	FROM Estrategia E
	INNER JOIN TipoEstrategia TE ON
		E.TipoEstrategiaID = TE.TipoEstrategiaID
	INNER JOIN ods.Campania CA ON
		E.CampaniaID = CA.Codigo
	INNER JOIN ods.ProductoComercial PC ON
		PC.CampaniaID = CA.CampaniaID
		AND PC.CUV = E.CUV2
	INNER JOIN Ods.ConsultorasProgramaNuevas CPN ON
		CPN.CodigoConsultora = @CodigoConsultora
		AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND E.Activo = 1
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.NumeroPedido = @NumeroPedido
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.CUV2 not in(SELECT CUV FROM @tablaCuvPedido)
	ORDER BY te.Orden ASC, e.Orden ASC

	-- Obtener estrategias de recomendadas para ti.
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null
	select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	from ods.Zona z
	inner join ods.Region r on
		z.RegionId = r.RegionId
	where ZonaId = @ZonaID

	declare @tablaCuvFaltante table (CUV varchar(6))
	insert into @tablaCuvFaltante
	select
		distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante nolock
	where
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	select
		distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa (nolock)
	inner join ods.Campania c (nolock) on
		fa.CampaniaID = c.CampaniaID
	where
		c.Codigo = @CampaniaID
		and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
		and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

	/*SB20-1080 - INICIO */
	DECLARE @cont1 INT, @cont2 INT, @codConsultoraDefault VARCHAR(9)
	SET @cont1 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)
	/*SB20-1080 - FIN */
	
	INSERT INTO #TEMPORAL
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		e.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,    pc.MarcaID,
		te.Orden Orden1,
		op.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
	FROM Estrategia E
	INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	INNER JOIN ods.Campania ca ON CA.Codigo = e.campaniaid
	INNER JOIN ods.OfertasPersonalizadas op ON E.CUV2 = op.CUV and op.AnioCampanaVenta = CA.Codigo and op.TipoPersonalizacion = 'OPT'
	INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
	INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND c.ConsultoraID = @ConsultoraID
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	--ORDER BY te.Orden ASC, op.Orden
	ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

	/*SB20-1080 - INICIO */
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)
	
	IF (@cont1 = @cont2)
	BEGIN
		SET @codConsultoraDefault = (SELECT TOP 1 Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 89)

		
INSERT INTO #TEMPORAL
		SELECT
			EstrategiaID,
			CUV2,
			DescripcionCUV2,
			dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
			e.Precio,
			dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
			Precio2,
			TextoLibre,		
			FlagEstrella,
			ColorFondo,
			e.TipoEstrategiaID,
			e.ImagenURL FotoProducto01,
			te.ImagenEstrategia ImagenURL,
			e.LimiteVenta,    pc.MarcaID,
			te.Orden Orden1,
			op.Orden Orden2,
			pc.IndicadorMontoMinimo,
			pc.CodigoProducto,
			0 AS FlagNueva, -- R2621
			dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
			3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
			, E.EtiquetaID		-- SB20-351
			, E.EtiquetaID2		-- SB20-351
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania ca ON CA.Codigo = e.campaniaid
		INNER JOIN ods.OfertasPersonalizadas op ON E.CUV2 = op.CUV and op.AnioCampanaVenta = CA.Codigo and op.TipoPersonalizacion = 'OPT'
		--INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			--AND c.ConsultoraID = @ConsultoraID
			AND op.CodConsultora = @codConsultoraDefault
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
			AND TE.TipoEstrategiaID = 4
		--ORDER BY te.Orden ASC, op.Orden
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	/*SB20-1080 - FIN */
	
	--  Oferta Web y Lanzamiento
	INSERT INTO #TEMPORAL
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		te.Orden Orden1,
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		te.flagNueva,
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar	--Oferta Web
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
	FROM Estrategia E
	INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo
	INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND E.CampaniaID = @CampaniaID
		AND TE.flagRecoProduc = 0
		AND TE.flagNueva = 0
		AND TE.flagRecoPerfil = 0
		AND E.Zona LIKE '%' + @ZonaID + '%'
	ORDER BY
		te.Orden ASC,
		e.Orden ASC


	SELECT
		T.EstrategiaID,
		T.CUV2,
		T.DescripcionCUV2,
		T.EtiquetaDescripcion,
		T.Precio,
		T.EtiquetaDescripcion2,
		T.Precio2,
		T.TextoLibre,
		T.FlagEstrella,
		T.ColorFondo,
		T.TipoEstrategiaID,
		T.FotoProducto01,
		T.ImagenURL,
		T.LimiteVenta,
		T.MarcaID,
		T.Orden1,
		T.Orden2,
		T.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		T.FlagNueva, -- R2621
		T.TipoTallaColor,
		case
			when UPPER(TE.DescripcionEstrategia) = 'LANZAMIENTO' then 5		--Lanzamiento
			else T.TipoEstrategiaImagenMostrar
		end as TipoEstrategiaImagenMostrar,
		T.CodigoProducto as CodigoProducto
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg		/* SB20-353 */
		, T.EtiquetaID		-- SB20-351
		, T.EtiquetaID2		-- SB20-351
	FROM #TEMPORAL T
	INNER JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = T.TipoEstrategiaID
	LEFT JOIN Marca M ON M.MarcaId = T.MarcaId
	--ORDER BY Orden1 ASC, Orden2 ASC, EstrategiaID ASC
	ORDER BY
 Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL
	SET NOCOUNT OFF
END


GO

ALTER PROCEDURE [dbo].[ListarTipoEstrategia_SB2]  
 @TipoEstrategiaID INT  
AS  
BEGIN  
/*  
 EXEC ListarTipoEstrategia_SB2 0  
*/  
 SET NOCOUNT ON  
  SELECT   
   TipoEstrategiaID,   
   DescripcionEstrategia,   
   ISNULL(dbo.ObtenerDescripcionOferta(TipoEstrategiaID),'') AS DescripcionOferta,   
   Orden,   
   FlagActivo,   
   ISNULL(CodigoPrograma,'') AS CodigoPrograma,
   ISNULL(dbo.ObtenerOfertaID(TipoEstrategiaID),'') AS OfertaID,    
   ImagenEstrategia,  
   FlagNueva,  
   FlagRecoPerfil,  
   FlagRecoProduc
   , ISNULL(FlagMostrarImg,0) AS FlagMostrarImg 		/* SB20-353 */
   , case TipoEstrategiaID
	when 1 then 1
	when 2 then 2
	when 3 then 5
	when 4 then 4
	when 5 then 6
	WHEN 3014 THEN 7
	end as CodigoGeneral
  FROM   
   TipoEstrategia  
  WHERE  
   TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
  ORDER BY Orden, DescripcionEstrategia ASC  
 SET NOCOUNT OFF  
END 


go
