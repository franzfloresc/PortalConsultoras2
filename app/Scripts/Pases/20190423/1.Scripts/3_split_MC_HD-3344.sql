USE [BelcorpBolivia];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Split]') 
	AND type in (N'TF')
) 
	DROP FUNCTION [dbo].[Split]
GO

/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019      
DESCRIPCIÓN : Transforma cadenas en columnas 
*/ 
CREATE FUNCTION [dbo].[Split] (
@String      NVARCHAR (4000), 
@Delimitador NVARCHAR (10))
 
returns @ValueTable TABLE ( 
  [valor] NVARCHAR(4000)) 
  BEGIN 
      DECLARE @NextString NVARCHAR(4000) 
      DECLARE @Pos INT 
      DECLARE @NextPos INT 
      DECLARE @CommaCheck NVARCHAR(1) 

      --Inicializa 
      SET @NextString = '' 
      SET @CommaCheck = RIGHT(@String, 1) 
      SET @String = @String + @Delimitador 
      --Busca la posición del primer delimitador 
      SET @Pos = Charindex(@Delimitador, @String) 
      SET @NextPos = 1 

      --Itera mientras exista un delimitador en el string 
      WHILE ( @pos <> 0 ) 
        BEGIN 
            SET @NextString = Substring(@String, 1, @Pos - 1) 

            INSERT INTO @ValueTable 
                        ([valor]) 
            VALUES      (@NextString) 

            SET @String = Substring(@String, @pos + 1, Len(@String)) 
            SET @NextPos = @Pos 
            SET @pos = Charindex(@Delimitador, @String) 
        END 

      RETURN 
  END 
GO
USE [BelcorpChile];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Split]') 
	AND type in (N'TF')
) 
	DROP FUNCTION [dbo].[Split]
GO

/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019      
DESCRIPCIÓN : Transforma cadenas en columnas 
*/ 
CREATE FUNCTION [dbo].[Split] (
@String      NVARCHAR (4000), 
@Delimitador NVARCHAR (10))
 
returns @ValueTable TABLE ( 
  [valor] NVARCHAR(4000)) 
  BEGIN 
      DECLARE @NextString NVARCHAR(4000) 
      DECLARE @Pos INT 
      DECLARE @NextPos INT 
      DECLARE @CommaCheck NVARCHAR(1) 

      --Inicializa 
      SET @NextString = '' 
      SET @CommaCheck = RIGHT(@String, 1) 
      SET @String = @String + @Delimitador 
      --Busca la posición del primer delimitador 
      SET @Pos = Charindex(@Delimitador, @String) 
      SET @NextPos = 1 

      --Itera mientras exista un delimitador en el string 
      WHILE ( @pos <> 0 ) 
        BEGIN 
            SET @NextString = Substring(@String, 1, @Pos - 1) 

            INSERT INTO @ValueTable 
                        ([valor]) 
            VALUES      (@NextString) 

            SET @String = Substring(@String, @pos + 1, Len(@String)) 
            SET @NextPos = @Pos 
            SET @pos = Charindex(@Delimitador, @String) 
        END 

      RETURN 
  END 
GO
USE [BelcorpColombia];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Split]') 
	AND type in (N'TF')
) 
	DROP FUNCTION [dbo].[Split]
GO

/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019      
DESCRIPCIÓN : Transforma cadenas en columnas 
*/ 
CREATE FUNCTION [dbo].[Split] (
@String      NVARCHAR (4000), 
@Delimitador NVARCHAR (10))
 
returns @ValueTable TABLE ( 
  [valor] NVARCHAR(4000)) 
  BEGIN 
      DECLARE @NextString NVARCHAR(4000) 
      DECLARE @Pos INT 
      DECLARE @NextPos INT 
      DECLARE @CommaCheck NVARCHAR(1) 

      --Inicializa 
      SET @NextString = '' 
      SET @CommaCheck = RIGHT(@String, 1) 
      SET @String = @String + @Delimitador 
      --Busca la posición del primer delimitador 
      SET @Pos = Charindex(@Delimitador, @String) 
      SET @NextPos = 1 

      --Itera mientras exista un delimitador en el string 
      WHILE ( @pos <> 0 ) 
        BEGIN 
            SET @NextString = Substring(@String, 1, @Pos - 1) 

            INSERT INTO @ValueTable 
                        ([valor]) 
            VALUES      (@NextString) 

            SET @String = Substring(@String, @pos + 1, Len(@String)) 
            SET @NextPos = @Pos 
            SET @pos = Charindex(@Delimitador, @String) 
        END 

      RETURN 
  END 
GO
USE [BelcorpCostaRica];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Split]') 
	AND type in (N'TF')
) 
	DROP FUNCTION [dbo].[Split]
GO

/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019      
DESCRIPCIÓN : Transforma cadenas en columnas 
*/ 
CREATE FUNCTION [dbo].[Split] (
@String      NVARCHAR (4000), 
@Delimitador NVARCHAR (10))
 
returns @ValueTable TABLE ( 
  [valor] NVARCHAR(4000)) 
  BEGIN 
      DECLARE @NextString NVARCHAR(4000) 
      DECLARE @Pos INT 
      DECLARE @NextPos INT 
      DECLARE @CommaCheck NVARCHAR(1) 

      --Inicializa 
      SET @NextString = '' 
      SET @CommaCheck = RIGHT(@String, 1) 
      SET @String = @String + @Delimitador 
      --Busca la posición del primer delimitador 
      SET @Pos = Charindex(@Delimitador, @String) 
      SET @NextPos = 1 

      --Itera mientras exista un delimitador en el string 
      WHILE ( @pos <> 0 ) 
        BEGIN 
            SET @NextString = Substring(@String, 1, @Pos - 1) 

            INSERT INTO @ValueTable 
                        ([valor]) 
            VALUES      (@NextString) 

            SET @String = Substring(@String, @pos + 1, Len(@String)) 
            SET @NextPos = @Pos 
            SET @pos = Charindex(@Delimitador, @String) 
        END 

      RETURN 
  END 
GO
USE [BelcorpDominicana];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Split]') 
	AND type in (N'TF')
) 
	DROP FUNCTION [dbo].[Split]
GO

/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019      
DESCRIPCIÓN : Transforma cadenas en columnas 
*/ 
CREATE FUNCTION [dbo].[Split] (
@String      NVARCHAR (4000), 
@Delimitador NVARCHAR (10))
 
returns @ValueTable TABLE ( 
  [valor] NVARCHAR(4000)) 
  BEGIN 
      DECLARE @NextString NVARCHAR(4000) 
      DECLARE @Pos INT 
      DECLARE @NextPos INT 
      DECLARE @CommaCheck NVARCHAR(1) 

      --Inicializa 
      SET @NextString = '' 
      SET @CommaCheck = RIGHT(@String, 1) 
      SET @String = @String + @Delimitador 
      --Busca la posición del primer delimitador 
      SET @Pos = Charindex(@Delimitador, @String) 
      SET @NextPos = 1 

      --Itera mientras exista un delimitador en el string 
      WHILE ( @pos <> 0 ) 
        BEGIN 
            SET @NextString = Substring(@String, 1, @Pos - 1) 

            INSERT INTO @ValueTable 
                        ([valor]) 
            VALUES      (@NextString) 

            SET @String = Substring(@String, @pos + 1, Len(@String)) 
            SET @NextPos = @Pos 
            SET @pos = Charindex(@Delimitador, @String) 
        END 

      RETURN 
  END 
GO
USE [BelcorpEcuador];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Split]') 
	AND type in (N'TF')
) 
	DROP FUNCTION [dbo].[Split]
GO

/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019      
DESCRIPCIÓN : Transforma cadenas en columnas 
*/ 
CREATE FUNCTION [dbo].[Split] (
@String      NVARCHAR (4000), 
@Delimitador NVARCHAR (10))
 
returns @ValueTable TABLE ( 
  [valor] NVARCHAR(4000)) 
  BEGIN 
      DECLARE @NextString NVARCHAR(4000) 
      DECLARE @Pos INT 
      DECLARE @NextPos INT 
      DECLARE @CommaCheck NVARCHAR(1) 

      --Inicializa 
      SET @NextString = '' 
      SET @CommaCheck = RIGHT(@String, 1) 
      SET @String = @String + @Delimitador 
      --Busca la posición del primer delimitador 
      SET @Pos = Charindex(@Delimitador, @String) 
      SET @NextPos = 1 

      --Itera mientras exista un delimitador en el string 
      WHILE ( @pos <> 0 ) 
        BEGIN 
            SET @NextString = Substring(@String, 1, @Pos - 1) 

            INSERT INTO @ValueTable 
                        ([valor]) 
            VALUES      (@NextString) 

            SET @String = Substring(@String, @pos + 1, Len(@String)) 
            SET @NextPos = @Pos 
            SET @pos = Charindex(@Delimitador, @String) 
        END 

      RETURN 
  END 
GO
USE [BelcorpGuatemala];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Split]') 
	AND type in (N'TF')
) 
	DROP FUNCTION [dbo].[Split]
GO

/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019      
DESCRIPCIÓN : Transforma cadenas en columnas 
*/ 
CREATE FUNCTION [dbo].[Split] (
@String      NVARCHAR (4000), 
@Delimitador NVARCHAR (10))
 
returns @ValueTable TABLE ( 
  [valor] NVARCHAR(4000)) 
  BEGIN 
      DECLARE @NextString NVARCHAR(4000) 
      DECLARE @Pos INT 
      DECLARE @NextPos INT 
      DECLARE @CommaCheck NVARCHAR(1) 

      --Inicializa 
      SET @NextString = '' 
      SET @CommaCheck = RIGHT(@String, 1) 
      SET @String = @String + @Delimitador 
      --Busca la posición del primer delimitador 
      SET @Pos = Charindex(@Delimitador, @String) 
      SET @NextPos = 1 

      --Itera mientras exista un delimitador en el string 
      WHILE ( @pos <> 0 ) 
        BEGIN 
            SET @NextString = Substring(@String, 1, @Pos - 1) 

            INSERT INTO @ValueTable 
                        ([valor]) 
            VALUES      (@NextString) 

            SET @String = Substring(@String, @pos + 1, Len(@String)) 
            SET @NextPos = @Pos 
            SET @pos = Charindex(@Delimitador, @String) 
        END 

      RETURN 
  END 
GO
USE [BelcorpMexico];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Split]') 
	AND type in (N'TF')
) 
	DROP FUNCTION [dbo].[Split]
GO

/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019      
DESCRIPCIÓN : Transforma cadenas en columnas 
*/ 
CREATE FUNCTION [dbo].[Split] (
@String      NVARCHAR (4000), 
@Delimitador NVARCHAR (10))
 
returns @ValueTable TABLE ( 
  [valor] NVARCHAR(4000)) 
  BEGIN 
      DECLARE @NextString NVARCHAR(4000) 
      DECLARE @Pos INT 
      DECLARE @NextPos INT 
      DECLARE @CommaCheck NVARCHAR(1) 

      --Inicializa 
      SET @NextString = '' 
      SET @CommaCheck = RIGHT(@String, 1) 
      SET @String = @String + @Delimitador 
      --Busca la posición del primer delimitador 
      SET @Pos = Charindex(@Delimitador, @String) 
      SET @NextPos = 1 

      --Itera mientras exista un delimitador en el string 
      WHILE ( @pos <> 0 ) 
        BEGIN 
            SET @NextString = Substring(@String, 1, @Pos - 1) 

            INSERT INTO @ValueTable 
                        ([valor]) 
            VALUES      (@NextString) 

            SET @String = Substring(@String, @pos + 1, Len(@String)) 
            SET @NextPos = @Pos 
            SET @pos = Charindex(@Delimitador, @String) 
        END 

      RETURN 
  END 
GO
USE [BelcorpPanama];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Split]') 
	AND type in (N'TF')
) 
	DROP FUNCTION [dbo].[Split]
GO

/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019      
DESCRIPCIÓN : Transforma cadenas en columnas 
*/ 
CREATE FUNCTION [dbo].[Split] (
@String      NVARCHAR (4000), 
@Delimitador NVARCHAR (10))
 
returns @ValueTable TABLE ( 
  [valor] NVARCHAR(4000)) 
  BEGIN 
      DECLARE @NextString NVARCHAR(4000) 
      DECLARE @Pos INT 
      DECLARE @NextPos INT 
      DECLARE @CommaCheck NVARCHAR(1) 

      --Inicializa 
      SET @NextString = '' 
      SET @CommaCheck = RIGHT(@String, 1) 
      SET @String = @String + @Delimitador 
      --Busca la posición del primer delimitador 
      SET @Pos = Charindex(@Delimitador, @String) 
      SET @NextPos = 1 

      --Itera mientras exista un delimitador en el string 
      WHILE ( @pos <> 0 ) 
        BEGIN 
            SET @NextString = Substring(@String, 1, @Pos - 1) 

            INSERT INTO @ValueTable 
                        ([valor]) 
            VALUES      (@NextString) 

            SET @String = Substring(@String, @pos + 1, Len(@String)) 
            SET @NextPos = @Pos 
            SET @pos = Charindex(@Delimitador, @String) 
        END 

      RETURN 
  END 
GO
USE [BelcorpPeru];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Split]') 
	AND type in (N'TF')
) 
	DROP FUNCTION [dbo].[Split]
GO

/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019      
DESCRIPCIÓN : Transforma cadenas en columnas 
*/ 
CREATE FUNCTION [dbo].[Split] (
@String      NVARCHAR (4000), 
@Delimitador NVARCHAR (10))
 
returns @ValueTable TABLE ( 
  [valor] NVARCHAR(4000)) 
  BEGIN 
      DECLARE @NextString NVARCHAR(4000) 
      DECLARE @Pos INT 
      DECLARE @NextPos INT 
      DECLARE @CommaCheck NVARCHAR(1) 

      --Inicializa 
      SET @NextString = '' 
      SET @CommaCheck = RIGHT(@String, 1) 
      SET @String = @String + @Delimitador 
      --Busca la posición del primer delimitador 
      SET @Pos = Charindex(@Delimitador, @String) 
      SET @NextPos = 1 

      --Itera mientras exista un delimitador en el string 
      WHILE ( @pos <> 0 ) 
        BEGIN 
            SET @NextString = Substring(@String, 1, @Pos - 1) 

            INSERT INTO @ValueTable 
                        ([valor]) 
            VALUES      (@NextString) 

            SET @String = Substring(@String, @pos + 1, Len(@String)) 
            SET @NextPos = @Pos 
            SET @pos = Charindex(@Delimitador, @String) 
        END 

      RETURN 
  END 
GO
USE [BelcorpPuertoRico];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Split]') 
	AND type in (N'TF')
) 
	DROP FUNCTION [dbo].[Split]
GO

/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019      
DESCRIPCIÓN : Transforma cadenas en columnas 
*/ 
CREATE FUNCTION [dbo].[Split] (
@String      NVARCHAR (4000), 
@Delimitador NVARCHAR (10))
 
returns @ValueTable TABLE ( 
  [valor] NVARCHAR(4000)) 
  BEGIN 
      DECLARE @NextString NVARCHAR(4000) 
      DECLARE @Pos INT 
      DECLARE @NextPos INT 
      DECLARE @CommaCheck NVARCHAR(1) 

      --Inicializa 
      SET @NextString = '' 
      SET @CommaCheck = RIGHT(@String, 1) 
      SET @String = @String + @Delimitador 
      --Busca la posición del primer delimitador 
      SET @Pos = Charindex(@Delimitador, @String) 
      SET @NextPos = 1 

      --Itera mientras exista un delimitador en el string 
      WHILE ( @pos <> 0 ) 
        BEGIN 
            SET @NextString = Substring(@String, 1, @Pos - 1) 

            INSERT INTO @ValueTable 
                        ([valor]) 
            VALUES      (@NextString) 

            SET @String = Substring(@String, @pos + 1, Len(@String)) 
            SET @NextPos = @Pos 
            SET @pos = Charindex(@Delimitador, @String) 
        END 

      RETURN 
  END 
GO
USE [BelcorpSalvador];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Split]') 
	AND type in (N'TF')
) 
	DROP FUNCTION [dbo].[Split]
GO

/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019      
DESCRIPCIÓN : Transforma cadenas en columnas 
*/ 
CREATE FUNCTION [dbo].[Split] (
@String      NVARCHAR (4000), 
@Delimitador NVARCHAR (10))
 
returns @ValueTable TABLE ( 
  [valor] NVARCHAR(4000)) 
  BEGIN 
      DECLARE @NextString NVARCHAR(4000) 
      DECLARE @Pos INT 
      DECLARE @NextPos INT 
      DECLARE @CommaCheck NVARCHAR(1) 

      --Inicializa 
      SET @NextString = '' 
      SET @CommaCheck = RIGHT(@String, 1) 
      SET @String = @String + @Delimitador 
      --Busca la posición del primer delimitador 
      SET @Pos = Charindex(@Delimitador, @String) 
      SET @NextPos = 1 

      --Itera mientras exista un delimitador en el string 
      WHILE ( @pos <> 0 ) 
        BEGIN 
            SET @NextString = Substring(@String, 1, @Pos - 1) 

            INSERT INTO @ValueTable 
                        ([valor]) 
            VALUES      (@NextString) 

            SET @String = Substring(@String, @pos + 1, Len(@String)) 
            SET @NextPos = @Pos 
            SET @pos = Charindex(@Delimitador, @String) 
        END 

      RETURN 
  END 
GO
