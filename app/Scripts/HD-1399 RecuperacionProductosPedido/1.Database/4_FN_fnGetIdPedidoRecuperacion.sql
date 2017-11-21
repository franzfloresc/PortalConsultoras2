GO
if object_id('fnGetIdPedidoRecuperacion') is not null
begin
	drop function fnGetIdPedidoRecuperacion;
end
GO
create function fnGetIdPedidoRecuperacion(
	@CampaniaID int,
	@CodigoConsultora varchar(25)
)
returns int
as
begin
	return isnull((
		select top 1 PedidoRecuperacionId
		from PedidoRecuperacion
		where CodigoConsultora = @CodigoConsultora and CampaniaId = @CampaniaID
	), 0);
end
GO