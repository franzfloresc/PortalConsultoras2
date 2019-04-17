DECLARE @Descripcion varchar(128)
DECLARE @DescripcionRol varchar(128)

set @Descripcion='Administración de popups'
set @DescripcionRol='Adm Contenido'

/*REGISTRO EN TABLA PERMISO*/
if ((select count(1) from permiso  where permisoid in (select permisoid from rolpermiso where rolid=(select rolid from rol where descripcion=@DescripcionRol)) and idpadre=111 and descripcion=@Descripcion) > 0) begin

select *  FROM permiso WHERE Descripcion=@Descripcion
select *  FROM rolpermiso WHERE PERMISOID=(SELECT top 1PERMISOID FROM permiso WHERE Descripcion=@Descripcion)

print('Se insertaeliminaron  los datos')
end
else
begin
print('No se realizaron las eliminaciones pues ya no existen los registro ')
end
