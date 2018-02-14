
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
	,@Descripcion1 nvarchar(255)
	,@ImagenProducto nvarchar(150)
	,@MarcaId tinyint
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
					,FactorCuadre
					,NombreProducto
					,Descripcion1,
					,ImagenProducto,
					,MarcaId
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
					,@Descripcion1,
					,@ImagenProducto,
					,@MarcaId
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
					,FactorCuadre = @FactorCuadre
					,NombreProducto = @NombreProducto
					,Descripcion1 = @Descripcion1
					,ImagenProducto = @ImagenProducto
					,MarcaId = @MarcaId
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
	,@Descripcion1 nvarchar(255)
	,@ImagenProducto nvarchar(150)
	,@MarcaId tinyint
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
					,FactorCuadre
					,NombreProducto
					,Descripcion1,
					,ImagenProducto,
					,MarcaId
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
					,@Descripcion1,
					,@ImagenProducto,
					,@MarcaId
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
					,FactorCuadre = @FactorCuadre
					,NombreProducto = @NombreProducto
					,Descripcion1 = @Descripcion1
					,ImagenProducto = @ImagenProducto
					,MarcaId = @MarcaId
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
	,@Descripcion1 nvarchar(255)
	,@ImagenProducto nvarchar(150)
	,@MarcaId tinyint
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
					,FactorCuadre
					,NombreProducto
					,Descripcion1,
					,ImagenProducto,
					,MarcaId
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
					,@Descripcion1,
					,@ImagenProducto,
					,@MarcaId
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
					,FactorCuadre = @FactorCuadre
					,NombreProducto = @NombreProducto
					,Descripcion1 = @Descripcion1
					,ImagenProducto = @ImagenProducto
					,MarcaId = @MarcaId
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
	,@Descripcion1 nvarchar(255)
	,@ImagenProducto nvarchar(150)
	,@MarcaId tinyint
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
					,FactorCuadre
					,NombreProducto
					,Descripcion1,
					,ImagenProducto,
					,MarcaId
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
					,@Descripcion1,
					,@ImagenProducto,
					,@MarcaId
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
					,FactorCuadre = @FactorCuadre
					,NombreProducto = @NombreProducto
					,Descripcion1 = @Descripcion1
					,ImagenProducto = @ImagenProducto
					,MarcaId = @MarcaId
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
	,@Descripcion1 nvarchar(255)
	,@ImagenProducto nvarchar(150)
	,@MarcaId tinyint
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
					,FactorCuadre
					,NombreProducto
					,Descripcion1,
					,ImagenProducto,
					,MarcaId
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
					,@Descripcion1,
					,@ImagenProducto,
					,@MarcaId
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
					,FactorCuadre = @FactorCuadre
					,NombreProducto = @NombreProducto
					,Descripcion1 = @Descripcion1
					,ImagenProducto = @ImagenProducto
					,MarcaId = @MarcaId
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
	,@Descripcion1 nvarchar(255)
	,@ImagenProducto nvarchar(150)
	,@MarcaId tinyint
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
					,FactorCuadre
					,NombreProducto
					,Descripcion1,
					,ImagenProducto,
					,MarcaId
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
					,@Descripcion1,
					,@ImagenProducto,
					,@MarcaId
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
					,FactorCuadre = @FactorCuadre
					,NombreProducto = @NombreProducto
					,Descripcion1 = @Descripcion1
					,ImagenProducto = @ImagenProducto
					,MarcaId = @MarcaId
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
	,@Descripcion1 nvarchar(255)
	,@ImagenProducto nvarchar(150)
	,@MarcaId tinyint
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
					,FactorCuadre
					,NombreProducto
					,Descripcion1,
					,ImagenProducto,
					,MarcaId
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
					,@Descripcion1,
					,@ImagenProducto,
					,@MarcaId
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
					,FactorCuadre = @FactorCuadre
					,NombreProducto = @NombreProducto
					,Descripcion1 = @Descripcion1
					,ImagenProducto = @ImagenProducto
					,MarcaId = @MarcaId
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
	,@Descripcion1 nvarchar(255)
	,@ImagenProducto nvarchar(150)
	,@MarcaId tinyint
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
					,FactorCuadre
					,NombreProducto
					,Descripcion1,
					,ImagenProducto,
					,MarcaId
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
					,@Descripcion1,
					,@ImagenProducto,
					,@MarcaId
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
					,FactorCuadre = @FactorCuadre
					,NombreProducto = @NombreProducto
					,Descripcion1 = @Descripcion1
					,ImagenProducto = @ImagenProducto
					,MarcaId = @MarcaId
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
	,@Descripcion1 nvarchar(255)
	,@ImagenProducto nvarchar(150)
	,@MarcaId tinyint
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
					,FactorCuadre
					,NombreProducto
					,Descripcion1,
					,ImagenProducto,
					,MarcaId
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
					,@Descripcion1,
					,@ImagenProducto,
					,@MarcaId
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
					,FactorCuadre = @FactorCuadre
					,NombreProducto = @NombreProducto
					,Descripcion1 = @Descripcion1
					,ImagenProducto = @ImagenProducto
					,MarcaId = @MarcaId
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
	,@Descripcion1 nvarchar(255)
	,@ImagenProducto nvarchar(150)
	,@MarcaId tinyint
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
					,FactorCuadre
					,NombreProducto
					,Descripcion1,
					,ImagenProducto,
					,MarcaId
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
					,@Descripcion1,
					,@ImagenProducto,
					,@MarcaId
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
					,FactorCuadre = @FactorCuadre
					,NombreProducto = @NombreProducto
					,Descripcion1 = @Descripcion1
					,ImagenProducto = @ImagenProducto
					,MarcaId = @MarcaId
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
	,@Descripcion1 nvarchar(255)
	,@ImagenProducto nvarchar(150)
	,@MarcaId tinyint
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
					,FactorCuadre
					,NombreProducto
					,Descripcion1,
					,ImagenProducto,
					,MarcaId
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
					,@Descripcion1,
					,@ImagenProducto,
					,@MarcaId
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
					,FactorCuadre = @FactorCuadre
					,NombreProducto = @NombreProducto
					,Descripcion1 = @Descripcion1
					,ImagenProducto = @ImagenProducto
					,MarcaId = @MarcaId
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
	,@Descripcion1 nvarchar(255)
	,@ImagenProducto nvarchar(150)
	,@MarcaId tinyint
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
					,FactorCuadre
					,NombreProducto
					,Descripcion1,
					,ImagenProducto,
					,MarcaId
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
					,@Descripcion1,
					,@ImagenProducto,
					,@MarcaId
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
					,FactorCuadre = @FactorCuadre
					,NombreProducto = @NombreProducto
					,Descripcion1 = @Descripcion1
					,ImagenProducto = @ImagenProducto
					,MarcaId = @MarcaId
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
	,@Descripcion1 nvarchar(255)
	,@ImagenProducto nvarchar(150)
	,@MarcaId tinyint
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
					,FactorCuadre
					,NombreProducto
					,Descripcion1,
					,ImagenProducto,
					,MarcaId
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
					,@Descripcion1,
					,@ImagenProducto,
					,@MarcaId
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
					,FactorCuadre = @FactorCuadre
					,NombreProducto = @NombreProducto
					,Descripcion1 = @Descripcion1
					,ImagenProducto = @ImagenProducto
					,MarcaId = @MarcaId
			where EstrategiaProductoId = @existe
			set @Retorno = @existe
		end
	end

GO


