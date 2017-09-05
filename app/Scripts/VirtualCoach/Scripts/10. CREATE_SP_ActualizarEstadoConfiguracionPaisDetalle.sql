USE BelcorpChile
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'ActualizarEstadoConfiguracionPaisDetalle' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.ActualizarEstadoConfiguracionPaisDetalle
END
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