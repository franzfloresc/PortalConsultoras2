use belcorpperu_bpt
go 

delete  from configuracionpaisdatos where codigo='LogoMenuInicioNoActivaNoSuscrita'
go
delete  from configuracionpaisdatos where codigo='LogoMenuInicioNoSuscrita'
go
update configuracionpaisdatos set valor1='inicio-club-ganamas-desktop_normal.svg', valor2='inicio-club-ganamas-desktop_normal.svg' where codigo='LogoMenuInicioActiva';
go
update configuracionpaisdatos set valor1='inicio-ganamas-desktop_normal.svg', valor2='inicio-ganamas-mobile_normal.svg' where codigo='LogoMenuInicioNoActiva';
go

 
 