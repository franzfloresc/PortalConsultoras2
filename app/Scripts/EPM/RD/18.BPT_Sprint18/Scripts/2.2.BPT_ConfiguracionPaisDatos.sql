USE BelcorpPeru
GO

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

declare @DPedidoIntrigaCodigo varchar(100) = 'DPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DPedidoIntrigaCodigo)
begin
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
	,@DPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido para un consultora con RDI'
	,1
	)
end	

declare @MPedidoIntrigaCodigo varchar(100) = 'MPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MPedidoIntrigaCodigo)
begin
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
	,@MPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribir al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido mobile para un consultora con RDI'
	,1
	)
end	

declare @DLandingBannerIntrigaCodigo varchar(100) = 'DLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DLandingBannerIntrigaCodigo)
begin
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
	,@DLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'un nuevo espacio online exclusivo para ti'
	,null
	,'Desktop Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end	

declare @MLandingBannerIntrigaCodigo varchar(100) = 'MLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MLandingBannerIntrigaCodigo)
begin
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
	,@MLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,null
	,null
	,'Mobile Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end

GO

USE BelcorpMexico
GO

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

declare @DPedidoIntrigaCodigo varchar(100) = 'DPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DPedidoIntrigaCodigo)
begin
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
	,@DPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido para un consultora con RDI'
	,1
	)
end	

declare @MPedidoIntrigaCodigo varchar(100) = 'MPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MPedidoIntrigaCodigo)
begin
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
	,@MPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribir al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido mobile para un consultora con RDI'
	,1
	)
end	

declare @DLandingBannerIntrigaCodigo varchar(100) = 'DLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DLandingBannerIntrigaCodigo)
begin
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
	,@DLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'un nuevo espacio online exclusivo para ti'
	,null
	,'Desktop Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end	

declare @MLandingBannerIntrigaCodigo varchar(100) = 'MLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MLandingBannerIntrigaCodigo)
begin
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
	,@MLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,null
	,null
	,'Mobile Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end

GO

USE BelcorpColombia
GO

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

declare @DPedidoIntrigaCodigo varchar(100) = 'DPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DPedidoIntrigaCodigo)
begin
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
	,@DPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido para un consultora con RDI'
	,1
	)
end	

declare @MPedidoIntrigaCodigo varchar(100) = 'MPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MPedidoIntrigaCodigo)
begin
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
	,@MPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribir al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido mobile para un consultora con RDI'
	,1
	)
end	

declare @DLandingBannerIntrigaCodigo varchar(100) = 'DLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DLandingBannerIntrigaCodigo)
begin
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
	,@DLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'un nuevo espacio online exclusivo para ti'
	,null
	,'Desktop Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end	

declare @MLandingBannerIntrigaCodigo varchar(100) = 'MLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MLandingBannerIntrigaCodigo)
begin
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
	,@MLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,null
	,null
	,'Mobile Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end

GO

USE BelcorpVenezuela
GO

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

declare @DPedidoIntrigaCodigo varchar(100) = 'DPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DPedidoIntrigaCodigo)
begin
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
	,@DPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido para un consultora con RDI'
	,1
	)
end	

declare @MPedidoIntrigaCodigo varchar(100) = 'MPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MPedidoIntrigaCodigo)
begin
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
	,@MPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribir al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido mobile para un consultora con RDI'
	,1
	)
end	

declare @DLandingBannerIntrigaCodigo varchar(100) = 'DLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DLandingBannerIntrigaCodigo)
begin
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
	,@DLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'un nuevo espacio online exclusivo para ti'
	,null
	,'Desktop Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end	

declare @MLandingBannerIntrigaCodigo varchar(100) = 'MLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MLandingBannerIntrigaCodigo)
begin
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
	,@MLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,null
	,null
	,'Mobile Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end

GO

USE BelcorpSalvador
GO

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

declare @DPedidoIntrigaCodigo varchar(100) = 'DPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DPedidoIntrigaCodigo)
begin
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
	,@DPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido para un consultora con RDI'
	,1
	)
end	

declare @MPedidoIntrigaCodigo varchar(100) = 'MPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MPedidoIntrigaCodigo)
begin
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
	,@MPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribir al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido mobile para un consultora con RDI'
	,1
	)
end	

declare @DLandingBannerIntrigaCodigo varchar(100) = 'DLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DLandingBannerIntrigaCodigo)
begin
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
	,@DLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'un nuevo espacio online exclusivo para ti'
	,null
	,'Desktop Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end	

declare @MLandingBannerIntrigaCodigo varchar(100) = 'MLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MLandingBannerIntrigaCodigo)
begin
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
	,@MLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,null
	,null
	,'Mobile Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end

GO

USE BelcorpPuertoRico
GO

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

declare @DPedidoIntrigaCodigo varchar(100) = 'DPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DPedidoIntrigaCodigo)
begin
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
	,@DPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido para un consultora con RDI'
	,1
	)
end	

declare @MPedidoIntrigaCodigo varchar(100) = 'MPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MPedidoIntrigaCodigo)
begin
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
	,@MPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribir al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido mobile para un consultora con RDI'
	,1
	)
end	

declare @DLandingBannerIntrigaCodigo varchar(100) = 'DLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DLandingBannerIntrigaCodigo)
begin
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
	,@DLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'un nuevo espacio online exclusivo para ti'
	,null
	,'Desktop Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end	

declare @MLandingBannerIntrigaCodigo varchar(100) = 'MLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MLandingBannerIntrigaCodigo)
begin
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
	,@MLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,null
	,null
	,'Mobile Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end

GO

USE BelcorpPanama
GO

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

declare @DPedidoIntrigaCodigo varchar(100) = 'DPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DPedidoIntrigaCodigo)
begin
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
	,@DPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido para un consultora con RDI'
	,1
	)
end	

declare @MPedidoIntrigaCodigo varchar(100) = 'MPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MPedidoIntrigaCodigo)
begin
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
	,@MPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribir al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido mobile para un consultora con RDI'
	,1
	)
end	

declare @DLandingBannerIntrigaCodigo varchar(100) = 'DLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DLandingBannerIntrigaCodigo)
begin
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
	,@DLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'un nuevo espacio online exclusivo para ti'
	,null
	,'Desktop Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end	

declare @MLandingBannerIntrigaCodigo varchar(100) = 'MLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MLandingBannerIntrigaCodigo)
begin
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
	,@MLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,null
	,null
	,'Mobile Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end

GO

USE BelcorpGuatemala
GO

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

declare @DPedidoIntrigaCodigo varchar(100) = 'DPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DPedidoIntrigaCodigo)
begin
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
	,@DPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido para un consultora con RDI'
	,1
	)
end	

declare @MPedidoIntrigaCodigo varchar(100) = 'MPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MPedidoIntrigaCodigo)
begin
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
	,@MPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribir al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido mobile para un consultora con RDI'
	,1
	)
end	

declare @DLandingBannerIntrigaCodigo varchar(100) = 'DLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DLandingBannerIntrigaCodigo)
begin
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
	,@DLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'un nuevo espacio online exclusivo para ti'
	,null
	,'Desktop Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end	

declare @MLandingBannerIntrigaCodigo varchar(100) = 'MLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MLandingBannerIntrigaCodigo)
begin
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
	,@MLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,null
	,null
	,'Mobile Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end

GO

USE BelcorpEcuador
GO

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

declare @DPedidoIntrigaCodigo varchar(100) = 'DPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DPedidoIntrigaCodigo)
begin
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
	,@DPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido para un consultora con RDI'
	,1
	)
end	

declare @MPedidoIntrigaCodigo varchar(100) = 'MPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MPedidoIntrigaCodigo)
begin
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
	,@MPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribir al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido mobile para un consultora con RDI'
	,1
	)
end	

declare @DLandingBannerIntrigaCodigo varchar(100) = 'DLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DLandingBannerIntrigaCodigo)
begin
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
	,@DLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'un nuevo espacio online exclusivo para ti'
	,null
	,'Desktop Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end	

declare @MLandingBannerIntrigaCodigo varchar(100) = 'MLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MLandingBannerIntrigaCodigo)
begin
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
	,@MLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,null
	,null
	,'Mobile Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end

GO

USE BelcorpDominicana
GO

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

declare @DPedidoIntrigaCodigo varchar(100) = 'DPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DPedidoIntrigaCodigo)
begin
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
	,@DPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido para un consultora con RDI'
	,1
	)
end	

declare @MPedidoIntrigaCodigo varchar(100) = 'MPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MPedidoIntrigaCodigo)
begin
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
	,@MPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribir al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido mobile para un consultora con RDI'
	,1
	)
end	

declare @DLandingBannerIntrigaCodigo varchar(100) = 'DLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DLandingBannerIntrigaCodigo)
begin
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
	,@DLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'un nuevo espacio online exclusivo para ti'
	,null
	,'Desktop Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end	

declare @MLandingBannerIntrigaCodigo varchar(100) = 'MLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MLandingBannerIntrigaCodigo)
begin
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
	,@MLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,null
	,null
	,'Mobile Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end

GO

USE BelcorpCostaRica
GO

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

declare @DPedidoIntrigaCodigo varchar(100) = 'DPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DPedidoIntrigaCodigo)
begin
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
	,@DPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido para un consultora con RDI'
	,1
	)
end	

declare @MPedidoIntrigaCodigo varchar(100) = 'MPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MPedidoIntrigaCodigo)
begin
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
	,@MPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribir al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido mobile para un consultora con RDI'
	,1
	)
end	

declare @DLandingBannerIntrigaCodigo varchar(100) = 'DLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DLandingBannerIntrigaCodigo)
begin
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
	,@DLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'un nuevo espacio online exclusivo para ti'
	,null
	,'Desktop Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end	

declare @MLandingBannerIntrigaCodigo varchar(100) = 'MLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MLandingBannerIntrigaCodigo)
begin
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
	,@MLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,null
	,null
	,'Mobile Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end

GO

USE BelcorpChile
GO

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

declare @DPedidoIntrigaCodigo varchar(100) = 'DPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DPedidoIntrigaCodigo)
begin
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
	,@DPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido para un consultora con RDI'
	,1
	)
end	

declare @MPedidoIntrigaCodigo varchar(100) = 'MPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MPedidoIntrigaCodigo)
begin
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
	,@MPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribir al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido mobile para un consultora con RDI'
	,1
	)
end	

declare @DLandingBannerIntrigaCodigo varchar(100) = 'DLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DLandingBannerIntrigaCodigo)
begin
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
	,@DLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'un nuevo espacio online exclusivo para ti'
	,null
	,'Desktop Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end	

declare @MLandingBannerIntrigaCodigo varchar(100) = 'MLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MLandingBannerIntrigaCodigo)
begin
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
	,@MLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,null
	,null
	,'Mobile Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end

GO

USE BelcorpBolivia
GO

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

declare @DPedidoIntrigaCodigo varchar(100) = 'DPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DPedidoIntrigaCodigo)
begin
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
	,@DPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido para un consultora con RDI'
	,1
	)
end	

declare @MPedidoIntrigaCodigo varchar(100) = 'MPedidoIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MPedidoIntrigaCodigo)
begin
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
	,@MPedidoIntrigaCodigo
	,0
	,'¡Pronto podrás suscribir al Club Gana+!'
	,'y tendrás muchas ofertas exclusivas hechas a tu medida'
	,null
	,'Textos de Pedido mobile para un consultora con RDI'
	,1
	)
end	

declare @DLandingBannerIntrigaCodigo varchar(100) = 'DLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @DLandingBannerIntrigaCodigo)
begin
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
	,@DLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,'un nuevo espacio online exclusivo para ti'
	,null
	,'Desktop Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end	

declare @MLandingBannerIntrigaCodigo varchar(100) = 'MLandingBannerIntriga'
if not exists (	select *
				from ConfiguracionPaisDatos cpd
				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
				and cpd.codigo = @MLandingBannerIntrigaCodigo)
begin
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
	,@MLandingBannerIntrigaCodigo
	,0
	,'¡Pronto podrás suscribirte al Club Gana+!'
	,null
	,null
	,'Mobile Banner Landing Productos Comprar y Revisar, Revista Digital Intriga'
	,1
	)
end

GO

