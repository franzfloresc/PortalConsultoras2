﻿GO
USE BelcorpPeru
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END

GO
USE BelcorpMexico
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END

GO
USE BelcorpColombia
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END

GO
USE BelcorpSalvador
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END

GO
USE BelcorpPuertoRico
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END

GO
USE BelcorpPanama
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END

GO
USE BelcorpGuatemala
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END

GO
USE BelcorpEcuador
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END

GO
USE BelcorpDominicana
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END

GO
USE BelcorpCostaRica
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END

GO
USE BelcorpChile
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END

GO
USE BelcorpBolivia
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END

GO