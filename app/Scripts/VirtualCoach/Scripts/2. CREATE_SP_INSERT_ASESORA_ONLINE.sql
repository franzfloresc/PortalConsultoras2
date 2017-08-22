USE BelcorpChile
GO

CREATE PROCEDURE InsertarAsesoraOnline
(
	@CodigoConsultora varchar(10),
	@Respuesta1 int,
	@Respuesta2 int,
	@Respuesta3 int,
	@Respuesta4 int,
	@Origen varchar(100)
)
AS
BEGIN
	INSERT INTO AsesoraOnline 
	VALUES (@CodigoConsultora, @Respuesta1, @Respuesta2, @Respuesta3, @Respuesta4, GETDATE(), @Origen);

	SELECT SCOPE_IDENTITY();
END
GO