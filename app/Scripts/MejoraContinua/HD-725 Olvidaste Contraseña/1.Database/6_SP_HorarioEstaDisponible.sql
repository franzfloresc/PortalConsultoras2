USE BelcorpPeru
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'HorarioEstaDisponible' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.HorarioEstaDisponible
END
GO
CREATE PROCEDURE dbo.HorarioEstaDisponible
	@CodigoHorario varchar(50)
AS
BEGIN
	declare @EstaDisponible bit = 0;
	declare @HorarioId int = 0;
	declare @PrimerDiaSemana tinyint;
	declare @HoraISO bit;
	declare @HoraIncluyente bit;

	select top 1
		@HorarioId = HorarioId,
		@PrimerDiaSemana = PrimerDiaSemana,
		@HoraISO = HoraISO,
		@HoraIncluyente = HoraIncluyente
	from Horario
	where Codigo = @CodigoHorario;
	
	if @HorarioId <> 0
	begin
		set datefirst @PrimerDiaSemana;
		declare @Hoy datetime = iif(@HoraISO = 1, dbo.fnObtenerFechaHoraPais(), getdate());
		declare @DiaSemanaActual tinyint = datepart(dw, @Hoy);
		declare @HoraActual time = cast(@Hoy as time);
		set @HoraActual = dateadd(ms, -DATEPART(ms, @HoraActual), @HoraActual);
		set @HoraActual = dateadd(s, -DATEPART(s, @HoraActual), @HoraActual);

		set @EstaDisponible = iif(exists(
				select 1
				from HorarioDetalle
				where
					HorarioId = @HorarioId and
					(@DiaSemanaActual between DiaSemanaInicio and DiaSemanaFin) and
					(case @HoraIncluyente
						when 1 then iif(@HoraActual between HoraInicio and HoraFin, 1, 0)
						else iif(HoraInicio < @HoraActual and @HoraActual < HoraFin, 1, 0)
					end) = 1
			), 1, 0);
	end

	select @EstaDisponible;
END
GO

USE BelcorpMexico
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'HorarioEstaDisponible' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.HorarioEstaDisponible
END
GO
CREATE PROCEDURE dbo.HorarioEstaDisponible
	@CodigoHorario varchar(50)
AS
BEGIN
	declare @EstaDisponible bit = 0;
	declare @HorarioId int = 0;
	declare @PrimerDiaSemana tinyint;
	declare @HoraISO bit;
	declare @HoraIncluyente bit;

	select top 1
		@HorarioId = HorarioId,
		@PrimerDiaSemana = PrimerDiaSemana,
		@HoraISO = HoraISO,
		@HoraIncluyente = HoraIncluyente
	from Horario
	where Codigo = @CodigoHorario;
	
	if @HorarioId <> 0
	begin
		set datefirst @PrimerDiaSemana;
		declare @Hoy datetime = iif(@HoraISO = 1, dbo.fnObtenerFechaHoraPais(), getdate());
		declare @DiaSemanaActual tinyint = datepart(dw, @Hoy);
		declare @HoraActual time = cast(@Hoy as time);
		set @HoraActual = dateadd(ms, -DATEPART(ms, @HoraActual), @HoraActual);
		set @HoraActual = dateadd(s, -DATEPART(s, @HoraActual), @HoraActual);

		set @EstaDisponible = iif(exists(
				select 1
				from HorarioDetalle
				where
					HorarioId = @HorarioId and
					(@DiaSemanaActual between DiaSemanaInicio and DiaSemanaFin) and
					(case @HoraIncluyente
						when 1 then iif(@HoraActual between HoraInicio and HoraFin, 1, 0)
						else iif(HoraInicio < @HoraActual and @HoraActual < HoraFin, 1, 0)
					end) = 1
			), 1, 0);
	end

	select @EstaDisponible;
END
GO

USE BelcorpColombia
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'HorarioEstaDisponible' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.HorarioEstaDisponible
END
GO
CREATE PROCEDURE dbo.HorarioEstaDisponible
	@CodigoHorario varchar(50)
AS
BEGIN
	declare @EstaDisponible bit = 0;
	declare @HorarioId int = 0;
	declare @PrimerDiaSemana tinyint;
	declare @HoraISO bit;
	declare @HoraIncluyente bit;

	select top 1
		@HorarioId = HorarioId,
		@PrimerDiaSemana = PrimerDiaSemana,
		@HoraISO = HoraISO,
		@HoraIncluyente = HoraIncluyente
	from Horario
	where Codigo = @CodigoHorario;
	
	if @HorarioId <> 0
	begin
		set datefirst @PrimerDiaSemana;
		declare @Hoy datetime = iif(@HoraISO = 1, dbo.fnObtenerFechaHoraPais(), getdate());
		declare @DiaSemanaActual tinyint = datepart(dw, @Hoy);
		declare @HoraActual time = cast(@Hoy as time);
		set @HoraActual = dateadd(ms, -DATEPART(ms, @HoraActual), @HoraActual);
		set @HoraActual = dateadd(s, -DATEPART(s, @HoraActual), @HoraActual);

		set @EstaDisponible = iif(exists(
				select 1
				from HorarioDetalle
				where
					HorarioId = @HorarioId and
					(@DiaSemanaActual between DiaSemanaInicio and DiaSemanaFin) and
					(case @HoraIncluyente
						when 1 then iif(@HoraActual between HoraInicio and HoraFin, 1, 0)
						else iif(HoraInicio < @HoraActual and @HoraActual < HoraFin, 1, 0)
					end) = 1
			), 1, 0);
	end

	select @EstaDisponible;
END
GO

USE BelcorpVenezuela
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'HorarioEstaDisponible' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.HorarioEstaDisponible
END
GO
CREATE PROCEDURE dbo.HorarioEstaDisponible
	@CodigoHorario varchar(50)
AS
BEGIN
	declare @EstaDisponible bit = 0;
	declare @HorarioId int = 0;
	declare @PrimerDiaSemana tinyint;
	declare @HoraISO bit;
	declare @HoraIncluyente bit;

	select top 1
		@HorarioId = HorarioId,
		@PrimerDiaSemana = PrimerDiaSemana,
		@HoraISO = HoraISO,
		@HoraIncluyente = HoraIncluyente
	from Horario
	where Codigo = @CodigoHorario;
	
	if @HorarioId <> 0
	begin
		set datefirst @PrimerDiaSemana;
		declare @Hoy datetime = iif(@HoraISO = 1, dbo.fnObtenerFechaHoraPais(), getdate());
		declare @DiaSemanaActual tinyint = datepart(dw, @Hoy);
		declare @HoraActual time = cast(@Hoy as time);
		set @HoraActual = dateadd(ms, -DATEPART(ms, @HoraActual), @HoraActual);
		set @HoraActual = dateadd(s, -DATEPART(s, @HoraActual), @HoraActual);

		set @EstaDisponible = iif(exists(
				select 1
				from HorarioDetalle
				where
					HorarioId = @HorarioId and
					(@DiaSemanaActual between DiaSemanaInicio and DiaSemanaFin) and
					(case @HoraIncluyente
						when 1 then iif(@HoraActual between HoraInicio and HoraFin, 1, 0)
						else iif(HoraInicio < @HoraActual and @HoraActual < HoraFin, 1, 0)
					end) = 1
			), 1, 0);
	end

	select @EstaDisponible;
END
GO

USE BelcorpSalvador
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'HorarioEstaDisponible' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.HorarioEstaDisponible
END
GO
CREATE PROCEDURE dbo.HorarioEstaDisponible
	@CodigoHorario varchar(50)
AS
BEGIN
	declare @EstaDisponible bit = 0;
	declare @HorarioId int = 0;
	declare @PrimerDiaSemana tinyint;
	declare @HoraISO bit;
	declare @HoraIncluyente bit;

	select top 1
		@HorarioId = HorarioId,
		@PrimerDiaSemana = PrimerDiaSemana,
		@HoraISO = HoraISO,
		@HoraIncluyente = HoraIncluyente
	from Horario
	where Codigo = @CodigoHorario;
	
	if @HorarioId <> 0
	begin
		set datefirst @PrimerDiaSemana;
		declare @Hoy datetime = iif(@HoraISO = 1, dbo.fnObtenerFechaHoraPais(), getdate());
		declare @DiaSemanaActual tinyint = datepart(dw, @Hoy);
		declare @HoraActual time = cast(@Hoy as time);
		set @HoraActual = dateadd(ms, -DATEPART(ms, @HoraActual), @HoraActual);
		set @HoraActual = dateadd(s, -DATEPART(s, @HoraActual), @HoraActual);

		set @EstaDisponible = iif(exists(
				select 1
				from HorarioDetalle
				where
					HorarioId = @HorarioId and
					(@DiaSemanaActual between DiaSemanaInicio and DiaSemanaFin) and
					(case @HoraIncluyente
						when 1 then iif(@HoraActual between HoraInicio and HoraFin, 1, 0)
						else iif(HoraInicio < @HoraActual and @HoraActual < HoraFin, 1, 0)
					end) = 1
			), 1, 0);
	end

	select @EstaDisponible;
END
GO

USE BelcorpPuertoRico
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'HorarioEstaDisponible' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.HorarioEstaDisponible
END
GO
CREATE PROCEDURE dbo.HorarioEstaDisponible
	@CodigoHorario varchar(50)
AS
BEGIN
	declare @EstaDisponible bit = 0;
	declare @HorarioId int = 0;
	declare @PrimerDiaSemana tinyint;
	declare @HoraISO bit;
	declare @HoraIncluyente bit;

	select top 1
		@HorarioId = HorarioId,
		@PrimerDiaSemana = PrimerDiaSemana,
		@HoraISO = HoraISO,
		@HoraIncluyente = HoraIncluyente
	from Horario
	where Codigo = @CodigoHorario;
	
	if @HorarioId <> 0
	begin
		set datefirst @PrimerDiaSemana;
		declare @Hoy datetime = iif(@HoraISO = 1, dbo.fnObtenerFechaHoraPais(), getdate());
		declare @DiaSemanaActual tinyint = datepart(dw, @Hoy);
		declare @HoraActual time = cast(@Hoy as time);
		set @HoraActual = dateadd(ms, -DATEPART(ms, @HoraActual), @HoraActual);
		set @HoraActual = dateadd(s, -DATEPART(s, @HoraActual), @HoraActual);

		set @EstaDisponible = iif(exists(
				select 1
				from HorarioDetalle
				where
					HorarioId = @HorarioId and
					(@DiaSemanaActual between DiaSemanaInicio and DiaSemanaFin) and
					(case @HoraIncluyente
						when 1 then iif(@HoraActual between HoraInicio and HoraFin, 1, 0)
						else iif(HoraInicio < @HoraActual and @HoraActual < HoraFin, 1, 0)
					end) = 1
			), 1, 0);
	end

	select @EstaDisponible;
END
GO

USE BelcorpPanama
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'HorarioEstaDisponible' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.HorarioEstaDisponible
END
GO
CREATE PROCEDURE dbo.HorarioEstaDisponible
	@CodigoHorario varchar(50)
AS
BEGIN
	declare @EstaDisponible bit = 0;
	declare @HorarioId int = 0;
	declare @PrimerDiaSemana tinyint;
	declare @HoraISO bit;
	declare @HoraIncluyente bit;

	select top 1
		@HorarioId = HorarioId,
		@PrimerDiaSemana = PrimerDiaSemana,
		@HoraISO = HoraISO,
		@HoraIncluyente = HoraIncluyente
	from Horario
	where Codigo = @CodigoHorario;
	
	if @HorarioId <> 0
	begin
		set datefirst @PrimerDiaSemana;
		declare @Hoy datetime = iif(@HoraISO = 1, dbo.fnObtenerFechaHoraPais(), getdate());
		declare @DiaSemanaActual tinyint = datepart(dw, @Hoy);
		declare @HoraActual time = cast(@Hoy as time);
		set @HoraActual = dateadd(ms, -DATEPART(ms, @HoraActual), @HoraActual);
		set @HoraActual = dateadd(s, -DATEPART(s, @HoraActual), @HoraActual);

		set @EstaDisponible = iif(exists(
				select 1
				from HorarioDetalle
				where
					HorarioId = @HorarioId and
					(@DiaSemanaActual between DiaSemanaInicio and DiaSemanaFin) and
					(case @HoraIncluyente
						when 1 then iif(@HoraActual between HoraInicio and HoraFin, 1, 0)
						else iif(HoraInicio < @HoraActual and @HoraActual < HoraFin, 1, 0)
					end) = 1
			), 1, 0);
	end

	select @EstaDisponible;
END
GO

USE BelcorpGuatemala
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'HorarioEstaDisponible' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.HorarioEstaDisponible
END
GO
CREATE PROCEDURE dbo.HorarioEstaDisponible
	@CodigoHorario varchar(50)
AS
BEGIN
	declare @EstaDisponible bit = 0;
	declare @HorarioId int = 0;
	declare @PrimerDiaSemana tinyint;
	declare @HoraISO bit;
	declare @HoraIncluyente bit;

	select top 1
		@HorarioId = HorarioId,
		@PrimerDiaSemana = PrimerDiaSemana,
		@HoraISO = HoraISO,
		@HoraIncluyente = HoraIncluyente
	from Horario
	where Codigo = @CodigoHorario;
	
	if @HorarioId <> 0
	begin
		set datefirst @PrimerDiaSemana;
		declare @Hoy datetime = iif(@HoraISO = 1, dbo.fnObtenerFechaHoraPais(), getdate());
		declare @DiaSemanaActual tinyint = datepart(dw, @Hoy);
		declare @HoraActual time = cast(@Hoy as time);
		set @HoraActual = dateadd(ms, -DATEPART(ms, @HoraActual), @HoraActual);
		set @HoraActual = dateadd(s, -DATEPART(s, @HoraActual), @HoraActual);

		set @EstaDisponible = iif(exists(
				select 1
				from HorarioDetalle
				where
					HorarioId = @HorarioId and
					(@DiaSemanaActual between DiaSemanaInicio and DiaSemanaFin) and
					(case @HoraIncluyente
						when 1 then iif(@HoraActual between HoraInicio and HoraFin, 1, 0)
						else iif(HoraInicio < @HoraActual and @HoraActual < HoraFin, 1, 0)
					end) = 1
			), 1, 0);
	end

	select @EstaDisponible;
END
GO

USE BelcorpEcuador
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'HorarioEstaDisponible' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.HorarioEstaDisponible
END
GO
CREATE PROCEDURE dbo.HorarioEstaDisponible
	@CodigoHorario varchar(50)
AS
BEGIN
	declare @EstaDisponible bit = 0;
	declare @HorarioId int = 0;
	declare @PrimerDiaSemana tinyint;
	declare @HoraISO bit;
	declare @HoraIncluyente bit;

	select top 1
		@HorarioId = HorarioId,
		@PrimerDiaSemana = PrimerDiaSemana,
		@HoraISO = HoraISO,
		@HoraIncluyente = HoraIncluyente
	from Horario
	where Codigo = @CodigoHorario;
	
	if @HorarioId <> 0
	begin
		set datefirst @PrimerDiaSemana;
		declare @Hoy datetime = iif(@HoraISO = 1, dbo.fnObtenerFechaHoraPais(), getdate());
		declare @DiaSemanaActual tinyint = datepart(dw, @Hoy);
		declare @HoraActual time = cast(@Hoy as time);
		set @HoraActual = dateadd(ms, -DATEPART(ms, @HoraActual), @HoraActual);
		set @HoraActual = dateadd(s, -DATEPART(s, @HoraActual), @HoraActual);

		set @EstaDisponible = iif(exists(
				select 1
				from HorarioDetalle
				where
					HorarioId = @HorarioId and
					(@DiaSemanaActual between DiaSemanaInicio and DiaSemanaFin) and
					(case @HoraIncluyente
						when 1 then iif(@HoraActual between HoraInicio and HoraFin, 1, 0)
						else iif(HoraInicio < @HoraActual and @HoraActual < HoraFin, 1, 0)
					end) = 1
			), 1, 0);
	end

	select @EstaDisponible;
END
GO

USE BelcorpDominicana
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'HorarioEstaDisponible' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.HorarioEstaDisponible
END
GO
CREATE PROCEDURE dbo.HorarioEstaDisponible
	@CodigoHorario varchar(50)
AS
BEGIN
	declare @EstaDisponible bit = 0;
	declare @HorarioId int = 0;
	declare @PrimerDiaSemana tinyint;
	declare @HoraISO bit;
	declare @HoraIncluyente bit;

	select top 1
		@HorarioId = HorarioId,
		@PrimerDiaSemana = PrimerDiaSemana,
		@HoraISO = HoraISO,
		@HoraIncluyente = HoraIncluyente
	from Horario
	where Codigo = @CodigoHorario;
	
	if @HorarioId <> 0
	begin
		set datefirst @PrimerDiaSemana;
		declare @Hoy datetime = iif(@HoraISO = 1, dbo.fnObtenerFechaHoraPais(), getdate());
		declare @DiaSemanaActual tinyint = datepart(dw, @Hoy);
		declare @HoraActual time = cast(@Hoy as time);
		set @HoraActual = dateadd(ms, -DATEPART(ms, @HoraActual), @HoraActual);
		set @HoraActual = dateadd(s, -DATEPART(s, @HoraActual), @HoraActual);

		set @EstaDisponible = iif(exists(
				select 1
				from HorarioDetalle
				where
					HorarioId = @HorarioId and
					(@DiaSemanaActual between DiaSemanaInicio and DiaSemanaFin) and
					(case @HoraIncluyente
						when 1 then iif(@HoraActual between HoraInicio and HoraFin, 1, 0)
						else iif(HoraInicio < @HoraActual and @HoraActual < HoraFin, 1, 0)
					end) = 1
			), 1, 0);
	end

	select @EstaDisponible;
END
GO

USE BelcorpCostaRica
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'HorarioEstaDisponible' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.HorarioEstaDisponible
END
GO
CREATE PROCEDURE dbo.HorarioEstaDisponible
	@CodigoHorario varchar(50)
AS
BEGIN
	declare @EstaDisponible bit = 0;
	declare @HorarioId int = 0;
	declare @PrimerDiaSemana tinyint;
	declare @HoraISO bit;
	declare @HoraIncluyente bit;

	select top 1
		@HorarioId = HorarioId,
		@PrimerDiaSemana = PrimerDiaSemana,
		@HoraISO = HoraISO,
		@HoraIncluyente = HoraIncluyente
	from Horario
	where Codigo = @CodigoHorario;
	
	if @HorarioId <> 0
	begin
		set datefirst @PrimerDiaSemana;
		declare @Hoy datetime = iif(@HoraISO = 1, dbo.fnObtenerFechaHoraPais(), getdate());
		declare @DiaSemanaActual tinyint = datepart(dw, @Hoy);
		declare @HoraActual time = cast(@Hoy as time);
		set @HoraActual = dateadd(ms, -DATEPART(ms, @HoraActual), @HoraActual);
		set @HoraActual = dateadd(s, -DATEPART(s, @HoraActual), @HoraActual);

		set @EstaDisponible = iif(exists(
				select 1
				from HorarioDetalle
				where
					HorarioId = @HorarioId and
					(@DiaSemanaActual between DiaSemanaInicio and DiaSemanaFin) and
					(case @HoraIncluyente
						when 1 then iif(@HoraActual between HoraInicio and HoraFin, 1, 0)
						else iif(HoraInicio < @HoraActual and @HoraActual < HoraFin, 1, 0)
					end) = 1
			), 1, 0);
	end

	select @EstaDisponible;
END
GO

USE BelcorpChile
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'HorarioEstaDisponible' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.HorarioEstaDisponible
END
GO
CREATE PROCEDURE dbo.HorarioEstaDisponible
	@CodigoHorario varchar(50)
AS
BEGIN
	declare @EstaDisponible bit = 0;
	declare @HorarioId int = 0;
	declare @PrimerDiaSemana tinyint;
	declare @HoraISO bit;
	declare @HoraIncluyente bit;

	select top 1
		@HorarioId = HorarioId,
		@PrimerDiaSemana = PrimerDiaSemana,
		@HoraISO = HoraISO,
		@HoraIncluyente = HoraIncluyente
	from Horario
	where Codigo = @CodigoHorario;
	
	if @HorarioId <> 0
	begin
		set datefirst @PrimerDiaSemana;
		declare @Hoy datetime = iif(@HoraISO = 1, dbo.fnObtenerFechaHoraPais(), getdate());
		declare @DiaSemanaActual tinyint = datepart(dw, @Hoy);
		declare @HoraActual time = cast(@Hoy as time);
		set @HoraActual = dateadd(ms, -DATEPART(ms, @HoraActual), @HoraActual);
		set @HoraActual = dateadd(s, -DATEPART(s, @HoraActual), @HoraActual);

		set @EstaDisponible = iif(exists(
				select 1
				from HorarioDetalle
				where
					HorarioId = @HorarioId and
					(@DiaSemanaActual between DiaSemanaInicio and DiaSemanaFin) and
					(case @HoraIncluyente
						when 1 then iif(@HoraActual between HoraInicio and HoraFin, 1, 0)
						else iif(HoraInicio < @HoraActual and @HoraActual < HoraFin, 1, 0)
					end) = 1
			), 1, 0);
	end

	select @EstaDisponible;
END
GO

USE BelcorpBolivia
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'HorarioEstaDisponible' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.HorarioEstaDisponible
END
GO
CREATE PROCEDURE dbo.HorarioEstaDisponible
	@CodigoHorario varchar(50)
AS
BEGIN
	declare @EstaDisponible bit = 0;
	declare @HorarioId int = 0;
	declare @PrimerDiaSemana tinyint;
	declare @HoraISO bit;
	declare @HoraIncluyente bit;

	select top 1
		@HorarioId = HorarioId,
		@PrimerDiaSemana = PrimerDiaSemana,
		@HoraISO = HoraISO,
		@HoraIncluyente = HoraIncluyente
	from Horario
	where Codigo = @CodigoHorario;
	
	if @HorarioId <> 0
	begin
		set datefirst @PrimerDiaSemana;
		declare @Hoy datetime = iif(@HoraISO = 1, dbo.fnObtenerFechaHoraPais(), getdate());
		declare @DiaSemanaActual tinyint = datepart(dw, @Hoy);
		declare @HoraActual time = cast(@Hoy as time);
		set @HoraActual = dateadd(ms, -DATEPART(ms, @HoraActual), @HoraActual);
		set @HoraActual = dateadd(s, -DATEPART(s, @HoraActual), @HoraActual);

		set @EstaDisponible = iif(exists(
				select 1
				from HorarioDetalle
				where
					HorarioId = @HorarioId and
					(@DiaSemanaActual between DiaSemanaInicio and DiaSemanaFin) and
					(case @HoraIncluyente
						when 1 then iif(@HoraActual between HoraInicio and HoraFin, 1, 0)
						else iif(HoraInicio < @HoraActual and @HoraActual < HoraFin, 1, 0)
					end) = 1
			), 1, 0);
	end

	select @EstaDisponible;
END
GO

