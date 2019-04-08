GO

print db_name()
 
if not exists (select 1 from ConfiguracionPais a where a.Codigo = 'ATP')
begin
	
	declare @orden int = 1 
	declare @campania int = 201907

	INSERT INTO [ConfiguracionPais] 
	([Codigo],[Excluyente],[Descripcion],[Estado],[TienePerfil],[DesdeCampania],[UrlMenu],
	[MobileTituloMenu],[DesktopTituloMenu],
	[Logo],[MobileTituloBanner],[DesktopSubTituloBanner],[DesktopTituloBanner],[MobileSubTituloBanner],
	[DesktopFondoBanner],[MobileFondoBanner],
	[DesktopLogoBanner],[MobileLogoBanner],
	[Orden],[OrdenBpt],[MobileOrden],[MobileOrdenBPT])
	VALUES
	('ATP',1,'Arma tu pack',1,1,@campania,'',
	'Arma tu pack','Arma tu pack',
	NULL,NULL,NULL,NULL, NULL,
	NULL, NULL,
	NULL, NULL,
	@orden,@orden,@orden,@orden)

end

go

 

 