GO

print db_name()
go

begin

	update ConfiguracionPais 
	set Orden=Orden+1, OrdenBpt=OrdenBpt+1, MobileOrden=MobileOrden+1, MobileOrdenBPT=MobileOrdenBPT+1 
	from ConfiguracionPais where TienePerfil=1 and Codigo<>'ATP' and Orden not in (0) 
 
end

go

 