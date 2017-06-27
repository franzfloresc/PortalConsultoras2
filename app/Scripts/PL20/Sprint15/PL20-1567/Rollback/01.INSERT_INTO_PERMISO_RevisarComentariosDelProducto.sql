USE BelcorpBolivia
GO

BEGIN
	DECLARE @PermisoID int;

    SELECT @PermisoID = PermisoID  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @PermisoID != '' AND @PermisoID IS NOT NULL  
	BEGIN
		delete from RolPermiso where PermisoID = @PermisoID;
		delete from Permiso where PermisoID = @PermisoID;
	END	
END
GO

USE BelcorpChile
GO

BEGIN
	DECLARE @PermisoID int;

    SELECT @PermisoID = PermisoID  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @PermisoID != '' AND @PermisoID IS NOT NULL  
	BEGIN
		delete from RolPermiso where PermisoID = @PermisoID;
		delete from Permiso where PermisoID = @PermisoID;
	END	
END
GO

USE BelcorpColombia
GO

BEGIN
	DECLARE @PermisoID int;

    SELECT @PermisoID = PermisoID  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @PermisoID != '' AND @PermisoID IS NOT NULL  
	BEGIN
		delete from RolPermiso where PermisoID = @PermisoID;
		delete from Permiso where PermisoID = @PermisoID;
	END		
END
GO

USE BelcorpCostaRica
GO

BEGIN
	DECLARE @PermisoID int;

    SELECT @PermisoID = PermisoID  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @PermisoID != '' AND @PermisoID IS NOT NULL  
	BEGIN
		delete from RolPermiso where PermisoID = @PermisoID;
		delete from Permiso where PermisoID = @PermisoID;
	END		
END
GO

USE BelcorpDominicana
GO

BEGIN
	DECLARE @PermisoID int;

    SELECT @PermisoID = PermisoID  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @PermisoID != '' AND @PermisoID IS NOT NULL  
	BEGIN
		delete from RolPermiso where PermisoID = @PermisoID;
		delete from Permiso where PermisoID = @PermisoID;
	END	
END
GO

USE BelcorpEcuador
GO

BEGIN
	DECLARE @PermisoID int;

    SELECT @PermisoID = PermisoID  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @PermisoID != '' AND @PermisoID IS NOT NULL  
	BEGIN
		delete from RolPermiso where PermisoID = @PermisoID;
		delete from Permiso where PermisoID = @PermisoID;
	END		
END
GO

USE BelcorpGuatemala
GO

BEGIN
	DECLARE @PermisoID int;

    SELECT @PermisoID = PermisoID  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @PermisoID != '' AND @PermisoID IS NOT NULL  
	BEGIN
		delete from RolPermiso where PermisoID = @PermisoID;
		delete from Permiso where PermisoID = @PermisoID;
	END		
END
GO

USE BelcorpMexico
GO

BEGIN
	DECLARE @PermisoID int;

    SELECT @PermisoID = PermisoID  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @PermisoID != '' AND @PermisoID IS NOT NULL  
	BEGIN
		delete from RolPermiso where PermisoID = @PermisoID;
		delete from Permiso where PermisoID = @PermisoID;
	END		
END
GO

USE BelcorpPanama
GO

BEGIN
	DECLARE @PermisoID int;

    SELECT @PermisoID = PermisoID  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @PermisoID != '' AND @PermisoID IS NOT NULL  
	BEGIN
		delete from RolPermiso where PermisoID = @PermisoID;
		delete from Permiso where PermisoID = @PermisoID;
	END		
END
GO

USE BelcorpPeru
GO

BEGIN
	DECLARE @PermisoID int;

    SELECT @PermisoID = PermisoID  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @PermisoID != '' AND @PermisoID IS NOT NULL  
	BEGIN
		delete from RolPermiso where PermisoID = @PermisoID;
		delete from Permiso where PermisoID = @PermisoID;
	END		
END
GO

USE BelcorpPuertoRico
GO

BEGIN
	DECLARE @PermisoID int;

    SELECT @PermisoID = PermisoID  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @PermisoID != '' AND @PermisoID IS NOT NULL  
	BEGIN
		delete from RolPermiso where PermisoID = @PermisoID;
		delete from Permiso where PermisoID = @PermisoID;
	END		
END
GO

USE BelcorpSalvador
GO

BEGIN
	DECLARE @PermisoID int;

    SELECT @PermisoID = PermisoID  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @PermisoID != '' AND @PermisoID IS NOT NULL  
	BEGIN
		delete from RolPermiso where PermisoID = @PermisoID;
		delete from Permiso where PermisoID = @PermisoID;
	END		
END
GO

USE BelcorpVenezuela
GO

BEGIN
	DECLARE @PermisoID int;

    SELECT @PermisoID = PermisoID  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @PermisoID != '' AND @PermisoID IS NOT NULL  
	BEGIN
		delete from RolPermiso where PermisoID = @PermisoID;
		delete from Permiso where PermisoID = @PermisoID;
	END		
END
GO
