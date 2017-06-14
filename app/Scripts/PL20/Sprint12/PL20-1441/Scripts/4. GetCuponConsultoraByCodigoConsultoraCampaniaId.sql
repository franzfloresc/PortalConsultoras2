
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId'))
BEGIN
    DROP PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
END
GO

CREATE PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
@CodigoConsultora VARCHAR(50),
@CampaniaId INT
AS
/*
GetCuponConsultoraByCodigoConsultoraCampaniaId '000758833',201708
*/
BEGIN

SELECT top 1 
	cc.CuponConsultoraId,
	cc.CodigoConsultora,
	cc.CampaniaId,
	cc.CuponId,
	cc.ValorAsociado,
	cc.EstadoCupon,
	cc.EnvioCorreo,
	cc.FechaCreacion,
	cc.FechaModificacion,
	cc.UsuarioCreacion,
	cc.UsuarioModificacion,
	c.Tipo AS TipoCupon
FROM dbo.CuponConsultora cc
INNER JOIN dbo.Cupon c ON
	cc.CuponId = c.CuponId
WHERE 
	cc.CodigoConsultora = @CodigoConsultora
	AND cc.CampaniaId = @CampaniaId

END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId'))
BEGIN
    DROP PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
END
GO

CREATE PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
@CodigoConsultora VARCHAR(50),
@CampaniaId INT
AS
/*
GetCuponConsultoraByCodigoConsultoraCampaniaId '000758833',201708
*/
BEGIN

SELECT top 1 
	cc.CuponConsultoraId,
	cc.CodigoConsultora,
	cc.CampaniaId,
	cc.CuponId,
	cc.ValorAsociado,
	cc.EstadoCupon,
	cc.EnvioCorreo,
	cc.FechaCreacion,
	cc.FechaModificacion,
	cc.UsuarioCreacion,
	cc.UsuarioModificacion,
	c.Tipo AS TipoCupon
FROM dbo.CuponConsultora cc
INNER JOIN dbo.Cupon c ON
	cc.CuponId = c.CuponId
WHERE 
	cc.CodigoConsultora = @CodigoConsultora
	AND cc.CampaniaId = @CampaniaId

END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId'))
BEGIN
    DROP PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
END
GO

CREATE PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
@CodigoConsultora VARCHAR(50),
@CampaniaId INT
AS
/*
GetCuponConsultoraByCodigoConsultoraCampaniaId '000758833',201708
*/
BEGIN

SELECT top 1 
	cc.CuponConsultoraId,
	cc.CodigoConsultora,
	cc.CampaniaId,
	cc.CuponId,
	cc.ValorAsociado,
	cc.EstadoCupon,
	cc.EnvioCorreo,
	cc.FechaCreacion,
	cc.FechaModificacion,
	cc.UsuarioCreacion,
	cc.UsuarioModificacion,
	c.Tipo AS TipoCupon
FROM dbo.CuponConsultora cc
INNER JOIN dbo.Cupon c ON
	cc.CuponId = c.CuponId
WHERE 
	cc.CodigoConsultora = @CodigoConsultora
	AND cc.CampaniaId = @CampaniaId

END

GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId'))
BEGIN
    DROP PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
END
GO

CREATE PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
@CodigoConsultora VARCHAR(50),
@CampaniaId INT
AS
/*
GetCuponConsultoraByCodigoConsultoraCampaniaId '000758833',201708
*/
BEGIN

SELECT top 1 
	cc.CuponConsultoraId,
	cc.CodigoConsultora,
	cc.CampaniaId,
	cc.CuponId,
	cc.ValorAsociado,
	cc.EstadoCupon,
	cc.EnvioCorreo,
	cc.FechaCreacion,
	cc.FechaModificacion,
	cc.UsuarioCreacion,
	cc.UsuarioModificacion,
	c.Tipo AS TipoCupon
FROM dbo.CuponConsultora cc
INNER JOIN dbo.Cupon c ON
	cc.CuponId = c.CuponId
WHERE 
	cc.CodigoConsultora = @CodigoConsultora
	AND cc.CampaniaId = @CampaniaId

END

GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId'))
BEGIN
    DROP PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
END
GO

CREATE PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
@CodigoConsultora VARCHAR(50),
@CampaniaId INT
AS
/*
GetCuponConsultoraByCodigoConsultoraCampaniaId '000758833',201708
*/
BEGIN

SELECT top 1 
	cc.CuponConsultoraId,
	cc.CodigoConsultora,
	cc.CampaniaId,
	cc.CuponId,
	cc.ValorAsociado,
	cc.EstadoCupon,
	cc.EnvioCorreo,
	cc.FechaCreacion,
	cc.FechaModificacion,
	cc.UsuarioCreacion,
	cc.UsuarioModificacion,
	c.Tipo AS TipoCupon
FROM dbo.CuponConsultora cc
INNER JOIN dbo.Cupon c ON
	cc.CuponId = c.CuponId
WHERE 
	cc.CodigoConsultora = @CodigoConsultora
	AND cc.CampaniaId = @CampaniaId

END

GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId'))
BEGIN
    DROP PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
END
GO

CREATE PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
@CodigoConsultora VARCHAR(50),
@CampaniaId INT
AS
/*
GetCuponConsultoraByCodigoConsultoraCampaniaId '000758833',201708
*/
BEGIN

SELECT top 1 
	cc.CuponConsultoraId,
	cc.CodigoConsultora,
	cc.CampaniaId,
	cc.CuponId,
	cc.ValorAsociado,
	cc.EstadoCupon,
	cc.EnvioCorreo,
	cc.FechaCreacion,
	cc.FechaModificacion,
	cc.UsuarioCreacion,
	cc.UsuarioModificacion,
	c.Tipo AS TipoCupon
FROM dbo.CuponConsultora cc
INNER JOIN dbo.Cupon c ON
	cc.CuponId = c.CuponId
WHERE 
	cc.CodigoConsultora = @CodigoConsultora
	AND cc.CampaniaId = @CampaniaId

END

GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId'))
BEGIN
    DROP PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
END
GO

CREATE PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
@CodigoConsultora VARCHAR(50),
@CampaniaId INT
AS
/*
GetCuponConsultoraByCodigoConsultoraCampaniaId '000758833',201708
*/
BEGIN

SELECT top 1 
	cc.CuponConsultoraId,
	cc.CodigoConsultora,
	cc.CampaniaId,
	cc.CuponId,
	cc.ValorAsociado,
	cc.EstadoCupon,
	cc.EnvioCorreo,
	cc.FechaCreacion,
	cc.FechaModificacion,
	cc.UsuarioCreacion,
	cc.UsuarioModificacion,
	c.Tipo AS TipoCupon
FROM dbo.CuponConsultora cc
INNER JOIN dbo.Cupon c ON
	cc.CuponId = c.CuponId
WHERE 
	cc.CodigoConsultora = @CodigoConsultora
	AND cc.CampaniaId = @CampaniaId

END

GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId'))
BEGIN
    DROP PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
END
GO

CREATE PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
@CodigoConsultora VARCHAR(50),
@CampaniaId INT
AS
/*
GetCuponConsultoraByCodigoConsultoraCampaniaId '000758833',201708
*/
BEGIN

SELECT top 1 
	cc.CuponConsultoraId,
	cc.CodigoConsultora,
	cc.CampaniaId,
	cc.CuponId,
	cc.ValorAsociado,
	cc.EstadoCupon,
	cc.EnvioCorreo,
	cc.FechaCreacion,
	cc.FechaModificacion,
	cc.UsuarioCreacion,
	cc.UsuarioModificacion,
	c.Tipo AS TipoCupon
FROM dbo.CuponConsultora cc
INNER JOIN dbo.Cupon c ON
	cc.CuponId = c.CuponId
WHERE 
	cc.CodigoConsultora = @CodigoConsultora
	AND cc.CampaniaId = @CampaniaId

END

GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId'))
BEGIN
    DROP PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
END
GO

CREATE PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
@CodigoConsultora VARCHAR(50),
@CampaniaId INT
AS
/*
GetCuponConsultoraByCodigoConsultoraCampaniaId '000758833',201708
*/
BEGIN

SELECT top 1 
	cc.CuponConsultoraId,
	cc.CodigoConsultora,
	cc.CampaniaId,
	cc.CuponId,
	cc.ValorAsociado,
	cc.EstadoCupon,
	cc.EnvioCorreo,
	cc.FechaCreacion,
	cc.FechaModificacion,
	cc.UsuarioCreacion,
	cc.UsuarioModificacion,
	c.Tipo AS TipoCupon
FROM dbo.CuponConsultora cc
INNER JOIN dbo.Cupon c ON
	cc.CuponId = c.CuponId
WHERE 
	cc.CodigoConsultora = @CodigoConsultora
	AND cc.CampaniaId = @CampaniaId

END

GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId'))
BEGIN
    DROP PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
END
GO

CREATE PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
@CodigoConsultora VARCHAR(50),
@CampaniaId INT
AS
/*
GetCuponConsultoraByCodigoConsultoraCampaniaId '000758833',201708
*/
BEGIN

SELECT top 1 
	cc.CuponConsultoraId,
	cc.CodigoConsultora,
	cc.CampaniaId,
	cc.CuponId,
	cc.ValorAsociado,
	cc.EstadoCupon,
	cc.EnvioCorreo,
	cc.FechaCreacion,
	cc.FechaModificacion,
	cc.UsuarioCreacion,
	cc.UsuarioModificacion,
	c.Tipo AS TipoCupon
FROM dbo.CuponConsultora cc
INNER JOIN dbo.Cupon c ON
	cc.CuponId = c.CuponId
WHERE 
	cc.CodigoConsultora = @CodigoConsultora
	AND cc.CampaniaId = @CampaniaId

END

GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId'))
BEGIN
    DROP PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
END
GO

CREATE PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
@CodigoConsultora VARCHAR(50),
@CampaniaId INT
AS
/*
GetCuponConsultoraByCodigoConsultoraCampaniaId '000758833',201708
*/
BEGIN

SELECT top 1 
	cc.CuponConsultoraId,
	cc.CodigoConsultora,
	cc.CampaniaId,
	cc.CuponId,
	cc.ValorAsociado,
	cc.EstadoCupon,
	cc.EnvioCorreo,
	cc.FechaCreacion,
	cc.FechaModificacion,
	cc.UsuarioCreacion,
	cc.UsuarioModificacion,
	c.Tipo AS TipoCupon
FROM dbo.CuponConsultora cc
INNER JOIN dbo.Cupon c ON
	cc.CuponId = c.CuponId
WHERE 
	cc.CodigoConsultora = @CodigoConsultora
	AND cc.CampaniaId = @CampaniaId

END

GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId'))
BEGIN
    DROP PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
END
GO

CREATE PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
@CodigoConsultora VARCHAR(50),
@CampaniaId INT
AS
/*
GetCuponConsultoraByCodigoConsultoraCampaniaId '000758833',201708
*/
BEGIN

SELECT top 1 
	cc.CuponConsultoraId,
	cc.CodigoConsultora,
	cc.CampaniaId,
	cc.CuponId,
	cc.ValorAsociado,
	cc.EstadoCupon,
	cc.EnvioCorreo,
	cc.FechaCreacion,
	cc.FechaModificacion,
	cc.UsuarioCreacion,
	cc.UsuarioModificacion,
	c.Tipo AS TipoCupon
FROM dbo.CuponConsultora cc
INNER JOIN dbo.Cupon c ON
	cc.CuponId = c.CuponId
WHERE 
	cc.CodigoConsultora = @CodigoConsultora
	AND cc.CampaniaId = @CampaniaId

END

GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId'))
BEGIN
    DROP PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
END
GO

CREATE PROCEDURE dbo.GetCuponConsultoraByCodigoConsultoraCampaniaId
@CodigoConsultora VARCHAR(50),
@CampaniaId INT
AS
/*
GetCuponConsultoraByCodigoConsultoraCampaniaId '000758833',201708
*/
BEGIN

SELECT top 1 
	cc.CuponConsultoraId,
	cc.CodigoConsultora,
	cc.CampaniaId,
	cc.CuponId,
	cc.ValorAsociado,
	cc.EstadoCupon,
	cc.EnvioCorreo,
	cc.FechaCreacion,
	cc.FechaModificacion,
	cc.UsuarioCreacion,
	cc.UsuarioModificacion,
	c.Tipo AS TipoCupon
FROM dbo.CuponConsultora cc
INNER JOIN dbo.Cupon c ON
	cc.CuponId = c.CuponId
WHERE 
	cc.CodigoConsultora = @CodigoConsultora
	AND cc.CampaniaId = @CampaniaId

END

GO


