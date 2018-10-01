USE BelcorpBolivia
GO
IF OBJECT_ID('GetMatrizImagenesByCodigoSap', 'P') IS NOT NULL
DROP PROC GetMatrizImagenesByCodigoSap
GO

CREATE PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
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
IF OBJECT_ID('GetMatrizImagenesByCodigoSap', 'P') IS NOT NULL
DROP PROC GetMatrizImagenesByCodigoSap
GO

CREATE PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
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
IF OBJECT_ID('GetMatrizImagenesByCodigoSap', 'P') IS NOT NULL
DROP PROC GetMatrizImagenesByCodigoSap
GO

CREATE PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
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
IF OBJECT_ID('GetMatrizImagenesByCodigoSap', 'P') IS NOT NULL
DROP PROC GetMatrizImagenesByCodigoSap
GO

CREATE PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
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
IF OBJECT_ID('GetMatrizImagenesByCodigoSap', 'P') IS NOT NULL
DROP PROC GetMatrizImagenesByCodigoSap
GO

CREATE PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
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
IF OBJECT_ID('GetMatrizImagenesByCodigoSap', 'P') IS NOT NULL
DROP PROC GetMatrizImagenesByCodigoSap
GO

CREATE PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
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
IF OBJECT_ID('GetMatrizImagenesByCodigoSap', 'P') IS NOT NULL
DROP PROC GetMatrizImagenesByCodigoSap
GO

CREATE PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
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
IF OBJECT_ID('GetMatrizImagenesByCodigoSap', 'P') IS NOT NULL
DROP PROC GetMatrizImagenesByCodigoSap
GO

CREATE PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
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
IF OBJECT_ID('GetMatrizImagenesByCodigoSap', 'P') IS NOT NULL
DROP PROC GetMatrizImagenesByCodigoSap
GO

CREATE PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
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
IF OBJECT_ID('GetMatrizImagenesByCodigoSap', 'P') IS NOT NULL
DROP PROC GetMatrizImagenesByCodigoSap
GO

CREATE PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
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
IF OBJECT_ID('GetMatrizImagenesByCodigoSap', 'P') IS NOT NULL
DROP PROC GetMatrizImagenesByCodigoSap
GO

CREATE PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
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
IF OBJECT_ID('GetMatrizImagenesByCodigoSap', 'P') IS NOT NULL
DROP PROC GetMatrizImagenesByCodigoSap
GO

CREATE PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
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
IF OBJECT_ID('GetMatrizImagenesByCodigoSap', 'P') IS NOT NULL
DROP PROC GetMatrizImagenesByCodigoSap
GO

CREATE PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
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
