USE BelcorpPeru
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_PedidoWebDetalle_TipoEstrategiaID]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE PedidoWebDetalle DROP CONSTRAINT COST_PedidoWebDetalle_TipoEstrategiaID
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'PedidoWebDetalle' AND COLUMN_NAME = 'TipoEstrategiaID'
)
BEGIN
	ALTER TABLE PedidoWebDetalle  DROP COLUMN TipoEstrategiaID; 
END

GO

USE BelcorpMexico
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_PedidoWebDetalle_TipoEstrategiaID]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE PedidoWebDetalle DROP CONSTRAINT COST_PedidoWebDetalle_TipoEstrategiaID
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'PedidoWebDetalle' AND COLUMN_NAME = 'TipoEstrategiaID'
)
BEGIN
	ALTER TABLE PedidoWebDetalle  DROP COLUMN TipoEstrategiaID; 
END

GO

USE BelcorpColombia
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_PedidoWebDetalle_TipoEstrategiaID]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE PedidoWebDetalle DROP CONSTRAINT COST_PedidoWebDetalle_TipoEstrategiaID
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'PedidoWebDetalle' AND COLUMN_NAME = 'TipoEstrategiaID'
)
BEGIN
	ALTER TABLE PedidoWebDetalle  DROP COLUMN TipoEstrategiaID; 
END

GO

USE BelcorpVenezuela
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_PedidoWebDetalle_TipoEstrategiaID]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE PedidoWebDetalle DROP CONSTRAINT COST_PedidoWebDetalle_TipoEstrategiaID
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'PedidoWebDetalle' AND COLUMN_NAME = 'TipoEstrategiaID'
)
BEGIN
	ALTER TABLE PedidoWebDetalle  DROP COLUMN TipoEstrategiaID; 
END

GO

USE BelcorpSalvador
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_PedidoWebDetalle_TipoEstrategiaID]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE PedidoWebDetalle DROP CONSTRAINT COST_PedidoWebDetalle_TipoEstrategiaID
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'PedidoWebDetalle' AND COLUMN_NAME = 'TipoEstrategiaID'
)
BEGIN
	ALTER TABLE PedidoWebDetalle  DROP COLUMN TipoEstrategiaID; 
END

GO

USE BelcorpPuertoRico
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_PedidoWebDetalle_TipoEstrategiaID]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE PedidoWebDetalle DROP CONSTRAINT COST_PedidoWebDetalle_TipoEstrategiaID
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'PedidoWebDetalle' AND COLUMN_NAME = 'TipoEstrategiaID'
)
BEGIN
	ALTER TABLE PedidoWebDetalle  DROP COLUMN TipoEstrategiaID; 
END

GO

USE BelcorpPanama
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_PedidoWebDetalle_TipoEstrategiaID]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE PedidoWebDetalle DROP CONSTRAINT COST_PedidoWebDetalle_TipoEstrategiaID
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'PedidoWebDetalle' AND COLUMN_NAME = 'TipoEstrategiaID'
)
BEGIN
	ALTER TABLE PedidoWebDetalle  DROP COLUMN TipoEstrategiaID; 
END

GO

USE BelcorpGuatemala
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_PedidoWebDetalle_TipoEstrategiaID]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE PedidoWebDetalle DROP CONSTRAINT COST_PedidoWebDetalle_TipoEstrategiaID
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'PedidoWebDetalle' AND COLUMN_NAME = 'TipoEstrategiaID'
)
BEGIN
	ALTER TABLE PedidoWebDetalle  DROP COLUMN TipoEstrategiaID; 
END

GO

USE BelcorpEcuador
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_PedidoWebDetalle_TipoEstrategiaID]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE PedidoWebDetalle DROP CONSTRAINT COST_PedidoWebDetalle_TipoEstrategiaID
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'PedidoWebDetalle' AND COLUMN_NAME = 'TipoEstrategiaID'
)
BEGIN
	ALTER TABLE PedidoWebDetalle  DROP COLUMN TipoEstrategiaID; 
END

GO

USE BelcorpDominicana
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_PedidoWebDetalle_TipoEstrategiaID]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE PedidoWebDetalle DROP CONSTRAINT COST_PedidoWebDetalle_TipoEstrategiaID
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'PedidoWebDetalle' AND COLUMN_NAME = 'TipoEstrategiaID'
)
BEGIN
	ALTER TABLE PedidoWebDetalle  DROP COLUMN TipoEstrategiaID; 
END

GO

USE BelcorpCostaRica
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_PedidoWebDetalle_TipoEstrategiaID]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE PedidoWebDetalle DROP CONSTRAINT COST_PedidoWebDetalle_TipoEstrategiaID
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'PedidoWebDetalle' AND COLUMN_NAME = 'TipoEstrategiaID'
)
BEGIN
	ALTER TABLE PedidoWebDetalle  DROP COLUMN TipoEstrategiaID; 
END

GO

USE BelcorpChile
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_PedidoWebDetalle_TipoEstrategiaID]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE PedidoWebDetalle DROP CONSTRAINT COST_PedidoWebDetalle_TipoEstrategiaID
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'PedidoWebDetalle' AND COLUMN_NAME = 'TipoEstrategiaID'
)
BEGIN
	ALTER TABLE PedidoWebDetalle  DROP COLUMN TipoEstrategiaID; 
END

GO

USE BelcorpBolivia
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_PedidoWebDetalle_TipoEstrategiaID]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE PedidoWebDetalle DROP CONSTRAINT COST_PedidoWebDetalle_TipoEstrategiaID
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'PedidoWebDetalle' AND COLUMN_NAME = 'TipoEstrategiaID'
)
BEGIN
	ALTER TABLE PedidoWebDetalle  DROP COLUMN TipoEstrategiaID; 
END

GO

