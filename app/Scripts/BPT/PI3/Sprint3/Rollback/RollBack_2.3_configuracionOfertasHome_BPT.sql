GO

print db_name()

go

begin

	update configuracionOfertasHome 
	set DesktopOrden=DesktopOrden-1, DesktopOrdenBpt=DesktopOrdenBpt-1, MobileOrden=MobileOrden-1, MobileOrdenBpt=MobileOrdenBpt-1 
	where ConfiguracionPaisID in (select ConfiguracionPaisID from ConfiguracionPais where Codigo<>'ATP' and Orden not in (0))

end
 