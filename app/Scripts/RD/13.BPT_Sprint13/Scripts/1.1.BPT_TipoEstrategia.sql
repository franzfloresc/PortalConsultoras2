USE BelcorpPeru
GO

GO
    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD FlagValidarImagen int NULL ; 
	END


    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD  PesoMaximoImagen int NULL ;  
	END


	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT FlagValidarImagen_def DEFAULT 0 FOR FlagValidarImagen; 
	END

 	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT PesoMaximoImagen_def DEFAULT 0 FOR PesoMaximoImagen; 
	END 


UPDATE TipoEstrategia
SET	FlagValidarImagen = 0,
	PesoMaximoImagen = 0

GO

USE BelcorpMexico
GO

GO
    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD FlagValidarImagen int NULL ; 
	END


    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD  PesoMaximoImagen int NULL ;  
	END


	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT FlagValidarImagen_def DEFAULT 0 FOR FlagValidarImagen; 
	END

 	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT PesoMaximoImagen_def DEFAULT 0 FOR PesoMaximoImagen; 
	END 


UPDATE TipoEstrategia
SET	FlagValidarImagen = 0,
	PesoMaximoImagen = 0

GO

USE BelcorpColombia
GO

GO
    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD FlagValidarImagen int NULL ; 
	END


    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD  PesoMaximoImagen int NULL ;  
	END


	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT FlagValidarImagen_def DEFAULT 0 FOR FlagValidarImagen; 
	END

 	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT PesoMaximoImagen_def DEFAULT 0 FOR PesoMaximoImagen; 
	END 


UPDATE TipoEstrategia
SET	FlagValidarImagen = 0,
	PesoMaximoImagen = 0

GO

USE BelcorpVenezuela
GO

GO
    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD FlagValidarImagen int NULL ; 
	END


    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD  PesoMaximoImagen int NULL ;  
	END


	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT FlagValidarImagen_def DEFAULT 0 FOR FlagValidarImagen; 
	END

 	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT PesoMaximoImagen_def DEFAULT 0 FOR PesoMaximoImagen; 
	END 


UPDATE TipoEstrategia
SET	FlagValidarImagen = 0,
	PesoMaximoImagen = 0

GO

USE BelcorpSalvador
GO

GO
    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD FlagValidarImagen int NULL ; 
	END


    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD  PesoMaximoImagen int NULL ;  
	END


	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT FlagValidarImagen_def DEFAULT 0 FOR FlagValidarImagen; 
	END

 	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT PesoMaximoImagen_def DEFAULT 0 FOR PesoMaximoImagen; 
	END 


UPDATE TipoEstrategia
SET	FlagValidarImagen = 0,
	PesoMaximoImagen = 0

GO

USE BelcorpPuertoRico
GO

GO
    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD FlagValidarImagen int NULL ; 
	END


    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD  PesoMaximoImagen int NULL ;  
	END


	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT FlagValidarImagen_def DEFAULT 0 FOR FlagValidarImagen; 
	END

 	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT PesoMaximoImagen_def DEFAULT 0 FOR PesoMaximoImagen; 
	END 


UPDATE TipoEstrategia
SET	FlagValidarImagen = 0,
	PesoMaximoImagen = 0

GO

USE BelcorpPanama
GO

GO
    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD FlagValidarImagen int NULL ; 
	END


    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD  PesoMaximoImagen int NULL ;  
	END


	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT FlagValidarImagen_def DEFAULT 0 FOR FlagValidarImagen; 
	END

 	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT PesoMaximoImagen_def DEFAULT 0 FOR PesoMaximoImagen; 
	END 


UPDATE TipoEstrategia
SET	FlagValidarImagen = 0,
	PesoMaximoImagen = 0

GO

USE BelcorpGuatemala
GO

GO
    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD FlagValidarImagen int NULL ; 
	END


    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD  PesoMaximoImagen int NULL ;  
	END


	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT FlagValidarImagen_def DEFAULT 0 FOR FlagValidarImagen; 
	END

 	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT PesoMaximoImagen_def DEFAULT 0 FOR PesoMaximoImagen; 
	END 


UPDATE TipoEstrategia
SET	FlagValidarImagen = 0,
	PesoMaximoImagen = 0

GO

USE BelcorpEcuador
GO

GO
    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD FlagValidarImagen int NULL ; 
	END


    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD  PesoMaximoImagen int NULL ;  
	END


	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT FlagValidarImagen_def DEFAULT 0 FOR FlagValidarImagen; 
	END

 	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT PesoMaximoImagen_def DEFAULT 0 FOR PesoMaximoImagen; 
	END 


UPDATE TipoEstrategia
SET	FlagValidarImagen = 0,
	PesoMaximoImagen = 0

GO

USE BelcorpDominicana
GO

GO
    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD FlagValidarImagen int NULL ; 
	END


    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD  PesoMaximoImagen int NULL ;  
	END


	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT FlagValidarImagen_def DEFAULT 0 FOR FlagValidarImagen; 
	END

 	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT PesoMaximoImagen_def DEFAULT 0 FOR PesoMaximoImagen; 
	END 


UPDATE TipoEstrategia
SET	FlagValidarImagen = 0,
	PesoMaximoImagen = 0

GO

USE BelcorpCostaRica
GO

GO
    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD FlagValidarImagen int NULL ; 
	END


    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD  PesoMaximoImagen int NULL ;  
	END


	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT FlagValidarImagen_def DEFAULT 0 FOR FlagValidarImagen; 
	END

 	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT PesoMaximoImagen_def DEFAULT 0 FOR PesoMaximoImagen; 
	END 


UPDATE TipoEstrategia
SET	FlagValidarImagen = 0,
	PesoMaximoImagen = 0

GO

USE BelcorpChile
GO

GO
    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD FlagValidarImagen int NULL ; 
	END


    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD  PesoMaximoImagen int NULL ;  
	END


	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT FlagValidarImagen_def DEFAULT 0 FOR FlagValidarImagen; 
	END

 	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT PesoMaximoImagen_def DEFAULT 0 FOR PesoMaximoImagen; 
	END 


UPDATE TipoEstrategia
SET	FlagValidarImagen = 0,
	PesoMaximoImagen = 0

GO

USE BelcorpBolivia
GO

GO
    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'FlagValidarImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD FlagValidarImagen int NULL ; 
	END


    IF NOT EXISTS(
        SELECT *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'TipoEstrategia' AND COLUMN_NAME = 'PesoMaximoImagen'
    )
    	BEGIN
		ALTER TABLE TipoEstrategia ADD  PesoMaximoImagen int NULL ;  
	END


	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[FlagValidarImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT FlagValidarImagen_def DEFAULT 0 FOR FlagValidarImagen; 
	END

 	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id('[dbo].[PesoMaximoImagen_def]') 
	and OBJECTPROPERTY(id, 'IsConstraint') = 1)
	BEGIN
		ALTER TABLE TipoEstrategia ADD CONSTRAINT PesoMaximoImagen_def DEFAULT 0 FOR PesoMaximoImagen; 
	END 


UPDATE TipoEstrategia
SET	FlagValidarImagen = 0,
	PesoMaximoImagen = 0

GO

