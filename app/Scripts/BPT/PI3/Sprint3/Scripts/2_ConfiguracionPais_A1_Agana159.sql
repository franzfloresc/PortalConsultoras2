 
GO
-- AGANA-159

USE BelcorpPeru_BPT

GO

print db_name()


go

begin

	-- select Orden, OrdenBpt, MobileOrden, MobileOrdenBPT from ConfiguracionPais where TienePerfil=1 and Codigo<>'ATP' and Orden not in (0)
	update ConfiguracionPais 
	set Orden=Orden+1, OrdenBpt=OrdenBpt+1, MobileOrden=MobileOrden+1, MobileOrdenBPT=MobileOrdenBPT+1 
	from ConfiguracionPais where TienePerfil=1 and Codigo<>'ATP' and Orden not in (0) 
 
	-- select DesktopOrden, DesktopOrdenBpt, MobileOrden, MobileOrdenBpt from configuracionOfertasHome where ConfiguracionPaisID in (select ConfiguracionPaisID from ConfiguracionPais where TienePerfil=1 and Codigo<>'ATP' and Orden not in (0))
	update configuracionOfertasHome 
	set DesktopOrden=DesktopOrden+1, DesktopOrdenBpt=DesktopOrdenBpt+1, MobileOrden=MobileOrden+1, MobileOrdenBpt=MobileOrdenBpt+1 
	where ConfiguracionPaisID in (select ConfiguracionPaisID from ConfiguracionPais where TienePerfil=1 and Codigo<>'ATP' and Orden not in (0))

end

 