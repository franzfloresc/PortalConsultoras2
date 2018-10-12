use SoporteConsultoras
GO
if not exists (select 1 from Permiso where IdPerfil = 4 and	IdPais = 2 and IdMenu = 35)
begin
	insert into Permiso values(4, 2, 35)
end
GO
