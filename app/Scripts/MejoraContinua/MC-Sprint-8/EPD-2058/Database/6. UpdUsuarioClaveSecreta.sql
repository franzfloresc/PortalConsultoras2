
USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[UpdUsuarioClaveSecreta]
	@CodigoUsuario varchar(20),
	@ClaveSecreta varchar(200),
	@CambioClave bit
as
update dbo.Usuario
set ClaveSecreta = dbo.EncriptarClaveSHA1(@ClaveSecreta),
	CambioClave = @CambioClave
where CodigoUsuario = @CodigoUsuario
GO

/*end*/

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[UpdUsuarioClaveSecreta]
	@CodigoUsuario varchar(20),
	@ClaveSecreta varchar(200),
	@CambioClave bit
as
update dbo.Usuario
set ClaveSecreta = dbo.EncriptarClaveSHA1(@ClaveSecreta),
	CambioClave = @CambioClave
where CodigoUsuario = @CodigoUsuario
GO
/*end*/

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[UpdUsuarioClaveSecreta]
	@CodigoUsuario varchar(20),
	@ClaveSecreta varchar(200),
	@CambioClave bit
as
update dbo.Usuario
set ClaveSecreta = dbo.EncriptarClaveSHA1(@ClaveSecreta),
	CambioClave = @CambioClave
where CodigoUsuario = @CodigoUsuario
GO
/*end*/

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[UpdUsuarioClaveSecreta]
	@CodigoUsuario varchar(20),
	@ClaveSecreta varchar(200),
	@CambioClave bit
as
update dbo.Usuario
set ClaveSecreta = dbo.EncriptarClaveSHA1(@ClaveSecreta),
	CambioClave = @CambioClave
where CodigoUsuario = @CodigoUsuario
GO
/*end*/

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[UpdUsuarioClaveSecreta]
	@CodigoUsuario varchar(20),
	@ClaveSecreta varchar(200),
	@CambioClave bit
as
update dbo.Usuario
set ClaveSecreta = dbo.EncriptarClaveSHA1(@ClaveSecreta),
	CambioClave = @CambioClave
where CodigoUsuario = @CodigoUsuario
GO
/*end*/

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[UpdUsuarioClaveSecreta]
	@CodigoUsuario varchar(20),
	@ClaveSecreta varchar(200),
	@CambioClave bit
as
update dbo.Usuario
set ClaveSecreta = dbo.EncriptarClaveSHA1(@ClaveSecreta),
	CambioClave = @CambioClave
where CodigoUsuario = @CodigoUsuario
GO
/*end*/

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[UpdUsuarioClaveSecreta]
	@CodigoUsuario varchar(20),
	@ClaveSecreta varchar(200),
	@CambioClave bit
as
update dbo.Usuario
set ClaveSecreta = dbo.EncriptarClaveSHA1(@ClaveSecreta),
	CambioClave = @CambioClave
where CodigoUsuario = @CodigoUsuario
GO
/*end*/

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[UpdUsuarioClaveSecreta]
	@CodigoUsuario varchar(20),
	@ClaveSecreta varchar(200),
	@CambioClave bit
as
update dbo.Usuario
set ClaveSecreta = dbo.EncriptarClaveSHA1(@ClaveSecreta),
	CambioClave = @CambioClave
where CodigoUsuario = @CodigoUsuario
GO
/*end*/

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[UpdUsuarioClaveSecreta]
	@CodigoUsuario varchar(20),
	@ClaveSecreta varchar(200),
	@CambioClave bit
as
update dbo.Usuario
set ClaveSecreta = dbo.EncriptarClaveSHA1(@ClaveSecreta),
	CambioClave = @CambioClave
where CodigoUsuario = @CodigoUsuario
GO
/*end*/

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[UpdUsuarioClaveSecreta]
	@CodigoUsuario varchar(20),
	@ClaveSecreta varchar(200),
	@CambioClave bit
as
update dbo.Usuario
set ClaveSecreta = dbo.EncriptarClaveSHA1(@ClaveSecreta),
	CambioClave = @CambioClave
where CodigoUsuario = @CodigoUsuario
GO
/*end*/

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[UpdUsuarioClaveSecreta]
	@CodigoUsuario varchar(20),
	@ClaveSecreta varchar(200),
	@CambioClave bit
as
update dbo.Usuario
set ClaveSecreta = dbo.EncriptarClaveSHA1(@ClaveSecreta),
	CambioClave = @CambioClave
where CodigoUsuario = @CodigoUsuario
GO
/*end*/

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[UpdUsuarioClaveSecreta]
	@CodigoUsuario varchar(20),
	@ClaveSecreta varchar(200),
	@CambioClave bit
as
update dbo.Usuario
set ClaveSecreta = dbo.EncriptarClaveSHA1(@ClaveSecreta),
	CambioClave = @CambioClave
where CodigoUsuario = @CodigoUsuario
GO
/*end*/

USE BelcorpVenezuela
GO

ALTER PROCEDURE [dbo].[UpdUsuarioClaveSecreta]
	@CodigoUsuario varchar(20),
	@ClaveSecreta varchar(200),
	@CambioClave bit
as
update dbo.Usuario
set ClaveSecreta = dbo.EncriptarClaveSHA1(@ClaveSecreta),
	CambioClave = @CambioClave
where CodigoUsuario = @CodigoUsuario
GO
