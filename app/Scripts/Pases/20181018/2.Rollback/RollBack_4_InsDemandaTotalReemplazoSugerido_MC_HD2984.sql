USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[InsDemandaTotalReemplazoSugerido]
(
@CampaniaID int,
@ConsultoraID int,
@CUVOriginal varchar(20),
@CUVSugerido varchar(20),
@Aceptado bit,
@Cantidad int,
@PrecioUnidad money
)
AS
BEGIN
	DECLARE @Tipo varchar(3) = 'FRS'
	if (@Aceptado = 1) set @Tipo = 'RSA'

	IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido = @CUVSugerido)
		BEGIN
			IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal AND @CUVSugerido IS NULL)
			BEGIN
				INSERT INTO DemandaTotalReemplazoSugerido(
				 CampaniaID
				,ConsultoraID
				,CUVOriginal
				,CUVSugerido
				,Aceptado
				,Cantidad
				,PrecioUnidad
				,Tipo
				,FechaProceso
				)
				VALUES
				(
				 @CampaniaID 
				 ,@ConsultoraID 
				 ,@CUVOriginal
				 ,@CUVSugerido
				 ,@Aceptado
				 ,@Cantidad
				 ,@PrecioUnidad
				 ,@Tipo
				 ,getdate())
			 END
		END
	END	
	ELSE
	BEGIN
		IF (@CUVSugerido IS NOT NULL)
		BEGIN
			UPDATE DemandaTotalReemplazoSugerido SET CUVSugerido = @CUVSugerido, Aceptado = 1, Cantidad = @Cantidad, PrecioUnidad = @PrecioUnidad, Tipo = @Tipo, FechaProceso = getdate() 
			WHERE CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL
		END
	END
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[InsDemandaTotalReemplazoSugerido]
(
@CampaniaID int,
@ConsultoraID int,
@CUVOriginal varchar(20),
@CUVSugerido varchar(20),
@Aceptado bit,
@Cantidad int,
@PrecioUnidad money
)
AS
BEGIN
	DECLARE @Tipo varchar(3) = 'FRS'
	if (@Aceptado = 1) set @Tipo = 'RSA'

	IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido = @CUVSugerido)
		BEGIN
			IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal AND @CUVSugerido IS NULL)
			BEGIN
				INSERT INTO DemandaTotalReemplazoSugerido(
				 CampaniaID
				,ConsultoraID
				,CUVOriginal
				,CUVSugerido
				,Aceptado
				,Cantidad
				,PrecioUnidad
				,Tipo
				,FechaProceso
				)
				VALUES
				(
				 @CampaniaID 
				 ,@ConsultoraID 
				 ,@CUVOriginal
				 ,@CUVSugerido
				 ,@Aceptado
				 ,@Cantidad
				 ,@PrecioUnidad
				 ,@Tipo
				 ,getdate())
			 END
		END
	END	
	ELSE
	BEGIN
		IF (@CUVSugerido IS NOT NULL)
		BEGIN
			UPDATE DemandaTotalReemplazoSugerido SET CUVSugerido = @CUVSugerido, Aceptado = 1, Cantidad = @Cantidad, PrecioUnidad = @PrecioUnidad, Tipo = @Tipo, FechaProceso = getdate() 
			WHERE CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL
		END
	END
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[InsDemandaTotalReemplazoSugerido]
(
@CampaniaID int,
@ConsultoraID int,
@CUVOriginal varchar(20),
@CUVSugerido varchar(20),
@Aceptado bit,
@Cantidad int,
@PrecioUnidad money
)
AS
BEGIN
	DECLARE @Tipo varchar(3) = 'FRS'
	if (@Aceptado = 1) set @Tipo = 'RSA'

	IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido = @CUVSugerido)
		BEGIN
			IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal AND @CUVSugerido IS NULL)
			BEGIN
				INSERT INTO DemandaTotalReemplazoSugerido(
				 CampaniaID
				,ConsultoraID
				,CUVOriginal
				,CUVSugerido
				,Aceptado
				,Cantidad
				,PrecioUnidad
				,Tipo
				,FechaProceso
				)
				VALUES
				(
				 @CampaniaID 
				 ,@ConsultoraID 
				 ,@CUVOriginal
				 ,@CUVSugerido
				 ,@Aceptado
				 ,@Cantidad
				 ,@PrecioUnidad
				 ,@Tipo
				 ,getdate())
			 END
		END
	END	
	ELSE
	BEGIN
		IF (@CUVSugerido IS NOT NULL)
		BEGIN
			UPDATE DemandaTotalReemplazoSugerido SET CUVSugerido = @CUVSugerido, Aceptado = 1, Cantidad = @Cantidad, PrecioUnidad = @PrecioUnidad, Tipo = @Tipo, FechaProceso = getdate() 
			WHERE CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL
		END
	END
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[InsDemandaTotalReemplazoSugerido]
(
@CampaniaID int,
@ConsultoraID int,
@CUVOriginal varchar(20),
@CUVSugerido varchar(20),
@Aceptado bit,
@Cantidad int,
@PrecioUnidad money
)
AS
BEGIN
	DECLARE @Tipo varchar(3) = 'FRS'
	if (@Aceptado = 1) set @Tipo = 'RSA'

	IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido = @CUVSugerido)
		BEGIN
			IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal AND @CUVSugerido IS NULL)
			BEGIN
				INSERT INTO DemandaTotalReemplazoSugerido(
				 CampaniaID
				,ConsultoraID
				,CUVOriginal
				,CUVSugerido
				,Aceptado
				,Cantidad
				,PrecioUnidad
				,Tipo
				,FechaProceso
				)
				VALUES
				(
				 @CampaniaID 
				 ,@ConsultoraID 
				 ,@CUVOriginal
				 ,@CUVSugerido
				 ,@Aceptado
				 ,@Cantidad
				 ,@PrecioUnidad
				 ,@Tipo
				 ,getdate())
			 END
		END
	END	
	ELSE
	BEGIN
		IF (@CUVSugerido IS NOT NULL)
		BEGIN
			UPDATE DemandaTotalReemplazoSugerido SET CUVSugerido = @CUVSugerido, Aceptado = 1, Cantidad = @Cantidad, PrecioUnidad = @PrecioUnidad, Tipo = @Tipo, FechaProceso = getdate() 
			WHERE CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL
		END
	END
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[InsDemandaTotalReemplazoSugerido]
(
@CampaniaID int,
@ConsultoraID int,
@CUVOriginal varchar(20),
@CUVSugerido varchar(20),
@Aceptado bit,
@Cantidad int,
@PrecioUnidad money
)
AS
BEGIN
	DECLARE @Tipo varchar(3) = 'FRS'
	if (@Aceptado = 1) set @Tipo = 'RSA'

	IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido = @CUVSugerido)
		BEGIN
			IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal AND @CUVSugerido IS NULL)
			BEGIN
				INSERT INTO DemandaTotalReemplazoSugerido(
				 CampaniaID
				,ConsultoraID
				,CUVOriginal
				,CUVSugerido
				,Aceptado
				,Cantidad
				,PrecioUnidad
				,Tipo
				,FechaProceso
				)
				VALUES
				(
				 @CampaniaID 
				 ,@ConsultoraID 
				 ,@CUVOriginal
				 ,@CUVSugerido
				 ,@Aceptado
				 ,@Cantidad
				 ,@PrecioUnidad
				 ,@Tipo
				 ,getdate())
			 END
		END
	END	
	ELSE
	BEGIN
		IF (@CUVSugerido IS NOT NULL)
		BEGIN
			UPDATE DemandaTotalReemplazoSugerido SET CUVSugerido = @CUVSugerido, Aceptado = 1, Cantidad = @Cantidad, PrecioUnidad = @PrecioUnidad, Tipo = @Tipo, FechaProceso = getdate() 
			WHERE CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL
		END
	END
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[InsDemandaTotalReemplazoSugerido]
(
@CampaniaID int,
@ConsultoraID int,
@CUVOriginal varchar(20),
@CUVSugerido varchar(20),
@Aceptado bit,
@Cantidad int,
@PrecioUnidad money
)
AS
BEGIN
	DECLARE @Tipo varchar(3) = 'FRS'
	if (@Aceptado = 1) set @Tipo = 'RSA'

	IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido = @CUVSugerido)
		BEGIN
			IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal AND @CUVSugerido IS NULL)
			BEGIN
				INSERT INTO DemandaTotalReemplazoSugerido(
				 CampaniaID
				,ConsultoraID
				,CUVOriginal
				,CUVSugerido
				,Aceptado
				,Cantidad
				,PrecioUnidad
				,Tipo
				,FechaProceso
				)
				VALUES
				(
				 @CampaniaID 
				 ,@ConsultoraID 
				 ,@CUVOriginal
				 ,@CUVSugerido
				 ,@Aceptado
				 ,@Cantidad
				 ,@PrecioUnidad
				 ,@Tipo
				 ,getdate())
			 END
		END
	END	
	ELSE
	BEGIN
		IF (@CUVSugerido IS NOT NULL)
		BEGIN
			UPDATE DemandaTotalReemplazoSugerido SET CUVSugerido = @CUVSugerido, Aceptado = 1, Cantidad = @Cantidad, PrecioUnidad = @PrecioUnidad, Tipo = @Tipo, FechaProceso = getdate() 
			WHERE CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL
		END
	END
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[InsDemandaTotalReemplazoSugerido]
(
@CampaniaID int,
@ConsultoraID int,
@CUVOriginal varchar(20),
@CUVSugerido varchar(20),
@Aceptado bit,
@Cantidad int,
@PrecioUnidad money
)
AS
BEGIN
	DECLARE @Tipo varchar(3) = 'FRS'
	if (@Aceptado = 1) set @Tipo = 'RSA'

	IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido = @CUVSugerido)
		BEGIN
			IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal AND @CUVSugerido IS NULL)
			BEGIN
				INSERT INTO DemandaTotalReemplazoSugerido(
				 CampaniaID
				,ConsultoraID
				,CUVOriginal
				,CUVSugerido
				,Aceptado
				,Cantidad
				,PrecioUnidad
				,Tipo
				,FechaProceso
				)
				VALUES
				(
				 @CampaniaID 
				 ,@ConsultoraID 
				 ,@CUVOriginal
				 ,@CUVSugerido
				 ,@Aceptado
				 ,@Cantidad
				 ,@PrecioUnidad
				 ,@Tipo
				 ,getdate())
			 END
		END
	END	
	ELSE
	BEGIN
		IF (@CUVSugerido IS NOT NULL)
		BEGIN
			UPDATE DemandaTotalReemplazoSugerido SET CUVSugerido = @CUVSugerido, Aceptado = 1, Cantidad = @Cantidad, PrecioUnidad = @PrecioUnidad, Tipo = @Tipo, FechaProceso = getdate() 
			WHERE CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL
		END
	END
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[InsDemandaTotalReemplazoSugerido]
(
@CampaniaID int,
@ConsultoraID int,
@CUVOriginal varchar(20),
@CUVSugerido varchar(20),
@Aceptado bit,
@Cantidad int,
@PrecioUnidad money
)
AS
BEGIN
	DECLARE @Tipo varchar(3) = 'FRS'
	if (@Aceptado = 1) set @Tipo = 'RSA'

	IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido = @CUVSugerido)
		BEGIN
			IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal AND @CUVSugerido IS NULL)
			BEGIN
				INSERT INTO DemandaTotalReemplazoSugerido(
				 CampaniaID
				,ConsultoraID
				,CUVOriginal
				,CUVSugerido
				,Aceptado
				,Cantidad
				,PrecioUnidad
				,Tipo
				,FechaProceso
				)
				VALUES
				(
				 @CampaniaID 
				 ,@ConsultoraID 
				 ,@CUVOriginal
				 ,@CUVSugerido
				 ,@Aceptado
				 ,@Cantidad
				 ,@PrecioUnidad
				 ,@Tipo
				 ,getdate())
			 END
		END
	END	
	ELSE
	BEGIN
		IF (@CUVSugerido IS NOT NULL)
		BEGIN
			UPDATE DemandaTotalReemplazoSugerido SET CUVSugerido = @CUVSugerido, Aceptado = 1, Cantidad = @Cantidad, PrecioUnidad = @PrecioUnidad, Tipo = @Tipo, FechaProceso = getdate() 
			WHERE CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL
		END
	END
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[InsDemandaTotalReemplazoSugerido]
(
@CampaniaID int,
@ConsultoraID int,
@CUVOriginal varchar(20),
@CUVSugerido varchar(20),
@Aceptado bit,
@Cantidad int,
@PrecioUnidad money
)
AS
BEGIN
	DECLARE @Tipo varchar(3) = 'FRS'
	if (@Aceptado = 1) set @Tipo = 'RSA'

	IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido = @CUVSugerido)
		BEGIN
			IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal AND @CUVSugerido IS NULL)
			BEGIN
				INSERT INTO DemandaTotalReemplazoSugerido(
				 CampaniaID
				,ConsultoraID
				,CUVOriginal
				,CUVSugerido
				,Aceptado
				,Cantidad
				,PrecioUnidad
				,Tipo
				,FechaProceso
				)
				VALUES
				(
				 @CampaniaID 
				 ,@ConsultoraID 
				 ,@CUVOriginal
				 ,@CUVSugerido
				 ,@Aceptado
				 ,@Cantidad
				 ,@PrecioUnidad
				 ,@Tipo
				 ,getdate())
			 END
		END
	END	
	ELSE
	BEGIN
		IF (@CUVSugerido IS NOT NULL)
		BEGIN
			UPDATE DemandaTotalReemplazoSugerido SET CUVSugerido = @CUVSugerido, Aceptado = 1, Cantidad = @Cantidad, PrecioUnidad = @PrecioUnidad, Tipo = @Tipo, FechaProceso = getdate() 
			WHERE CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL
		END
	END
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[InsDemandaTotalReemplazoSugerido]
(
@CampaniaID int,
@ConsultoraID int,
@CUVOriginal varchar(20),
@CUVSugerido varchar(20),
@Aceptado bit,
@Cantidad int,
@PrecioUnidad money
)
AS
BEGIN
	DECLARE @Tipo varchar(3) = 'FRS'
	if (@Aceptado = 1) set @Tipo = 'RSA'

	IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido = @CUVSugerido)
		BEGIN
			IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal AND @CUVSugerido IS NULL)
			BEGIN
				INSERT INTO DemandaTotalReemplazoSugerido(
				 CampaniaID
				,ConsultoraID
				,CUVOriginal
				,CUVSugerido
				,Aceptado
				,Cantidad
				,PrecioUnidad
				,Tipo
				,FechaProceso
				)
				VALUES
				(
				 @CampaniaID 
				 ,@ConsultoraID 
				 ,@CUVOriginal
				 ,@CUVSugerido
				 ,@Aceptado
				 ,@Cantidad
				 ,@PrecioUnidad
				 ,@Tipo
				 ,getdate())
			 END
		END
	END	
	ELSE
	BEGIN
		IF (@CUVSugerido IS NOT NULL)
		BEGIN
			UPDATE DemandaTotalReemplazoSugerido SET CUVSugerido = @CUVSugerido, Aceptado = 1, Cantidad = @Cantidad, PrecioUnidad = @PrecioUnidad, Tipo = @Tipo, FechaProceso = getdate() 
			WHERE CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL
		END
	END
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[InsDemandaTotalReemplazoSugerido]
(
@CampaniaID int,
@ConsultoraID int,
@CUVOriginal varchar(20),
@CUVSugerido varchar(20),
@Aceptado bit,
@Cantidad int,
@PrecioUnidad money
)
AS
BEGIN
	DECLARE @Tipo varchar(3) = 'FRS'
	if (@Aceptado = 1) set @Tipo = 'RSA'

	IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido = @CUVSugerido)
		BEGIN
			IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal AND @CUVSugerido IS NULL)
			BEGIN
				INSERT INTO DemandaTotalReemplazoSugerido(
				 CampaniaID
				,ConsultoraID
				,CUVOriginal
				,CUVSugerido
				,Aceptado
				,Cantidad
				,PrecioUnidad
				,Tipo
				,FechaProceso
				)
				VALUES
				(
				 @CampaniaID 
				 ,@ConsultoraID 
				 ,@CUVOriginal
				 ,@CUVSugerido
				 ,@Aceptado
				 ,@Cantidad
				 ,@PrecioUnidad
				 ,@Tipo
				 ,getdate())
			 END
		END
	END	
	ELSE
	BEGIN
		IF (@CUVSugerido IS NOT NULL)
		BEGIN
			UPDATE DemandaTotalReemplazoSugerido SET CUVSugerido = @CUVSugerido, Aceptado = 1, Cantidad = @Cantidad, PrecioUnidad = @PrecioUnidad, Tipo = @Tipo, FechaProceso = getdate() 
			WHERE CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL
		END
	END
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[InsDemandaTotalReemplazoSugerido]
(
@CampaniaID int,
@ConsultoraID int,
@CUVOriginal varchar(20),
@CUVSugerido varchar(20),
@Aceptado bit,
@Cantidad int,
@PrecioUnidad money
)
AS
BEGIN
	DECLARE @Tipo varchar(3) = 'FRS'
	if (@Aceptado = 1) set @Tipo = 'RSA'

	IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido = @CUVSugerido)
		BEGIN
			IF NOT EXISTS (SELECT TOP 1 1 FROM DemandaTotalReemplazoSugerido WHERE CampaniaID = @CampaniaID 
				and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal AND @CUVSugerido IS NULL)
			BEGIN
				INSERT INTO DemandaTotalReemplazoSugerido(
				 CampaniaID
				,ConsultoraID
				,CUVOriginal
				,CUVSugerido
				,Aceptado
				,Cantidad
				,PrecioUnidad
				,Tipo
				,FechaProceso
				)
				VALUES
				(
				 @CampaniaID 
				 ,@ConsultoraID 
				 ,@CUVOriginal
				 ,@CUVSugerido
				 ,@Aceptado
				 ,@Cantidad
				 ,@PrecioUnidad
				 ,@Tipo
				 ,getdate())
			 END
		END
	END	
	ELSE
	BEGIN
		IF (@CUVSugerido IS NOT NULL)
		BEGIN
			UPDATE DemandaTotalReemplazoSugerido SET CUVSugerido = @CUVSugerido, Aceptado = 1, Cantidad = @Cantidad, PrecioUnidad = @PrecioUnidad, Tipo = @Tipo, FechaProceso = getdate() 
			WHERE CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID and CUVOriginal = @CUVOriginal and CUVSugerido IS NULL
		END
	END
END
GO