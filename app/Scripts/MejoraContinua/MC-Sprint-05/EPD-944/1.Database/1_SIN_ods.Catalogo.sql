USE BelcorpBolivia
GO
IF OBJECT_ID('ods.Catalogo') IS NULL
BEGIN
	CREATE SYNONYM ods.Catalogo
	FOR ODS_BO.dbo.Catalogo;
END
GO
/*end*/

USE BelcorpChile
GO
IF OBJECT_ID('ods.Catalogo') IS NULL
BEGIN
	CREATE SYNONYM ods.Catalogo
	FOR ODS_CL.dbo.Catalogo;
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF OBJECT_ID('ods.Catalogo') IS NULL
BEGIN
	CREATE SYNONYM ods.Catalogo
	FOR ODS_CR.dbo.Catalogo;
END
GO
/*end*/

USE BelcorpDominicana
GO
IF OBJECT_ID('ods.Catalogo') IS NULL
BEGIN
	CREATE SYNONYM ods.Catalogo
	FOR ODS_DO.dbo.Catalogo;
END
GO
/*end*/

USE BelcorpEcuador
GO
IF OBJECT_ID('ods.Catalogo') IS NULL
BEGIN
	CREATE SYNONYM ods.Catalogo
	FOR ODS_EC.dbo.Catalogo;
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF OBJECT_ID('ods.Catalogo') IS NULL
BEGIN
	CREATE SYNONYM ods.Catalogo
	FOR ODS_GT.dbo.Catalogo;
END
GO
/*end*/

USE BelcorpPanama
GO
IF OBJECT_ID('ods.Catalogo') IS NULL
BEGIN
	CREATE SYNONYM ods.Catalogo
	FOR ODS_PA.dbo.Catalogo;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF OBJECT_ID('ods.Catalogo') IS NULL
BEGIN
	CREATE SYNONYM ods.Catalogo
	FOR ODS_PR.dbo.Catalogo;
END
GO
/*end*/

USE BelcorpSalvador
GO
IF OBJECT_ID('ods.Catalogo') IS NULL
BEGIN
	CREATE SYNONYM ods.Catalogo
	FOR ODS_SA.dbo.Catalogo;
END
GO
/*end*/

USE BelcorpVenezuela
GO
IF OBJECT_ID('ods.Catalogo') IS NULL
BEGIN
	CREATE SYNONYM ods.Catalogo
	FOR ODS_VE.dbo.Catalogo;
END
GO
/*end*/

USE BelcorpColombia
GO
IF OBJECT_ID('ods.Catalogo') IS NULL
BEGIN
	CREATE SYNONYM ods.Catalogo
	FOR ODS_CO.dbo.Catalogo;
END
GO
/*end*/

USE BelcorpMexico
GO
IF OBJECT_ID('ods.Catalogo') IS NULL
BEGIN
	CREATE SYNONYM ods.Catalogo
	FOR ODS_MX.dbo.Catalogo;
END
GO
/*end*/

USE BelcorpPeru
GO
IF OBJECT_ID('ods.Catalogo') IS NULL
BEGIN
	CREATE SYNONYM ods.Catalogo
	FOR ODS_PE.dbo.Catalogo;
END
GO