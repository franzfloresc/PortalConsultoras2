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
