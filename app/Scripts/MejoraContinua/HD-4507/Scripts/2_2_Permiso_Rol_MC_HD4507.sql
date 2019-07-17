GO
USE BelcorpPeru
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT ISNULL(MAX(PermisoID) + 1, 0) FROM dbo.Permiso);
INSERT INTO [dbo].[Permiso]
           ([PermisoID]
           ,[Descripcion]
           ,[IdPadre]
           ,[OrdenItem]
           ,[UrlItem]
           ,[PaginaNueva]
           ,[Posicion]
           ,[UrlImagen]
           ,[EsSoloImagen]
           ,[EsMenuEspecial]
           ,[EsServicios]
           ,[EsPrincipal]
           ,[Codigo])
     VALUES
           (@PermisoID
           ,'Encuesta Chatbot'
           ,81
           ,102
           ,'Chatbot/Index'
           ,0
           ,'Header'
           ,NULL
           ,0
           ,0
           ,0
           ,0
           ,NULL);

INSERT INTO [dbo].[RolPermiso]
           ([RolID]
           ,[PermisoID]
           ,[Activo]
           ,[Mostrar])
     VALUES
           (3
           ,@PermisoID
           ,1
           ,1);

GO
USE BelcorpMexico
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT ISNULL(MAX(PermisoID) + 1, 0) FROM dbo.Permiso);
INSERT INTO [dbo].[Permiso]
           ([PermisoID]
           ,[Descripcion]
           ,[IdPadre]
           ,[OrdenItem]
           ,[UrlItem]
           ,[PaginaNueva]
           ,[Posicion]
           ,[UrlImagen]
           ,[EsSoloImagen]
           ,[EsMenuEspecial]
           ,[EsServicios]
           ,[EsPrincipal]
           ,[Codigo])
     VALUES
           (@PermisoID
           ,'Encuesta Chatbot'
           ,81
           ,102
           ,'Chatbot/Index'
           ,0
           ,'Header'
           ,NULL
           ,0
           ,0
           ,0
           ,0
           ,NULL);

INSERT INTO [dbo].[RolPermiso]
           ([RolID]
           ,[PermisoID]
           ,[Activo]
           ,[Mostrar])
     VALUES
           (3
           ,@PermisoID
           ,1
           ,1);

GO
USE BelcorpColombia
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT ISNULL(MAX(PermisoID) + 1, 0) FROM dbo.Permiso);
INSERT INTO [dbo].[Permiso]
           ([PermisoID]
           ,[Descripcion]
           ,[IdPadre]
           ,[OrdenItem]
           ,[UrlItem]
           ,[PaginaNueva]
           ,[Posicion]
           ,[UrlImagen]
           ,[EsSoloImagen]
           ,[EsMenuEspecial]
           ,[EsServicios]
           ,[EsPrincipal]
           ,[Codigo])
     VALUES
           (@PermisoID
           ,'Encuesta Chatbot'
           ,81
           ,102
           ,'Chatbot/Index'
           ,0
           ,'Header'
           ,NULL
           ,0
           ,0
           ,0
           ,0
           ,NULL);

INSERT INTO [dbo].[RolPermiso]
           ([RolID]
           ,[PermisoID]
           ,[Activo]
           ,[Mostrar])
     VALUES
           (3
           ,@PermisoID
           ,1
           ,1);

GO
USE BelcorpSalvador
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT ISNULL(MAX(PermisoID) + 1, 0) FROM dbo.Permiso);
INSERT INTO [dbo].[Permiso]
           ([PermisoID]
           ,[Descripcion]
           ,[IdPadre]
           ,[OrdenItem]
           ,[UrlItem]
           ,[PaginaNueva]
           ,[Posicion]
           ,[UrlImagen]
           ,[EsSoloImagen]
           ,[EsMenuEspecial]
           ,[EsServicios]
           ,[EsPrincipal]
           ,[Codigo])
     VALUES
           (@PermisoID
           ,'Encuesta Chatbot'
           ,81
           ,102
           ,'Chatbot/Index'
           ,0
           ,'Header'
           ,NULL
           ,0
           ,0
           ,0
           ,0
           ,NULL);

INSERT INTO [dbo].[RolPermiso]
           ([RolID]
           ,[PermisoID]
           ,[Activo]
           ,[Mostrar])
     VALUES
           (3
           ,@PermisoID
           ,1
           ,1);

GO
USE BelcorpPuertoRico
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT ISNULL(MAX(PermisoID) + 1, 0) FROM dbo.Permiso);
INSERT INTO [dbo].[Permiso]
           ([PermisoID]
           ,[Descripcion]
           ,[IdPadre]
           ,[OrdenItem]
           ,[UrlItem]
           ,[PaginaNueva]
           ,[Posicion]
           ,[UrlImagen]
           ,[EsSoloImagen]
           ,[EsMenuEspecial]
           ,[EsServicios]
           ,[EsPrincipal]
           ,[Codigo])
     VALUES
           (@PermisoID
           ,'Encuesta Chatbot'
           ,81
           ,102
           ,'Chatbot/Index'
           ,0
           ,'Header'
           ,NULL
           ,0
           ,0
           ,0
           ,0
           ,NULL);

INSERT INTO [dbo].[RolPermiso]
           ([RolID]
           ,[PermisoID]
           ,[Activo]
           ,[Mostrar])
     VALUES
           (3
           ,@PermisoID
           ,1
           ,1);

GO
USE BelcorpPanama
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT ISNULL(MAX(PermisoID) + 1, 0) FROM dbo.Permiso);
INSERT INTO [dbo].[Permiso]
           ([PermisoID]
           ,[Descripcion]
           ,[IdPadre]
           ,[OrdenItem]
           ,[UrlItem]
           ,[PaginaNueva]
           ,[Posicion]
           ,[UrlImagen]
           ,[EsSoloImagen]
           ,[EsMenuEspecial]
           ,[EsServicios]
           ,[EsPrincipal]
           ,[Codigo])
     VALUES
           (@PermisoID
           ,'Encuesta Chatbot'
           ,81
           ,102
           ,'Chatbot/Index'
           ,0
           ,'Header'
           ,NULL
           ,0
           ,0
           ,0
           ,0
           ,NULL);

INSERT INTO [dbo].[RolPermiso]
           ([RolID]
           ,[PermisoID]
           ,[Activo]
           ,[Mostrar])
     VALUES
           (3
           ,@PermisoID
           ,1
           ,1);

GO
USE BelcorpGuatemala
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT ISNULL(MAX(PermisoID) + 1, 0) FROM dbo.Permiso);
INSERT INTO [dbo].[Permiso]
           ([PermisoID]
           ,[Descripcion]
           ,[IdPadre]
           ,[OrdenItem]
           ,[UrlItem]
           ,[PaginaNueva]
           ,[Posicion]
           ,[UrlImagen]
           ,[EsSoloImagen]
           ,[EsMenuEspecial]
           ,[EsServicios]
           ,[EsPrincipal]
           ,[Codigo])
     VALUES
           (@PermisoID
           ,'Encuesta Chatbot'
           ,81
           ,102
           ,'Chatbot/Index'
           ,0
           ,'Header'
           ,NULL
           ,0
           ,0
           ,0
           ,0
           ,NULL);

INSERT INTO [dbo].[RolPermiso]
           ([RolID]
           ,[PermisoID]
           ,[Activo]
           ,[Mostrar])
     VALUES
           (3
           ,@PermisoID
           ,1
           ,1);

GO
USE BelcorpEcuador
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT ISNULL(MAX(PermisoID) + 1, 0) FROM dbo.Permiso);
INSERT INTO [dbo].[Permiso]
           ([PermisoID]
           ,[Descripcion]
           ,[IdPadre]
           ,[OrdenItem]
           ,[UrlItem]
           ,[PaginaNueva]
           ,[Posicion]
           ,[UrlImagen]
           ,[EsSoloImagen]
           ,[EsMenuEspecial]
           ,[EsServicios]
           ,[EsPrincipal]
           ,[Codigo])
     VALUES
           (@PermisoID
           ,'Encuesta Chatbot'
           ,81
           ,102
           ,'Chatbot/Index'
           ,0
           ,'Header'
           ,NULL
           ,0
           ,0
           ,0
           ,0
           ,NULL);

INSERT INTO [dbo].[RolPermiso]
           ([RolID]
           ,[PermisoID]
           ,[Activo]
           ,[Mostrar])
     VALUES
           (3
           ,@PermisoID
           ,1
           ,1);

GO
USE BelcorpDominicana
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT ISNULL(MAX(PermisoID) + 1, 0) FROM dbo.Permiso);
INSERT INTO [dbo].[Permiso]
           ([PermisoID]
           ,[Descripcion]
           ,[IdPadre]
           ,[OrdenItem]
           ,[UrlItem]
           ,[PaginaNueva]
           ,[Posicion]
           ,[UrlImagen]
           ,[EsSoloImagen]
           ,[EsMenuEspecial]
           ,[EsServicios]
           ,[EsPrincipal]
           ,[Codigo])
     VALUES
           (@PermisoID
           ,'Encuesta Chatbot'
           ,81
           ,102
           ,'Chatbot/Index'
           ,0
           ,'Header'
           ,NULL
           ,0
           ,0
           ,0
           ,0
           ,NULL);

INSERT INTO [dbo].[RolPermiso]
           ([RolID]
           ,[PermisoID]
           ,[Activo]
           ,[Mostrar])
     VALUES
           (3
           ,@PermisoID
           ,1
           ,1);

GO
USE BelcorpCostaRica
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT ISNULL(MAX(PermisoID) + 1, 0) FROM dbo.Permiso);
INSERT INTO [dbo].[Permiso]
           ([PermisoID]
           ,[Descripcion]
           ,[IdPadre]
           ,[OrdenItem]
           ,[UrlItem]
           ,[PaginaNueva]
           ,[Posicion]
           ,[UrlImagen]
           ,[EsSoloImagen]
           ,[EsMenuEspecial]
           ,[EsServicios]
           ,[EsPrincipal]
           ,[Codigo])
     VALUES
           (@PermisoID
           ,'Encuesta Chatbot'
           ,81
           ,102
           ,'Chatbot/Index'
           ,0
           ,'Header'
           ,NULL
           ,0
           ,0
           ,0
           ,0
           ,NULL);

INSERT INTO [dbo].[RolPermiso]
           ([RolID]
           ,[PermisoID]
           ,[Activo]
           ,[Mostrar])
     VALUES
           (3
           ,@PermisoID
           ,1
           ,1);

GO
USE BelcorpChile
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT ISNULL(MAX(PermisoID) + 1, 0) FROM dbo.Permiso);
INSERT INTO [dbo].[Permiso]
           ([PermisoID]
           ,[Descripcion]
           ,[IdPadre]
           ,[OrdenItem]
           ,[UrlItem]
           ,[PaginaNueva]
           ,[Posicion]
           ,[UrlImagen]
           ,[EsSoloImagen]
           ,[EsMenuEspecial]
           ,[EsServicios]
           ,[EsPrincipal]
           ,[Codigo])
     VALUES
           (@PermisoID
           ,'Encuesta Chatbot'
           ,81
           ,102
           ,'Chatbot/Index'
           ,0
           ,'Header'
           ,NULL
           ,0
           ,0
           ,0
           ,0
           ,NULL);

INSERT INTO [dbo].[RolPermiso]
           ([RolID]
           ,[PermisoID]
           ,[Activo]
           ,[Mostrar])
     VALUES
           (3
           ,@PermisoID
           ,1
           ,1);

GO
USE BelcorpBolivia
GO
Declare @PermisoID AS int;
set @PermisoID = (SELECT ISNULL(MAX(PermisoID) + 1, 0) FROM dbo.Permiso);
INSERT INTO [dbo].[Permiso]
           ([PermisoID]
           ,[Descripcion]
           ,[IdPadre]
           ,[OrdenItem]
           ,[UrlItem]
           ,[PaginaNueva]
           ,[Posicion]
           ,[UrlImagen]
           ,[EsSoloImagen]
           ,[EsMenuEspecial]
           ,[EsServicios]
           ,[EsPrincipal]
           ,[Codigo])
     VALUES
           (@PermisoID
           ,'Encuesta Chatbot'
           ,81
           ,102
           ,'Chatbot/Index'
           ,0
           ,'Header'
           ,NULL
           ,0
           ,0
           ,0
           ,0
           ,NULL);

INSERT INTO [dbo].[RolPermiso]
           ([RolID]
           ,[PermisoID]
           ,[Activo]
           ,[Mostrar])
     VALUES
           (3
           ,@PermisoID
           ,1
           ,1);

GO
