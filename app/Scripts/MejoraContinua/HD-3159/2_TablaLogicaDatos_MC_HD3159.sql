DECLARE @TablaLogicaID int = 152;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'Cierre Sesion Validado')
INSERT INTO TablaLogicaDatos values (cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, '01', 'Validar Cierre Session', '1');
