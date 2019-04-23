USE [BelcorpBolivia];
GO

DECLARE @PermisoId INT
DECLARE @OrdenItem INT
DECLARE @idPadre INT
DECLARE @RolId INT
DECLARE @Descripcion varchar(128)
DECLARE @DescripcionRol varchar(128)

set @Descripcion='Administración de popups'
set @DescripcionRol='Adm Contenido'

/*REGISTRO EN TABLA PERMISO*/
if ((select count(1) from permiso  where permisoid in (select permisoid from rolpermiso where rolid=(select rolid from rol where descripcion=@DescripcionRol)) and idpadre=111 and descripcion=@Descripcion) <= 0) begin

SELECT @PermisoId=max(Permisoid) + 1 from permiso 
SELECT @OrdenItem=max(OrdenItem) + 1 from permiso where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=111
SELECT @idPadre= Permisoid FROM permiso  where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=110
SELECT @RolId=RolID from rol where rolid=4

INSERT INTO permiso 
(
 PermisoId
,Descripcion
,idPadre
,OrdenItem
,UrlItem
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo)
SELECT 
@PermisoId
,'Administración de popups'
,@idPadre
,@OrdenItem
,'AdministracionPopups/Index'
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo
FROM permiso
WHERE permisoID=100

/*REGISTRO EN TABLA ROLPERMISO*/


INSERT INTO rolpermiso
(
 ROLID
,PERMISOID
,ACTIVO
,MOSTRAR
)
SELECT top 1
@RolId
,@PermisoId
,ACTIVO
,MOSTRAR
from rolpermiso
where rolid=@RolId
	
print('Se insertaron los datos')
end
else
begin
print('No se realizaron los registro pues ya se encuentran ')
end

GO
USE [BelcorpChile];
GO

DECLARE @PermisoId INT
DECLARE @OrdenItem INT
DECLARE @idPadre INT
DECLARE @RolId INT
DECLARE @Descripcion varchar(128)
DECLARE @DescripcionRol varchar(128)

set @Descripcion='Administración de popups'
set @DescripcionRol='Adm Contenido'

/*REGISTRO EN TABLA PERMISO*/
if ((select count(1) from permiso  where permisoid in (select permisoid from rolpermiso where rolid=(select rolid from rol where descripcion=@DescripcionRol)) and idpadre=111 and descripcion=@Descripcion) <= 0) begin

SELECT @PermisoId=max(Permisoid) + 1 from permiso 
SELECT @OrdenItem=max(OrdenItem) + 1 from permiso where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=111
SELECT @idPadre= Permisoid FROM permiso  where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=110
SELECT @RolId=RolID from rol where rolid=4

INSERT INTO permiso 
(
 PermisoId
,Descripcion
,idPadre
,OrdenItem
,UrlItem
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo)
SELECT 
@PermisoId
,'Administración de popups'
,@idPadre
,@OrdenItem
,'AdministracionPopups/Index'
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo
FROM permiso
WHERE permisoID=100

/*REGISTRO EN TABLA ROLPERMISO*/


INSERT INTO rolpermiso
(
 ROLID
,PERMISOID
,ACTIVO
,MOSTRAR
)
SELECT top 1
@RolId
,@PermisoId
,ACTIVO
,MOSTRAR
from rolpermiso
where rolid=@RolId
	
print('Se insertaron los datos')
end
else
begin
print('No se realizaron los registro pues ya se encuentran ')
end

GO
USE [BelcorpColombia];
GO

DECLARE @PermisoId INT
DECLARE @OrdenItem INT
DECLARE @idPadre INT
DECLARE @RolId INT
DECLARE @Descripcion varchar(128)
DECLARE @DescripcionRol varchar(128)

set @Descripcion='Administración de popups'
set @DescripcionRol='Adm Contenido'

/*REGISTRO EN TABLA PERMISO*/
if ((select count(1) from permiso  where permisoid in (select permisoid from rolpermiso where rolid=(select rolid from rol where descripcion=@DescripcionRol)) and idpadre=111 and descripcion=@Descripcion) <= 0) begin

SELECT @PermisoId=max(Permisoid) + 1 from permiso 
SELECT @OrdenItem=max(OrdenItem) + 1 from permiso where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=111
SELECT @idPadre= Permisoid FROM permiso  where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=110
SELECT @RolId=RolID from rol where rolid=4

INSERT INTO permiso 
(
 PermisoId
,Descripcion
,idPadre
,OrdenItem
,UrlItem
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo)
SELECT 
@PermisoId
,'Administración de popups'
,@idPadre
,@OrdenItem
,'AdministracionPopups/Index'
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo
FROM permiso
WHERE permisoID=100

/*REGISTRO EN TABLA ROLPERMISO*/


INSERT INTO rolpermiso
(
 ROLID
,PERMISOID
,ACTIVO
,MOSTRAR
)
SELECT top 1
@RolId
,@PermisoId
,ACTIVO
,MOSTRAR
from rolpermiso
where rolid=@RolId
	
print('Se insertaron los datos')
end
else
begin
print('No se realizaron los registro pues ya se encuentran ')
end

GO
USE [BelcorpCostaRica];
GO

DECLARE @PermisoId INT
DECLARE @OrdenItem INT
DECLARE @idPadre INT
DECLARE @RolId INT
DECLARE @Descripcion varchar(128)
DECLARE @DescripcionRol varchar(128)

set @Descripcion='Administración de popups'
set @DescripcionRol='Adm Contenido'

/*REGISTRO EN TABLA PERMISO*/
if ((select count(1) from permiso  where permisoid in (select permisoid from rolpermiso where rolid=(select rolid from rol where descripcion=@DescripcionRol)) and idpadre=111 and descripcion=@Descripcion) <= 0) begin

SELECT @PermisoId=max(Permisoid) + 1 from permiso 
SELECT @OrdenItem=max(OrdenItem) + 1 from permiso where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=111
SELECT @idPadre= Permisoid FROM permiso  where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=110
SELECT @RolId=RolID from rol where rolid=4

INSERT INTO permiso 
(
 PermisoId
,Descripcion
,idPadre
,OrdenItem
,UrlItem
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo)
SELECT 
@PermisoId
,'Administración de popups'
,@idPadre
,@OrdenItem
,'AdministracionPopups/Index'
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo
FROM permiso
WHERE permisoID=100

/*REGISTRO EN TABLA ROLPERMISO*/


INSERT INTO rolpermiso
(
 ROLID
,PERMISOID
,ACTIVO
,MOSTRAR
)
SELECT top 1
@RolId
,@PermisoId
,ACTIVO
,MOSTRAR
from rolpermiso
where rolid=@RolId
	
print('Se insertaron los datos')
end
else
begin
print('No se realizaron los registro pues ya se encuentran ')
end

GO
USE [BelcorpDominicana];
GO

DECLARE @PermisoId INT
DECLARE @OrdenItem INT
DECLARE @idPadre INT
DECLARE @RolId INT
DECLARE @Descripcion varchar(128)
DECLARE @DescripcionRol varchar(128)

set @Descripcion='Administración de popups'
set @DescripcionRol='Adm Contenido'

/*REGISTRO EN TABLA PERMISO*/
if ((select count(1) from permiso  where permisoid in (select permisoid from rolpermiso where rolid=(select rolid from rol where descripcion=@DescripcionRol)) and idpadre=111 and descripcion=@Descripcion) <= 0) begin

SELECT @PermisoId=max(Permisoid) + 1 from permiso 
SELECT @OrdenItem=max(OrdenItem) + 1 from permiso where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=111
SELECT @idPadre= Permisoid FROM permiso  where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=110
SELECT @RolId=RolID from rol where rolid=4

INSERT INTO permiso 
(
 PermisoId
,Descripcion
,idPadre
,OrdenItem
,UrlItem
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo)
SELECT 
@PermisoId
,'Administración de popups'
,@idPadre
,@OrdenItem
,'AdministracionPopups/Index'
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo
FROM permiso
WHERE permisoID=100

/*REGISTRO EN TABLA ROLPERMISO*/


INSERT INTO rolpermiso
(
 ROLID
,PERMISOID
,ACTIVO
,MOSTRAR
)
SELECT top 1
@RolId
,@PermisoId
,ACTIVO
,MOSTRAR
from rolpermiso
where rolid=@RolId
	
print('Se insertaron los datos')
end
else
begin
print('No se realizaron los registro pues ya se encuentran ')
end

GO
USE [BelcorpEcuador];
GO

DECLARE @PermisoId INT
DECLARE @OrdenItem INT
DECLARE @idPadre INT
DECLARE @RolId INT
DECLARE @Descripcion varchar(128)
DECLARE @DescripcionRol varchar(128)

set @Descripcion='Administración de popups'
set @DescripcionRol='Adm Contenido'

/*REGISTRO EN TABLA PERMISO*/
if ((select count(1) from permiso  where permisoid in (select permisoid from rolpermiso where rolid=(select rolid from rol where descripcion=@DescripcionRol)) and idpadre=111 and descripcion=@Descripcion) <= 0) begin

SELECT @PermisoId=max(Permisoid) + 1 from permiso 
SELECT @OrdenItem=max(OrdenItem) + 1 from permiso where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=111
SELECT @idPadre= Permisoid FROM permiso  where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=110
SELECT @RolId=RolID from rol where rolid=4

INSERT INTO permiso 
(
 PermisoId
,Descripcion
,idPadre
,OrdenItem
,UrlItem
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo)
SELECT 
@PermisoId
,'Administración de popups'
,@idPadre
,@OrdenItem
,'AdministracionPopups/Index'
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo
FROM permiso
WHERE permisoID=100

/*REGISTRO EN TABLA ROLPERMISO*/


INSERT INTO rolpermiso
(
 ROLID
,PERMISOID
,ACTIVO
,MOSTRAR
)
SELECT top 1
@RolId
,@PermisoId
,ACTIVO
,MOSTRAR
from rolpermiso
where rolid=@RolId
	
print('Se insertaron los datos')
end
else
begin
print('No se realizaron los registro pues ya se encuentran ')
end

GO
USE [BelcorpGuatemala];
GO

DECLARE @PermisoId INT
DECLARE @OrdenItem INT
DECLARE @idPadre INT
DECLARE @RolId INT
DECLARE @Descripcion varchar(128)
DECLARE @DescripcionRol varchar(128)

set @Descripcion='Administración de popups'
set @DescripcionRol='Adm Contenido'

/*REGISTRO EN TABLA PERMISO*/
if ((select count(1) from permiso  where permisoid in (select permisoid from rolpermiso where rolid=(select rolid from rol where descripcion=@DescripcionRol)) and idpadre=111 and descripcion=@Descripcion) <= 0) begin

SELECT @PermisoId=max(Permisoid) + 1 from permiso 
SELECT @OrdenItem=max(OrdenItem) + 1 from permiso where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=111
SELECT @idPadre= Permisoid FROM permiso  where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=110
SELECT @RolId=RolID from rol where rolid=4

INSERT INTO permiso 
(
 PermisoId
,Descripcion
,idPadre
,OrdenItem
,UrlItem
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo)
SELECT 
@PermisoId
,'Administración de popups'
,@idPadre
,@OrdenItem
,'AdministracionPopups/Index'
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo
FROM permiso
WHERE permisoID=100

/*REGISTRO EN TABLA ROLPERMISO*/


INSERT INTO rolpermiso
(
 ROLID
,PERMISOID
,ACTIVO
,MOSTRAR
)
SELECT top 1
@RolId
,@PermisoId
,ACTIVO
,MOSTRAR
from rolpermiso
where rolid=@RolId
	
print('Se insertaron los datos')
end
else
begin
print('No se realizaron los registro pues ya se encuentran ')
end

GO
USE [BelcorpMexico];
GO

DECLARE @PermisoId INT
DECLARE @OrdenItem INT
DECLARE @idPadre INT
DECLARE @RolId INT
DECLARE @Descripcion varchar(128)
DECLARE @DescripcionRol varchar(128)

set @Descripcion='Administración de popups'
set @DescripcionRol='Adm Contenido'

/*REGISTRO EN TABLA PERMISO*/
if ((select count(1) from permiso  where permisoid in (select permisoid from rolpermiso where rolid=(select rolid from rol where descripcion=@DescripcionRol)) and idpadre=111 and descripcion=@Descripcion) <= 0) begin

SELECT @PermisoId=max(Permisoid) + 1 from permiso 
SELECT @OrdenItem=max(OrdenItem) + 1 from permiso where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=111
SELECT @idPadre= Permisoid FROM permiso  where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=110
SELECT @RolId=RolID from rol where rolid=4

INSERT INTO permiso 
(
 PermisoId
,Descripcion
,idPadre
,OrdenItem
,UrlItem
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo)
SELECT 
@PermisoId
,'Administración de popups'
,@idPadre
,@OrdenItem
,'AdministracionPopups/Index'
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo
FROM permiso
WHERE permisoID=100

/*REGISTRO EN TABLA ROLPERMISO*/


INSERT INTO rolpermiso
(
 ROLID
,PERMISOID
,ACTIVO
,MOSTRAR
)
SELECT top 1
@RolId
,@PermisoId
,ACTIVO
,MOSTRAR
from rolpermiso
where rolid=@RolId
	
print('Se insertaron los datos')
end
else
begin
print('No se realizaron los registro pues ya se encuentran ')
end

GO
USE [BelcorpPanama];
GO

DECLARE @PermisoId INT
DECLARE @OrdenItem INT
DECLARE @idPadre INT
DECLARE @RolId INT
DECLARE @Descripcion varchar(128)
DECLARE @DescripcionRol varchar(128)

set @Descripcion='Administración de popups'
set @DescripcionRol='Adm Contenido'

/*REGISTRO EN TABLA PERMISO*/
if ((select count(1) from permiso  where permisoid in (select permisoid from rolpermiso where rolid=(select rolid from rol where descripcion=@DescripcionRol)) and idpadre=111 and descripcion=@Descripcion) <= 0) begin

SELECT @PermisoId=max(Permisoid) + 1 from permiso 
SELECT @OrdenItem=max(OrdenItem) + 1 from permiso where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=111
SELECT @idPadre= Permisoid FROM permiso  where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=110
SELECT @RolId=RolID from rol where rolid=4

INSERT INTO permiso 
(
 PermisoId
,Descripcion
,idPadre
,OrdenItem
,UrlItem
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo)
SELECT 
@PermisoId
,'Administración de popups'
,@idPadre
,@OrdenItem
,'AdministracionPopups/Index'
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo
FROM permiso
WHERE permisoID=100

/*REGISTRO EN TABLA ROLPERMISO*/


INSERT INTO rolpermiso
(
 ROLID
,PERMISOID
,ACTIVO
,MOSTRAR
)
SELECT top 1
@RolId
,@PermisoId
,ACTIVO
,MOSTRAR
from rolpermiso
where rolid=@RolId
	
print('Se insertaron los datos')
end
else
begin
print('No se realizaron los registro pues ya se encuentran ')
end

GO
USE [BelcorpPeru];
GO

DECLARE @PermisoId INT
DECLARE @OrdenItem INT
DECLARE @idPadre INT
DECLARE @RolId INT
DECLARE @Descripcion varchar(128)
DECLARE @DescripcionRol varchar(128)

set @Descripcion='Administración de popups'
set @DescripcionRol='Adm Contenido'

/*REGISTRO EN TABLA PERMISO*/
if ((select count(1) from permiso  where permisoid in (select permisoid from rolpermiso where rolid=(select rolid from rol where descripcion=@DescripcionRol)) and idpadre=111 and descripcion=@Descripcion) <= 0) begin

SELECT @PermisoId=max(Permisoid) + 1 from permiso 
SELECT @OrdenItem=max(OrdenItem) + 1 from permiso where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=111
SELECT @idPadre= Permisoid FROM permiso  where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=110
SELECT @RolId=RolID from rol where rolid=4

INSERT INTO permiso 
(
 PermisoId
,Descripcion
,idPadre
,OrdenItem
,UrlItem
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo)
SELECT 
@PermisoId
,'Administración de popups'
,@idPadre
,@OrdenItem
,'AdministracionPopups/Index'
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo
FROM permiso
WHERE permisoID=100

/*REGISTRO EN TABLA ROLPERMISO*/


INSERT INTO rolpermiso
(
 ROLID
,PERMISOID
,ACTIVO
,MOSTRAR
)
SELECT top 1
@RolId
,@PermisoId
,ACTIVO
,MOSTRAR
from rolpermiso
where rolid=@RolId
	
print('Se insertaron los datos')
end
else
begin
print('No se realizaron los registro pues ya se encuentran ')
end

GO
USE [BelcorpPuertoRico];
GO

DECLARE @PermisoId INT
DECLARE @OrdenItem INT
DECLARE @idPadre INT
DECLARE @RolId INT
DECLARE @Descripcion varchar(128)
DECLARE @DescripcionRol varchar(128)

set @Descripcion='Administración de popups'
set @DescripcionRol='Adm Contenido'

/*REGISTRO EN TABLA PERMISO*/
if ((select count(1) from permiso  where permisoid in (select permisoid from rolpermiso where rolid=(select rolid from rol where descripcion=@DescripcionRol)) and idpadre=111 and descripcion=@Descripcion) <= 0) begin

SELECT @PermisoId=max(Permisoid) + 1 from permiso 
SELECT @OrdenItem=max(OrdenItem) + 1 from permiso where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=111
SELECT @idPadre= Permisoid FROM permiso  where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=110
SELECT @RolId=RolID from rol where rolid=4

INSERT INTO permiso 
(
 PermisoId
,Descripcion
,idPadre
,OrdenItem
,UrlItem
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo)
SELECT 
@PermisoId
,'Administración de popups'
,@idPadre
,@OrdenItem
,'AdministracionPopups/Index'
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo
FROM permiso
WHERE permisoID=100

/*REGISTRO EN TABLA ROLPERMISO*/


INSERT INTO rolpermiso
(
 ROLID
,PERMISOID
,ACTIVO
,MOSTRAR
)
SELECT top 1
@RolId
,@PermisoId
,ACTIVO
,MOSTRAR
from rolpermiso
where rolid=@RolId
	
print('Se insertaron los datos')
end
else
begin
print('No se realizaron los registro pues ya se encuentran ')
end

GO
USE [BelcorpSalvador];
GO

DECLARE @PermisoId INT
DECLARE @OrdenItem INT
DECLARE @idPadre INT
DECLARE @RolId INT
DECLARE @Descripcion varchar(128)
DECLARE @DescripcionRol varchar(128)

set @Descripcion='Administración de popups'
set @DescripcionRol='Adm Contenido'

/*REGISTRO EN TABLA PERMISO*/
if ((select count(1) from permiso  where permisoid in (select permisoid from rolpermiso where rolid=(select rolid from rol where descripcion=@DescripcionRol)) and idpadre=111 and descripcion=@Descripcion) <= 0) begin

SELECT @PermisoId=max(Permisoid) + 1 from permiso 
SELECT @OrdenItem=max(OrdenItem) + 1 from permiso where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=111
SELECT @idPadre= Permisoid FROM permiso  where permisoid in (select permisoid from rolpermiso where rolid=4) and idpadre=110
SELECT @RolId=RolID from rol where rolid=4

INSERT INTO permiso 
(
 PermisoId
,Descripcion
,idPadre
,OrdenItem
,UrlItem
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo)
SELECT 
@PermisoId
,'Administración de popups'
,@idPadre
,@OrdenItem
,'AdministracionPopups/Index'
,PaginaNueva
,Posicion
,UrlImagen
,EsSoloImagen
,EsMenuEspecial
,EsServicios
,EsPrincipal
,Codigo
FROM permiso
WHERE permisoID=100

/*REGISTRO EN TABLA ROLPERMISO*/


INSERT INTO rolpermiso
(
 ROLID
,PERMISOID
,ACTIVO
,MOSTRAR
)
SELECT top 1
@RolId
,@PermisoId
,ACTIVO
,MOSTRAR
from rolpermiso
where rolid=@RolId
	
print('Se insertaron los datos')
end
else
begin
print('No se realizaron los registro pues ya se encuentran ')
end

GO
