

USE BelcorpPeru_PL50
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProducto]
@EstrategiaID int
,@CUV2 varchar(6)
,@UsuarioModificacion nvarchar(30)
as
begin
	update EstrategiaProducto
	set Activo = 0
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = getdate()
	where EstrategiaID = @EstrategiaID
		and CUV2 = @CUV2
end
