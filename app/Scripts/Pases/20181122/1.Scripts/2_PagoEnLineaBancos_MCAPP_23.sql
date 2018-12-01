USE BelcorpPeru
GO

/* Actualizacion de URIApp  Bancos */
UPDATE [PagoEnLineaBancos] SET URIExternalApp = 'pe.com.interbank.mobilebanking' WHERE [Id] = 1; 			--Interbank
UPDATE [PagoEnLineaBancos] SET URIExternalApp = 'pe.com.scotiabank.blpm.android.client' WHERE [Id] = 2; 	--Scotiabank
UPDATE [PagoEnLineaBancos] SET URIExternalApp = 'com.bbva.nxt_peru' WHERE [Id] = 3; 						--Continental
UPDATE [PagoEnLineaBancos] SET URIExternalApp = 'com.bcp.bank.bcp' WHERE [Id] = 4; 							--BCP
UPDATE [PagoEnLineaBancos] SET URIExternalApp = 'pe.com.bn.app.bancodelanacion' WHERE [Id] = 5; 			--Banco de la Nación
UPDATE [PagoEnLineaBancos] SET URIExternalApp = 'com.westernunion.moneytransferr3app.acs1' WHERE [Id] = 6; 	--Wester Unión
UPDATE [PagoEnLineaBancos] SET URIExternalApp = 'com.yellowpepper.pichincha' WHERE [Id] = 7; 				--Pichincha

GO