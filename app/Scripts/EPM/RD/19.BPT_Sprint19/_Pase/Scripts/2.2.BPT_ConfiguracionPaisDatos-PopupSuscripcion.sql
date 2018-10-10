USE BelcorpPeru
GO

GO
declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	
	declare @estado int = 1,
	@Campania int = 0,
	@Comp varchar(100) = 'Popup_Club_Gana+'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in (
		'PopupMensaje1',
        'PopupMensaje2',
        'PopupMensajeColor',
        'PopupImagenEtiqueta', 
        'PopupImagenPublicidad',
        'PopupBotonColorFondo',
        'PopupBotonColorTexto',
        'PopupBotonTexto',
        'PopupFondoColor',
        'PopupFondoColorMarco');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje1', 'UN NUEVO ESPACIO CON OFERTAS', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje2', 'HECHAS A TU MEDIDA', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensajeColor', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenEtiqueta', 'ClubGanaMas-etiqueta-dorado.png', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenPublicidad', 'ClubGanaMas-Popup.gif', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorFondo', '#C39934', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorTexto', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonTexto', 'CONOCE EL CLUB', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColor', 'transparent', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColorMarco', 'C39934', @Comp)

end
GO

USE BelcorpMexico
GO

GO
declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	
	declare @estado int = 1,
	@Campania int = 0,
	@Comp varchar(100) = 'Popup_Club_Gana+'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in (
		'PopupMensaje1',
        'PopupMensaje2',
        'PopupMensajeColor',
        'PopupImagenEtiqueta', 
        'PopupImagenPublicidad',
        'PopupBotonColorFondo',
        'PopupBotonColorTexto',
        'PopupBotonTexto',
        'PopupFondoColor',
        'PopupFondoColorMarco');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje1', 'UN NUEVO ESPACIO CON OFERTAS', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje2', 'HECHAS A TU MEDIDA', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensajeColor', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenEtiqueta', 'ClubGanaMas-etiqueta-dorado.png', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenPublicidad', 'ClubGanaMas-Popup.gif', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorFondo', '#C39934', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorTexto', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonTexto', 'CONOCE EL CLUB', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColor', 'transparent', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColorMarco', 'C39934', @Comp)

end
GO

USE BelcorpColombia
GO

GO
declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	
	declare @estado int = 1,
	@Campania int = 0,
	@Comp varchar(100) = 'Popup_Club_Gana+'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in (
		'PopupMensaje1',
        'PopupMensaje2',
        'PopupMensajeColor',
        'PopupImagenEtiqueta', 
        'PopupImagenPublicidad',
        'PopupBotonColorFondo',
        'PopupBotonColorTexto',
        'PopupBotonTexto',
        'PopupFondoColor',
        'PopupFondoColorMarco');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje1', 'UN NUEVO ESPACIO CON OFERTAS', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje2', 'HECHAS A TU MEDIDA', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensajeColor', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenEtiqueta', 'ClubGanaMas-etiqueta-dorado.png', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenPublicidad', 'ClubGanaMas-Popup.gif', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorFondo', '#C39934', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorTexto', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonTexto', 'CONOCE EL CLUB', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColor', 'transparent', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColorMarco', 'C39934', @Comp)

end
GO

USE BelcorpVenezuela
GO

GO
declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	
	declare @estado int = 1,
	@Campania int = 0,
	@Comp varchar(100) = 'Popup_Club_Gana+'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in (
		'PopupMensaje1',
        'PopupMensaje2',
        'PopupMensajeColor',
        'PopupImagenEtiqueta', 
        'PopupImagenPublicidad',
        'PopupBotonColorFondo',
        'PopupBotonColorTexto',
        'PopupBotonTexto',
        'PopupFondoColor',
        'PopupFondoColorMarco');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje1', 'UN NUEVO ESPACIO CON OFERTAS', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje2', 'HECHAS A TU MEDIDA', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensajeColor', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenEtiqueta', 'ClubGanaMas-etiqueta-dorado.png', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenPublicidad', 'ClubGanaMas-Popup.gif', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorFondo', '#C39934', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorTexto', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonTexto', 'CONOCE EL CLUB', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColor', 'transparent', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColorMarco', 'C39934', @Comp)

end
GO

USE BelcorpSalvador
GO

GO
declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	
	declare @estado int = 1,
	@Campania int = 0,
	@Comp varchar(100) = 'Popup_Club_Gana+'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in (
		'PopupMensaje1',
        'PopupMensaje2',
        'PopupMensajeColor',
        'PopupImagenEtiqueta', 
        'PopupImagenPublicidad',
        'PopupBotonColorFondo',
        'PopupBotonColorTexto',
        'PopupBotonTexto',
        'PopupFondoColor',
        'PopupFondoColorMarco');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje1', 'UN NUEVO ESPACIO CON OFERTAS', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje2', 'HECHAS A TU MEDIDA', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensajeColor', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenEtiqueta', 'ClubGanaMas-etiqueta-dorado.png', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenPublicidad', 'ClubGanaMas-Popup.gif', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorFondo', '#C39934', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorTexto', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonTexto', 'CONOCE EL CLUB', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColor', 'transparent', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColorMarco', 'C39934', @Comp)

end
GO

USE BelcorpPuertoRico
GO

GO
declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	
	declare @estado int = 1,
	@Campania int = 0,
	@Comp varchar(100) = 'Popup_Club_Gana+'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in (
		'PopupMensaje1',
        'PopupMensaje2',
        'PopupMensajeColor',
        'PopupImagenEtiqueta', 
        'PopupImagenPublicidad',
        'PopupBotonColorFondo',
        'PopupBotonColorTexto',
        'PopupBotonTexto',
        'PopupFondoColor',
        'PopupFondoColorMarco');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje1', 'UN NUEVO ESPACIO CON OFERTAS', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje2', 'HECHAS A TU MEDIDA', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensajeColor', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenEtiqueta', 'ClubGanaMas-etiqueta-dorado.png', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenPublicidad', 'ClubGanaMas-Popup.gif', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorFondo', '#C39934', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorTexto', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonTexto', 'CONOCE EL CLUB', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColor', 'transparent', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColorMarco', 'C39934', @Comp)

end
GO

USE BelcorpPanama
GO

GO
declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	
	declare @estado int = 1,
	@Campania int = 0,
	@Comp varchar(100) = 'Popup_Club_Gana+'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in (
		'PopupMensaje1',
        'PopupMensaje2',
        'PopupMensajeColor',
        'PopupImagenEtiqueta', 
        'PopupImagenPublicidad',
        'PopupBotonColorFondo',
        'PopupBotonColorTexto',
        'PopupBotonTexto',
        'PopupFondoColor',
        'PopupFondoColorMarco');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje1', 'UN NUEVO ESPACIO CON OFERTAS', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje2', 'HECHAS A TU MEDIDA', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensajeColor', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenEtiqueta', 'ClubGanaMas-etiqueta-dorado.png', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenPublicidad', 'ClubGanaMas-Popup.gif', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorFondo', '#C39934', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorTexto', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonTexto', 'CONOCE EL CLUB', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColor', 'transparent', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColorMarco', 'C39934', @Comp)

end
GO

USE BelcorpGuatemala
GO

GO
declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	
	declare @estado int = 1,
	@Campania int = 0,
	@Comp varchar(100) = 'Popup_Club_Gana+'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in (
		'PopupMensaje1',
        'PopupMensaje2',
        'PopupMensajeColor',
        'PopupImagenEtiqueta', 
        'PopupImagenPublicidad',
        'PopupBotonColorFondo',
        'PopupBotonColorTexto',
        'PopupBotonTexto',
        'PopupFondoColor',
        'PopupFondoColorMarco');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje1', 'UN NUEVO ESPACIO CON OFERTAS', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje2', 'HECHAS A TU MEDIDA', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensajeColor', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenEtiqueta', 'ClubGanaMas-etiqueta-dorado.png', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenPublicidad', 'ClubGanaMas-Popup.gif', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorFondo', '#C39934', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorTexto', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonTexto', 'CONOCE EL CLUB', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColor', 'transparent', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColorMarco', 'C39934', @Comp)

end
GO

USE BelcorpEcuador
GO

GO
declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	
	declare @estado int = 1,
	@Campania int = 0,
	@Comp varchar(100) = 'Popup_Club_Gana+'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in (
		'PopupMensaje1',
        'PopupMensaje2',
        'PopupMensajeColor',
        'PopupImagenEtiqueta', 
        'PopupImagenPublicidad',
        'PopupBotonColorFondo',
        'PopupBotonColorTexto',
        'PopupBotonTexto',
        'PopupFondoColor',
        'PopupFondoColorMarco');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje1', 'UN NUEVO ESPACIO CON OFERTAS', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje2', 'HECHAS A TU MEDIDA', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensajeColor', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenEtiqueta', 'ClubGanaMas-etiqueta-dorado.png', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenPublicidad', 'ClubGanaMas-Popup.gif', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorFondo', '#C39934', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorTexto', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonTexto', 'CONOCE EL CLUB', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColor', 'transparent', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColorMarco', 'C39934', @Comp)

end
GO

USE BelcorpDominicana
GO

GO
declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	
	declare @estado int = 1,
	@Campania int = 0,
	@Comp varchar(100) = 'Popup_Club_Gana+'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in (
		'PopupMensaje1',
        'PopupMensaje2',
        'PopupMensajeColor',
        'PopupImagenEtiqueta', 
        'PopupImagenPublicidad',
        'PopupBotonColorFondo',
        'PopupBotonColorTexto',
        'PopupBotonTexto',
        'PopupFondoColor',
        'PopupFondoColorMarco');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje1', 'UN NUEVO ESPACIO CON OFERTAS', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje2', 'HECHAS A TU MEDIDA', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensajeColor', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenEtiqueta', 'ClubGanaMas-etiqueta-dorado.png', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenPublicidad', 'ClubGanaMas-Popup.gif', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorFondo', '#C39934', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorTexto', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonTexto', 'CONOCE EL CLUB', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColor', 'transparent', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColorMarco', 'C39934', @Comp)

end
GO

USE BelcorpCostaRica
GO

GO
declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	
	declare @estado int = 1,
	@Campania int = 0,
	@Comp varchar(100) = 'Popup_Club_Gana+'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in (
		'PopupMensaje1',
        'PopupMensaje2',
        'PopupMensajeColor',
        'PopupImagenEtiqueta', 
        'PopupImagenPublicidad',
        'PopupBotonColorFondo',
        'PopupBotonColorTexto',
        'PopupBotonTexto',
        'PopupFondoColor',
        'PopupFondoColorMarco');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje1', 'UN NUEVO ESPACIO CON OFERTAS', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje2', 'HECHAS A TU MEDIDA', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensajeColor', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenEtiqueta', 'ClubGanaMas-etiqueta-dorado.png', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenPublicidad', 'ClubGanaMas-Popup.gif', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorFondo', '#C39934', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorTexto', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonTexto', 'CONOCE EL CLUB', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColor', 'transparent', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColorMarco', 'C39934', @Comp)

end
GO

USE BelcorpChile
GO

GO
declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	
	declare @estado int = 1,
	@Campania int = 0,
	@Comp varchar(100) = 'Popup_Club_Gana+'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in (
		'PopupMensaje1',
        'PopupMensaje2',
        'PopupMensajeColor',
        'PopupImagenEtiqueta', 
        'PopupImagenPublicidad',
        'PopupBotonColorFondo',
        'PopupBotonColorTexto',
        'PopupBotonTexto',
        'PopupFondoColor',
        'PopupFondoColorMarco');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje1', 'UN NUEVO ESPACIO CON OFERTAS', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje2', 'HECHAS A TU MEDIDA', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensajeColor', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenEtiqueta', 'ClubGanaMas-etiqueta-dorado.png', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenPublicidad', 'ClubGanaMas-Popup.gif', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorFondo', '#C39934', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorTexto', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonTexto', 'CONOCE EL CLUB', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColor', 'transparent', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColorMarco', 'C39934', @Comp)

end
GO

USE BelcorpBolivia
GO

GO
declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	
	declare @estado int = 1,
	@Campania int = 0,
	@Comp varchar(100) = 'Popup_Club_Gana+'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in (
		'PopupMensaje1',
        'PopupMensaje2',
        'PopupMensajeColor',
        'PopupImagenEtiqueta', 
        'PopupImagenPublicidad',
        'PopupBotonColorFondo',
        'PopupBotonColorTexto',
        'PopupBotonTexto',
        'PopupFondoColor',
        'PopupFondoColorMarco');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje1', 'UN NUEVO ESPACIO CON OFERTAS', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje2', 'HECHAS A TU MEDIDA', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensajeColor', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenEtiqueta', 'ClubGanaMas-etiqueta-dorado.png', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenPublicidad', 'ClubGanaMas-Popup.gif', @Comp)

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorFondo', '#C39934', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorTexto', '#FFF', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonTexto', 'CONOCE EL CLUB', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColor', 'transparent', @Comp)
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Componente)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColorMarco', 'C39934', @Comp)

end
GO
