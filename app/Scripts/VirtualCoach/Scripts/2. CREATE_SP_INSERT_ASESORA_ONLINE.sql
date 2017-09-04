USE BelcorpChile
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsertarAsesoraOnline' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.InsertarAsesoraOnline
END
GO
CREATE PROCEDURE InsertarAsesoraOnline
	@CodigoConsultora varchar(10),
	@ConfirmacionInscripcion int,
	@Respuesta1 int,
	@Respuesta2 int,
	@Respuesta3 int,
	@Respuesta4 int,
	@Respuesta5 int,
	@Origen varchar(100)
AS
BEGIN
	IF NOT EXISTS (SELECT TOP 1 * FROM AsesoraOnline WHERE CodigoConsultora IN (@CodigoConsultora))
	BEGIN
		INSERT INTO AsesoraOnline (CodigoConsultora, ConfirmacionInscripcion, Respuesta1, Respuesta2, Respuesta3, Respuesta4, Respuesta5, FechaCreacion, Origen)
		VALUES (@CodigoConsultora, @ConfirmacionInscripcion, @Respuesta1, @Respuesta2, @Respuesta3, @Respuesta4, @Respuesta5, GETDATE(), @Origen);

		SELECT SCOPE_IDENTITY();
	END
	ELSE 
	BEGIN
		SELECT 0;
	END
END
GO