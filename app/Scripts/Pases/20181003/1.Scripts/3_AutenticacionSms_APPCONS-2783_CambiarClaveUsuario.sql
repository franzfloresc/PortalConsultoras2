USE BelcorpPeru
GO

/* CambiarClaveUsuario */
ALTER procedure [dbo].[CambiarClaveUsuario]
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario 
set ClaveSecreta = @ClaveEncriptada ,
	CambioClave = 1,
	FechaModificacion = getdate()
where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpMexico
GO

/* CambiarClaveUsuario */
ALTER procedure [dbo].[CambiarClaveUsuario]
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario 
set ClaveSecreta = @ClaveEncriptada ,
	CambioClave = 1,
	FechaModificacion = getdate()
where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpColombia
GO

/* CambiarClaveUsuario */
ALTER procedure [dbo].[CambiarClaveUsuario]
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario 
set ClaveSecreta = @ClaveEncriptada ,
	CambioClave = 1,
	FechaModificacion = getdate()
where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpSalvador
GO

/* CambiarClaveUsuario */
ALTER procedure [dbo].[CambiarClaveUsuario]
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario 
set ClaveSecreta = @ClaveEncriptada ,
	CambioClave = 1,
	FechaModificacion = getdate()
where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpPuertoRico
GO

/* CambiarClaveUsuario */
ALTER procedure [dbo].[CambiarClaveUsuario]
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario 
set ClaveSecreta = @ClaveEncriptada ,
	CambioClave = 1,
	FechaModificacion = getdate()
where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpPanama
GO

/* CambiarClaveUsuario */
ALTER procedure [dbo].[CambiarClaveUsuario]
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario 
set ClaveSecreta = @ClaveEncriptada ,
	CambioClave = 1,
	FechaModificacion = getdate()
where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpGuatemala
GO

/* CambiarClaveUsuario */
ALTER procedure [dbo].[CambiarClaveUsuario]
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario 
set ClaveSecreta = @ClaveEncriptada ,
	CambioClave = 1,
	FechaModificacion = getdate()
where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpEcuador
GO

/* CambiarClaveUsuario */
ALTER procedure [dbo].[CambiarClaveUsuario]
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario 
set ClaveSecreta = @ClaveEncriptada ,
	CambioClave = 1,
	FechaModificacion = getdate()
where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpDominicana
GO

/* CambiarClaveUsuario */
ALTER procedure [dbo].[CambiarClaveUsuario]
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario 
set ClaveSecreta = @ClaveEncriptada ,
	CambioClave = 1,
	FechaModificacion = getdate()
where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpCostaRica
GO

/* CambiarClaveUsuario */
ALTER procedure [dbo].[CambiarClaveUsuario]
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario 
set ClaveSecreta = @ClaveEncriptada ,
	CambioClave = 1,
	FechaModificacion = getdate()
where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpChile
GO

/* CambiarClaveUsuario */
ALTER procedure [dbo].[CambiarClaveUsuario]
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario 
set ClaveSecreta = @ClaveEncriptada ,
	CambioClave = 1,
	FechaModificacion = getdate()
where CodigoUsuario = @CodigoUsuario

end
GO

USE BelcorpBolivia
GO

/* CambiarClaveUsuario */
ALTER procedure [dbo].[CambiarClaveUsuario]
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario 
set ClaveSecreta = @ClaveEncriptada ,
	CambioClave = 1,
	FechaModificacion = getdate()
where CodigoUsuario = @CodigoUsuario

end
GO

