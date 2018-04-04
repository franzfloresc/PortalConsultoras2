go
delete from TablaLogicaDatos where TablaLogicaID = 137
delete from TablaLogica where TablaLogicaID = 137

Insert Into TablaLogica (TablaLogicaID, Descripcion)
values (137, 'Cantidad Cuv Masivo')

Insert Into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
values (13701, 137, '200', 'Cantidad Cuv Masivo en Zona Estrategia - Btn Nuevo Masivo')
go