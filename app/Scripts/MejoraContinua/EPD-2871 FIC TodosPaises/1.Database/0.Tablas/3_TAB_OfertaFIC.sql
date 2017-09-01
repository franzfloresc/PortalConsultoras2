GO
IF OBJECT_ID('OfertaFIC') IS NULL
BEGIN
	CREATE TABLE OfertaFIC(
		[CampaniaID] [int] NOT NULL,
		[CUV] [varchar](20) NOT NULL,
		[ImagenUrl] [varchar](500) NOT NULL,
		[PaisISO] [varchar](20) NOT NULL,
		[UsuarioRegistro] [varchar](50) NOT NULL,
		[NombreImagen] [varchar](500) NOT NULL,
		CONSTRAINT [PK_CuvAutomatico_OfertaFIC] PRIMARY KEY CLUSTERED 
		(
			[CampaniaID] ASC,
			[CUV] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY];
END
GO