USE [BelcorpPeru]  
GO
IF EXISTS (SELECT * FROM sys.synonyms WHERE  name = 'escaladescuentoZona') 
	DROP SYNONYM ods.escaladescuentoZona 
GO
CREATE SYNONYM ods.escaladescuentoZona FOR ODS_PE.dbo.escaladescuentoZona;


USE [BelcorpBolivia]
GO
IF EXISTS (SELECT * FROM sys.synonyms WHERE  name = 'escaladescuentoZona') 
	DROP SYNONYM ods.escaladescuentoZona 
GO
CREATE SYNONYM ods.escaladescuentoZona FOR ODS_BO.dbo.escaladescuentoZona;


USE [BelcorpChile]
GO
IF EXISTS (SELECT * FROM sys.synonyms WHERE  name = 'escaladescuentoZona') 
	DROP SYNONYM ods.escaladescuentoZona 
GO
CREATE SYNONYM ods.escaladescuentoZona FOR ODS_CL.dbo.escaladescuentoZona;


USE [BelcorpColombia]
GO
IF EXISTS (SELECT * FROM sys.synonyms WHERE  name = 'escaladescuentoZona') 
	DROP SYNONYM ods.escaladescuentoZona 
GO
CREATE SYNONYM ods.escaladescuentoZona FOR ODS_CO.dbo.escaladescuentoZona;


USE [BelcorpCostaRica]
GO
IF EXISTS (SELECT * FROM sys.synonyms WHERE  name = 'escaladescuentoZona') 
	DROP SYNONYM ods.escaladescuentoZona 
GO
CREATE SYNONYM ods.escaladescuentoZona FOR ODS_CR.dbo.escaladescuentoZona;


USE [BelcorpDominicana]
GO
IF EXISTS (SELECT * FROM sys.synonyms WHERE  name = 'escaladescuentoZona') 
	DROP SYNONYM ods.escaladescuentoZona 
GO
CREATE SYNONYM ods.escaladescuentoZona FOR ODS_DO.dbo.escaladescuentoZona;


USE [BelcorpEcuador]
GO
IF EXISTS (SELECT * FROM sys.synonyms WHERE  name = 'escaladescuentoZona') 
	DROP SYNONYM ods.escaladescuentoZona 
GO
CREATE SYNONYM ods.escaladescuentoZona FOR ODS_EC.dbo.escaladescuentoZona;


USE [BelcorpGuatemala]
GO
IF EXISTS (SELECT * FROM sys.synonyms WHERE  name = 'escaladescuentoZona') 
	DROP SYNONYM ods.escaladescuentoZona 
GO
CREATE SYNONYM ods.escaladescuentoZona FOR ODS_GT.dbo.escaladescuentoZona;


USE [BelcorpMexico]
GO
IF EXISTS (SELECT * FROM sys.synonyms WHERE  name = 'escaladescuentoZona') 
	DROP SYNONYM ods.escaladescuentoZona 
GO
CREATE SYNONYM ods.escaladescuentoZona FOR ODS_MX.dbo.escaladescuentoZona;


USE [BelcorpPanama]
GO
IF EXISTS (SELECT * FROM sys.synonyms WHERE  name = 'escaladescuentoZona') 
	DROP SYNONYM ods.escaladescuentoZona 
GO
CREATE SYNONYM ods.escaladescuentoZona FOR ODS_PA.dbo.escaladescuentoZona;


USE [BelcorpPuertoRico]
GO
IF EXISTS (SELECT * FROM sys.synonyms WHERE  name = 'escaladescuentoZona') 
	DROP SYNONYM ods.escaladescuentoZona 
GO
CREATE SYNONYM ods.escaladescuentoZona FOR ODS_PR.dbo.escaladescuentoZona;


USE [BelcorpSalvador]
GO
IF EXISTS (SELECT * FROM sys.synonyms WHERE  name = 'escaladescuentoZona') 
	DROP SYNONYM ods.escaladescuentoZona 
GO
CREATE SYNONYM ods.escaladescuentoZona FOR ODS_SV.dbo.escaladescuentoZona;



