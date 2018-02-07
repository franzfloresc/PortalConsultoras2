
USE BelcorpPeru_PL50
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProductoAll]
@EstrategiaID int
,@UsuarioModificacion nvarchar(30)
as
begin
	update EstrategiaProducto
	set Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	where EstrategiaID = @EstrategiaID
end
