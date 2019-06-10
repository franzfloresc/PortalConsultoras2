DECLARE @TablaLogicaID int = 153;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'Cierre Sesion')
INSERT INTO TablaLogicaDatos values (cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, '01', 'Cierre Session Pedido Reservado', '1');
