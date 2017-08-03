GO
alter procedure dbo.GetCDRWebByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
as
begin
	select
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	from LogCDRWebCulminado
	where LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
end
GO