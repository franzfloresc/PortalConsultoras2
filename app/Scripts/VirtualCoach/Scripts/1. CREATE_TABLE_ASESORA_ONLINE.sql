USE BelcorpChile
GO

CREATE TABLE [dbo].[AsesoraOnline](
	IdAsesoraOnline int IDENTITY(1,1) NOT NULL,
	CodigoConsultora varchar(10) NULL,
	TipsGestionClientes int NULL,
	TipsMasClientes int NULL,
	TipsVentas int NULL,
	MasCatalogos int NULL,
	FechaCreacion datetime NULL,
	Origen varchar(100) NULL,
PRIMARY KEY CLUSTERED 
(
	IdAsesoraOnline ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO