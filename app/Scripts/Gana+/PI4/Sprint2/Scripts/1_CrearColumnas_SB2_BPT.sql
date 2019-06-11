use BelcorpPeru_GANAMAS;


ALTER TABLE PedidoWeb ADD GananciaRevista MONEY;
ALTER TABLE PedidoWeb ADD GananciaWeb MONEY;
ALTER TABLE PedidoWeb ADD GananciaOtros MONEY;

select * from PedidoWeb;