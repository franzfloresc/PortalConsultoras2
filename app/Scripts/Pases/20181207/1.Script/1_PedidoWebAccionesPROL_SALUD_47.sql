USE [BelcorpPeru]
go

IF NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE PedidoWebAccionesPROL ADD CONSTRAINT PK_PedidoWebAccionesPROL PRIMARY KEY (PedidoWebAccionesPROLID);
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	DROP INDEX [IDX_PedidoWebAccionesPROL_CampaniaID] ON [dbo].[PedidoWebAccionesPROL];
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

CREATE NONCLUSTERED INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL] (PedidoID, PedidoDetalleID, ValAutomaticaPROLLogId);   
go

USE [BelcorpMexico]
go

IF NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE PedidoWebAccionesPROL ADD CONSTRAINT PK_PedidoWebAccionesPROL PRIMARY KEY (PedidoWebAccionesPROLID);
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	DROP INDEX [IDX_PedidoWebAccionesPROL_CampaniaID] ON [dbo].[PedidoWebAccionesPROL];
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

CREATE NONCLUSTERED INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL] (PedidoID, PedidoDetalleID, ValAutomaticaPROLLogId);   
go

USE [BelcorpColombia]
go


IF NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE PedidoWebAccionesPROL ADD CONSTRAINT PK_PedidoWebAccionesPROL PRIMARY KEY (PedidoWebAccionesPROLID);
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	DROP INDEX [IDX_PedidoWebAccionesPROL_CampaniaID] ON [dbo].[PedidoWebAccionesPROL];
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

CREATE NONCLUSTERED INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL] (PedidoID, PedidoDetalleID, ValAutomaticaPROLLogId);   
go

USE [BelcorpSalvador]
go


IF NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE PedidoWebAccionesPROL ADD CONSTRAINT PK_PedidoWebAccionesPROL PRIMARY KEY (PedidoWebAccionesPROLID);
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	DROP INDEX [IDX_PedidoWebAccionesPROL_CampaniaID] ON [dbo].[PedidoWebAccionesPROL];
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

CREATE NONCLUSTERED INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL] (PedidoID, PedidoDetalleID, ValAutomaticaPROLLogId);   
go

USE [BelcorpPuertoRico]
go


IF NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE PedidoWebAccionesPROL ADD CONSTRAINT PK_PedidoWebAccionesPROL PRIMARY KEY (PedidoWebAccionesPROLID);
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	DROP INDEX [IDX_PedidoWebAccionesPROL_CampaniaID] ON [dbo].[PedidoWebAccionesPROL];
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

CREATE NONCLUSTERED INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL] (PedidoID, PedidoDetalleID, ValAutomaticaPROLLogId);   
go

USE [BelcorpPanama]
go


IF NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE PedidoWebAccionesPROL ADD CONSTRAINT PK_PedidoWebAccionesPROL PRIMARY KEY (PedidoWebAccionesPROLID);
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	DROP INDEX [IDX_PedidoWebAccionesPROL_CampaniaID] ON [dbo].[PedidoWebAccionesPROL];
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

CREATE NONCLUSTERED INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL] (PedidoID, PedidoDetalleID, ValAutomaticaPROLLogId);   
go

USE [BelcorpGuatemala]
go


IF NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE PedidoWebAccionesPROL ADD CONSTRAINT PK_PedidoWebAccionesPROL PRIMARY KEY (PedidoWebAccionesPROLID);
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	DROP INDEX [IDX_PedidoWebAccionesPROL_CampaniaID] ON [dbo].[PedidoWebAccionesPROL];
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

CREATE NONCLUSTERED INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL] (PedidoID, PedidoDetalleID, ValAutomaticaPROLLogId);   
go

USE [BelcorpEcuador]
go


IF NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE PedidoWebAccionesPROL ADD CONSTRAINT PK_PedidoWebAccionesPROL PRIMARY KEY (PedidoWebAccionesPROLID);
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	DROP INDEX [IDX_PedidoWebAccionesPROL_CampaniaID] ON [dbo].[PedidoWebAccionesPROL];
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

CREATE NONCLUSTERED INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL] (PedidoID, PedidoDetalleID, ValAutomaticaPROLLogId);   
go

USE [BelcorpDominicana]
go


IF NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE PedidoWebAccionesPROL ADD CONSTRAINT PK_PedidoWebAccionesPROL PRIMARY KEY (PedidoWebAccionesPROLID);
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	DROP INDEX [IDX_PedidoWebAccionesPROL_CampaniaID] ON [dbo].[PedidoWebAccionesPROL];
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

CREATE NONCLUSTERED INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL] (PedidoID, PedidoDetalleID, ValAutomaticaPROLLogId);   
go

USE [BelcorpCostaRica]
go


IF NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE PedidoWebAccionesPROL ADD CONSTRAINT PK_PedidoWebAccionesPROL PRIMARY KEY (PedidoWebAccionesPROLID);
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	DROP INDEX [IDX_PedidoWebAccionesPROL_CampaniaID] ON [dbo].[PedidoWebAccionesPROL];
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

CREATE NONCLUSTERED INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL] (PedidoID, PedidoDetalleID, ValAutomaticaPROLLogId);   
go

USE [BelcorpChile]
go


IF NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE PedidoWebAccionesPROL ADD CONSTRAINT PK_PedidoWebAccionesPROL PRIMARY KEY (PedidoWebAccionesPROLID);
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	DROP INDEX [IDX_PedidoWebAccionesPROL_CampaniaID] ON [dbo].[PedidoWebAccionesPROL];
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

CREATE NONCLUSTERED INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL] (PedidoID, PedidoDetalleID, ValAutomaticaPROLLogId);   
go

USE [BelcorpBolivia]
go


IF NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE PedidoWebAccionesPROL ADD CONSTRAINT PK_PedidoWebAccionesPROL PRIMARY KEY (PedidoWebAccionesPROLID);
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	DROP INDEX [IDX_PedidoWebAccionesPROL_CampaniaID] ON [dbo].[PedidoWebAccionesPROL];
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

CREATE NONCLUSTERED INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL] (PedidoID, PedidoDetalleID, ValAutomaticaPROLLogId);   
go

