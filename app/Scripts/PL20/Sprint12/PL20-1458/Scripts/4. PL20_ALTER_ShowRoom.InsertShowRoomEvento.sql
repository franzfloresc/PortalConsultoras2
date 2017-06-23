USE BelcorpBolivia
GO
ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania, TienePersonalizacion)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania, @TienePersonalizacion)

set @EventoID = @@IDENTITY

end

GO
USE BelcorpCostaRica
GO
ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania, TienePersonalizacion)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania, @TienePersonalizacion)

set @EventoID = @@IDENTITY

end

GO
USE BelcorpChile
GO
ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania, TienePersonalizacion)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania, @TienePersonalizacion)

set @EventoID = @@IDENTITY

end

GO
USE BelcorpColombia
GO
ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania, TienePersonalizacion)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania, @TienePersonalizacion)

set @EventoID = @@IDENTITY

end

GO
USE BelcorpDominicana
GO
ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania, TienePersonalizacion)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania, @TienePersonalizacion)

set @EventoID = @@IDENTITY

end

GO
USE BelcorpEcuador
GO
ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania, TienePersonalizacion)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania, @TienePersonalizacion)

set @EventoID = @@IDENTITY

end

GO
USE BelcorpGuatemala
GO
ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania, TienePersonalizacion)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania, @TienePersonalizacion)

set @EventoID = @@IDENTITY

end

GO
USE BelcorpMexico
GO
ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania, TienePersonalizacion)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania, @TienePersonalizacion)

set @EventoID = @@IDENTITY

end

GO
USE BelcorpPanama
GO
ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania, TienePersonalizacion)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania, @TienePersonalizacion)

set @EventoID = @@IDENTITY

end

GO
USE BelcorpPeru
GO
ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania, TienePersonalizacion)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania, @TienePersonalizacion)

set @EventoID = @@IDENTITY

end

GO
USE BelcorpPuertoRico
GO
ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania, TienePersonalizacion)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania, @TienePersonalizacion)

set @EventoID = @@IDENTITY

end

GO
USE BelcorpSalvador
GO
ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania, TienePersonalizacion)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania, @TienePersonalizacion)

set @EventoID = @@IDENTITY

end

GO
USE BelcorpVenezuela
GO
ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania, TienePersonalizacion)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania, @TienePersonalizacion)

set @EventoID = @@IDENTITY

end

GO
