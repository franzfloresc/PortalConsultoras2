USE BelcorpPeru
GO

DELETE [PagoEnLineaTipoPasarela] WHERE [CodigoPlataforma] = 'A' AND [Codigo] IN ('16', '17', '18');
GO

