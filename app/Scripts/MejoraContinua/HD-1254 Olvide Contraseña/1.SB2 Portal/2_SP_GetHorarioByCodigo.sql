USE BelcorpPeru
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetHorarioByCodigo' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetHorarioByCodigo
END
GO
CREATE PROCEDURE dbo.GetHorarioByCodigo
	@Codigo varchar(50)
AS
BEGIN
	select top 1
		HorarioId,
		Codigo,
		Resumen,
		PrimerDiaSemana,
		HoraISO,
		HoraIncluyente
	from Horario
	where Codigo = @Codigo;
END
GO

USE BelcorpMexico
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetHorarioByCodigo' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetHorarioByCodigo
END
GO
CREATE PROCEDURE dbo.GetHorarioByCodigo
	@Codigo varchar(50)
AS
BEGIN
	select top 1
		HorarioId,
		Codigo,
		Resumen,
		PrimerDiaSemana,
		HoraISO,
		HoraIncluyente
	from Horario
	where Codigo = @Codigo;
END
GO

USE BelcorpColombia
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetHorarioByCodigo' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetHorarioByCodigo
END
GO
CREATE PROCEDURE dbo.GetHorarioByCodigo
	@Codigo varchar(50)
AS
BEGIN
	select top 1
		HorarioId,
		Codigo,
		Resumen,
		PrimerDiaSemana,
		HoraISO,
		HoraIncluyente
	from Horario
	where Codigo = @Codigo;
END
GO

USE BelcorpVenezuela
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetHorarioByCodigo' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetHorarioByCodigo
END
GO
CREATE PROCEDURE dbo.GetHorarioByCodigo
	@Codigo varchar(50)
AS
BEGIN
	select top 1
		HorarioId,
		Codigo,
		Resumen,
		PrimerDiaSemana,
		HoraISO,
		HoraIncluyente
	from Horario
	where Codigo = @Codigo;
END
GO

USE BelcorpSalvador
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetHorarioByCodigo' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetHorarioByCodigo
END
GO
CREATE PROCEDURE dbo.GetHorarioByCodigo
	@Codigo varchar(50)
AS
BEGIN
	select top 1
		HorarioId,
		Codigo,
		Resumen,
		PrimerDiaSemana,
		HoraISO,
		HoraIncluyente
	from Horario
	where Codigo = @Codigo;
END
GO

USE BelcorpPuertoRico
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetHorarioByCodigo' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetHorarioByCodigo
END
GO
CREATE PROCEDURE dbo.GetHorarioByCodigo
	@Codigo varchar(50)
AS
BEGIN
	select top 1
		HorarioId,
		Codigo,
		Resumen,
		PrimerDiaSemana,
		HoraISO,
		HoraIncluyente
	from Horario
	where Codigo = @Codigo;
END
GO

USE BelcorpPanama
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetHorarioByCodigo' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetHorarioByCodigo
END
GO
CREATE PROCEDURE dbo.GetHorarioByCodigo
	@Codigo varchar(50)
AS
BEGIN
	select top 1
		HorarioId,
		Codigo,
		Resumen,
		PrimerDiaSemana,
		HoraISO,
		HoraIncluyente
	from Horario
	where Codigo = @Codigo;
END
GO

USE BelcorpGuatemala
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetHorarioByCodigo' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetHorarioByCodigo
END
GO
CREATE PROCEDURE dbo.GetHorarioByCodigo
	@Codigo varchar(50)
AS
BEGIN
	select top 1
		HorarioId,
		Codigo,
		Resumen,
		PrimerDiaSemana,
		HoraISO,
		HoraIncluyente
	from Horario
	where Codigo = @Codigo;
END
GO

USE BelcorpEcuador
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetHorarioByCodigo' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetHorarioByCodigo
END
GO
CREATE PROCEDURE dbo.GetHorarioByCodigo
	@Codigo varchar(50)
AS
BEGIN
	select top 1
		HorarioId,
		Codigo,
		Resumen,
		PrimerDiaSemana,
		HoraISO,
		HoraIncluyente
	from Horario
	where Codigo = @Codigo;
END
GO

USE BelcorpDominicana
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetHorarioByCodigo' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetHorarioByCodigo
END
GO
CREATE PROCEDURE dbo.GetHorarioByCodigo
	@Codigo varchar(50)
AS
BEGIN
	select top 1
		HorarioId,
		Codigo,
		Resumen,
		PrimerDiaSemana,
		HoraISO,
		HoraIncluyente
	from Horario
	where Codigo = @Codigo;
END
GO

USE BelcorpCostaRica
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetHorarioByCodigo' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetHorarioByCodigo
END
GO
CREATE PROCEDURE dbo.GetHorarioByCodigo
	@Codigo varchar(50)
AS
BEGIN
	select top 1
		HorarioId,
		Codigo,
		Resumen,
		PrimerDiaSemana,
		HoraISO,
		HoraIncluyente
	from Horario
	where Codigo = @Codigo;
END
GO

USE BelcorpChile
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetHorarioByCodigo' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetHorarioByCodigo
END
GO
CREATE PROCEDURE dbo.GetHorarioByCodigo
	@Codigo varchar(50)
AS
BEGIN
	select top 1
		HorarioId,
		Codigo,
		Resumen,
		PrimerDiaSemana,
		HoraISO,
		HoraIncluyente
	from Horario
	where Codigo = @Codigo;
END
GO

USE BelcorpBolivia
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetHorarioByCodigo' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetHorarioByCodigo
END
GO
CREATE PROCEDURE dbo.GetHorarioByCodigo
	@Codigo varchar(50)
AS
BEGIN
	select top 1
		HorarioId,
		Codigo,
		Resumen,
		PrimerDiaSemana,
		HoraISO,
		HoraIncluyente
	from Horario
	where Codigo = @Codigo;
END
GO

