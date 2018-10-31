
go
declare @campaniaId int = 201816

-- Desktop
update ShowRoom.PersonalizacionNivel
set Valor = ''
where
	PersonalizacionId in (select
	PersonalizacionId
from ShowRoom.Personalizacion
where Atributo in ('ImagenFondoContenedorOfertasShowRoomVenta')
)
	and EventoId in (select EventoID  from ShowRoom.Evento where CampaniaID = @campaniaId)


-- Mobile
update ShowRoom.PersonalizacionNivel
set Valor = ''
where
	PersonalizacionId in (select
	PersonalizacionId
from ShowRoom.Personalizacion
where Atributo in ('ImagenBannerContenedorOfertasVenta')
)
	and EventoId in (select EventoID  from ShowRoom.Evento where CampaniaID = @campaniaId)


go