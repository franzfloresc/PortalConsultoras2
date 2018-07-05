USE BelcorpPeru;
GO

IF COL_LENGTH('dbo.BannerPaisSegmentoZona', 'CodigosConsultora') IS NOT NULL
BEGIN
 ALTER TABLE dbo.BannerPaisSegmentoZona DROP COLUMN CodigosConsultora, TipoAcceso;
END

GO