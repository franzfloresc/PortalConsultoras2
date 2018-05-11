GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO