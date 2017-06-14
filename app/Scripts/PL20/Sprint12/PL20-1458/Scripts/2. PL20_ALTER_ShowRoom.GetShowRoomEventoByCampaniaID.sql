USE BelcorpBolivia
GO
ALTER PROCEDURE ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID INT
AS
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
*/
BEGIN
select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania,
	isnull(TienePersonalizacion,0) as TienePersonalizacion
from ShowRoom.Evento
where CampaniaID = @CampaniaID
END

GO
USE BelcorpCostaRica
GO
ALTER PROCEDURE ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID INT
AS
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
*/
BEGIN
select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania,
	isnull(TienePersonalizacion,0) as TienePersonalizacion
from ShowRoom.Evento
where CampaniaID = @CampaniaID
END

GO
USE BelcorpChile
GO
ALTER PROCEDURE ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID INT
AS
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
*/
BEGIN
select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania,
	isnull(TienePersonalizacion,0) as TienePersonalizacion
from ShowRoom.Evento
where CampaniaID = @CampaniaID
END

GO
USE BelcorpColombia
GO
ALTER PROCEDURE ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID INT
AS
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
*/
BEGIN
select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania,
	isnull(TienePersonalizacion,0) as TienePersonalizacion
from ShowRoom.Evento
where CampaniaID = @CampaniaID
END

GO
USE BelcorpDominicana
GO
ALTER PROCEDURE ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID INT
AS
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
*/
BEGIN
select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania,
	isnull(TienePersonalizacion,0) as TienePersonalizacion
from ShowRoom.Evento
where CampaniaID = @CampaniaID
END

GO
USE BelcorpEcuador
GO
ALTER PROCEDURE ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID INT
AS
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
*/
BEGIN
select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania,
	isnull(TienePersonalizacion,0) as TienePersonalizacion
from ShowRoom.Evento
where CampaniaID = @CampaniaID
END

GO
USE BelcorpGuatemala
GO
ALTER PROCEDURE ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID INT
AS
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
*/
BEGIN
select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania,
	isnull(TienePersonalizacion,0) as TienePersonalizacion
from ShowRoom.Evento
where CampaniaID = @CampaniaID
END

GO
USE BelcorpMexico
GO
ALTER PROCEDURE ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID INT
AS
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
*/
BEGIN
select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania,
	isnull(TienePersonalizacion,0) as TienePersonalizacion
from ShowRoom.Evento
where CampaniaID = @CampaniaID
END

GO
USE BelcorpPanama
GO
ALTER PROCEDURE ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID INT
AS
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
*/
BEGIN
select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania,
	isnull(TienePersonalizacion,0) as TienePersonalizacion
from ShowRoom.Evento
where CampaniaID = @CampaniaID
END

GO
USE BelcorpPeru
GO
ALTER PROCEDURE ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID INT
AS
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
*/
BEGIN
select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania,
	isnull(TienePersonalizacion,0) as TienePersonalizacion
from ShowRoom.Evento
where CampaniaID = @CampaniaID
END

GO
USE BelcorpPuertoRico
GO
ALTER PROCEDURE ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID INT
AS
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
*/
BEGIN
select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania,
	isnull(TienePersonalizacion,0) as TienePersonalizacion
from ShowRoom.Evento
where CampaniaID = @CampaniaID
END

GO
USE BelcorpSalvador
GO
ALTER PROCEDURE ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID INT
AS
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
*/
BEGIN
select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania,
	isnull(TienePersonalizacion,0) as TienePersonalizacion
from ShowRoom.Evento
where CampaniaID = @CampaniaID
END

GO
USE BelcorpVenezuela
GO
ALTER PROCEDURE ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID INT
AS
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
*/
BEGIN
select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania,
	isnull(TienePersonalizacion,0) as TienePersonalizacion
from ShowRoom.Evento
where CampaniaID = @CampaniaID
END

GO
