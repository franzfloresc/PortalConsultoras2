USE BelcorpPeru
GO

/* Actualizacion de PagoEnLineaTipoPasarela */
DELETE PagoEnLineaTipoPasarela WHERE [CodigoPlataforma] = 'A' AND [Codigo] = '14'
GO

DELETE PagoEnLineaTipoPasarela WHERE [CodigoPlataforma] = 'A' AND [Codigo] = '15'
GO

USE BelcorpMexico
GO

/* Actualizacion de PagoEnLineaTipoPasarela */
DELETE PagoEnLineaTipoPasarela WHERE [CodigoPlataforma] = 'B' AND [Codigo] = '07'
GO

DELETE PagoEnLineaTipoPasarela WHERE [CodigoPlataforma] = 'B' AND [Codigo] = '08'
GO
