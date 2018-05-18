GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO