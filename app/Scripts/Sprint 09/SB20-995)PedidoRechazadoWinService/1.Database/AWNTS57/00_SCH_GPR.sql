USE BelcorpBolivia
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
/*end*/

USE BelcorpChile
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
/*end*/

USE BelcorpDominicana
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
/*end*/

USE BelcorpEcuador
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
/*end*/

USE BelcorpPanama
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
/*end*/

USE BelcorpSalvador
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
/*end*/

USE BelcorpVenezuela
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO