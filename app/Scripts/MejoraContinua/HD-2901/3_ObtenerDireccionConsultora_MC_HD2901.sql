CREATE PROCEDURE ObtenerDireccionConsultora
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT ISNULL(D.Direccion,D.DireccionLinea1) FROM ods.Direccion d 
	INNER JOIN ods.consultora c ON c.ConsultoraID = d.ConsultoraID
	WHERE c.Codigo=@CodigoConsultora;
END