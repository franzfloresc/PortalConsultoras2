USE [BelcorpMexico];
GO

if not exists(select 1 from Permiso where PermisoID = 1093)
begin
    insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
    values(1093,'Configuración de Zonas',434,8,'Unete/ConfiguracionValidacionZona',0,'Header','',0,0,0,0,null)
end

if not exists(select  1 from RolPermiso where [PermisoID] =1093 and RolID =3)
begin
   insert RolPermiso
    values(3,1093,1,1)
end

GO


