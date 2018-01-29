USE BelcorpChile_BPT
GO

declare @RevistaDigitalIntricaId int = 0
declare @RevistaDigitalIntricaCodigo varchar(30) = 'RDI'

select 
@RevistaDigitalIntricaId = cp.ConfiguracionPaisID
from ConfiguracionPais cp
where cp.Codigo = @RevistaDigitalIntricaCodigo



declare @LogoMenuOfertasCodigo varchar(100) = 'LogoMenuOfertas'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @LogoMenuOfertasCodigo)
begin
	print('Insertando  LogoMenuOfertas a RDI')
	insert into ConfiguracionPaisDatos(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	values(
	@RevistaDigitalIntricaId
	,@LogoMenuOfertasCodigo
	,0
	,'gif-ganamas.gif'
	,'gif-ganamas.gif'
	,null
	,'Gif para el menú de rd intriga'
	,1
	)
end	

declare @DBienvenidaIntrigaCodigo varchar(100) = 'DBienvenidaIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DBienvenidaIntrigaCodigo)
begin
	print('Insertando  DBienvenidaIntriga a RDI')
	insert into ConfiguracionPaisDatos(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	values(
	@RevistaDigitalIntricaId
	,@DBienvenidaIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+! '
	,'un nuevo espacio online exclusivo para ti'
	,'black'
	,'Textos de bienvenida para un consultora con RDI'
	,1
	)
end	

declare @MBienvenidaIntrigaCodigo varchar(100) = 'MBienvenidaIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MBienvenidaIntrigaCodigo)
begin
	print('Insertando  MBienvenidaIntriga a RDI')
	insert into ConfiguracionPaisDatos(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	values(
	@RevistaDigitalIntricaId
	,@MBienvenidaIntrigaCodigo
	,0
	,'#Nombre, pronto te podrás suscribir al Club Gana+'
	,'y difrutarás de packs hechos a tu medida de tus productos favoritos'
	,'black'
	,'Textos de bienvenida mobile para un consultora con RDI'
	,1
	)
end	

declare @LogoComercialCodigo varchar(100) = 'LogoComercial'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @LogoComercialCodigo)
begin
	print('Insertando  LogoComercial a RDI')
	insert into ConfiguracionPaisDatos(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	values(
	@RevistaDigitalIntricaId
	,@LogoComercialCodigo
	,0
	,'logotipo-ganamaplus-blanco.svg'
	,'logotipo-ganamaplus-blanco.svg'
	,null
	,'Logo comercial para intriga que se asignara en todo sb2'
	,1
	)
end	

declare @LogoComercialFondoCodigo varchar(100) = 'LogoComercialFondo'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @LogoComercialFondoCodigo)
begin
	print('Insertando  LogoComercialFondo a RDI')
	insert into ConfiguracionPaisDatos(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	values(
	@RevistaDigitalIntricaId
	,@LogoComercialFondoCodigo
	,0
	,'GanaMasFondo.png'
	,'GanaMasMobileFondo.png'
	,null
	,'Logo comercial para intriga que se asignara en todo sb2'
	,1
	)
end	

declare @NombreComercialCodigo varchar(100) = 'NombreComercial'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @NombreComercialCodigo)
begin
	print('Insertando  NombreComercial a RDI')
	insert into ConfiguracionPaisDatos(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	values(
	@RevistaDigitalIntricaId
	,@NombreComercialCodigo
	,0
	,'Gana +'
	,null
	,null
	,'Nombre comercial cuando que se asignara en todo sb2'
	,1
	)
end	

declare @DCatalogoIntrigaCodigo varchar(100) = 'DCatalogoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DCatalogoIntrigaCodigo)
begin
	print('Insertando  DCatalogoIntriga a RDI')
	insert into ConfiguracionPaisDatos(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	values(
	@RevistaDigitalIntricaId
	,@DCatalogoIntrigaCodigo
	,0
	,'Pronto podrás suscribirte al Club Gana+'
	,'¡Y ya no tendrás que digitar códigos!'
	,null
	,'Textos de Catálogo para un consultora con RDI'
	,1
	)
end	

declare @MCatalogoIntrigaCodigo varchar(100) = 'MCatalogoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MCatalogoIntrigaCodigo)
begin
	print('Insertando  MCatalogoIntriga a RDI')
	insert into ConfiguracionPaisDatos(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	values(
	@RevistaDigitalIntricaId
	,@MCatalogoIntrigaCodigo
	,0
	,'Pronto podrás suscribirte al Club Gana+'
	,'¡Y ya no tendrás que digitar códigos!'
	,null
	,'Textos de Catálogo mobile para un consultora con RDI'
	,1
	)
end	