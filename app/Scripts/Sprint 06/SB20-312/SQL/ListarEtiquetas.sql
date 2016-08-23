
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
		end as CodigoGeneral
		FROM Etiqueta
		WHERE (Estado = @Estado OR -1 = @Estado)
		ORDER BY Descripcion ASC
	SET NOCOUNT OFF
END

GO

/*end*/

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
			when 1007 then 5
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
			when 1005 then 5
		end as CodigoGeneral
		FROM Etiqueta
		WHERE (Estado = @Estado OR -1 = @Estado)
		ORDER BY Descripcion ASC
	SET NOCOUNT OFF
END

GO

/*end*/

USE BelcorpBolivia
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
			when 3002 then 4
			when 3003 then 5
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
			when 2 then 2
			when 3 then 3
			when 2002 then 4
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
			when 5 then 3
			when 6 then 2
			when 2004 then 4
			when 2005 then 5
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
			when 2 then 2
			when 3 then 3
			when 2002 then 4
			when 2003 then 5
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
			when 1005 then 5
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
			when 2003 then 5
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
			when 2003 then 5
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
			when 2003 then 5
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
			when 2 then 2
			when 3 then 3
			when 6 then 4
		end as CodigoGeneral
		FROM Etiqueta
		WHERE (Estado = @Estado OR -1 = @Estado)
		ORDER BY Descripcion ASC
	SET NOCOUNT OFF
END

GO


