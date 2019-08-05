USE [BelcorpBolivia];
GO
if not exists(select  1 from Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81)
begin 
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

end
GO
USE [BelcorpChile];
GO
if not exists(select  1 from Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81)
begin 
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

end
GO
USE [BelcorpColombia];
GO
if not exists(select  1 from Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81)
begin 
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

end
GO
USE [BelcorpCostaRica];
GO
if not exists(select  1 from Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81)
begin 
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

end
GO
USE [BelcorpDominicana];
GO
if not exists(select  1 from Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81)
begin 
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

end
GO
USE [BelcorpEcuador];
GO
if not exists(select  1 from Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81)
begin 
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

end
GO
USE [BelcorpGuatemala];
GO
if not exists(select  1 from Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81)
begin 
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

end
GO
USE [BelcorpMexico];
GO
if not exists(select  1 from Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81)
begin 
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

end
GO
USE [BelcorpPanama];
GO
if not exists(select  1 from Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81)
begin 
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

end
GO
USE [BelcorpPeru];
GO
if not exists(select  1 from Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81)
begin 
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

end
GO
USE [BelcorpPuertoRico];
GO
if not exists(select  1 from Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81)
begin 
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

end
GO
USE [BelcorpSalvador];
GO
if not exists(select  1 from Permiso where [UrlItem] ='Chatbot/Index' and IdPadre =81)
begin 
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

end
GO
