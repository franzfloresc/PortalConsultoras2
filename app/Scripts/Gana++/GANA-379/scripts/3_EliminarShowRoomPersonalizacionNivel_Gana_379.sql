USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[ShowRoom].[EliminarShowRoomPersonalizacionNivel]') 
	AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
END
GO
CREATE PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
@EventoID INT
AS
BEGIN
	DELETE FROM ShowRoom.PersonalizacionNivel WHERE eventoId = @EventoID
END
GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[ShowRoom].[EliminarShowRoomPersonalizacionNivel]') 
	AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
END
GO
CREATE PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
@EventoID INT
AS
BEGIN
	DELETE FROM ShowRoom.PersonalizacionNivel WHERE eventoId = @EventoID
END
GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[ShowRoom].[EliminarShowRoomPersonalizacionNivel]') 
	AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
END
GO
CREATE PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
@EventoID INT
AS
BEGIN
	DELETE FROM ShowRoom.PersonalizacionNivel WHERE eventoId = @EventoID
END
GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[ShowRoom].[EliminarShowRoomPersonalizacionNivel]') 
	AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
END
GO
CREATE PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
@EventoID INT
AS
BEGIN
	DELETE FROM ShowRoom.PersonalizacionNivel WHERE eventoId = @EventoID
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[ShowRoom].[EliminarShowRoomPersonalizacionNivel]') 
	AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
END
GO
CREATE PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
@EventoID INT
AS
BEGIN
	DELETE FROM ShowRoom.PersonalizacionNivel WHERE eventoId = @EventoID
END
GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[ShowRoom].[EliminarShowRoomPersonalizacionNivel]') 
	AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
END
GO
CREATE PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
@EventoID INT
AS
BEGIN
	DELETE FROM ShowRoom.PersonalizacionNivel WHERE eventoId = @EventoID
END
GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[ShowRoom].[EliminarShowRoomPersonalizacionNivel]') 
	AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
END
GO
CREATE PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
@EventoID INT
AS
BEGIN
	DELETE FROM ShowRoom.PersonalizacionNivel WHERE eventoId = @EventoID
END
GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[ShowRoom].[EliminarShowRoomPersonalizacionNivel]') 
	AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
END
GO
CREATE PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
@EventoID INT
AS
BEGIN
	DELETE FROM ShowRoom.PersonalizacionNivel WHERE eventoId = @EventoID
END
GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[ShowRoom].[EliminarShowRoomPersonalizacionNivel]') 
	AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
END
GO
CREATE PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
@EventoID INT
AS
BEGIN
	DELETE FROM ShowRoom.PersonalizacionNivel WHERE eventoId = @EventoID
END
GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[ShowRoom].[EliminarShowRoomPersonalizacionNivel]') 
	AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
END
GO
CREATE PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
@EventoID INT
AS
BEGIN
	DELETE FROM ShowRoom.PersonalizacionNivel WHERE eventoId = @EventoID
END
GO

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[ShowRoom].[EliminarShowRoomPersonalizacionNivel]') 
	AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
END
GO
CREATE PROCEDURE ShowRoom.EliminarShowRoomPersonalizacionNivel
@EventoID INT
AS
BEGIN
	DELETE FROM ShowRoom.PersonalizacionNivel WHERE eventoId = @EventoID
END
GO

