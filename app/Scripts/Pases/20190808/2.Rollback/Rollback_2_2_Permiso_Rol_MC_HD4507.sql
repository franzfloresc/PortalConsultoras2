USE [BelcorpBolivia];
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT PermisoID FROM dbo.Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81);

DELETE FROM RolPermiso WHERE PermisoID=@PermisoID;
DELETE FROM Permiso WHERE PermisoID=@PermisoID;
GO
USE [BelcorpChile];
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT PermisoID FROM dbo.Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81);

DELETE FROM RolPermiso WHERE PermisoID=@PermisoID;
DELETE FROM Permiso WHERE PermisoID=@PermisoID;
GO
USE [BelcorpColombia];
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT PermisoID FROM dbo.Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81);

DELETE FROM RolPermiso WHERE PermisoID=@PermisoID;
DELETE FROM Permiso WHERE PermisoID=@PermisoID;
GO
USE [BelcorpCostaRica];
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT PermisoID FROM dbo.Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81);

DELETE FROM RolPermiso WHERE PermisoID=@PermisoID;
DELETE FROM Permiso WHERE PermisoID=@PermisoID;
GO
USE [BelcorpDominicana];
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT PermisoID FROM dbo.Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81);

DELETE FROM RolPermiso WHERE PermisoID=@PermisoID;
DELETE FROM Permiso WHERE PermisoID=@PermisoID;
GO
USE [BelcorpEcuador];
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT PermisoID FROM dbo.Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81);

DELETE FROM RolPermiso WHERE PermisoID=@PermisoID;
DELETE FROM Permiso WHERE PermisoID=@PermisoID;
GO
USE [BelcorpGuatemala];
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT PermisoID FROM dbo.Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81);

DELETE FROM RolPermiso WHERE PermisoID=@PermisoID;
DELETE FROM Permiso WHERE PermisoID=@PermisoID;
GO
USE [BelcorpMexico];
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT PermisoID FROM dbo.Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81);

DELETE FROM RolPermiso WHERE PermisoID=@PermisoID;
DELETE FROM Permiso WHERE PermisoID=@PermisoID;
GO
USE [BelcorpPanama];
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT PermisoID FROM dbo.Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81);

DELETE FROM RolPermiso WHERE PermisoID=@PermisoID;
DELETE FROM Permiso WHERE PermisoID=@PermisoID;
GO
USE [BelcorpPeru];
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT PermisoID FROM dbo.Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81);

DELETE FROM RolPermiso WHERE PermisoID=@PermisoID;
DELETE FROM Permiso WHERE PermisoID=@PermisoID;
GO
USE [BelcorpPuertoRico];
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT PermisoID FROM dbo.Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81);

DELETE FROM RolPermiso WHERE PermisoID=@PermisoID;
DELETE FROM Permiso WHERE PermisoID=@PermisoID;
GO
USE [BelcorpSalvador];
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT PermisoID FROM dbo.Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81);

DELETE FROM RolPermiso WHERE PermisoID=@PermisoID;
DELETE FROM Permiso WHERE PermisoID=@PermisoID;
GO
