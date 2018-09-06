IF (OBJECT_ID ( 'dbo.ObtenerDireccionConsultora', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerDireccionConsultora
GO
CREATE PROCEDURE ObtenerDireccionConsultora
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP(1)
		ISNULL(D.Direccion,D.DireccionLinea1) AS Direccion, u.UnidadGeografica1 AS Ciudad
	FROM ods.Direccion d
	INNER JOIN ods.consultora c ON c.ConsultoraID = d.ConsultoraID
	LEFT JOIN dbo.Ubigeo u ON u.CodigoUbigeo = d.UnidadGeografica
	WHERE
		d.tipoDireccion='Domicilio' AND
		c.Codigo=@CodigoConsultora;
END