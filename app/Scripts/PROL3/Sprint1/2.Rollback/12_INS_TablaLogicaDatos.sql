GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;
END
GO