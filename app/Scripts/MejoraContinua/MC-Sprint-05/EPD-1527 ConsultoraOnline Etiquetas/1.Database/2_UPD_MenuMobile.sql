USE BelcorpBolivia
GO
if exists(
	select 1
	from MenuMobile
	where MenuPadreID = 1001 and OrdenItem = 7 and MenuMobileID <> 1035
)
begin
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where MenuPadreID = 1001 and OrdenItem >= 7;
end;

update MenuMobile
set Descripcion = 'App de Catálogos'
where MenuMobileID = 1031;

update MenuMobile
set UrlItem = 'Mobile/Catalogo/EnterateMas'
where MenuMobileID = 1032;

update MenuMobile
set
	UrlItem = 'Mobile/ConsultoraOnline/Informacion||Mobile/Catalogo/EnterateMas',
	Descripcion = 'App de Catálogos',
	OrdenItem = 7
where MenuMobileID = 1035;
GO
/*end*/

USE BelcorpChile
GO
if exists(
	select 1
	from MenuMobile
	where MenuPadreID = 1001 and OrdenItem = 7 and MenuMobileID <> 1035
)
begin
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where MenuPadreID = 1001 and OrdenItem >= 7;
end;

update MenuMobile
set Descripcion = 'App de Catálogos'
where MenuMobileID = 1031;

update MenuMobile
set UrlItem = 'Mobile/Catalogo/EnterateMas'
where MenuMobileID = 1032;

update MenuMobile
set
	UrlItem = 'Mobile/ConsultoraOnline/Informacion||Mobile/Catalogo/EnterateMas',
	Descripcion = 'App de Catálogos',
	OrdenItem = 7
where MenuMobileID = 1035;
GO
/*end*/

USE BelcorpCostaRica
GO
if exists(
	select 1
	from MenuMobile
	where MenuPadreID = 1001 and OrdenItem = 7 and MenuMobileID <> 1035
)
begin
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where MenuPadreID = 1001 and OrdenItem >= 7;
end;

update MenuMobile
set Descripcion = 'App de Catálogos'
where MenuMobileID = 1031;

update MenuMobile
set UrlItem = 'Mobile/Catalogo/EnterateMas'
where MenuMobileID = 1032;

update MenuMobile
set
	UrlItem = 'Mobile/ConsultoraOnline/Informacion||Mobile/Catalogo/EnterateMas',
	Descripcion = 'App de Catálogos',
	OrdenItem = 7
where MenuMobileID = 1035;
GO
/*end*/

USE BelcorpDominicana
GO
if exists(
	select 1
	from MenuMobile
	where MenuPadreID = 1001 and OrdenItem = 7 and MenuMobileID <> 1035
)
begin
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where MenuPadreID = 1001 and OrdenItem >= 7;
end;

update MenuMobile
set Descripcion = 'App de Catálogos'
where MenuMobileID = 1031;

update MenuMobile
set UrlItem = 'Mobile/Catalogo/EnterateMas'
where MenuMobileID = 1032;

update MenuMobile
set
	UrlItem = 'Mobile/ConsultoraOnline/Informacion||Mobile/Catalogo/EnterateMas',
	Descripcion = 'App de Catálogos',
	OrdenItem = 7
where MenuMobileID = 1035;
GO
/*end*/

USE BelcorpEcuador
GO
if exists(
	select 1
	from MenuMobile
	where MenuPadreID = 1001 and OrdenItem = 7 and MenuMobileID <> 1035
)
begin
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where MenuPadreID = 1001 and OrdenItem >= 7;
end;

update MenuMobile
set Descripcion = 'App de Catálogos'
where MenuMobileID = 1031;

update MenuMobile
set UrlItem = 'Mobile/Catalogo/EnterateMas'
where MenuMobileID = 1032;

update MenuMobile
set
	UrlItem = 'Mobile/ConsultoraOnline/Informacion||Mobile/Catalogo/EnterateMas',
	Descripcion = 'App de Catálogos',
	OrdenItem = 7
where MenuMobileID = 1035;
GO
/*end*/

USE BelcorpGuatemala
GO
if exists(
	select 1
	from MenuMobile
	where MenuPadreID = 1001 and OrdenItem = 7 and MenuMobileID <> 1035
)
begin
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where MenuPadreID = 1001 and OrdenItem >= 7;
end;

update MenuMobile
set Descripcion = 'App de Catálogos'
where MenuMobileID = 1031;

update MenuMobile
set UrlItem = 'Mobile/Catalogo/EnterateMas'
where MenuMobileID = 1032;

update MenuMobile
set
	UrlItem = 'Mobile/ConsultoraOnline/Informacion||Mobile/Catalogo/EnterateMas',
	Descripcion = 'App de Catálogos',
	OrdenItem = 7
where MenuMobileID = 1035;
GO
/*end*/

USE BelcorpPanama
GO
if exists(
	select 1
	from MenuMobile
	where MenuPadreID = 1001 and OrdenItem = 7 and MenuMobileID <> 1035
)
begin
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where MenuPadreID = 1001 and OrdenItem >= 7;
end;

update MenuMobile
set Descripcion = 'App de Catálogos'
where MenuMobileID = 1031;

update MenuMobile
set UrlItem = 'Mobile/Catalogo/EnterateMas'
where MenuMobileID = 1032;

update MenuMobile
set
	UrlItem = 'Mobile/ConsultoraOnline/Informacion||Mobile/Catalogo/EnterateMas',
	Descripcion = 'App de Catálogos',
	OrdenItem = 7
where MenuMobileID = 1035;
GO
/*end*/

USE BelcorpPuertoRico
GO
if exists(
	select 1
	from MenuMobile
	where MenuPadreID = 1001 and OrdenItem = 7 and MenuMobileID <> 1035
)
begin
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where MenuPadreID = 1001 and OrdenItem >= 7;
end;

update MenuMobile
set Descripcion = 'App de Catálogos'
where MenuMobileID = 1031;

update MenuMobile
set UrlItem = 'Mobile/Catalogo/EnterateMas'
where MenuMobileID = 1032;

update MenuMobile
set
	UrlItem = 'Mobile/ConsultoraOnline/Informacion||Mobile/Catalogo/EnterateMas',
	Descripcion = 'App de Catálogos',
	OrdenItem = 7
where MenuMobileID = 1035;
GO
/*end*/

USE BelcorpSalvador
GO
if exists(
	select 1
	from MenuMobile
	where MenuPadreID = 1001 and OrdenItem = 7 and MenuMobileID <> 1035
)
begin
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where MenuPadreID = 1001 and OrdenItem >= 7;
end;

update MenuMobile
set Descripcion = 'App de Catálogos'
where MenuMobileID = 1031;

update MenuMobile
set UrlItem = 'Mobile/Catalogo/EnterateMas'
where MenuMobileID = 1032;

update MenuMobile
set
	UrlItem = 'Mobile/ConsultoraOnline/Informacion||Mobile/Catalogo/EnterateMas',
	Descripcion = 'App de Catálogos',
	OrdenItem = 7
where MenuMobileID = 1035;
GO
/*end*/

USE BelcorpVenezuela
GO
if exists(
	select 1
	from MenuMobile
	where MenuPadreID = 1001 and OrdenItem = 7 and MenuMobileID <> 1035
)
begin
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where MenuPadreID = 1001 and OrdenItem >= 7;
end;

update MenuMobile
set Descripcion = 'App de Catálogos'
where MenuMobileID = 1031;

update MenuMobile
set UrlItem = 'Mobile/Catalogo/EnterateMas'
where MenuMobileID = 1032;

update MenuMobile
set
	UrlItem = 'Mobile/ConsultoraOnline/Informacion||Mobile/Catalogo/EnterateMas',
	Descripcion = 'App de Catálogos',
	OrdenItem = 7
where MenuMobileID = 1035;
GO
/*end*/

USE BelcorpColombia
GO
if exists(
	select 1
	from MenuMobile
	where MenuPadreID = 1001 and OrdenItem = 7 and MenuMobileID <> 1035
)
begin
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where MenuPadreID = 1001 and OrdenItem >= 7;
end;

update MenuMobile
set Descripcion = 'App de Catálogos'
where MenuMobileID = 1031;

update MenuMobile
set UrlItem = 'Mobile/Catalogo/EnterateMas'
where MenuMobileID = 1032;

update MenuMobile
set
	UrlItem = 'Mobile/ConsultoraOnline/Informacion||Mobile/Catalogo/EnterateMas',
	Descripcion = 'App de Catálogos',
	OrdenItem = 7
where MenuMobileID = 1035;
GO
/*end*/

USE BelcorpMexico
GO
if exists(
	select 1
	from MenuMobile
	where MenuPadreID = 1001 and OrdenItem = 7 and MenuMobileID <> 1035
)
begin
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where MenuPadreID = 1001 and OrdenItem >= 7;
end;

update MenuMobile
set Descripcion = 'App de Catálogos'
where MenuMobileID = 1031;

update MenuMobile
set UrlItem = 'Mobile/Catalogo/EnterateMas'
where MenuMobileID = 1032;

update MenuMobile
set
	UrlItem = 'Mobile/ConsultoraOnline/Informacion||Mobile/Catalogo/EnterateMas',
	Descripcion = 'App de Catálogos',
	OrdenItem = 7
where MenuMobileID = 1035;
GO
/*end*/

USE BelcorpPeru
GO
if exists(
	select 1
	from MenuMobile
	where MenuPadreID = 1001 and OrdenItem = 7 and MenuMobileID <> 1035
)
begin
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where MenuPadreID = 1001 and OrdenItem >= 7;
end;

update MenuMobile
set Descripcion = 'App de Catálogos'
where MenuMobileID = 1031;

update MenuMobile
set UrlItem = 'Mobile/Catalogo/EnterateMas'
where MenuMobileID = 1032;

update MenuMobile
set
	UrlItem = 'Mobile/ConsultoraOnline/Informacion||Mobile/Catalogo/EnterateMas',
	Descripcion = 'App de Catálogos',
	OrdenItem = 7
where MenuMobileID = 1035;
GO