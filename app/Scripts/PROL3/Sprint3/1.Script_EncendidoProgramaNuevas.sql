GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
insert into TablaLogica values (7, 'ActivarProgramaNueva')
insert into TablaLogicaDatos values (701, 7, 'Activo', '0', '')
GO