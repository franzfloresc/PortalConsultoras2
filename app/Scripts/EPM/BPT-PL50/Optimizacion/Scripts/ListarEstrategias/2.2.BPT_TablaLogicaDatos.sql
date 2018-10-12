USE [BelcorpPeru_BPT]
GO

IF EXISTS(SELECT TLD.Codigo FROM [dbo].[TablaLogicaDatos] TLD WHERE TLD.TablaLogicaDatosID = 10002)
BEGIN
	DELETE FROM [dbo].[TablaLogicaDatos] WHERE TablaLogicaDatosID = 10002
END

INSERT INTO [dbo].[TablaLogicaDatos](TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor)
VALUES (10002,100,'YYYYYYYYY','Ofertas forzadas',null);
