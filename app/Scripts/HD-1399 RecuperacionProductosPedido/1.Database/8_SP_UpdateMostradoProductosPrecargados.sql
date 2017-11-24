GO
if object_id('UpdateMostradoProductosPrecargados') is not null
begin
	drop procedure UpdateMostradoProductosPrecargados;
end
GO
create procedure UpdateMostradoProductosPrecargados
	@CampaniaID int,
	@ConsultoraID bigint,
	@IPUsuario varchar(25)
as
begin
	update PedidoWeb
	set IPUsuario = isnull(IPUsuario,@IPUsuario)
	where CampaniaId = @CampaniaID and ConsultoraID = @ConsultoraID;

	update PedidoRecuperacion
	set Mostrado = 1
	where CampaniaId = @CampaniaID and ConsultoraID = @ConsultoraID;
end
GO