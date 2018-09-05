USE BelcorpPeru
GO

if not exists(select 1 from Permiso where Descripcion = 'Reporte de Contrato')
begin

	-- MENU Y PERMISO
	--@IDPadre => Consultora: 1003, SAC: 81, ADMCONTENIDO: 111
	DECLARE @IDPadre INT = 81
	--@RolID Consultora: 1, SAC: 3, ADMCONTENIDO: 4
	DECLARE @RolID INT = 3
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	
	-- select * from Permiso  WHERE IDPadre = 81
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;
	--SELECT @PermisoID, @OrdenItem


    insert into Permiso ([PermisoID]
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
		   values(@PermisoID+1,'Reporte de Contrato',@IDPadre,@OrdenItem + 1,'ReporteContrato/Index',0,'Header','',0,0,0,0,null)
	
	   INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 0, 1)

end
GO

USE BelcorpMexico
GO

if not exists(select 1 from Permiso where Descripcion = 'Reporte de Contrato')
begin

	-- MENU Y PERMISO
	--@IDPadre => Consultora: 1003, SAC: 81, ADMCONTENIDO: 111
	DECLARE @IDPadre INT = 81
	--@RolID Consultora: 1, SAC: 3, ADMCONTENIDO: 4
	DECLARE @RolID INT = 3
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	
	-- select * from Permiso  WHERE IDPadre = 81
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;
	--SELECT @PermisoID, @OrdenItem


    insert into Permiso ([PermisoID]
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
		   values(@PermisoID+1,'Reporte de Contrato',@IDPadre,@OrdenItem + 1,'ReporteContrato/Index',0,'Header','',0,0,0,0,null)
	
	   INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 0, 1)

end
GO

USE BelcorpColombia
GO

if not exists(select 1 from Permiso where Descripcion = 'Reporte de Contrato')
begin

	-- MENU Y PERMISO
	--@IDPadre => Consultora: 1003, SAC: 81, ADMCONTENIDO: 111
	DECLARE @IDPadre INT = 81
	--@RolID Consultora: 1, SAC: 3, ADMCONTENIDO: 4
	DECLARE @RolID INT = 3
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	
	-- select * from Permiso  WHERE IDPadre = 81
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;
	--SELECT @PermisoID, @OrdenItem


    insert into Permiso ([PermisoID]
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
		   values(@PermisoID+1,'Reporte de Contrato',@IDPadre,@OrdenItem + 1,'ReporteContrato/Index',0,'Header','',0,0,0,0,null)
	
	   INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 1, 1)

end
GO

USE BelcorpSalvador
GO

if not exists(select 1 from Permiso where Descripcion = 'Reporte de Contrato')
begin

	-- MENU Y PERMISO
	--@IDPadre => Consultora: 1003, SAC: 81, ADMCONTENIDO: 111
	DECLARE @IDPadre INT = 81
	--@RolID Consultora: 1, SAC: 3, ADMCONTENIDO: 4
	DECLARE @RolID INT = 3
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	
	-- select * from Permiso  WHERE IDPadre = 81
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;
	--SELECT @PermisoID, @OrdenItem


    insert into Permiso ([PermisoID]
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
		   values(@PermisoID+1,'Reporte de Contrato',@IDPadre,@OrdenItem + 1,'ReporteContrato/Index',0,'Header','',0,0,0,0,null)
	
	   INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 0, 1)

end
GO

USE BelcorpPuertoRico
GO

if not exists(select 1 from Permiso where Descripcion = 'Reporte de Contrato')
begin

	-- MENU Y PERMISO
	--@IDPadre => Consultora: 1003, SAC: 81, ADMCONTENIDO: 111
	DECLARE @IDPadre INT = 81
	--@RolID Consultora: 1, SAC: 3, ADMCONTENIDO: 4
	DECLARE @RolID INT = 3
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	
	-- select * from Permiso  WHERE IDPadre = 81
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;
	--SELECT @PermisoID, @OrdenItem


    insert into Permiso ([PermisoID]
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
		   values(@PermisoID+1,'Reporte de Contrato',@IDPadre,@OrdenItem + 1,'ReporteContrato/Index',0,'Header','',0,0,0,0,null)
	
	   INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 0, 1)

end
GO

USE BelcorpPanama
GO

if not exists(select 1 from Permiso where Descripcion = 'Reporte de Contrato')
begin

	-- MENU Y PERMISO
	--@IDPadre => Consultora: 1003, SAC: 81, ADMCONTENIDO: 111
	DECLARE @IDPadre INT = 81
	--@RolID Consultora: 1, SAC: 3, ADMCONTENIDO: 4
	DECLARE @RolID INT = 3
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	
	-- select * from Permiso  WHERE IDPadre = 81
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;
	--SELECT @PermisoID, @OrdenItem


    insert into Permiso ([PermisoID]
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
		   values(@PermisoID+1,'Reporte de Contrato',@IDPadre,@OrdenItem + 1,'ReporteContrato/Index',0,'Header','',0,0,0,0,null)
	
	   INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 0, 1)

end
GO

USE BelcorpGuatemala
GO

if not exists(select 1 from Permiso where Descripcion = 'Reporte de Contrato')
begin

	-- MENU Y PERMISO
	--@IDPadre => Consultora: 1003, SAC: 81, ADMCONTENIDO: 111
	DECLARE @IDPadre INT = 81
	--@RolID Consultora: 1, SAC: 3, ADMCONTENIDO: 4
	DECLARE @RolID INT = 3
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	
	-- select * from Permiso  WHERE IDPadre = 81
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;
	--SELECT @PermisoID, @OrdenItem


    insert into Permiso ([PermisoID]
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
		   values(@PermisoID+1,'Reporte de Contrato',@IDPadre,@OrdenItem + 1,'ReporteContrato/Index',0,'Header','',0,0,0,0,null)
	
	   INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 0, 1)

end
GO

USE BelcorpEcuador
GO

if not exists(select 1 from Permiso where Descripcion = 'Reporte de Contrato')
begin

	-- MENU Y PERMISO
	--@IDPadre => Consultora: 1003, SAC: 81, ADMCONTENIDO: 111
	DECLARE @IDPadre INT = 81
	--@RolID Consultora: 1, SAC: 3, ADMCONTENIDO: 4
	DECLARE @RolID INT = 3
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	
	-- select * from Permiso  WHERE IDPadre = 81
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;
	--SELECT @PermisoID, @OrdenItem


    insert into Permiso ([PermisoID]
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
		   values(@PermisoID+1,'Reporte de Contrato',@IDPadre,@OrdenItem + 1,'ReporteContrato/Index',0,'Header','',0,0,0,0,null)
	
	   INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 0, 1)

end
GO

USE BelcorpDominicana
GO

if not exists(select 1 from Permiso where Descripcion = 'Reporte de Contrato')
begin

	-- MENU Y PERMISO
	--@IDPadre => Consultora: 1003, SAC: 81, ADMCONTENIDO: 111
	DECLARE @IDPadre INT = 81
	--@RolID Consultora: 1, SAC: 3, ADMCONTENIDO: 4
	DECLARE @RolID INT = 3
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	
	-- select * from Permiso  WHERE IDPadre = 81
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;
	--SELECT @PermisoID, @OrdenItem


    insert into Permiso ([PermisoID]
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
		   values(@PermisoID+1,'Reporte de Contrato',@IDPadre,@OrdenItem + 1,'ReporteContrato/Index',0,'Header','',0,0,0,0,null)
	
	   INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 0, 1)

end
GO

USE BelcorpCostaRica
GO

if not exists(select 1 from Permiso where Descripcion = 'Reporte de Contrato')
begin

	-- MENU Y PERMISO
	--@IDPadre => Consultora: 1003, SAC: 81, ADMCONTENIDO: 111
	DECLARE @IDPadre INT = 81
	--@RolID Consultora: 1, SAC: 3, ADMCONTENIDO: 4
	DECLARE @RolID INT = 3
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	
	-- select * from Permiso  WHERE IDPadre = 81
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;
	--SELECT @PermisoID, @OrdenItem


    insert into Permiso ([PermisoID]
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
		   values(@PermisoID+1,'Reporte de Contrato',@IDPadre,@OrdenItem + 1,'ReporteContrato/Index',0,'Header','',0,0,0,0,null)
	
	   INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 0, 1)

end
GO

USE BelcorpChile
GO

if not exists(select 1 from Permiso where Descripcion = 'Reporte de Contrato')
begin

	-- MENU Y PERMISO
	--@IDPadre => Consultora: 1003, SAC: 81, ADMCONTENIDO: 111
	DECLARE @IDPadre INT = 81
	--@RolID Consultora: 1, SAC: 3, ADMCONTENIDO: 4
	DECLARE @RolID INT = 3
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	
	-- select * from Permiso  WHERE IDPadre = 81
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;
	--SELECT @PermisoID, @OrdenItem


    insert into Permiso ([PermisoID]
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
		   values(@PermisoID+1,'Reporte de Contrato',@IDPadre,@OrdenItem + 1,'ReporteContrato/Index',0,'Header','',0,0,0,0,null)
	
	   INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 0, 1)

end
GO

USE BelcorpBolivia
GO

if not exists(select 1 from Permiso where Descripcion = 'Reporte de Contrato')
begin

	-- MENU Y PERMISO
	--@IDPadre => Consultora: 1003, SAC: 81, ADMCONTENIDO: 111
	DECLARE @IDPadre INT = 81
	--@RolID Consultora: 1, SAC: 3, ADMCONTENIDO: 4
	DECLARE @RolID INT = 3
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	
	-- select * from Permiso  WHERE IDPadre = 81
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;
	--SELECT @PermisoID, @OrdenItem


    insert into Permiso ([PermisoID]
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
		   values(@PermisoID+1,'Reporte de Contrato',@IDPadre,@OrdenItem + 1,'ReporteContrato/Index',0,'Header','',0,0,0,0,null)
	
	   INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 0, 1)

end
GO

