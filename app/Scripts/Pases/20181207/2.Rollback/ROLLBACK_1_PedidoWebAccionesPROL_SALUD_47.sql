USE [BelcorpPeru]
go

IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE dbo.PedidoWebAccionesPROL DROP CONSTRAINT PK_PedidoWebAccionesPROL;  
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	CREATE NONCLUSTERED INDEX IDX_PedidoWebAccionesPROL_CampaniaID ON [dbo].[PedidoWebAccionesPROL] (CampaniaId ASC) INCLUDE(ConsultoraID); 
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  


USE [BelcorpMexico]
go

IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE dbo.PedidoWebAccionesPROL DROP CONSTRAINT PK_PedidoWebAccionesPROL;  
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	CREATE NONCLUSTERED INDEX IDX_PedidoWebAccionesPROL_CampaniaID ON [dbo].[PedidoWebAccionesPROL] (CampaniaId ASC) INCLUDE(ConsultoraID); 
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

USE [BelcorpColombia]
go


IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE dbo.PedidoWebAccionesPROL DROP CONSTRAINT PK_PedidoWebAccionesPROL;  
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	CREATE NONCLUSTERED INDEX IDX_PedidoWebAccionesPROL_CampaniaID ON [dbo].[PedidoWebAccionesPROL] (CampaniaId ASC) INCLUDE(ConsultoraID); 
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

USE [BelcorpSalvador]
go


IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE dbo.PedidoWebAccionesPROL DROP CONSTRAINT PK_PedidoWebAccionesPROL;  
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	CREATE NONCLUSTERED INDEX IDX_PedidoWebAccionesPROL_CampaniaID ON [dbo].[PedidoWebAccionesPROL] (CampaniaId ASC) INCLUDE(ConsultoraID); 
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

USE [BelcorpPuertoRico]
go


IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE dbo.PedidoWebAccionesPROL DROP CONSTRAINT PK_PedidoWebAccionesPROL;  
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	CREATE NONCLUSTERED INDEX IDX_PedidoWebAccionesPROL_CampaniaID ON [dbo].[PedidoWebAccionesPROL] (CampaniaId ASC) INCLUDE(ConsultoraID); 
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

USE [BelcorpPanama]
go


IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE dbo.PedidoWebAccionesPROL DROP CONSTRAINT PK_PedidoWebAccionesPROL;  
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	CREATE NONCLUSTERED INDEX IDX_PedidoWebAccionesPROL_CampaniaID ON [dbo].[PedidoWebAccionesPROL] (CampaniaId ASC) INCLUDE(ConsultoraID); 
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

USE [BelcorpGuatemala]
go


IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE dbo.PedidoWebAccionesPROL DROP CONSTRAINT PK_PedidoWebAccionesPROL;  
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	CREATE NONCLUSTERED INDEX IDX_PedidoWebAccionesPROL_CampaniaID ON [dbo].[PedidoWebAccionesPROL] (CampaniaId ASC) INCLUDE(ConsultoraID); 
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

USE [BelcorpEcuador]
go


IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE dbo.PedidoWebAccionesPROL DROP CONSTRAINT PK_PedidoWebAccionesPROL;  
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	CREATE NONCLUSTERED INDEX IDX_PedidoWebAccionesPROL_CampaniaID ON [dbo].[PedidoWebAccionesPROL] (CampaniaId ASC) INCLUDE(ConsultoraID); 
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

USE [BelcorpDominicana]
go


IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE dbo.PedidoWebAccionesPROL DROP CONSTRAINT PK_PedidoWebAccionesPROL;  
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	CREATE NONCLUSTERED INDEX IDX_PedidoWebAccionesPROL_CampaniaID ON [dbo].[PedidoWebAccionesPROL] (CampaniaId ASC) INCLUDE(ConsultoraID); 
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

USE [BelcorpCostaRica]
go


IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE dbo.PedidoWebAccionesPROL DROP CONSTRAINT PK_PedidoWebAccionesPROL;  
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	CREATE NONCLUSTERED INDEX IDX_PedidoWebAccionesPROL_CampaniaID ON [dbo].[PedidoWebAccionesPROL] (CampaniaId ASC) INCLUDE(ConsultoraID); 
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

USE [BelcorpChile]
go


IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE dbo.PedidoWebAccionesPROL DROP CONSTRAINT PK_PedidoWebAccionesPROL;  
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	CREATE NONCLUSTERED INDEX IDX_PedidoWebAccionesPROL_CampaniaID ON [dbo].[PedidoWebAccionesPROL] (CampaniaId ASC) INCLUDE(ConsultoraID); 
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

USE [BelcorpBolivia]
go


IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'PedidoWebAccionesPROL' and CONSTRAINT_NAME='PK_PedidoWebAccionesPROL')
begin
	ALTER TABLE dbo.PedidoWebAccionesPROL DROP CONSTRAINT PK_PedidoWebAccionesPROL;  
end
go

IF EXISTS (SELECT name FROM sys.indexes  WHERE name='IDX_PedidoWebAccionesPROL_CampaniaID' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))
begin
	CREATE NONCLUSTERED INDEX IDX_PedidoWebAccionesPROL_CampaniaID ON [dbo].[PedidoWebAccionesPROL] (CampaniaId ASC) INCLUDE(ConsultoraID); 
end

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId' AND object_id = OBJECT_ID('[dbo].[PedidoWebAccionesPROL]'))   
    DROP INDEX IX_PedidoWebAccionesPROL_PedID_PedDetalleID_ValPROLLogId ON [dbo].[PedidoWebAccionesPROL];
GO  

