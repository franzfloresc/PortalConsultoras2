USE BelcorpPeru
GO

if exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	delete from MenuMobile where Codigo = 'CaminoBrillante'
	update MenuMobile set OrdenItem = 9 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpMexico
GO

if exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	delete from MenuMobile where Codigo = 'CaminoBrillante'
	update MenuMobile set OrdenItem = 9 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpColombia
GO

if exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	delete from MenuMobile where Codigo = 'CaminoBrillante'
	update MenuMobile set OrdenItem = 9 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpSalvador
GO

if exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	delete from MenuMobile where Codigo = 'CaminoBrillante'
	update MenuMobile set OrdenItem = 9 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpPuertoRico
GO

if exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	delete from MenuMobile where Codigo = 'CaminoBrillante'
	update MenuMobile set OrdenItem = 9 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpPanama
GO

if exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	delete from MenuMobile where Codigo = 'CaminoBrillante'
	update MenuMobile set OrdenItem = 9 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpGuatemala
GO

if exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	delete from MenuMobile where Codigo = 'CaminoBrillante'
	update MenuMobile set OrdenItem = 9 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpEcuador
GO

if exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	delete from MenuMobile where Codigo = 'CaminoBrillante'
	update MenuMobile set OrdenItem = 9 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpDominicana
GO

if exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	delete from MenuMobile where Codigo = 'CaminoBrillante'
	update MenuMobile set OrdenItem = 9 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpCostaRica
GO

if exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	delete from MenuMobile where Codigo = 'CaminoBrillante'
	update MenuMobile set OrdenItem = 9 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpChile
GO

if exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	delete from MenuMobile where Codigo = 'CaminoBrillante'
	update MenuMobile set OrdenItem = 9 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1015 and MenuPadreID = 1001
end
GO

USE BelcorpBolivia
GO

if exists(select 1 from MenuMobile where Codigo = 'CaminoBrillante')
begin
	update MenuMobile set OrdenItem = 9 where MenuMobileID = 1008 and MenuPadreID = 1001
	update MenuMobile set OrdenItem = 10 where MenuMobileID = 1015 and MenuPadreID = 1001
	delete from MenuMobile where Codigo = 'CaminoBrillante'
end
GO

