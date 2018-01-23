
USE BelcorpPeru
GO

IF EXISTS (select 1 from sys.objects where type = 'U' and name = 'Horario')
BEGIN
	IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
	BEGIN	
		DECLARE @HorarioId int
		--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
		SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

		/*ELIMINANDO DETALLE*/
		DELETE FROM HorarioDetalle where HorarioId = @HorarioId
		/*ELIMINANDO CABECERA*/
		DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
	END
END

GO

USE BelcorpMexico
GO

IF EXISTS (select 1 from sys.objects where type = 'U' and name = 'Horario')
BEGIN
	IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
	BEGIN	
		DECLARE @HorarioId int
		--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
		SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

		/*ELIMINANDO DETALLE*/
		DELETE FROM HorarioDetalle where HorarioId = @HorarioId
		/*ELIMINANDO CABECERA*/
		DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
	END
END
GO

USE BelcorpColombia
GO

IF EXISTS (select 1 from sys.objects where type = 'U' and name = 'Horario')
BEGIN
	IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
	BEGIN	
		DECLARE @HorarioId int
		--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
		SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

		/*ELIMINANDO DETALLE*/
		DELETE FROM HorarioDetalle where HorarioId = @HorarioId
		/*ELIMINANDO CABECERA*/
		DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
	END
END
GO

USE BelcorpVenezuela
GO

IF EXISTS (select 1 from sys.objects where type = 'U' and name = 'Horario')
BEGIN
	IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
	BEGIN	
		DECLARE @HorarioId int
		--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
		SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

		/*ELIMINANDO DETALLE*/
		DELETE FROM HorarioDetalle where HorarioId = @HorarioId
		/*ELIMINANDO CABECERA*/
		DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
	END
END
GO

USE BelcorpSalvador
GO

IF EXISTS (select 1 from sys.objects where type = 'U' and name = 'Horario')
BEGIN
	IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
	BEGIN	
		DECLARE @HorarioId int
		--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
		SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

		/*ELIMINANDO DETALLE*/
		DELETE FROM HorarioDetalle where HorarioId = @HorarioId
		/*ELIMINANDO CABECERA*/
		DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
	END
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (select 1 from sys.objects where type = 'U' and name = 'Horario')
BEGIN
	IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
	BEGIN	
		DECLARE @HorarioId int
		--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
		SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

		/*ELIMINANDO DETALLE*/
		DELETE FROM HorarioDetalle where HorarioId = @HorarioId
		/*ELIMINANDO CABECERA*/
		DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
	END
END
GO

USE BelcorpPanama
GO

IF EXISTS (select 1 from sys.objects where type = 'U' and name = 'Horario')
BEGIN
	IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
	BEGIN	
		DECLARE @HorarioId int
		--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
		SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

		/*ELIMINANDO DETALLE*/
		DELETE FROM HorarioDetalle where HorarioId = @HorarioId
		/*ELIMINANDO CABECERA*/
		DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
	END
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (select 1 from sys.objects where type = 'U' and name = 'Horario')
BEGIN
	IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
	BEGIN	
		DECLARE @HorarioId int
		--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
		SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

		/*ELIMINANDO DETALLE*/
		DELETE FROM HorarioDetalle where HorarioId = @HorarioId
		/*ELIMINANDO CABECERA*/
		DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
	END
END
GO

USE BelcorpEcuador
GO

IF EXISTS (select 1 from sys.objects where type = 'U' and name = 'Horario')
BEGIN
	IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
	BEGIN	
		DECLARE @HorarioId int
		--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
		SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

		/*ELIMINANDO DETALLE*/
		DELETE FROM HorarioDetalle where HorarioId = @HorarioId
		/*ELIMINANDO CABECERA*/
		DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
	END
END
GO

USE BelcorpDominicana
GO

IF EXISTS (select 1 from sys.objects where type = 'U' and name = 'Horario')
BEGIN
	IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
	BEGIN	
		DECLARE @HorarioId int
		--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
		SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

		/*ELIMINANDO DETALLE*/
		DELETE FROM HorarioDetalle where HorarioId = @HorarioId
		/*ELIMINANDO CABECERA*/
		DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
	END
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (select 1 from sys.objects where type = 'U' and name = 'Horario')
BEGIN
	IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
	BEGIN	
		DECLARE @HorarioId int
		--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
		SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

		/*ELIMINANDO DETALLE*/
		DELETE FROM HorarioDetalle where HorarioId = @HorarioId
		/*ELIMINANDO CABECERA*/
		DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
	END
END
GO

USE BelcorpChile
GO

IF EXISTS (select 1 from sys.objects where type = 'U' and name = 'Horario')
BEGIN
	IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
	BEGIN	
		DECLARE @HorarioId int
		--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
		SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

		/*ELIMINANDO DETALLE*/
		DELETE FROM HorarioDetalle where HorarioId = @HorarioId
		/*ELIMINANDO CABECERA*/
		DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
	END
END
GO

USE BelcorpBolivia
GO

IF EXISTS (select 1 from sys.objects where type = 'U' and name = 'Horario')
BEGIN
	IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
	BEGIN	
		DECLARE @HorarioId int
		--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
		SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

		/*ELIMINANDO DETALLE*/
		DELETE FROM HorarioDetalle where HorarioId = @HorarioId
		/*ELIMINANDO CABECERA*/
		DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
	END
END
GO

