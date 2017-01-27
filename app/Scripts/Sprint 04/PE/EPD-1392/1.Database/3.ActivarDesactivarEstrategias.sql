USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))
	END

	SET NOCOUNT OFF
END

GO

------------------------------------------------------------------------------------------------------------------------------------------------------

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))
	END

	SET NOCOUNT OFF
END

GO

------------------------------------------------------------------------------------------------------------------------------------------------------

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))
	END

	SET NOCOUNT OFF
END

GO

------------------------------------------------------------------------------------------------------------------------------------------------------

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))
	END

	SET NOCOUNT OFF
END

GO

------------------------------------------------------------------------------------------------------------------------------------------------------

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))
	END

	SET NOCOUNT OFF
END

GO

------------------------------------------------------------------------------------------------------------------------------------------------------

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))
	END

	SET NOCOUNT OFF
END

GO

------------------------------------------------------------------------------------------------------------------------------------------------------

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))
	END

	SET NOCOUNT OFF
END

GO

------------------------------------------------------------------------------------------------------------------------------------------------------

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))
	END

	SET NOCOUNT OFF
END

GO

------------------------------------------------------------------------------------------------------------------------------------------------------

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))
	END

	SET NOCOUNT OFF
END

GO

------------------------------------------------------------------------------------------------------------------------------------------------------

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))
	END

	SET NOCOUNT OFF
END

GO

------------------------------------------------------------------------------------------------------------------------------------------------------

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))
	END

	SET NOCOUNT OFF
END

GO

------------------------------------------------------------------------------------------------------------------------------------------------------

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))
	END

	SET NOCOUNT OFF
END

GO

------------------------------------------------------------------------------------------------------------------------------------------------------

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))
	END

	SET NOCOUNT OFF
END

GO

------------------------------------------------------------------------------------------------------------------------------------------------------

