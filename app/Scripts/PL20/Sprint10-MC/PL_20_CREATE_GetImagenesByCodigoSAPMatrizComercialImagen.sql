USE BelcorpBolivia
GO

BEGIN
	
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
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
			   CodigoSAP,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where codigoSAP = @CodigoSAP
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

BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
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
			   CodigoSAP,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where codigoSAP = @CodigoSAP
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

BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
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
			   CodigoSAP,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where codigoSAP = @CodigoSAP
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

BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
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
			   CodigoSAP,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where codigoSAP = @CodigoSAP
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

BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
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
			   CodigoSAP,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where codigoSAP = @CodigoSAP
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

BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
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
			   CodigoSAP,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where codigoSAP = @CodigoSAP
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

BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
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
			   CodigoSAP,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where codigoSAP = @CodigoSAP
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

BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
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
			   CodigoSAP,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where codigoSAP = @CodigoSAP
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

BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
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
			   CodigoSAP,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where codigoSAP = @CodigoSAP
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


BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
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
			   CodigoSAP,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where codigoSAP = @CodigoSAP
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

BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
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
			   CodigoSAP,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where codigoSAP = @CodigoSAP
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

BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
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
			   CodigoSAP,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where codigoSAP = @CodigoSAP
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

BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
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
			   CodigoSAP,
			   isnull(Foto,'') Foto,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where codigoSAP = @CodigoSAP
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END

END
GO




