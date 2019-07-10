USE [BelcorpBolivia];
GO
IF COL_LENGTH('dbo.SolicitudCliente', 'IDCDC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCDC varchar(100) NULL

IF COL_LENGTH('dbo.SolicitudCliente', 'IDCMC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCMC varchar(200) NULL

GO
USE [BelcorpChile];
GO
IF COL_LENGTH('dbo.SolicitudCliente', 'IDCDC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCDC varchar(100) NULL

IF COL_LENGTH('dbo.SolicitudCliente', 'IDCMC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCMC varchar(200) NULL

GO
USE [BelcorpColombia];
GO
IF COL_LENGTH('dbo.SolicitudCliente', 'IDCDC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCDC varchar(100) NULL

IF COL_LENGTH('dbo.SolicitudCliente', 'IDCMC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCMC varchar(200) NULL

GO
USE [BelcorpCostaRica];
GO
IF COL_LENGTH('dbo.SolicitudCliente', 'IDCDC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCDC varchar(100) NULL

IF COL_LENGTH('dbo.SolicitudCliente', 'IDCMC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCMC varchar(200) NULL

GO
USE [BelcorpDominicana];
GO
IF COL_LENGTH('dbo.SolicitudCliente', 'IDCDC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCDC varchar(100) NULL

IF COL_LENGTH('dbo.SolicitudCliente', 'IDCMC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCMC varchar(200) NULL

GO
USE [BelcorpEcuador];
GO
IF COL_LENGTH('dbo.SolicitudCliente', 'IDCDC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCDC varchar(100) NULL

IF COL_LENGTH('dbo.SolicitudCliente', 'IDCMC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCMC varchar(200) NULL

GO
USE [BelcorpGuatemala];
GO
IF COL_LENGTH('dbo.SolicitudCliente', 'IDCDC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCDC varchar(100) NULL

IF COL_LENGTH('dbo.SolicitudCliente', 'IDCMC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCMC varchar(200) NULL

GO
USE [BelcorpMexico];
GO
IF COL_LENGTH('dbo.SolicitudCliente', 'IDCDC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCDC varchar(100) NULL

IF COL_LENGTH('dbo.SolicitudCliente', 'IDCMC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCMC varchar(200) NULL

GO
USE [BelcorpPanama];
GO
IF COL_LENGTH('dbo.SolicitudCliente', 'IDCDC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCDC varchar(100) NULL

IF COL_LENGTH('dbo.SolicitudCliente', 'IDCMC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCMC varchar(200) NULL

GO
USE [BelcorpPeru];
GO
IF COL_LENGTH('dbo.SolicitudCliente', 'IDCDC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCDC varchar(100) NULL

IF COL_LENGTH('dbo.SolicitudCliente', 'IDCMC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCMC varchar(200) NULL

GO
USE [BelcorpPuertoRico];
GO
IF COL_LENGTH('dbo.SolicitudCliente', 'IDCDC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCDC varchar(100) NULL

IF COL_LENGTH('dbo.SolicitudCliente', 'IDCMC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCMC varchar(200) NULL

GO
USE [BelcorpSalvador];
GO
IF COL_LENGTH('dbo.SolicitudCliente', 'IDCDC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCDC varchar(100) NULL

IF COL_LENGTH('dbo.SolicitudCliente', 'IDCMC') IS NULL
	ALTER TABLE SolicitudCliente ADD IDCMC varchar(200) NULL

GO
