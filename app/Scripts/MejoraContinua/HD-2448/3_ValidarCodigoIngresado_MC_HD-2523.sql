USE BelcorpPeru
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado
GO

CREATE PROCEDURE dbo.ValidarCodigoIngresado
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Iguales bit = 0
	if exists(
	SELECT
		1
	FROM dbo.CodigoGenerado
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
		set @Iguales = 1
	SELECT @Iguales as SonIguales
END


GO
USE BelcorpMexico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado
GO

CREATE PROCEDURE dbo.ValidarCodigoIngresado
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Iguales bit = 0
	if exists(
	SELECT
		1
	FROM dbo.CodigoGenerado
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
		set @Iguales = 1
	SELECT @Iguales as SonIguales
END


GO
USE BelcorpColombia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado
GO

CREATE PROCEDURE dbo.ValidarCodigoIngresado
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Iguales bit = 0
	if exists(
	SELECT
		1
	FROM dbo.CodigoGenerado
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
		set @Iguales = 1
	SELECT @Iguales as SonIguales
END


GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado
GO

CREATE PROCEDURE dbo.ValidarCodigoIngresado
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Iguales bit = 0
	if exists(
	SELECT
		1
	FROM dbo.CodigoGenerado
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
		set @Iguales = 1
	SELECT @Iguales as SonIguales
END


GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado
GO

CREATE PROCEDURE dbo.ValidarCodigoIngresado
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Iguales bit = 0
	if exists(
	SELECT
		1
	FROM dbo.CodigoGenerado
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
		set @Iguales = 1
	SELECT @Iguales as SonIguales
END


GO
USE BelcorpPanama
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado
GO

CREATE PROCEDURE dbo.ValidarCodigoIngresado
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Iguales bit = 0
	if exists(
	SELECT
		1
	FROM dbo.CodigoGenerado
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
		set @Iguales = 1
	SELECT @Iguales as SonIguales
END


GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado
GO

CREATE PROCEDURE dbo.ValidarCodigoIngresado
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Iguales bit = 0
	if exists(
	SELECT
		1
	FROM dbo.CodigoGenerado
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
		set @Iguales = 1
	SELECT @Iguales as SonIguales
END


GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado
GO

CREATE PROCEDURE dbo.ValidarCodigoIngresado
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Iguales bit = 0
	if exists(
	SELECT
		1
	FROM dbo.CodigoGenerado
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
		set @Iguales = 1
	SELECT @Iguales as SonIguales
END


GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado
GO

CREATE PROCEDURE dbo.ValidarCodigoIngresado
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Iguales bit = 0
	if exists(
	SELECT
		1
	FROM dbo.CodigoGenerado
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
		set @Iguales = 1
	SELECT @Iguales as SonIguales
END


GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado
GO

CREATE PROCEDURE dbo.ValidarCodigoIngresado
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Iguales bit = 0
	if exists(
	SELECT
		1
	FROM dbo.CodigoGenerado
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
		set @Iguales = 1
	SELECT @Iguales as SonIguales
END


GO
USE BelcorpChile
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado
GO

CREATE PROCEDURE dbo.ValidarCodigoIngresado
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Iguales bit = 0
	if exists(
	SELECT
		1
	FROM dbo.CodigoGenerado
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
		set @Iguales = 1
	SELECT @Iguales as SonIguales
END


GO
USE BelcorpBolivia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado
GO

CREATE PROCEDURE dbo.ValidarCodigoIngresado
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Iguales bit = 0
	if exists(
	SELECT
		1
	FROM dbo.CodigoGenerado
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
		set @Iguales = 1
	SELECT @Iguales as SonIguales
END

GO
