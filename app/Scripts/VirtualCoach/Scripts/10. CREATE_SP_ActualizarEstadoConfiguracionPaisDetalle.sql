USE BelcorpChile
GO

CREATE PROCEDURE ActualizarEstadoConfiguracionPaisDetalle
(
	@CodigoConsultora varchar(20),
	@Estado int
)
AS 
BEGIN
	Update ConfiguracionPaisDetalle
	Set Estado = @Estado
	where CodigoConsultora = @CodigoConsultora;
END
GO