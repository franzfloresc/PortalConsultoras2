USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.DelIncentivosMontoExigencia'))
	DROP PROC dbo.DelIncentivosMontoExigencia
GO
CREATE PROC dbo.DelIncentivosMontoExigencia
(
@MontoID int
)
AS
BEGIN
	DELETE FROM IncentivosMontoExigencia 
	where @MontoID = MontoID 	
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.DelIncentivosMontoExigencia'))
	DROP PROC dbo.DelIncentivosMontoExigencia
GO
CREATE PROC dbo.DelIncentivosMontoExigencia
(
@MontoID int
)
AS
BEGIN
	DELETE FROM IncentivosMontoExigencia 
	where @MontoID = MontoID 	
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.DelIncentivosMontoExigencia'))
	DROP PROC dbo.DelIncentivosMontoExigencia
GO
CREATE PROC dbo.DelIncentivosMontoExigencia
(
@MontoID int
)
AS
BEGIN
	DELETE FROM IncentivosMontoExigencia 
	where @MontoID = MontoID 	
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.DelIncentivosMontoExigencia'))
	DROP PROC dbo.DelIncentivosMontoExigencia
GO
CREATE PROC dbo.DelIncentivosMontoExigencia
(
@MontoID int
)
AS
BEGIN
	DELETE FROM IncentivosMontoExigencia 
	where @MontoID = MontoID 	
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.DelIncentivosMontoExigencia'))
	DROP PROC dbo.DelIncentivosMontoExigencia
GO
CREATE PROC dbo.DelIncentivosMontoExigencia
(
@MontoID int
)
AS
BEGIN
	DELETE FROM IncentivosMontoExigencia 
	where @MontoID = MontoID 	
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.DelIncentivosMontoExigencia'))
	DROP PROC dbo.DelIncentivosMontoExigencia
GO
CREATE PROC dbo.DelIncentivosMontoExigencia
(
@MontoID int
)
AS
BEGIN
	DELETE FROM IncentivosMontoExigencia 
	where @MontoID = MontoID 	
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.DelIncentivosMontoExigencia'))
	DROP PROC dbo.DelIncentivosMontoExigencia
GO
CREATE PROC dbo.DelIncentivosMontoExigencia
(
@MontoID int
)
AS
BEGIN
	DELETE FROM IncentivosMontoExigencia 
	where @MontoID = MontoID 	
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.DelIncentivosMontoExigencia'))
	DROP PROC dbo.DelIncentivosMontoExigencia
GO
CREATE PROC dbo.DelIncentivosMontoExigencia
(
@MontoID int
)
AS
BEGIN
	DELETE FROM IncentivosMontoExigencia 
	where @MontoID = MontoID 	
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.DelIncentivosMontoExigencia'))
	DROP PROC dbo.DelIncentivosMontoExigencia
GO
CREATE PROC dbo.DelIncentivosMontoExigencia
(
@MontoID int
)
AS
BEGIN
	DELETE FROM IncentivosMontoExigencia 
	where @MontoID = MontoID 	
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.DelIncentivosMontoExigencia'))
	DROP PROC dbo.DelIncentivosMontoExigencia
GO
CREATE PROC dbo.DelIncentivosMontoExigencia
(
@MontoID int
)
AS
BEGIN
	DELETE FROM IncentivosMontoExigencia 
	where @MontoID = MontoID 	
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.DelIncentivosMontoExigencia'))
	DROP PROC dbo.DelIncentivosMontoExigencia
GO
CREATE PROC dbo.DelIncentivosMontoExigencia
(
@MontoID int
)
AS
BEGIN
	DELETE FROM IncentivosMontoExigencia 
	where @MontoID = MontoID 	
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.DelIncentivosMontoExigencia'))
	DROP PROC dbo.DelIncentivosMontoExigencia
GO
CREATE PROC dbo.DelIncentivosMontoExigencia
(
@MontoID int
)
AS
BEGIN
	DELETE FROM IncentivosMontoExigencia 
	where @MontoID = MontoID 	
END
GO

