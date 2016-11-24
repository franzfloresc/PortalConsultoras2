--- Scripts para mostrar los popups en un orden determinado.
USE BelcorpColombia
Go

-- Crear tabla para configurar el orden de los PopUps
IF EXISTS(
	SELECT *
	FROM INFORMATION_SCHEMA.tables 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_TYPE='BASE TABLE' AND TABLE_NAME = 'PopupPais'
)
BEGIN
    DROP TABLE dbo.PopupPais
END


go

CREATE TABLE PopupPais
(
	PopupPaisID INT IDENTITY(1,1) PRIMARY KEY,	
	CodigoPopup INT,
	Descripcion VARCHAR(30),
	CodigoISO CHAR(2),
	Orden INT,
	Activo BIT
)

GO

-- Crear SP para mostrar el orden de los PopUps
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'ObtenerOrdenPopUpMostrar' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.ObtenerOrdenPopUpMostrar
END

GO

CREATE PROCEDURE dbo.ObtenerOrdenPopUpMostrar
AS

BEGIN

	SELECT  P.PopupPaisID,P.CodigoPopup, P.Descripcion, P.Orden FROM
	PopupPais P
	WHERE P.Activo = 1
	ORDER BY P.Orden
	
END

GO

DELETE FROM PopupPais

INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(1, 'VideoIntroductorio', 'CO', 1, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(2, 'GPR', 'CO', 2, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(3, 'Demanda Anticipada', 'CO', 3, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(4, 'Aceptación de contrato', 'CO', 4, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(5, 'Showroom', 'CO', 5, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(6, 'Actualizar datos', 'CO', 6, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(7, 'Flexipago', 'CO', 7, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(8, 'Comunicado', 'CO', 8, 1)

GO


---
USE BelcorpMexico
Go

-- Crear tabla para configurar el orden de los PopUps
IF EXISTS(
	SELECT *
	FROM INFORMATION_SCHEMA.tables 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_TYPE='BASE TABLE' AND TABLE_NAME = 'PopupPais'
)
BEGIN
    DROP TABLE dbo.PopupPais
END


go

CREATE TABLE PopupPais
(
	PopupPaisID INT IDENTITY(1,1) PRIMARY KEY,	
	CodigoPopup INT,
	Descripcion VARCHAR(30),
	CodigoISO CHAR(2),
	Orden INT,
	Activo BIT
)

GO

-- Crear SP para mostrar el orden de los PopUps
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'ObtenerOrdenPopUpMostrar' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.ObtenerOrdenPopUpMostrar
END

GO

CREATE PROCEDURE dbo.ObtenerOrdenPopUpMostrar
AS

BEGIN

	SELECT  P.PopupPaisID,P.CodigoPopup, P.Descripcion, P.Orden FROM
	PopupPais P
	WHERE P.Activo = 1
	ORDER BY P.Orden
	
END

GO

DELETE FROM PopupPais

INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(1, 'VideoIntroductorio', 'MX', 1, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(2, 'GPR', 'MX', 2, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(3, 'Demanda Anticipada', 'MX', 3, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(4, 'Aceptación de contrato', 'MX', 4, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(5, 'Showroom', 'MX', 5, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(6, 'Actualizar datos', 'MX', 6, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(7, 'Flexipago', 'MX', 7, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(8, 'Comunicado', 'MX', 8, 1)

GO


----

USE BelcorpPeru
Go

-- Crear tabla para configurar el orden de los PopUps
IF EXISTS(
	SELECT *
	FROM INFORMATION_SCHEMA.tables 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_TYPE='BASE TABLE' AND TABLE_NAME = 'PopupPais'
)
BEGIN
    DROP TABLE dbo.PopupPais
END

GO


CREATE TABLE PopupPais
(
	PopupPaisID INT IDENTITY(1,1) PRIMARY KEY,	
	CodigoPopup INT,
	Descripcion VARCHAR(30),
	CodigoISO CHAR(2),
	Orden INT,
	Activo BIT
)

GO

-- Crear SP para mostrar el orden de los PopUps
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'ObtenerOrdenPopUpMostrar' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.ObtenerOrdenPopUpMostrar
END

GO

CREATE PROCEDURE dbo.ObtenerOrdenPopUpMostrar
AS

BEGIN

	SELECT  P.PopupPaisID,P.CodigoPopup, P.Descripcion, P.Orden FROM
	PopupPais P
	WHERE P.Activo = 1
	ORDER BY P.Orden
	
END

GO

DELETE FROM PopupPais

INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(1, 'VideoIntroductorio', 'PE', 1, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(2, 'GPR', 'PE', 2, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(3, 'Demanda Anticipada', 'PE', 3, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(4, 'Aceptación de contrato', 'PE', 4, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(5, 'Showroom', 'PE', 5, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(6, 'Actualizar datos', 'PE', 6, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(7, 'Flexipago', 'PE', 7, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(8, 'Comunicado', 'PE', 8, 1)

GO

