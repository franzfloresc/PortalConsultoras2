DECLARE @TablaLogicaID int = 152;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
