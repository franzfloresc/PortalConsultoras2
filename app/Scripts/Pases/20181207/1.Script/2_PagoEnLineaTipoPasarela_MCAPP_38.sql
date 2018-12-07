USE BelcorpPeru
GO

/* Actualizacion de PagoEnLineaTipoPasarela */
DELETE PagoEnLineaTipoPasarela WHERE [CodigoPlataforma] = 'A' AND [Codigo] = '14'
GO
INSERT PagoEnLineaTipoPasarela ([CodigoPlataforma],[Codigo],[Descripcion],[Valor])
VALUES ('A','14','URL Autorizacion Pagos App','https://devapi.vnforapps.com/api.tokenization/api/v2')
GO

DELETE PagoEnLineaTipoPasarela WHERE [CodigoPlataforma] = 'A' AND [Codigo] = '15'
GO
INSERT PagoEnLineaTipoPasarela ([CodigoPlataforma],[Codigo],[Descripcion],[Valor])
VALUES ('A','15','URL Terminos de Uso App','https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/FileConsultoras/PE/CONDICIONES_DE_USO_WEB_PE.pdf')
GO

USE BelcorpMexico
GO

/* Actualizacion de PagoEnLineaTipoPasarela */
DELETE PagoEnLineaTipoPasarela WHERE [CodigoPlataforma] = 'B' AND [Codigo] = '07'
GO
INSERT PagoEnLineaTipoPasarela ([CodigoPlataforma],[Codigo],[Descripcion],[Valor])
VALUES ('B','07','% Gastos Administrativos','2.4')
GO


DELETE PagoEnLineaTipoPasarela WHERE [CodigoPlataforma] = 'B' AND [Codigo] = '08'
GO
INSERT PagoEnLineaTipoPasarela ([CodigoPlataforma],[Codigo],[Descripcion],[Valor])
VALUES ('B','08','Monto Mínimo de Pago','1.5')
GO
