USE BelcorpPeru
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSellingDetalle'
		)
BEGIN
	DROP TABLE [dbo].[UpSellingDetalle]
END
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSelling'
		)
BEGIN
	DROP TABLE [dbo].[UpSelling]
END
GO

CREATE TABLE UpSelling (
	UpSellingId INT NOT NULL identity PRIMARY KEY
	,CodigoCampana VARCHAR(6) NOT NULL
	,MontoMeta DECIMAL(21, 4) NOT NULL
	,TextoMeta1 VARCHAR(250) NOT NULL
	,TextoMeta2 VARCHAR(250) NULL
	,TextoGanaste1 VARCHAR(250) NULL
	,TextoGanaste2 VARCHAR(250) NULL
	,Activo BIT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

CREATE TABLE UpSellingDetalle (
	UpSellingDetalleId INT NOT NULL identity PRIMARY KEY
	,CUV VARCHAR(50) NOT NULL --6?
	,Nombre VARCHAR(250) NOT NULL
	,Descripcion VARCHAR(500) NULL
	,Imagen VARCHAR(400) NULL
	,Stock INT NOT NULL
	,Orden INT NOT NULL
	,Activo BIT NOT NULL
	,UpSellingId INT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

ALTER TABLE UpSellingDetalle ADD CONSTRAINT FK_UpSellingDetalle FOREIGN KEY (UpSellingId) REFERENCES UpSelling (UpSellingId);

GO

USE BelcorpMexico
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSellingDetalle'
		)
BEGIN
	DROP TABLE [dbo].[UpSellingDetalle]
END
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSelling'
		)
BEGIN
	DROP TABLE [dbo].[UpSelling]
END
GO

CREATE TABLE UpSelling (
	UpSellingId INT NOT NULL identity PRIMARY KEY
	,CodigoCampana VARCHAR(6) NOT NULL
	,MontoMeta DECIMAL(21, 4) NOT NULL
	,TextoMeta1 VARCHAR(250) NOT NULL
	,TextoMeta2 VARCHAR(250) NULL
	,TextoGanaste1 VARCHAR(250) NULL
	,TextoGanaste2 VARCHAR(250) NULL
	,Activo BIT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

CREATE TABLE UpSellingDetalle (
	UpSellingDetalleId INT NOT NULL identity PRIMARY KEY
	,CUV VARCHAR(50) NOT NULL --6?
	,Nombre VARCHAR(250) NOT NULL
	,Descripcion VARCHAR(500) NULL
	,Imagen VARCHAR(400) NULL
	,Stock INT NOT NULL
	,Orden INT NOT NULL
	,Activo BIT NOT NULL
	,UpSellingId INT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

ALTER TABLE UpSellingDetalle ADD CONSTRAINT FK_UpSellingDetalle FOREIGN KEY (UpSellingId) REFERENCES UpSelling (UpSellingId);

GO

USE BelcorpColombia
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSellingDetalle'
		)
BEGIN
	DROP TABLE [dbo].[UpSellingDetalle]
END
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSelling'
		)
BEGIN
	DROP TABLE [dbo].[UpSelling]
END
GO

CREATE TABLE UpSelling (
	UpSellingId INT NOT NULL identity PRIMARY KEY
	,CodigoCampana VARCHAR(6) NOT NULL
	,MontoMeta DECIMAL(21, 4) NOT NULL
	,TextoMeta1 VARCHAR(250) NOT NULL
	,TextoMeta2 VARCHAR(250) NULL
	,TextoGanaste1 VARCHAR(250) NULL
	,TextoGanaste2 VARCHAR(250) NULL
	,Activo BIT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

CREATE TABLE UpSellingDetalle (
	UpSellingDetalleId INT NOT NULL identity PRIMARY KEY
	,CUV VARCHAR(50) NOT NULL --6?
	,Nombre VARCHAR(250) NOT NULL
	,Descripcion VARCHAR(500) NULL
	,Imagen VARCHAR(400) NULL
	,Stock INT NOT NULL
	,Orden INT NOT NULL
	,Activo BIT NOT NULL
	,UpSellingId INT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

ALTER TABLE UpSellingDetalle ADD CONSTRAINT FK_UpSellingDetalle FOREIGN KEY (UpSellingId) REFERENCES UpSelling (UpSellingId);

GO

USE BelcorpVenezuela
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSellingDetalle'
		)
BEGIN
	DROP TABLE [dbo].[UpSellingDetalle]
END
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSelling'
		)
BEGIN
	DROP TABLE [dbo].[UpSelling]
END
GO

CREATE TABLE UpSelling (
	UpSellingId INT NOT NULL identity PRIMARY KEY
	,CodigoCampana VARCHAR(6) NOT NULL
	,MontoMeta DECIMAL(21, 4) NOT NULL
	,TextoMeta1 VARCHAR(250) NOT NULL
	,TextoMeta2 VARCHAR(250) NULL
	,TextoGanaste1 VARCHAR(250) NULL
	,TextoGanaste2 VARCHAR(250) NULL
	,Activo BIT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

CREATE TABLE UpSellingDetalle (
	UpSellingDetalleId INT NOT NULL identity PRIMARY KEY
	,CUV VARCHAR(50) NOT NULL --6?
	,Nombre VARCHAR(250) NOT NULL
	,Descripcion VARCHAR(500) NULL
	,Imagen VARCHAR(400) NULL
	,Stock INT NOT NULL
	,Orden INT NOT NULL
	,Activo BIT NOT NULL
	,UpSellingId INT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

ALTER TABLE UpSellingDetalle ADD CONSTRAINT FK_UpSellingDetalle FOREIGN KEY (UpSellingId) REFERENCES UpSelling (UpSellingId);

GO

USE BelcorpSalvador
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSellingDetalle'
		)
BEGIN
	DROP TABLE [dbo].[UpSellingDetalle]
END
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSelling'
		)
BEGIN
	DROP TABLE [dbo].[UpSelling]
END
GO

CREATE TABLE UpSelling (
	UpSellingId INT NOT NULL identity PRIMARY KEY
	,CodigoCampana VARCHAR(6) NOT NULL
	,MontoMeta DECIMAL(21, 4) NOT NULL
	,TextoMeta1 VARCHAR(250) NOT NULL
	,TextoMeta2 VARCHAR(250) NULL
	,TextoGanaste1 VARCHAR(250) NULL
	,TextoGanaste2 VARCHAR(250) NULL
	,Activo BIT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

CREATE TABLE UpSellingDetalle (
	UpSellingDetalleId INT NOT NULL identity PRIMARY KEY
	,CUV VARCHAR(50) NOT NULL --6?
	,Nombre VARCHAR(250) NOT NULL
	,Descripcion VARCHAR(500) NULL
	,Imagen VARCHAR(400) NULL
	,Stock INT NOT NULL
	,Orden INT NOT NULL
	,Activo BIT NOT NULL
	,UpSellingId INT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

ALTER TABLE UpSellingDetalle ADD CONSTRAINT FK_UpSellingDetalle FOREIGN KEY (UpSellingId) REFERENCES UpSelling (UpSellingId);

GO

USE BelcorpPuertoRico
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSellingDetalle'
		)
BEGIN
	DROP TABLE [dbo].[UpSellingDetalle]
END
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSelling'
		)
BEGIN
	DROP TABLE [dbo].[UpSelling]
END
GO

CREATE TABLE UpSelling (
	UpSellingId INT NOT NULL identity PRIMARY KEY
	,CodigoCampana VARCHAR(6) NOT NULL
	,MontoMeta DECIMAL(21, 4) NOT NULL
	,TextoMeta1 VARCHAR(250) NOT NULL
	,TextoMeta2 VARCHAR(250) NULL
	,TextoGanaste1 VARCHAR(250) NULL
	,TextoGanaste2 VARCHAR(250) NULL
	,Activo BIT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

CREATE TABLE UpSellingDetalle (
	UpSellingDetalleId INT NOT NULL identity PRIMARY KEY
	,CUV VARCHAR(50) NOT NULL --6?
	,Nombre VARCHAR(250) NOT NULL
	,Descripcion VARCHAR(500) NULL
	,Imagen VARCHAR(400) NULL
	,Stock INT NOT NULL
	,Orden INT NOT NULL
	,Activo BIT NOT NULL
	,UpSellingId INT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

ALTER TABLE UpSellingDetalle ADD CONSTRAINT FK_UpSellingDetalle FOREIGN KEY (UpSellingId) REFERENCES UpSelling (UpSellingId);

GO

USE BelcorpPanama
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSellingDetalle'
		)
BEGIN
	DROP TABLE [dbo].[UpSellingDetalle]
END
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSelling'
		)
BEGIN
	DROP TABLE [dbo].[UpSelling]
END
GO

CREATE TABLE UpSelling (
	UpSellingId INT NOT NULL identity PRIMARY KEY
	,CodigoCampana VARCHAR(6) NOT NULL
	,MontoMeta DECIMAL(21, 4) NOT NULL
	,TextoMeta1 VARCHAR(250) NOT NULL
	,TextoMeta2 VARCHAR(250) NULL
	,TextoGanaste1 VARCHAR(250) NULL
	,TextoGanaste2 VARCHAR(250) NULL
	,Activo BIT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

CREATE TABLE UpSellingDetalle (
	UpSellingDetalleId INT NOT NULL identity PRIMARY KEY
	,CUV VARCHAR(50) NOT NULL --6?
	,Nombre VARCHAR(250) NOT NULL
	,Descripcion VARCHAR(500) NULL
	,Imagen VARCHAR(400) NULL
	,Stock INT NOT NULL
	,Orden INT NOT NULL
	,Activo BIT NOT NULL
	,UpSellingId INT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

ALTER TABLE UpSellingDetalle ADD CONSTRAINT FK_UpSellingDetalle FOREIGN KEY (UpSellingId) REFERENCES UpSelling (UpSellingId);

GO

USE BelcorpGuatemala
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSellingDetalle'
		)
BEGIN
	DROP TABLE [dbo].[UpSellingDetalle]
END
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSelling'
		)
BEGIN
	DROP TABLE [dbo].[UpSelling]
END
GO

CREATE TABLE UpSelling (
	UpSellingId INT NOT NULL identity PRIMARY KEY
	,CodigoCampana VARCHAR(6) NOT NULL
	,MontoMeta DECIMAL(21, 4) NOT NULL
	,TextoMeta1 VARCHAR(250) NOT NULL
	,TextoMeta2 VARCHAR(250) NULL
	,TextoGanaste1 VARCHAR(250) NULL
	,TextoGanaste2 VARCHAR(250) NULL
	,Activo BIT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

CREATE TABLE UpSellingDetalle (
	UpSellingDetalleId INT NOT NULL identity PRIMARY KEY
	,CUV VARCHAR(50) NOT NULL --6?
	,Nombre VARCHAR(250) NOT NULL
	,Descripcion VARCHAR(500) NULL
	,Imagen VARCHAR(400) NULL
	,Stock INT NOT NULL
	,Orden INT NOT NULL
	,Activo BIT NOT NULL
	,UpSellingId INT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

ALTER TABLE UpSellingDetalle ADD CONSTRAINT FK_UpSellingDetalle FOREIGN KEY (UpSellingId) REFERENCES UpSelling (UpSellingId);

GO

USE BelcorpEcuador
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSellingDetalle'
		)
BEGIN
	DROP TABLE [dbo].[UpSellingDetalle]
END
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSelling'
		)
BEGIN
	DROP TABLE [dbo].[UpSelling]
END
GO

CREATE TABLE UpSelling (
	UpSellingId INT NOT NULL identity PRIMARY KEY
	,CodigoCampana VARCHAR(6) NOT NULL
	,MontoMeta DECIMAL(21, 4) NOT NULL
	,TextoMeta1 VARCHAR(250) NOT NULL
	,TextoMeta2 VARCHAR(250) NULL
	,TextoGanaste1 VARCHAR(250) NULL
	,TextoGanaste2 VARCHAR(250) NULL
	,Activo BIT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

CREATE TABLE UpSellingDetalle (
	UpSellingDetalleId INT NOT NULL identity PRIMARY KEY
	,CUV VARCHAR(50) NOT NULL --6?
	,Nombre VARCHAR(250) NOT NULL
	,Descripcion VARCHAR(500) NULL
	,Imagen VARCHAR(400) NULL
	,Stock INT NOT NULL
	,Orden INT NOT NULL
	,Activo BIT NOT NULL
	,UpSellingId INT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

ALTER TABLE UpSellingDetalle ADD CONSTRAINT FK_UpSellingDetalle FOREIGN KEY (UpSellingId) REFERENCES UpSelling (UpSellingId);

GO

USE BelcorpDominicana
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSellingDetalle'
		)
BEGIN
	DROP TABLE [dbo].[UpSellingDetalle]
END
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSelling'
		)
BEGIN
	DROP TABLE [dbo].[UpSelling]
END
GO

CREATE TABLE UpSelling (
	UpSellingId INT NOT NULL identity PRIMARY KEY
	,CodigoCampana VARCHAR(6) NOT NULL
	,MontoMeta DECIMAL(21, 4) NOT NULL
	,TextoMeta1 VARCHAR(250) NOT NULL
	,TextoMeta2 VARCHAR(250) NULL
	,TextoGanaste1 VARCHAR(250) NULL
	,TextoGanaste2 VARCHAR(250) NULL
	,Activo BIT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

CREATE TABLE UpSellingDetalle (
	UpSellingDetalleId INT NOT NULL identity PRIMARY KEY
	,CUV VARCHAR(50) NOT NULL --6?
	,Nombre VARCHAR(250) NOT NULL
	,Descripcion VARCHAR(500) NULL
	,Imagen VARCHAR(400) NULL
	,Stock INT NOT NULL
	,Orden INT NOT NULL
	,Activo BIT NOT NULL
	,UpSellingId INT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

ALTER TABLE UpSellingDetalle ADD CONSTRAINT FK_UpSellingDetalle FOREIGN KEY (UpSellingId) REFERENCES UpSelling (UpSellingId);

GO

USE BelcorpCostaRica
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSellingDetalle'
		)
BEGIN
	DROP TABLE [dbo].[UpSellingDetalle]
END
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSelling'
		)
BEGIN
	DROP TABLE [dbo].[UpSelling]
END
GO

CREATE TABLE UpSelling (
	UpSellingId INT NOT NULL identity PRIMARY KEY
	,CodigoCampana VARCHAR(6) NOT NULL
	,MontoMeta DECIMAL(21, 4) NOT NULL
	,TextoMeta1 VARCHAR(250) NOT NULL
	,TextoMeta2 VARCHAR(250) NULL
	,TextoGanaste1 VARCHAR(250) NULL
	,TextoGanaste2 VARCHAR(250) NULL
	,Activo BIT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

CREATE TABLE UpSellingDetalle (
	UpSellingDetalleId INT NOT NULL identity PRIMARY KEY
	,CUV VARCHAR(50) NOT NULL --6?
	,Nombre VARCHAR(250) NOT NULL
	,Descripcion VARCHAR(500) NULL
	,Imagen VARCHAR(400) NULL
	,Stock INT NOT NULL
	,Orden INT NOT NULL
	,Activo BIT NOT NULL
	,UpSellingId INT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

ALTER TABLE UpSellingDetalle ADD CONSTRAINT FK_UpSellingDetalle FOREIGN KEY (UpSellingId) REFERENCES UpSelling (UpSellingId);

GO

USE BelcorpChile
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSellingDetalle'
		)
BEGIN
	DROP TABLE [dbo].[UpSellingDetalle]
END
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSelling'
		)
BEGIN
	DROP TABLE [dbo].[UpSelling]
END
GO

CREATE TABLE UpSelling (
	UpSellingId INT NOT NULL identity PRIMARY KEY
	,CodigoCampana VARCHAR(6) NOT NULL
	,MontoMeta DECIMAL(21, 4) NOT NULL
	,TextoMeta1 VARCHAR(250) NOT NULL
	,TextoMeta2 VARCHAR(250) NULL
	,TextoGanaste1 VARCHAR(250) NULL
	,TextoGanaste2 VARCHAR(250) NULL
	,Activo BIT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

CREATE TABLE UpSellingDetalle (
	UpSellingDetalleId INT NOT NULL identity PRIMARY KEY
	,CUV VARCHAR(50) NOT NULL --6?
	,Nombre VARCHAR(250) NOT NULL
	,Descripcion VARCHAR(500) NULL
	,Imagen VARCHAR(400) NULL
	,Stock INT NOT NULL
	,Orden INT NOT NULL
	,Activo BIT NOT NULL
	,UpSellingId INT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

ALTER TABLE UpSellingDetalle ADD CONSTRAINT FK_UpSellingDetalle FOREIGN KEY (UpSellingId) REFERENCES UpSelling (UpSellingId);

GO

USE BelcorpBolivia
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSellingDetalle'
		)
BEGIN
	DROP TABLE [dbo].[UpSellingDetalle]
END
GO

IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'UpSelling'
		)
BEGIN
	DROP TABLE [dbo].[UpSelling]
END
GO

CREATE TABLE UpSelling (
	UpSellingId INT NOT NULL identity PRIMARY KEY
	,CodigoCampana VARCHAR(6) NOT NULL
	,MontoMeta DECIMAL(21, 4) NOT NULL
	,TextoMeta1 VARCHAR(250) NOT NULL
	,TextoMeta2 VARCHAR(250) NULL
	,TextoGanaste1 VARCHAR(250) NULL
	,TextoGanaste2 VARCHAR(250) NULL
	,Activo BIT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

CREATE TABLE UpSellingDetalle (
	UpSellingDetalleId INT NOT NULL identity PRIMARY KEY
	,CUV VARCHAR(50) NOT NULL --6?
	,Nombre VARCHAR(250) NOT NULL
	,Descripcion VARCHAR(500) NULL
	,Imagen VARCHAR(400) NULL
	,Stock INT NOT NULL
	,Orden INT NOT NULL
	,Activo BIT NOT NULL
	,UpSellingId INT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModicacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

ALTER TABLE UpSellingDetalle ADD CONSTRAINT FK_UpSellingDetalle FOREIGN KEY (UpSellingId) REFERENCES UpSelling (UpSellingId);

GO

