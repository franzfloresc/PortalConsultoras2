USE [BelcorpPeru]  
GO
IF object_id('Fn_GetEscalaDescuentoZona') IS NOT NULL
BEGIN
    DROP FUNCTION [dbo].[Fn_GetEscalaDescuentoZona]
END
GO
CREATE FUNCTION Fn_GetEscalaDescuentoZona(
	@campaniaId		INT, 
	@codRegion		VARCHAR(8) , 
	@codZona		VARCHAR(8)
)
RETURNS  @rtnTable TABLE 
(
    MontoHasta		NUMERIC(15, 2)	,
	PorDescuento	INT	
)
AS
BEGIN
INSERT INTO @rtnTable
SELECT MontoHasta,	PorDescuento FROM ods.escalaDescuentoZona  WHERE CampaniaId=@campaniaId and CodRegion=@codRegion and CodZona=@codZona;

IF ((SELECT COUNT(*) FROM @rtnTable) = 0)
BEGIN
	INSERT INTO @rtnTable
	SELECT MontoHasta,	PorDescuento FROM ods.EscalaDescuento ;
END
RETURN	
END
GO

USE [BelcorpBolivia]
GO
IF object_id('Fn_GetEscalaDescuentoZona') IS NOT NULL
BEGIN
    DROP FUNCTION [dbo].[Fn_GetEscalaDescuentoZona]
END
GO
CREATE FUNCTION Fn_GetEscalaDescuentoZona(
	@campaniaId		INT, 
	@codRegion		VARCHAR(8) , 
	@codZona		VARCHAR(8)
)
RETURNS  @rtnTable TABLE 
(
    MontoHasta		NUMERIC(15, 2)	,
	PorDescuento	INT	
)
AS
BEGIN
INSERT INTO @rtnTable
SELECT MontoHasta,	PorDescuento FROM ods.escalaDescuentoZona  WHERE CampaniaId=@campaniaId and CodRegion=@codRegion and CodZona=@codZona;

IF ((SELECT COUNT(*) FROM @rtnTable) = 0)
BEGIN
	INSERT INTO @rtnTable
	SELECT MontoHasta,	PorDescuento FROM ods.EscalaDescuento ;
END
RETURN	
END
GO

USE [BelcorpChile]
GO
IF object_id('Fn_GetEscalaDescuentoZona') IS NOT NULL
BEGIN
    DROP FUNCTION [dbo].[Fn_GetEscalaDescuentoZona]
END
GO
CREATE FUNCTION Fn_GetEscalaDescuentoZona(
	@campaniaId		INT, 
	@codRegion		VARCHAR(8) , 
	@codZona		VARCHAR(8)
)
RETURNS  @rtnTable TABLE 
(
    MontoHasta		NUMERIC(15, 2)	,
	PorDescuento	INT	
)
AS
BEGIN
INSERT INTO @rtnTable
SELECT MontoHasta,	PorDescuento FROM ods.escalaDescuentoZona  WHERE CampaniaId=@campaniaId and CodRegion=@codRegion and CodZona=@codZona;

IF ((SELECT COUNT(*) FROM @rtnTable) = 0)
BEGIN
	INSERT INTO @rtnTable
	SELECT MontoHasta,	PorDescuento FROM ods.EscalaDescuento ;
END
RETURN	
END
GO

USE [BelcorpColombia]
GO
IF object_id('Fn_GetEscalaDescuentoZona') IS NOT NULL
BEGIN
    DROP FUNCTION [dbo].[Fn_GetEscalaDescuentoZona]
END
GO
CREATE FUNCTION Fn_GetEscalaDescuentoZona(
	@campaniaId		INT, 
	@codRegion		VARCHAR(8) , 
	@codZona		VARCHAR(8)
)
RETURNS  @rtnTable TABLE 
(
    MontoHasta		NUMERIC(15, 2)	,
	PorDescuento	INT	
)
AS
BEGIN
INSERT INTO @rtnTable
SELECT MontoHasta,	PorDescuento FROM ods.escalaDescuentoZona  WHERE CampaniaId=@campaniaId and CodRegion=@codRegion and CodZona=@codZona;

IF ((SELECT COUNT(*) FROM @rtnTable) = 0)
BEGIN
	INSERT INTO @rtnTable
	SELECT MontoHasta,	PorDescuento FROM ods.EscalaDescuento ;
END
RETURN	
END
GO

USE [BelcorpCostaRica]
GO
IF object_id('Fn_GetEscalaDescuentoZona') IS NOT NULL
BEGIN
    DROP FUNCTION [dbo].[Fn_GetEscalaDescuentoZona]
END
GO
CREATE FUNCTION Fn_GetEscalaDescuentoZona(
	@campaniaId		INT, 
	@codRegion		VARCHAR(8) , 
	@codZona		VARCHAR(8)
)
RETURNS  @rtnTable TABLE 
(
    MontoHasta		NUMERIC(15, 2)	,
	PorDescuento	INT	
)
AS
BEGIN
INSERT INTO @rtnTable
SELECT MontoHasta,	PorDescuento FROM ods.escalaDescuentoZona  WHERE CampaniaId=@campaniaId and CodRegion=@codRegion and CodZona=@codZona;

IF ((SELECT COUNT(*) FROM @rtnTable) = 0)
BEGIN
	INSERT INTO @rtnTable
	SELECT MontoHasta,	PorDescuento FROM ods.EscalaDescuento ;
END
RETURN	
END
GO

USE [BelcorpDominicana]
GO
IF object_id('Fn_GetEscalaDescuentoZona') IS NOT NULL
BEGIN
    DROP FUNCTION [dbo].[Fn_GetEscalaDescuentoZona]
END
GO
CREATE FUNCTION Fn_GetEscalaDescuentoZona(
	@campaniaId		INT, 
	@codRegion		VARCHAR(8) , 
	@codZona		VARCHAR(8)
)
RETURNS  @rtnTable TABLE 
(
    MontoHasta		NUMERIC(15, 2)	,
	PorDescuento	INT	
)
AS
BEGIN
INSERT INTO @rtnTable
SELECT MontoHasta,	PorDescuento FROM ods.escalaDescuentoZona  WHERE CampaniaId=@campaniaId and CodRegion=@codRegion and CodZona=@codZona;

IF ((SELECT COUNT(*) FROM @rtnTable) = 0)
BEGIN
	INSERT INTO @rtnTable
	SELECT MontoHasta,	PorDescuento FROM ods.EscalaDescuento ;
END
RETURN	
END
GO

USE [BelcorpEcuador]
GO
IF object_id('Fn_GetEscalaDescuentoZona') IS NOT NULL
BEGIN
    DROP FUNCTION [dbo].[Fn_GetEscalaDescuentoZona]
END
GO
CREATE FUNCTION Fn_GetEscalaDescuentoZona(
	@campaniaId		INT, 
	@codRegion		VARCHAR(8) , 
	@codZona		VARCHAR(8)
)
RETURNS  @rtnTable TABLE 
(
    MontoHasta		NUMERIC(15, 2)	,
	PorDescuento	INT	
)
AS
BEGIN
INSERT INTO @rtnTable
SELECT MontoHasta,	PorDescuento FROM ods.escalaDescuentoZona  WHERE CampaniaId=@campaniaId and CodRegion=@codRegion and CodZona=@codZona;

IF ((SELECT COUNT(*) FROM @rtnTable) = 0)
BEGIN
	INSERT INTO @rtnTable
	SELECT MontoHasta,	PorDescuento FROM ods.EscalaDescuento ;
END
RETURN	
END
GO

USE [BelcorpGuatemala]
GO
IF object_id('Fn_GetEscalaDescuentoZona') IS NOT NULL
BEGIN
    DROP FUNCTION [dbo].[Fn_GetEscalaDescuentoZona]
END
GO
CREATE FUNCTION Fn_GetEscalaDescuentoZona(
	@campaniaId		INT, 
	@codRegion		VARCHAR(8) , 
	@codZona		VARCHAR(8)
)
RETURNS  @rtnTable TABLE 
(
    MontoHasta		NUMERIC(15, 2)	,
	PorDescuento	INT	
)
AS
BEGIN
INSERT INTO @rtnTable
SELECT MontoHasta,	PorDescuento FROM ods.escalaDescuentoZona  WHERE CampaniaId=@campaniaId and CodRegion=@codRegion and CodZona=@codZona;

IF ((SELECT COUNT(*) FROM @rtnTable) = 0)
BEGIN
	INSERT INTO @rtnTable
	SELECT MontoHasta,	PorDescuento FROM ods.EscalaDescuento ;
END
RETURN	
END
GO

USE [BelcorpMexico]
GO
IF object_id('Fn_GetEscalaDescuentoZona') IS NOT NULL
BEGIN
    DROP FUNCTION [dbo].[Fn_GetEscalaDescuentoZona]
END
GO
CREATE FUNCTION Fn_GetEscalaDescuentoZona(
	@campaniaId		INT, 
	@codRegion		VARCHAR(8) , 
	@codZona		VARCHAR(8)
)
RETURNS  @rtnTable TABLE 
(
    MontoHasta		NUMERIC(15, 2)	,
	PorDescuento	INT	
)
AS
BEGIN
INSERT INTO @rtnTable
SELECT MontoHasta,	PorDescuento FROM ods.escalaDescuentoZona  WHERE CampaniaId=@campaniaId and CodRegion=@codRegion and CodZona=@codZona;

IF ((SELECT COUNT(*) FROM @rtnTable) = 0)
BEGIN
	INSERT INTO @rtnTable
	SELECT MontoHasta,	PorDescuento FROM ods.EscalaDescuento ;
END
RETURN	
END
GO

USE [BelcorpPanama]
GO
IF object_id('Fn_GetEscalaDescuentoZona') IS NOT NULL
BEGIN
    DROP FUNCTION [dbo].[Fn_GetEscalaDescuentoZona]
END
GO
CREATE FUNCTION Fn_GetEscalaDescuentoZona(
	@campaniaId		INT, 
	@codRegion		VARCHAR(8) , 
	@codZona		VARCHAR(8)
)
RETURNS  @rtnTable TABLE 
(
    MontoHasta		NUMERIC(15, 2)	,
	PorDescuento	INT	
)
AS
BEGIN
INSERT INTO @rtnTable
SELECT MontoHasta,	PorDescuento FROM ods.escalaDescuentoZona  WHERE CampaniaId=@campaniaId and CodRegion=@codRegion and CodZona=@codZona;

IF ((SELECT COUNT(*) FROM @rtnTable) = 0)
BEGIN
	INSERT INTO @rtnTable
	SELECT MontoHasta,	PorDescuento FROM ods.EscalaDescuento ;
END
RETURN	
END
GO

USE [BelcorpPuertoRico]
GO
IF object_id('Fn_GetEscalaDescuentoZona') IS NOT NULL
BEGIN
    DROP FUNCTION [dbo].[Fn_GetEscalaDescuentoZona]
END
GO
CREATE FUNCTION Fn_GetEscalaDescuentoZona(
	@campaniaId		INT, 
	@codRegion		VARCHAR(8) , 
	@codZona		VARCHAR(8)
)
RETURNS  @rtnTable TABLE 
(
    MontoHasta		NUMERIC(15, 2)	,
	PorDescuento	INT	
)
AS
BEGIN
INSERT INTO @rtnTable
SELECT MontoHasta,	PorDescuento FROM ods.escalaDescuentoZona  WHERE CampaniaId=@campaniaId and CodRegion=@codRegion and CodZona=@codZona;

IF ((SELECT COUNT(*) FROM @rtnTable) = 0)
BEGIN
	INSERT INTO @rtnTable
	SELECT MontoHasta,	PorDescuento FROM ods.EscalaDescuento ;
END
RETURN	
END
GO

USE [BelcorpSalvador]
GO
IF object_id('Fn_GetEscalaDescuentoZona') IS NOT NULL
BEGIN
    DROP FUNCTION [dbo].[Fn_GetEscalaDescuentoZona]
END
GO
CREATE FUNCTION Fn_GetEscalaDescuentoZona(
	@campaniaId		INT, 
	@codRegion		VARCHAR(8) , 
	@codZona		VARCHAR(8)
)
RETURNS  @rtnTable TABLE 
(
    MontoHasta		NUMERIC(15, 2)	,
	PorDescuento	INT	
)
AS
BEGIN
INSERT INTO @rtnTable
SELECT MontoHasta,	PorDescuento FROM ods.escalaDescuentoZona  WHERE CampaniaId=@campaniaId and CodRegion=@codRegion and CodZona=@codZona;

IF ((SELECT COUNT(*) FROM @rtnTable) = 0)
BEGIN
	INSERT INTO @rtnTable
	SELECT MontoHasta,	PorDescuento FROM ods.EscalaDescuento ;
END
RETURN	
END
GO







