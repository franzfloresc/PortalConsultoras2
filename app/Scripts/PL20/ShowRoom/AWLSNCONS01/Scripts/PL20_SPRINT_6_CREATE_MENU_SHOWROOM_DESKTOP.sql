

USE BelcorpPeru
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'
declare @PermisoID int 

 
if (select count(*) from Permiso where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	set @PermisoID = (select max(PermisoId) + 1 from Permiso)

	declare @ordenItem int
	set @ordenItem = (select max(ordenitem) + 1 from Permiso where IdPadre = 0)

	insert into Permiso(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,EsMenuEspecial,EsServicios,EsPrincipal)
		values(@PermisoID,@Descripcion,0,@ordenItem,@UrlItem,0,'Header','',0,0,0,1)

	insert into RolPermiso(RolID,PermisoID,Activo,Mostrar)values(1,@PermisoID,1,1)
end

set @PermisoID = (select max(PermisoId) from Permiso)
if (select count(*) from RolPermiso where PermisoID = 1057) = 0
begin
	
	insert into RolPermiso(RolID,PermisoID,Activo,Mostrar)values(1,@PermisoID,1,1)
end


/*end*/

USE BelcorpBolivia
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'
declare @PermisoID int 

if (select count(*) from Permiso where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	
	set @PermisoID = (select max(PermisoId) + 1 from Permiso)

	declare @ordenItem int
	set @ordenItem = (select max(ordenitem) + 1 from Permiso where IdPadre = 0)

	insert into Permiso(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,EsMenuEspecial,EsServicios,EsPrincipal)
		values(@PermisoID,@Descripcion,0,@ordenItem,@UrlItem,0,'Header','',0,0,0,1)

end

set @PermisoID = (select max(PermisoId) from Permiso)
if (select count(*) from RolPermiso where PermisoID = @PermisoID) = 0
begin
	
	insert into RolPermiso(RolID,PermisoID,Activo,Mostrar)values(1,@PermisoID,1,1)
end

GO

/*end*/


USE BelcorpChile
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'
declare @PermisoID int 

if (select count(*) from Permiso where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	
	set @PermisoID = (select max(PermisoId) + 1 from Permiso)

	declare @ordenItem int
	set @ordenItem = (select max(ordenitem) + 1 from Permiso where IdPadre = 0)

	insert into Permiso(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,EsMenuEspecial,EsServicios,EsPrincipal)
		values(@PermisoID,@Descripcion,81,@ordenItem,@UrlItem,0,'Header','',0,0,0,1)

end

set @PermisoID = (select max(PermisoId) from Permiso)
if (select count(*) from RolPermiso where PermisoID = @PermisoID) = 0
begin
	
	insert into RolPermiso(RolID,PermisoID,Activo,Mostrar)values(1,@PermisoID,1,1)
end

GO

/*end*/

USE BelcorpColombia
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'
declare @PermisoID int 

if (select count(*) from Permiso where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	
	set @PermisoID = (select max(PermisoId) + 1 from Permiso)

	declare @ordenItem int
	set @ordenItem = (select max(ordenitem) + 1 from Permiso where IdPadre = 0)

	insert into Permiso(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,EsMenuEspecial,EsServicios,EsPrincipal)
		values(@PermisoID,@Descripcion,0,@ordenItem,@UrlItem,0,'Header','',0,0,0,1)

end

set @PermisoID = (select max(PermisoId) from Permiso)
if (select count(*) from RolPermiso where PermisoID = @PermisoID) = 0
begin
	
	insert into RolPermiso(RolID,PermisoID,Activo,Mostrar)values(1,@PermisoID,1,1)
end

GO

/*end*/




USE BelcorpCostaRica
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'
declare @PermisoID int


if (select count(*) from Permiso where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	 
	set @PermisoID = (select max(PermisoId) + 1 from Permiso)

	declare @ordenItem int
	set @ordenItem = (select max(ordenitem) + 1 from Permiso where IdPadre = 0)

	insert into Permiso(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,EsMenuEspecial,EsServicios,EsPrincipal)
		values(@PermisoID,@Descripcion,0,@ordenItem,@UrlItem,0,'Header','',0,0,0,1)

end
set @PermisoID = (select max(PermisoId) from Permiso)
if (select count(*) from RolPermiso where PermisoID = @PermisoID) = 0
begin
	insert into RolPermiso(RolID,PermisoID,Activo,Mostrar)values(1,@PermisoID,1,1)
end

GO

/*end*/


USE BelcorpDominicana
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'
declare @PermisoID int 


if (select count(*) from Permiso where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	
	set @PermisoID = (select max(PermisoId) + 1 from Permiso)

	declare @ordenItem int
	set @ordenItem = (select max(ordenitem) + 1 from Permiso where IdPadre = 0)

	insert into Permiso(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,EsMenuEspecial,EsServicios,EsPrincipal)
		values(@PermisoID,@Descripcion,0,@ordenItem,@UrlItem,0,'Header','',0,0,0,1)

end
set @PermisoID = (select max(PermisoId) from Permiso)
if (select count(*) from RolPermiso where PermisoID = @PermisoID) = 0
begin
	
	insert into RolPermiso(RolID,PermisoID,Activo,Mostrar)values(1,@PermisoID,1,1)
end

GO

/*end*/


USE BelcorpEcuador
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'
declare @PermisoID int 


if (select count(*) from Permiso where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	
	set @PermisoID = (select max(PermisoId) + 1 from Permiso)

	declare @ordenItem int
	set @ordenItem = (select max(ordenitem) + 1 from Permiso where IdPadre = 0)

	insert into Permiso(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,EsMenuEspecial,EsServicios,EsPrincipal)
		values(@PermisoID,@Descripcion,0,@ordenItem,@UrlItem,0,'Header','',0,0,0,1)

end
set @PermisoID = (select max(PermisoId) from Permiso)
if (select count(*) from RolPermiso where PermisoID = @PermisoID) = 0
begin
	
	insert into RolPermiso(RolID,PermisoID,Activo,Mostrar)values(1,@PermisoID,1,1)
end

GO


/*end*/


USE BelcorpGuatemala
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'
declare @PermisoID int 

if (select count(*) from Permiso where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	
	set @PermisoID = (select max(PermisoId) + 1 from Permiso)

	declare @ordenItem int
	set @ordenItem = (select max(ordenitem) + 1 from Permiso where IdPadre = 0)

	insert into Permiso(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,EsMenuEspecial,EsServicios,EsPrincipal)
		values(@PermisoID,@Descripcion,0,@ordenItem,@UrlItem,0,'Header','',0,0,0,1)

end
set @PermisoID = (select max(PermisoId) from Permiso)
if (select count(*) from RolPermiso where PermisoID = @PermisoID) = 0
begin
	insert into RolPermiso(RolID,PermisoID,Activo,Mostrar)values(1,@PermisoID,1,1)
end


GO

/*end*/



USE BelcorpMexico
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'
declare @PermisoID int 

if (select count(*) from Permiso where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	
	set @PermisoID = (select max(PermisoId) + 1 from Permiso)

	declare @ordenItem int
	set @ordenItem = (select max(ordenitem) + 1 from Permiso where IdPadre = 0)

	insert into Permiso(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,EsMenuEspecial,EsServicios,EsPrincipal)
		values(@PermisoID,@Descripcion,0,@ordenItem,@UrlItem,0,'Header','',0,0,0,1)

end
set @PermisoID = (select max(PermisoId) from Permiso)
if (select count(*) from RolPermiso where PermisoID = @PermisoID) = 0
begin
	insert into RolPermiso(RolID,PermisoID,Activo,Mostrar)values(1,@PermisoID,1,1)
end

GO

/*end*/



USE BelcorpPanama
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'
declare @PermisoID int 

if (select count(*) from Permiso where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	
	set @PermisoID = (select max(PermisoId) + 1 from Permiso)

	declare @ordenItem int
	set @ordenItem = (select max(ordenitem) + 1 from Permiso where IdPadre = 0)

	insert into Permiso(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,EsMenuEspecial,EsServicios,EsPrincipal)
		values(@PermisoID,@Descripcion,0,@ordenItem,@UrlItem,0,'Header','',0,0,0,1)

end

set @PermisoID = (select max(PermisoId) from Permiso)
if (select count(*) from RolPermiso where PermisoID = @PermisoID) = 0
begin
	insert into RolPermiso(RolID,PermisoID,Activo,Mostrar)values(1,@PermisoID,1,1)
end

GO


/*end*/


USE BelcorpPuertoRico
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'
declare @PermisoID int 


if (select count(*) from Permiso where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	
	set @PermisoID = (select max(PermisoId) + 1 from Permiso)

	declare @ordenItem int
	set @ordenItem = (select max(ordenitem) + 1 from Permiso where IdPadre = 0)

	insert into Permiso(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,EsMenuEspecial,EsServicios,EsPrincipal)
		values(@PermisoID,@Descripcion,0,@ordenItem,@UrlItem,0,'Header','',0,0,0,1)

end
set @PermisoID = (select max(PermisoId) from Permiso)
if (select count(*) from RolPermiso where PermisoID = @PermisoID) = 0
begin
	insert into RolPermiso(RolID,PermisoID,Activo,Mostrar)values(1,@PermisoID,1,1)
end

GO

/*end*/



USE BelcorpSalvador
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'
declare @PermisoID int 

if (select count(*) from Permiso where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	
	set @PermisoID = (select max(PermisoId) + 1 from Permiso)

	declare @ordenItem int
	set @ordenItem = (select max(ordenitem) + 1 from Permiso where IdPadre = 0)

	insert into Permiso(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,EsMenuEspecial,EsServicios,EsPrincipal)
		values(@PermisoID,@Descripcion,0,@ordenItem,@UrlItem,0,'Header','',0,0,0,1)

end
set @PermisoID = (select max(PermisoId) from Permiso)
if (select count(*) from RolPermiso where PermisoID = @PermisoID) = 0
begin
	insert into RolPermiso(RolID,PermisoID,Activo,Mostrar)values(1,@PermisoID,1,1)
end


GO

/*end*/



USE BelcorpVenezuela
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'
declare @PermisoID int 

if (select count(*) from Permiso where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	
	set @PermisoID = (select max(PermisoId) + 1 from Permiso)

	declare @ordenItem int
	set @ordenItem = (select max(ordenitem) + 1 from Permiso where IdPadre = 0)

	insert into Permiso(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,EsMenuEspecial,EsServicios,EsPrincipal)
		values(@PermisoID,@Descripcion,0,@ordenItem,@UrlItem,0,'Header','',0,0,0,1)

end

set @PermisoID = (select max(PermisoId) from Permiso)
if (select count(*) from RolPermiso where PermisoID = @PermisoID) = 0
begin
	insert into RolPermiso(RolID,PermisoID,Activo,Mostrar)values(1,@PermisoID,1,1)
end

GO



