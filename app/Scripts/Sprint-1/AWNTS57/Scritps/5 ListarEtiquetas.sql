

USE BelcorpBolivia
GO

ALTER PROCEDURE ListarEtiquetas
	@Estado INT
AS
BEGIN
	SET NOCOUNT ON
		SELECT EtiquetaID, Descripcion, Estado 
		,case EtiquetaID
			when 3009 then 1
			when 3011 then 2
			when 3010 then 3
			when 3008 then 4
			WHEN 3004 THEN 5
		end as CodigoGeneral
		FROM Etiqueta
		WHERE (Estado = @Estado OR -1 = @Estado)
		ORDER BY Descripcion ASC
	SET NOCOUNT OFF
END

GO

/*end*/

USE BelcorpChile
GO

ALTER PROCEDURE ListarEtiquetas
	@Estado INT
AS
BEGIN
	SET NOCOUNT ON
		SELECT EtiquetaID, Descripcion, Estado 
		,case EtiquetaID
			when 1 then 1
			when 3 then 2
			when 2 then 3
			when 2002 then 4
			WHEN 3004 THEN 5
		end as CodigoGeneral
		FROM Etiqueta
		WHERE (Estado = @Estado OR -1 = @Estado)
		ORDER BY Descripcion ASC
	SET NOCOUNT OFF
END

GO

/*end*/

USE BelcorpCostaRica
GO

ALTER PROCEDURE ListarEtiquetas
	@Estado INT
AS
BEGIN
	SET NOCOUNT ON
		SELECT EtiquetaID, Descripcion, Estado 
		,case EtiquetaID
			when 4 then 1
			when 6 then 2
			when 5 then 3
			when 2004 then 4
			WHEN 3004 THEN 5
		end as CodigoGeneral
		FROM Etiqueta
		WHERE (Estado = @Estado OR -1 = @Estado)
		ORDER BY Descripcion ASC
	SET NOCOUNT OFF
END

GO

/*end*/

USE BelcorpDominicana
GO

ALTER PROCEDURE ListarEtiquetas
	@Estado INT
AS
BEGIN
	SET NOCOUNT ON
		SELECT EtiquetaID, Descripcion, Estado 
		,case EtiquetaID
			when 1 then 1
			when 3 then 2
			when 2 then 3
			when 2002 then 4
			WHEN 3004 THEN 5
		end as CodigoGeneral
		FROM Etiqueta
		WHERE (Estado = @Estado OR -1 = @Estado)
		ORDER BY Descripcion ASC
	SET NOCOUNT OFF
END

GO

/*end*/

USE BelcorpEcuador
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
			when 4 then 4
			WHEN 3004 THEN 5
		end as CodigoGeneral
		FROM Etiqueta
		WHERE (Estado = @Estado OR -1 = @Estado)
		ORDER BY Descripcion ASC
	SET NOCOUNT OFF
END

GO

/*end*/

USE BelcorpGuatemala
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

USE BelcorpPanama
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
			when 2002 then 4
			WHEN 3004 THEN 5
		end as CodigoGeneral
		FROM Etiqueta
		WHERE (Estado = @Estado OR -1 = @Estado)
		ORDER BY Descripcion ASC
	SET NOCOUNT OFF
END

GO

/*end*/

USE BelcorpPuertoRico
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
			when 2002 then 4
			WHEN 3004 THEN 5
		end as CodigoGeneral
		FROM Etiqueta
		WHERE (Estado = @Estado OR -1 = @Estado)
		ORDER BY Descripcion ASC
	SET NOCOUNT OFF
END

GO

/*end*/

USE BelcorpSalvador
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
			when 2002 then 4
			WHEN 3004 THEN 5
		end as CodigoGeneral
		FROM Etiqueta
		WHERE (Estado = @Estado OR -1 = @Estado)
		ORDER BY Descripcion ASC
	SET NOCOUNT OFF
END

GO

/*end*/

USE BelcorpVenezuela
GO

ALTER PROCEDURE ListarEtiquetas
	@Estado INT
AS
BEGIN
	SET NOCOUNT ON
		SELECT EtiquetaID, Descripcion, Estado 
		,case EtiquetaID
			when 1 then 1
			when 3 then 2
			when 2 then 3
			when 6 then 4
			WHEN 3004 THEN 5
		end as CodigoGeneral
		FROM Etiqueta
		WHERE (Estado = @Estado OR -1 = @Estado)
		ORDER BY Descripcion ASC
	SET NOCOUNT OFF
END

GO
