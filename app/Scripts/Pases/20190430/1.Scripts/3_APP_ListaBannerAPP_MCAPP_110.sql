USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerAPP]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerAPP]
GO

CREATE PROC [dbo].Lista_BannerAPP
@CodigoConsultora varchar(20)
AS
BEGIN
	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CAD.CodigoDetalle,CAD.RutaContenido,CAD.Accion,CAD.Orden,CAD.Tipo,CAD.Estado EstadoDetalle,
	CAST(CASE 
		WHEN VC.IdVistoContenido IS NULL THEN 0
		ELSE 1
	END AS BIT) ContenidoVisto
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1
	ORDER BY CP.IdContenido,CAD.Orden
END

GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerAPP]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerAPP]
GO

CREATE PROC [dbo].Lista_BannerAPP
@CodigoConsultora varchar(20)
AS
BEGIN
	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CAD.CodigoDetalle,CAD.RutaContenido,CAD.Accion,CAD.Orden,CAD.Tipo,CAD.Estado EstadoDetalle,
	CAST(CASE 
		WHEN VC.IdVistoContenido IS NULL THEN 0
		ELSE 1
	END AS BIT) ContenidoVisto
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1
	ORDER BY CP.IdContenido,CAD.Orden
END

GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerAPP]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerAPP]
GO

CREATE PROC [dbo].Lista_BannerAPP
@CodigoConsultora varchar(20)
AS
BEGIN
	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CAD.CodigoDetalle,CAD.RutaContenido,CAD.Accion,CAD.Orden,CAD.Tipo,CAD.Estado EstadoDetalle,
	CAST(CASE 
		WHEN VC.IdVistoContenido IS NULL THEN 0
		ELSE 1
	END AS BIT) ContenidoVisto
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1
	ORDER BY CP.IdContenido,CAD.Orden
END

GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerAPP]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerAPP]
GO

CREATE PROC [dbo].Lista_BannerAPP
@CodigoConsultora varchar(20)
AS
BEGIN
	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CAD.CodigoDetalle,CAD.RutaContenido,CAD.Accion,CAD.Orden,CAD.Tipo,CAD.Estado EstadoDetalle,
	CAST(CASE 
		WHEN VC.IdVistoContenido IS NULL THEN 0
		ELSE 1
	END AS BIT) ContenidoVisto
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1
	ORDER BY CP.IdContenido,CAD.Orden
END

GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerAPP]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerAPP]
GO

CREATE PROC [dbo].Lista_BannerAPP
@CodigoConsultora varchar(20)
AS
BEGIN
	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CAD.CodigoDetalle,CAD.RutaContenido,CAD.Accion,CAD.Orden,CAD.Tipo,CAD.Estado EstadoDetalle,
	CAST(CASE 
		WHEN VC.IdVistoContenido IS NULL THEN 0
		ELSE 1
	END AS BIT) ContenidoVisto
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1
	ORDER BY CP.IdContenido,CAD.Orden
END

GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerAPP]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerAPP]
GO

CREATE PROC [dbo].Lista_BannerAPP
@CodigoConsultora varchar(20)
AS
BEGIN
	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CAD.CodigoDetalle,CAD.RutaContenido,CAD.Accion,CAD.Orden,CAD.Tipo,CAD.Estado EstadoDetalle,
	CAST(CASE 
		WHEN VC.IdVistoContenido IS NULL THEN 0
		ELSE 1
	END AS BIT) ContenidoVisto
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1
	ORDER BY CP.IdContenido,CAD.Orden
END

GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerAPP]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerAPP]
GO

CREATE PROC [dbo].Lista_BannerAPP
@CodigoConsultora varchar(20)
AS
BEGIN
	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CAD.CodigoDetalle,CAD.RutaContenido,CAD.Accion,CAD.Orden,CAD.Tipo,CAD.Estado EstadoDetalle,
	CAST(CASE 
		WHEN VC.IdVistoContenido IS NULL THEN 0
		ELSE 1
	END AS BIT) ContenidoVisto
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1
	ORDER BY CP.IdContenido,CAD.Orden
END

GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerAPP]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerAPP]
GO

CREATE PROC [dbo].Lista_BannerAPP
@CodigoConsultora varchar(20)
AS
BEGIN
	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CAD.CodigoDetalle,CAD.RutaContenido,CAD.Accion,CAD.Orden,CAD.Tipo,CAD.Estado EstadoDetalle,
	CAST(CASE 
		WHEN VC.IdVistoContenido IS NULL THEN 0
		ELSE 1
	END AS BIT) ContenidoVisto
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1
	ORDER BY CP.IdContenido,CAD.Orden
END

GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerAPP]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerAPP]
GO

CREATE PROC [dbo].Lista_BannerAPP
@CodigoConsultora varchar(20)
AS
BEGIN
	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CAD.CodigoDetalle,CAD.RutaContenido,CAD.Accion,CAD.Orden,CAD.Tipo,CAD.Estado EstadoDetalle,
	CAST(CASE 
		WHEN VC.IdVistoContenido IS NULL THEN 0
		ELSE 1
	END AS BIT) ContenidoVisto
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1
	ORDER BY CP.IdContenido,CAD.Orden
END

GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerAPP]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerAPP]
GO

CREATE PROC [dbo].Lista_BannerAPP
@CodigoConsultora varchar(20)
AS
BEGIN
	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CAD.CodigoDetalle,CAD.RutaContenido,CAD.Accion,CAD.Orden,CAD.Tipo,CAD.Estado EstadoDetalle,
	CAST(CASE 
		WHEN VC.IdVistoContenido IS NULL THEN 0
		ELSE 1
	END AS BIT) ContenidoVisto
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1
	ORDER BY CP.IdContenido,CAD.Orden
END

GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerAPP]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerAPP]
GO

CREATE PROC [dbo].Lista_BannerAPP
@CodigoConsultora varchar(20)
AS
BEGIN
	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CAD.CodigoDetalle,CAD.RutaContenido,CAD.Accion,CAD.Orden,CAD.Tipo,CAD.Estado EstadoDetalle,
	CAST(CASE 
		WHEN VC.IdVistoContenido IS NULL THEN 0
		ELSE 1
	END AS BIT) ContenidoVisto
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1
	ORDER BY CP.IdContenido,CAD.Orden
END

GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerAPP]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerAPP]
GO

CREATE PROC [dbo].Lista_BannerAPP
@CodigoConsultora varchar(20)
AS
BEGIN
	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CAD.CodigoDetalle,CAD.RutaContenido,CAD.Accion,CAD.Orden,CAD.Tipo,CAD.Estado EstadoDetalle,
	CAST(CASE 
		WHEN VC.IdVistoContenido IS NULL THEN 0
		ELSE 1
	END AS BIT) ContenidoVisto
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1
	ORDER BY CP.IdContenido,CAD.Orden
END

GO