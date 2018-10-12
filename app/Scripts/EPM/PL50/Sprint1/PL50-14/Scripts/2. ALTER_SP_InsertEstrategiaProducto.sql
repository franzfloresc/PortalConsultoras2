
USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[InsertEstrategiaProducto]
@Retorno int output
,@EstrategiaProductoId int 
,@EstrategiaId int
,@Campania int
,@CUV nvarchar(20)
,@CodigoEstrategia nvarchar(100)
,@Grupo nvarchar(20)
,@Orden int
,@CUV2 nvarchar(20)
,@SAP nvarchar(50)
,@Cantidad int
,@Precio money
,@PrecioValorizado money
,@Digitable int
,@CodigoError nvarchar(100)
,@CodigoErrorObs nvarchar(4000)
,@FactorCuadre INT
,@NombreProducto nvarchar(150)
,@IdMarca tinyint
,@UsuarioModificacion nvarchar(30)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
	set @existe = isnull(@existe, 0)

	if @existe = 0
	begin
		INSERT INTO EstrategiaProducto(
			EstrategiaId
			,Campania
			,CUV
			,CodigoEstrategia
			,Grupo
			,Orden
			,CUV2
			,SAP
			,Cantidad
			,Precio
			,PrecioValorizado
			,Digitable
			,CodigoError
			,CodigoErrorObs
			,FactorCuadre
			,NombreProducto
			,IdMarca
			,Activo
			,UsuarioCreacion
			,FechaCreacion
		)VALUES(
			@EstrategiaId
			,@Campania
			,@CUV
			,@CodigoEstrategia
			,@Grupo
			,@Orden
			,@CUV2
			,@SAP
			,@Cantidad
			,@Precio
			,@PrecioValorizado
			,@Digitable
			,@CodigoError
			,@CodigoErrorObs
			,@FactorCuadre
			,@NombreProducto
			,@IdMarca
			,1
			,@UsuarioModificacion
			,getdate()
		)
	
		set @Retorno = @@IDENTITY
	end
	else
	begin
		declare @TipoEstrategiaId int, @EsProductoShowRoom bit
		select @TipoEstrategiaId = TipoEstrategiaId 
		from Estrategia where EstrategiaId = @EstrategiaId

		set @EsProductoShowRoom = case when @TipoEstrategiaId = 3028 then 1 else 0 end

		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
				,FactorCuadre = @FactorCuadre
				,NombreProducto = case when @EsProductoShowRoom = 1 then @NombreProducto else NombreProducto end
				,IdMarca = @IdMarca
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = getdate()
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end

GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[InsertEstrategiaProducto]
@Retorno int output
,@EstrategiaProductoId int 
,@EstrategiaId int
,@Campania int
,@CUV nvarchar(20)
,@CodigoEstrategia nvarchar(100)
,@Grupo nvarchar(20)
,@Orden int
,@CUV2 nvarchar(20)
,@SAP nvarchar(50)
,@Cantidad int
,@Precio money
,@PrecioValorizado money
,@Digitable int
,@CodigoError nvarchar(100)
,@CodigoErrorObs nvarchar(4000)
,@FactorCuadre INT
,@NombreProducto nvarchar(150)
,@IdMarca tinyint
,@UsuarioModificacion nvarchar(30)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
	set @existe = isnull(@existe, 0)

	if @existe = 0
	begin
		INSERT INTO EstrategiaProducto(
			EstrategiaId
			,Campania
			,CUV
			,CodigoEstrategia
			,Grupo
			,Orden
			,CUV2
			,SAP
			,Cantidad
			,Precio
			,PrecioValorizado
			,Digitable
			,CodigoError
			,CodigoErrorObs
			,FactorCuadre
			,NombreProducto
			,IdMarca
			,Activo
			,UsuarioCreacion
			,FechaCreacion
		)VALUES(
			@EstrategiaId
			,@Campania
			,@CUV
			,@CodigoEstrategia
			,@Grupo
			,@Orden
			,@CUV2
			,@SAP
			,@Cantidad
			,@Precio
			,@PrecioValorizado
			,@Digitable
			,@CodigoError
			,@CodigoErrorObs
			,@FactorCuadre
			,@NombreProducto
			,@IdMarca
			,1
			,@UsuarioModificacion
			,getdate()
		)
	
		set @Retorno = @@IDENTITY
	end
	else
	begin
		declare @TipoEstrategiaId int, @EsProductoShowRoom bit
		select @TipoEstrategiaId = TipoEstrategiaId 
		from Estrategia where EstrategiaId = @EstrategiaId

		set @EsProductoShowRoom = case when @TipoEstrategiaId = 3028 then 1 else 0 end

		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
				,FactorCuadre = @FactorCuadre
				,NombreProducto = case when @EsProductoShowRoom = 1 then @NombreProducto else NombreProducto end
				,IdMarca = @IdMarca
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = getdate()
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end

GO


USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[InsertEstrategiaProducto]
@Retorno int output
,@EstrategiaProductoId int 
,@EstrategiaId int
,@Campania int
,@CUV nvarchar(20)
,@CodigoEstrategia nvarchar(100)
,@Grupo nvarchar(20)
,@Orden int
,@CUV2 nvarchar(20)
,@SAP nvarchar(50)
,@Cantidad int
,@Precio money
,@PrecioValorizado money
,@Digitable int
,@CodigoError nvarchar(100)
,@CodigoErrorObs nvarchar(4000)
,@FactorCuadre INT
,@NombreProducto nvarchar(150)
,@IdMarca tinyint
,@UsuarioModificacion nvarchar(30)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
	set @existe = isnull(@existe, 0)

	if @existe = 0
	begin
		INSERT INTO EstrategiaProducto(
			EstrategiaId
			,Campania
			,CUV
			,CodigoEstrategia
			,Grupo
			,Orden
			,CUV2
			,SAP
			,Cantidad
			,Precio
			,PrecioValorizado
			,Digitable
			,CodigoError
			,CodigoErrorObs
			,FactorCuadre
			,NombreProducto
			,IdMarca
			,Activo
			,UsuarioCreacion
			,FechaCreacion
		)VALUES(
			@EstrategiaId
			,@Campania
			,@CUV
			,@CodigoEstrategia
			,@Grupo
			,@Orden
			,@CUV2
			,@SAP
			,@Cantidad
			,@Precio
			,@PrecioValorizado
			,@Digitable
			,@CodigoError
			,@CodigoErrorObs
			,@FactorCuadre
			,@NombreProducto
			,@IdMarca
			,1
			,@UsuarioModificacion
			,getdate()
		)
	
		set @Retorno = @@IDENTITY
	end
	else
	begin
		declare @TipoEstrategiaId int, @EsProductoShowRoom bit
		select @TipoEstrategiaId = TipoEstrategiaId 
		from Estrategia where EstrategiaId = @EstrategiaId

		set @EsProductoShowRoom = case when @TipoEstrategiaId = 3028 then 1 else 0 end

		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
				,FactorCuadre = @FactorCuadre
				,NombreProducto = case when @EsProductoShowRoom = 1 then @NombreProducto else NombreProducto end
				,IdMarca = @IdMarca
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = getdate()
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end

GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[InsertEstrategiaProducto]
@Retorno int output
,@EstrategiaProductoId int 
,@EstrategiaId int
,@Campania int
,@CUV nvarchar(20)
,@CodigoEstrategia nvarchar(100)
,@Grupo nvarchar(20)
,@Orden int
,@CUV2 nvarchar(20)
,@SAP nvarchar(50)
,@Cantidad int
,@Precio money
,@PrecioValorizado money
,@Digitable int
,@CodigoError nvarchar(100)
,@CodigoErrorObs nvarchar(4000)
,@FactorCuadre INT
,@NombreProducto nvarchar(150)
,@IdMarca tinyint
,@UsuarioModificacion nvarchar(30)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
	set @existe = isnull(@existe, 0)

	if @existe = 0
	begin
		INSERT INTO EstrategiaProducto(
			EstrategiaId
			,Campania
			,CUV
			,CodigoEstrategia
			,Grupo
			,Orden
			,CUV2
			,SAP
			,Cantidad
			,Precio
			,PrecioValorizado
			,Digitable
			,CodigoError
			,CodigoErrorObs
			,FactorCuadre
			,NombreProducto
			,IdMarca
			,Activo
			,UsuarioCreacion
			,FechaCreacion
		)VALUES(
			@EstrategiaId
			,@Campania
			,@CUV
			,@CodigoEstrategia
			,@Grupo
			,@Orden
			,@CUV2
			,@SAP
			,@Cantidad
			,@Precio
			,@PrecioValorizado
			,@Digitable
			,@CodigoError
			,@CodigoErrorObs
			,@FactorCuadre
			,@NombreProducto
			,@IdMarca
			,1
			,@UsuarioModificacion
			,getdate()
		)
	
		set @Retorno = @@IDENTITY
	end
	else
	begin
		declare @TipoEstrategiaId int, @EsProductoShowRoom bit
		select @TipoEstrategiaId = TipoEstrategiaId 
		from Estrategia where EstrategiaId = @EstrategiaId

		set @EsProductoShowRoom = case when @TipoEstrategiaId = 3028 then 1 else 0 end

		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
				,FactorCuadre = @FactorCuadre
				,NombreProducto = case when @EsProductoShowRoom = 1 then @NombreProducto else NombreProducto end
				,IdMarca = @IdMarca
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = getdate()
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end

GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[InsertEstrategiaProducto]
@Retorno int output
,@EstrategiaProductoId int 
,@EstrategiaId int
,@Campania int
,@CUV nvarchar(20)
,@CodigoEstrategia nvarchar(100)
,@Grupo nvarchar(20)
,@Orden int
,@CUV2 nvarchar(20)
,@SAP nvarchar(50)
,@Cantidad int
,@Precio money
,@PrecioValorizado money
,@Digitable int
,@CodigoError nvarchar(100)
,@CodigoErrorObs nvarchar(4000)
,@FactorCuadre INT
,@NombreProducto nvarchar(150)
,@IdMarca tinyint
,@UsuarioModificacion nvarchar(30)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
	set @existe = isnull(@existe, 0)

	if @existe = 0
	begin
		INSERT INTO EstrategiaProducto(
			EstrategiaId
			,Campania
			,CUV
			,CodigoEstrategia
			,Grupo
			,Orden
			,CUV2
			,SAP
			,Cantidad
			,Precio
			,PrecioValorizado
			,Digitable
			,CodigoError
			,CodigoErrorObs
			,FactorCuadre
			,NombreProducto
			,IdMarca
			,Activo
			,UsuarioCreacion
			,FechaCreacion
		)VALUES(
			@EstrategiaId
			,@Campania
			,@CUV
			,@CodigoEstrategia
			,@Grupo
			,@Orden
			,@CUV2
			,@SAP
			,@Cantidad
			,@Precio
			,@PrecioValorizado
			,@Digitable
			,@CodigoError
			,@CodigoErrorObs
			,@FactorCuadre
			,@NombreProducto
			,@IdMarca
			,1
			,@UsuarioModificacion
			,getdate()
		)
	
		set @Retorno = @@IDENTITY
	end
	else
	begin
		declare @TipoEstrategiaId int, @EsProductoShowRoom bit
		select @TipoEstrategiaId = TipoEstrategiaId 
		from Estrategia where EstrategiaId = @EstrategiaId

		set @EsProductoShowRoom = case when @TipoEstrategiaId = 3028 then 1 else 0 end

		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
				,FactorCuadre = @FactorCuadre
				,NombreProducto = case when @EsProductoShowRoom = 1 then @NombreProducto else NombreProducto end
				,IdMarca = @IdMarca
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = getdate()
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end

GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[InsertEstrategiaProducto]
@Retorno int output
,@EstrategiaProductoId int 
,@EstrategiaId int
,@Campania int
,@CUV nvarchar(20)
,@CodigoEstrategia nvarchar(100)
,@Grupo nvarchar(20)
,@Orden int
,@CUV2 nvarchar(20)
,@SAP nvarchar(50)
,@Cantidad int
,@Precio money
,@PrecioValorizado money
,@Digitable int
,@CodigoError nvarchar(100)
,@CodigoErrorObs nvarchar(4000)
,@FactorCuadre INT
,@NombreProducto nvarchar(150)
,@IdMarca tinyint
,@UsuarioModificacion nvarchar(30)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
	set @existe = isnull(@existe, 0)

	if @existe = 0
	begin
		INSERT INTO EstrategiaProducto(
			EstrategiaId
			,Campania
			,CUV
			,CodigoEstrategia
			,Grupo
			,Orden
			,CUV2
			,SAP
			,Cantidad
			,Precio
			,PrecioValorizado
			,Digitable
			,CodigoError
			,CodigoErrorObs
			,FactorCuadre
			,NombreProducto
			,IdMarca
			,Activo
			,UsuarioCreacion
			,FechaCreacion
		)VALUES(
			@EstrategiaId
			,@Campania
			,@CUV
			,@CodigoEstrategia
			,@Grupo
			,@Orden
			,@CUV2
			,@SAP
			,@Cantidad
			,@Precio
			,@PrecioValorizado
			,@Digitable
			,@CodigoError
			,@CodigoErrorObs
			,@FactorCuadre
			,@NombreProducto
			,@IdMarca
			,1
			,@UsuarioModificacion
			,getdate()
		)
	
		set @Retorno = @@IDENTITY
	end
	else
	begin
		declare @TipoEstrategiaId int, @EsProductoShowRoom bit
		select @TipoEstrategiaId = TipoEstrategiaId 
		from Estrategia where EstrategiaId = @EstrategiaId

		set @EsProductoShowRoom = case when @TipoEstrategiaId = 3028 then 1 else 0 end

		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
				,FactorCuadre = @FactorCuadre
				,NombreProducto = case when @EsProductoShowRoom = 1 then @NombreProducto else NombreProducto end
				,IdMarca = @IdMarca
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = getdate()
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end

GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[InsertEstrategiaProducto]
@Retorno int output
,@EstrategiaProductoId int 
,@EstrategiaId int
,@Campania int
,@CUV nvarchar(20)
,@CodigoEstrategia nvarchar(100)
,@Grupo nvarchar(20)
,@Orden int
,@CUV2 nvarchar(20)
,@SAP nvarchar(50)
,@Cantidad int
,@Precio money
,@PrecioValorizado money
,@Digitable int
,@CodigoError nvarchar(100)
,@CodigoErrorObs nvarchar(4000)
,@FactorCuadre INT
,@NombreProducto nvarchar(150)
,@IdMarca tinyint
,@UsuarioModificacion nvarchar(30)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
	set @existe = isnull(@existe, 0)

	if @existe = 0
	begin
		INSERT INTO EstrategiaProducto(
			EstrategiaId
			,Campania
			,CUV
			,CodigoEstrategia
			,Grupo
			,Orden
			,CUV2
			,SAP
			,Cantidad
			,Precio
			,PrecioValorizado
			,Digitable
			,CodigoError
			,CodigoErrorObs
			,FactorCuadre
			,NombreProducto
			,IdMarca
			,Activo
			,UsuarioCreacion
			,FechaCreacion
		)VALUES(
			@EstrategiaId
			,@Campania
			,@CUV
			,@CodigoEstrategia
			,@Grupo
			,@Orden
			,@CUV2
			,@SAP
			,@Cantidad
			,@Precio
			,@PrecioValorizado
			,@Digitable
			,@CodigoError
			,@CodigoErrorObs
			,@FactorCuadre
			,@NombreProducto
			,@IdMarca
			,1
			,@UsuarioModificacion
			,getdate()
		)
	
		set @Retorno = @@IDENTITY
	end
	else
	begin
		declare @TipoEstrategiaId int, @EsProductoShowRoom bit
		select @TipoEstrategiaId = TipoEstrategiaId 
		from Estrategia where EstrategiaId = @EstrategiaId

		set @EsProductoShowRoom = case when @TipoEstrategiaId = 3028 then 1 else 0 end

		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
				,FactorCuadre = @FactorCuadre
				,NombreProducto = case when @EsProductoShowRoom = 1 then @NombreProducto else NombreProducto end
				,IdMarca = @IdMarca
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = getdate()
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end

GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[InsertEstrategiaProducto]
@Retorno int output
,@EstrategiaProductoId int 
,@EstrategiaId int
,@Campania int
,@CUV nvarchar(20)
,@CodigoEstrategia nvarchar(100)
,@Grupo nvarchar(20)
,@Orden int
,@CUV2 nvarchar(20)
,@SAP nvarchar(50)
,@Cantidad int
,@Precio money
,@PrecioValorizado money
,@Digitable int
,@CodigoError nvarchar(100)
,@CodigoErrorObs nvarchar(4000)
,@FactorCuadre INT
,@NombreProducto nvarchar(150)
,@IdMarca tinyint
,@UsuarioModificacion nvarchar(30)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
	set @existe = isnull(@existe, 0)

	if @existe = 0
	begin
		INSERT INTO EstrategiaProducto(
			EstrategiaId
			,Campania
			,CUV
			,CodigoEstrategia
			,Grupo
			,Orden
			,CUV2
			,SAP
			,Cantidad
			,Precio
			,PrecioValorizado
			,Digitable
			,CodigoError
			,CodigoErrorObs
			,FactorCuadre
			,NombreProducto
			,IdMarca
			,Activo
			,UsuarioCreacion
			,FechaCreacion
		)VALUES(
			@EstrategiaId
			,@Campania
			,@CUV
			,@CodigoEstrategia
			,@Grupo
			,@Orden
			,@CUV2
			,@SAP
			,@Cantidad
			,@Precio
			,@PrecioValorizado
			,@Digitable
			,@CodigoError
			,@CodigoErrorObs
			,@FactorCuadre
			,@NombreProducto
			,@IdMarca
			,1
			,@UsuarioModificacion
			,getdate()
		)
	
		set @Retorno = @@IDENTITY
	end
	else
	begin
		declare @TipoEstrategiaId int, @EsProductoShowRoom bit
		select @TipoEstrategiaId = TipoEstrategiaId 
		from Estrategia where EstrategiaId = @EstrategiaId

		set @EsProductoShowRoom = case when @TipoEstrategiaId = 3028 then 1 else 0 end

		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
				,FactorCuadre = @FactorCuadre
				,NombreProducto = case when @EsProductoShowRoom = 1 then @NombreProducto else NombreProducto end
				,IdMarca = @IdMarca
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = getdate()
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end

GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[InsertEstrategiaProducto]
@Retorno int output
,@EstrategiaProductoId int 
,@EstrategiaId int
,@Campania int
,@CUV nvarchar(20)
,@CodigoEstrategia nvarchar(100)
,@Grupo nvarchar(20)
,@Orden int
,@CUV2 nvarchar(20)
,@SAP nvarchar(50)
,@Cantidad int
,@Precio money
,@PrecioValorizado money
,@Digitable int
,@CodigoError nvarchar(100)
,@CodigoErrorObs nvarchar(4000)
,@FactorCuadre INT
,@NombreProducto nvarchar(150)
,@IdMarca tinyint
,@UsuarioModificacion nvarchar(30)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
	set @existe = isnull(@existe, 0)

	if @existe = 0
	begin
		INSERT INTO EstrategiaProducto(
			EstrategiaId
			,Campania
			,CUV
			,CodigoEstrategia
			,Grupo
			,Orden
			,CUV2
			,SAP
			,Cantidad
			,Precio
			,PrecioValorizado
			,Digitable
			,CodigoError
			,CodigoErrorObs
			,FactorCuadre
			,NombreProducto
			,IdMarca
			,Activo
			,UsuarioCreacion
			,FechaCreacion
		)VALUES(
			@EstrategiaId
			,@Campania
			,@CUV
			,@CodigoEstrategia
			,@Grupo
			,@Orden
			,@CUV2
			,@SAP
			,@Cantidad
			,@Precio
			,@PrecioValorizado
			,@Digitable
			,@CodigoError
			,@CodigoErrorObs
			,@FactorCuadre
			,@NombreProducto
			,@IdMarca
			,1
			,@UsuarioModificacion
			,getdate()
		)
	
		set @Retorno = @@IDENTITY
	end
	else
	begin
		declare @TipoEstrategiaId int, @EsProductoShowRoom bit
		select @TipoEstrategiaId = TipoEstrategiaId 
		from Estrategia where EstrategiaId = @EstrategiaId

		set @EsProductoShowRoom = case when @TipoEstrategiaId = 3028 then 1 else 0 end

		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
				,FactorCuadre = @FactorCuadre
				,NombreProducto = case when @EsProductoShowRoom = 1 then @NombreProducto else NombreProducto end
				,IdMarca = @IdMarca
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = getdate()
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end

GO

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[InsertEstrategiaProducto]
@Retorno int output
,@EstrategiaProductoId int 
,@EstrategiaId int
,@Campania int
,@CUV nvarchar(20)
,@CodigoEstrategia nvarchar(100)
,@Grupo nvarchar(20)
,@Orden int
,@CUV2 nvarchar(20)
,@SAP nvarchar(50)
,@Cantidad int
,@Precio money
,@PrecioValorizado money
,@Digitable int
,@CodigoError nvarchar(100)
,@CodigoErrorObs nvarchar(4000)
,@FactorCuadre INT
,@NombreProducto nvarchar(150)
,@IdMarca tinyint
,@UsuarioModificacion nvarchar(30)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
	set @existe = isnull(@existe, 0)

	if @existe = 0
	begin
		INSERT INTO EstrategiaProducto(
			EstrategiaId
			,Campania
			,CUV
			,CodigoEstrategia
			,Grupo
			,Orden
			,CUV2
			,SAP
			,Cantidad
			,Precio
			,PrecioValorizado
			,Digitable
			,CodigoError
			,CodigoErrorObs
			,FactorCuadre
			,NombreProducto
			,IdMarca
			,Activo
			,UsuarioCreacion
			,FechaCreacion
		)VALUES(
			@EstrategiaId
			,@Campania
			,@CUV
			,@CodigoEstrategia
			,@Grupo
			,@Orden
			,@CUV2
			,@SAP
			,@Cantidad
			,@Precio
			,@PrecioValorizado
			,@Digitable
			,@CodigoError
			,@CodigoErrorObs
			,@FactorCuadre
			,@NombreProducto
			,@IdMarca
			,1
			,@UsuarioModificacion
			,getdate()
		)
	
		set @Retorno = @@IDENTITY
	end
	else
	begin
		declare @TipoEstrategiaId int, @EsProductoShowRoom bit
		select @TipoEstrategiaId = TipoEstrategiaId 
		from Estrategia where EstrategiaId = @EstrategiaId

		set @EsProductoShowRoom = case when @TipoEstrategiaId = 3028 then 1 else 0 end

		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
				,FactorCuadre = @FactorCuadre
				,NombreProducto = case when @EsProductoShowRoom = 1 then @NombreProducto else NombreProducto end
				,IdMarca = @IdMarca
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = getdate()
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end

GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[InsertEstrategiaProducto]
@Retorno int output
,@EstrategiaProductoId int 
,@EstrategiaId int
,@Campania int
,@CUV nvarchar(20)
,@CodigoEstrategia nvarchar(100)
,@Grupo nvarchar(20)
,@Orden int
,@CUV2 nvarchar(20)
,@SAP nvarchar(50)
,@Cantidad int
,@Precio money
,@PrecioValorizado money
,@Digitable int
,@CodigoError nvarchar(100)
,@CodigoErrorObs nvarchar(4000)
,@FactorCuadre INT
,@NombreProducto nvarchar(150)
,@IdMarca tinyint
,@UsuarioModificacion nvarchar(30)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
	set @existe = isnull(@existe, 0)

	if @existe = 0
	begin
		INSERT INTO EstrategiaProducto(
			EstrategiaId
			,Campania
			,CUV
			,CodigoEstrategia
			,Grupo
			,Orden
			,CUV2
			,SAP
			,Cantidad
			,Precio
			,PrecioValorizado
			,Digitable
			,CodigoError
			,CodigoErrorObs
			,FactorCuadre
			,NombreProducto
			,IdMarca
			,Activo
			,UsuarioCreacion
			,FechaCreacion
		)VALUES(
			@EstrategiaId
			,@Campania
			,@CUV
			,@CodigoEstrategia
			,@Grupo
			,@Orden
			,@CUV2
			,@SAP
			,@Cantidad
			,@Precio
			,@PrecioValorizado
			,@Digitable
			,@CodigoError
			,@CodigoErrorObs
			,@FactorCuadre
			,@NombreProducto
			,@IdMarca
			,1
			,@UsuarioModificacion
			,getdate()
		)
	
		set @Retorno = @@IDENTITY
	end
	else
	begin
		declare @TipoEstrategiaId int, @EsProductoShowRoom bit
		select @TipoEstrategiaId = TipoEstrategiaId 
		from Estrategia where EstrategiaId = @EstrategiaId

		set @EsProductoShowRoom = case when @TipoEstrategiaId = 3028 then 1 else 0 end

		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
				,FactorCuadre = @FactorCuadre
				,NombreProducto = case when @EsProductoShowRoom = 1 then @NombreProducto else NombreProducto end
				,IdMarca = @IdMarca
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = getdate()
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end

GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[InsertEstrategiaProducto]
@Retorno int output
,@EstrategiaProductoId int 
,@EstrategiaId int
,@Campania int
,@CUV nvarchar(20)
,@CodigoEstrategia nvarchar(100)
,@Grupo nvarchar(20)
,@Orden int
,@CUV2 nvarchar(20)
,@SAP nvarchar(50)
,@Cantidad int
,@Precio money
,@PrecioValorizado money
,@Digitable int
,@CodigoError nvarchar(100)
,@CodigoErrorObs nvarchar(4000)
,@FactorCuadre INT
,@NombreProducto nvarchar(150)
,@IdMarca tinyint
,@UsuarioModificacion nvarchar(30)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
	set @existe = isnull(@existe, 0)

	if @existe = 0
	begin
		INSERT INTO EstrategiaProducto(
			EstrategiaId
			,Campania
			,CUV
			,CodigoEstrategia
			,Grupo
			,Orden
			,CUV2
			,SAP
			,Cantidad
			,Precio
			,PrecioValorizado
			,Digitable
			,CodigoError
			,CodigoErrorObs
			,FactorCuadre
			,NombreProducto
			,IdMarca
			,Activo
			,UsuarioCreacion
			,FechaCreacion
		)VALUES(
			@EstrategiaId
			,@Campania
			,@CUV
			,@CodigoEstrategia
			,@Grupo
			,@Orden
			,@CUV2
			,@SAP
			,@Cantidad
			,@Precio
			,@PrecioValorizado
			,@Digitable
			,@CodigoError
			,@CodigoErrorObs
			,@FactorCuadre
			,@NombreProducto
			,@IdMarca
			,1
			,@UsuarioModificacion
			,getdate()
		)
	
		set @Retorno = @@IDENTITY
	end
	else
	begin
		declare @TipoEstrategiaId int, @EsProductoShowRoom bit
		select @TipoEstrategiaId = TipoEstrategiaId 
		from Estrategia where EstrategiaId = @EstrategiaId

		set @EsProductoShowRoom = case when @TipoEstrategiaId = 3028 then 1 else 0 end

		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
				,FactorCuadre = @FactorCuadre
				,NombreProducto = case when @EsProductoShowRoom = 1 then @NombreProducto else NombreProducto end
				,IdMarca = @IdMarca
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = getdate()
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end

GO

USE BelcorpVenezuela
GO

ALTER PROCEDURE [dbo].[InsertEstrategiaProducto]
@Retorno int output
,@EstrategiaProductoId int 
,@EstrategiaId int
,@Campania int
,@CUV nvarchar(20)
,@CodigoEstrategia nvarchar(100)
,@Grupo nvarchar(20)
,@Orden int
,@CUV2 nvarchar(20)
,@SAP nvarchar(50)
,@Cantidad int
,@Precio money
,@PrecioValorizado money
,@Digitable int
,@CodigoError nvarchar(100)
,@CodigoErrorObs nvarchar(4000)
,@FactorCuadre INT
,@NombreProducto nvarchar(150)
,@IdMarca tinyint
,@UsuarioModificacion nvarchar(30)
AS
begin

	declare @existe int = 0
	select @existe = EstrategiaProductoId
	from EstrategiaProducto
	where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
	set @existe = isnull(@existe, 0)

	if @existe = 0
	begin
		INSERT INTO EstrategiaProducto(
			EstrategiaId
			,Campania
			,CUV
			,CodigoEstrategia
			,Grupo
			,Orden
			,CUV2
			,SAP
			,Cantidad
			,Precio
			,PrecioValorizado
			,Digitable
			,CodigoError
			,CodigoErrorObs
			,FactorCuadre
			,NombreProducto
			,IdMarca
			,Activo
			,UsuarioCreacion
			,FechaCreacion
		)VALUES(
			@EstrategiaId
			,@Campania
			,@CUV
			,@CodigoEstrategia
			,@Grupo
			,@Orden
			,@CUV2
			,@SAP
			,@Cantidad
			,@Precio
			,@PrecioValorizado
			,@Digitable
			,@CodigoError
			,@CodigoErrorObs
			,@FactorCuadre
			,@NombreProducto
			,@IdMarca
			,1
			,@UsuarioModificacion
			,getdate()
		)
	
		set @Retorno = @@IDENTITY
	end
	else
	begin
		declare @TipoEstrategiaId int, @EsProductoShowRoom bit
		select @TipoEstrategiaId = TipoEstrategiaId 
		from Estrategia where EstrategiaId = @EstrategiaId

		set @EsProductoShowRoom = case when @TipoEstrategiaId = 3028 then 1 else 0 end

		update EstrategiaProducto
			set  Campania = @Campania
				--,CUV = @CUV
				,CodigoEstrategia = @CodigoEstrategia
				,Grupo = @Grupo
				,Orden = @Orden
				--,CUV2 = @CUV2
				,SAP = @SAP
				,Cantidad = @Cantidad
				,Precio = @Precio
				,PrecioValorizado = @PrecioValorizado
				,Digitable = @Digitable
				,CodigoError = @CodigoError
				,CodigoErrorObs = @CodigoErrorObs
				,FactorCuadre = @FactorCuadre
				,NombreProducto = case when @EsProductoShowRoom = 1 then @NombreProducto else NombreProducto end
				,IdMarca = @IdMarca
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = getdate()
		where EstrategiaProductoId = @existe
		set @Retorno = @existe
	end
end

GO




