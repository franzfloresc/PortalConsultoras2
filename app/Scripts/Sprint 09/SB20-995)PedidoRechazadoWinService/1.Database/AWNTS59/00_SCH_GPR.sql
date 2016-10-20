USE BelcorpColombia
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
/*end*/

USE BelcorpMexico
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
/*end*/

USE BelcorpPeru
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO