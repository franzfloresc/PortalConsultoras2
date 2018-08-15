USE BelcorpPeru
GO
update Banner
set URL = 'https://www.somosbelcorp.com/OfertaLiquidacion/OfertasLiquidacion'
where
	CampaniaID >= 201811 and GrupoBannerID = 152 and
	(Titulo like '%expoferta_PE%' or Titulo like '%expofertas_PE%');
GO