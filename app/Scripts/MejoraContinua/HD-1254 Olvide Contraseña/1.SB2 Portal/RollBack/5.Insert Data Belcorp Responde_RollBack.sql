USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END
GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END
GO

