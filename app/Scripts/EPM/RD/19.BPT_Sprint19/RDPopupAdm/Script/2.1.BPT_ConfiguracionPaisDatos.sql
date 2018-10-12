
GO
update ConfiguracionPaisDatos
set Componente = 'Popup_Club_Gana+'
where Codigo in ('PopupMensaje1',
'PopupMensaje2',
'PopupMensajeColor',
'PopupImagenEtiqueta',
'PopupImagenPublicidad',
'PopupBotonColorFondo',
'PopupBotonColorTexto',
'PopupBotonTexto',
'PopupFondoColor',
'PopupFondoColorMarco')

GO