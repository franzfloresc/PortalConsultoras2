USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[GetBeneficioCaminoBrillante]
(
@CodigoNivel varchar(3) = ''
)
AS
BEGIN
	if (@CodigoNivel = '')
	BEGIN
		SELECT 
			 0 AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		Where Estado = 1
	END
	ELSE
	BEGIN
		SELECT 
			 Cast(ROW_NUMBER() OVER(ORDER BY BeneficioID ASC) as int) AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		where CodigoNivel = @CodigoNivel
		Order By CodigoBeneficio asc
	END
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[GetBeneficioCaminoBrillante]
(
@CodigoNivel varchar(3) = ''
)
AS
BEGIN
	if (@CodigoNivel = '')
	BEGIN
		SELECT 
			 0 AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		Where Estado = 1
	END
	ELSE
	BEGIN
		SELECT 
			 Cast(ROW_NUMBER() OVER(ORDER BY BeneficioID ASC) as int) AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		where CodigoNivel = @CodigoNivel
		Order By CodigoBeneficio asc
	END
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[GetBeneficioCaminoBrillante]
(
@CodigoNivel varchar(3) = ''
)
AS
BEGIN
	if (@CodigoNivel = '')
	BEGIN
		SELECT 
			 0 AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		Where Estado = 1
	END
	ELSE
	BEGIN
		SELECT 
			 Cast(ROW_NUMBER() OVER(ORDER BY BeneficioID ASC) as int) AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		where CodigoNivel = @CodigoNivel
		Order By CodigoBeneficio asc
	END
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[GetBeneficioCaminoBrillante]
(
@CodigoNivel varchar(3) = ''
)
AS
BEGIN
	if (@CodigoNivel = '')
	BEGIN
		SELECT 
			 0 AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		Where Estado = 1
	END
	ELSE
	BEGIN
		SELECT 
			 Cast(ROW_NUMBER() OVER(ORDER BY BeneficioID ASC) as int) AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		where CodigoNivel = @CodigoNivel
		Order By CodigoBeneficio asc
	END
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[GetBeneficioCaminoBrillante]
(
@CodigoNivel varchar(3) = ''
)
AS
BEGIN
	if (@CodigoNivel = '')
	BEGIN
		SELECT 
			 0 AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		Where Estado = 1
	END
	ELSE
	BEGIN
		SELECT 
			 Cast(ROW_NUMBER() OVER(ORDER BY BeneficioID ASC) as int) AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		where CodigoNivel = @CodigoNivel
		Order By CodigoBeneficio asc
	END
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[GetBeneficioCaminoBrillante]
(
@CodigoNivel varchar(3) = ''
)
AS
BEGIN
	if (@CodigoNivel = '')
	BEGIN
		SELECT 
			 0 AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		Where Estado = 1
	END
	ELSE
	BEGIN
		SELECT 
			 Cast(ROW_NUMBER() OVER(ORDER BY BeneficioID ASC) as int) AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		where CodigoNivel = @CodigoNivel
		Order By CodigoBeneficio asc
	END
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[GetBeneficioCaminoBrillante]
(
@CodigoNivel varchar(3) = ''
)
AS
BEGIN
	if (@CodigoNivel = '')
	BEGIN
		SELECT 
			 0 AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		Where Estado = 1
	END
	ELSE
	BEGIN
		SELECT 
			 Cast(ROW_NUMBER() OVER(ORDER BY BeneficioID ASC) as int) AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		where CodigoNivel = @CodigoNivel
		Order By CodigoBeneficio asc
	END
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[GetBeneficioCaminoBrillante]
(
@CodigoNivel varchar(3) = ''
)
AS
BEGIN
	if (@CodigoNivel = '')
	BEGIN
		SELECT 
			 0 AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		Where Estado = 1
	END
	ELSE
	BEGIN
		SELECT 
			 Cast(ROW_NUMBER() OVER(ORDER BY BeneficioID ASC) as int) AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		where CodigoNivel = @CodigoNivel
		Order By CodigoBeneficio asc
	END
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[GetBeneficioCaminoBrillante]
(
@CodigoNivel varchar(3) = ''
)
AS
BEGIN
	if (@CodigoNivel = '')
	BEGIN
		SELECT 
			 0 AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		Where Estado = 1
	END
	ELSE
	BEGIN
		SELECT 
			 Cast(ROW_NUMBER() OVER(ORDER BY BeneficioID ASC) as int) AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		where CodigoNivel = @CodigoNivel
		Order By CodigoBeneficio asc
	END
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[GetBeneficioCaminoBrillante]
(
@CodigoNivel varchar(3) = ''
)
AS
BEGIN
	if (@CodigoNivel = '')
	BEGIN
		SELECT 
			 0 AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		Where Estado = 1
	END
	ELSE
	BEGIN
		SELECT 
			 Cast(ROW_NUMBER() OVER(ORDER BY BeneficioID ASC) as int) AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		where CodigoNivel = @CodigoNivel
		Order By CodigoBeneficio asc
	END
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[GetBeneficioCaminoBrillante]
(
@CodigoNivel varchar(3) = ''
)
AS
BEGIN
	if (@CodigoNivel = '')
	BEGIN
		SELECT 
			 0 AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		Where Estado = 1
	END
	ELSE
	BEGIN
		SELECT 
			 Cast(ROW_NUMBER() OVER(ORDER BY BeneficioID ASC) as int) AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		where CodigoNivel = @CodigoNivel
		Order By CodigoBeneficio asc
	END
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[GetBeneficioCaminoBrillante]
(
@CodigoNivel varchar(3) = ''
)
AS
BEGIN
	if (@CodigoNivel = '')
	BEGIN
		SELECT 
			 0 AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		Where Estado = 1
	END
	ELSE
	BEGIN
		SELECT 
			 Cast(ROW_NUMBER() OVER(ORDER BY BeneficioID ASC) as int) AS Registro
			,CodigoNivel AS CodigoNivel
			,CodigoBeneficio AS CodigoBeneficio
			,NombreBeneficio AS NombreBeneficio
			,Descripcion AS Descripcion
			,Orden
			,UrlIcono AS Icono
			,Estado
		FROM  dbo.BeneficioCaminoBrillante WITH (NOLOCK)
		where CodigoNivel = @CodigoNivel
		Order By CodigoBeneficio asc
	END
END
GO

