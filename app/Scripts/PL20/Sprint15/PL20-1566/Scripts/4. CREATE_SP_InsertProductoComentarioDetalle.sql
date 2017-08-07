
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.InsertProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.InsertProductoComentarioDetalle
END
GO

CREATE PROCEDURE dbo.InsertProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@Valorizado TINYINT,
	@Recomendado BIT,
	@Comentario VARCHAR(400),
	@CodigoConsultora VARCHAR(20),
	@CampaniaID INT,
	@CodTipoOrigen INT
)
AS

BEGIN
	INSERT INTO ProductoComentarioDetalle
	(
		ProdComentarioId,
		Valorizado,
		Recomendado,
		Comentario,
		CodigoConsultora,
		CampaniaID,
		CodTipoOrigen,
		FechaRegistro,
		Estado
	)
	VALUES 
	(
		@ProdComentarioId,
		@Valorizado,
		@Recomendado,
		@Comentario,
		@CodigoConsultora,
		@CampaniaID,
		@CodTipoOrigen,
		GETDATE(),
		1
	)

	SELECT @@Identity AS ProdComentarioDetalleId
END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.InsertProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.InsertProductoComentarioDetalle
END
GO

CREATE PROCEDURE dbo.InsertProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@Valorizado TINYINT,
	@Recomendado BIT,
	@Comentario VARCHAR(400),
	@CodigoConsultora VARCHAR(20),
	@CampaniaID INT,
	@CodTipoOrigen INT
)
AS

BEGIN
	INSERT INTO ProductoComentarioDetalle
	(
		ProdComentarioId,
		Valorizado,
		Recomendado,
		Comentario,
		CodigoConsultora,
		CampaniaID,
		CodTipoOrigen,
		FechaRegistro,
		Estado
	)
	VALUES 
	(
		@ProdComentarioId,
		@Valorizado,
		@Recomendado,
		@Comentario,
		@CodigoConsultora,
		@CampaniaID,
		@CodTipoOrigen,
		GETDATE(),
		1
	)

	SELECT @@Identity AS ProdComentarioDetalleId
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.InsertProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.InsertProductoComentarioDetalle
END
GO

CREATE PROCEDURE dbo.InsertProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@Valorizado TINYINT,
	@Recomendado BIT,
	@Comentario VARCHAR(400),
	@CodigoConsultora VARCHAR(20),
	@CampaniaID INT,
	@CodTipoOrigen INT
)
AS

BEGIN
	INSERT INTO ProductoComentarioDetalle
	(
		ProdComentarioId,
		Valorizado,
		Recomendado,
		Comentario,
		CodigoConsultora,
		CampaniaID,
		CodTipoOrigen,
		FechaRegistro,
		Estado
	)
	VALUES 
	(
		@ProdComentarioId,
		@Valorizado,
		@Recomendado,
		@Comentario,
		@CodigoConsultora,
		@CampaniaID,
		@CodTipoOrigen,
		GETDATE(),
		1
	)

	SELECT @@Identity AS ProdComentarioDetalleId
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.InsertProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.InsertProductoComentarioDetalle
END
GO

CREATE PROCEDURE dbo.InsertProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@Valorizado TINYINT,
	@Recomendado BIT,
	@Comentario VARCHAR(400),
	@CodigoConsultora VARCHAR(20),
	@CampaniaID INT,
	@CodTipoOrigen INT
)
AS

BEGIN
	INSERT INTO ProductoComentarioDetalle
	(
		ProdComentarioId,
		Valorizado,
		Recomendado,
		Comentario,
		CodigoConsultora,
		CampaniaID,
		CodTipoOrigen,
		FechaRegistro,
		Estado
	)
	VALUES 
	(
		@ProdComentarioId,
		@Valorizado,
		@Recomendado,
		@Comentario,
		@CodigoConsultora,
		@CampaniaID,
		@CodTipoOrigen,
		GETDATE(),
		1
	)

	SELECT @@Identity AS ProdComentarioDetalleId
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.InsertProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.InsertProductoComentarioDetalle
END
GO

CREATE PROCEDURE dbo.InsertProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@Valorizado TINYINT,
	@Recomendado BIT,
	@Comentario VARCHAR(400),
	@CodigoConsultora VARCHAR(20),
	@CampaniaID INT,
	@CodTipoOrigen INT
)
AS

BEGIN
	INSERT INTO ProductoComentarioDetalle
	(
		ProdComentarioId,
		Valorizado,
		Recomendado,
		Comentario,
		CodigoConsultora,
		CampaniaID,
		CodTipoOrigen,
		FechaRegistro,
		Estado
	)
	VALUES 
	(
		@ProdComentarioId,
		@Valorizado,
		@Recomendado,
		@Comentario,
		@CodigoConsultora,
		@CampaniaID,
		@CodTipoOrigen,
		GETDATE(),
		1
	)

	SELECT @@Identity AS ProdComentarioDetalleId
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.InsertProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.InsertProductoComentarioDetalle
END
GO

CREATE PROCEDURE dbo.InsertProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@Valorizado TINYINT,
	@Recomendado BIT,
	@Comentario VARCHAR(400),
	@CodigoConsultora VARCHAR(20),
	@CampaniaID INT,
	@CodTipoOrigen INT
)
AS

BEGIN
	INSERT INTO ProductoComentarioDetalle
	(
		ProdComentarioId,
		Valorizado,
		Recomendado,
		Comentario,
		CodigoConsultora,
		CampaniaID,
		CodTipoOrigen,
		FechaRegistro,
		Estado
	)
	VALUES 
	(
		@ProdComentarioId,
		@Valorizado,
		@Recomendado,
		@Comentario,
		@CodigoConsultora,
		@CampaniaID,
		@CodTipoOrigen,
		GETDATE(),
		1
	)

	SELECT @@Identity AS ProdComentarioDetalleId
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.InsertProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.InsertProductoComentarioDetalle
END
GO

CREATE PROCEDURE dbo.InsertProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@Valorizado TINYINT,
	@Recomendado BIT,
	@Comentario VARCHAR(400),
	@CodigoConsultora VARCHAR(20),
	@CampaniaID INT,
	@CodTipoOrigen INT
)
AS

BEGIN
	INSERT INTO ProductoComentarioDetalle
	(
		ProdComentarioId,
		Valorizado,
		Recomendado,
		Comentario,
		CodigoConsultora,
		CampaniaID,
		CodTipoOrigen,
		FechaRegistro,
		Estado
	)
	VALUES 
	(
		@ProdComentarioId,
		@Valorizado,
		@Recomendado,
		@Comentario,
		@CodigoConsultora,
		@CampaniaID,
		@CodTipoOrigen,
		GETDATE(),
		1
	)

	SELECT @@Identity AS ProdComentarioDetalleId
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.InsertProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.InsertProductoComentarioDetalle
END
GO

CREATE PROCEDURE dbo.InsertProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@Valorizado TINYINT,
	@Recomendado BIT,
	@Comentario VARCHAR(400),
	@CodigoConsultora VARCHAR(20),
	@CampaniaID INT,
	@CodTipoOrigen INT
)
AS

BEGIN
	INSERT INTO ProductoComentarioDetalle
	(
		ProdComentarioId,
		Valorizado,
		Recomendado,
		Comentario,
		CodigoConsultora,
		CampaniaID,
		CodTipoOrigen,
		FechaRegistro,
		Estado
	)
	VALUES 
	(
		@ProdComentarioId,
		@Valorizado,
		@Recomendado,
		@Comentario,
		@CodigoConsultora,
		@CampaniaID,
		@CodTipoOrigen,
		GETDATE(),
		1
	)

	SELECT @@Identity AS ProdComentarioDetalleId
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.InsertProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.InsertProductoComentarioDetalle
END
GO

CREATE PROCEDURE dbo.InsertProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@Valorizado TINYINT,
	@Recomendado BIT,
	@Comentario VARCHAR(400),
	@CodigoConsultora VARCHAR(20),
	@CampaniaID INT,
	@CodTipoOrigen INT
)
AS

BEGIN
	INSERT INTO ProductoComentarioDetalle
	(
		ProdComentarioId,
		Valorizado,
		Recomendado,
		Comentario,
		CodigoConsultora,
		CampaniaID,
		CodTipoOrigen,
		FechaRegistro,
		Estado
	)
	VALUES 
	(
		@ProdComentarioId,
		@Valorizado,
		@Recomendado,
		@Comentario,
		@CodigoConsultora,
		@CampaniaID,
		@CodTipoOrigen,
		GETDATE(),
		1
	)

	SELECT @@Identity AS ProdComentarioDetalleId
END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.InsertProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.InsertProductoComentarioDetalle
END
GO

CREATE PROCEDURE dbo.InsertProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@Valorizado TINYINT,
	@Recomendado BIT,
	@Comentario VARCHAR(400),
	@CodigoConsultora VARCHAR(20),
	@CampaniaID INT,
	@CodTipoOrigen INT
)
AS

BEGIN
	INSERT INTO ProductoComentarioDetalle
	(
		ProdComentarioId,
		Valorizado,
		Recomendado,
		Comentario,
		CodigoConsultora,
		CampaniaID,
		CodTipoOrigen,
		FechaRegistro,
		Estado
	)
	VALUES 
	(
		@ProdComentarioId,
		@Valorizado,
		@Recomendado,
		@Comentario,
		@CodigoConsultora,
		@CampaniaID,
		@CodTipoOrigen,
		GETDATE(),
		1
	)

	SELECT @@Identity AS ProdComentarioDetalleId
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.InsertProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.InsertProductoComentarioDetalle
END
GO

CREATE PROCEDURE dbo.InsertProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@Valorizado TINYINT,
	@Recomendado BIT,
	@Comentario VARCHAR(400),
	@CodigoConsultora VARCHAR(20),
	@CampaniaID INT,
	@CodTipoOrigen INT
)
AS

BEGIN
	INSERT INTO ProductoComentarioDetalle
	(
		ProdComentarioId,
		Valorizado,
		Recomendado,
		Comentario,
		CodigoConsultora,
		CampaniaID,
		CodTipoOrigen,
		FechaRegistro,
		Estado
	)
	VALUES 
	(
		@ProdComentarioId,
		@Valorizado,
		@Recomendado,
		@Comentario,
		@CodigoConsultora,
		@CampaniaID,
		@CodTipoOrigen,
		GETDATE(),
		1
	)

	SELECT @@Identity AS ProdComentarioDetalleId
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.InsertProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.InsertProductoComentarioDetalle
END
GO

CREATE PROCEDURE dbo.InsertProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@Valorizado TINYINT,
	@Recomendado BIT,
	@Comentario VARCHAR(400),
	@CodigoConsultora VARCHAR(20),
	@CampaniaID INT,
	@CodTipoOrigen INT
)
AS

BEGIN
	INSERT INTO ProductoComentarioDetalle
	(
		ProdComentarioId,
		Valorizado,
		Recomendado,
		Comentario,
		CodigoConsultora,
		CampaniaID,
		CodTipoOrigen,
		FechaRegistro,
		Estado
	)
	VALUES 
	(
		@ProdComentarioId,
		@Valorizado,
		@Recomendado,
		@Comentario,
		@CodigoConsultora,
		@CampaniaID,
		@CodTipoOrigen,
		GETDATE(),
		1
	)

	SELECT @@Identity AS ProdComentarioDetalleId
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.InsertProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.InsertProductoComentarioDetalle
END
GO

CREATE PROCEDURE dbo.InsertProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@Valorizado TINYINT,
	@Recomendado BIT,
	@Comentario VARCHAR(400),
	@CodigoConsultora VARCHAR(20),
	@CampaniaID INT,
	@CodTipoOrigen INT
)
AS

BEGIN
	INSERT INTO ProductoComentarioDetalle
	(
		ProdComentarioId,
		Valorizado,
		Recomendado,
		Comentario,
		CodigoConsultora,
		CampaniaID,
		CodTipoOrigen,
		FechaRegistro,
		Estado
	)
	VALUES 
	(
		@ProdComentarioId,
		@Valorizado,
		@Recomendado,
		@Comentario,
		@CodigoConsultora,
		@CampaniaID,
		@CodTipoOrigen,
		GETDATE(),
		1
	)

	SELECT @@Identity AS ProdComentarioDetalleId
END
GO

