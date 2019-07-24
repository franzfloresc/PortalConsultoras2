IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'ObtenerDataEncuesta')
BEGIN
 DROP PROCEDURE ObtenerDataEncuesta;
END

GO