USE BelcorpPeru;
GO

IF COL_LENGTH('dbo.BannerPaisSegmentoZona', 'CodigosConsultora') IS NULL
BEGIN
 ALTER TABLE dbo.BannerPaisSegmentoZona ADD CodigosConsultora VARCHAR(MAX), TipoAcceso SMALLINT;
END

GO