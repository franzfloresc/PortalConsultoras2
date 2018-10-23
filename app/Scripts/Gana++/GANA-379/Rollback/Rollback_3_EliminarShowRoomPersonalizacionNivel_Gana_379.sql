USE BelcorpPeru_PL50
GO
IF EXISTS(SELECT 1 FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[ShowRoom].[EliminarShowRoomPersonalizacionNivel]') 
	AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
END
GO

USE BelcorpChile_PL50
GO
IF EXISTS(SELECT 1 FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[ShowRoom].[EliminarShowRoomPersonalizacionNivel]') 
	AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
END
GO
