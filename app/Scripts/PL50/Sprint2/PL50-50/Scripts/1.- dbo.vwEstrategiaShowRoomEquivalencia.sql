IF EXISTS (select * from sys.objects where type = 'V' and name = 'vwEstrategiaShowRoomEquivalencia')
BEGIN
	DROP VIEW [dbo].[vwEstrategiaShowRoomEquivalencia]
END
GO

CREATE VIEW [dbo].[vwEstrategiaShowRoomEquivalencia] 
AS
SELECT 
	11 as ConfiguracionOfertaID
	,1707 as TipoOfertaSisID
	,3028 as TipoEstrategiaId
GO
