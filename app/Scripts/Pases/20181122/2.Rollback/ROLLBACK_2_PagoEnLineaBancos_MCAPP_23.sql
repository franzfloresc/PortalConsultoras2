USE BelcorpPeru
GO

/* Actualizacion de URIApp  Bancos */
UPDATE [PagoEnLineaBancos] SET URIExternalApp = NULL WHERE [Id] = 1; 	--Interbank
UPDATE [PagoEnLineaBancos] SET URIExternalApp = NULL WHERE [Id] = 2; 	--Scotiabank
UPDATE [PagoEnLineaBancos] SET URIExternalApp = NULL WHERE [Id] = 3; 	--Continental
UPDATE [PagoEnLineaBancos] SET URIExternalApp = NULL WHERE [Id] = 4; 	--BCP
UPDATE [PagoEnLineaBancos] SET URIExternalApp = NULL WHERE [Id] = 5; 	--Banco de la Nación
UPDATE [PagoEnLineaBancos] SET URIExternalApp = NULL WHERE [Id] = 6; 	--Wester Unión
UPDATE [PagoEnLineaBancos] SET URIExternalApp = NULL WHERE [Id] = 7; 	--Pichincha

GO