USE BelcorpPeru
GO

GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_PE.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_PE.dbo.ProductoExclusivo
END
GO

USE BelcorpMexico
GO

GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_MX.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_MX.dbo.ProductoExclusivo
END
GO

USE BelcorpColombia
GO

GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_CO.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_CO.dbo.ProductoExclusivo
END
GO

USE BelcorpSalvador
GO

GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_SV.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_SV.dbo.ProductoExclusivo
END
GO

USE BelcorpPuertoRico
GO

GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_PR.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_PR.dbo.ProductoExclusivo
END
GO

USE BelcorpPanama
GO

GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_PA.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_PA.dbo.ProductoExclusivo
END
GO

USE BelcorpGuatemala
GO

GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_GT.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_GT.dbo.ProductoExclusivo
END
GO

USE BelcorpEcuador
GO

GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_EC.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_EC.dbo.ProductoExclusivo
END
GO

USE BelcorpDominicana
GO

GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_DO.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_DO.dbo.ProductoExclusivo
END
GO

USE BelcorpCostaRica
GO

GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_CR.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_CR.dbo.ProductoExclusivo
END
GO

USE BelcorpChile
GO

GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_CL.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_CL.dbo.ProductoExclusivo
END
GO

USE BelcorpBolivia
GO

GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_BO.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_BO.dbo.ProductoExclusivo
END
GO

