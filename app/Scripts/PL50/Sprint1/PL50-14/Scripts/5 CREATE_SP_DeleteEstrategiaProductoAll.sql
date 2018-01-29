

USE BelcorpColombia_PL50
GO

CREATE procedure [dbo].[DeleteEstrategiaProductoAll]
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
GO

USE BelcorpMexico_PL50
GO

CREATE procedure [dbo].[DeleteEstrategiaProductoAll]
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
GO

USE BelcorpPeru_PL50
GO

CREATE procedure [dbo].[DeleteEstrategiaProductoAll]
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
