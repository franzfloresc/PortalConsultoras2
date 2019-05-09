USE [BelcorpBolivia]
GO
IF EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @PermisoID INT = 0
	SELECT @PermisoID = PermisoID FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES'

	DELETE FROM RolPermiso WHERE PermisoID = @PermisoID

END
GO

USE [BelcorpChile]
GO
IF EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @PermisoID INT = 0
	SELECT @PermisoID = PermisoID FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES'
	
	DELETE FROM RolPermiso WHERE PermisoID = @PermisoID

END
GO

USE [BelcorpColombia]
GO
IF EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @PermisoID INT = 0
	SELECT @PermisoID = PermisoID FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES'

	DELETE FROM RolPermiso WHERE PermisoID = @PermisoID

END
GO

USE [BelcorpCostaRica]
GO
IF EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @PermisoID INT = 0
	SELECT @PermisoID = PermisoID FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES'
	
	DELETE FROM RolPermiso WHERE PermisoID = @PermisoID

END
GO

USE [BelcorpDominicana]
GO
IF EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @PermisoID INT = 0
	SELECT @PermisoID = PermisoID FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES'

	DELETE FROM RolPermiso WHERE PermisoID = @PermisoID

END
GO

USE [BelcorpEcuador]
GO
IF EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @PermisoID INT = 0
	SELECT @PermisoID = PermisoID FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES'
	
	DELETE FROM RolPermiso WHERE PermisoID = @PermisoID

END
GO

USE [BelcorpGuatemala]
GO
IF EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @PermisoID INT = 0
	SELECT @PermisoID = PermisoID FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES'
	
	DELETE FROM RolPermiso WHERE PermisoID = @PermisoID

END
GO

USE [BelcorpMexico]
GO
IF EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @PermisoID INT = 0
	SELECT @PermisoID = PermisoID FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES'
	
	DELETE FROM RolPermiso WHERE PermisoID = @PermisoID

END
GO

USE [BelcorpPanama]
GO
IF EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @PermisoID INT = 0
	SELECT @PermisoID = PermisoID FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES'

	DELETE FROM RolPermiso WHERE PermisoID = @PermisoID

END
GO

USE [BelcorpPeru]
GO
IF EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @PermisoID INT = 0
	SELECT @PermisoID = PermisoID FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES'
	
	DELETE FROM RolPermiso WHERE PermisoID = @PermisoID

END
GO

USE [BelcorpPuertoRico]
GO
IF EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @PermisoID INT = 0
	SELECT @PermisoID = PermisoID FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES'
	
	DELETE FROM RolPermiso WHERE PermisoID = @PermisoID

END
GO

USE [BelcorpSalvador]
GO
IF EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN

	DECLARE @PermisoID INT = 0
	SELECT @PermisoID = PermisoID FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES'
	
	DELETE FROM RolPermiso WHERE PermisoID = @PermisoID

END
GO
