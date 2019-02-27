USE BelcorpPeru
GO

DELETE [PagoEnLineaTipoPasarela] WHERE [CodigoPlataforma] = 'A' AND [Codigo] IN ('16', '17', '18');
GO

INSERT [PagoEnLineaTipoPasarela] ([CodigoPlataforma] ,[Codigo] ,[Descripcion] ,[Valor])
VALUES ('A','16','Codigo de comercio App', '515776502');
GO

INSERT [PagoEnLineaTipoPasarela] ([CodigoPlataforma] ,[Codigo] ,[Descripcion] ,[Valor])
VALUES ('A','17','AccessKey Id App', 'AKIAISPFEE2QMRPG3UUQ');
GO

INSERT [PagoEnLineaTipoPasarela] ([CodigoPlataforma] ,[Codigo] ,[Descripcion] ,[Valor])
VALUES ('A','18','SecretAccessKey App', 'RYg0dX9U1OP06Q+lnzMwxPcZYFGCCGymNTDC9tek');
GO

