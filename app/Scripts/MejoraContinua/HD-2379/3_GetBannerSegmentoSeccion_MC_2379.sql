USE BelcorpPeru
GO

ALTER procedure [dbo].[GetBannerSegmentoSeccion]
	@CampaniaId int,
	@BannerId int,
	@PaisId int
AS

SELECT	ISNULL(Segmento,-1) as Segmento,
		ISNULL(ConfiguracionZona,'') as ConfiguracionZona,
		ISNULL(SegmentoInterno, '') as SegmentoInterno,
		ISNULL(TipoAcceso, -1) as TipoAcceso
FROM	BannerPaisSegmentoZona with(nolock)
WHERE	CampaniaId = @CampaniaId and
		BannerId = @BannerId and
		PaisId = @PaisId
GO