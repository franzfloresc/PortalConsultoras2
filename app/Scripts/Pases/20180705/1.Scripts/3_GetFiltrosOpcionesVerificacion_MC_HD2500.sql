USE BelcorpPeru
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetFiltrosOpcionesVerificacion')
BEGIN
	DROP PROC GetFiltrosOpcionesVerificacion
END
GO
-- GetFiltrosOpcionesVerificacion 2
CREATE PROC GetFiltrosOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		IsNull(IdEstadoActividad, 0) as IdEstadoActividad,
		IsNull(CampaniaInicio, 0) as CampaniaInicio,
		IsNull(CampaniaFinal, 0) as CampaniaFinal,
		IsNull(MensajeSaludo, '') as MensajeSaludo
	from [dbo].[FiltrosOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpMexico
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetFiltrosOpcionesVerificacion')
BEGIN
	DROP PROC GetFiltrosOpcionesVerificacion
END
GO
-- GetFiltrosOpcionesVerificacion 2
CREATE PROC GetFiltrosOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		IsNull(IdEstadoActividad, 0) as IdEstadoActividad,
		IsNull(CampaniaInicio, 0) as CampaniaInicio,
		IsNull(CampaniaFinal, 0) as CampaniaFinal,
		IsNull(MensajeSaludo, '') as MensajeSaludo
	from [dbo].[FiltrosOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpColombia
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetFiltrosOpcionesVerificacion')
BEGIN
	DROP PROC GetFiltrosOpcionesVerificacion
END
GO
-- GetFiltrosOpcionesVerificacion 2
CREATE PROC GetFiltrosOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		IsNull(IdEstadoActividad, 0) as IdEstadoActividad,
		IsNull(CampaniaInicio, 0) as CampaniaInicio,
		IsNull(CampaniaFinal, 0) as CampaniaFinal,
		IsNull(MensajeSaludo, '') as MensajeSaludo
	from [dbo].[FiltrosOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpSalvador
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetFiltrosOpcionesVerificacion')
BEGIN
	DROP PROC GetFiltrosOpcionesVerificacion
END
GO
-- GetFiltrosOpcionesVerificacion 2
CREATE PROC GetFiltrosOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		IsNull(IdEstadoActividad, 0) as IdEstadoActividad,
		IsNull(CampaniaInicio, 0) as CampaniaInicio,
		IsNull(CampaniaFinal, 0) as CampaniaFinal,
		IsNull(MensajeSaludo, '') as MensajeSaludo
	from [dbo].[FiltrosOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpPuertoRico
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetFiltrosOpcionesVerificacion')
BEGIN
	DROP PROC GetFiltrosOpcionesVerificacion
END
GO
-- GetFiltrosOpcionesVerificacion 2
CREATE PROC GetFiltrosOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		IsNull(IdEstadoActividad, 0) as IdEstadoActividad,
		IsNull(CampaniaInicio, 0) as CampaniaInicio,
		IsNull(CampaniaFinal, 0) as CampaniaFinal,
		IsNull(MensajeSaludo, '') as MensajeSaludo
	from [dbo].[FiltrosOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpPanama
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetFiltrosOpcionesVerificacion')
BEGIN
	DROP PROC GetFiltrosOpcionesVerificacion
END
GO
-- GetFiltrosOpcionesVerificacion 2
CREATE PROC GetFiltrosOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		IsNull(IdEstadoActividad, 0) as IdEstadoActividad,
		IsNull(CampaniaInicio, 0) as CampaniaInicio,
		IsNull(CampaniaFinal, 0) as CampaniaFinal,
		IsNull(MensajeSaludo, '') as MensajeSaludo
	from [dbo].[FiltrosOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpGuatemala
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetFiltrosOpcionesVerificacion')
BEGIN
	DROP PROC GetFiltrosOpcionesVerificacion
END
GO
-- GetFiltrosOpcionesVerificacion 2
CREATE PROC GetFiltrosOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		IsNull(IdEstadoActividad, 0) as IdEstadoActividad,
		IsNull(CampaniaInicio, 0) as CampaniaInicio,
		IsNull(CampaniaFinal, 0) as CampaniaFinal,
		IsNull(MensajeSaludo, '') as MensajeSaludo
	from [dbo].[FiltrosOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpEcuador
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetFiltrosOpcionesVerificacion')
BEGIN
	DROP PROC GetFiltrosOpcionesVerificacion
END
GO
-- GetFiltrosOpcionesVerificacion 2
CREATE PROC GetFiltrosOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		IsNull(IdEstadoActividad, 0) as IdEstadoActividad,
		IsNull(CampaniaInicio, 0) as CampaniaInicio,
		IsNull(CampaniaFinal, 0) as CampaniaFinal,
		IsNull(MensajeSaludo, '') as MensajeSaludo
	from [dbo].[FiltrosOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpDominicana
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetFiltrosOpcionesVerificacion')
BEGIN
	DROP PROC GetFiltrosOpcionesVerificacion
END
GO
-- GetFiltrosOpcionesVerificacion 2
CREATE PROC GetFiltrosOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		IsNull(IdEstadoActividad, 0) as IdEstadoActividad,
		IsNull(CampaniaInicio, 0) as CampaniaInicio,
		IsNull(CampaniaFinal, 0) as CampaniaFinal,
		IsNull(MensajeSaludo, '') as MensajeSaludo
	from [dbo].[FiltrosOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpCostaRica
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetFiltrosOpcionesVerificacion')
BEGIN
	DROP PROC GetFiltrosOpcionesVerificacion
END
GO
-- GetFiltrosOpcionesVerificacion 2
CREATE PROC GetFiltrosOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		IsNull(IdEstadoActividad, 0) as IdEstadoActividad,
		IsNull(CampaniaInicio, 0) as CampaniaInicio,
		IsNull(CampaniaFinal, 0) as CampaniaFinal,
		IsNull(MensajeSaludo, '') as MensajeSaludo
	from [dbo].[FiltrosOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpChile
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetFiltrosOpcionesVerificacion')
BEGIN
	DROP PROC GetFiltrosOpcionesVerificacion
END
GO
-- GetFiltrosOpcionesVerificacion 2
CREATE PROC GetFiltrosOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		IsNull(IdEstadoActividad, 0) as IdEstadoActividad,
		IsNull(CampaniaInicio, 0) as CampaniaInicio,
		IsNull(CampaniaFinal, 0) as CampaniaFinal,
		IsNull(MensajeSaludo, '') as MensajeSaludo
	from [dbo].[FiltrosOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpBolivia
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetFiltrosOpcionesVerificacion')
BEGIN
	DROP PROC GetFiltrosOpcionesVerificacion
END
GO
-- GetFiltrosOpcionesVerificacion 2
CREATE PROC GetFiltrosOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		IsNull(IdEstadoActividad, 0) as IdEstadoActividad,
		IsNull(CampaniaInicio, 0) as CampaniaInicio,
		IsNull(CampaniaFinal, 0) as CampaniaFinal,
		IsNull(MensajeSaludo, '') as MensajeSaludo
	from [dbo].[FiltrosOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

