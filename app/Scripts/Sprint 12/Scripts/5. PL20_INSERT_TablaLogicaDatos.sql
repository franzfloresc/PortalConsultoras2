USE BelcorpCostaRica
GO

DECLARE @ID SMALLINT 
SET @ID = 98 --Plan 20 - Activación

IF NOT EXISTS(SELECT 1 FROM TablaLogicaDatos where TablaLogicaID = @ID AND TablaLogicaDatosID='9803')
BEGIN
	DECLARE @datosID SMALLINT
	SET @datosID = (SELECT MAX(TablaLogicaDatosID)+1 FROM TablaLogicaDatos WHERE TablaLogicaID = @ID)
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID, Codigo, Descripcion) VALUES('9803', @ID, '201705', 'Personalización showroom')
END

GO