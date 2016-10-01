IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'ProductoComercialOfertaRevista')
BEGIN
	CREATE TABLE [dbo].[ProductoComercialOfertaRevista](
		[Campania] [int] NOT NULL,
		[CUV] [varchar](50) NOT NULL,
		[SAP] [varchar](20) NULL,
		[Oferta] [varchar](20) NULL,
	CONSTRAINT [PK_ProductoComercialOfertaRevista] PRIMARY KEY CLUSTERED 
	(
		[Campania] ASC,
		[CUV] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
	)ON [PRIMARY]
END
