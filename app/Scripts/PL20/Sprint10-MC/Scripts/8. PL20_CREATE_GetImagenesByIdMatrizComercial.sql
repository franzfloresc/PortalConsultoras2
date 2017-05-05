USE BelcorpBolivia
GO

IF OBJECT_ID('GetImagenesByIdMatrizImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByIdMatrizImagen
GO

BEGIN
	
CREATE PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   IdMatrizComercial,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where idMatrizComercial = @IdMatrizComercial
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END

END
GO
/*end*/

USE BelcorpChile
GO

IF OBJECT_ID('GetImagenesByIdMatrizImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByIdMatrizImagen
GO


BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   IdMatrizComercial,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where idMatrizComercial = @IdMatrizComercial
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END

END
GO
/*end*/

USE BelcorpColombia
GO

IF OBJECT_ID('GetImagenesByIdMatrizImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByIdMatrizImagen
GO


BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   IdMatrizComercial,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where idMatrizComercial = @IdMatrizComercial
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END

END
GO
/*end*/

USE BelcorpCostaRica
GO

IF OBJECT_ID('GetImagenesByIdMatrizImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByIdMatrizImagen
GO


BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   IdMatrizComercial,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where idMatrizComercial = @IdMatrizComercial
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END

END
GO
/*end*/

USE BelcorpDominicana
GO

IF OBJECT_ID('GetImagenesByIdMatrizImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByIdMatrizImagen
GO


BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   IdMatrizComercial,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where idMatrizComercial = @IdMatrizComercial
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END

END
GO
/*end*/

USE BelcorpEcuador
GO

IF OBJECT_ID('GetImagenesByIdMatrizImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByIdMatrizImagen
GO


BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   IdMatrizComercial,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where idMatrizComercial = @IdMatrizComercial
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END

END
GO
/*end*/

USE BelcorpGuatemala
GO

IF OBJECT_ID('GetImagenesByIdMatrizImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByIdMatrizImagen
GO


BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   IdMatrizComercial,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where idMatrizComercial = @IdMatrizComercial
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END

END
GO
/*end*/

USE BelcorpMexico
GO

IF OBJECT_ID('GetImagenesByIdMatrizImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByIdMatrizImagen
GO


BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   IdMatrizComercial,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where idMatrizComercial = @IdMatrizComercial
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END

END
GO
/*end*/

USE BelcorpPanama
GO

IF OBJECT_ID('GetImagenesByIdMatrizImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByIdMatrizImagen
GO


BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   IdMatrizComercial,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where idMatrizComercial = @IdMatrizComercial
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END

END
GO
/*end*/

USE BelcorpPeru
GO

IF OBJECT_ID('GetImagenesByIdMatrizImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByIdMatrizImagen
GO

BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   IdMatrizComercial,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where idMatrizComercial = @IdMatrizComercial
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END

END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF OBJECT_ID('GetImagenesByIdMatrizImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByIdMatrizImagen
GO

BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   IdMatrizComercial,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where idMatrizComercial = @IdMatrizComercial
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END


END
GO
/*end*/

USE BelcorpSalvador
GO

IF OBJECT_ID('GetImagenesByIdMatrizImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByIdMatrizImagen
GO


BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   IdMatrizComercial,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where idMatrizComercial = @IdMatrizComercial
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END

END
GO
/*end*/

USE BelcorpVenezuela
GO

IF OBJECT_ID('GetImagenesByIdMatrizImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByIdMatrizImagen
GO


BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   IdMatrizComercial,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where idMatrizComercial = @IdMatrizComercial
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END


END
GO




