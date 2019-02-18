USE BelcorpPeru
GO
Delete from menuApp where versionMenu = 8

insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3 
from MenuApp where versionMenu = 7
GO
update MenuApp set Descripcion = 'IR AL HOME', Orden = 0 where versionMenu = 8 and codigo = 'MEN_LAT_INICIO'
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_PERFIL', 'MEN_LAT_GRUPO1', 'MI PERFIL', 1, 4, 1, 8)
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_MISDATOS', 'MEN_LAT_PERFIL', 'Mis Datos', 1, 4, 1, 8)
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_DIRENTREGA', 'MEN_LAT_PERFIL', 'Dirección de Entrega', 2, 4, 0, 8)
GO

USE BelcorpMexico
GO
Delete from menuApp where versionMenu = 8

insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3 
from MenuApp where versionMenu = 7
GO
update MenuApp set Descripcion = 'IR AL HOME', Orden = 0  where versionMenu = 8 and codigo = 'MEN_LAT_INICIO'
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_PERFIL', 'MEN_LAT_GRUPO1', 'MI PERFIL', 1, 4, 1, 8)
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_MISDATOS', 'MEN_LAT_PERFIL', 'Mis Datos', 1, 4, 1, 8)
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_DIRENTREGA', 'MEN_LAT_PERFIL', 'Dirección de Entrega', 2, 4, 0, 8)
GO

USE BelcorpColombia
GO
Delete from menuApp where versionMenu = 8

insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3 
from MenuApp where versionMenu = 7
GO
update MenuApp set Descripcion = 'IR AL HOME', Orden = 0  where versionMenu = 8 and codigo = 'MEN_LAT_INICIO'
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_PERFIL', 'MEN_LAT_GRUPO1', 'MI PERFIL', 1, 4, 1, 8)
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_MISDATOS', 'MEN_LAT_PERFIL', 'Mis Datos', 1, 4, 1, 8)
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_DIRENTREGA', 'MEN_LAT_PERFIL', 'Dirección de Entrega', 2, 4, 0, 8)
GO

USE BelcorpSalvador
GO
Delete from menuApp where versionMenu = 8

insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3 
from MenuApp where versionMenu = 7
GO
update MenuApp set Descripcion = 'IR AL HOME', Orden = 0  where versionMenu = 8 and codigo = 'MEN_LAT_INICIO'
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_PERFIL', 'MEN_LAT_GRUPO1', 'MI PERFIL', 1, 4, 1, 8)
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_MISDATOS', 'MEN_LAT_PERFIL', 'Mis Datos', 1, 4, 1, 8)
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_DIRENTREGA', 'MEN_LAT_PERFIL', 'Dirección de Entrega', 2, 4, 0, 8)
GO

USE BelcorpPuertoRico
GO
Delete from menuApp where versionMenu = 8

insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3 
from MenuApp where versionMenu = 7
GO
update MenuApp set Descripcion = 'IR AL HOME', Orden = 0  where versionMenu = 8 and codigo = 'MEN_LAT_INICIO'
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_PERFIL', 'MEN_LAT_GRUPO1', 'MI PERFIL', 1, 4, 1, 8)
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_MISDATOS', 'MEN_LAT_PERFIL', 'Mis Datos', 1, 4, 1, 8)
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_DIRENTREGA', 'MEN_LAT_PERFIL', 'Dirección de Entrega', 2, 4, 0, 8)
GO

USE BelcorpPanama
GO
Delete from menuApp where versionMenu = 8

insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3 
from MenuApp where versionMenu = 7
GO
update MenuApp set Descripcion = 'IR AL HOME', Orden = 0  where versionMenu = 8 and codigo = 'MEN_LAT_INICIO'
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_PERFIL', 'MEN_LAT_GRUPO1', 'MI PERFIL', 1, 4, 1, 8)
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_MISDATOS', 'MEN_LAT_PERFIL', 'Mis Datos', 1, 4, 1, 8)
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_DIRENTREGA', 'MEN_LAT_PERFIL', 'Dirección de Entrega', 2, 4, 0, 8)
GO

USE BelcorpGuatemala
GO
Delete from menuApp where versionMenu = 8

insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3 
from MenuApp where versionMenu = 7
GO
update MenuApp set Descripcion = 'IR AL HOME', Orden = 0  where versionMenu = 8 and codigo = 'MEN_LAT_INICIO'
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_PERFIL', 'MEN_LAT_GRUPO1', 'MI PERFIL', 1, 4, 1, 8)
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_MISDATOS', 'MEN_LAT_PERFIL', 'Mis Datos', 1, 4, 1, 8)
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_DIRENTREGA', 'MEN_LAT_PERFIL', 'Dirección de Entrega', 2, 4, 0, 8)
GO

USE BelcorpEcuador
GO
Delete from menuApp where versionMenu = 8

insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3 
from MenuApp where versionMenu = 7
GO
update MenuApp set Descripcion = 'IR AL HOME', Orden = 0  where versionMenu = 8 and codigo = 'MEN_LAT_INICIO'
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_PERFIL', 'MEN_LAT_GRUPO1', 'MI PERFIL', 1, 4, 1, 8)
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_MISDATOS', 'MEN_LAT_PERFIL', 'Mis Datos', 1, 4, 1, 8)
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_DIRENTREGA', 'MEN_LAT_PERFIL', 'Dirección de Entrega', 2, 4, 0, 8)
GO

USE BelcorpDominicana
GO
Delete from menuApp where versionMenu = 8

insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3 
from MenuApp where versionMenu = 7
GO
update MenuApp set Descripcion = 'IR AL HOME', Orden = 0  where versionMenu = 8 and codigo = 'MEN_LAT_INICIO'
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_PERFIL', 'MEN_LAT_GRUPO1', 'MI PERFIL', 1, 4, 1, 8)
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_MISDATOS', 'MEN_LAT_PERFIL', 'Mis Datos', 1, 4, 1, 8)
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_DIRENTREGA', 'MEN_LAT_PERFIL', 'Dirección de Entrega', 2, 4, 0, 8)
GO

USE BelcorpCostaRica
GO
Delete from menuApp where versionMenu = 8

insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3 
from MenuApp where versionMenu = 7
GO
update MenuApp set Descripcion = 'IR AL HOME', Orden = 0  where versionMenu = 8 and codigo = 'MEN_LAT_INICIO'
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_PERFIL', 'MEN_LAT_GRUPO1', 'MI PERFIL', 1, 4, 1, 8)
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_MISDATOS', 'MEN_LAT_PERFIL', 'Mis Datos', 1, 4, 1, 8)
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_DIRENTREGA', 'MEN_LAT_PERFIL', 'Dirección de Entrega', 2, 4, 0, 8)
GO

USE BelcorpChile
GO
Delete from menuApp where versionMenu = 8

insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3 
from MenuApp where versionMenu = 7
GO
update MenuApp set Descripcion = 'IR AL HOME', Orden = 0  where versionMenu = 8 and codigo = 'MEN_LAT_INICIO'
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_PERFIL', 'MEN_LAT_GRUPO1', 'MI PERFIL', 1, 4, 1, 8)
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_MISDATOS', 'MEN_LAT_PERFIL', 'Mis Datos', 1, 4, 1, 8)
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_DIRENTREGA', 'MEN_LAT_PERFIL', 'Dirección de Entrega', 2, 4, 1, 8)
GO

USE BelcorpBolivia
GO
Delete from menuApp where versionMenu = 8

insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3 
from MenuApp where versionMenu = 7
GO
update MenuApp set Descripcion = 'IR AL HOME', Orden = 0  where versionMenu = 8 and codigo = 'MEN_LAT_INICIO'
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_PERFIL', 'MEN_LAT_GRUPO1', 'MI PERFIL', 1, 4, 1, 8)
GO
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_MISDATOS', 'MEN_LAT_PERFIL', 'Mis Datos', 1, 4, 1, 8)
insert into menuApp (codigo, codigoMenuPadre, descripcion, orden, posicion, visible, versionMenu) 
values ('MEN_LAT_DIRENTREGA', 'MEN_LAT_PERFIL', 'Dirección de Entrega', 2, 4, 0, 8)
GO

