USE BelcorpChile
GO
IF OBJECT_ID('ActualizarEstadoConfiguracionPaisDetalle', 'P') IS NOT NULL
	DROP PROC ActualizarEstadoConfiguracionPaisDetalle
GO
CREATE PROCEDURE ActualizarEstadoConfiguracionPaisDetalle
	@CodigoConsultora varchar(20),
	@Estado int
AS 
BEGIN
	Update ConfiguracionPaisDetalle
	Set Estado = @Estado
	where CodigoConsultora = @CodigoConsultora;
END
GO