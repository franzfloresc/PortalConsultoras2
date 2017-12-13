USE BelcorpPeru
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetEventoFestivo')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END
GO
CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END
END
GO

USE BelcorpMexico
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetEventoFestivo')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END
GO
CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END
END
GO

USE BelcorpColombia
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetEventoFestivo')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END
GO
CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END
END
GO

USE BelcorpVenezuela
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetEventoFestivo')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END
GO
CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END
END
GO

USE BelcorpSalvador
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetEventoFestivo')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END
GO
CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetEventoFestivo')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END
GO
CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END
END
GO

USE BelcorpPanama
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetEventoFestivo')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END
GO
CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetEventoFestivo')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END
GO
CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END
END
GO

USE BelcorpEcuador
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetEventoFestivo')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END
GO
CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END
END
GO

USE BelcorpDominicana
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetEventoFestivo')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END
GO
CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetEventoFestivo')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END
GO
CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END
END
GO

USE BelcorpChile
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetEventoFestivo')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END
GO
CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END
END
GO

USE BelcorpBolivia
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetEventoFestivo')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END
GO
CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END
END
GO

