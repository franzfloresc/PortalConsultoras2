USE BelcorpPeru
GO

IF EXISTS ( select * from sysobjects where name='df_contrato_deviceID')
alter table contrato  drop constraint df_contrato_deviceID
go
IF EXISTS ( select * from sysobjects where name='df_contrato_IMEI')
alter table contrato  drop constraint df_contrato_IMEI
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
	alter table contrato drop column [IMEI]
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID') =0
	alter table contrato drop column [DeviceID]
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO

USE BelcorpMexico
GO

IF EXISTS ( select * from sysobjects where name='df_contrato_deviceID')
alter table contrato  drop constraint df_contrato_deviceID
go
IF EXISTS ( select * from sysobjects where name='df_contrato_IMEI')
alter table contrato  drop constraint df_contrato_IMEI
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
	alter table contrato drop column [IMEI]
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID') =0
	alter table contrato drop column [DeviceID]
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO

USE BelcorpColombia
GO

IF EXISTS ( select * from sysobjects where name='df_contrato_deviceID')
alter table contrato  drop constraint df_contrato_deviceID
go
IF EXISTS ( select * from sysobjects where name='df_contrato_IMEI')
alter table contrato  drop constraint df_contrato_IMEI
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
	alter table contrato drop column [IMEI]
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID') =0
	alter table contrato drop column [DeviceID]
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO

USE BelcorpSalvador
GO

IF EXISTS ( select * from sysobjects where name='df_contrato_deviceID')
alter table contrato  drop constraint df_contrato_deviceID
go
IF EXISTS ( select * from sysobjects where name='df_contrato_IMEI')
alter table contrato  drop constraint df_contrato_IMEI
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
	alter table contrato drop column [IMEI]
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID') =0
	alter table contrato drop column [DeviceID]
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO

USE BelcorpPuertoRico
GO

IF EXISTS ( select * from sysobjects where name='df_contrato_deviceID')
alter table contrato  drop constraint df_contrato_deviceID
go
IF EXISTS ( select * from sysobjects where name='df_contrato_IMEI')
alter table contrato  drop constraint df_contrato_IMEI
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
	alter table contrato drop column [IMEI]
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID') =0
	alter table contrato drop column [DeviceID]
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO

USE BelcorpPanama
GO

IF EXISTS ( select * from sysobjects where name='df_contrato_deviceID')
alter table contrato  drop constraint df_contrato_deviceID
go
IF EXISTS ( select * from sysobjects where name='df_contrato_IMEI')
alter table contrato  drop constraint df_contrato_IMEI
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
	alter table contrato drop column [IMEI]
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID') =0
	alter table contrato drop column [DeviceID]
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO

USE BelcorpGuatemala
GO

IF EXISTS ( select * from sysobjects where name='df_contrato_deviceID')
alter table contrato  drop constraint df_contrato_deviceID
go
IF EXISTS ( select * from sysobjects where name='df_contrato_IMEI')
alter table contrato  drop constraint df_contrato_IMEI
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
	alter table contrato drop column [IMEI]
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID') =0
	alter table contrato drop column [DeviceID]
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO

USE BelcorpEcuador
GO

IF EXISTS ( select * from sysobjects where name='df_contrato_deviceID')
alter table contrato  drop constraint df_contrato_deviceID
go
IF EXISTS ( select * from sysobjects where name='df_contrato_IMEI')
alter table contrato  drop constraint df_contrato_IMEI
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
	alter table contrato drop column [IMEI]
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID') =0
	alter table contrato drop column [DeviceID]
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO

USE BelcorpDominicana
GO

IF EXISTS ( select * from sysobjects where name='df_contrato_deviceID')
alter table contrato  drop constraint df_contrato_deviceID
go
IF EXISTS ( select * from sysobjects where name='df_contrato_IMEI')
alter table contrato  drop constraint df_contrato_IMEI
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
	alter table contrato drop column [IMEI]
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID') =0
	alter table contrato drop column [DeviceID]
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO

USE BelcorpCostaRica
GO

IF EXISTS ( select * from sysobjects where name='df_contrato_deviceID')
alter table contrato  drop constraint df_contrato_deviceID
go
IF EXISTS ( select * from sysobjects where name='df_contrato_IMEI')
alter table contrato  drop constraint df_contrato_IMEI
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
	alter table contrato drop column [IMEI]
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID') =0
	alter table contrato drop column [DeviceID]
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO

USE BelcorpChile
GO

IF EXISTS ( select * from sysobjects where name='df_contrato_deviceID')
alter table contrato  drop constraint df_contrato_deviceID
go
IF EXISTS ( select * from sysobjects where name='df_contrato_IMEI')
alter table contrato  drop constraint df_contrato_IMEI
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
	alter table contrato drop column [IMEI]
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID') =0
	alter table contrato drop column [DeviceID]
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO

USE BelcorpBolivia
GO

IF EXISTS ( select * from sysobjects where name='df_contrato_deviceID')
alter table contrato  drop constraint df_contrato_deviceID
go
IF EXISTS ( select * from sysobjects where name='df_contrato_IMEI')
alter table contrato  drop constraint df_contrato_IMEI
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
	alter table contrato drop column [IMEI]
go
IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID') =0
	alter table contrato drop column [DeviceID]
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO

