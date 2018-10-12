use SoporteConsultoras
GO
if exists (select 1 from Permiso where IdPerfil = 4 and	IdPais = 2 and IdMenu = 35)
begin
	delete from Permiso where IdPerfil = 4 and	IdPais = 2 and IdMenu = 35
end
GO
