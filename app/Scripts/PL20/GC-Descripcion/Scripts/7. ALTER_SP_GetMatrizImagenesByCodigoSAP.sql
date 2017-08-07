USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
(
	@CodigoSap varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

DECLARE @IdMatrizComercial INT

SET @IdMatrizComercial = (SELECT TOP 1 IdMatrizComercial FROM MatrizComercial WHERE CodigoSAP=@CodigoSap)

SELECT 
	*,
COUNT(*) OVER() AS TotalRegistros
FROM
(
	SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
	 mc.IdMatrizComercial,
	 isnull(Foto,'') Foto,
	 NemoTecnico,
	 mci.DescripcionComercial,
	 mci.FechaRegistro 
	FROM MatrizComercial mc
	left join MatrizComercialImagen mci on mci.idMatrizComercial=mc.idMatrizComercial
	where mc.idMatrizComercial = @IdMatrizComercial
) as T
order by T.FechaRegistro desc
OFFSET (@NumeroPagina-1)*@Registros ROWS
FETCH NEXT @Registros ROWS ONLY;

END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
(
	@CodigoSap varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

DECLARE @IdMatrizComercial INT

SET @IdMatrizComercial = (SELECT TOP 1 IdMatrizComercial FROM MatrizComercial WHERE CodigoSAP=@CodigoSap)

SELECT 
	*,
COUNT(*) OVER() AS TotalRegistros
FROM
(
	SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
	 mc.IdMatrizComercial,
	 isnull(Foto,'') Foto,
	 NemoTecnico,
	 mci.DescripcionComercial,
	 mci.FechaRegistro 
	FROM MatrizComercial mc
	left join MatrizComercialImagen mci on mci.idMatrizComercial=mc.idMatrizComercial
	where mc.idMatrizComercial = @IdMatrizComercial
) as T
order by T.FechaRegistro desc
OFFSET (@NumeroPagina-1)*@Registros ROWS
FETCH NEXT @Registros ROWS ONLY;

END

GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
(
	@CodigoSap varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

DECLARE @IdMatrizComercial INT

SET @IdMatrizComercial = (SELECT TOP 1 IdMatrizComercial FROM MatrizComercial WHERE CodigoSAP=@CodigoSap)

SELECT 
	*,
COUNT(*) OVER() AS TotalRegistros
FROM
(
	SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
	 mc.IdMatrizComercial,
	 isnull(Foto,'') Foto,
	 NemoTecnico,
	 mci.DescripcionComercial,
	 mci.FechaRegistro 
	FROM MatrizComercial mc
	left join MatrizComercialImagen mci on mci.idMatrizComercial=mc.idMatrizComercial
	where mc.idMatrizComercial = @IdMatrizComercial
) as T
order by T.FechaRegistro desc
OFFSET (@NumeroPagina-1)*@Registros ROWS
FETCH NEXT @Registros ROWS ONLY;

END

GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
(
	@CodigoSap varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

DECLARE @IdMatrizComercial INT

SET @IdMatrizComercial = (SELECT TOP 1 IdMatrizComercial FROM MatrizComercial WHERE CodigoSAP=@CodigoSap)

SELECT 
	*,
COUNT(*) OVER() AS TotalRegistros
FROM
(
	SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
	 mc.IdMatrizComercial,
	 isnull(Foto,'') Foto,
	 NemoTecnico,
	 mci.DescripcionComercial,
	 mci.FechaRegistro 
	FROM MatrizComercial mc
	left join MatrizComercialImagen mci on mci.idMatrizComercial=mc.idMatrizComercial
	where mc.idMatrizComercial = @IdMatrizComercial
) as T
order by T.FechaRegistro desc
OFFSET (@NumeroPagina-1)*@Registros ROWS
FETCH NEXT @Registros ROWS ONLY;

END

GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
(
	@CodigoSap varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

DECLARE @IdMatrizComercial INT

SET @IdMatrizComercial = (SELECT TOP 1 IdMatrizComercial FROM MatrizComercial WHERE CodigoSAP=@CodigoSap)

SELECT 
	*,
COUNT(*) OVER() AS TotalRegistros
FROM
(
	SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
	 mc.IdMatrizComercial,
	 isnull(Foto,'') Foto,
	 NemoTecnico,
	 mci.DescripcionComercial,
	 mci.FechaRegistro 
	FROM MatrizComercial mc
	left join MatrizComercialImagen mci on mci.idMatrizComercial=mc.idMatrizComercial
	where mc.idMatrizComercial = @IdMatrizComercial
) as T
order by T.FechaRegistro desc
OFFSET (@NumeroPagina-1)*@Registros ROWS
FETCH NEXT @Registros ROWS ONLY;

END

GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
(
	@CodigoSap varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

DECLARE @IdMatrizComercial INT

SET @IdMatrizComercial = (SELECT TOP 1 IdMatrizComercial FROM MatrizComercial WHERE CodigoSAP=@CodigoSap)

SELECT 
	*,
COUNT(*) OVER() AS TotalRegistros
FROM
(
	SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
	 mc.IdMatrizComercial,
	 isnull(Foto,'') Foto,
	 NemoTecnico,
	 mci.DescripcionComercial,
	 mci.FechaRegistro 
	FROM MatrizComercial mc
	left join MatrizComercialImagen mci on mci.idMatrizComercial=mc.idMatrizComercial
	where mc.idMatrizComercial = @IdMatrizComercial
) as T
order by T.FechaRegistro desc
OFFSET (@NumeroPagina-1)*@Registros ROWS
FETCH NEXT @Registros ROWS ONLY;

END

GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
(
	@CodigoSap varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

DECLARE @IdMatrizComercial INT

SET @IdMatrizComercial = (SELECT TOP 1 IdMatrizComercial FROM MatrizComercial WHERE CodigoSAP=@CodigoSap)

SELECT 
	*,
COUNT(*) OVER() AS TotalRegistros
FROM
(
	SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
	 mc.IdMatrizComercial,
	 isnull(Foto,'') Foto,
	 NemoTecnico,
	 mci.DescripcionComercial,
	 mci.FechaRegistro 
	FROM MatrizComercial mc
	left join MatrizComercialImagen mci on mci.idMatrizComercial=mc.idMatrizComercial
	where mc.idMatrizComercial = @IdMatrizComercial
) as T
order by T.FechaRegistro desc
OFFSET (@NumeroPagina-1)*@Registros ROWS
FETCH NEXT @Registros ROWS ONLY;

END

GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
(
	@CodigoSap varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

DECLARE @IdMatrizComercial INT

SET @IdMatrizComercial = (SELECT TOP 1 IdMatrizComercial FROM MatrizComercial WHERE CodigoSAP=@CodigoSap)

SELECT 
	*,
COUNT(*) OVER() AS TotalRegistros
FROM
(
	SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
	 mc.IdMatrizComercial,
	 isnull(Foto,'') Foto,
	 NemoTecnico,
	 mci.DescripcionComercial,
	 mci.FechaRegistro 
	FROM MatrizComercial mc
	left join MatrizComercialImagen mci on mci.idMatrizComercial=mc.idMatrizComercial
	where mc.idMatrizComercial = @IdMatrizComercial
) as T
order by T.FechaRegistro desc
OFFSET (@NumeroPagina-1)*@Registros ROWS
FETCH NEXT @Registros ROWS ONLY;

END

GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
(
	@CodigoSap varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

DECLARE @IdMatrizComercial INT

SET @IdMatrizComercial = (SELECT TOP 1 IdMatrizComercial FROM MatrizComercial WHERE CodigoSAP=@CodigoSap)

SELECT 
	*,
COUNT(*) OVER() AS TotalRegistros
FROM
(
	SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
	 mc.IdMatrizComercial,
	 isnull(Foto,'') Foto,
	 NemoTecnico,
	 mci.DescripcionComercial,
	 mci.FechaRegistro 
	FROM MatrizComercial mc
	left join MatrizComercialImagen mci on mci.idMatrizComercial=mc.idMatrizComercial
	where mc.idMatrizComercial = @IdMatrizComercial
) as T
order by T.FechaRegistro desc
OFFSET (@NumeroPagina-1)*@Registros ROWS
FETCH NEXT @Registros ROWS ONLY;

END

GO

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
(
	@CodigoSap varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

DECLARE @IdMatrizComercial INT

SET @IdMatrizComercial = (SELECT TOP 1 IdMatrizComercial FROM MatrizComercial WHERE CodigoSAP=@CodigoSap)

SELECT 
	*,
COUNT(*) OVER() AS TotalRegistros
FROM
(
	SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
	 mc.IdMatrizComercial,
	 isnull(Foto,'') Foto,
	 NemoTecnico,
	 mci.DescripcionComercial,
	 mci.FechaRegistro 
	FROM MatrizComercial mc
	left join MatrizComercialImagen mci on mci.idMatrizComercial=mc.idMatrizComercial
	where mc.idMatrizComercial = @IdMatrizComercial
) as T
order by T.FechaRegistro desc
OFFSET (@NumeroPagina-1)*@Registros ROWS
FETCH NEXT @Registros ROWS ONLY;

END

GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
(
	@CodigoSap varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

DECLARE @IdMatrizComercial INT

SET @IdMatrizComercial = (SELECT TOP 1 IdMatrizComercial FROM MatrizComercial WHERE CodigoSAP=@CodigoSap)

SELECT 
	*,
COUNT(*) OVER() AS TotalRegistros
FROM
(
	SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
	 mc.IdMatrizComercial,
	 isnull(Foto,'') Foto,
	 NemoTecnico,
	 mci.DescripcionComercial,
	 mci.FechaRegistro 
	FROM MatrizComercial mc
	left join MatrizComercialImagen mci on mci.idMatrizComercial=mc.idMatrizComercial
	where mc.idMatrizComercial = @IdMatrizComercial
) as T
order by T.FechaRegistro desc
OFFSET (@NumeroPagina-1)*@Registros ROWS
FETCH NEXT @Registros ROWS ONLY;

END

GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
(
	@CodigoSap varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

DECLARE @IdMatrizComercial INT

SET @IdMatrizComercial = (SELECT TOP 1 IdMatrizComercial FROM MatrizComercial WHERE CodigoSAP=@CodigoSap)

SELECT 
	*,
COUNT(*) OVER() AS TotalRegistros
FROM
(
	SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
	 mc.IdMatrizComercial,
	 isnull(Foto,'') Foto,
	 NemoTecnico,
	 mci.DescripcionComercial,
	 mci.FechaRegistro 
	FROM MatrizComercial mc
	left join MatrizComercialImagen mci on mci.idMatrizComercial=mc.idMatrizComercial
	where mc.idMatrizComercial = @IdMatrizComercial
) as T
order by T.FechaRegistro desc
OFFSET (@NumeroPagina-1)*@Registros ROWS
FETCH NEXT @Registros ROWS ONLY;

END

GO

USE BelcorpVenezuela
GO

ALTER PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
(
	@CodigoSap varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

DECLARE @IdMatrizComercial INT

SET @IdMatrizComercial = (SELECT TOP 1 IdMatrizComercial FROM MatrizComercial WHERE CodigoSAP=@CodigoSap)

SELECT 
	*,
COUNT(*) OVER() AS TotalRegistros
FROM
(
	SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
	 mc.IdMatrizComercial,
	 isnull(Foto,'') Foto,
	 NemoTecnico,
	 mci.DescripcionComercial,
	 mci.FechaRegistro 
	FROM MatrizComercial mc
	left join MatrizComercialImagen mci on mci.idMatrizComercial=mc.idMatrizComercial
	where mc.idMatrizComercial = @IdMatrizComercial
) as T
order by T.FechaRegistro desc
OFFSET (@NumeroPagina-1)*@Registros ROWS
FETCH NEXT @Registros ROWS ONLY;

END

GO



