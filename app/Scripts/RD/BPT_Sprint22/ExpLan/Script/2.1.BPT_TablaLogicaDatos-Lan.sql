
declare @logicaID int = 102

delete from TablaLogicaDatos where TablaLogicaID = @logicaID and Codigo in ('02', '12');

insert into TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
values (102*100 + 02, @logicaID, '02', 'Flag Individual => 1: Si el producto no esta dentro de un pack')

insert into TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
values (102*100 + 12, @logicaID, '12', 'Slogan')
