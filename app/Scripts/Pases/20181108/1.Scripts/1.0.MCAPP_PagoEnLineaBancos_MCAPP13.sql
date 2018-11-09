USE BelcorpPeru
GO

IF COL_LENGTH('PagoEnLineaBancos', 'URIExternalApp') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaBancos 
	ADD URIExternalApp VARCHAR(200) NULL;
END
GO

USE BelcorpMexico
GO

IF COL_LENGTH('PagoEnLineaBancos', 'URIExternalApp') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaBancos 
	ADD URIExternalApp VARCHAR(200) NULL;
END
GO

USE BelcorpColombia
GO

IF COL_LENGTH('PagoEnLineaBancos', 'URIExternalApp') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaBancos 
	ADD URIExternalApp VARCHAR(200) NULL;
END
GO

USE BelcorpSalvador
GO

IF COL_LENGTH('PagoEnLineaBancos', 'URIExternalApp') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaBancos 
	ADD URIExternalApp VARCHAR(200) NULL;
END
GO

USE BelcorpPuertoRico
GO

IF COL_LENGTH('PagoEnLineaBancos', 'URIExternalApp') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaBancos 
	ADD URIExternalApp VARCHAR(200) NULL;
END
GO

USE BelcorpPanama
GO

IF COL_LENGTH('PagoEnLineaBancos', 'URIExternalApp') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaBancos 
	ADD URIExternalApp VARCHAR(200) NULL;
END
GO

USE BelcorpGuatemala
GO

IF COL_LENGTH('PagoEnLineaBancos', 'URIExternalApp') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaBancos 
	ADD URIExternalApp VARCHAR(200) NULL;
END
GO

USE BelcorpEcuador
GO

IF COL_LENGTH('PagoEnLineaBancos', 'URIExternalApp') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaBancos 
	ADD URIExternalApp VARCHAR(200) NULL;
END
GO

USE BelcorpDominicana
GO

IF COL_LENGTH('PagoEnLineaBancos', 'URIExternalApp') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaBancos 
	ADD URIExternalApp VARCHAR(200) NULL;
END
GO

USE BelcorpCostaRica
GO

IF COL_LENGTH('PagoEnLineaBancos', 'URIExternalApp') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaBancos 
	ADD URIExternalApp VARCHAR(200) NULL;
END
GO

USE BelcorpChile
GO

IF COL_LENGTH('PagoEnLineaBancos', 'URIExternalApp') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaBancos 
	ADD URIExternalApp VARCHAR(200) NULL;
END
GO

USE BelcorpBolivia
GO

IF COL_LENGTH('PagoEnLineaBancos', 'URIExternalApp') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaBancos 
	ADD URIExternalApp VARCHAR(200) NULL;
END
GO

