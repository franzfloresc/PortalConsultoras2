USE BelcorpBolivia
GO

BEGIN
	
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
	@NumeroPagina int,
	@Registros int,
	@TotalRegistros int OUTPUT
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
		order by FechaRegistro desc
		OFFSET (@NumeroPagina-1)*@Registros ROWS
		FETCH NEXT @Registros ROWS ONLY
	) as T;
END

END
GO
/*end*/

USE BelcorpChile
GO

BEGIN
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
	@NumeroPagina int,
	@Registros int,
	@TotalRegistros int OUTPUT
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
		order by FechaRegistro desc
		OFFSET (@NumeroPagina-1)*@Registros ROWS
		FETCH NEXT @Registros ROWS ONLY
	) as T;
END
END
GO
/*end*/

USE BelcorpColombia
GO

BEGIN
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
	@NumeroPagina int,
	@Registros int,
	@TotalRegistros int OUTPUT
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
		order by FechaRegistro desc
		OFFSET (@NumeroPagina-1)*@Registros ROWS
		FETCH NEXT @Registros ROWS ONLY
	) as T;
END
END
GO
/*end*/

USE BelcorpCostaRica
GO

BEGIN
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
	@NumeroPagina int,
	@Registros int,
	@TotalRegistros int OUTPUT
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
		order by FechaRegistro desc
		OFFSET (@NumeroPagina-1)*@Registros ROWS
		FETCH NEXT @Registros ROWS ONLY
	) as T;
END
END

END
GO
/*end*/

USE BelcorpDominicana
GO

BEGIN
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
	@NumeroPagina int,
	@Registros int,
	@TotalRegistros int OUTPUT
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
		order by FechaRegistro desc
		OFFSET (@NumeroPagina-1)*@Registros ROWS
		FETCH NEXT @Registros ROWS ONLY
	) as T;
END
END
GO
/*end*/

USE BelcorpEcuador
GO

BEGIN
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
	@NumeroPagina int,
	@Registros int,
	@TotalRegistros int OUTPUT
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
		order by FechaRegistro desc
		OFFSET (@NumeroPagina-1)*@Registros ROWS
		FETCH NEXT @Registros ROWS ONLY
	) as T;
END
END
GO
/*end*/

USE BelcorpGuatemala
GO

BEGIN
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
	@NumeroPagina int,
	@Registros int,
	@TotalRegistros int OUTPUT
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
		order by FechaRegistro desc
		OFFSET (@NumeroPagina-1)*@Registros ROWS
		FETCH NEXT @Registros ROWS ONLY
	) as T;
END
END
GO
/*end*/

USE BelcorpMexico
GO

BEGIN
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
	@NumeroPagina int,
	@Registros int,
	@TotalRegistros int OUTPUT
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
		order by FechaRegistro desc
		OFFSET (@NumeroPagina-1)*@Registros ROWS
		FETCH NEXT @Registros ROWS ONLY
	) as T;
END
END

END
GO
/*end*/

USE BelcorpPanama
GO

BEGIN
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
	@NumeroPagina int,
	@Registros int,
	@TotalRegistros int OUTPUT
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
		order by FechaRegistro desc
		OFFSET (@NumeroPagina-1)*@Registros ROWS
		FETCH NEXT @Registros ROWS ONLY
	) as T;
END
END

END
GO
/*end*/

USE BelcorpPeru
GO


BEGIN
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
	@NumeroPagina int,
	@Registros int,
	@TotalRegistros int OUTPUT
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
		order by FechaRegistro desc
		OFFSET (@NumeroPagina-1)*@Registros ROWS
		FETCH NEXT @Registros ROWS ONLY
	) as T;
END
END
GO
/*end*/

USE BelcorpPuertoRico
GO

BEGIN
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
	@NumeroPagina int,
	@Registros int,
	@TotalRegistros int OUTPUT
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
		order by FechaRegistro desc
		OFFSET (@NumeroPagina-1)*@Registros ROWS
		FETCH NEXT @Registros ROWS ONLY
	) as T;
END

END
GO
/*end*/

USE BelcorpSalvador
GO


BEGIN
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
	@NumeroPagina int,
	@Registros int,
	@TotalRegistros int OUTPUT
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
		order by FechaRegistro desc
		OFFSET (@NumeroPagina-1)*@Registros ROWS
		FETCH NEXT @Registros ROWS ONLY
	) as T;
END
END
GO
/*end*/

USE BelcorpVenezuela
GO

BEGIN
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50),
	@NumeroPagina int,
	@Registros int,
	@TotalRegistros int OUTPUT
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
		order by FechaRegistro desc
		OFFSET (@NumeroPagina-1)*@Registros ROWS
		FETCH NEXT @Registros ROWS ONLY
	) as T;
END

END
GO




