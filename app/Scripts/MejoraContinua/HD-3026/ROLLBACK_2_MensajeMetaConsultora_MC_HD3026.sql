UPDATE MensajeMetaConsultora SET Mensaje='Te faltan #valor para pasar pedido' WHERE TipoMensaje='MontoMinimo';
UPDATE MensajeMetaConsultora SET Mensaje='S�lo te faltan #valor m�s.' WHERE TipoMensaje='TippingPoint';
UPDATE MensajeMetaConsultora SET Mensaje='Ya estas por llegar a tu tope de l�nea de cr�dito.' WHERE TipoMensaje='MontoMaximo';
UPDATE MensajeMetaConsultora SET Mensaje='Tu pedido ya alcanz� el monto m�ximo de tu l�nea de cr�dito.' WHERE TipoMensaje='MontoMaximoSupero';
UPDATE MensajeMetaConsultora SET Mensaje='Solo agrega #valor m�s.' WHERE TipoMensaje='EscalaDescuento';
UPDATE MensajeMetaConsultora SET Mensaje='Ya alcanzaste el #porcentaje% de descuento.' WHERE TipoMensaje='EscalaDescuentoSupero';
DELETE MensajeMetaConsultora WHERE TipoMensaje='Inicio';