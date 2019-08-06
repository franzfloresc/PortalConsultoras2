IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'InsertarEncuesta')
BEGIN
 DROP PROCEDURE InsertarEncuesta;
END

GO