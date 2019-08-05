USE BelcorpPeru
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.InsBeneficioCaminoBrillante
END
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@CodigoNivel VARCHAR(3),
@CodigoBeneficio VARCHAR(15) = '',
@NombreBeneficio VARCHAR(100),
@Descripcion VARCHAR(300),
@UrlIcono VARCHAR(5),
@Orden INT,
@Estado BIT
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio)
	BEGIN
		UPDATE BeneficioCaminoBrillante Set 
			NombreBeneficio = @NombreBeneficio,
			Descripcion = @Descripcion,
			UrlIcono = @UrlIcono,
			Orden = @Orden,
			Estado = @Estado,
			FechaActualizacion = GETDATE()
		Where CodigoNivel = @CodigoNivel
		and CodigoBeneficio = @CodigoBeneficio
	END
	ELSE
	BEGIN
		IF (@CodigoBeneficio = '')
		BEGIN
			SELECT TOP 1 @CodigoBeneficio = 'BENEFICIO' + cast(cast(REPLACE(CodigoBeneficio, 'BENEFICIO', '') as int) + 1 as varchar(15)) FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel order by CodigoBeneficio desc
		END		

		INSERT INTO BeneficioCaminoBrillante VALUES
			(
				 @CodigoNivel
				,@CodigoBeneficio
				,@NombreBeneficio
				,@Descripcion
				,@UrlIcono
				,@Orden
				,GETDATE()
				,NULL
				,@Estado
			)
	END
END
GO

USE BelcorpMexico
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.InsBeneficioCaminoBrillante
END
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@CodigoNivel VARCHAR(3),
@CodigoBeneficio VARCHAR(15) = '',
@NombreBeneficio VARCHAR(100),
@Descripcion VARCHAR(300),
@UrlIcono VARCHAR(5),
@Orden INT,
@Estado BIT
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio)
	BEGIN
		UPDATE BeneficioCaminoBrillante Set 
			NombreBeneficio = @NombreBeneficio,
			Descripcion = @Descripcion,
			UrlIcono = @UrlIcono,
			Orden = @Orden,
			Estado = @Estado,
			FechaActualizacion = GETDATE()
		Where CodigoNivel = @CodigoNivel
		and CodigoBeneficio = @CodigoBeneficio
	END
	ELSE
	BEGIN
		IF (@CodigoBeneficio = '')
		BEGIN
			SELECT TOP 1 @CodigoBeneficio = 'BENEFICIO' + cast(cast(REPLACE(CodigoBeneficio, 'BENEFICIO', '') as int) + 1 as varchar(15)) FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel order by CodigoBeneficio desc
		END		

		INSERT INTO BeneficioCaminoBrillante VALUES
			(
				 @CodigoNivel
				,@CodigoBeneficio
				,@NombreBeneficio
				,@Descripcion
				,@UrlIcono
				,@Orden
				,GETDATE()
				,NULL
				,@Estado
			)
	END
END
GO

USE BelcorpColombia
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.InsBeneficioCaminoBrillante
END
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@CodigoNivel VARCHAR(3),
@CodigoBeneficio VARCHAR(15) = '',
@NombreBeneficio VARCHAR(100),
@Descripcion VARCHAR(300),
@UrlIcono VARCHAR(5),
@Orden INT,
@Estado BIT
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio)
	BEGIN
		UPDATE BeneficioCaminoBrillante Set 
			NombreBeneficio = @NombreBeneficio,
			Descripcion = @Descripcion,
			UrlIcono = @UrlIcono,
			Orden = @Orden,
			Estado = @Estado,
			FechaActualizacion = GETDATE()
		Where CodigoNivel = @CodigoNivel
		and CodigoBeneficio = @CodigoBeneficio
	END
	ELSE
	BEGIN
		IF (@CodigoBeneficio = '')
		BEGIN
			SELECT TOP 1 @CodigoBeneficio = 'BENEFICIO' + cast(cast(REPLACE(CodigoBeneficio, 'BENEFICIO', '') as int) + 1 as varchar(15)) FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel order by CodigoBeneficio desc
		END		

		INSERT INTO BeneficioCaminoBrillante VALUES
			(
				 @CodigoNivel
				,@CodigoBeneficio
				,@NombreBeneficio
				,@Descripcion
				,@UrlIcono
				,@Orden
				,GETDATE()
				,NULL
				,@Estado
			)
	END
END
GO

USE BelcorpSalvador
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.InsBeneficioCaminoBrillante
END
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@CodigoNivel VARCHAR(3),
@CodigoBeneficio VARCHAR(15) = '',
@NombreBeneficio VARCHAR(100),
@Descripcion VARCHAR(300),
@UrlIcono VARCHAR(5),
@Orden INT,
@Estado BIT
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio)
	BEGIN
		UPDATE BeneficioCaminoBrillante Set 
			NombreBeneficio = @NombreBeneficio,
			Descripcion = @Descripcion,
			UrlIcono = @UrlIcono,
			Orden = @Orden,
			Estado = @Estado,
			FechaActualizacion = GETDATE()
		Where CodigoNivel = @CodigoNivel
		and CodigoBeneficio = @CodigoBeneficio
	END
	ELSE
	BEGIN
		IF (@CodigoBeneficio = '')
		BEGIN
			SELECT TOP 1 @CodigoBeneficio = 'BENEFICIO' + cast(cast(REPLACE(CodigoBeneficio, 'BENEFICIO', '') as int) + 1 as varchar(15)) FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel order by CodigoBeneficio desc
		END		

		INSERT INTO BeneficioCaminoBrillante VALUES
			(
				 @CodigoNivel
				,@CodigoBeneficio
				,@NombreBeneficio
				,@Descripcion
				,@UrlIcono
				,@Orden
				,GETDATE()
				,NULL
				,@Estado
			)
	END
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.InsBeneficioCaminoBrillante
END
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@CodigoNivel VARCHAR(3),
@CodigoBeneficio VARCHAR(15) = '',
@NombreBeneficio VARCHAR(100),
@Descripcion VARCHAR(300),
@UrlIcono VARCHAR(5),
@Orden INT,
@Estado BIT
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio)
	BEGIN
		UPDATE BeneficioCaminoBrillante Set 
			NombreBeneficio = @NombreBeneficio,
			Descripcion = @Descripcion,
			UrlIcono = @UrlIcono,
			Orden = @Orden,
			Estado = @Estado,
			FechaActualizacion = GETDATE()
		Where CodigoNivel = @CodigoNivel
		and CodigoBeneficio = @CodigoBeneficio
	END
	ELSE
	BEGIN
		IF (@CodigoBeneficio = '')
		BEGIN
			SELECT TOP 1 @CodigoBeneficio = 'BENEFICIO' + cast(cast(REPLACE(CodigoBeneficio, 'BENEFICIO', '') as int) + 1 as varchar(15)) FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel order by CodigoBeneficio desc
		END		

		INSERT INTO BeneficioCaminoBrillante VALUES
			(
				 @CodigoNivel
				,@CodigoBeneficio
				,@NombreBeneficio
				,@Descripcion
				,@UrlIcono
				,@Orden
				,GETDATE()
				,NULL
				,@Estado
			)
	END
END
GO

USE BelcorpPanama
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.InsBeneficioCaminoBrillante
END
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@CodigoNivel VARCHAR(3),
@CodigoBeneficio VARCHAR(15) = '',
@NombreBeneficio VARCHAR(100),
@Descripcion VARCHAR(300),
@UrlIcono VARCHAR(5),
@Orden INT,
@Estado BIT
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio)
	BEGIN
		UPDATE BeneficioCaminoBrillante Set 
			NombreBeneficio = @NombreBeneficio,
			Descripcion = @Descripcion,
			UrlIcono = @UrlIcono,
			Orden = @Orden,
			Estado = @Estado,
			FechaActualizacion = GETDATE()
		Where CodigoNivel = @CodigoNivel
		and CodigoBeneficio = @CodigoBeneficio
	END
	ELSE
	BEGIN
		IF (@CodigoBeneficio = '')
		BEGIN
			SELECT TOP 1 @CodigoBeneficio = 'BENEFICIO' + cast(cast(REPLACE(CodigoBeneficio, 'BENEFICIO', '') as int) + 1 as varchar(15)) FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel order by CodigoBeneficio desc
		END		

		INSERT INTO BeneficioCaminoBrillante VALUES
			(
				 @CodigoNivel
				,@CodigoBeneficio
				,@NombreBeneficio
				,@Descripcion
				,@UrlIcono
				,@Orden
				,GETDATE()
				,NULL
				,@Estado
			)
	END
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.InsBeneficioCaminoBrillante
END
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@CodigoNivel VARCHAR(3),
@CodigoBeneficio VARCHAR(15) = '',
@NombreBeneficio VARCHAR(100),
@Descripcion VARCHAR(300),
@UrlIcono VARCHAR(5),
@Orden INT,
@Estado BIT
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio)
	BEGIN
		UPDATE BeneficioCaminoBrillante Set 
			NombreBeneficio = @NombreBeneficio,
			Descripcion = @Descripcion,
			UrlIcono = @UrlIcono,
			Orden = @Orden,
			Estado = @Estado,
			FechaActualizacion = GETDATE()
		Where CodigoNivel = @CodigoNivel
		and CodigoBeneficio = @CodigoBeneficio
	END
	ELSE
	BEGIN
		IF (@CodigoBeneficio = '')
		BEGIN
			SELECT TOP 1 @CodigoBeneficio = 'BENEFICIO' + cast(cast(REPLACE(CodigoBeneficio, 'BENEFICIO', '') as int) + 1 as varchar(15)) FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel order by CodigoBeneficio desc
		END		

		INSERT INTO BeneficioCaminoBrillante VALUES
			(
				 @CodigoNivel
				,@CodigoBeneficio
				,@NombreBeneficio
				,@Descripcion
				,@UrlIcono
				,@Orden
				,GETDATE()
				,NULL
				,@Estado
			)
	END
END
GO

USE BelcorpEcuador
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.InsBeneficioCaminoBrillante
END
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@CodigoNivel VARCHAR(3),
@CodigoBeneficio VARCHAR(15) = '',
@NombreBeneficio VARCHAR(100),
@Descripcion VARCHAR(300),
@UrlIcono VARCHAR(5),
@Orden INT,
@Estado BIT
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio)
	BEGIN
		UPDATE BeneficioCaminoBrillante Set 
			NombreBeneficio = @NombreBeneficio,
			Descripcion = @Descripcion,
			UrlIcono = @UrlIcono,
			Orden = @Orden,
			Estado = @Estado,
			FechaActualizacion = GETDATE()
		Where CodigoNivel = @CodigoNivel
		and CodigoBeneficio = @CodigoBeneficio
	END
	ELSE
	BEGIN
		IF (@CodigoBeneficio = '')
		BEGIN
			SELECT TOP 1 @CodigoBeneficio = 'BENEFICIO' + cast(cast(REPLACE(CodigoBeneficio, 'BENEFICIO', '') as int) + 1 as varchar(15)) FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel order by CodigoBeneficio desc
		END		

		INSERT INTO BeneficioCaminoBrillante VALUES
			(
				 @CodigoNivel
				,@CodigoBeneficio
				,@NombreBeneficio
				,@Descripcion
				,@UrlIcono
				,@Orden
				,GETDATE()
				,NULL
				,@Estado
			)
	END
END
GO

USE BelcorpDominicana
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.InsBeneficioCaminoBrillante
END
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@CodigoNivel VARCHAR(3),
@CodigoBeneficio VARCHAR(15) = '',
@NombreBeneficio VARCHAR(100),
@Descripcion VARCHAR(300),
@UrlIcono VARCHAR(5),
@Orden INT,
@Estado BIT
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio)
	BEGIN
		UPDATE BeneficioCaminoBrillante Set 
			NombreBeneficio = @NombreBeneficio,
			Descripcion = @Descripcion,
			UrlIcono = @UrlIcono,
			Orden = @Orden,
			Estado = @Estado,
			FechaActualizacion = GETDATE()
		Where CodigoNivel = @CodigoNivel
		and CodigoBeneficio = @CodigoBeneficio
	END
	ELSE
	BEGIN
		IF (@CodigoBeneficio = '')
		BEGIN
			SELECT TOP 1 @CodigoBeneficio = 'BENEFICIO' + cast(cast(REPLACE(CodigoBeneficio, 'BENEFICIO', '') as int) + 1 as varchar(15)) FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel order by CodigoBeneficio desc
		END		

		INSERT INTO BeneficioCaminoBrillante VALUES
			(
				 @CodigoNivel
				,@CodigoBeneficio
				,@NombreBeneficio
				,@Descripcion
				,@UrlIcono
				,@Orden
				,GETDATE()
				,NULL
				,@Estado
			)
	END
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.InsBeneficioCaminoBrillante
END
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@CodigoNivel VARCHAR(3),
@CodigoBeneficio VARCHAR(15) = '',
@NombreBeneficio VARCHAR(100),
@Descripcion VARCHAR(300),
@UrlIcono VARCHAR(5),
@Orden INT,
@Estado BIT
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio)
	BEGIN
		UPDATE BeneficioCaminoBrillante Set 
			NombreBeneficio = @NombreBeneficio,
			Descripcion = @Descripcion,
			UrlIcono = @UrlIcono,
			Orden = @Orden,
			Estado = @Estado,
			FechaActualizacion = GETDATE()
		Where CodigoNivel = @CodigoNivel
		and CodigoBeneficio = @CodigoBeneficio
	END
	ELSE
	BEGIN
		IF (@CodigoBeneficio = '')
		BEGIN
			SELECT TOP 1 @CodigoBeneficio = 'BENEFICIO' + cast(cast(REPLACE(CodigoBeneficio, 'BENEFICIO', '') as int) + 1 as varchar(15)) FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel order by CodigoBeneficio desc
		END		

		INSERT INTO BeneficioCaminoBrillante VALUES
			(
				 @CodigoNivel
				,@CodigoBeneficio
				,@NombreBeneficio
				,@Descripcion
				,@UrlIcono
				,@Orden
				,GETDATE()
				,NULL
				,@Estado
			)
	END
END
GO

USE BelcorpChile
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.InsBeneficioCaminoBrillante
END
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@CodigoNivel VARCHAR(3),
@CodigoBeneficio VARCHAR(15) = '',
@NombreBeneficio VARCHAR(100),
@Descripcion VARCHAR(300),
@UrlIcono VARCHAR(5),
@Orden INT,
@Estado BIT
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio)
	BEGIN
		UPDATE BeneficioCaminoBrillante Set 
			NombreBeneficio = @NombreBeneficio,
			Descripcion = @Descripcion,
			UrlIcono = @UrlIcono,
			Orden = @Orden,
			Estado = @Estado,
			FechaActualizacion = GETDATE()
		Where CodigoNivel = @CodigoNivel
		and CodigoBeneficio = @CodigoBeneficio
	END
	ELSE
	BEGIN
		IF (@CodigoBeneficio = '')
		BEGIN
			SELECT TOP 1 @CodigoBeneficio = 'BENEFICIO' + cast(cast(REPLACE(CodigoBeneficio, 'BENEFICIO', '') as int) + 1 as varchar(15)) FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel order by CodigoBeneficio desc
		END		

		INSERT INTO BeneficioCaminoBrillante VALUES
			(
				 @CodigoNivel
				,@CodigoBeneficio
				,@NombreBeneficio
				,@Descripcion
				,@UrlIcono
				,@Orden
				,GETDATE()
				,NULL
				,@Estado
			)
	END
END
GO

USE BelcorpBolivia
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.InsBeneficioCaminoBrillante
END
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@CodigoNivel VARCHAR(3),
@CodigoBeneficio VARCHAR(15) = '',
@NombreBeneficio VARCHAR(100),
@Descripcion VARCHAR(300),
@UrlIcono VARCHAR(5),
@Orden INT,
@Estado BIT
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio)
	BEGIN
		UPDATE BeneficioCaminoBrillante Set 
			NombreBeneficio = @NombreBeneficio,
			Descripcion = @Descripcion,
			UrlIcono = @UrlIcono,
			Orden = @Orden,
			Estado = @Estado,
			FechaActualizacion = GETDATE()
		Where CodigoNivel = @CodigoNivel
		and CodigoBeneficio = @CodigoBeneficio
	END
	ELSE
	BEGIN
		IF (@CodigoBeneficio = '')
		BEGIN
			SELECT TOP 1 @CodigoBeneficio = 'BENEFICIO' + cast(cast(REPLACE(CodigoBeneficio, 'BENEFICIO', '') as int) + 1 as varchar(15)) FROM BeneficioCaminoBrillante where CodigoNivel = @CodigoNivel order by CodigoBeneficio desc
		END		

		INSERT INTO BeneficioCaminoBrillante VALUES
			(
				 @CodigoNivel
				,@CodigoBeneficio
				,@NombreBeneficio
				,@Descripcion
				,@UrlIcono
				,@Orden
				,GETDATE()
				,NULL
				,@Estado
			)
	END
END
GO

