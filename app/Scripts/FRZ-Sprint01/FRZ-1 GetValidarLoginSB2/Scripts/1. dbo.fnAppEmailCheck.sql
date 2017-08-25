USE BelcorpBolivia
GO

IF OBJECT_ID(N'dbo.fnAppEmailCheck') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fnAppEmailCheck
END
GO

CREATE FUNCTION [dbo].[fnAppEmailCheck](@email VARCHAR(255))   
RETURNS bit  
AS  
BEGIN  
     DECLARE @valid bit  
     IF @email IS NOT NULL   
          SET @email = LOWER(@email)  
          SET @valid = 0  
          IF @email like '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%'  
             AND @email NOT like '%@%@%'  
             AND CHARINDEX('.@',@email) = 0  
             AND CHARINDEX('..',@email) = 0  
             AND CHARINDEX(',',@email) = 0  
             AND RIGHT(@email,1) between 'a' AND 'z'  
               SET @valid=1  
     RETURN @valid  
END
GO
/*end*/

USE BelcorpChile
GO

IF OBJECT_ID(N'dbo.fnAppEmailCheck') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fnAppEmailCheck
END
GO

CREATE FUNCTION [dbo].[fnAppEmailCheck](@email VARCHAR(255))   
RETURNS bit  
AS  
BEGIN  
     DECLARE @valid bit  
     IF @email IS NOT NULL   
          SET @email = LOWER(@email)  
          SET @valid = 0  
          IF @email like '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%'  
             AND @email NOT like '%@%@%'  
             AND CHARINDEX('.@',@email) = 0  
             AND CHARINDEX('..',@email) = 0  
             AND CHARINDEX(',',@email) = 0  
             AND RIGHT(@email,1) between 'a' AND 'z'  
               SET @valid=1  
     RETURN @valid  
END
GO
/*end*/

USE BelcorpColombia
GO

IF OBJECT_ID(N'dbo.fnAppEmailCheck') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fnAppEmailCheck
END
GO

CREATE FUNCTION [dbo].[fnAppEmailCheck](@email VARCHAR(255))   
RETURNS bit  
AS  
BEGIN  
     DECLARE @valid bit  
     IF @email IS NOT NULL   
          SET @email = LOWER(@email)  
          SET @valid = 0  
          IF @email like '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%'  
             AND @email NOT like '%@%@%'  
             AND CHARINDEX('.@',@email) = 0  
             AND CHARINDEX('..',@email) = 0  
             AND CHARINDEX(',',@email) = 0  
             AND RIGHT(@email,1) between 'a' AND 'z'  
               SET @valid=1  
     RETURN @valid  
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF OBJECT_ID(N'dbo.fnAppEmailCheck') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fnAppEmailCheck
END
GO

CREATE FUNCTION [dbo].[fnAppEmailCheck](@email VARCHAR(255))   
RETURNS bit  
AS  
BEGIN  
     DECLARE @valid bit  
     IF @email IS NOT NULL   
          SET @email = LOWER(@email)  
          SET @valid = 0  
          IF @email like '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%'  
             AND @email NOT like '%@%@%'  
             AND CHARINDEX('.@',@email) = 0  
             AND CHARINDEX('..',@email) = 0  
             AND CHARINDEX(',',@email) = 0  
             AND RIGHT(@email,1) between 'a' AND 'z'  
               SET @valid=1  
     RETURN @valid  
END
GO
/*end*/

USE BelcorpDominicana
GO

IF OBJECT_ID(N'dbo.fnAppEmailCheck') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fnAppEmailCheck
END
GO

CREATE FUNCTION [dbo].[fnAppEmailCheck](@email VARCHAR(255))   
RETURNS bit  
AS  
BEGIN  
     DECLARE @valid bit  
     IF @email IS NOT NULL   
          SET @email = LOWER(@email)  
          SET @valid = 0  
          IF @email like '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%'  
             AND @email NOT like '%@%@%'  
             AND CHARINDEX('.@',@email) = 0  
             AND CHARINDEX('..',@email) = 0  
             AND CHARINDEX(',',@email) = 0  
             AND RIGHT(@email,1) between 'a' AND 'z'  
               SET @valid=1  
     RETURN @valid  
END
GO
/*end*/

USE BelcorpEcuador
GO

IF OBJECT_ID(N'dbo.fnAppEmailCheck') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fnAppEmailCheck
END
GO

CREATE FUNCTION [dbo].[fnAppEmailCheck](@email VARCHAR(255))   
RETURNS bit  
AS  
BEGIN  
     DECLARE @valid bit  
     IF @email IS NOT NULL   
          SET @email = LOWER(@email)  
          SET @valid = 0  
          IF @email like '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%'  
             AND @email NOT like '%@%@%'  
             AND CHARINDEX('.@',@email) = 0  
             AND CHARINDEX('..',@email) = 0  
             AND CHARINDEX(',',@email) = 0  
             AND RIGHT(@email,1) between 'a' AND 'z'  
               SET @valid=1  
     RETURN @valid  
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF OBJECT_ID(N'dbo.fnAppEmailCheck') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fnAppEmailCheck
END
GO

CREATE FUNCTION [dbo].[fnAppEmailCheck](@email VARCHAR(255))   
RETURNS bit  
AS  
BEGIN  
     DECLARE @valid bit  
     IF @email IS NOT NULL   
          SET @email = LOWER(@email)  
          SET @valid = 0  
          IF @email like '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%'  
             AND @email NOT like '%@%@%'  
             AND CHARINDEX('.@',@email) = 0  
             AND CHARINDEX('..',@email) = 0  
             AND CHARINDEX(',',@email) = 0  
             AND RIGHT(@email,1) between 'a' AND 'z'  
               SET @valid=1  
     RETURN @valid  
END
GO
/*end*/

USE BelcorpMexico
GO

IF OBJECT_ID(N'dbo.fnAppEmailCheck') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fnAppEmailCheck
END
GO

CREATE FUNCTION [dbo].[fnAppEmailCheck](@email VARCHAR(255))   
RETURNS bit  
AS  
BEGIN  
     DECLARE @valid bit  
     IF @email IS NOT NULL   
          SET @email = LOWER(@email)  
          SET @valid = 0  
          IF @email like '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%'  
             AND @email NOT like '%@%@%'  
             AND CHARINDEX('.@',@email) = 0  
             AND CHARINDEX('..',@email) = 0  
             AND CHARINDEX(',',@email) = 0  
             AND RIGHT(@email,1) between 'a' AND 'z'  
               SET @valid=1  
     RETURN @valid  
END
GO
/*end*/

USE BelcorpPanama
GO

IF OBJECT_ID(N'dbo.fnAppEmailCheck') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fnAppEmailCheck
END
GO

CREATE FUNCTION [dbo].[fnAppEmailCheck](@email VARCHAR(255))   
RETURNS bit  
AS  
BEGIN  
     DECLARE @valid bit  
     IF @email IS NOT NULL   
          SET @email = LOWER(@email)  
          SET @valid = 0  
          IF @email like '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%'  
             AND @email NOT like '%@%@%'  
             AND CHARINDEX('.@',@email) = 0  
             AND CHARINDEX('..',@email) = 0  
             AND CHARINDEX(',',@email) = 0  
             AND RIGHT(@email,1) between 'a' AND 'z'  
               SET @valid=1  
     RETURN @valid  
END
GO
/*end*/

USE BelcorpPeru
GO

IF OBJECT_ID(N'dbo.fnAppEmailCheck') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fnAppEmailCheck
END
GO

CREATE FUNCTION [dbo].[fnAppEmailCheck](@email VARCHAR(255))   
RETURNS bit  
AS  
BEGIN  
     DECLARE @valid bit  
     IF @email IS NOT NULL   
          SET @email = LOWER(@email)  
          SET @valid = 0  
          IF @email like '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%'  
             AND @email NOT like '%@%@%'  
             AND CHARINDEX('.@',@email) = 0  
             AND CHARINDEX('..',@email) = 0  
             AND CHARINDEX(',',@email) = 0  
             AND RIGHT(@email,1) between 'a' AND 'z'  
               SET @valid=1  
     RETURN @valid  
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF OBJECT_ID(N'dbo.fnAppEmailCheck') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fnAppEmailCheck
END
GO

CREATE FUNCTION [dbo].[fnAppEmailCheck](@email VARCHAR(255))   
RETURNS bit  
AS  
BEGIN  
     DECLARE @valid bit  
     IF @email IS NOT NULL   
          SET @email = LOWER(@email)  
          SET @valid = 0  
          IF @email like '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%'  
             AND @email NOT like '%@%@%'  
             AND CHARINDEX('.@',@email) = 0  
             AND CHARINDEX('..',@email) = 0  
             AND CHARINDEX(',',@email) = 0  
             AND RIGHT(@email,1) between 'a' AND 'z'  
               SET @valid=1  
     RETURN @valid  
END
GO
/*end*/

USE BelcorpSalvador
GO

IF OBJECT_ID(N'dbo.fnAppEmailCheck') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fnAppEmailCheck
END
GO

CREATE FUNCTION [dbo].[fnAppEmailCheck](@email VARCHAR(255))   
RETURNS bit  
AS  
BEGIN  
     DECLARE @valid bit  
     IF @email IS NOT NULL   
          SET @email = LOWER(@email)  
          SET @valid = 0  
          IF @email like '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%'  
             AND @email NOT like '%@%@%'  
             AND CHARINDEX('.@',@email) = 0  
             AND CHARINDEX('..',@email) = 0  
             AND CHARINDEX(',',@email) = 0  
             AND RIGHT(@email,1) between 'a' AND 'z'  
               SET @valid=1  
     RETURN @valid  
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF OBJECT_ID(N'dbo.fnAppEmailCheck') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fnAppEmailCheck
END
GO

CREATE FUNCTION [dbo].[fnAppEmailCheck](@email VARCHAR(255))   
RETURNS bit  
AS  
BEGIN  
     DECLARE @valid bit  
     IF @email IS NOT NULL   
          SET @email = LOWER(@email)  
          SET @valid = 0  
          IF @email like '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%'  
             AND @email NOT like '%@%@%'  
             AND CHARINDEX('.@',@email) = 0  
             AND CHARINDEX('..',@email) = 0  
             AND CHARINDEX(',',@email) = 0  
             AND RIGHT(@email,1) between 'a' AND 'z'  
               SET @valid=1  
     RETURN @valid  
END
GO