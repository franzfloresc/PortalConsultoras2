USE BelcorpChile_BPT
GO

declare @RevistaDigitalIntricaId int = 0
declare @RevistaDigitalIntricaCodigo varchar(30) = 'RDI'

select 
@RevistaDigitalIntricaId = cp.ConfiguracionPaisID
from ConfiguracionPais cp
where cp.Codigo = @RevistaDigitalIntricaCodigo



--declare @LogoComercialCodigo varchar(100) = 'LogoComercial'
--if not exists (	select *
--				from ConfiguracionPaisDatos cpd
--				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
--				and cpd.codigo = @LogoComercialCodigo)
--begin
--	print('Insertando  LogoComercial a RDI')
--	insert into ConfiguracionPaisDatos(
--	ConfiguracionPaisID
--	,Codigo
--	,CampaniaID
--	,Valor1
--	,Valor2
--	,Valor3
--	,Descripcion
--	,Estado
--	)
--	values(
--	@RevistaDigitalIntricaId
--	,@LogoComercialCodigo
--	,0
--	,'logotipo-ganamaplus-blanco.svg'
--	,'logotipo-ganamaplus-blanco.svg'
--	,null
--	,'Logo comercial para intriga que se asignara en todo sb2'
--	,1
--	)
--end	



--declare @LogoComercialFondoCodigo varchar(100) = 'LogoComercialFondo'
--if not exists (	select *
--				from ConfiguracionPaisDatos cpd
--				where cpd.ConfiguracionPaisID = @RevistaDigitalIntricaId
--				and cpd.codigo = @LogoComercialFondoCodigo)
--begin
--	print('Insertando  LogoComercialFondo a RDI')
--	insert into ConfiguracionPaisDatos(
--	ConfiguracionPaisID
--	,Codigo
--	,CampaniaID
--	,Valor1
--	,Valor2
--	,Valor3
--	,Descripcion
--	,Estado
--	)
--	values(
--	@RevistaDigitalIntricaId
--	,@LogoComercialFondoCodigo
--	,0
--	,'GanaMasFondo.png'
--	,'GanaMasMobileFondo.png'
--	,null
--	,'Logo comercial para intriga que se asignara en todo sb2'
--	,1
--	)
--end	



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