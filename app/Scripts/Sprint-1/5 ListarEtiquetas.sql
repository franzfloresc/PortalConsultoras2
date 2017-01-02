USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[ListarEtiquetas]
	@Estado INT
AS
BEGIN
	SET NOCOUNT ON
		SELECT EtiquetaID, Descripcion, Estado
		,CASE EtiquetaID
			WHEN 1 THEN 1
			WHEN 2 THEN 2
			WHEN 3 THEN 3
			WHEN 3003 THEN 4
			WHEN 3004 THEN 5
		END AS CodigoGeneral
		FROM Etiqueta
		WHERE (Estado = @Estado OR -1 = @Estado)
		ORDER BY Descripcion ASC
	SET NOCOUNT OFF
END

GO