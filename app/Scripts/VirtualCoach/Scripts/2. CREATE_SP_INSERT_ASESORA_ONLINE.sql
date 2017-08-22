USE BelcorpChile
GO

CREATE PROCEDURE InsertarAsesoraOnline
(
	@CodigoConsultora varchar(10),
	@TipsGestionClientes int,
	@TipsMasClientes int,
	@TipsVentas int,
	@MasCatalogos int,
	@Origen varchar(100)
)
AS
BEGIN
	INSERT INTO AsesoraOnline 
	VALUES (@CodigoConsultora, @TipsGestionClientes, @TipsMasClientes, @TipsVentas, @MasCatalogos, GETDATE(), @Origen);

	SELECT SCOPE_IDENTITY();
END
GO