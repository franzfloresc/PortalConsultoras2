USE BelcorpBolivia
GO

ALTER PROCEDURE dbo.ObtenerComunicadoPorConsultora @CodigoConsultora VARCHAR(20)
	,@TipoDispositivo SMALLINT = 2
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @vCodigoConsultora VARCHAR(20)
		,@vTipoDispositivo SMALLINT;

	SET @vCodigoConsultora = @CodigoConsultora;
	SET @vTipoDispositivo = @TipoDispositivo;

	DECLARE @FechaHoraPais DATETIME
	DECLARE @TBL_COMUNICADO TABLE (
		ComunicadoId BIGINT NOT NULL
		,CodigoConsultora VARCHAR(20) NOT NULL
		,CodigoCampania VARCHAR(8) NULL
		,Accion VARCHAR(3) NULL
		,DescripcionAccion VARCHAR(350) NULL
		,UrlImagen VARCHAR(350) NULL
		,Visualizo BIT NOT NULL
		,Orden INT NULL
		,Descripcion VARCHAR(500) NULL
		,SegmentacionID INT NULL
		,SegmentacionConsultora BIT NOT NULL
		,SegmentacionRegionZona BIT NOT NULL
		,SegmentacionEstadoActividad BIT NOT NULL
		,TipoComunicado INT NULL
		,PRIMARY KEY (ComunicadoId)
		)

	SELECT @FechaHoraPais = dbo.fnObtenerFechaHoraPais()

	INSERT INTO @TBL_COMUNICADO (
		ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
		)
	SELECT C.ComunicadoId
		,@vCodigoConsultora AS CodigoConsultora
		,C.CodigoCampania
		,C.Accion
		,C.DescripcionAccion
		,C.UrlImagen
		,0 AS Visualizo
		,C.Orden
		,C.Descripcion
		,C.SegmentacionID
		,ISNULL(C.SegmentacionConsultora, 0)
		,ISNULL(C.SegmentacionRegionZona, 0)
		,ISNULL(C.SegmentacionEstadoActividad, 0)
		,TipoComunicado
	FROM dbo.Comunicado C(NOLOCK)
	WHERE C.Activo = 1
		AND C.TipoDispositivo =IIF(C.TipoDispositivo = 0,C.TipoDispositivo, @vTipoDispositivo)
		AND @FechaHoraPais BETWEEN ISNULL(C.FechaInicio, @FechaHoraPais)
			AND ISNULL(C.FechaFin, @FechaHoraPais)
		AND NOT EXISTS (
			SELECT 1
			FROM dbo.VisualizacionComunicado VC(NOLOCK)
			WHERE VC.CodigoConsultora = @vCodigoConsultora
				AND VC.ComunicadoId = C.ComunicadoId
				AND ISNULL(VC.NoMostrar, 0) = 1
			)

	SELECT ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
	FROM @TBL_COMUNICADO
	ORDER BY Orden DESC

	SELECT CV.ComunicadoVistaId
		,CV.ComunicadoId
		,CV.NombreControlador
		,CV.NombreVista
	FROM dbo.ComunicadoVista CV(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON CV.ComunicadoId = C.ComunicadoId

	SELECT SC.SegmentacionComunicadoId
		,C.ComunicadoId
		,SC.SegmentacionID
		,SC.CodigoConsultora
		,SC.CodigoRegion
		,SC.CodigoZona
		,SC.IdEstadoActividad
	FROM dbo.SegmentacionComunicado SC(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON SC.SegmentacionID = C.SegmentacionID

	SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE dbo.ObtenerComunicadoPorConsultora @CodigoConsultora VARCHAR(20)
	,@TipoDispositivo SMALLINT = 2
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @vCodigoConsultora VARCHAR(20)
		,@vTipoDispositivo SMALLINT;

	SET @vCodigoConsultora = @CodigoConsultora;
	SET @vTipoDispositivo = @TipoDispositivo;

	DECLARE @FechaHoraPais DATETIME
	DECLARE @TBL_COMUNICADO TABLE (
		ComunicadoId BIGINT NOT NULL
		,CodigoConsultora VARCHAR(20) NOT NULL
		,CodigoCampania VARCHAR(8) NULL
		,Accion VARCHAR(3) NULL
		,DescripcionAccion VARCHAR(350) NULL
		,UrlImagen VARCHAR(350) NULL
		,Visualizo BIT NOT NULL
		,Orden INT NULL
		,Descripcion VARCHAR(500) NULL
		,SegmentacionID INT NULL
		,SegmentacionConsultora BIT NOT NULL
		,SegmentacionRegionZona BIT NOT NULL
		,SegmentacionEstadoActividad BIT NOT NULL
		,TipoComunicado INT NULL
		,PRIMARY KEY (ComunicadoId)
		)

	SELECT @FechaHoraPais = dbo.fnObtenerFechaHoraPais()

	INSERT INTO @TBL_COMUNICADO (
		ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
		)
	SELECT C.ComunicadoId
		,@vCodigoConsultora AS CodigoConsultora
		,C.CodigoCampania
		,C.Accion
		,C.DescripcionAccion
		,C.UrlImagen
		,0 AS Visualizo
		,C.Orden
		,C.Descripcion
		,C.SegmentacionID
		,ISNULL(C.SegmentacionConsultora, 0)
		,ISNULL(C.SegmentacionRegionZona, 0)
		,ISNULL(C.SegmentacionEstadoActividad, 0)
		,TipoComunicado
	FROM dbo.Comunicado C(NOLOCK)
	WHERE C.Activo = 1
		AND C.TipoDispositivo =IIF(C.TipoDispositivo = 0,C.TipoDispositivo, @vTipoDispositivo)
		AND @FechaHoraPais BETWEEN ISNULL(C.FechaInicio, @FechaHoraPais)
			AND ISNULL(C.FechaFin, @FechaHoraPais)
		AND NOT EXISTS (
			SELECT 1
			FROM dbo.VisualizacionComunicado VC(NOLOCK)
			WHERE VC.CodigoConsultora = @vCodigoConsultora
				AND VC.ComunicadoId = C.ComunicadoId
				AND ISNULL(VC.NoMostrar, 0) = 1
			)

	SELECT ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
	FROM @TBL_COMUNICADO
	ORDER BY Orden DESC

	SELECT CV.ComunicadoVistaId
		,CV.ComunicadoId
		,CV.NombreControlador
		,CV.NombreVista
	FROM dbo.ComunicadoVista CV(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON CV.ComunicadoId = C.ComunicadoId

	SELECT SC.SegmentacionComunicadoId
		,C.ComunicadoId
		,SC.SegmentacionID
		,SC.CodigoConsultora
		,SC.CodigoRegion
		,SC.CodigoZona
		,SC.IdEstadoActividad
	FROM dbo.SegmentacionComunicado SC(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON SC.SegmentacionID = C.SegmentacionID

	SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE dbo.ObtenerComunicadoPorConsultora @CodigoConsultora VARCHAR(20)
	,@TipoDispositivo SMALLINT = 2
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @vCodigoConsultora VARCHAR(20)
		,@vTipoDispositivo SMALLINT;

	SET @vCodigoConsultora = @CodigoConsultora;
	SET @vTipoDispositivo = @TipoDispositivo;

	DECLARE @FechaHoraPais DATETIME
	DECLARE @TBL_COMUNICADO TABLE (
		ComunicadoId BIGINT NOT NULL
		,CodigoConsultora VARCHAR(20) NOT NULL
		,CodigoCampania VARCHAR(8) NULL
		,Accion VARCHAR(3) NULL
		,DescripcionAccion VARCHAR(350) NULL
		,UrlImagen VARCHAR(350) NULL
		,Visualizo BIT NOT NULL
		,Orden INT NULL
		,Descripcion VARCHAR(500) NULL
		,SegmentacionID INT NULL
		,SegmentacionConsultora BIT NOT NULL
		,SegmentacionRegionZona BIT NOT NULL
		,SegmentacionEstadoActividad BIT NOT NULL
		,TipoComunicado INT NULL
		,PRIMARY KEY (ComunicadoId)
		)

	SELECT @FechaHoraPais = dbo.fnObtenerFechaHoraPais()

	INSERT INTO @TBL_COMUNICADO (
		ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
		)
	SELECT C.ComunicadoId
		,@vCodigoConsultora AS CodigoConsultora
		,C.CodigoCampania
		,C.Accion
		,C.DescripcionAccion
		,C.UrlImagen
		,0 AS Visualizo
		,C.Orden
		,C.Descripcion
		,C.SegmentacionID
		,ISNULL(C.SegmentacionConsultora, 0)
		,ISNULL(C.SegmentacionRegionZona, 0)
		,ISNULL(C.SegmentacionEstadoActividad, 0)
		,TipoComunicado
	FROM dbo.Comunicado C(NOLOCK)
	WHERE C.Activo = 1
		AND C.TipoDispositivo =IIF(C.TipoDispositivo = 0,C.TipoDispositivo, @vTipoDispositivo)
		AND @FechaHoraPais BETWEEN ISNULL(C.FechaInicio, @FechaHoraPais)
			AND ISNULL(C.FechaFin, @FechaHoraPais)
		AND NOT EXISTS (
			SELECT 1
			FROM dbo.VisualizacionComunicado VC(NOLOCK)
			WHERE VC.CodigoConsultora = @vCodigoConsultora
				AND VC.ComunicadoId = C.ComunicadoId
				AND ISNULL(VC.NoMostrar, 0) = 1
			)

	SELECT ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
	FROM @TBL_COMUNICADO
	ORDER BY Orden DESC

	SELECT CV.ComunicadoVistaId
		,CV.ComunicadoId
		,CV.NombreControlador
		,CV.NombreVista
	FROM dbo.ComunicadoVista CV(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON CV.ComunicadoId = C.ComunicadoId

	SELECT SC.SegmentacionComunicadoId
		,C.ComunicadoId
		,SC.SegmentacionID
		,SC.CodigoConsultora
		,SC.CodigoRegion
		,SC.CodigoZona
		,SC.IdEstadoActividad
	FROM dbo.SegmentacionComunicado SC(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON SC.SegmentacionID = C.SegmentacionID

	SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE dbo.ObtenerComunicadoPorConsultora @CodigoConsultora VARCHAR(20)
	,@TipoDispositivo SMALLINT = 2
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @vCodigoConsultora VARCHAR(20)
		,@vTipoDispositivo SMALLINT;

	SET @vCodigoConsultora = @CodigoConsultora;
	SET @vTipoDispositivo = @TipoDispositivo;

	DECLARE @FechaHoraPais DATETIME
	DECLARE @TBL_COMUNICADO TABLE (
		ComunicadoId BIGINT NOT NULL
		,CodigoConsultora VARCHAR(20) NOT NULL
		,CodigoCampania VARCHAR(8) NULL
		,Accion VARCHAR(3) NULL
		,DescripcionAccion VARCHAR(350) NULL
		,UrlImagen VARCHAR(350) NULL
		,Visualizo BIT NOT NULL
		,Orden INT NULL
		,Descripcion VARCHAR(500) NULL
		,SegmentacionID INT NULL
		,SegmentacionConsultora BIT NOT NULL
		,SegmentacionRegionZona BIT NOT NULL
		,SegmentacionEstadoActividad BIT NOT NULL
		,TipoComunicado INT NULL
		,PRIMARY KEY (ComunicadoId)
		)

	SELECT @FechaHoraPais = dbo.fnObtenerFechaHoraPais()

	INSERT INTO @TBL_COMUNICADO (
		ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
		)
	SELECT C.ComunicadoId
		,@vCodigoConsultora AS CodigoConsultora
		,C.CodigoCampania
		,C.Accion
		,C.DescripcionAccion
		,C.UrlImagen
		,0 AS Visualizo
		,C.Orden
		,C.Descripcion
		,C.SegmentacionID
		,ISNULL(C.SegmentacionConsultora, 0)
		,ISNULL(C.SegmentacionRegionZona, 0)
		,ISNULL(C.SegmentacionEstadoActividad, 0)
		,TipoComunicado
	FROM dbo.Comunicado C(NOLOCK)
	WHERE C.Activo = 1
		AND C.TipoDispositivo =IIF(C.TipoDispositivo = 0,C.TipoDispositivo, @vTipoDispositivo)
		AND @FechaHoraPais BETWEEN ISNULL(C.FechaInicio, @FechaHoraPais)
			AND ISNULL(C.FechaFin, @FechaHoraPais)
		AND NOT EXISTS (
			SELECT 1
			FROM dbo.VisualizacionComunicado VC(NOLOCK)
			WHERE VC.CodigoConsultora = @vCodigoConsultora
				AND VC.ComunicadoId = C.ComunicadoId
				AND ISNULL(VC.NoMostrar, 0) = 1
			)

	SELECT ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
	FROM @TBL_COMUNICADO
	ORDER BY Orden DESC

	SELECT CV.ComunicadoVistaId
		,CV.ComunicadoId
		,CV.NombreControlador
		,CV.NombreVista
	FROM dbo.ComunicadoVista CV(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON CV.ComunicadoId = C.ComunicadoId

	SELECT SC.SegmentacionComunicadoId
		,C.ComunicadoId
		,SC.SegmentacionID
		,SC.CodigoConsultora
		,SC.CodigoRegion
		,SC.CodigoZona
		,SC.IdEstadoActividad
	FROM dbo.SegmentacionComunicado SC(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON SC.SegmentacionID = C.SegmentacionID

	SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE dbo.ObtenerComunicadoPorConsultora @CodigoConsultora VARCHAR(20)
	,@TipoDispositivo SMALLINT = 2
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @vCodigoConsultora VARCHAR(20)
		,@vTipoDispositivo SMALLINT;

	SET @vCodigoConsultora = @CodigoConsultora;
	SET @vTipoDispositivo = @TipoDispositivo;

	DECLARE @FechaHoraPais DATETIME
	DECLARE @TBL_COMUNICADO TABLE (
		ComunicadoId BIGINT NOT NULL
		,CodigoConsultora VARCHAR(20) NOT NULL
		,CodigoCampania VARCHAR(8) NULL
		,Accion VARCHAR(3) NULL
		,DescripcionAccion VARCHAR(350) NULL
		,UrlImagen VARCHAR(350) NULL
		,Visualizo BIT NOT NULL
		,Orden INT NULL
		,Descripcion VARCHAR(500) NULL
		,SegmentacionID INT NULL
		,SegmentacionConsultora BIT NOT NULL
		,SegmentacionRegionZona BIT NOT NULL
		,SegmentacionEstadoActividad BIT NOT NULL
		,TipoComunicado INT NULL
		,PRIMARY KEY (ComunicadoId)
		)

	SELECT @FechaHoraPais = dbo.fnObtenerFechaHoraPais()

	INSERT INTO @TBL_COMUNICADO (
		ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
		)
	SELECT C.ComunicadoId
		,@vCodigoConsultora AS CodigoConsultora
		,C.CodigoCampania
		,C.Accion
		,C.DescripcionAccion
		,C.UrlImagen
		,0 AS Visualizo
		,C.Orden
		,C.Descripcion
		,C.SegmentacionID
		,ISNULL(C.SegmentacionConsultora, 0)
		,ISNULL(C.SegmentacionRegionZona, 0)
		,ISNULL(C.SegmentacionEstadoActividad, 0)
		,TipoComunicado
	FROM dbo.Comunicado C(NOLOCK)
	WHERE C.Activo = 1
		AND C.TipoDispositivo =IIF(C.TipoDispositivo = 0,C.TipoDispositivo, @vTipoDispositivo)
		AND @FechaHoraPais BETWEEN ISNULL(C.FechaInicio, @FechaHoraPais)
			AND ISNULL(C.FechaFin, @FechaHoraPais)
		AND NOT EXISTS (
			SELECT 1
			FROM dbo.VisualizacionComunicado VC(NOLOCK)
			WHERE VC.CodigoConsultora = @vCodigoConsultora
				AND VC.ComunicadoId = C.ComunicadoId
				AND ISNULL(VC.NoMostrar, 0) = 1
			)

	SELECT ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
	FROM @TBL_COMUNICADO
	ORDER BY Orden DESC

	SELECT CV.ComunicadoVistaId
		,CV.ComunicadoId
		,CV.NombreControlador
		,CV.NombreVista
	FROM dbo.ComunicadoVista CV(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON CV.ComunicadoId = C.ComunicadoId

	SELECT SC.SegmentacionComunicadoId
		,C.ComunicadoId
		,SC.SegmentacionID
		,SC.CodigoConsultora
		,SC.CodigoRegion
		,SC.CodigoZona
		,SC.IdEstadoActividad
	FROM dbo.SegmentacionComunicado SC(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON SC.SegmentacionID = C.SegmentacionID

	SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE dbo.ObtenerComunicadoPorConsultora @CodigoConsultora VARCHAR(20)
	,@TipoDispositivo SMALLINT = 2
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @vCodigoConsultora VARCHAR(20)
		,@vTipoDispositivo SMALLINT;

	SET @vCodigoConsultora = @CodigoConsultora;
	SET @vTipoDispositivo = @TipoDispositivo;

	DECLARE @FechaHoraPais DATETIME
	DECLARE @TBL_COMUNICADO TABLE (
		ComunicadoId BIGINT NOT NULL
		,CodigoConsultora VARCHAR(20) NOT NULL
		,CodigoCampania VARCHAR(8) NULL
		,Accion VARCHAR(3) NULL
		,DescripcionAccion VARCHAR(350) NULL
		,UrlImagen VARCHAR(350) NULL
		,Visualizo BIT NOT NULL
		,Orden INT NULL
		,Descripcion VARCHAR(500) NULL
		,SegmentacionID INT NULL
		,SegmentacionConsultora BIT NOT NULL
		,SegmentacionRegionZona BIT NOT NULL
		,SegmentacionEstadoActividad BIT NOT NULL
		,TipoComunicado INT NULL
		,PRIMARY KEY (ComunicadoId)
		)

	SELECT @FechaHoraPais = dbo.fnObtenerFechaHoraPais()

	INSERT INTO @TBL_COMUNICADO (
		ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
		)
	SELECT C.ComunicadoId
		,@vCodigoConsultora AS CodigoConsultora
		,C.CodigoCampania
		,C.Accion
		,C.DescripcionAccion
		,C.UrlImagen
		,0 AS Visualizo
		,C.Orden
		,C.Descripcion
		,C.SegmentacionID
		,ISNULL(C.SegmentacionConsultora, 0)
		,ISNULL(C.SegmentacionRegionZona, 0)
		,ISNULL(C.SegmentacionEstadoActividad, 0)
		,TipoComunicado
	FROM dbo.Comunicado C(NOLOCK)
	WHERE C.Activo = 1
		AND C.TipoDispositivo =IIF(C.TipoDispositivo = 0,C.TipoDispositivo, @vTipoDispositivo)
		AND @FechaHoraPais BETWEEN ISNULL(C.FechaInicio, @FechaHoraPais)
			AND ISNULL(C.FechaFin, @FechaHoraPais)
		AND NOT EXISTS (
			SELECT 1
			FROM dbo.VisualizacionComunicado VC(NOLOCK)
			WHERE VC.CodigoConsultora = @vCodigoConsultora
				AND VC.ComunicadoId = C.ComunicadoId
				AND ISNULL(VC.NoMostrar, 0) = 1
			)

	SELECT ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
	FROM @TBL_COMUNICADO
	ORDER BY Orden DESC

	SELECT CV.ComunicadoVistaId
		,CV.ComunicadoId
		,CV.NombreControlador
		,CV.NombreVista
	FROM dbo.ComunicadoVista CV(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON CV.ComunicadoId = C.ComunicadoId

	SELECT SC.SegmentacionComunicadoId
		,C.ComunicadoId
		,SC.SegmentacionID
		,SC.CodigoConsultora
		,SC.CodigoRegion
		,SC.CodigoZona
		,SC.IdEstadoActividad
	FROM dbo.SegmentacionComunicado SC(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON SC.SegmentacionID = C.SegmentacionID

	SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE dbo.ObtenerComunicadoPorConsultora @CodigoConsultora VARCHAR(20)
	,@TipoDispositivo SMALLINT = 2
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @vCodigoConsultora VARCHAR(20)
		,@vTipoDispositivo SMALLINT;

	SET @vCodigoConsultora = @CodigoConsultora;
	SET @vTipoDispositivo = @TipoDispositivo;

	DECLARE @FechaHoraPais DATETIME
	DECLARE @TBL_COMUNICADO TABLE (
		ComunicadoId BIGINT NOT NULL
		,CodigoConsultora VARCHAR(20) NOT NULL
		,CodigoCampania VARCHAR(8) NULL
		,Accion VARCHAR(3) NULL
		,DescripcionAccion VARCHAR(350) NULL
		,UrlImagen VARCHAR(350) NULL
		,Visualizo BIT NOT NULL
		,Orden INT NULL
		,Descripcion VARCHAR(500) NULL
		,SegmentacionID INT NULL
		,SegmentacionConsultora BIT NOT NULL
		,SegmentacionRegionZona BIT NOT NULL
		,SegmentacionEstadoActividad BIT NOT NULL
		,TipoComunicado INT NULL
		,PRIMARY KEY (ComunicadoId)
		)

	SELECT @FechaHoraPais = dbo.fnObtenerFechaHoraPais()

	INSERT INTO @TBL_COMUNICADO (
		ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
		)
	SELECT C.ComunicadoId
		,@vCodigoConsultora AS CodigoConsultora
		,C.CodigoCampania
		,C.Accion
		,C.DescripcionAccion
		,C.UrlImagen
		,0 AS Visualizo
		,C.Orden
		,C.Descripcion
		,C.SegmentacionID
		,ISNULL(C.SegmentacionConsultora, 0)
		,ISNULL(C.SegmentacionRegionZona, 0)
		,ISNULL(C.SegmentacionEstadoActividad, 0)
		,TipoComunicado
	FROM dbo.Comunicado C(NOLOCK)
	WHERE C.Activo = 1
		AND C.TipoDispositivo =IIF(C.TipoDispositivo = 0,C.TipoDispositivo, @vTipoDispositivo)
		AND @FechaHoraPais BETWEEN ISNULL(C.FechaInicio, @FechaHoraPais)
			AND ISNULL(C.FechaFin, @FechaHoraPais)
		AND NOT EXISTS (
			SELECT 1
			FROM dbo.VisualizacionComunicado VC(NOLOCK)
			WHERE VC.CodigoConsultora = @vCodigoConsultora
				AND VC.ComunicadoId = C.ComunicadoId
				AND ISNULL(VC.NoMostrar, 0) = 1
			)

	SELECT ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
	FROM @TBL_COMUNICADO
	ORDER BY Orden DESC

	SELECT CV.ComunicadoVistaId
		,CV.ComunicadoId
		,CV.NombreControlador
		,CV.NombreVista
	FROM dbo.ComunicadoVista CV(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON CV.ComunicadoId = C.ComunicadoId

	SELECT SC.SegmentacionComunicadoId
		,C.ComunicadoId
		,SC.SegmentacionID
		,SC.CodigoConsultora
		,SC.CodigoRegion
		,SC.CodigoZona
		,SC.IdEstadoActividad
	FROM dbo.SegmentacionComunicado SC(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON SC.SegmentacionID = C.SegmentacionID

	SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE dbo.ObtenerComunicadoPorConsultora @CodigoConsultora VARCHAR(20)
	,@TipoDispositivo SMALLINT = 2
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @vCodigoConsultora VARCHAR(20)
		,@vTipoDispositivo SMALLINT;

	SET @vCodigoConsultora = @CodigoConsultora;
	SET @vTipoDispositivo = @TipoDispositivo;

	DECLARE @FechaHoraPais DATETIME
	DECLARE @TBL_COMUNICADO TABLE (
		ComunicadoId BIGINT NOT NULL
		,CodigoConsultora VARCHAR(20) NOT NULL
		,CodigoCampania VARCHAR(8) NULL
		,Accion VARCHAR(3) NULL
		,DescripcionAccion VARCHAR(350) NULL
		,UrlImagen VARCHAR(350) NULL
		,Visualizo BIT NOT NULL
		,Orden INT NULL
		,Descripcion VARCHAR(500) NULL
		,SegmentacionID INT NULL
		,SegmentacionConsultora BIT NOT NULL
		,SegmentacionRegionZona BIT NOT NULL
		,SegmentacionEstadoActividad BIT NOT NULL
		,TipoComunicado INT NULL
		,PRIMARY KEY (ComunicadoId)
		)

	SELECT @FechaHoraPais = dbo.fnObtenerFechaHoraPais()

	INSERT INTO @TBL_COMUNICADO (
		ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
		)
	SELECT C.ComunicadoId
		,@vCodigoConsultora AS CodigoConsultora
		,C.CodigoCampania
		,C.Accion
		,C.DescripcionAccion
		,C.UrlImagen
		,0 AS Visualizo
		,C.Orden
		,C.Descripcion
		,C.SegmentacionID
		,ISNULL(C.SegmentacionConsultora, 0)
		,ISNULL(C.SegmentacionRegionZona, 0)
		,ISNULL(C.SegmentacionEstadoActividad, 0)
		,TipoComunicado
	FROM dbo.Comunicado C(NOLOCK)
	WHERE C.Activo = 1
		AND C.TipoDispositivo =IIF(C.TipoDispositivo = 0,C.TipoDispositivo, @vTipoDispositivo)
		AND @FechaHoraPais BETWEEN ISNULL(C.FechaInicio, @FechaHoraPais)
			AND ISNULL(C.FechaFin, @FechaHoraPais)
		AND NOT EXISTS (
			SELECT 1
			FROM dbo.VisualizacionComunicado VC(NOLOCK)
			WHERE VC.CodigoConsultora = @vCodigoConsultora
				AND VC.ComunicadoId = C.ComunicadoId
				AND ISNULL(VC.NoMostrar, 0) = 1
			)

	SELECT ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
	FROM @TBL_COMUNICADO
	ORDER BY Orden DESC

	SELECT CV.ComunicadoVistaId
		,CV.ComunicadoId
		,CV.NombreControlador
		,CV.NombreVista
	FROM dbo.ComunicadoVista CV(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON CV.ComunicadoId = C.ComunicadoId

	SELECT SC.SegmentacionComunicadoId
		,C.ComunicadoId
		,SC.SegmentacionID
		,SC.CodigoConsultora
		,SC.CodigoRegion
		,SC.CodigoZona
		,SC.IdEstadoActividad
	FROM dbo.SegmentacionComunicado SC(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON SC.SegmentacionID = C.SegmentacionID

	SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE dbo.ObtenerComunicadoPorConsultora @CodigoConsultora VARCHAR(20)
	,@TipoDispositivo SMALLINT = 2
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @vCodigoConsultora VARCHAR(20)
		,@vTipoDispositivo SMALLINT;

	SET @vCodigoConsultora = @CodigoConsultora;
	SET @vTipoDispositivo = @TipoDispositivo;

	DECLARE @FechaHoraPais DATETIME
	DECLARE @TBL_COMUNICADO TABLE (
		ComunicadoId BIGINT NOT NULL
		,CodigoConsultora VARCHAR(20) NOT NULL
		,CodigoCampania VARCHAR(8) NULL
		,Accion VARCHAR(3) NULL
		,DescripcionAccion VARCHAR(350) NULL
		,UrlImagen VARCHAR(350) NULL
		,Visualizo BIT NOT NULL
		,Orden INT NULL
		,Descripcion VARCHAR(500) NULL
		,SegmentacionID INT NULL
		,SegmentacionConsultora BIT NOT NULL
		,SegmentacionRegionZona BIT NOT NULL
		,SegmentacionEstadoActividad BIT NOT NULL
		,TipoComunicado INT NULL
		,PRIMARY KEY (ComunicadoId)
		)

	SELECT @FechaHoraPais = dbo.fnObtenerFechaHoraPais()

	INSERT INTO @TBL_COMUNICADO (
		ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
		)
	SELECT C.ComunicadoId
		,@vCodigoConsultora AS CodigoConsultora
		,C.CodigoCampania
		,C.Accion
		,C.DescripcionAccion
		,C.UrlImagen
		,0 AS Visualizo
		,C.Orden
		,C.Descripcion
		,C.SegmentacionID
		,ISNULL(C.SegmentacionConsultora, 0)
		,ISNULL(C.SegmentacionRegionZona, 0)
		,ISNULL(C.SegmentacionEstadoActividad, 0)
		,TipoComunicado
	FROM dbo.Comunicado C(NOLOCK)
	WHERE C.Activo = 1
		AND C.TipoDispositivo =IIF(C.TipoDispositivo = 0,C.TipoDispositivo, @vTipoDispositivo)
		AND @FechaHoraPais BETWEEN ISNULL(C.FechaInicio, @FechaHoraPais)
			AND ISNULL(C.FechaFin, @FechaHoraPais)
		AND NOT EXISTS (
			SELECT 1
			FROM dbo.VisualizacionComunicado VC(NOLOCK)
			WHERE VC.CodigoConsultora = @vCodigoConsultora
				AND VC.ComunicadoId = C.ComunicadoId
				AND ISNULL(VC.NoMostrar, 0) = 1
			)

	SELECT ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
	FROM @TBL_COMUNICADO
	ORDER BY Orden DESC

	SELECT CV.ComunicadoVistaId
		,CV.ComunicadoId
		,CV.NombreControlador
		,CV.NombreVista
	FROM dbo.ComunicadoVista CV(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON CV.ComunicadoId = C.ComunicadoId

	SELECT SC.SegmentacionComunicadoId
		,C.ComunicadoId
		,SC.SegmentacionID
		,SC.CodigoConsultora
		,SC.CodigoRegion
		,SC.CodigoZona
		,SC.IdEstadoActividad
	FROM dbo.SegmentacionComunicado SC(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON SC.SegmentacionID = C.SegmentacionID

	SET NOCOUNT OFF
END
GO

USE BelcorpPeru
GO

ALTER PROCEDURE dbo.ObtenerComunicadoPorConsultora @CodigoConsultora VARCHAR(20)
	,@TipoDispositivo SMALLINT = 2
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @vCodigoConsultora VARCHAR(20)
		,@vTipoDispositivo SMALLINT;

	SET @vCodigoConsultora = @CodigoConsultora;
	SET @vTipoDispositivo = @TipoDispositivo;

	DECLARE @FechaHoraPais DATETIME
	DECLARE @TBL_COMUNICADO TABLE (
		ComunicadoId BIGINT NOT NULL
		,CodigoConsultora VARCHAR(20) NOT NULL
		,CodigoCampania VARCHAR(8) NULL
		,Accion VARCHAR(3) NULL
		,DescripcionAccion VARCHAR(350) NULL
		,UrlImagen VARCHAR(350) NULL
		,Visualizo BIT NOT NULL
		,Orden INT NULL
		,Descripcion VARCHAR(500) NULL
		,SegmentacionID INT NULL
		,SegmentacionConsultora BIT NOT NULL
		,SegmentacionRegionZona BIT NOT NULL
		,SegmentacionEstadoActividad BIT NOT NULL
		,TipoComunicado INT NULL
		,PRIMARY KEY (ComunicadoId)
		)

	SELECT @FechaHoraPais = dbo.fnObtenerFechaHoraPais()

	INSERT INTO @TBL_COMUNICADO (
		ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
		)
	SELECT C.ComunicadoId
		,@vCodigoConsultora AS CodigoConsultora
		,C.CodigoCampania
		,C.Accion
		,C.DescripcionAccion
		,C.UrlImagen
		,0 AS Visualizo
		,C.Orden
		,C.Descripcion
		,C.SegmentacionID
		,ISNULL(C.SegmentacionConsultora, 0)
		,ISNULL(C.SegmentacionRegionZona, 0)
		,ISNULL(C.SegmentacionEstadoActividad, 0)
		,TipoComunicado
	FROM dbo.Comunicado C(NOLOCK)
	WHERE C.Activo = 1
		AND C.TipoDispositivo =IIF(C.TipoDispositivo = 0,C.TipoDispositivo, @vTipoDispositivo)
		AND @FechaHoraPais BETWEEN ISNULL(C.FechaInicio, @FechaHoraPais)
			AND ISNULL(C.FechaFin, @FechaHoraPais)
		AND NOT EXISTS (
			SELECT 1
			FROM dbo.VisualizacionComunicado VC(NOLOCK)
			WHERE VC.CodigoConsultora = @vCodigoConsultora
				AND VC.ComunicadoId = C.ComunicadoId
				AND ISNULL(VC.NoMostrar, 0) = 1
			)

	SELECT ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
	FROM @TBL_COMUNICADO
	ORDER BY Orden DESC

	SELECT CV.ComunicadoVistaId
		,CV.ComunicadoId
		,CV.NombreControlador
		,CV.NombreVista
	FROM dbo.ComunicadoVista CV(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON CV.ComunicadoId = C.ComunicadoId

	SELECT SC.SegmentacionComunicadoId
		,C.ComunicadoId
		,SC.SegmentacionID
		,SC.CodigoConsultora
		,SC.CodigoRegion
		,SC.CodigoZona
		,SC.IdEstadoActividad
	FROM dbo.SegmentacionComunicado SC(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON SC.SegmentacionID = C.SegmentacionID

	SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE dbo.ObtenerComunicadoPorConsultora @CodigoConsultora VARCHAR(20)
	,@TipoDispositivo SMALLINT = 2
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @vCodigoConsultora VARCHAR(20)
		,@vTipoDispositivo SMALLINT;

	SET @vCodigoConsultora = @CodigoConsultora;
	SET @vTipoDispositivo = @TipoDispositivo;

	DECLARE @FechaHoraPais DATETIME
	DECLARE @TBL_COMUNICADO TABLE (
		ComunicadoId BIGINT NOT NULL
		,CodigoConsultora VARCHAR(20) NOT NULL
		,CodigoCampania VARCHAR(8) NULL
		,Accion VARCHAR(3) NULL
		,DescripcionAccion VARCHAR(350) NULL
		,UrlImagen VARCHAR(350) NULL
		,Visualizo BIT NOT NULL
		,Orden INT NULL
		,Descripcion VARCHAR(500) NULL
		,SegmentacionID INT NULL
		,SegmentacionConsultora BIT NOT NULL
		,SegmentacionRegionZona BIT NOT NULL
		,SegmentacionEstadoActividad BIT NOT NULL
		,TipoComunicado INT NULL
		,PRIMARY KEY (ComunicadoId)
		)

	SELECT @FechaHoraPais = dbo.fnObtenerFechaHoraPais()

	INSERT INTO @TBL_COMUNICADO (
		ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
		)
	SELECT C.ComunicadoId
		,@vCodigoConsultora AS CodigoConsultora
		,C.CodigoCampania
		,C.Accion
		,C.DescripcionAccion
		,C.UrlImagen
		,0 AS Visualizo
		,C.Orden
		,C.Descripcion
		,C.SegmentacionID
		,ISNULL(C.SegmentacionConsultora, 0)
		,ISNULL(C.SegmentacionRegionZona, 0)
		,ISNULL(C.SegmentacionEstadoActividad, 0)
		,TipoComunicado
	FROM dbo.Comunicado C(NOLOCK)
	WHERE C.Activo = 1
		AND C.TipoDispositivo =IIF(C.TipoDispositivo = 0,C.TipoDispositivo, @vTipoDispositivo)
		AND @FechaHoraPais BETWEEN ISNULL(C.FechaInicio, @FechaHoraPais)
			AND ISNULL(C.FechaFin, @FechaHoraPais)
		AND NOT EXISTS (
			SELECT 1
			FROM dbo.VisualizacionComunicado VC(NOLOCK)
			WHERE VC.CodigoConsultora = @vCodigoConsultora
				AND VC.ComunicadoId = C.ComunicadoId
				AND ISNULL(VC.NoMostrar, 0) = 1
			)

	SELECT ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
	FROM @TBL_COMUNICADO
	ORDER BY Orden DESC

	SELECT CV.ComunicadoVistaId
		,CV.ComunicadoId
		,CV.NombreControlador
		,CV.NombreVista
	FROM dbo.ComunicadoVista CV(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON CV.ComunicadoId = C.ComunicadoId

	SELECT SC.SegmentacionComunicadoId
		,C.ComunicadoId
		,SC.SegmentacionID
		,SC.CodigoConsultora
		,SC.CodigoRegion
		,SC.CodigoZona
		,SC.IdEstadoActividad
	FROM dbo.SegmentacionComunicado SC(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON SC.SegmentacionID = C.SegmentacionID

	SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE dbo.ObtenerComunicadoPorConsultora @CodigoConsultora VARCHAR(20)
	,@TipoDispositivo SMALLINT = 2
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @vCodigoConsultora VARCHAR(20)
		,@vTipoDispositivo SMALLINT;

	SET @vCodigoConsultora = @CodigoConsultora;
	SET @vTipoDispositivo = @TipoDispositivo;

	DECLARE @FechaHoraPais DATETIME
	DECLARE @TBL_COMUNICADO TABLE (
		ComunicadoId BIGINT NOT NULL
		,CodigoConsultora VARCHAR(20) NOT NULL
		,CodigoCampania VARCHAR(8) NULL
		,Accion VARCHAR(3) NULL
		,DescripcionAccion VARCHAR(350) NULL
		,UrlImagen VARCHAR(350) NULL
		,Visualizo BIT NOT NULL
		,Orden INT NULL
		,Descripcion VARCHAR(500) NULL
		,SegmentacionID INT NULL
		,SegmentacionConsultora BIT NOT NULL
		,SegmentacionRegionZona BIT NOT NULL
		,SegmentacionEstadoActividad BIT NOT NULL
		,TipoComunicado INT NULL
		,PRIMARY KEY (ComunicadoId)
		)

	SELECT @FechaHoraPais = dbo.fnObtenerFechaHoraPais()

	INSERT INTO @TBL_COMUNICADO (
		ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
		)
	SELECT C.ComunicadoId
		,@vCodigoConsultora AS CodigoConsultora
		,C.CodigoCampania
		,C.Accion
		,C.DescripcionAccion
		,C.UrlImagen
		,0 AS Visualizo
		,C.Orden
		,C.Descripcion
		,C.SegmentacionID
		,ISNULL(C.SegmentacionConsultora, 0)
		,ISNULL(C.SegmentacionRegionZona, 0)
		,ISNULL(C.SegmentacionEstadoActividad, 0)
		,TipoComunicado
	FROM dbo.Comunicado C(NOLOCK)
	WHERE C.Activo = 1
		AND C.TipoDispositivo =IIF(C.TipoDispositivo = 0,C.TipoDispositivo, @vTipoDispositivo)
		AND @FechaHoraPais BETWEEN ISNULL(C.FechaInicio, @FechaHoraPais)
			AND ISNULL(C.FechaFin, @FechaHoraPais)
		AND NOT EXISTS (
			SELECT 1
			FROM dbo.VisualizacionComunicado VC(NOLOCK)
			WHERE VC.CodigoConsultora = @vCodigoConsultora
				AND VC.ComunicadoId = C.ComunicadoId
				AND ISNULL(VC.NoMostrar, 0) = 1
			)

	SELECT ComunicadoId
		,CodigoConsultora
		,CodigoCampania
		,Accion
		,DescripcionAccion
		,UrlImagen
		,Visualizo
		,Orden
		,Descripcion
		,SegmentacionID
		,SegmentacionConsultora
		,SegmentacionRegionZona
		,SegmentacionEstadoActividad
		,TipoComunicado
	FROM @TBL_COMUNICADO
	ORDER BY Orden DESC

	SELECT CV.ComunicadoVistaId
		,CV.ComunicadoId
		,CV.NombreControlador
		,CV.NombreVista
	FROM dbo.ComunicadoVista CV(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON CV.ComunicadoId = C.ComunicadoId

	SELECT SC.SegmentacionComunicadoId
		,C.ComunicadoId
		,SC.SegmentacionID
		,SC.CodigoConsultora
		,SC.CodigoRegion
		,SC.CodigoZona
		,SC.IdEstadoActividad
	FROM dbo.SegmentacionComunicado SC(NOLOCK)
	INNER JOIN @TBL_COMUNICADO C ON SC.SegmentacionID = C.SegmentacionID

	SET NOCOUNT OFF
END
GO


