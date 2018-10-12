use SoporteConsultoras
go
if exists (select 1 from Permiso where IdPerfil = 4 and	IdPais = 2 and IdMenu = 35)
begin
	delete from Permiso where IdPerfil = 4 and IdPais = 2 and IdMenu = 35
end
if exists (select 1 from Menu where IdMenu = 35)
begin
	Delete from Menu where IdMenu = 35
end