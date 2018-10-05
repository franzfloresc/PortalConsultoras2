
declare @logicaID int = 102

delete from TablaLogicaDatos where TablaLogicaID = @logicaID and Codigo in ('12', '13');

insert into TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
values (102*100 + 12, @logicaID, '12', 'Flag Individual => 1: Si el producto no esta dentro de un pack')

insert into TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
values (102*100 + 13, @logicaID, '13', 'Slogan')
