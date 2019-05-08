USE BelcorpPeru
GO

if not exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	declare @_MenuMobileID int = (select max(MenuMobileID) from MenuMobile) + 1
	insert into MenuMobile values(@_MenuMobileID, 'Camino Brillante', 1001, 9, 'CaminoBrillante/Index', '', 0, 'Menu', 'Mobile', 0, 'CaminoBrillante')
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 11 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpMexico
GO

if not exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	declare @_MenuMobileID int = (select max(MenuMobileID) from MenuMobile) + 1
	insert into MenuMobile values(@_MenuMobileID, 'Camino Brillante', 1001, 9, 'CaminoBrillante/Index', '', 0, 'Menu', 'Mobile', 0, 'CaminoBrillante')
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 11 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpColombia
GO

if not exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	declare @_MenuMobileID int = (select max(MenuMobileID) from MenuMobile) + 1
	insert into MenuMobile values(@_MenuMobileID, 'Camino Brillante', 1001, 9, 'CaminoBrillante/Index', '', 0, 'Menu', 'Mobile', 0, 'CaminoBrillante')
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 11 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpSalvador
GO

if not exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	declare @_MenuMobileID int = (select max(MenuMobileID) from MenuMobile) + 1
	insert into MenuMobile values(@_MenuMobileID, 'Camino Brillante', 1001, 9, 'CaminoBrillante/Index', '', 0, 'Menu', 'Mobile', 0, 'CaminoBrillante')
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 11 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpPuertoRico
GO

if not exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	declare @_MenuMobileID int = (select max(MenuMobileID) from MenuMobile) + 1
	insert into MenuMobile values(@_MenuMobileID, 'Camino Brillante', 1001, 9, 'CaminoBrillante/Index', '', 0, 'Menu', 'Mobile', 0, 'CaminoBrillante')
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 11 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpPanama
GO

if not exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	declare @_MenuMobileID int = (select max(MenuMobileID) from MenuMobile) + 1
	insert into MenuMobile values(@_MenuMobileID, 'Camino Brillante', 1001, 9, 'CaminoBrillante/Index', '', 0, 'Menu', 'Mobile', 0, 'CaminoBrillante')
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 11 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpGuatemala
GO

if not exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	declare @_MenuMobileID int = (select max(MenuMobileID) from MenuMobile) + 1
	insert into MenuMobile values(@_MenuMobileID, 'Camino Brillante', 1001, 9, 'CaminoBrillante/Index', '', 0, 'Menu', 'Mobile', 0, 'CaminoBrillante')
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 11 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpEcuador
GO

if not exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	declare @_MenuMobileID int = (select max(MenuMobileID) from MenuMobile) + 1
	insert into MenuMobile values(@_MenuMobileID, 'Camino Brillante', 1001, 9, 'CaminoBrillante/Index', '', 0, 'Menu', 'Mobile', 0, 'CaminoBrillante')
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 11 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpDominicana
GO

if not exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	declare @_MenuMobileID int = (select max(MenuMobileID) from MenuMobile) + 1
	insert into MenuMobile values(@_MenuMobileID, 'Camino Brillante', 1001, 9, 'CaminoBrillante/Index', '', 0, 'Menu', 'Mobile', 0, 'CaminoBrillante')
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 11 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpCostaRica
GO

if not exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	declare @_MenuMobileID int = (select max(MenuMobileID) from MenuMobile) + 1
	insert into MenuMobile values(@_MenuMobileID, 'Camino Brillante', 1001, 9, 'CaminoBrillante/Index', '', 0, 'Menu', 'Mobile', 0, 'CaminoBrillante')
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 11 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpChile
GO

if not exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	declare @_MenuMobileID int = (select max(MenuMobileID) from MenuMobile) + 1
	insert into MenuMobile values(@_MenuMobileID, 'Camino Brillante', 1001, 9, 'CaminoBrillante/Index', '', 0, 'Menu', 'Mobile', 0, 'CaminoBrillante')
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 11 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpBolivia
GO

if not exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	declare @_MenuMobileID int = (select max(MenuMobileID) from MenuMobile) + 1
	insert into MenuMobile values(@_MenuMobileID, 'Camino Brillante', 1001, 9, 'CaminoBrillante/Index', '', 0, 'Menu', 'Mobile', 0, 'CaminoBrillante')
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 11 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

