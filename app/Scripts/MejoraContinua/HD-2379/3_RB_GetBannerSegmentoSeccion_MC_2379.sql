USE [BelcorpPeru]
GO
/****** Object:  StoredProcedure [dbo].[GetBannerSegmentoSeccion]    Script Date: 23/05/2018 12:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
