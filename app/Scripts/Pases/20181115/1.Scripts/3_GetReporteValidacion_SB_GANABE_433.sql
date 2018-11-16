USE BelcorpPeru
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetReporteValidacion_SB]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetReporteValidacion_SB]
GO
CREATE PROCEDURE [dbo].[GetReporteValidacion_SB] @CampaniaID INT
	,@TipoEstrategia VARCHAR(3)
AS
BEGIN 
	BEGIN TRY
	DECLARE @CodigoTipoEstrategia CHAR(3);

	SET @CodigoTipoEstrategia = CASE @TipoEstrategia
				WHEN 'OPT'
					THEN '001'
				WHEN 'ODD'
					THEN '009'
				WHEN 'OPM'
					THEN '007'
				END;

	SELECT @TipoEstrategia AS TipoPersonalizacion
			,e.CampaniaID AS AnioCampanaVenta
			,'' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = 'OPT'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM dbo.Estrategia e WITH (NOLOCK)
		INNER JOIN  dbo.TipoEstrategia te WITH (NOLOCK) ON e.TipoEstrategiaId = te.TipoEstrategiaId
			AND te.Codigo = @CodigoTipoEstrategia
		INNER JOIN ods.Campania c WITH (NOLOCK) ON c.Codigo = e.CampaniaID
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID

	END TRY

	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000)
			,@ErrorSeverity INT
			,@ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE()
			,@ErrorSeverity = ERROR_SEVERITY()
			,@ErrorState = ERROR_STATE()

		RAISERROR (
				@ErrorMessage
				,@ErrorSeverity
				,@ErrorState
				)
	END CATCH
END 
GO

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetReporteValidacion_SB]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetReporteValidacion_SB]
GO
CREATE PROCEDURE [dbo].[GetReporteValidacion_SB] @CampaniaID INT
	,@TipoEstrategia VARCHAR(3)
AS
BEGIN 
	BEGIN TRY
	DECLARE @CodigoTipoEstrategia CHAR(3);

	SET @CodigoTipoEstrategia = CASE @TipoEstrategia
				WHEN 'OPT'
					THEN '001'
				WHEN 'ODD'
					THEN '009'
				WHEN 'OPM'
					THEN '007'
				END;

	SELECT @TipoEstrategia AS TipoPersonalizacion
			,e.CampaniaID AS AnioCampanaVenta
			,'' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = 'OPT'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM dbo.Estrategia e WITH (NOLOCK)
		INNER JOIN  dbo.TipoEstrategia te WITH (NOLOCK) ON e.TipoEstrategiaId = te.TipoEstrategiaId
			AND te.Codigo = @CodigoTipoEstrategia
		INNER JOIN ods.Campania c WITH (NOLOCK) ON c.Codigo = e.CampaniaID
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID

	END TRY

	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000)
			,@ErrorSeverity INT
			,@ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE()
			,@ErrorSeverity = ERROR_SEVERITY()
			,@ErrorState = ERROR_STATE()

		RAISERROR (
				@ErrorMessage
				,@ErrorSeverity
				,@ErrorState
				)
	END CATCH
END 
GO

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetReporteValidacion_SB]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetReporteValidacion_SB]
GO
CREATE PROCEDURE [dbo].[GetReporteValidacion_SB] @CampaniaID INT
	,@TipoEstrategia VARCHAR(3)
AS
BEGIN 
	BEGIN TRY
	DECLARE @CodigoTipoEstrategia CHAR(3);

	SET @CodigoTipoEstrategia = CASE @TipoEstrategia
				WHEN 'OPT'
					THEN '001'
				WHEN 'ODD'
					THEN '009'
				WHEN 'OPM'
					THEN '007'
				END;

	SELECT @TipoEstrategia AS TipoPersonalizacion
			,e.CampaniaID AS AnioCampanaVenta
			,'' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = 'OPT'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM dbo.Estrategia e WITH (NOLOCK)
		INNER JOIN  dbo.TipoEstrategia te WITH (NOLOCK) ON e.TipoEstrategiaId = te.TipoEstrategiaId
			AND te.Codigo = @CodigoTipoEstrategia
		INNER JOIN ods.Campania c WITH (NOLOCK) ON c.Codigo = e.CampaniaID
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID

	END TRY

	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000)
			,@ErrorSeverity INT
			,@ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE()
			,@ErrorSeverity = ERROR_SEVERITY()
			,@ErrorState = ERROR_STATE()

		RAISERROR (
				@ErrorMessage
				,@ErrorSeverity
				,@ErrorState
				)
	END CATCH
END 
GO

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetReporteValidacion_SB]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetReporteValidacion_SB]
GO
CREATE PROCEDURE [dbo].[GetReporteValidacion_SB] @CampaniaID INT
	,@TipoEstrategia VARCHAR(3)
AS
BEGIN 
	BEGIN TRY
	DECLARE @CodigoTipoEstrategia CHAR(3);

	SET @CodigoTipoEstrategia = CASE @TipoEstrategia
				WHEN 'OPT'
					THEN '001'
				WHEN 'ODD'
					THEN '009'
				WHEN 'OPM'
					THEN '007'
				END;

	SELECT @TipoEstrategia AS TipoPersonalizacion
			,e.CampaniaID AS AnioCampanaVenta
			,'' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = 'OPT'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM dbo.Estrategia e WITH (NOLOCK)
		INNER JOIN  dbo.TipoEstrategia te WITH (NOLOCK) ON e.TipoEstrategiaId = te.TipoEstrategiaId
			AND te.Codigo = @CodigoTipoEstrategia
		INNER JOIN ods.Campania c WITH (NOLOCK) ON c.Codigo = e.CampaniaID
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID

	END TRY

	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000)
			,@ErrorSeverity INT
			,@ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE()
			,@ErrorSeverity = ERROR_SEVERITY()
			,@ErrorState = ERROR_STATE()

		RAISERROR (
				@ErrorMessage
				,@ErrorSeverity
				,@ErrorState
				)
	END CATCH
END 
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetReporteValidacion_SB]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetReporteValidacion_SB]
GO
CREATE PROCEDURE [dbo].[GetReporteValidacion_SB] @CampaniaID INT
	,@TipoEstrategia VARCHAR(3)
AS
BEGIN 
	BEGIN TRY
	DECLARE @CodigoTipoEstrategia CHAR(3);

	SET @CodigoTipoEstrategia = CASE @TipoEstrategia
				WHEN 'OPT'
					THEN '001'
				WHEN 'ODD'
					THEN '009'
				WHEN 'OPM'
					THEN '007'
				END;

	SELECT @TipoEstrategia AS TipoPersonalizacion
			,e.CampaniaID AS AnioCampanaVenta
			,'' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = 'OPT'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM dbo.Estrategia e WITH (NOLOCK)
		INNER JOIN  dbo.TipoEstrategia te WITH (NOLOCK) ON e.TipoEstrategiaId = te.TipoEstrategiaId
			AND te.Codigo = @CodigoTipoEstrategia
		INNER JOIN ods.Campania c WITH (NOLOCK) ON c.Codigo = e.CampaniaID
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID

	END TRY

	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000)
			,@ErrorSeverity INT
			,@ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE()
			,@ErrorSeverity = ERROR_SEVERITY()
			,@ErrorState = ERROR_STATE()

		RAISERROR (
				@ErrorMessage
				,@ErrorSeverity
				,@ErrorState
				)
	END CATCH
END 
GO

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetReporteValidacion_SB]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetReporteValidacion_SB]
GO
CREATE PROCEDURE [dbo].[GetReporteValidacion_SB] @CampaniaID INT
	,@TipoEstrategia VARCHAR(3)
AS
BEGIN 
	BEGIN TRY
	DECLARE @CodigoTipoEstrategia CHAR(3);

	SET @CodigoTipoEstrategia = CASE @TipoEstrategia
				WHEN 'OPT'
					THEN '001'
				WHEN 'ODD'
					THEN '009'
				WHEN 'OPM'
					THEN '007'
				END;

	SELECT @TipoEstrategia AS TipoPersonalizacion
			,e.CampaniaID AS AnioCampanaVenta
			,'' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = 'OPT'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM dbo.Estrategia e WITH (NOLOCK)
		INNER JOIN  dbo.TipoEstrategia te WITH (NOLOCK) ON e.TipoEstrategiaId = te.TipoEstrategiaId
			AND te.Codigo = @CodigoTipoEstrategia
		INNER JOIN ods.Campania c WITH (NOLOCK) ON c.Codigo = e.CampaniaID
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID

	END TRY

	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000)
			,@ErrorSeverity INT
			,@ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE()
			,@ErrorSeverity = ERROR_SEVERITY()
			,@ErrorState = ERROR_STATE()

		RAISERROR (
				@ErrorMessage
				,@ErrorSeverity
				,@ErrorState
				)
	END CATCH
END 
GO

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetReporteValidacion_SB]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetReporteValidacion_SB]
GO
CREATE PROCEDURE [dbo].[GetReporteValidacion_SB] @CampaniaID INT
	,@TipoEstrategia VARCHAR(3)
AS
BEGIN 
	BEGIN TRY
	DECLARE @CodigoTipoEstrategia CHAR(3);

	SET @CodigoTipoEstrategia = CASE @TipoEstrategia
				WHEN 'OPT'
					THEN '001'
				WHEN 'ODD'
					THEN '009'
				WHEN 'OPM'
					THEN '007'
				END;

	SELECT @TipoEstrategia AS TipoPersonalizacion
			,e.CampaniaID AS AnioCampanaVenta
			,'' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = 'OPT'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM dbo.Estrategia e WITH (NOLOCK)
		INNER JOIN  dbo.TipoEstrategia te WITH (NOLOCK) ON e.TipoEstrategiaId = te.TipoEstrategiaId
			AND te.Codigo = @CodigoTipoEstrategia
		INNER JOIN ods.Campania c WITH (NOLOCK) ON c.Codigo = e.CampaniaID
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID

	END TRY

	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000)
			,@ErrorSeverity INT
			,@ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE()
			,@ErrorSeverity = ERROR_SEVERITY()
			,@ErrorState = ERROR_STATE()

		RAISERROR (
				@ErrorMessage
				,@ErrorSeverity
				,@ErrorState
				)
	END CATCH
END 
GO

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetReporteValidacion_SB]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetReporteValidacion_SB]
GO
CREATE PROCEDURE [dbo].[GetReporteValidacion_SB] @CampaniaID INT
	,@TipoEstrategia VARCHAR(3)
AS
BEGIN 
	BEGIN TRY
	DECLARE @CodigoTipoEstrategia CHAR(3);

	SET @CodigoTipoEstrategia = CASE @TipoEstrategia
				WHEN 'OPT'
					THEN '001'
				WHEN 'ODD'
					THEN '009'
				WHEN 'OPM'
					THEN '007'
				END;

	SELECT @TipoEstrategia AS TipoPersonalizacion
			,e.CampaniaID AS AnioCampanaVenta
			,'' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = 'OPT'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM dbo.Estrategia e WITH (NOLOCK)
		INNER JOIN  dbo.TipoEstrategia te WITH (NOLOCK) ON e.TipoEstrategiaId = te.TipoEstrategiaId
			AND te.Codigo = @CodigoTipoEstrategia
		INNER JOIN ods.Campania c WITH (NOLOCK) ON c.Codigo = e.CampaniaID
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID

	END TRY

	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000)
			,@ErrorSeverity INT
			,@ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE()
			,@ErrorSeverity = ERROR_SEVERITY()
			,@ErrorState = ERROR_STATE()

		RAISERROR (
				@ErrorMessage
				,@ErrorSeverity
				,@ErrorState
				)
	END CATCH
END 
GO

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetReporteValidacion_SB]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetReporteValidacion_SB]
GO
CREATE PROCEDURE [dbo].[GetReporteValidacion_SB] @CampaniaID INT
	,@TipoEstrategia VARCHAR(3)
AS
BEGIN 
	BEGIN TRY
	DECLARE @CodigoTipoEstrategia CHAR(3);

	SET @CodigoTipoEstrategia = CASE @TipoEstrategia
				WHEN 'OPT'
					THEN '001'
				WHEN 'ODD'
					THEN '009'
				WHEN 'OPM'
					THEN '007'
				END;

	SELECT @TipoEstrategia AS TipoPersonalizacion
			,e.CampaniaID AS AnioCampanaVenta
			,'' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = 'OPT'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM dbo.Estrategia e WITH (NOLOCK)
		INNER JOIN  dbo.TipoEstrategia te WITH (NOLOCK) ON e.TipoEstrategiaId = te.TipoEstrategiaId
			AND te.Codigo = @CodigoTipoEstrategia
		INNER JOIN ods.Campania c WITH (NOLOCK) ON c.Codigo = e.CampaniaID
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID

	END TRY

	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000)
			,@ErrorSeverity INT
			,@ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE()
			,@ErrorSeverity = ERROR_SEVERITY()
			,@ErrorState = ERROR_STATE()

		RAISERROR (
				@ErrorMessage
				,@ErrorSeverity
				,@ErrorState
				)
	END CATCH
END 
GO

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetReporteValidacion_SB]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetReporteValidacion_SB]
GO
CREATE PROCEDURE [dbo].[GetReporteValidacion_SB] @CampaniaID INT
	,@TipoEstrategia VARCHAR(3)
AS
BEGIN 
	BEGIN TRY
	DECLARE @CodigoTipoEstrategia CHAR(3);

	SET @CodigoTipoEstrategia = CASE @TipoEstrategia
				WHEN 'OPT'
					THEN '001'
				WHEN 'ODD'
					THEN '009'
				WHEN 'OPM'
					THEN '007'
				END;

	SELECT @TipoEstrategia AS TipoPersonalizacion
			,e.CampaniaID AS AnioCampanaVenta
			,'' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = 'OPT'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM dbo.Estrategia e WITH (NOLOCK)
		INNER JOIN  dbo.TipoEstrategia te WITH (NOLOCK) ON e.TipoEstrategiaId = te.TipoEstrategiaId
			AND te.Codigo = @CodigoTipoEstrategia
		INNER JOIN ods.Campania c WITH (NOLOCK) ON c.Codigo = e.CampaniaID
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID

	END TRY

	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000)
			,@ErrorSeverity INT
			,@ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE()
			,@ErrorSeverity = ERROR_SEVERITY()
			,@ErrorState = ERROR_STATE()

		RAISERROR (
				@ErrorMessage
				,@ErrorSeverity
				,@ErrorState
				)
	END CATCH
END 
GO

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetReporteValidacion_SB]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetReporteValidacion_SB]
GO
CREATE PROCEDURE [dbo].[GetReporteValidacion_SB] @CampaniaID INT
	,@TipoEstrategia VARCHAR(3)
AS
BEGIN 
	BEGIN TRY
	DECLARE @CodigoTipoEstrategia CHAR(3);

	SET @CodigoTipoEstrategia = CASE @TipoEstrategia
				WHEN 'OPT'
					THEN '001'
				WHEN 'ODD'
					THEN '009'
				WHEN 'OPM'
					THEN '007'
				END;

	SELECT @TipoEstrategia AS TipoPersonalizacion
			,e.CampaniaID AS AnioCampanaVenta
			,'' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = 'OPT'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM dbo.Estrategia e WITH (NOLOCK)
		INNER JOIN  dbo.TipoEstrategia te WITH (NOLOCK) ON e.TipoEstrategiaId = te.TipoEstrategiaId
			AND te.Codigo = @CodigoTipoEstrategia
		INNER JOIN ods.Campania c WITH (NOLOCK) ON c.Codigo = e.CampaniaID
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID

	END TRY

	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000)
			,@ErrorSeverity INT
			,@ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE()
			,@ErrorSeverity = ERROR_SEVERITY()
			,@ErrorState = ERROR_STATE()

		RAISERROR (
				@ErrorMessage
				,@ErrorSeverity
				,@ErrorState
				)
	END CATCH
END 
GO

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetReporteValidacion_SB]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetReporteValidacion_SB]
GO
CREATE PROCEDURE [dbo].[GetReporteValidacion_SB] @CampaniaID INT
	,@TipoEstrategia VARCHAR(3)
AS
BEGIN 
	BEGIN TRY
	DECLARE @CodigoTipoEstrategia CHAR(3);

	SET @CodigoTipoEstrategia = CASE @TipoEstrategia
				WHEN 'OPT'
					THEN '001'
				WHEN 'ODD'
					THEN '009'
				WHEN 'OPM'
					THEN '007'
				END;

	SELECT @TipoEstrategia AS TipoPersonalizacion
			,e.CampaniaID AS AnioCampanaVenta
			,'' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = 'OPT'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM dbo.Estrategia e WITH (NOLOCK)
		INNER JOIN  dbo.TipoEstrategia te WITH (NOLOCK) ON e.TipoEstrategiaId = te.TipoEstrategiaId
			AND te.Codigo = @CodigoTipoEstrategia
		INNER JOIN ods.Campania c WITH (NOLOCK) ON c.Codigo = e.CampaniaID
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID

	END TRY

	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000)
			,@ErrorSeverity INT
			,@ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE()
			,@ErrorSeverity = ERROR_SEVERITY()
			,@ErrorState = ERROR_STATE()

		RAISERROR (
				@ErrorMessage
				,@ErrorSeverity
				,@ErrorState
				)
	END CATCH
END 
GO

