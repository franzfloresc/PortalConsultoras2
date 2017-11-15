GO
if object_id('GetMostradoProductosPrecargados') is not null
begin
	drop procedure GetMostradoProductosPrecargados;
end
GO
create procedure GetMostradoProductosPrecargados
	@CampaniaID int,
	@CodigoConsultora varchar(25)
as
begin
	select isnull((
		select Mostrado
		from PedidoRecuperacion
		where CodigoConsultora = @CodigoConsultora and CampaniaId = @CampaniaID
	), 1);
end
GO