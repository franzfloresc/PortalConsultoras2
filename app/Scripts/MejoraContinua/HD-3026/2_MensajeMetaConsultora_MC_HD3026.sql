UPDATE MensajeMetaConsultora SET Mensaje='Te falta #valor para alcanzar el M. m�nimo (*)' WHERE TipoMensaje='MontoMinimo';
UPDATE MensajeMetaConsultora SET Mensaje='Te falta #valor para llevarte tu regalo (*)' WHERE TipoMensaje='TippingPoint';
UPDATE MensajeMetaConsultora SET Mensaje='S�lo puedes agregar #valor m�s (*)' WHERE TipoMensaje='MontoMaximo';
UPDATE MensajeMetaConsultora SET Mensaje='�Alcanzaste tu monto m�ximo! (*)' WHERE TipoMensaje='MontoMaximoSupero';
UPDATE MensajeMetaConsultora SET Mensaje='Te falta #valor para el #porcentaje% DSCTO (*)' WHERE TipoMensaje='EscalaDescuento';
UPDATE MensajeMetaConsultora SET Mensaje='�Alcanzaste el descuento m�ximo de #porcentaje% DSCTO! (*)' WHERE TipoMensaje='EscalaDescuentoSupero';
DELETE MensajeMetaConsultora WHERE TipoMensaje='Inicio';
INSERT INTO MensajeMetaConsultora(TipoMensaje, Titulo, Mensaje) VALUES('Inicio', '', '�Empieza agregar productos para alcanzar tu regalo! (*)');