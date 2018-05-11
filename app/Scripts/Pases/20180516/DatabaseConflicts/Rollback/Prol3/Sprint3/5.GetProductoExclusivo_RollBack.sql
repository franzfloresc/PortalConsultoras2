GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO