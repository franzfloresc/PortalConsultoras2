if not exists (select 1 from TablaLogica where TablaLogicaID = 151)
begin
	insert into TablaLogica values (151, 'Proteccion de Excel');
	insert into TablaLogicaDatos values (15101, 151, '01', 'Habilitar Proteccion', '1');
end
