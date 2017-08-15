
USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[InsUsuario]
	@CodigoUsuario varchar(20),
	@PaisID tinyint,
	@Nombre varchar(80),
	@ClaveSecreta varchar(200),
	@EMail varchar(50),
	@EMailActivo bit,
	@Telefono varchar(20),
	@Celular varchar(20),
	@Sobrenombre varchar(80),
	@CompartirDatos bit,
	@Activo bit,
	@TipoUsuario tinyint,
	@CambioClave bit,
	@DocumentoIdentidad VARCHAR(20) = NULL
AS
INSERT INTO dbo.Usuario (
	CodigoUsuario, PaisID, Nombre, ClaveSecreta, EMail, EMailActivo, Telefono,
	Celular, Sobrenombre, CompartirDatos, Activo, TipoUsuario, CambioClave, DocumentoIdentidad)
VALUES (@CodigoUsuario, @PaisID, @Nombre, @ClaveSecreta, @EMail, @EMailActivo, @Telefono,
	@Celular, @Sobrenombre, @CompartirDatos, @Activo, @TipoUsuario, @CambioClave, @DocumentoIdentidad)
GO

/*end*/

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[InsUsuario]
	@CodigoUsuario varchar(20),
	@PaisID tinyint,
	@Nombre varchar(80),
	@ClaveSecreta varchar(200),
	@EMail varchar(50),
	@EMailActivo bit,
	@Telefono varchar(20),
	@Celular varchar(20),
	@Sobrenombre varchar(80),
	@CompartirDatos bit,
	@Activo bit,
	@TipoUsuario tinyint,
	@CambioClave bit,
	@DocumentoIdentidad VARCHAR(20) = NULL
AS
INSERT INTO dbo.Usuario (
	CodigoUsuario, PaisID, Nombre, ClaveSecreta, EMail, EMailActivo, Telefono,
	Celular, Sobrenombre, CompartirDatos, Activo, TipoUsuario, CambioClave, DocumentoIdentidad)
VALUES (@CodigoUsuario, @PaisID, @Nombre, @ClaveSecreta, @EMail, @EMailActivo, @Telefono,
	@Celular, @Sobrenombre, @CompartirDatos, @Activo, @TipoUsuario, @CambioClave, @DocumentoIdentidad)
GO
/*end*/

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[InsUsuario]
	@CodigoUsuario varchar(20),
	@PaisID tinyint,
	@Nombre varchar(80),
	@ClaveSecreta varchar(200),
	@EMail varchar(50),
	@EMailActivo bit,
	@Telefono varchar(20),
	@Celular varchar(20),
	@Sobrenombre varchar(80),
	@CompartirDatos bit,
	@Activo bit,
	@TipoUsuario tinyint,
	@CambioClave bit,
	@DocumentoIdentidad VARCHAR(20) = NULL
AS
INSERT INTO dbo.Usuario (
	CodigoUsuario, PaisID, Nombre, ClaveSecreta, EMail, EMailActivo, Telefono,
	Celular, Sobrenombre, CompartirDatos, Activo, TipoUsuario, CambioClave, DocumentoIdentidad)
VALUES (@CodigoUsuario, @PaisID, @Nombre, @ClaveSecreta, @EMail, @EMailActivo, @Telefono,
	@Celular, @Sobrenombre, @CompartirDatos, @Activo, @TipoUsuario, @CambioClave, @DocumentoIdentidad)
GO
/*end*/

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[InsUsuario]
	@CodigoUsuario varchar(20),
	@PaisID tinyint,
	@Nombre varchar(80),
	@ClaveSecreta varchar(200),
	@EMail varchar(50),
	@EMailActivo bit,
	@Telefono varchar(20),
	@Celular varchar(20),
	@Sobrenombre varchar(80),
	@CompartirDatos bit,
	@Activo bit,
	@TipoUsuario tinyint,
	@CambioClave bit,
	@DocumentoIdentidad VARCHAR(20) = NULL
AS
INSERT INTO dbo.Usuario (
	CodigoUsuario, PaisID, Nombre, ClaveSecreta, EMail, EMailActivo, Telefono,
	Celular, Sobrenombre, CompartirDatos, Activo, TipoUsuario, CambioClave, DocumentoIdentidad)
VALUES (@CodigoUsuario, @PaisID, @Nombre, @ClaveSecreta, @EMail, @EMailActivo, @Telefono,
	@Celular, @Sobrenombre, @CompartirDatos, @Activo, @TipoUsuario, @CambioClave, @DocumentoIdentidad)
GO
/*end*/

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[InsUsuario]
	@CodigoUsuario varchar(20),
	@PaisID tinyint,
	@Nombre varchar(80),
	@ClaveSecreta varchar(200),
	@EMail varchar(50),
	@EMailActivo bit,
	@Telefono varchar(20),
	@Celular varchar(20),
	@Sobrenombre varchar(80),
	@CompartirDatos bit,
	@Activo bit,
	@TipoUsuario tinyint,
	@CambioClave bit,
	@DocumentoIdentidad VARCHAR(20) = NULL
AS
INSERT INTO dbo.Usuario (
	CodigoUsuario, PaisID, Nombre, ClaveSecreta, EMail, EMailActivo, Telefono,
	Celular, Sobrenombre, CompartirDatos, Activo, TipoUsuario, CambioClave, DocumentoIdentidad)
VALUES (@CodigoUsuario, @PaisID, @Nombre, @ClaveSecreta, @EMail, @EMailActivo, @Telefono,
	@Celular, @Sobrenombre, @CompartirDatos, @Activo, @TipoUsuario, @CambioClave, @DocumentoIdentidad)
GO
/*end*/

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[InsUsuario]
	@CodigoUsuario varchar(20),
	@PaisID tinyint,
	@Nombre varchar(80),
	@ClaveSecreta varchar(200),
	@EMail varchar(50),
	@EMailActivo bit,
	@Telefono varchar(20),
	@Celular varchar(20),
	@Sobrenombre varchar(80),
	@CompartirDatos bit,
	@Activo bit,
	@TipoUsuario tinyint,
	@CambioClave bit,
	@DocumentoIdentidad VARCHAR(20) = NULL
AS
INSERT INTO dbo.Usuario (
	CodigoUsuario, PaisID, Nombre, ClaveSecreta, EMail, EMailActivo, Telefono,
	Celular, Sobrenombre, CompartirDatos, Activo, TipoUsuario, CambioClave, DocumentoIdentidad)
VALUES (@CodigoUsuario, @PaisID, @Nombre, @ClaveSecreta, @EMail, @EMailActivo, @Telefono,
	@Celular, @Sobrenombre, @CompartirDatos, @Activo, @TipoUsuario, @CambioClave, @DocumentoIdentidad)
GO
/*end*/

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[InsUsuario]
	@CodigoUsuario varchar(20),
	@PaisID tinyint,
	@Nombre varchar(80),
	@ClaveSecreta varchar(200),
	@EMail varchar(50),
	@EMailActivo bit,
	@Telefono varchar(20),
	@Celular varchar(20),
	@Sobrenombre varchar(80),
	@CompartirDatos bit,
	@Activo bit,
	@TipoUsuario tinyint,
	@CambioClave bit,
	@DocumentoIdentidad VARCHAR(20) = NULL
AS
INSERT INTO dbo.Usuario (
	CodigoUsuario, PaisID, Nombre, ClaveSecreta, EMail, EMailActivo, Telefono,
	Celular, Sobrenombre, CompartirDatos, Activo, TipoUsuario, CambioClave, DocumentoIdentidad)
VALUES (@CodigoUsuario, @PaisID, @Nombre, @ClaveSecreta, @EMail, @EMailActivo, @Telefono,
	@Celular, @Sobrenombre, @CompartirDatos, @Activo, @TipoUsuario, @CambioClave, @DocumentoIdentidad)
GO
/*end*/

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[InsUsuario]
	@CodigoUsuario varchar(20),
	@PaisID tinyint,
	@Nombre varchar(80),
	@ClaveSecreta varchar(200),
	@EMail varchar(50),
	@EMailActivo bit,
	@Telefono varchar(20),
	@Celular varchar(20),
	@Sobrenombre varchar(80),
	@CompartirDatos bit,
	@Activo bit,
	@TipoUsuario tinyint,
	@CambioClave bit,
	@DocumentoIdentidad VARCHAR(20) = NULL
AS
INSERT INTO dbo.Usuario (
	CodigoUsuario, PaisID, Nombre, ClaveSecreta, EMail, EMailActivo, Telefono,
	Celular, Sobrenombre, CompartirDatos, Activo, TipoUsuario, CambioClave, DocumentoIdentidad)
VALUES (@CodigoUsuario, @PaisID, @Nombre, @ClaveSecreta, @EMail, @EMailActivo, @Telefono,
	@Celular, @Sobrenombre, @CompartirDatos, @Activo, @TipoUsuario, @CambioClave, @DocumentoIdentidad)
GO
/*end*/

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[InsUsuario]
	@CodigoUsuario varchar(20),
	@PaisID tinyint,
	@Nombre varchar(80),
	@ClaveSecreta varchar(200),
	@EMail varchar(50),
	@EMailActivo bit,
	@Telefono varchar(20),
	@Celular varchar(20),
	@Sobrenombre varchar(80),
	@CompartirDatos bit,
	@Activo bit,
	@TipoUsuario tinyint,
	@CambioClave bit,
	@DocumentoIdentidad VARCHAR(20) = NULL
AS
INSERT INTO dbo.Usuario (
	CodigoUsuario, PaisID, Nombre, ClaveSecreta, EMail, EMailActivo, Telefono,
	Celular, Sobrenombre, CompartirDatos, Activo, TipoUsuario, CambioClave, DocumentoIdentidad)
VALUES (@CodigoUsuario, @PaisID, @Nombre, @ClaveSecreta, @EMail, @EMailActivo, @Telefono,
	@Celular, @Sobrenombre, @CompartirDatos, @Activo, @TipoUsuario, @CambioClave, @DocumentoIdentidad)
GO
/*end*/

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[InsUsuario]
	@CodigoUsuario varchar(20),
	@PaisID tinyint,
	@Nombre varchar(80),
	@ClaveSecreta varchar(200),
	@EMail varchar(50),
	@EMailActivo bit,
	@Telefono varchar(20),
	@Celular varchar(20),
	@Sobrenombre varchar(80),
	@CompartirDatos bit,
	@Activo bit,
	@TipoUsuario tinyint,
	@CambioClave bit,
	@DocumentoIdentidad VARCHAR(20) = NULL
AS
INSERT INTO dbo.Usuario (
	CodigoUsuario, PaisID, Nombre, ClaveSecreta, EMail, EMailActivo, Telefono,
	Celular, Sobrenombre, CompartirDatos, Activo, TipoUsuario, CambioClave, DocumentoIdentidad)
VALUES (@CodigoUsuario, @PaisID, @Nombre, @ClaveSecreta, @EMail, @EMailActivo, @Telefono,
	@Celular, @Sobrenombre, @CompartirDatos, @Activo, @TipoUsuario, @CambioClave, @DocumentoIdentidad)
GO
/*end*/

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[InsUsuario]
	@CodigoUsuario varchar(20),
	@PaisID tinyint,
	@Nombre varchar(80),
	@ClaveSecreta varchar(200),
	@EMail varchar(50),
	@EMailActivo bit,
	@Telefono varchar(20),
	@Celular varchar(20),
	@Sobrenombre varchar(80),
	@CompartirDatos bit,
	@Activo bit,
	@TipoUsuario tinyint,
	@CambioClave bit,
	@DocumentoIdentidad VARCHAR(20) = NULL
AS
INSERT INTO dbo.Usuario (
	CodigoUsuario, PaisID, Nombre, ClaveSecreta, EMail, EMailActivo, Telefono,
	Celular, Sobrenombre, CompartirDatos, Activo, TipoUsuario, CambioClave, DocumentoIdentidad)
VALUES (@CodigoUsuario, @PaisID, @Nombre, @ClaveSecreta, @EMail, @EMailActivo, @Telefono,
	@Celular, @Sobrenombre, @CompartirDatos, @Activo, @TipoUsuario, @CambioClave, @DocumentoIdentidad)
GO
/*end*/

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[InsUsuario]
	@CodigoUsuario varchar(20),
	@PaisID tinyint,
	@Nombre varchar(80),
	@ClaveSecreta varchar(200),
	@EMail varchar(50),
	@EMailActivo bit,
	@Telefono varchar(20),
	@Celular varchar(20),
	@Sobrenombre varchar(80),
	@CompartirDatos bit,
	@Activo bit,
	@TipoUsuario tinyint,
	@CambioClave bit,
	@DocumentoIdentidad VARCHAR(20) = NULL
AS
INSERT INTO dbo.Usuario (
	CodigoUsuario, PaisID, Nombre, ClaveSecreta, EMail, EMailActivo, Telefono,
	Celular, Sobrenombre, CompartirDatos, Activo, TipoUsuario, CambioClave, DocumentoIdentidad)
VALUES (@CodigoUsuario, @PaisID, @Nombre, @ClaveSecreta, @EMail, @EMailActivo, @Telefono,
	@Celular, @Sobrenombre, @CompartirDatos, @Activo, @TipoUsuario, @CambioClave, @DocumentoIdentidad)
GO
/*end*/

USE BelcorpVenezuela
GO

ALTER PROCEDURE [dbo].[InsUsuario]
	@CodigoUsuario varchar(20),
	@PaisID tinyint,
	@Nombre varchar(80),
	@ClaveSecreta varchar(200),
	@EMail varchar(50),
	@EMailActivo bit,
	@Telefono varchar(20),
	@Celular varchar(20),
	@Sobrenombre varchar(80),
	@CompartirDatos bit,
	@Activo bit,
	@TipoUsuario tinyint,
	@CambioClave bit,
	@DocumentoIdentidad VARCHAR(20) = NULL
AS
INSERT INTO dbo.Usuario (
	CodigoUsuario, PaisID, Nombre, ClaveSecreta, EMail, EMailActivo, Telefono,
	Celular, Sobrenombre, CompartirDatos, Activo, TipoUsuario, CambioClave, DocumentoIdentidad)
VALUES (@CodigoUsuario, @PaisID, @Nombre, @ClaveSecreta, @EMail, @EMailActivo, @Telefono,
	@Celular, @Sobrenombre, @CompartirDatos, @Activo, @TipoUsuario, @CambioClave, @DocumentoIdentidad)
GO