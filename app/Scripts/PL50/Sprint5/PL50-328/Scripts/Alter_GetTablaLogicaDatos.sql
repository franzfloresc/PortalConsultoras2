ALTER PROCEDURE [dbo].[GetTablaLogicaDatos] @TablaLogicaID SMALLINT
AS
SELECT TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	,Valor
FROM TablaLogicaDatos(NOLOCK)
WHERE TablaLogicaID = @TablaLogicaID
