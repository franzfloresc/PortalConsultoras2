--- Scripts para mostrar los popups en un orden determinado.
USE BelcorpBolivia
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

INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(1, 'VideoIntroductorio', 'BO', 1, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(2, 'GPR', 'BO', 2, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(3, 'Demanda Anticipada', 'BO', 3, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(4, 'Aceptación de contrato', 'BO', 4, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(5, 'Showroom', 'BO', 5, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(6, 'Actualizar datos', 'BO', 6, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(7, 'Flexipago', 'BO', 7, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(8, 'Comunicado', 'BO', 8, 1)

GO


---

USE BelcorpChile
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

INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(1, 'VideoIntroductorio', 'CL', 1, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(2, 'GPR', 'CL', 2, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(3, 'Demanda Anticipada', 'CL', 3, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(4, 'Aceptación de contrato', 'CL', 4, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(5, 'Showroom', 'CL', 5, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(6, 'Actualizar datos', 'CL', 6, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(7, 'Flexipago', 'CL', 7, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(8, 'Comunicado', 'CL', 8, 1)

GO


---

USE BelcorpCostaRica
GO
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

INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(1, 'VideoIntroductorio', 'CR', 1, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(2, 'GPR', 'CR', 2, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(3, 'Demanda Anticipada', 'CR', 3, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(4, 'Aceptación de contrato', 'CR', 4, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(5, 'Showroom', 'CR', 5, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(6, 'Actualizar datos', 'CR', 6, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(7, 'Flexipago', 'CR', 7, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(8, 'Comunicado', 'CR', 8, 1)

GO


---
USE BelcorpDominicana
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

INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(1, 'VideoIntroductorio', 'DO', 1, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(2, 'GPR', 'DO', 2, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(3, 'Demanda Anticipada', 'DO', 3, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(4, 'Aceptación de contrato', 'DO', 4, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(5, 'Showroom', 'DO', 5, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(6, 'Actualizar datos', 'DO', 6, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(7, 'Flexipago', 'DO', 7, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(8, 'Comunicado', 'DO', 8, 1)

GO

--
USE BelcorpEcuador
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

INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(1, 'VideoIntroductorio', 'EC', 1, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(2, 'GPR', 'EC', 2, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(3, 'Demanda Anticipada', 'EC', 3, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(4, 'Aceptación de contrato', 'EC', 4, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(5, 'Showroom', 'EC', 5, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(6, 'Actualizar datos', 'EC', 6, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(7, 'Flexipago', 'EC', 7, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(8, 'Comunicado', 'EC', 8, 1)

GO


--
USE BelcorpGuatemala
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

INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(1, 'VideoIntroductorio', 'GT', 1, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(2, 'GPR', 'GT', 2, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(3, 'Demanda Anticipada', 'GT', 3, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(4, 'Aceptación de contrato', 'GT', 4, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(5, 'Showroom', 'GT', 5, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(6, 'Actualizar datos', 'GT', 6, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(7, 'Flexipago', 'GT', 7, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(8, 'Comunicado', 'GT', 8, 1)

GO


--
USE BelcorpPanama
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

INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(1, 'VideoIntroductorio', 'PA', 1, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(2, 'GPR', 'PA', 2, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(3, 'Demanda Anticipada', 'PA', 3, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(4, 'Aceptación de contrato', 'PA', 4, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(5, 'Showroom', 'PA', 5, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(6, 'Actualizar datos', 'PA', 6, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(7, 'Flexipago', 'PA', 7, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(8, 'Comunicado', 'PA', 8, 1)

GO



---
USE BelcorpPuertoRico
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

INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(1, 'VideoIntroductorio', 'PR', 1, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(2, 'GPR', 'PR', 2, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(3, 'Demanda Anticipada', 'PR', 3, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(4, 'Aceptación de contrato', 'PR', 4, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(5, 'Showroom', 'PR', 5, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(6, 'Actualizar datos', 'PR', 6, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(7, 'Flexipago', 'PR', 7, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(8, 'Comunicado', 'PR', 8, 1)

GO


---
USE BelcorpSalvador
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

INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(1, 'VideoIntroductorio', 'SV', 1, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(2, 'GPR', 'SV', 2, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(3, 'Demanda Anticipada', 'SV', 3, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(4, 'Aceptación de contrato', 'SV', 4, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(5, 'Showroom', 'SV', 5, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(6, 'Actualizar datos', 'SV', 6, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(7, 'Flexipago', 'SV', 7, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(8, 'Comunicado', 'SV', 8, 1)

GO



---
USE BelcorpVenezuela
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

INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(1, 'VideoIntroductorio', 'VE', 1, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(2, 'GPR', 'VE', 2, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(3, 'Demanda Anticipada', 'VE', 3, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(4, 'Aceptación de contrato', 'VE', 4, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(5, 'Showroom', 'VE', 5, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(6, 'Actualizar datos', 'VE', 6, 1)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(7, 'Flexipago', 'VE', 7, 0)
INSERT INTO PopupPais(CodigoPopup, Descripcion, CodigoISO, Orden, Activo) VALUES(8, 'Comunicado', 'VE', 8, 1)

GO


