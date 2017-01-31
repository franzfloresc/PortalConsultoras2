

USE BelcorpColombia
GO

ALTER PROCEDURE ListarEtiquetas
	@Estado INT
AS
BEGIN
	SET NOCOUNT ON
		SELECT EtiquetaID, Descripcion, Estado 
		,case EtiquetaID
			when 1 then 1
			when 2 then 2
			when 3 then 3
			when 1006 then 4
			WHEN 3004 THEN 5
		end as CodigoGeneral
		FROM Etiqueta
		WHERE (Estado = @Estado OR -1 = @Estado)
		ORDER BY Descripcion ASC
	SET NOCOUNT OFF
END

GO

/*end*/

USE BelcorpMexico
GO

ALTER PROCEDURE ListarEtiquetas
	@Estado INT
AS
BEGIN
	SET NOCOUNT ON
		SELECT EtiquetaID, Descripcion, Estado 
		,case EtiquetaID
			when 1 then 1
			when 2 then 2
			when 3 then 3
			when 1004 then 4
			WHEN 3004 THEN 5
		end as CodigoGeneral
		FROM Etiqueta
		WHERE (Estado = @Estado OR -1 = @Estado)
		ORDER BY Descripcion ASC
	SET NOCOUNT OFF
END

GO

/*end*/


USE BelcorpPeru
GO

ALTER PROCEDURE ListarEtiquetas
	@Estado INT
AS
BEGIN
	SET NOCOUNT ON
		SELECT EtiquetaID, Descripcion, Estado
		,case EtiquetaID
			when 1 then 1
			when 2 then 2
			when 3 then 3
			when 3003 then 4
			WHEN 3004 THEN 5
		end as CodigoGeneral
		FROM Etiqueta
		WHERE (Estado = @Estado OR -1 = @Estado)
		ORDER BY Descripcion ASC
	SET NOCOUNT OFF
END

GO
