DECLARE @TablaLogicaID int = 231;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
