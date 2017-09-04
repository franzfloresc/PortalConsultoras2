GO
ALTER PROCEDURE [dbo].[GetCantidadPedidosConsultoraOnline]
	@ConsultoraId bigint
AS
BEGIN
	set nocount on;

	declare @EsAfiliado bit;
	select top 1 @EsAfiliado = EsAfiliado
	from AfiliaClienteConsultora with(nolock)
	where ConsultoraID = @ConsultoraId
	order by coalesce(FechaModificacion,FechaCreacion) desc;

	if isnull(@EsAfiliado, 0) = 1
	begin
		SELECT ISNULL(COUNT(S.SolicitudClienteID), -1) AS Cantidad
		FROM SolicitudCliente S with(nolock)
		WHERE S.ConsultoraID = @ConsultoraId AND S.Estado IS NULL
	end
	else
	begin 
		SELECT -1 AS Cantidad;
	end
END
GO