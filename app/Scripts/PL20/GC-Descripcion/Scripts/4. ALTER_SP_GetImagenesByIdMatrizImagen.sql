USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
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
			   NemoTecnico,
			   DescripcionComercial,
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

ALTER PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
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
			   NemoTecnico,
			   DescripcionComercial,
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

ALTER PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
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
			   NemoTecnico,
			   DescripcionComercial,
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

ALTER PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
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
			   NemoTecnico,
			   DescripcionComercial,
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

ALTER PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
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
			   NemoTecnico,
			   DescripcionComercial,
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

ALTER PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
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
			   NemoTecnico,
			   DescripcionComercial,
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

ALTER PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
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
			   NemoTecnico,
			   DescripcionComercial,
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

ALTER PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
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
			   NemoTecnico,
			   DescripcionComercial,
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

ALTER PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
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
			   NemoTecnico,
			   DescripcionComercial,
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

ALTER PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
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
			   NemoTecnico,
			   DescripcionComercial,
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

ALTER PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
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
			   NemoTecnico,
			   DescripcionComercial,
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

ALTER PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
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
			   NemoTecnico,
			   DescripcionComercial,
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

ALTER PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
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
			   NemoTecnico,
			   DescripcionComercial,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where idMatrizComercial = @IdMatrizComercial
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;
GO
