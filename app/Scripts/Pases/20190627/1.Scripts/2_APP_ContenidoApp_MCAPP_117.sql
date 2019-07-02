USE BelcorpPeru
GO

DECLARE @ID_CONTENIDO INT

IF(NOT EXISTS(SELECT * FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL'))
BEGIN
	INSERT INTO dbo.contenidoAPP (Codigo,Descripcion,Estado,CantidadContenido,RutaImagen)
	VALUES('QUESTIONPROURL','URL Para tu voz online',1,1,NULL)
	SET @ID_CONTENIDO= @@IDENTITY
END
ELSE
BEGIN
	SET @ID_CONTENIDO =(SELECT IDCONTENIDO FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL')
END

INSERT INTO dbo.contenidoAPPDETA (IdContenido,CodigoDetalle,Descripcion,RutaContenido,ACCION,Orden,Estado,Tipo,Campania)
VALUES (@ID_CONTENIDO,'QUESTIONPROURL','URL Para tu voz online','https://www.questionpro.com/a/panelsso?ID_STRING={0}&SIGNATURE={1}&id={2}','',1,1,'URL',NULL)

GO

USE BelcorpMexico
GO

DECLARE @ID_CONTENIDO INT

IF(NOT EXISTS(SELECT * FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL'))
BEGIN
	INSERT INTO dbo.contenidoAPP (Codigo,Descripcion,Estado,CantidadContenido,RutaImagen)
	VALUES('QUESTIONPROURL','URL Para tu voz online',1,1,NULL)
	SET @ID_CONTENIDO= @@IDENTITY
END
ELSE
BEGIN
	SET @ID_CONTENIDO =(SELECT IDCONTENIDO FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL')
END

INSERT INTO dbo.contenidoAPPDETA (IdContenido,CodigoDetalle,Descripcion,RutaContenido,ACCION,Orden,Estado,Tipo,Campania)
VALUES (@ID_CONTENIDO,'QUESTIONPROURL','URL Para tu voz online','https://www.questionpro.com/a/panelsso?ID_STRING={0}&SIGNATURE={1}&id={2}','',1,1,'URL',NULL)

GO

USE BelcorpColombia
GO

DECLARE @ID_CONTENIDO INT

IF(NOT EXISTS(SELECT * FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL'))
BEGIN
	INSERT INTO dbo.contenidoAPP (Codigo,Descripcion,Estado,CantidadContenido,RutaImagen)
	VALUES('QUESTIONPROURL','URL Para tu voz online',1,1,NULL)
	SET @ID_CONTENIDO= @@IDENTITY
END
ELSE
BEGIN
	SET @ID_CONTENIDO =(SELECT IDCONTENIDO FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL')
END

INSERT INTO dbo.contenidoAPPDETA (IdContenido,CodigoDetalle,Descripcion,RutaContenido,ACCION,Orden,Estado,Tipo,Campania)
VALUES (@ID_CONTENIDO,'QUESTIONPROURL','URL Para tu voz online','https://www.questionpro.com/a/panelsso?ID_STRING={0}&SIGNATURE={1}&id={2}','',1,1,'URL',NULL)

GO

USE BelcorpSalvador
GO

DECLARE @ID_CONTENIDO INT

IF(NOT EXISTS(SELECT * FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL'))
BEGIN
	INSERT INTO dbo.contenidoAPP (Codigo,Descripcion,Estado,CantidadContenido,RutaImagen)
	VALUES('QUESTIONPROURL','URL Para tu voz online',1,1,NULL)
	SET @ID_CONTENIDO= @@IDENTITY
END
ELSE
BEGIN
	SET @ID_CONTENIDO =(SELECT IDCONTENIDO FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL')
END

INSERT INTO dbo.contenidoAPPDETA (IdContenido,CodigoDetalle,Descripcion,RutaContenido,ACCION,Orden,Estado,Tipo,Campania)
VALUES (@ID_CONTENIDO,'QUESTIONPROURL','URL Para tu voz online','https://www.questionpro.com/a/panelsso?ID_STRING={0}&SIGNATURE={1}&id={2}','',1,1,'URL',NULL)

GO

USE BelcorpPuertoRico
GO

DECLARE @ID_CONTENIDO INT

IF(NOT EXISTS(SELECT * FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL'))
BEGIN
	INSERT INTO dbo.contenidoAPP (Codigo,Descripcion,Estado,CantidadContenido,RutaImagen)
	VALUES('QUESTIONPROURL','URL Para tu voz online',1,1,NULL)
	SET @ID_CONTENIDO= @@IDENTITY
END
ELSE
BEGIN
	SET @ID_CONTENIDO =(SELECT IDCONTENIDO FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL')
END

INSERT INTO dbo.contenidoAPPDETA (IdContenido,CodigoDetalle,Descripcion,RutaContenido,ACCION,Orden,Estado,Tipo,Campania)
VALUES (@ID_CONTENIDO,'QUESTIONPROURL','URL Para tu voz online','https://www.questionpro.com/a/panelsso?ID_STRING={0}&SIGNATURE={1}&id={2}','',1,1,'URL',NULL)

GO

USE BelcorpPanama
GO

DECLARE @ID_CONTENIDO INT

IF(NOT EXISTS(SELECT * FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL'))
BEGIN
	INSERT INTO dbo.contenidoAPP (Codigo,Descripcion,Estado,CantidadContenido,RutaImagen)
	VALUES('QUESTIONPROURL','URL Para tu voz online',1,1,NULL)
	SET @ID_CONTENIDO= @@IDENTITY
END
ELSE
BEGIN
	SET @ID_CONTENIDO =(SELECT IDCONTENIDO FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL')
END

INSERT INTO dbo.contenidoAPPDETA (IdContenido,CodigoDetalle,Descripcion,RutaContenido,ACCION,Orden,Estado,Tipo,Campania)
VALUES (@ID_CONTENIDO,'QUESTIONPROURL','URL Para tu voz online','https://www.questionpro.com/a/panelsso?ID_STRING={0}&SIGNATURE={1}&id={2}','',1,1,'URL',NULL)

GO

USE BelcorpGuatemala
GO

DECLARE @ID_CONTENIDO INT

IF(NOT EXISTS(SELECT * FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL'))
BEGIN
	INSERT INTO dbo.contenidoAPP (Codigo,Descripcion,Estado,CantidadContenido,RutaImagen)
	VALUES('QUESTIONPROURL','URL Para tu voz online',1,1,NULL)
	SET @ID_CONTENIDO= @@IDENTITY
END
ELSE
BEGIN
	SET @ID_CONTENIDO =(SELECT IDCONTENIDO FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL')
END

INSERT INTO dbo.contenidoAPPDETA (IdContenido,CodigoDetalle,Descripcion,RutaContenido,ACCION,Orden,Estado,Tipo,Campania)
VALUES (@ID_CONTENIDO,'QUESTIONPROURL','URL Para tu voz online','https://www.questionpro.com/a/panelsso?ID_STRING={0}&SIGNATURE={1}&id={2}','',1,1,'URL',NULL)

GO

USE BelcorpEcuador
GO

DECLARE @ID_CONTENIDO INT

IF(NOT EXISTS(SELECT * FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL'))
BEGIN
	INSERT INTO dbo.contenidoAPP (Codigo,Descripcion,Estado,CantidadContenido,RutaImagen)
	VALUES('QUESTIONPROURL','URL Para tu voz online',1,1,NULL)
	SET @ID_CONTENIDO= @@IDENTITY
END
ELSE
BEGIN
	SET @ID_CONTENIDO =(SELECT IDCONTENIDO FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL')
END

INSERT INTO dbo.contenidoAPPDETA (IdContenido,CodigoDetalle,Descripcion,RutaContenido,ACCION,Orden,Estado,Tipo,Campania)
VALUES (@ID_CONTENIDO,'QUESTIONPROURL','URL Para tu voz online','https://www.questionpro.com/a/panelsso?ID_STRING={0}&SIGNATURE={1}&id={2}','',1,1,'URL',NULL)

GO

USE BelcorpDominicana
GO

DECLARE @ID_CONTENIDO INT

IF(NOT EXISTS(SELECT * FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL'))
BEGIN
	INSERT INTO dbo.contenidoAPP (Codigo,Descripcion,Estado,CantidadContenido,RutaImagen)
	VALUES('QUESTIONPROURL','URL Para tu voz online',1,1,NULL)
	SET @ID_CONTENIDO= @@IDENTITY
END
ELSE
BEGIN
	SET @ID_CONTENIDO =(SELECT IDCONTENIDO FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL')
END

INSERT INTO dbo.contenidoAPPDETA (IdContenido,CodigoDetalle,Descripcion,RutaContenido,ACCION,Orden,Estado,Tipo,Campania)
VALUES (@ID_CONTENIDO,'QUESTIONPROURL','URL Para tu voz online','https://www.questionpro.com/a/panelsso?ID_STRING={0}&SIGNATURE={1}&id={2}','',1,1,'URL',NULL)

GO

USE BelcorpCostaRica
GO

DECLARE @ID_CONTENIDO INT

IF(NOT EXISTS(SELECT * FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL'))
BEGIN
	INSERT INTO dbo.contenidoAPP (Codigo,Descripcion,Estado,CantidadContenido,RutaImagen)
	VALUES('QUESTIONPROURL','URL Para tu voz online',1,1,NULL)
	SET @ID_CONTENIDO= @@IDENTITY
END
ELSE
BEGIN
	SET @ID_CONTENIDO =(SELECT IDCONTENIDO FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL')
END

INSERT INTO dbo.contenidoAPPDETA (IdContenido,CodigoDetalle,Descripcion,RutaContenido,ACCION,Orden,Estado,Tipo,Campania)
VALUES (@ID_CONTENIDO,'QUESTIONPROURL','URL Para tu voz online','https://www.questionpro.com/a/panelsso?ID_STRING={0}&SIGNATURE={1}&id={2}','',1,1,'URL',NULL)

GO

USE BelcorpChile
GO

DECLARE @ID_CONTENIDO INT

IF(NOT EXISTS(SELECT * FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL'))
BEGIN
	INSERT INTO dbo.contenidoAPP (Codigo,Descripcion,Estado,CantidadContenido,RutaImagen)
	VALUES('QUESTIONPROURL','URL Para tu voz online',1,1,NULL)
	SET @ID_CONTENIDO= @@IDENTITY
END
ELSE
BEGIN
	SET @ID_CONTENIDO =(SELECT IDCONTENIDO FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL')
END

INSERT INTO dbo.contenidoAPPDETA (IdContenido,CodigoDetalle,Descripcion,RutaContenido,ACCION,Orden,Estado,Tipo,Campania)
VALUES (@ID_CONTENIDO,'QUESTIONPROURL','URL Para tu voz online','https://www.questionpro.com/a/panelsso?ID_STRING={0}&SIGNATURE={1}&id={2}','',1,1,'URL',NULL)

GO

USE BelcorpBolivia
GO

DECLARE @ID_CONTENIDO INT

IF(NOT EXISTS(SELECT * FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL'))
BEGIN
	INSERT INTO dbo.contenidoAPP (Codigo,Descripcion,Estado,CantidadContenido,RutaImagen)
	VALUES('QUESTIONPROURL','URL Para tu voz online',1,1,NULL)
	SET @ID_CONTENIDO= @@IDENTITY
END
ELSE
BEGIN
	SET @ID_CONTENIDO =(SELECT IDCONTENIDO FROM dbo.COntenidoApp WHERE Codigo='QUESTIONPROURL')
END

INSERT INTO dbo.contenidoAPPDETA (IdContenido,CodigoDetalle,Descripcion,RutaContenido,ACCION,Orden,Estado,Tipo,Campania)
VALUES (@ID_CONTENIDO,'QUESTIONPROURL','URL Para tu voz online','https://www.questionpro.com/a/panelsso?ID_STRING={0}&SIGNATURE={1}&id={2}','',1,1,'URL',NULL)

GO

