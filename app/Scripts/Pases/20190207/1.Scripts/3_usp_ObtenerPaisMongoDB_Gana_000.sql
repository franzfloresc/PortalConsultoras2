USE BelcorpPeru
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_ObtenerPaisMongoDB') 
  BEGIN 
      DROP PROCEDURE dbo.usp_ObtenerPaisMongoDB 
  END 
GO 


CREATE PROCEDURE dbo.usp_ObtenerPaisMongoDB
	@Estrategia CHAR(3)
AS

DECLARE @Codigo CHAR(17) = 'MSPersonalizacion'

SELECT Pais FROM 
(
	SELECT 
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PE' END AS 'Pais'
				FROM BelcorpPeru.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPeru.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpChile
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CL' END AS 'Pais'
				FROM BelcorpChile.dbo.ConfiguracionPais config
				INNER JOIN BelcorpChile.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpBolivia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'BO' END AS 'Pais'
				FROM BelcorpBolivia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpBolivia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpColombia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CO' END AS 'Pais'
				FROM BelcorpColombia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpColombia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpCostaRica
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CR' END AS 'Pais'
				FROM BelcorpCostaRica.dbo.ConfiguracionPais config
				INNER JOIN BelcorpCostaRica.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpDominicana
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'DO' END AS 'Pais'
				FROM BelcorpDominicana.dbo.ConfiguracionPais config
				INNER JOIN BelcorpDominicana.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpEcuador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'EC' END AS 'Pais'
				FROM BelcorpEcuador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpEcuador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpGuatemala
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'GU' END AS 'Pais'
				FROM BelcorpGuatemala.dbo.ConfiguracionPais config
				INNER JOIN BelcorpGuatemala.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpMexico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'MX' END AS 'Pais'
				FROM BelcorpMexico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpMexico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPanama
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PA' END AS 'Pais'
				FROM BelcorpPanama.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPanama.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPuertoRico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PR' END AS 'Pais'
				FROM BelcorpPuertoRico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPuertoRico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpSalvador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'SV' END AS 'Pais'
				FROM BelcorpSalvador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpSalvador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo


) Tabla 
WHERE Pais IS NOT NULL

GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_ObtenerPaisMongoDB') 
  BEGIN 
      DROP PROCEDURE dbo.usp_ObtenerPaisMongoDB 
  END 
GO 


CREATE PROCEDURE dbo.usp_ObtenerPaisMongoDB
	@Estrategia CHAR(3)
AS

DECLARE @Codigo CHAR(17) = 'MSPersonalizacion'

SELECT Pais FROM 
(
	SELECT 
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PE' END AS 'Pais'
				FROM BelcorpPeru.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPeru.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpChile
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CL' END AS 'Pais'
				FROM BelcorpChile.dbo.ConfiguracionPais config
				INNER JOIN BelcorpChile.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpBolivia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'BO' END AS 'Pais'
				FROM BelcorpBolivia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpBolivia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpColombia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CO' END AS 'Pais'
				FROM BelcorpColombia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpColombia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpCostaRica
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CR' END AS 'Pais'
				FROM BelcorpCostaRica.dbo.ConfiguracionPais config
				INNER JOIN BelcorpCostaRica.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpDominicana
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'DO' END AS 'Pais'
				FROM BelcorpDominicana.dbo.ConfiguracionPais config
				INNER JOIN BelcorpDominicana.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpEcuador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'EC' END AS 'Pais'
				FROM BelcorpEcuador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpEcuador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpGuatemala
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'GU' END AS 'Pais'
				FROM BelcorpGuatemala.dbo.ConfiguracionPais config
				INNER JOIN BelcorpGuatemala.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpMexico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'MX' END AS 'Pais'
				FROM BelcorpMexico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpMexico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPanama
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PA' END AS 'Pais'
				FROM BelcorpPanama.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPanama.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPuertoRico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PR' END AS 'Pais'
				FROM BelcorpPuertoRico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPuertoRico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpSalvador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'SV' END AS 'Pais'
				FROM BelcorpSalvador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpSalvador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo


) Tabla 
WHERE Pais IS NOT NULL

GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_ObtenerPaisMongoDB') 
  BEGIN 
      DROP PROCEDURE dbo.usp_ObtenerPaisMongoDB 
  END 
GO 


CREATE PROCEDURE dbo.usp_ObtenerPaisMongoDB
	@Estrategia CHAR(3)
AS

DECLARE @Codigo CHAR(17) = 'MSPersonalizacion'

SELECT Pais FROM 
(
	SELECT 
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PE' END AS 'Pais'
				FROM BelcorpPeru.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPeru.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpChile
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CL' END AS 'Pais'
				FROM BelcorpChile.dbo.ConfiguracionPais config
				INNER JOIN BelcorpChile.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpBolivia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'BO' END AS 'Pais'
				FROM BelcorpBolivia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpBolivia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpColombia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CO' END AS 'Pais'
				FROM BelcorpColombia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpColombia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpCostaRica
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CR' END AS 'Pais'
				FROM BelcorpCostaRica.dbo.ConfiguracionPais config
				INNER JOIN BelcorpCostaRica.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpDominicana
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'DO' END AS 'Pais'
				FROM BelcorpDominicana.dbo.ConfiguracionPais config
				INNER JOIN BelcorpDominicana.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpEcuador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'EC' END AS 'Pais'
				FROM BelcorpEcuador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpEcuador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpGuatemala
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'GU' END AS 'Pais'
				FROM BelcorpGuatemala.dbo.ConfiguracionPais config
				INNER JOIN BelcorpGuatemala.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpMexico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'MX' END AS 'Pais'
				FROM BelcorpMexico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpMexico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPanama
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PA' END AS 'Pais'
				FROM BelcorpPanama.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPanama.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPuertoRico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PR' END AS 'Pais'
				FROM BelcorpPuertoRico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPuertoRico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpSalvador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'SV' END AS 'Pais'
				FROM BelcorpSalvador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpSalvador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo


) Tabla 
WHERE Pais IS NOT NULL

GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_ObtenerPaisMongoDB') 
  BEGIN 
      DROP PROCEDURE dbo.usp_ObtenerPaisMongoDB 
  END 
GO 


CREATE PROCEDURE dbo.usp_ObtenerPaisMongoDB
	@Estrategia CHAR(3)
AS

DECLARE @Codigo CHAR(17) = 'MSPersonalizacion'

SELECT Pais FROM 
(
	SELECT 
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PE' END AS 'Pais'
				FROM BelcorpPeru.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPeru.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpChile
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CL' END AS 'Pais'
				FROM BelcorpChile.dbo.ConfiguracionPais config
				INNER JOIN BelcorpChile.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpBolivia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'BO' END AS 'Pais'
				FROM BelcorpBolivia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpBolivia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpColombia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CO' END AS 'Pais'
				FROM BelcorpColombia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpColombia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpCostaRica
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CR' END AS 'Pais'
				FROM BelcorpCostaRica.dbo.ConfiguracionPais config
				INNER JOIN BelcorpCostaRica.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpDominicana
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'DO' END AS 'Pais'
				FROM BelcorpDominicana.dbo.ConfiguracionPais config
				INNER JOIN BelcorpDominicana.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpEcuador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'EC' END AS 'Pais'
				FROM BelcorpEcuador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpEcuador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpGuatemala
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'GU' END AS 'Pais'
				FROM BelcorpGuatemala.dbo.ConfiguracionPais config
				INNER JOIN BelcorpGuatemala.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpMexico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'MX' END AS 'Pais'
				FROM BelcorpMexico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpMexico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPanama
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PA' END AS 'Pais'
				FROM BelcorpPanama.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPanama.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPuertoRico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PR' END AS 'Pais'
				FROM BelcorpPuertoRico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPuertoRico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpSalvador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'SV' END AS 'Pais'
				FROM BelcorpSalvador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpSalvador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo


) Tabla 
WHERE Pais IS NOT NULL

GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_ObtenerPaisMongoDB') 
  BEGIN 
      DROP PROCEDURE dbo.usp_ObtenerPaisMongoDB 
  END 
GO 


CREATE PROCEDURE dbo.usp_ObtenerPaisMongoDB
	@Estrategia CHAR(3)
AS

DECLARE @Codigo CHAR(17) = 'MSPersonalizacion'

SELECT Pais FROM 
(
	SELECT 
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PE' END AS 'Pais'
				FROM BelcorpPeru.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPeru.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpChile
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CL' END AS 'Pais'
				FROM BelcorpChile.dbo.ConfiguracionPais config
				INNER JOIN BelcorpChile.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpBolivia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'BO' END AS 'Pais'
				FROM BelcorpBolivia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpBolivia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpColombia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CO' END AS 'Pais'
				FROM BelcorpColombia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpColombia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpCostaRica
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CR' END AS 'Pais'
				FROM BelcorpCostaRica.dbo.ConfiguracionPais config
				INNER JOIN BelcorpCostaRica.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpDominicana
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'DO' END AS 'Pais'
				FROM BelcorpDominicana.dbo.ConfiguracionPais config
				INNER JOIN BelcorpDominicana.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpEcuador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'EC' END AS 'Pais'
				FROM BelcorpEcuador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpEcuador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpGuatemala
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'GU' END AS 'Pais'
				FROM BelcorpGuatemala.dbo.ConfiguracionPais config
				INNER JOIN BelcorpGuatemala.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpMexico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'MX' END AS 'Pais'
				FROM BelcorpMexico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpMexico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPanama
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PA' END AS 'Pais'
				FROM BelcorpPanama.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPanama.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPuertoRico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PR' END AS 'Pais'
				FROM BelcorpPuertoRico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPuertoRico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpSalvador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'SV' END AS 'Pais'
				FROM BelcorpSalvador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpSalvador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo


) Tabla 
WHERE Pais IS NOT NULL

GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_ObtenerPaisMongoDB') 
  BEGIN 
      DROP PROCEDURE dbo.usp_ObtenerPaisMongoDB 
  END 
GO 


CREATE PROCEDURE dbo.usp_ObtenerPaisMongoDB
	@Estrategia CHAR(3)
AS

DECLARE @Codigo CHAR(17) = 'MSPersonalizacion'

SELECT Pais FROM 
(
	SELECT 
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PE' END AS 'Pais'
				FROM BelcorpPeru.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPeru.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpChile
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CL' END AS 'Pais'
				FROM BelcorpChile.dbo.ConfiguracionPais config
				INNER JOIN BelcorpChile.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpBolivia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'BO' END AS 'Pais'
				FROM BelcorpBolivia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpBolivia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpColombia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CO' END AS 'Pais'
				FROM BelcorpColombia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpColombia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpCostaRica
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CR' END AS 'Pais'
				FROM BelcorpCostaRica.dbo.ConfiguracionPais config
				INNER JOIN BelcorpCostaRica.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpDominicana
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'DO' END AS 'Pais'
				FROM BelcorpDominicana.dbo.ConfiguracionPais config
				INNER JOIN BelcorpDominicana.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpEcuador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'EC' END AS 'Pais'
				FROM BelcorpEcuador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpEcuador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpGuatemala
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'GU' END AS 'Pais'
				FROM BelcorpGuatemala.dbo.ConfiguracionPais config
				INNER JOIN BelcorpGuatemala.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpMexico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'MX' END AS 'Pais'
				FROM BelcorpMexico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpMexico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPanama
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PA' END AS 'Pais'
				FROM BelcorpPanama.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPanama.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPuertoRico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PR' END AS 'Pais'
				FROM BelcorpPuertoRico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPuertoRico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpSalvador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'SV' END AS 'Pais'
				FROM BelcorpSalvador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpSalvador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo


) Tabla 
WHERE Pais IS NOT NULL

GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_ObtenerPaisMongoDB') 
  BEGIN 
      DROP PROCEDURE dbo.usp_ObtenerPaisMongoDB 
  END 
GO 


CREATE PROCEDURE dbo.usp_ObtenerPaisMongoDB
	@Estrategia CHAR(3)
AS

DECLARE @Codigo CHAR(17) = 'MSPersonalizacion'

SELECT Pais FROM 
(
	SELECT 
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PE' END AS 'Pais'
				FROM BelcorpPeru.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPeru.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpChile
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CL' END AS 'Pais'
				FROM BelcorpChile.dbo.ConfiguracionPais config
				INNER JOIN BelcorpChile.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpBolivia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'BO' END AS 'Pais'
				FROM BelcorpBolivia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpBolivia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpColombia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CO' END AS 'Pais'
				FROM BelcorpColombia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpColombia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpCostaRica
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CR' END AS 'Pais'
				FROM BelcorpCostaRica.dbo.ConfiguracionPais config
				INNER JOIN BelcorpCostaRica.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpDominicana
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'DO' END AS 'Pais'
				FROM BelcorpDominicana.dbo.ConfiguracionPais config
				INNER JOIN BelcorpDominicana.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpEcuador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'EC' END AS 'Pais'
				FROM BelcorpEcuador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpEcuador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpGuatemala
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'GU' END AS 'Pais'
				FROM BelcorpGuatemala.dbo.ConfiguracionPais config
				INNER JOIN BelcorpGuatemala.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpMexico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'MX' END AS 'Pais'
				FROM BelcorpMexico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpMexico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPanama
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PA' END AS 'Pais'
				FROM BelcorpPanama.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPanama.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPuertoRico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PR' END AS 'Pais'
				FROM BelcorpPuertoRico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPuertoRico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpSalvador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'SV' END AS 'Pais'
				FROM BelcorpSalvador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpSalvador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo


) Tabla 
WHERE Pais IS NOT NULL

GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_ObtenerPaisMongoDB') 
  BEGIN 
      DROP PROCEDURE dbo.usp_ObtenerPaisMongoDB 
  END 
GO 


CREATE PROCEDURE dbo.usp_ObtenerPaisMongoDB
	@Estrategia CHAR(3)
AS

DECLARE @Codigo CHAR(17) = 'MSPersonalizacion'

SELECT Pais FROM 
(
	SELECT 
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PE' END AS 'Pais'
				FROM BelcorpPeru.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPeru.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpChile
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CL' END AS 'Pais'
				FROM BelcorpChile.dbo.ConfiguracionPais config
				INNER JOIN BelcorpChile.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpBolivia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'BO' END AS 'Pais'
				FROM BelcorpBolivia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpBolivia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpColombia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CO' END AS 'Pais'
				FROM BelcorpColombia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpColombia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpCostaRica
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CR' END AS 'Pais'
				FROM BelcorpCostaRica.dbo.ConfiguracionPais config
				INNER JOIN BelcorpCostaRica.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpDominicana
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'DO' END AS 'Pais'
				FROM BelcorpDominicana.dbo.ConfiguracionPais config
				INNER JOIN BelcorpDominicana.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpEcuador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'EC' END AS 'Pais'
				FROM BelcorpEcuador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpEcuador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpGuatemala
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'GU' END AS 'Pais'
				FROM BelcorpGuatemala.dbo.ConfiguracionPais config
				INNER JOIN BelcorpGuatemala.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpMexico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'MX' END AS 'Pais'
				FROM BelcorpMexico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpMexico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPanama
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PA' END AS 'Pais'
				FROM BelcorpPanama.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPanama.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPuertoRico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PR' END AS 'Pais'
				FROM BelcorpPuertoRico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPuertoRico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpSalvador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'SV' END AS 'Pais'
				FROM BelcorpSalvador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpSalvador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo


) Tabla 
WHERE Pais IS NOT NULL

GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_ObtenerPaisMongoDB') 
  BEGIN 
      DROP PROCEDURE dbo.usp_ObtenerPaisMongoDB 
  END 
GO 


CREATE PROCEDURE dbo.usp_ObtenerPaisMongoDB
	@Estrategia CHAR(3)
AS

DECLARE @Codigo CHAR(17) = 'MSPersonalizacion'

SELECT Pais FROM 
(
	SELECT 
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PE' END AS 'Pais'
				FROM BelcorpPeru.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPeru.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpChile
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CL' END AS 'Pais'
				FROM BelcorpChile.dbo.ConfiguracionPais config
				INNER JOIN BelcorpChile.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpBolivia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'BO' END AS 'Pais'
				FROM BelcorpBolivia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpBolivia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpColombia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CO' END AS 'Pais'
				FROM BelcorpColombia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpColombia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpCostaRica
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CR' END AS 'Pais'
				FROM BelcorpCostaRica.dbo.ConfiguracionPais config
				INNER JOIN BelcorpCostaRica.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpDominicana
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'DO' END AS 'Pais'
				FROM BelcorpDominicana.dbo.ConfiguracionPais config
				INNER JOIN BelcorpDominicana.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpEcuador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'EC' END AS 'Pais'
				FROM BelcorpEcuador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpEcuador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpGuatemala
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'GU' END AS 'Pais'
				FROM BelcorpGuatemala.dbo.ConfiguracionPais config
				INNER JOIN BelcorpGuatemala.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpMexico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'MX' END AS 'Pais'
				FROM BelcorpMexico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpMexico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPanama
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PA' END AS 'Pais'
				FROM BelcorpPanama.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPanama.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPuertoRico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PR' END AS 'Pais'
				FROM BelcorpPuertoRico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPuertoRico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpSalvador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'SV' END AS 'Pais'
				FROM BelcorpSalvador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpSalvador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo


) Tabla 
WHERE Pais IS NOT NULL

GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_ObtenerPaisMongoDB') 
  BEGIN 
      DROP PROCEDURE dbo.usp_ObtenerPaisMongoDB 
  END 
GO 


CREATE PROCEDURE dbo.usp_ObtenerPaisMongoDB
	@Estrategia CHAR(3)
AS

DECLARE @Codigo CHAR(17) = 'MSPersonalizacion'

SELECT Pais FROM 
(
	SELECT 
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PE' END AS 'Pais'
				FROM BelcorpPeru.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPeru.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpChile
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CL' END AS 'Pais'
				FROM BelcorpChile.dbo.ConfiguracionPais config
				INNER JOIN BelcorpChile.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpBolivia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'BO' END AS 'Pais'
				FROM BelcorpBolivia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpBolivia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpColombia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CO' END AS 'Pais'
				FROM BelcorpColombia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpColombia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpCostaRica
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CR' END AS 'Pais'
				FROM BelcorpCostaRica.dbo.ConfiguracionPais config
				INNER JOIN BelcorpCostaRica.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpDominicana
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'DO' END AS 'Pais'
				FROM BelcorpDominicana.dbo.ConfiguracionPais config
				INNER JOIN BelcorpDominicana.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpEcuador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'EC' END AS 'Pais'
				FROM BelcorpEcuador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpEcuador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpGuatemala
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'GU' END AS 'Pais'
				FROM BelcorpGuatemala.dbo.ConfiguracionPais config
				INNER JOIN BelcorpGuatemala.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpMexico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'MX' END AS 'Pais'
				FROM BelcorpMexico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpMexico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPanama
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PA' END AS 'Pais'
				FROM BelcorpPanama.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPanama.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPuertoRico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PR' END AS 'Pais'
				FROM BelcorpPuertoRico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPuertoRico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpSalvador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'SV' END AS 'Pais'
				FROM BelcorpSalvador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpSalvador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo


) Tabla 
WHERE Pais IS NOT NULL

GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_ObtenerPaisMongoDB') 
  BEGIN 
      DROP PROCEDURE dbo.usp_ObtenerPaisMongoDB 
  END 
GO 


CREATE PROCEDURE dbo.usp_ObtenerPaisMongoDB
	@Estrategia CHAR(3)
AS

DECLARE @Codigo CHAR(17) = 'MSPersonalizacion'

SELECT Pais FROM 
(
	SELECT 
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PE' END AS 'Pais'
				FROM BelcorpPeru.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPeru.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpChile
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CL' END AS 'Pais'
				FROM BelcorpChile.dbo.ConfiguracionPais config
				INNER JOIN BelcorpChile.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpBolivia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'BO' END AS 'Pais'
				FROM BelcorpBolivia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpBolivia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpColombia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CO' END AS 'Pais'
				FROM BelcorpColombia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpColombia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpCostaRica
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CR' END AS 'Pais'
				FROM BelcorpCostaRica.dbo.ConfiguracionPais config
				INNER JOIN BelcorpCostaRica.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpDominicana
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'DO' END AS 'Pais'
				FROM BelcorpDominicana.dbo.ConfiguracionPais config
				INNER JOIN BelcorpDominicana.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpEcuador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'EC' END AS 'Pais'
				FROM BelcorpEcuador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpEcuador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpGuatemala
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'GU' END AS 'Pais'
				FROM BelcorpGuatemala.dbo.ConfiguracionPais config
				INNER JOIN BelcorpGuatemala.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpMexico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'MX' END AS 'Pais'
				FROM BelcorpMexico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpMexico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPanama
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PA' END AS 'Pais'
				FROM BelcorpPanama.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPanama.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPuertoRico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PR' END AS 'Pais'
				FROM BelcorpPuertoRico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPuertoRico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpSalvador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'SV' END AS 'Pais'
				FROM BelcorpSalvador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpSalvador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo


) Tabla 
WHERE Pais IS NOT NULL

GO

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_ObtenerPaisMongoDB') 
  BEGIN 
      DROP PROCEDURE dbo.usp_ObtenerPaisMongoDB 
  END 
GO 


CREATE PROCEDURE dbo.usp_ObtenerPaisMongoDB
	@Estrategia CHAR(3)
AS

DECLARE @Codigo CHAR(17) = 'MSPersonalizacion'

SELECT Pais FROM 
(
	SELECT 
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PE' END AS 'Pais'
				FROM BelcorpPeru.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPeru.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpChile
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CL' END AS 'Pais'
				FROM BelcorpChile.dbo.ConfiguracionPais config
				INNER JOIN BelcorpChile.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpBolivia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'BO' END AS 'Pais'
				FROM BelcorpBolivia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpBolivia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpColombia
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CO' END AS 'Pais'
				FROM BelcorpColombia.dbo.ConfiguracionPais config
				INNER JOIN BelcorpColombia.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpCostaRica
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'CR' END AS 'Pais'
				FROM BelcorpCostaRica.dbo.ConfiguracionPais config
				INNER JOIN BelcorpCostaRica.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpDominicana
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'DO' END AS 'Pais'
				FROM BelcorpDominicana.dbo.ConfiguracionPais config
				INNER JOIN BelcorpDominicana.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpEcuador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'EC' END AS 'Pais'
				FROM BelcorpEcuador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpEcuador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpGuatemala
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'GU' END AS 'Pais'
				FROM BelcorpGuatemala.dbo.ConfiguracionPais config
				INNER JOIN BelcorpGuatemala.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpMexico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'MX' END AS 'Pais'
				FROM BelcorpMexico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpMexico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPanama
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PA' END AS 'Pais'
				FROM BelcorpPanama.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPanama.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpPuertoRico
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'PR' END AS 'Pais'
				FROM BelcorpPuertoRico.dbo.ConfiguracionPais config
				INNER JOIN BelcorpPuertoRico.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo

	UNION ALL
	--BelcorpSalvador
	SELECT
			CASE WHEN CHARINDEX(@estrategia, datos.Valor1) > 0 THEN  'SV' END AS 'Pais'
				FROM BelcorpSalvador.dbo.ConfiguracionPais config
				INNER JOIN BelcorpSalvador.dbo.ConfiguracionPaisDatos datos ON config.ConfiguracionPaisID = datos.ConfiguracionPaisID
					WHERE config.Estado = 1 
					AND datos.Estado = 1
					AND config.Codigo = @Codigo


) Tabla 
WHERE Pais IS NOT NULL

GO




