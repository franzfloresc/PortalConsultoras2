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
		FechaCulminado,
		TipoDespacho,
		FleteDespacho,
		MensajeDespacho
	from LogCDRWebCulminado
	where LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
end
GO