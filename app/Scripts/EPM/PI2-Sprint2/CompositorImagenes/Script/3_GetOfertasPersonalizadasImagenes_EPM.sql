
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetOfertasPersonalizadasImagenes]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetOfertasPersonalizadasImagenes]
GO


CREATE PROCEDURE [dbo].[GetOfertasPersonalizadasImagenes]
	@CampaniaID int,
	@TipoConfigurado int,
	@CodigoEstrategia varchar(4) = '001'
as
/* el resultado es la lista de cuv que no existe imagen en la tabla 
-- GetCantidadOfertasPersonalizadas 201801, 1, '007'
*/
BEGIN
	SET NOCOUNT OFF


	-- el select 
	GetCantidadOfertasPersonalizadas @CampaniaID, @TipoConfigurado, @CodigoEstrategia



	SET NOCOUNT ON
END
