USE BelcorpPeru
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsDemandaTotalReemplazoSugerido')
BEGIN
	DROP PROCEDURE InsDemandaTotalReemplazoSugerido
END
GO
CREATE PROCEDURE InsDemandaTotalReemplazoSugerido
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

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsDemandaTotalReemplazoSugerido')
BEGIN
	DROP PROCEDURE InsDemandaTotalReemplazoSugerido
END
GO
CREATE PROCEDURE InsDemandaTotalReemplazoSugerido
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

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsDemandaTotalReemplazoSugerido')
BEGIN
	DROP PROCEDURE InsDemandaTotalReemplazoSugerido
END
GO
CREATE PROCEDURE InsDemandaTotalReemplazoSugerido
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

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsDemandaTotalReemplazoSugerido')
BEGIN
	DROP PROCEDURE InsDemandaTotalReemplazoSugerido
END
GO
CREATE PROCEDURE InsDemandaTotalReemplazoSugerido
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

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsDemandaTotalReemplazoSugerido')
BEGIN
	DROP PROCEDURE InsDemandaTotalReemplazoSugerido
END
GO
CREATE PROCEDURE InsDemandaTotalReemplazoSugerido
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

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsDemandaTotalReemplazoSugerido')
BEGIN
	DROP PROCEDURE InsDemandaTotalReemplazoSugerido
END
GO
CREATE PROCEDURE InsDemandaTotalReemplazoSugerido
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

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsDemandaTotalReemplazoSugerido')
BEGIN
	DROP PROCEDURE InsDemandaTotalReemplazoSugerido
END
GO
CREATE PROCEDURE InsDemandaTotalReemplazoSugerido
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

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsDemandaTotalReemplazoSugerido')
BEGIN
	DROP PROCEDURE InsDemandaTotalReemplazoSugerido
END
GO
CREATE PROCEDURE InsDemandaTotalReemplazoSugerido
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

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsDemandaTotalReemplazoSugerido')
BEGIN
	DROP PROCEDURE InsDemandaTotalReemplazoSugerido
END
GO
CREATE PROCEDURE InsDemandaTotalReemplazoSugerido
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

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsDemandaTotalReemplazoSugerido')
BEGIN
	DROP PROCEDURE InsDemandaTotalReemplazoSugerido
END
GO
CREATE PROCEDURE InsDemandaTotalReemplazoSugerido
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

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsDemandaTotalReemplazoSugerido')
BEGIN
	DROP PROCEDURE InsDemandaTotalReemplazoSugerido
END
GO
CREATE PROCEDURE InsDemandaTotalReemplazoSugerido
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

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsDemandaTotalReemplazoSugerido')
BEGIN
	DROP PROCEDURE InsDemandaTotalReemplazoSugerido
END
GO
CREATE PROCEDURE InsDemandaTotalReemplazoSugerido
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

