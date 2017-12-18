USE BelcorpPeru
GO

GO	

IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT FlagValidarImagen_def
	END

 	IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT PesoMaximoImagen_def 
	END     

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN FlagValidarImagen; 
	END

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN PesoMaximoImagen;
	END
GO

USE BelcorpMexico
GO

GO	

IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT FlagValidarImagen_def
	END

 	IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT PesoMaximoImagen_def 
	END     

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN FlagValidarImagen; 
	END

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN PesoMaximoImagen;
	END
GO

USE BelcorpColombia
GO

GO	

IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT FlagValidarImagen_def
	END

 	IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT PesoMaximoImagen_def 
	END     

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN FlagValidarImagen; 
	END

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN PesoMaximoImagen;
	END
GO

USE BelcorpVenezuela
GO

GO	

IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT FlagValidarImagen_def
	END

 	IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT PesoMaximoImagen_def 
	END     

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN FlagValidarImagen; 
	END

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN PesoMaximoImagen;
	END
GO

USE BelcorpSalvador
GO

GO	

IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT FlagValidarImagen_def
	END

 	IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT PesoMaximoImagen_def 
	END     

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN FlagValidarImagen; 
	END

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN PesoMaximoImagen;
	END
GO

USE BelcorpPuertoRico
GO

GO	

IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT FlagValidarImagen_def
	END

 	IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT PesoMaximoImagen_def 
	END     

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN FlagValidarImagen; 
	END

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN PesoMaximoImagen;
	END
GO

USE BelcorpPanama
GO

GO	

IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT FlagValidarImagen_def
	END

 	IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT PesoMaximoImagen_def 
	END     

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN FlagValidarImagen; 
	END

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN PesoMaximoImagen;
	END
GO

USE BelcorpGuatemala
GO

GO	

IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT FlagValidarImagen_def
	END

 	IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT PesoMaximoImagen_def 
	END     

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN FlagValidarImagen; 
	END

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN PesoMaximoImagen;
	END
GO

USE BelcorpEcuador
GO

GO	

IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT FlagValidarImagen_def
	END

 	IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT PesoMaximoImagen_def 
	END     

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN FlagValidarImagen; 
	END

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN PesoMaximoImagen;
	END
GO

USE BelcorpDominicana
GO

GO	

IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT FlagValidarImagen_def
	END

 	IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT PesoMaximoImagen_def 
	END     

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN FlagValidarImagen; 
	END

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN PesoMaximoImagen;
	END
GO

USE BelcorpCostaRica
GO

GO	

IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT FlagValidarImagen_def
	END

 	IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT PesoMaximoImagen_def 
	END     

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN FlagValidarImagen; 
	END

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN PesoMaximoImagen;
	END
GO

USE BelcorpChile
GO

GO	

IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT FlagValidarImagen_def
	END

 	IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT PesoMaximoImagen_def 
	END     

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN FlagValidarImagen; 
	END

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN PesoMaximoImagen;
	END
GO

USE BelcorpBolivia
GO

GO	

IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT FlagValidarImagen_def
	END

 	IF EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia DROP CONSTRAINT PesoMaximoImagen_def 
	END     

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN FlagValidarImagen; 
	END

    IF EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia  DROP COLUMN PesoMaximoImagen;
	END
GO

