if exists (select 1 from TablaLogicaDatos where TablaLogicaID = 132)
delete from TablaLogicaDatos where TablaLogicaID = 132

if exists (select 1 from TablaLogica where TablaLogicaID = 132)
delete from TablaLogica where TablaLogicaID = 132

insert into TablaLogica values (132, 'Codigos-Revista impresa')

insert into TablaLogicaDatos values (13201, 132, '24', 'Codigos revista impresa separado por comas.')