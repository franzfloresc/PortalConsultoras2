

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.UpdateCuponConsultoraEstadoCupon'))
BEGIN
    DROP PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
END
GO

CREATE PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
@CodigoConsultora VARCHAR(50),
@CampaniaId INT,
@EstadoCupon INT
AS
BEGIN

UPDATE CuponConsultora
SET
	EstadoCupon = @EstadoCupon 
WHERE
	CodigoConsultora = @CodigoConsultora
	AND CampaniaId = @CampaniaId

END

GO 
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.UpdateCuponConsultoraEstadoCupon'))
BEGIN
    DROP PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
END
GO

CREATE PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
@CodigoConsultora VARCHAR(50),
@CampaniaId INT,
@EstadoCupon INT
AS
BEGIN

UPDATE CuponConsultora
SET
	EstadoCupon = @EstadoCupon 
WHERE
	CodigoConsultora = @CodigoConsultora
	AND CampaniaId = @CampaniaId

END

GO 
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.UpdateCuponConsultoraEstadoCupon'))
BEGIN
    DROP PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
END
GO

CREATE PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
@CodigoConsultora VARCHAR(50),
@CampaniaId INT,
@EstadoCupon INT
AS
BEGIN

UPDATE CuponConsultora
SET
	EstadoCupon = @EstadoCupon 
WHERE
	CodigoConsultora = @CodigoConsultora
	AND CampaniaId = @CampaniaId

END

GO 
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.UpdateCuponConsultoraEstadoCupon'))
BEGIN
    DROP PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
END
GO

CREATE PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
@CodigoConsultora VARCHAR(50),
@CampaniaId INT,
@EstadoCupon INT
AS
BEGIN

UPDATE CuponConsultora
SET
	EstadoCupon = @EstadoCupon 
WHERE
	CodigoConsultora = @CodigoConsultora
	AND CampaniaId = @CampaniaId

END

GO 
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.UpdateCuponConsultoraEstadoCupon'))
BEGIN
    DROP PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
END
GO

CREATE PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
@CodigoConsultora VARCHAR(50),
@CampaniaId INT,
@EstadoCupon INT
AS
BEGIN

UPDATE CuponConsultora
SET
	EstadoCupon = @EstadoCupon 
WHERE
	CodigoConsultora = @CodigoConsultora
	AND CampaniaId = @CampaniaId

END

GO 
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.UpdateCuponConsultoraEstadoCupon'))
BEGIN
    DROP PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
END
GO

CREATE PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
@CodigoConsultora VARCHAR(50),
@CampaniaId INT,
@EstadoCupon INT
AS
BEGIN

UPDATE CuponConsultora
SET
	EstadoCupon = @EstadoCupon 
WHERE
	CodigoConsultora = @CodigoConsultora
	AND CampaniaId = @CampaniaId

END

GO 
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.UpdateCuponConsultoraEstadoCupon'))
BEGIN
    DROP PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
END
GO

CREATE PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
@CodigoConsultora VARCHAR(50),
@CampaniaId INT,
@EstadoCupon INT
AS
BEGIN

UPDATE CuponConsultora
SET
	EstadoCupon = @EstadoCupon 
WHERE
	CodigoConsultora = @CodigoConsultora
	AND CampaniaId = @CampaniaId

END

GO 
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.UpdateCuponConsultoraEstadoCupon'))
BEGIN
    DROP PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
END
GO

CREATE PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
@CodigoConsultora VARCHAR(50),
@CampaniaId INT,
@EstadoCupon INT
AS
BEGIN

UPDATE CuponConsultora
SET
	EstadoCupon = @EstadoCupon 
WHERE
	CodigoConsultora = @CodigoConsultora
	AND CampaniaId = @CampaniaId

END

GO 
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.UpdateCuponConsultoraEstadoCupon'))
BEGIN
    DROP PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
END
GO

CREATE PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
@CodigoConsultora VARCHAR(50),
@CampaniaId INT,
@EstadoCupon INT
AS
BEGIN

UPDATE CuponConsultora
SET
	EstadoCupon = @EstadoCupon 
WHERE
	CodigoConsultora = @CodigoConsultora
	AND CampaniaId = @CampaniaId

END

GO 
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.UpdateCuponConsultoraEstadoCupon'))
BEGIN
    DROP PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
END
GO

CREATE PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
@CodigoConsultora VARCHAR(50),
@CampaniaId INT,
@EstadoCupon INT
AS
BEGIN

UPDATE CuponConsultora
SET
	EstadoCupon = @EstadoCupon 
WHERE
	CodigoConsultora = @CodigoConsultora
	AND CampaniaId = @CampaniaId

END

GO 
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.UpdateCuponConsultoraEstadoCupon'))
BEGIN
    DROP PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
END
GO

CREATE PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
@CodigoConsultora VARCHAR(50),
@CampaniaId INT,
@EstadoCupon INT
AS
BEGIN

UPDATE CuponConsultora
SET
	EstadoCupon = @EstadoCupon 
WHERE
	CodigoConsultora = @CodigoConsultora
	AND CampaniaId = @CampaniaId

END

GO 
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.UpdateCuponConsultoraEstadoCupon'))
BEGIN
    DROP PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
END
GO

CREATE PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
@CodigoConsultora VARCHAR(50),
@CampaniaId INT,
@EstadoCupon INT
AS
BEGIN

UPDATE CuponConsultora
SET
	EstadoCupon = @EstadoCupon 
WHERE
	CodigoConsultora = @CodigoConsultora
	AND CampaniaId = @CampaniaId

END

GO 
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.UpdateCuponConsultoraEstadoCupon'))
BEGIN
    DROP PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
END
GO

CREATE PROCEDURE dbo.UpdateCuponConsultoraEstadoCupon
@CodigoConsultora VARCHAR(50),
@CampaniaId INT,
@EstadoCupon INT
AS
BEGIN

UPDATE CuponConsultora
SET
	EstadoCupon = @EstadoCupon 
WHERE
	CodigoConsultora = @CodigoConsultora
	AND CampaniaId = @CampaniaId

END

GO 
