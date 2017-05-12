USE BelcorpBolivia
GO
ALTER PROCEDURE ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania,
	TienePersonalizacion = @TienePersonalizacion
where EventoID = @EventoID

end

GO
USE BelcorpCostaRica
GO
ALTER PROCEDURE ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania,
	TienePersonalizacion = @TienePersonalizacion
where EventoID = @EventoID

end

GO
USE BelcorpChile
GO
ALTER PROCEDURE ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania,
	TienePersonalizacion = @TienePersonalizacion
where EventoID = @EventoID

end

GO
USE BelcorpColombia
GO
ALTER PROCEDURE ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania,
	TienePersonalizacion = @TienePersonalizacion
where EventoID = @EventoID

end

GO
USE BelcorpDominicana
GO
ALTER PROCEDURE ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania,
	TienePersonalizacion = @TienePersonalizacion
where EventoID = @EventoID

end

GO
USE BelcorpEcuador
GO
ALTER PROCEDURE ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania,
	TienePersonalizacion = @TienePersonalizacion
where EventoID = @EventoID

end

GO
USE BelcorpGuatemala
GO
ALTER PROCEDURE ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania,
	TienePersonalizacion = @TienePersonalizacion
where EventoID = @EventoID

end

GO
USE BelcorpMexico
GO
ALTER PROCEDURE ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania,
	TienePersonalizacion = @TienePersonalizacion
where EventoID = @EventoID

end

GO
USE BelcorpPanama
GO
ALTER PROCEDURE ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania,
	TienePersonalizacion = @TienePersonalizacion
where EventoID = @EventoID

end

GO
USE BelcorpPeru
GO
ALTER PROCEDURE ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania,
	TienePersonalizacion = @TienePersonalizacion
where EventoID = @EventoID

end

GO
USE BelcorpPuertoRico
GO
ALTER PROCEDURE ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania,
	TienePersonalizacion = @TienePersonalizacion
where EventoID = @EventoID

end

GO
USE BelcorpSalvador
GO
ALTER PROCEDURE ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania,
	TienePersonalizacion = @TienePersonalizacion
where EventoID = @EventoID

end

GO
USE BelcorpVenezuela
GO
ALTER PROCEDURE ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania,
	TienePersonalizacion = @TienePersonalizacion
where EventoID = @EventoID

end

GO
