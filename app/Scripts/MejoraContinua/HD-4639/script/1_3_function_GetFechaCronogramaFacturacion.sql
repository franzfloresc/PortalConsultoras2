GO
USE BelcorpPeru
GO
IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  object_id = OBJECT_ID(N'[dbo].[GetFechaCronogramaFacturacion]')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetFechaCronogramaFacturacion]
GO

create FUNCTION [dbo].[GetFechaCronogramaFacturacion](@FECHAINPUT DATETIME)
returns VARCHAR(8000)
AS
  BEGIN
      DECLARE @fecha VARCHAR(64)
      SELECT @fecha = Concat(Cast(Datename(dw, @FECHAINPUT) AS VARCHAR(16)), ' ',
                             Cast(Datepart(day, @FECHAINPUT) AS VARCHAR(8)), ' ',
                             Cast(Datename(month, @FECHAINPUT) AS VARCHAR  (16)))
      --SET language us_english;

	  RETURN @fecha
  END

  --SET language español;
   --SELECT dbo.GetFechaCronogramaFacturacion(getdate())

GO
USE BelcorpMexico
GO
IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  object_id = OBJECT_ID(N'[dbo].[GetFechaCronogramaFacturacion]')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetFechaCronogramaFacturacion]
GO

create FUNCTION [dbo].[GetFechaCronogramaFacturacion](@FECHAINPUT DATETIME)
returns VARCHAR(8000)
AS
  BEGIN
      DECLARE @fecha VARCHAR(64)
      SELECT @fecha = Concat(Cast(Datename(dw, @FECHAINPUT) AS VARCHAR(16)), ' ',
                             Cast(Datepart(day, @FECHAINPUT) AS VARCHAR(8)), ' ',
                             Cast(Datename(month, @FECHAINPUT) AS VARCHAR  (16)))
      --SET language us_english;

	  RETURN @fecha
  END

  --SET language español;
   --SELECT dbo.GetFechaCronogramaFacturacion(getdate())

GO
USE BelcorpColombia
GO
IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  object_id = OBJECT_ID(N'[dbo].[GetFechaCronogramaFacturacion]')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetFechaCronogramaFacturacion]
GO

create FUNCTION [dbo].[GetFechaCronogramaFacturacion](@FECHAINPUT DATETIME)
returns VARCHAR(8000)
AS
  BEGIN
      DECLARE @fecha VARCHAR(64)
      SELECT @fecha = Concat(Cast(Datename(dw, @FECHAINPUT) AS VARCHAR(16)), ' ',
                             Cast(Datepart(day, @FECHAINPUT) AS VARCHAR(8)), ' ',
                             Cast(Datename(month, @FECHAINPUT) AS VARCHAR  (16)))
      --SET language us_english;

	  RETURN @fecha
  END

  --SET language español;
   --SELECT dbo.GetFechaCronogramaFacturacion(getdate())

GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  object_id = OBJECT_ID(N'[dbo].[GetFechaCronogramaFacturacion]')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetFechaCronogramaFacturacion]
GO

create FUNCTION [dbo].[GetFechaCronogramaFacturacion](@FECHAINPUT DATETIME)
returns VARCHAR(8000)
AS
  BEGIN
      DECLARE @fecha VARCHAR(64)
      SELECT @fecha = Concat(Cast(Datename(dw, @FECHAINPUT) AS VARCHAR(16)), ' ',
                             Cast(Datepart(day, @FECHAINPUT) AS VARCHAR(8)), ' ',
                             Cast(Datename(month, @FECHAINPUT) AS VARCHAR  (16)))
      --SET language us_english;

	  RETURN @fecha
  END

  --SET language español;
   --SELECT dbo.GetFechaCronogramaFacturacion(getdate())

GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  object_id = OBJECT_ID(N'[dbo].[GetFechaCronogramaFacturacion]')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetFechaCronogramaFacturacion]
GO

create FUNCTION [dbo].[GetFechaCronogramaFacturacion](@FECHAINPUT DATETIME)
returns VARCHAR(8000)
AS
  BEGIN
      DECLARE @fecha VARCHAR(64)
      SELECT @fecha = Concat(Cast(Datename(dw, @FECHAINPUT) AS VARCHAR(16)), ' ',
                             Cast(Datepart(day, @FECHAINPUT) AS VARCHAR(8)), ' ',
                             Cast(Datename(month, @FECHAINPUT) AS VARCHAR  (16)))
      --SET language us_english;

	  RETURN @fecha
  END

  --SET language español;
   --SELECT dbo.GetFechaCronogramaFacturacion(getdate())

GO
USE BelcorpPanama
GO
IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  object_id = OBJECT_ID(N'[dbo].[GetFechaCronogramaFacturacion]')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetFechaCronogramaFacturacion]
GO

create FUNCTION [dbo].[GetFechaCronogramaFacturacion](@FECHAINPUT DATETIME)
returns VARCHAR(8000)
AS
  BEGIN
      DECLARE @fecha VARCHAR(64)
      SELECT @fecha = Concat(Cast(Datename(dw, @FECHAINPUT) AS VARCHAR(16)), ' ',
                             Cast(Datepart(day, @FECHAINPUT) AS VARCHAR(8)), ' ',
                             Cast(Datename(month, @FECHAINPUT) AS VARCHAR  (16)))
      --SET language us_english;

	  RETURN @fecha
  END

  --SET language español;
   --SELECT dbo.GetFechaCronogramaFacturacion(getdate())

GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  object_id = OBJECT_ID(N'[dbo].[GetFechaCronogramaFacturacion]')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetFechaCronogramaFacturacion]
GO

create FUNCTION [dbo].[GetFechaCronogramaFacturacion](@FECHAINPUT DATETIME)
returns VARCHAR(8000)
AS
  BEGIN
      DECLARE @fecha VARCHAR(64)
      SELECT @fecha = Concat(Cast(Datename(dw, @FECHAINPUT) AS VARCHAR(16)), ' ',
                             Cast(Datepart(day, @FECHAINPUT) AS VARCHAR(8)), ' ',
                             Cast(Datename(month, @FECHAINPUT) AS VARCHAR  (16)))
      --SET language us_english;

	  RETURN @fecha
  END

  --SET language español;
   --SELECT dbo.GetFechaCronogramaFacturacion(getdate())

GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  object_id = OBJECT_ID(N'[dbo].[GetFechaCronogramaFacturacion]')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetFechaCronogramaFacturacion]
GO

create FUNCTION [dbo].[GetFechaCronogramaFacturacion](@FECHAINPUT DATETIME)
returns VARCHAR(8000)
AS
  BEGIN
      DECLARE @fecha VARCHAR(64)
      SELECT @fecha = Concat(Cast(Datename(dw, @FECHAINPUT) AS VARCHAR(16)), ' ',
                             Cast(Datepart(day, @FECHAINPUT) AS VARCHAR(8)), ' ',
                             Cast(Datename(month, @FECHAINPUT) AS VARCHAR  (16)))
      --SET language us_english;

	  RETURN @fecha
  END

  --SET language español;
   --SELECT dbo.GetFechaCronogramaFacturacion(getdate())

GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  object_id = OBJECT_ID(N'[dbo].[GetFechaCronogramaFacturacion]')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetFechaCronogramaFacturacion]
GO

create FUNCTION [dbo].[GetFechaCronogramaFacturacion](@FECHAINPUT DATETIME)
returns VARCHAR(8000)
AS
  BEGIN
      DECLARE @fecha VARCHAR(64)
      SELECT @fecha = Concat(Cast(Datename(dw, @FECHAINPUT) AS VARCHAR(16)), ' ',
                             Cast(Datepart(day, @FECHAINPUT) AS VARCHAR(8)), ' ',
                             Cast(Datename(month, @FECHAINPUT) AS VARCHAR  (16)))
      --SET language us_english;

	  RETURN @fecha
  END

  --SET language español;
   --SELECT dbo.GetFechaCronogramaFacturacion(getdate())

GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  object_id = OBJECT_ID(N'[dbo].[GetFechaCronogramaFacturacion]')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetFechaCronogramaFacturacion]
GO

create FUNCTION [dbo].[GetFechaCronogramaFacturacion](@FECHAINPUT DATETIME)
returns VARCHAR(8000)
AS
  BEGIN
      DECLARE @fecha VARCHAR(64)
      SELECT @fecha = Concat(Cast(Datename(dw, @FECHAINPUT) AS VARCHAR(16)), ' ',
                             Cast(Datepart(day, @FECHAINPUT) AS VARCHAR(8)), ' ',
                             Cast(Datename(month, @FECHAINPUT) AS VARCHAR  (16)))
      --SET language us_english;

	  RETURN @fecha
  END

  --SET language español;
   --SELECT dbo.GetFechaCronogramaFacturacion(getdate())

GO
USE BelcorpChile
GO
IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  object_id = OBJECT_ID(N'[dbo].[GetFechaCronogramaFacturacion]')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetFechaCronogramaFacturacion]
GO

create FUNCTION [dbo].[GetFechaCronogramaFacturacion](@FECHAINPUT DATETIME)
returns VARCHAR(8000)
AS
  BEGIN
      DECLARE @fecha VARCHAR(64)
      SELECT @fecha = Concat(Cast(Datename(dw, @FECHAINPUT) AS VARCHAR(16)), ' ',
                             Cast(Datepart(day, @FECHAINPUT) AS VARCHAR(8)), ' ',
                             Cast(Datename(month, @FECHAINPUT) AS VARCHAR  (16)))
      --SET language us_english;

	  RETURN @fecha
  END

  --SET language español;
   --SELECT dbo.GetFechaCronogramaFacturacion(getdate())

GO
USE BelcorpBolivia
GO
IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  object_id = OBJECT_ID(N'[dbo].[GetFechaCronogramaFacturacion]')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetFechaCronogramaFacturacion]
GO

create FUNCTION [dbo].[GetFechaCronogramaFacturacion](@FECHAINPUT DATETIME)
returns VARCHAR(8000)
AS
  BEGIN
      DECLARE @fecha VARCHAR(64)
      SELECT @fecha = Concat(Cast(Datename(dw, @FECHAINPUT) AS VARCHAR(16)), ' ',
                             Cast(Datepart(day, @FECHAINPUT) AS VARCHAR(8)), ' ',
                             Cast(Datename(month, @FECHAINPUT) AS VARCHAR  (16)))
      --SET language us_english;

	  RETURN @fecha
  END

  --SET language español;
   --SELECT dbo.GetFechaCronogramaFacturacion(getdate())

GO
