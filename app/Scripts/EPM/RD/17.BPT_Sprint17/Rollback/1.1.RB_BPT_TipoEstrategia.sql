USE BelcorpPeru
GO

GO

IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_TipoEstrategia_NombreComercial]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE TipoEstrategia DROP CONSTRAINT COST_TipoEstrategia_NombreComercial
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'NombreComercial'
)
BEGIN
	ALTER TABLE TipoEstrategia  DROP COLUMN NombreComercial; 
END

GO

USE BelcorpMexico
GO

GO

IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_TipoEstrategia_NombreComercial]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE TipoEstrategia DROP CONSTRAINT COST_TipoEstrategia_NombreComercial
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'NombreComercial'
)
BEGIN
	ALTER TABLE TipoEstrategia  DROP COLUMN NombreComercial; 
END

GO

USE BelcorpColombia
GO

GO

IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_TipoEstrategia_NombreComercial]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE TipoEstrategia DROP CONSTRAINT COST_TipoEstrategia_NombreComercial
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'NombreComercial'
)
BEGIN
	ALTER TABLE TipoEstrategia  DROP COLUMN NombreComercial; 
END

GO

USE BelcorpVenezuela
GO

GO

IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_TipoEstrategia_NombreComercial]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE TipoEstrategia DROP CONSTRAINT COST_TipoEstrategia_NombreComercial
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'NombreComercial'
)
BEGIN
	ALTER TABLE TipoEstrategia  DROP COLUMN NombreComercial; 
END

GO

USE BelcorpSalvador
GO

GO

IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_TipoEstrategia_NombreComercial]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE TipoEstrategia DROP CONSTRAINT COST_TipoEstrategia_NombreComercial
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'NombreComercial'
)
BEGIN
	ALTER TABLE TipoEstrategia  DROP COLUMN NombreComercial; 
END

GO

USE BelcorpPuertoRico
GO

GO

IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_TipoEstrategia_NombreComercial]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE TipoEstrategia DROP CONSTRAINT COST_TipoEstrategia_NombreComercial
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'NombreComercial'
)
BEGIN
	ALTER TABLE TipoEstrategia  DROP COLUMN NombreComercial; 
END

GO

USE BelcorpPanama
GO

GO

IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_TipoEstrategia_NombreComercial]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE TipoEstrategia DROP CONSTRAINT COST_TipoEstrategia_NombreComercial
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'NombreComercial'
)
BEGIN
	ALTER TABLE TipoEstrategia  DROP COLUMN NombreComercial; 
END

GO

USE BelcorpGuatemala
GO

GO

IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_TipoEstrategia_NombreComercial]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE TipoEstrategia DROP CONSTRAINT COST_TipoEstrategia_NombreComercial
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'NombreComercial'
)
BEGIN
	ALTER TABLE TipoEstrategia  DROP COLUMN NombreComercial; 
END

GO

USE BelcorpEcuador
GO

GO

IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_TipoEstrategia_NombreComercial]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE TipoEstrategia DROP CONSTRAINT COST_TipoEstrategia_NombreComercial
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'NombreComercial'
)
BEGIN
	ALTER TABLE TipoEstrategia  DROP COLUMN NombreComercial; 
END

GO

USE BelcorpDominicana
GO

GO

IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_TipoEstrategia_NombreComercial]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE TipoEstrategia DROP CONSTRAINT COST_TipoEstrategia_NombreComercial
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'NombreComercial'
)
BEGIN
	ALTER TABLE TipoEstrategia  DROP COLUMN NombreComercial; 
END

GO

USE BelcorpCostaRica
GO

GO

IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_TipoEstrategia_NombreComercial]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE TipoEstrategia DROP CONSTRAINT COST_TipoEstrategia_NombreComercial
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'NombreComercial'
)
BEGIN
	ALTER TABLE TipoEstrategia  DROP COLUMN NombreComercial; 
END

GO

USE BelcorpChile
GO

GO

IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_TipoEstrategia_NombreComercial]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE TipoEstrategia DROP CONSTRAINT COST_TipoEstrategia_NombreComercial
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'NombreComercial'
)
BEGIN
	ALTER TABLE TipoEstrategia  DROP COLUMN NombreComercial; 
END

GO

USE BelcorpBolivia
GO

GO

IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_TipoEstrategia_NombreComercial]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE TipoEstrategia DROP CONSTRAINT COST_TipoEstrategia_NombreComercial
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'NombreComercial'
)
BEGIN
	ALTER TABLE TipoEstrategia  DROP COLUMN NombreComercial; 
END

GO
