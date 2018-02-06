

USE BelcorpPeru_PL50
GO

CREATE PROCEDURE [dbo].[UpdateEstrategiaProducto]
@EstrategiaId int
,@CUV2 nvarchar(20)
,@Precio money
--,@PrecioValorizado money
,@NombreProducto nvarchar(150)
,@Descripcion1 nvarchar(255)
,@ImagenProducto nvarchar(150)
,@IdMarca tinyint
,@Activo tinyint
,@UsuarioModificacion nvarchar(30)
AS
begin

	update EstrategiaProducto
	set  --Campania = @Campania
		--,CUV = @CUV
		--,CUV2 = @CUV2
		Precio = @Precio
		--,PrecioValorizado = @PrecioValorizado
		,NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,IdMarca = @IdMarca
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = getdate()
	where EstrategiaId = @EstrategiaId and CUV2 = @CUV2
		
end
GO
