use belcorpColombia
go

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
		   values(1070,'Reporte de Contrato',81,109,'ReporteContrato/Index',0,'Header','',0,0,0,0,null)
  
    insert into RolPermiso values (3,1070,1,1)
GO