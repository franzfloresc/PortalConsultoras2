UPDATE MensajeMetaConsultora SET Mensaje='Te faltan #valor para pasar pedido' WHERE TipoMensaje='MontoMinimo';
UPDATE MensajeMetaConsultora SET Mensaje='Sólo te faltan #valor más.' WHERE TipoMensaje='TippingPoint';
UPDATE MensajeMetaConsultora SET Mensaje='Ya estas por llegar a tu tope de línea de crédito.' WHERE TipoMensaje='MontoMaximo';
UPDATE MensajeMetaConsultora SET Mensaje='Tu pedido ya alcanzó el monto máximo de tu línea de crédito.' WHERE TipoMensaje='MontoMaximoSupero';
UPDATE MensajeMetaConsultora SET Mensaje='Solo agrega #valor más.' WHERE TipoMensaje='EscalaDescuento';
UPDATE MensajeMetaConsultora SET Mensaje='Ya alcanzaste el #porcentaje% de descuento.' WHERE TipoMensaje='EscalaDescuentoSupero';
DELETE MensajeMetaConsultora WHERE TipoMensaje='Inicio';