DECLARE @codigo INT = 138;
DELETE FROM TablaLogica WHERE TablaLogicaID = @codigo;
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = @codigo;