USE BelcorpPeru
GO

/* ALTER CambiarClaveUsuario */
IF (OBJECT_ID ( 'dbo.CambiarClaveUsuario', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.CambiarClaveUsuario AS SET NOCOUNT ON;')
GO

ALTER procedure dbo.CambiarClaveUsuario
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario set ClaveSecreta = @ClaveEncriptada where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpMexico
GO

/* ALTER CambiarClaveUsuario */
IF (OBJECT_ID ( 'dbo.CambiarClaveUsuario', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.CambiarClaveUsuario AS SET NOCOUNT ON;')
GO


ALTER procedure dbo.CambiarClaveUsuario
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario set ClaveSecreta = @ClaveEncriptada where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpColombia
GO

/* ALTER CambiarClaveUsuario */
IF (OBJECT_ID ( 'dbo.CambiarClaveUsuario', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.CambiarClaveUsuario AS SET NOCOUNT ON;')
GO


ALTER procedure dbo.CambiarClaveUsuario
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario set ClaveSecreta = @ClaveEncriptada where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpSalvador
GO

/* ALTER CambiarClaveUsuario */
IF (OBJECT_ID ( 'dbo.CambiarClaveUsuario', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.CambiarClaveUsuario AS SET NOCOUNT ON;')
GO


ALTER procedure dbo.CambiarClaveUsuario
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario set ClaveSecreta = @ClaveEncriptada where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpPuertoRico
GO

/* ALTER CambiarClaveUsuario */
IF (OBJECT_ID ( 'dbo.CambiarClaveUsuario', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.CambiarClaveUsuario AS SET NOCOUNT ON;')
GO

ALTER procedure dbo.CambiarClaveUsuario
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario set ClaveSecreta = @ClaveEncriptada where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpPanama
GO

/* ALTER CambiarClaveUsuario */
IF (OBJECT_ID ( 'dbo.CambiarClaveUsuario', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.CambiarClaveUsuario AS SET NOCOUNT ON;')
GO


ALTER procedure dbo.CambiarClaveUsuario
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario set ClaveSecreta = @ClaveEncriptada where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpGuatemala
GO

/* ALTER CambiarClaveUsuario */
IF (OBJECT_ID ( 'dbo.CambiarClaveUsuario', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.CambiarClaveUsuario AS SET NOCOUNT ON;')
GO


ALTER procedure dbo.CambiarClaveUsuario
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario set ClaveSecreta = @ClaveEncriptada where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpEcuador
GO

/* ALTER CambiarClaveUsuario */
IF (OBJECT_ID ( 'dbo.CambiarClaveUsuario', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.CambiarClaveUsuario AS SET NOCOUNT ON;')
GO


ALTER procedure dbo.CambiarClaveUsuario
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario set ClaveSecreta = @ClaveEncriptada where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpDominicana
GO

/* ALTER CambiarClaveUsuario */
IF (OBJECT_ID ( 'dbo.CambiarClaveUsuario', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.CambiarClaveUsuario AS SET NOCOUNT ON;')
GO


ALTER procedure dbo.CambiarClaveUsuario
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario set ClaveSecreta = @ClaveEncriptada where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpCostaRica
GO

/* ALTER CambiarClaveUsuario */
IF (OBJECT_ID ( 'dbo.CambiarClaveUsuario', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.CambiarClaveUsuario AS SET NOCOUNT ON;')
GO


ALTER procedure dbo.CambiarClaveUsuario
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario set ClaveSecreta = @ClaveEncriptada where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpChile
GO

/* ALTER CambiarClaveUsuario */
IF (OBJECT_ID ( 'dbo.CambiarClaveUsuario', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.CambiarClaveUsuario AS SET NOCOUNT ON;')
GO


ALTER procedure dbo.CambiarClaveUsuario
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario set ClaveSecreta = @ClaveEncriptada where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpBolivia
GO

/* ALTER CambiarClaveUsuario */
IF (OBJECT_ID ( 'dbo.CambiarClaveUsuario', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.CambiarClaveUsuario AS SET NOCOUNT ON;')
GO


ALTER procedure dbo.CambiarClaveUsuario
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario set ClaveSecreta = @ClaveEncriptada where CodigoUsuario = @CodigoUsuario

end
GO

