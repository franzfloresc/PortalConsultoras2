USE BelcorpBolivia
go

delete from EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP'

go

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END

GO

USE BelcorpChile
go

delete from EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP'

go

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END

GO

USE BelcorpColombia
go

delete from EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP'

go

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END

GO

USE BelcorpCostaRica
go

delete from EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP'

go

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END

GO

USE BelcorpDominicana
go

delete from EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP'

go

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END

GO

USE BelcorpEcuador
go

delete from EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP'

go

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END

GO

USE BelcorpGuatemala
go

delete from EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP'

go

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END

GO

USE BelcorpMexico
go

delete from EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP'

go

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END

GO

USE BelcorpPanama
go

delete from EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP'

go

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END

GO

USE BelcorpPeru
go

delete from EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP'

go

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END

GO

USE BelcorpPuertoRico
go

delete from EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP'

go

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END

GO

USE BelcorpSalvador
go

delete from EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP'

go

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END

GO

USE BelcorpVenezuela
go

delete from EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP'

go

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END

GO