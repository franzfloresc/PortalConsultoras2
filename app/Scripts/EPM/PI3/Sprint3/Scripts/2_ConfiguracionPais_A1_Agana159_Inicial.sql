

GO
-- AGANA-159

USE BelcorpPeru_BPT

GO

print db_name()
 
if not exists (select 1 from ConfiguracionPais a where a.Codigo = 'ATP')
begin
	
	declare @orden int = 1 
	declare @campania int = 0 

	INSERT INTO [ConfiguracionPais] 
	([Codigo],[Excluyente],[Descripcion],[Estado],[TienePerfil],[DesdeCampania],[MobileTituloMenu],[DesktopTituloMenu],[Logo],[Orden],[DesktopTituloBanner],[MobileTituloBanner],[DesktopSubTituloBanner],[MobileSubTituloBanner],[DesktopFondoBanner],[MobileFondoBanner],[DesktopLogoBanner],[MobileLogoBanner],[UrlMenu],[OrdenBpt],[MobileOrden],[MobileOrdenBPT])
	VALUES
	('ATP',1,'Arma tu pack',1,1,@campania,'Arma tu pack Mobile','Arma tu pack Desktop',NULL,@orden,'Arma tu pack Desktop Banner','Arma tu pack Mobile Banner',NULL,NULL,'porDefinir.png','porDefinir.png','porDefinir.png','porDefinir.png','#',@orden,@orden,@orden)

end

go

 

 