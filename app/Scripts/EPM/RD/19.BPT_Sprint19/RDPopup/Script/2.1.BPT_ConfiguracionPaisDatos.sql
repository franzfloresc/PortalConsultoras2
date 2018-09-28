
GO
declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	
	declare @estado int = 1,
	@Campania int = 0

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

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje1', 'CON LA NUEVA HERRAMIENTA DE VOZ')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensaje2', 'ENCUENTRA PRODUCTOS MÁS RÁPIDO')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupMensajeColor', 'white')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenEtiqueta', '')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupImagenPublicidad', '')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorFondo', '#c39934')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonColorTexto', '#fff')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupBotonTexto', 'DESCUBRE CÓMO TENERLOS')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColor', 'transparent')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1)
	values (@ConfiguracionPaisID, @estado, @Campania, 'PopupFondoColorMarco', 'c39934')

end
GO