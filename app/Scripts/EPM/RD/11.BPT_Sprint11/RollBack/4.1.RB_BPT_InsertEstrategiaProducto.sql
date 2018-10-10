USE BelcorpPeru
GO

GO
ALTER PROCEDURE dbo.InsertEstrategiaProducto
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
	AS
	begin
	
		declare @existe int = 0
		select @existe = EstrategiaProductoId
		from EstrategiaProducto
		where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
		set @existe = isnull(@existe, 0)
	
		-- select * from EstrategiaProducto
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
				)
	
				set @Retorno = @@IDENTITY
		end
		else
		begin
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
			where EstrategiaProductoId = @existe
			set @Retorno = @existe
		end
	end
GO
/*END*/
GO

USE BelcorpMexico
GO

GO
ALTER PROCEDURE dbo.InsertEstrategiaProducto
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
	AS
	begin
	
		declare @existe int = 0
		select @existe = EstrategiaProductoId
		from EstrategiaProducto
		where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
		set @existe = isnull(@existe, 0)
	
		-- select * from EstrategiaProducto
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
				)
	
				set @Retorno = @@IDENTITY
		end
		else
		begin
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
			where EstrategiaProductoId = @existe
			set @Retorno = @existe
		end
	end
GO
/*END*/
GO

USE BelcorpColombia
GO

GO
ALTER PROCEDURE dbo.InsertEstrategiaProducto
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
	AS
	begin
	
		declare @existe int = 0
		select @existe = EstrategiaProductoId
		from EstrategiaProducto
		where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
		set @existe = isnull(@existe, 0)
	
		-- select * from EstrategiaProducto
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
				)
	
				set @Retorno = @@IDENTITY
		end
		else
		begin
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
			where EstrategiaProductoId = @existe
			set @Retorno = @existe
		end
	end
GO
/*END*/
GO

USE BelcorpVenezuela
GO

GO
ALTER PROCEDURE dbo.InsertEstrategiaProducto
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
	AS
	begin
	
		declare @existe int = 0
		select @existe = EstrategiaProductoId
		from EstrategiaProducto
		where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
		set @existe = isnull(@existe, 0)
	
		-- select * from EstrategiaProducto
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
				)
	
				set @Retorno = @@IDENTITY
		end
		else
		begin
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
			where EstrategiaProductoId = @existe
			set @Retorno = @existe
		end
	end
GO
/*END*/
GO

USE BelcorpSalvador
GO

GO
ALTER PROCEDURE dbo.InsertEstrategiaProducto
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
	AS
	begin
	
		declare @existe int = 0
		select @existe = EstrategiaProductoId
		from EstrategiaProducto
		where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
		set @existe = isnull(@existe, 0)
	
		-- select * from EstrategiaProducto
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
				)
	
				set @Retorno = @@IDENTITY
		end
		else
		begin
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
			where EstrategiaProductoId = @existe
			set @Retorno = @existe
		end
	end
GO
/*END*/
GO

USE BelcorpPuertoRico
GO

GO
ALTER PROCEDURE dbo.InsertEstrategiaProducto
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
	AS
	begin
	
		declare @existe int = 0
		select @existe = EstrategiaProductoId
		from EstrategiaProducto
		where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
		set @existe = isnull(@existe, 0)
	
		-- select * from EstrategiaProducto
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
				)
	
				set @Retorno = @@IDENTITY
		end
		else
		begin
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
			where EstrategiaProductoId = @existe
			set @Retorno = @existe
		end
	end
GO
/*END*/
GO

USE BelcorpPanama
GO

GO
ALTER PROCEDURE dbo.InsertEstrategiaProducto
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
	AS
	begin
	
		declare @existe int = 0
		select @existe = EstrategiaProductoId
		from EstrategiaProducto
		where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
		set @existe = isnull(@existe, 0)
	
		-- select * from EstrategiaProducto
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
				)
	
				set @Retorno = @@IDENTITY
		end
		else
		begin
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
			where EstrategiaProductoId = @existe
			set @Retorno = @existe
		end
	end
GO
/*END*/
GO

USE BelcorpGuatemala
GO

GO
ALTER PROCEDURE dbo.InsertEstrategiaProducto
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
	AS
	begin
	
		declare @existe int = 0
		select @existe = EstrategiaProductoId
		from EstrategiaProducto
		where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
		set @existe = isnull(@existe, 0)
	
		-- select * from EstrategiaProducto
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
				)
	
				set @Retorno = @@IDENTITY
		end
		else
		begin
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
			where EstrategiaProductoId = @existe
			set @Retorno = @existe
		end
	end
GO
/*END*/
GO

USE BelcorpEcuador
GO

GO
ALTER PROCEDURE dbo.InsertEstrategiaProducto
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
	AS
	begin
	
		declare @existe int = 0
		select @existe = EstrategiaProductoId
		from EstrategiaProducto
		where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
		set @existe = isnull(@existe, 0)
	
		-- select * from EstrategiaProducto
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
				)
	
				set @Retorno = @@IDENTITY
		end
		else
		begin
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
			where EstrategiaProductoId = @existe
			set @Retorno = @existe
		end
	end
GO
/*END*/
GO

USE BelcorpDominicana
GO

GO
ALTER PROCEDURE dbo.InsertEstrategiaProducto
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
	AS
	begin
	
		declare @existe int = 0
		select @existe = EstrategiaProductoId
		from EstrategiaProducto
		where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
		set @existe = isnull(@existe, 0)
	
		-- select * from EstrategiaProducto
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
				)
	
				set @Retorno = @@IDENTITY
		end
		else
		begin
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
			where EstrategiaProductoId = @existe
			set @Retorno = @existe
		end
	end
GO
/*END*/
GO

USE BelcorpCostaRica
GO

GO
ALTER PROCEDURE dbo.InsertEstrategiaProducto
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
	AS
	begin
	
		declare @existe int = 0
		select @existe = EstrategiaProductoId
		from EstrategiaProducto
		where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
		set @existe = isnull(@existe, 0)
	
		-- select * from EstrategiaProducto
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
				)
	
				set @Retorno = @@IDENTITY
		end
		else
		begin
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
			where EstrategiaProductoId = @existe
			set @Retorno = @existe
		end
	end
GO
/*END*/
GO

USE BelcorpChile
GO

GO
ALTER PROCEDURE dbo.InsertEstrategiaProducto
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
	AS
	begin
	
		declare @existe int = 0
		select @existe = EstrategiaProductoId
		from EstrategiaProducto
		where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
		set @existe = isnull(@existe, 0)
	
		-- select * from EstrategiaProducto
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
				)
	
				set @Retorno = @@IDENTITY
		end
		else
		begin
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
			where EstrategiaProductoId = @existe
			set @Retorno = @existe
		end
	end
GO
/*END*/
GO

USE BelcorpBolivia
GO

GO
ALTER PROCEDURE dbo.InsertEstrategiaProducto
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
	AS
	begin
	
		declare @existe int = 0
		select @existe = EstrategiaProductoId
		from EstrategiaProducto
		where CUV2 = @CUV2 and CUV = @CUV AND EstrategiaID = @EstrategiaId
		
		set @existe = isnull(@existe, 0)
	
		-- select * from EstrategiaProducto
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
				)
	
				set @Retorno = @@IDENTITY
		end
		else
		begin
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
			where EstrategiaProductoId = @existe
			set @Retorno = @existe
		end
	end
GO
/*END*/
GO

