USE BelcorpPeru
GO

IF OBJECT_ID('dbo.UsuarioExternoPais') IS NOT NULL
	DROP TABLE dbo.UsuarioExternoPais
GO
CREATE TABLE dbo.UsuarioExternoPais(
	Proveedor varchar(20) not null,
	IdAplicacion varchar(50) not null,
	PaisID tinyint not null,
	CodigoISO varchar(2) not null
	CONSTRAINT PK_UsuarioExternoPais PRIMARY KEY CLUSTERED 
	(
		Proveedor asc,
		IdAplicacion asc
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY];
GO