GO
IF TYPE_ID('OfertaFICType') IS NULL
BEGIN
	CREATE TYPE OfertaFICType AS TABLE(
		[CampaniaID] [int] NULL,
		[CUV] [varchar](20) NULL,
		[ImagenUrl] [varchar](500) NULL,
		[PaisISO] [varchar](20) NULL,
		[UsuarioRegistro] [varchar](50) NULL,
		[NombreImagen] [varchar](500) NULL
	);
END
GO