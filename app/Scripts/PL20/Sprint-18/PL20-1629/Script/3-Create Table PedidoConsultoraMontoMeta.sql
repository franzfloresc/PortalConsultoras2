if not exists(select 1 from sysobjects where name = 'PedidoConsultoraMontoMeta' and xtype = 'u')
begin
	create table PedidoConsultoraMontoMeta
	(
		CampaniaId int not null,
		ConsultoraId int not null,
		MontoPedido decimal(18,2),
		GapMinimo decimal(18,2),
		GapMaximo decimal(18,2),
		GapAgregar decimal(18,2),
		MontoMeta decimal(18,2)
	)
	
	Alter table PedidoConsultoraMontoMeta   
	Add Constraint PK_CampaniaId_ConsultoraId PRIMARY KEY CLUSTERED (CampaniaId,ConsultoraId);
end
