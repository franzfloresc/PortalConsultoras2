USE [BelcorpBolivia]
GO
IF EXISTS(SELECT 1 FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @MenuMobileID INT = 0
	SELECT @MenuMobileID = MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES'

	DELETE FROM MenuMobile WHERE MenuMobileID = @MenuMobileID

END
GO

USE [BelcorpChile]
GO
IF EXISTS(SELECT 1 FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @MenuMobileID INT = 0
	SELECT @MenuMobileID = MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES'
	
	DELETE FROM MenuMobile WHERE MenuMobileID = @MenuMobileID

END
GO

USE [BelcorpColombia]
GO
IF EXISTS(SELECT 1 FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @MenuMobileID INT = 0
	SELECT @MenuMobileID = MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES'

	DELETE FROM MenuMobile WHERE MenuMobileID = @MenuMobileID

END
GO

USE [BelcorpCostaRica]
GO
IF EXISTS(SELECT 1 FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @MenuMobileID INT = 0
	SELECT @MenuMobileID = MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES'

	DELETE FROM MenuMobile WHERE MenuMobileID = @MenuMobileID

END
GO

USE [BelcorpDominicana]
GO
IF EXISTS(SELECT 1 FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @MenuMobileID INT = 0
	SELECT @MenuMobileID = MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES'
	
	DELETE FROM MenuMobile WHERE MenuMobileID = @MenuMobileID

END
GO

USE [BelcorpEcuador]
GO
IF EXISTS(SELECT 1 FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @MenuMobileID INT = 0
	SELECT @MenuMobileID = MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES'
	
	DELETE FROM MenuMobile WHERE MenuMobileID = @MenuMobileID

END
GO

USE [BelcorpGuatemala]
GO
IF EXISTS(SELECT 1 FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @MenuMobileID INT = 0
	SELECT @MenuMobileID = MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES'

	DELETE FROM MenuMobile WHERE MenuMobileID = @MenuMobileID

END
GO

USE [BelcorpMexico]
GO
IF EXISTS(SELECT 1 FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @MenuMobileID INT = 0
	SELECT @MenuMobileID = MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES'
	
	DELETE FROM MenuMobile WHERE MenuMobileID = @MenuMobileID

END
GO

USE [BelcorpPanama]
GO
IF EXISTS(SELECT 1 FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @MenuMobileID INT = 0
	SELECT @MenuMobileID = MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES'
	
	DELETE FROM MenuMobile WHERE MenuMobileID = @MenuMobileID

END
GO

USE [BelcorpPeru]
GO
IF EXISTS(SELECT 1 FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @MenuMobileID INT = 0
	SELECT @MenuMobileID = MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES'
	
	DELETE FROM MenuMobile WHERE MenuMobileID = @MenuMobileID

END
GO

USE [BelcorpPuertoRico]
GO
IF EXISTS(SELECT 1 FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @MenuMobileID INT = 0
	SELECT @MenuMobileID = MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES'
	
	DELETE FROM MenuMobile WHERE MenuMobileID = @MenuMobileID

END
GO

USE [BelcorpSalvador]
GO
IF EXISTS(SELECT 1 FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @MenuMobileID INT = 0
	SELECT @MenuMobileID = MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES'

	DELETE FROM MenuMobile WHERE MenuMobileID = @MenuMobileID

END
GO
