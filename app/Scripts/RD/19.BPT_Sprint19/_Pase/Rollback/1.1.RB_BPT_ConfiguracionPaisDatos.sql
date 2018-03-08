USE BelcorpPeru
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_ConfiguracionPaisDatos_Componente]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos DROP CONSTRAINT COST_ConfiguracionPaisDatos_Componente
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'ConfiguracionPaisDatos' AND COLUMN_NAME = 'Componente1'
)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos  DROP COLUMN Componente; 
END
GO

USE BelcorpMexico
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_ConfiguracionPaisDatos_Componente]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos DROP CONSTRAINT COST_ConfiguracionPaisDatos_Componente
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'ConfiguracionPaisDatos' AND COLUMN_NAME = 'Componente1'
)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos  DROP COLUMN Componente; 
END
GO

USE BelcorpColombia
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_ConfiguracionPaisDatos_Componente]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos DROP CONSTRAINT COST_ConfiguracionPaisDatos_Componente
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'ConfiguracionPaisDatos' AND COLUMN_NAME = 'Componente1'
)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos  DROP COLUMN Componente; 
END
GO

USE BelcorpVenezuela
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_ConfiguracionPaisDatos_Componente]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos DROP CONSTRAINT COST_ConfiguracionPaisDatos_Componente
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'ConfiguracionPaisDatos' AND COLUMN_NAME = 'Componente1'
)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos  DROP COLUMN Componente; 
END
GO

USE BelcorpSalvador
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_ConfiguracionPaisDatos_Componente]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos DROP CONSTRAINT COST_ConfiguracionPaisDatos_Componente
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'ConfiguracionPaisDatos' AND COLUMN_NAME = 'Componente1'
)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos  DROP COLUMN Componente; 
END
GO

USE BelcorpPuertoRico
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_ConfiguracionPaisDatos_Componente]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos DROP CONSTRAINT COST_ConfiguracionPaisDatos_Componente
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'ConfiguracionPaisDatos' AND COLUMN_NAME = 'Componente1'
)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos  DROP COLUMN Componente; 
END
GO

USE BelcorpPanama
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_ConfiguracionPaisDatos_Componente]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos DROP CONSTRAINT COST_ConfiguracionPaisDatos_Componente
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'ConfiguracionPaisDatos' AND COLUMN_NAME = 'Componente1'
)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos  DROP COLUMN Componente; 
END
GO

USE BelcorpGuatemala
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_ConfiguracionPaisDatos_Componente]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos DROP CONSTRAINT COST_ConfiguracionPaisDatos_Componente
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'ConfiguracionPaisDatos' AND COLUMN_NAME = 'Componente1'
)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos  DROP COLUMN Componente; 
END
GO

USE BelcorpEcuador
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_ConfiguracionPaisDatos_Componente]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos DROP CONSTRAINT COST_ConfiguracionPaisDatos_Componente
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'ConfiguracionPaisDatos' AND COLUMN_NAME = 'Componente1'
)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos  DROP COLUMN Componente; 
END
GO

USE BelcorpDominicana
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_ConfiguracionPaisDatos_Componente]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos DROP CONSTRAINT COST_ConfiguracionPaisDatos_Componente
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'ConfiguracionPaisDatos' AND COLUMN_NAME = 'Componente1'
)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos  DROP COLUMN Componente; 
END
GO

USE BelcorpCostaRica
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_ConfiguracionPaisDatos_Componente]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos DROP CONSTRAINT COST_ConfiguracionPaisDatos_Componente
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'ConfiguracionPaisDatos' AND COLUMN_NAME = 'Componente1'
)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos  DROP COLUMN Componente; 
END
GO

USE BelcorpChile
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_ConfiguracionPaisDatos_Componente]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos DROP CONSTRAINT COST_ConfiguracionPaisDatos_Componente
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'ConfiguracionPaisDatos' AND COLUMN_NAME = 'Componente1'
)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos  DROP COLUMN Componente; 
END
GO

USE BelcorpBolivia
GO

GO
IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[COST_ConfiguracionPaisDatos_Componente]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos DROP CONSTRAINT COST_ConfiguracionPaisDatos_Componente
END

IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'ConfiguracionPaisDatos' AND COLUMN_NAME = 'Componente1'
)
BEGIN
	ALTER TABLE ConfiguracionPaisDatos  DROP COLUMN Componente; 
END
GO

