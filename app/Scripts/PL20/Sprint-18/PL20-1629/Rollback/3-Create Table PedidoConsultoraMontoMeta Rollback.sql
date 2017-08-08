if exists(select 1 from sysobjects where name = 'PedidoConsultoraMontoMeta' and xtype = 'u')
begin
	drop table PedidoConsultoraMontoMeta
end
