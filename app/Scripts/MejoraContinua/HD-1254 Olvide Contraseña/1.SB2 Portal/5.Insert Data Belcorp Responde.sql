USE BelcorpPeru
GO

DECLARE @HorarioId int = 0
IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END

/*INSERTANDO CABECERA*/ 
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*INSERTANDO DETALLE*/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000')
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpMexico
GO

DECLARE @HorarioId int = 0
IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END

/*INSERTANDO CABECERA*/ 
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*INSERTANDO DETALLE*/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000')
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpColombia
GO

DECLARE @HorarioId int = 0
IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END

/*INSERTANDO CABECERA*/ 
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*INSERTANDO DETALLE*/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000')
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpVenezuela
GO

DECLARE @HorarioId int = 0
IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END

/*INSERTANDO CABECERA*/ 
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*INSERTANDO DETALLE*/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000')
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpSalvador
GO

DECLARE @HorarioId int = 0
IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END

/*INSERTANDO CABECERA*/ 
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*INSERTANDO DETALLE*/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000')
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpPuertoRico
GO

DECLARE @HorarioId int = 0
IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END

/*INSERTANDO CABECERA*/ 
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*INSERTANDO DETALLE*/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000')
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpPanama
GO

DECLARE @HorarioId int = 0
IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END

/*INSERTANDO CABECERA*/ 
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*INSERTANDO DETALLE*/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000')
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpGuatemala
GO

DECLARE @HorarioId int = 0
IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END

/*INSERTANDO CABECERA*/ 
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*INSERTANDO DETALLE*/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000')
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpEcuador
GO

DECLARE @HorarioId int = 0
IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END

/*INSERTANDO CABECERA*/ 
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*INSERTANDO DETALLE*/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000')
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpDominicana
GO

DECLARE @HorarioId int = 0
IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END

/*INSERTANDO CABECERA*/ 
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*INSERTANDO DETALLE*/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000')
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpCostaRica
GO

DECLARE @HorarioId int = 0
IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END

/*INSERTANDO CABECERA*/ 
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*INSERTANDO DETALLE*/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000')
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpChile
GO

DECLARE @HorarioId int = 0
IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END

/*INSERTANDO CABECERA*/ 
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*INSERTANDO DETALLE*/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000')
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpBolivia
GO

DECLARE @HorarioId int = 0
IF EXISTS (SELECT 1 FROM Horario WHERE Codigo = 'BelcorpResponde')
BEGIN	
	--> El texto 'BelcorpResponde' puede variar, se debe revisar antes el texto existente.
	SELECT @HorarioId = isnull(HorarioId,0) FROM Horario WHERE Codigo = 'BelcorpResponde' 

	/*ELIMINANDO DETALLE*/
	DELETE FROM HorarioDetalle where HorarioId = @HorarioId
	/*ELIMINANDO CABECERA*/
	DELETE FROM Horario WHERE Codigo = 'BelcorpResponde'
END

/*INSERTANDO CABECERA*/ 
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*INSERTANDO DETALLE*/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000')
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO


