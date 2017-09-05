USE BelcorpChile
GO
IF OBJECT_ID('dbo.AsesoraOnline') IS NOT NULL
	DROP TABLE dbo.AsesoraOnline
GO
CREATE TABLE dbo.AsesoraOnline(
	IdAsesoraOnline int IDENTITY(1,1) NOT NULL,
	CodigoConsultora varchar(10) NULL,
	ConfirmacionInscripcion int NULL,
	Respuesta1 int NULL,
	Respuesta2 int NULL,
	Respuesta3 int NULL,
	Respuesta4 int NULL,
	Respuesta5 int NULL,
	FechaCreacion datetime NULL,
	Origen varchar(100) NULL,
PRIMARY KEY CLUSTERED 
(
	IdAsesoraOnline ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO