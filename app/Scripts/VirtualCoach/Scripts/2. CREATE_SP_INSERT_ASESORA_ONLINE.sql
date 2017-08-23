USE BelcorpChile
GO

CREATE PROCEDURE InsertarAsesoraOnline
(
	@CodigoConsultora varchar(10),
	@ConfirmacionInscripcion int,
	@Respuesta1 int,
	@Respuesta2 int,
	@Respuesta3 int,
	@Respuesta4 int,
	@Origen varchar(100)
)
AS
BEGIN

	IF NOT EXISTS ( SELECT TOP 1 * FROM AsesoraOnline WHERE CodigoConsultora IN (@CodigoConsultora))
	BEGIN
		INSERT INTO AsesoraOnline 
		VALUES (@CodigoConsultora, @ConfirmacionInscripcion, @Respuesta1, @Respuesta2, @Respuesta3, @Respuesta4, GETDATE(), @Origen);

		SELECT SCOPE_IDENTITY();
	END
	ELSE 
	BEGIN
		SELECT 0;
	END
END
GO