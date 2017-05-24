USE BelcorpBolivia
GO
IF OBJECT_ID('GetImagenesByNemotecnico', 'P') IS NOT NULL
	DROP PROC GetImagenesByNemotecnico
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
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
GO

USE BelcorpCostaRica
GO
IF OBJECT_ID('GetImagenesByNemotecnico', 'P') IS NOT NULL
	DROP PROC GetImagenesByNemotecnico
GO
	
CREATE PROCEDURE [dbo].GetImagenesByNemotecnico
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
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
GO

USE BelcorpChile
GO
IF OBJECT_ID('GetImagenesByIdMatrizImagen', 'P') IS NOT NULL
	DROP PROC GetImagenesByIdMatrizImagen
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
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
GO

USE BelcorpColombia
GO
IF OBJECT_ID('GetImagenesByNemotecnico', 'P') IS NOT NULL
	DROP PROC GetImagenesByNemotecnico
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
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
GO

USE BelcorpDominicana
GO
IF OBJECT_ID('GetImagenesByNemotecnico', 'P') IS NOT NULL
	DROP PROC GetImagenesByNemotecnico
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
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
GO

USE BelcorpEcuador
GO
IF OBJECT_ID('GetImagenesByNemotecnico', 'P') IS NOT NULL
	DROP PROC GetImagenesByNemotecnico
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
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
GO

USE BelcorpGuatemala
GO
IF OBJECT_ID('GetImagenesByIdMatrizImagen', 'P') IS NOT NULL
	DROP PROC GetImagenesByIdMatrizImagen
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
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
GO

USE BelcorpMexico
GO
IF OBJECT_ID('GetImagenesByIdMatrizImagen', 'P') IS NOT NULL
	DROP PROC GetImagenesByIdMatrizImagen
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
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
GO

USE BelcorpPanama
GO
IF OBJECT_ID('GetImagenesByNemotecnico', 'P') IS NOT NULL
	DROP PROC GetImagenesByNemotecnico
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
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
GO
USE BelcorpPeru
GO
IF OBJECT_ID('GetImagenesByNemotecnico', 'P') IS NOT NULL
	DROP PROC GetImagenesByNemotecnico
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
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
GO
USE BelcorpPuertoRico
GO
IF OBJECT_ID('GetImagenesByNemotecnico', 'P') IS NOT NULL
	DROP PROC GetImagenesByNemotecnico
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
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
GO
USE BelcorpSalvador
GO
IF OBJECT_ID('GetImagenesByNemotecnico', 'P') IS NOT NULL
	DROP PROC GetImagenesByNemotecnico
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
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
GO
USE BelcorpVenezuela
GO
IF OBJECT_ID('GetImagenesByNemotecnico', 'P') IS NOT NULL
	DROP PROC GetImagenesByNemotecnico
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
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
GO
