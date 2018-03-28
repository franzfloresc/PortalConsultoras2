IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE type = 'U'
			AND name = 'Upselling_Marca_Categoria'
		)
BEGIN
	DROP TABLE [dbo].[Upselling_Marca_Categoria]
END
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
	,TextoMetaPrincipal VARCHAR(250) NOT NULL
	,TextoInferior VARCHAR(250) NOT NULL
	,TextoGanastePrincipal VARCHAR(250) NOT NULL
	,TextoGanasteBoton VARCHAR(250) NOT NULL
	,TextoGanastePremio VARCHAR(250) NOT NULL
	,ImagenFondoPrincipalDesktop VARCHAR(250) NOT NULL
	,ImagenFondoPrincipalMobile VARCHAR(250) NOT NULL
	,ImagenFondoGanasteMobile VARCHAR(250) NOT NULL
	,CategoriaApoyada bit DEFAULT 0
	,CategoriaMonto bit DEFAULT 0
	,Activo BIT NOT NULL
	,UsuarioCreacion VARCHAR(150) NOT NULL
	,FechaCreacion DATETIME NOT NULL
	,UsuarioModificacion VARCHAR(150) NULL
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
	,UsuarioModificacion VARCHAR(150) NULL
	,FechaModificacion DATETIME NULL
	)

ALTER TABLE UpSellingDetalle ADD CONSTRAINT FK_UpSellingDetalle FOREIGN KEY (UpSellingId) REFERENCES UpSelling (UpSellingId);
