USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerLanzamientoAPP]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerLanzamientoAPP]
GO

CREATE PROC [dbo].Lista_BannerLanzamientoAPP
@CodigoConsultora varchar(20),
@Codigo varchar(20)=NULL,
@Capania int=NULL,
@Zona varchar(20)=NULL,
@Region varchar(20)=NULL,
@Seccion varchar(20)=NULL
AS
BEGIN
	SET @Codigo= isnull(@Codigo,'')
	SET @Capania= isnull(@Capania,'')
	SET @Zona= isnull(@Zona,'')
	SET @Region= isnull(@Region,'')
	SET @Seccion= isnull(@Seccion,'')

	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR  @Capania BETWEEN ISNULL(CP.DesdeCampania,@Capania) AND ISNULL(CP.HastaCampania,@Capania))
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CodigoDetalle,RutaContenido,Accion,Orden,Tipo,CAD.Estado EstadoDetalle
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido	LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR CAD.Campania=@Capania) 
	ORDER BY CP.IdContenido,CAD.Orden	
END

GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerLanzamientoAPP]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerLanzamientoAPP]
GO

CREATE PROC [dbo].Lista_BannerLanzamientoAPP
@CodigoConsultora varchar(20),
@Codigo varchar(20)=NULL,
@Capania int=NULL,
@Zona varchar(20)=NULL,
@Region varchar(20)=NULL,
@Seccion varchar(20)=NULL
AS
BEGIN
	SET @Codigo= isnull(@Codigo,'')
	SET @Capania= isnull(@Capania,'')
	SET @Zona= isnull(@Zona,'')
	SET @Region= isnull(@Region,'')
	SET @Seccion= isnull(@Seccion,'')

	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR  @Capania BETWEEN ISNULL(CP.DesdeCampania,@Capania) AND ISNULL(CP.HastaCampania,@Capania))
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CodigoDetalle,RutaContenido,Accion,Orden,Tipo,CAD.Estado EstadoDetalle
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido	LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR CAD.Campania=@Capania) 
	ORDER BY CP.IdContenido,CAD.Orden	
END

GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerLanzamientoAPP]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerLanzamientoAPP]
GO

CREATE PROC [dbo].Lista_BannerLanzamientoAPP
@CodigoConsultora varchar(20),
@Codigo varchar(20)=NULL,
@Capania int=NULL,
@Zona varchar(20)=NULL,
@Region varchar(20)=NULL,
@Seccion varchar(20)=NULL
AS
BEGIN
	SET @Codigo= isnull(@Codigo,'')
	SET @Capania= isnull(@Capania,'')
	SET @Zona= isnull(@Zona,'')
	SET @Region= isnull(@Region,'')
	SET @Seccion= isnull(@Seccion,'')

	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR  @Capania BETWEEN ISNULL(CP.DesdeCampania,@Capania) AND ISNULL(CP.HastaCampania,@Capania))
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CodigoDetalle,RutaContenido,Accion,Orden,Tipo,CAD.Estado EstadoDetalle
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido	LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR CAD.Campania=@Capania) 
	ORDER BY CP.IdContenido,CAD.Orden	
END

GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerLanzamientoAPP]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerLanzamientoAPP]
GO

CREATE PROC [dbo].Lista_BannerLanzamientoAPP
@CodigoConsultora varchar(20),
@Codigo varchar(20)=NULL,
@Capania int=NULL,
@Zona varchar(20)=NULL,
@Region varchar(20)=NULL,
@Seccion varchar(20)=NULL
AS
BEGIN
	SET @Codigo= isnull(@Codigo,'')
	SET @Capania= isnull(@Capania,'')
	SET @Zona= isnull(@Zona,'')
	SET @Region= isnull(@Region,'')
	SET @Seccion= isnull(@Seccion,'')

	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR  @Capania BETWEEN ISNULL(CP.DesdeCampania,@Capania) AND ISNULL(CP.HastaCampania,@Capania))
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CodigoDetalle,RutaContenido,Accion,Orden,Tipo,CAD.Estado EstadoDetalle
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido	LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR CAD.Campania=@Capania) AND 
		(@Zona='' OR CAD.Zona=@Zona) AND (@Region='' OR CAD.Region=@Region) AND (@Region='' OR CAD.Seccion=@Seccion)
	ORDER BY CP.IdContenido,CAD.Orden	
END

GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerLanzamientoAPP]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerLanzamientoAPP]
GO

CREATE PROC [dbo].Lista_BannerLanzamientoAPP
@CodigoConsultora varchar(20),
@Codigo varchar(20)=NULL,
@Capania int=NULL,
@Zona varchar(20)=NULL,
@Region varchar(20)=NULL,
@Seccion varchar(20)=NULL
AS
BEGIN
	SET @Codigo= isnull(@Codigo,'')
	SET @Capania= isnull(@Capania,'')
	SET @Zona= isnull(@Zona,'')
	SET @Region= isnull(@Region,'')
	SET @Seccion= isnull(@Seccion,'')

	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR  @Capania BETWEEN ISNULL(CP.DesdeCampania,@Capania) AND ISNULL(CP.HastaCampania,@Capania))
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CodigoDetalle,RutaContenido,Accion,Orden,Tipo,CAD.Estado EstadoDetalle
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido	LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR CAD.Campania=@Capania) 
	ORDER BY CP.IdContenido,CAD.Orden	
END

GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerLanzamientoAPP]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerLanzamientoAPP]
GO

CREATE PROC [dbo].Lista_BannerLanzamientoAPP
@CodigoConsultora varchar(20),
@Codigo varchar(20)=NULL,
@Capania int=NULL,
@Zona varchar(20)=NULL,
@Region varchar(20)=NULL,
@Seccion varchar(20)=NULL
AS
BEGIN
	SET @Codigo= isnull(@Codigo,'')
	SET @Capania= isnull(@Capania,'')
	SET @Zona= isnull(@Zona,'')
	SET @Region= isnull(@Region,'')
	SET @Seccion= isnull(@Seccion,'')

	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR  @Capania BETWEEN ISNULL(CP.DesdeCampania,@Capania) AND ISNULL(CP.HastaCampania,@Capania))
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CodigoDetalle,RutaContenido,Accion,Orden,Tipo,CAD.Estado EstadoDetalle
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido	LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR CAD.Campania=@Capania) 
	ORDER BY CP.IdContenido,CAD.Orden	
END

GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerLanzamientoAPP]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerLanzamientoAPP]
GO

CREATE PROC [dbo].Lista_BannerLanzamientoAPP
@CodigoConsultora varchar(20),
@Codigo varchar(20)=NULL,
@Capania int=NULL,
@Zona varchar(20)=NULL,
@Region varchar(20)=NULL,
@Seccion varchar(20)=NULL
AS
BEGIN
	SET @Codigo= isnull(@Codigo,'')
	SET @Capania= isnull(@Capania,'')
	SET @Zona= isnull(@Zona,'')
	SET @Region= isnull(@Region,'')
	SET @Seccion= isnull(@Seccion,'')

	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR  @Capania BETWEEN ISNULL(CP.DesdeCampania,@Capania) AND ISNULL(CP.HastaCampania,@Capania))
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CodigoDetalle,RutaContenido,Accion,Orden,Tipo,CAD.Estado EstadoDetalle
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido	LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR CAD.Campania=@Capania) 
	ORDER BY CP.IdContenido,CAD.Orden	
END

GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerLanzamientoAPP]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerLanzamientoAPP]
GO

CREATE PROC [dbo].Lista_BannerLanzamientoAPP
@CodigoConsultora varchar(20),
@Codigo varchar(20)=NULL,
@Capania int=NULL,
@Zona varchar(20)=NULL,
@Region varchar(20)=NULL,
@Seccion varchar(20)=NULL
AS
BEGIN
	SET @Codigo= isnull(@Codigo,'')
	SET @Capania= isnull(@Capania,'')
	SET @Zona= isnull(@Zona,'')
	SET @Region= isnull(@Region,'')
	SET @Seccion= isnull(@Seccion,'')

	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR  @Capania BETWEEN ISNULL(CP.DesdeCampania,@Capania) AND ISNULL(CP.HastaCampania,@Capania))
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CodigoDetalle,RutaContenido,Accion,Orden,Tipo,CAD.Estado EstadoDetalle
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido	LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR CAD.Campania=@Capania) 
	ORDER BY CP.IdContenido,CAD.Orden	
END

GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerLanzamientoAPP]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerLanzamientoAPP]
GO

CREATE PROC [dbo].Lista_BannerLanzamientoAPP
@CodigoConsultora varchar(20),
@Codigo varchar(20)=NULL,
@Capania int=NULL,
@Zona varchar(20)=NULL,
@Region varchar(20)=NULL,
@Seccion varchar(20)=NULL
AS
BEGIN
	SET @Codigo= isnull(@Codigo,'')
	SET @Capania= isnull(@Capania,'')
	SET @Zona= isnull(@Zona,'')
	SET @Region= isnull(@Region,'')
	SET @Seccion= isnull(@Seccion,'')

	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR  @Capania BETWEEN ISNULL(CP.DesdeCampania,@Capania) AND ISNULL(CP.HastaCampania,@Capania))
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CodigoDetalle,RutaContenido,Accion,Orden,Tipo,CAD.Estado EstadoDetalle
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido	LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR CAD.Campania=@Capania)
	ORDER BY CP.IdContenido,CAD.Orden	
END

GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerLanzamientoAPP]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerLanzamientoAPP]
GO

CREATE PROC [dbo].Lista_BannerLanzamientoAPP
@CodigoConsultora varchar(20),
@Codigo varchar(20)=NULL,
@Capania int=NULL,
@Zona varchar(20)=NULL,
@Region varchar(20)=NULL,
@Seccion varchar(20)=NULL
AS
BEGIN
	SET @Codigo= isnull(@Codigo,'')
	SET @Capania= isnull(@Capania,'')
	SET @Zona= isnull(@Zona,'')
	SET @Region= isnull(@Region,'')
	SET @Seccion= isnull(@Seccion,'')

	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR  @Capania BETWEEN ISNULL(CP.DesdeCampania,@Capania) AND ISNULL(CP.HastaCampania,@Capania))
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CodigoDetalle,RutaContenido,Accion,Orden,Tipo,CAD.Estado EstadoDetalle
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido	LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR CAD.Campania=@Capania) 
	ORDER BY CP.IdContenido,CAD.Orden	
END

GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerLanzamientoAPP]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerLanzamientoAPP]
GO

CREATE PROC [dbo].Lista_BannerLanzamientoAPP
@CodigoConsultora varchar(20),
@Codigo varchar(20)=NULL,
@Capania int=NULL,
@Zona varchar(20)=NULL,
@Region varchar(20)=NULL,
@Seccion varchar(20)=NULL
AS
BEGIN
	SET @Codigo= isnull(@Codigo,'')
	SET @Capania= isnull(@Capania,'')
	SET @Zona= isnull(@Zona,'')
	SET @Region= isnull(@Region,'')
	SET @Seccion= isnull(@Seccion,'')

	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR  @Capania BETWEEN ISNULL(CP.DesdeCampania,@Capania) AND ISNULL(CP.HastaCampania,@Capania))
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CodigoDetalle,RutaContenido,Accion,Orden,Tipo,CAD.Estado EstadoDetalle
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido	LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR CAD.Campania=@Capania)
	ORDER BY CP.IdContenido,CAD.Orden	
END

GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lista_BannerLanzamientoAPP]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Lista_BannerLanzamientoAPP]
GO

CREATE PROC [dbo].Lista_BannerLanzamientoAPP
@CodigoConsultora varchar(20),
@Codigo varchar(20)=NULL,
@Capania int=NULL,
@Zona varchar(20)=NULL,
@Region varchar(20)=NULL,
@Seccion varchar(20)=NULL
AS
BEGIN
	SET @Codigo= isnull(@Codigo,'')
	SET @Capania= isnull(@Capania,'')
	SET @Zona= isnull(@Zona,'')
	SET @Region= isnull(@Region,'')
	SET @Seccion= isnull(@Seccion,'')

	SELECT CP.IdContenido,CP.Codigo,CP.UrlMiniatura,CP.DesdeCampania,CP.Estado,RutaImagen
	FROM dbo.ContenidoApp CP
	WHERE CP.Estado=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR  @Capania BETWEEN ISNULL(CP.DesdeCampania,@Capania) AND ISNULL(CP.HastaCampania,@Capania))
	ORDER BY CP.IdContenido
	
	SELECT CP.IdContenido,CAD.IdContenidoDeta,CP.Codigo,CodigoDetalle,RutaContenido,Accion,Orden,Tipo,CAD.Estado EstadoDetalle
	FROM dbo.ContenidoApp CP LEFT JOIN
		 dbo.ContenidoAppDeta CAD ON CAD.IdContenido=CP.IdContenido	LEFT JOIN
		 dbo.VistoContenidoConsultora VC ON VC.IdContenidoDeta=CAD.IdContenidoDeta AND VC.CodigoConsultora=@CodigoConsultora
	WHERE CP.Estado=1 and CAD.ESTADO=1 AND (@Codigo='' OR CP.Codigo=@Codigo) AND (@Capania=0 OR CAD.Campania=@Capania)
	ORDER BY CP.IdContenido,CAD.Orden	
END

GO
