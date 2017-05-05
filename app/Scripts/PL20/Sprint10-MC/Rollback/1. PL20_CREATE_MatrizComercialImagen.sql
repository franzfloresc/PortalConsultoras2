USE BelcorpBolivia
GO

IF OBJECT_ID('MatrizComercialImagen', 'P') IS NOT NULL
DROP PROC MatrizComercialImagen
GO

BEGIN
	CREATE TABLE [dbo].[MatrizComercialImagen](
		[IdMatrizComercialImagen] [int] IDENTITY(1,1) NOT NULL,
		[IdMatrizComercial] [int] NOT NULL,
		[Foto] [varchar](150) NULL,
		[UsuarioRegistro] [varchar](50) NULL,
		[FechaRegistro] [datetime] NULL,
		[UsuarioModificacion] [varchar](50) NULL,
		[FechaModificacion] [datetime] NULL,
		FOREIGN KEY (IdMatrizComercial) REFERENCES MatrizComercial(IdMatrizComercial),
	PRIMARY KEY CLUSTERED 
	(
		[IdMatrizComercialImagen] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
	) ON [PRIMARY]

	GO

END
GO
/*end*/

USE BelcorpChile
GO

IF OBJECT_ID('MatrizComercialImagen', 'P') IS NOT NULL
DROP PROC MatrizComercialImagen
GO

BEGIN
	CREATE TABLE [dbo].[MatrizComercialImagen](
		[IdMatrizComercialImagen] [int] IDENTITY(1,1) NOT NULL,
		[IdMatrizComercial] [int] NOT NULL,
		[Foto] [varchar](150) NULL,
		[UsuarioRegistro] [varchar](50) NULL,
		[FechaRegistro] [datetime] NULL,
		[UsuarioModificacion] [varchar](50) NULL,
		[FechaModificacion] [datetime] NULL,
		FOREIGN KEY (IdMatrizComercial) REFERENCES MatrizComercial(IdMatrizComercial),
	PRIMARY KEY CLUSTERED 
	(
		[IdMatrizComercialImagen] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
	) ON [PRIMARY]

	GO
END
GO
/*end*/

USE BelcorpColombia
GO

IF OBJECT_ID('MatrizComercialImagen', 'P') IS NOT NULL
DROP PROC MatrizComercialImagen
GO

BEGIN
	CREATE TABLE [dbo].[MatrizComercialImagen](
		[IdMatrizComercialImagen] [int] IDENTITY(1,1) NOT NULL,
		[IdMatrizComercial] [int] NOT NULL,
		[Foto] [varchar](150) NULL,
		[UsuarioRegistro] [varchar](50) NULL,
		[FechaRegistro] [datetime] NULL,
		[UsuarioModificacion] [varchar](50) NULL,
		[FechaModificacion] [datetime] NULL,
		FOREIGN KEY (IdMatrizComercial) REFERENCES MatrizComercial(IdMatrizComercial),
	PRIMARY KEY CLUSTERED 
	(
		[IdMatrizComercialImagen] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
	) ON [PRIMARY]

	GO
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF OBJECT_ID('MatrizComercialImagen', 'P') IS NOT NULL
DROP PROC MatrizComercialImagen
GO

BEGIN
	CREATE TABLE [dbo].[MatrizComercialImagen](
		[IdMatrizComercialImagen] [int] IDENTITY(1,1) NOT NULL,
		[IdMatrizComercial] [int] NOT NULL,
		[Foto] [varchar](150) NULL,
		[UsuarioRegistro] [varchar](50) NULL,
		[FechaRegistro] [datetime] NULL,
		[UsuarioModificacion] [varchar](50) NULL,
		[FechaModificacion] [datetime] NULL,
		FOREIGN KEY (IdMatrizComercial) REFERENCES MatrizComercial(IdMatrizComercial),
	PRIMARY KEY CLUSTERED 
	(
		[IdMatrizComercialImagen] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
	) ON [PRIMARY]

	GO
END
GO
/*end*/

USE BelcorpDominicana
GO

IF OBJECT_ID('MatrizComercialImagen', 'P') IS NOT NULL
DROP PROC MatrizComercialImagen
GO

BEGIN
	CREATE TABLE [dbo].[MatrizComercialImagen](
		[IdMatrizComercialImagen] [int] IDENTITY(1,1) NOT NULL,
		[IdMatrizComercial] [int] NOT NULL,
		[Foto] [varchar](150) NULL,
		[UsuarioRegistro] [varchar](50) NULL,
		[FechaRegistro] [datetime] NULL,
		[UsuarioModificacion] [varchar](50) NULL,
		[FechaModificacion] [datetime] NULL,
		FOREIGN KEY (IdMatrizComercial) REFERENCES MatrizComercial(IdMatrizComercial),
	PRIMARY KEY CLUSTERED 
	(
		[IdMatrizComercialImagen] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
	) ON [PRIMARY]

	GO
END
GO
/*end*/

USE BelcorpEcuador
GO

IF OBJECT_ID('MatrizComercialImagen', 'P') IS NOT NULL
DROP PROC MatrizComercialImagen
GO

BEGIN
	CREATE TABLE [dbo].[MatrizComercialImagen](
		[IdMatrizComercialImagen] [int] IDENTITY(1,1) NOT NULL,
		[IdMatrizComercial] [int] NOT NULL,
		[Foto] [varchar](150) NULL,
		[UsuarioRegistro] [varchar](50) NULL,
		[FechaRegistro] [datetime] NULL,
		[UsuarioModificacion] [varchar](50) NULL,
		[FechaModificacion] [datetime] NULL,
		FOREIGN KEY (IdMatrizComercial) REFERENCES MatrizComercial(IdMatrizComercial),
	PRIMARY KEY CLUSTERED 
	(
		[IdMatrizComercialImagen] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
	) ON [PRIMARY]

	GO
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF OBJECT_ID('MatrizComercialImagen', 'P') IS NOT NULL
DROP PROC MatrizComercialImagen
GO

BEGIN
	CREATE TABLE [dbo].[MatrizComercialImagen](
		[IdMatrizComercialImagen] [int] IDENTITY(1,1) NOT NULL,
		[IdMatrizComercial] [int] NOT NULL,
		[Foto] [varchar](150) NULL,
		[UsuarioRegistro] [varchar](50) NULL,
		[FechaRegistro] [datetime] NULL,
		[UsuarioModificacion] [varchar](50) NULL,
		[FechaModificacion] [datetime] NULL,
		FOREIGN KEY (IdMatrizComercial) REFERENCES MatrizComercial(IdMatrizComercial),
	PRIMARY KEY CLUSTERED 
	(
		[IdMatrizComercialImagen] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
	) ON [PRIMARY]

	GO
END
GO
/*end*/

USE BelcorpMexico
GO

IF OBJECT_ID('MatrizComercialImagen', 'P') IS NOT NULL
DROP PROC MatrizComercialImagen
GO

BEGIN
	CREATE TABLE [dbo].[MatrizComercialImagen](
		[IdMatrizComercialImagen] [int] IDENTITY(1,1) NOT NULL,
		[IdMatrizComercial] [int] NOT NULL,
		[Foto] [varchar](150) NULL,
		[UsuarioRegistro] [varchar](50) NULL,
		[FechaRegistro] [datetime] NULL,
		[UsuarioModificacion] [varchar](50) NULL,
		[FechaModificacion] [datetime] NULL,
		FOREIGN KEY (IdMatrizComercial) REFERENCES MatrizComercial(IdMatrizComercial),
	PRIMARY KEY CLUSTERED 
	(
		[IdMatrizComercialImagen] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
	) ON [PRIMARY]

	GO
END
GO
/*end*/

USE BelcorpPanama
GO

IF OBJECT_ID('MatrizComercialImagen', 'P') IS NOT NULL
DROP PROC MatrizComercialImagen
GO

BEGIN
	CREATE TABLE [dbo].[MatrizComercialImagen](
		[IdMatrizComercialImagen] [int] IDENTITY(1,1) NOT NULL,
		[IdMatrizComercial] [int] NOT NULL,
		[Foto] [varchar](150) NULL,
		[UsuarioRegistro] [varchar](50) NULL,
		[FechaRegistro] [datetime] NULL,
		[UsuarioModificacion] [varchar](50) NULL,
		[FechaModificacion] [datetime] NULL,
		FOREIGN KEY (IdMatrizComercial) REFERENCES MatrizComercial(IdMatrizComercial),
	PRIMARY KEY CLUSTERED 
	(
		[IdMatrizComercialImagen] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
	) ON [PRIMARY]

	GO
END
GO
/*end*/

USE BelcorpPeru
GO

IF OBJECT_ID('MatrizComercialImagen', 'P') IS NOT NULL
DROP PROC MatrizComercialImagen
GO

BEGIN
	CREATE TABLE [dbo].[MatrizComercialImagen](
		[IdMatrizComercialImagen] [int] IDENTITY(1,1) NOT NULL,
		[IdMatrizComercial] [int] NOT NULL,
		[Foto] [varchar](150) NULL,
		[UsuarioRegistro] [varchar](50) NULL,
		[FechaRegistro] [datetime] NULL,
		[UsuarioModificacion] [varchar](50) NULL,
		[FechaModificacion] [datetime] NULL,
		FOREIGN KEY (IdMatrizComercial) REFERENCES MatrizComercial(IdMatrizComercial),
	PRIMARY KEY CLUSTERED 
	(
		[IdMatrizComercialImagen] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
	) ON [PRIMARY]

	GO
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF OBJECT_ID('MatrizComercialImagen', 'P') IS NOT NULL
DROP PROC MatrizComercialImagen
GO

BEGIN
	CREATE TABLE [dbo].[MatrizComercialImagen](
		[IdMatrizComercialImagen] [int] IDENTITY(1,1) NOT NULL,
		[IdMatrizComercial] [int] NOT NULL,
		[Foto] [varchar](150) NULL,
		[UsuarioRegistro] [varchar](50) NULL,
		[FechaRegistro] [datetime] NULL,
		[UsuarioModificacion] [varchar](50) NULL,
		[FechaModificacion] [datetime] NULL,
		FOREIGN KEY (IdMatrizComercial) REFERENCES MatrizComercial(IdMatrizComercial),
	PRIMARY KEY CLUSTERED 
	(
		[IdMatrizComercialImagen] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
	) ON [PRIMARY]

	GO
END
GO
/*end*/

USE BelcorpSalvador
GO

IF OBJECT_ID('MatrizComercialImagen', 'P') IS NOT NULL
DROP PROC MatrizComercialImagen
GO

BEGIN
	CREATE TABLE [dbo].[MatrizComercialImagen](
		[IdMatrizComercialImagen] [int] IDENTITY(1,1) NOT NULL,
		[IdMatrizComercial] [int] NOT NULL,
		[Foto] [varchar](150) NULL,
		[UsuarioRegistro] [varchar](50) NULL,
		[FechaRegistro] [datetime] NULL,
		[UsuarioModificacion] [varchar](50) NULL,
		[FechaModificacion] [datetime] NULL,
		FOREIGN KEY (IdMatrizComercial) REFERENCES MatrizComercial(IdMatrizComercial),
	PRIMARY KEY CLUSTERED 
	(
		[IdMatrizComercialImagen] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
	) ON [PRIMARY]

	GO
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF OBJECT_ID('MatrizComercialImagen', 'P') IS NOT NULL
DROP PROC MatrizComercialImagen
GO

BEGIN
	CREATE TABLE [dbo].[MatrizComercialImagen](
		[IdMatrizComercialImagen] [int] IDENTITY(1,1) NOT NULL,
		[IdMatrizComercial] [int] NOT NULL,
		[Foto] [varchar](150) NULL,
		[UsuarioRegistro] [varchar](50) NULL,
		[FechaRegistro] [datetime] NULL,
		[UsuarioModificacion] [varchar](50) NULL,
		[FechaModificacion] [datetime] NULL,
		FOREIGN KEY (IdMatrizComercial) REFERENCES MatrizComercial(IdMatrizComercial),
	PRIMARY KEY CLUSTERED 
	(
		[IdMatrizComercialImagen] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
	) ON [PRIMARY]

	GO
END
GO






