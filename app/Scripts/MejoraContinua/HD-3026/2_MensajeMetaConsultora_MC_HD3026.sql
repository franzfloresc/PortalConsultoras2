UPDATE MensajeMetaConsultora SET Mensaje='Te falta #valor para alcanzar el M. mínimo (*)' WHERE TipoMensaje='MontoMinimo';
UPDATE MensajeMetaConsultora SET Mensaje='Te falta #valor para llevarte tu regalo (*)' WHERE TipoMensaje='TippingPoint';
UPDATE MensajeMetaConsultora SET Mensaje='Sólo puedes agregar #valor más (*)' WHERE TipoMensaje='MontoMaximo';
UPDATE MensajeMetaConsultora SET Mensaje='¡Alcanzaste tu monto máximo! (*)' WHERE TipoMensaje='MontoMaximoSupero';
UPDATE MensajeMetaConsultora SET Mensaje='Te falta #valor para el #porcentaje% DSCTO (*)' WHERE TipoMensaje='EscalaDescuento';
UPDATE MensajeMetaConsultora SET Mensaje='¡Alcanzaste el descuento máximo de #porcentaje% DSCTO! (*)' WHERE TipoMensaje='EscalaDescuentoSupero';
DELETE MensajeMetaConsultora WHERE TipoMensaje='Inicio';
INSERT INTO MensajeMetaConsultora(TipoMensaje, Titulo, Mensaje) VALUES('Inicio', '', '¡Empieza agregar productos para alcanzar tu regalo! (*)');