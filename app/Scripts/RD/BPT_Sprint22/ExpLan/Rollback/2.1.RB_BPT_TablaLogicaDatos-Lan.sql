
declare @logicaID int = 102

delete from TablaLogicaDatos where TablaLogicaID = @logicaID and Codigo in ('02', '12');

insert into TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
values (102*100 + 02, @logicaID, '02', 'Imagen Previsual Desktop')