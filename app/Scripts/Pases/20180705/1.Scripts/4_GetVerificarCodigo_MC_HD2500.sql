USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetVerificarCodigo')
BEGIN
	DROP PROC [dbo].[GetVerificarCodigo]
END
GO
CREATE PROC [dbo].[GetVerificarCodigo] 
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8),
@IdEstadoActividad int
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetVerificarCodigo')
BEGIN
	DROP PROC [dbo].[GetVerificarCodigo]
END
GO
CREATE PROC [dbo].[GetVerificarCodigo] 
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8),
@IdEstadoActividad int
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetVerificarCodigo')
BEGIN
	DROP PROC [dbo].[GetVerificarCodigo]
END
GO
CREATE PROC [dbo].[GetVerificarCodigo] 
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8),
@IdEstadoActividad int
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetVerificarCodigo')
BEGIN
	DROP PROC [dbo].[GetVerificarCodigo]
END
GO
CREATE PROC [dbo].[GetVerificarCodigo] 
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8),
@IdEstadoActividad int
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetVerificarCodigo')
BEGIN
	DROP PROC [dbo].[GetVerificarCodigo]
END
GO
CREATE PROC [dbo].[GetVerificarCodigo] 
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8),
@IdEstadoActividad int
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetVerificarCodigo')
BEGIN
	DROP PROC [dbo].[GetVerificarCodigo]
END
GO
CREATE PROC [dbo].[GetVerificarCodigo] 
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8),
@IdEstadoActividad int
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetVerificarCodigo')
BEGIN
	DROP PROC [dbo].[GetVerificarCodigo]
END
GO
CREATE PROC [dbo].[GetVerificarCodigo] 
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8),
@IdEstadoActividad int
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetVerificarCodigo')
BEGIN
	DROP PROC [dbo].[GetVerificarCodigo]
END
GO
CREATE PROC [dbo].[GetVerificarCodigo] 
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8),
@IdEstadoActividad int
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetVerificarCodigo')
BEGIN
	DROP PROC [dbo].[GetVerificarCodigo]
END
GO
CREATE PROC [dbo].[GetVerificarCodigo] 
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8),
@IdEstadoActividad int
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetVerificarCodigo')
BEGIN
	DROP PROC [dbo].[GetVerificarCodigo]
END
GO
CREATE PROC [dbo].[GetVerificarCodigo] 
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8),
@IdEstadoActividad int
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetVerificarCodigo')
BEGIN
	DROP PROC [dbo].[GetVerificarCodigo]
END
GO
CREATE PROC [dbo].[GetVerificarCodigo] 
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8),
@IdEstadoActividad int
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetVerificarCodigo')
BEGIN
	DROP PROC [dbo].[GetVerificarCodigo]
END
GO
CREATE PROC [dbo].[GetVerificarCodigo] 
(
@CodigoUsuario varchar(20),
@OrigenID int,
@CodigoIngresado varchar(8),
@IdEstadoActividad int
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

