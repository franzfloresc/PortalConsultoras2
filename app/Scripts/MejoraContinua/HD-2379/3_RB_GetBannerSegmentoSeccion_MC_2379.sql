USE [BelcorpPeru]
GO

ALTER procedure [dbo].[GetBannerSegmentoSeccion]
	@CampaniaId int,
	@BannerId int,
	@PaisId int
as

select	ISNULL(Segmento,-1) as Segmento,ISNULL(ConfiguracionZona,'') as ConfiguracionZona,
		ISNULL(SegmentoInterno, '') as SegmentoInterno
from	BannerPaisSegmentoZona with(nolock)
where	CampaniaId = @CampaniaId and
		BannerId = @BannerId and
		PaisId = @PaisId
