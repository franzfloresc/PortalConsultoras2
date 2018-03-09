﻿--use BelcorpChile_bpt
--go

--use BelcorpPeru_bpt
--go

--use BelcorpCostaRica_bpt
--go

print db_name()

if exists(	select 1
			from ConfiguracionPais cp
			where cp.Codigo = 'INICIORD'	)
begin
	print 'Actualizando ConfiguracionPais : INICIORD'
	update cp
	set 
	cp.DesktopTituloBanner = NULL
	,cp.DesktopSubTituloBanner = NULL
	,cp.MobileTituloBanner = NULL
	,cp.MobileSubTituloBanner = NULL
	,DesktopFondoBanner = NULL
	,MobileFondoBanner = NULL
	,DesktopLogoBanner = NULL
	,MobileLogoBanner = NULL
	from ConfiguracionPais cp
	where cp.Codigo = 'INICIORD'
end

if exists(	select 1
			from ConfiguracionPais cp
			where cp.Codigo = 'SR'	)
begin
	print 'Actualizando ConfiguracionPais : SR'
	update cp
	set 
	cp.DesktopTituloBanner = 'APROVECHA ESTOS ESPECIALES SOLO PARA TI'
	,cp.DesktopSubTituloBanner = NULL
	,cp.MobileTituloBanner = 'APROVECHA ESTOS ESPECIALES SOLO PARA TI'
	,cp.MobileSubTituloBanner = NULL
	from ConfiguracionPais cp
	where cp.Codigo = 'SR'
end

if exists(	select 1
			from ConfiguracionPais cp
			where cp.Codigo = 'RD'	)
begin
	print 'Actualizando ConfiguracionPais : RD'
	update cp
	set 
	cp.DesktopTituloBanner = NULL
	,cp.DesktopSubTituloBanner = NULL
	,cp.MobileTituloBanner = NULL
	,cp.MobileSubTituloBanner = NULL
	,DesktopFondoBanner = NULL
	,MobileFondoBanner = NULL
	,DesktopLogoBanner = NULL
	,MobileLogoBanner = NULL
	from ConfiguracionPais cp
	where cp.Codigo = 'RD'
end

if exists(	select 1
			from ConfiguracionPais cp
			where cp.Codigo = 'GND'	)
begin
	print 'Actualizando ConfiguracionPais : GND'
	update cp
	set 
	cp.DesktopTituloBanner = 'Disfruta de tu guía de negocio online en'
	,cp.DesktopSubTituloBanner = NULL
	,cp.MobileTituloBanner = 'Disfruta de tu guía de negocio online en'
	,cp.MobileSubTituloBanner = NULL
	from ConfiguracionPais cp
	where cp.Codigo = 'GND'
end