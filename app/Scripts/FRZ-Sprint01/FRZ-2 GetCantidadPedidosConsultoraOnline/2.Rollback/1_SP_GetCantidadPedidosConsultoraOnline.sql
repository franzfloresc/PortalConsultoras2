GO
ALTER PROCEDURE [dbo].[GetCantidadPedidosConsultoraOnline]
	@ConsultoraId bigint
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS (SELECT 1 FROM AfiliaClienteConsultora with(nolock) WHERE ConsultoraID = @ConsultoraId AND EsAfiliado = 1)
		SELECT ISNULL(COUNT(S.SolicitudClienteID), -1) AS Cantidad
		FROM SolicitudCliente S with(nolock)
		WHERE S.ConsultoraID = @ConsultoraId AND S.Estado IS NULL
	ELSE 
		SELECT -1 AS Cantidad;
END
GO