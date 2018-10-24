if not exists (select 1 from TablaLogica where TablaLogicaID = 148)
begin
	insert into TablaLogica values (148, 'Proteccion de Excel');
	insert into TablaLogicaDatos values (14801, 148, '01', 'Habilitar Proteccion', '1');
end
