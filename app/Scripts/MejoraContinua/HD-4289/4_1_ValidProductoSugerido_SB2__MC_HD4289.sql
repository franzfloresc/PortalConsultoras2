GO
USE [BelcorpBolivia]
GO


ALTER PROCEDURE [dbo].[ValidProductoSugerido_SB2]
(
	 @Return varchar(1000) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@Usuario varchar(50)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
)
AS
BEGIN
	set @Return = ''
	
	set @ProductoSugeridoID = isnull(@ProductoSugeridoID, 0)
	set @CampaniaID = isnull(@CampaniaID, '')
	set @CUV = isnull(@CUV, '')
	set @CUVSugerido = isnull(@CUVSugerido, '')
	set @Orden = isnull(@Orden, '')
	set @ImagenProducto = isnull(@ImagenProducto, '')
	set @Estado = isnull(@Estado,-1)
	set @Usuario = isnull(@Usuario, '')

	if @ProductoSugeridoID <= 0 
		set @ProductoSugeridoID = 0
	if @Estado < 0 
		set @Estado = -1

	-- Que se hayan ingresado todos los datos
	if @CampaniaID = '' or @CUV = '' or @CUVSugerido = '' or @Orden = '' or @Estado = -1
	begin
		set @Return = '-1|La información ingresada se encuentra incompleta. Por favor, revisar.'	
		return 0
	end

	-- Que el CUV Agotado exista para la campaña y que sea digitable.
	declare @digita int = -1, @activo int = -1
	
	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUV

	set @digita = isnull(@digita, -1)
	if @digita = -1 or @digita = 0
	begin
		set @Return = '-2|El CUV Agotado no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido exista para la campaña, sea digitable y se encuentre activo.	
	set @digita = -1	
	set @activo = -1

	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUVSugerido
	
	set @digita = isnull(@digita, -1)
	set @activo = isnull(@activo, -1)
	if @digita = -1 or @digita = 0 or @activo = -1 or @activo = 0
	begin
		set @Return = '-3|El CUV Sugerido no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido no esté como faltante anunciado ni como producto faltante.
	set @activo = 1

	select @activo= count(1)
	from dbo.productofaltante
	where  CampaniaID = @CampaniaID
		and cuv = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'
		return 0
	end

	set @activo = 1
	select @activo= count(1)
	from ods.faltanteanunciado fa
		inner join ods.campania c on c.CampaniaID = fa.CampaniaID
	where c.Codigo = @CampaniaID
		and  fa.codigoVenta = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'		
		return 0
	end

	-- Que el CUV Sugerido sea diferente al CUV Agotado
	if @CUV = @CUVSugerido
	begin
		set @Return = '-5|El CUV Sugerido debe ser diferente al CUV Agotado.'
		return 0
	end

	-- Que no se haya cargado previamente el mismo CUV Sugerido para el mismo CUV Agotado
	set @activo = 0

	select @activo = ProductoSugeridoID
	-- select *
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		and ps.CUVSugerido = @CUVSugerido
		and ps.Estado = 1
		and ps.RegionID=@RegionID --/* HD-4289 */
		and ps.ZonaID=@ZonaID --/* HD-4289 */
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0 )
	begin
		set @Return = '-6|El CUV Sugerido ya fue cargado previamente al mismo CUV Agotado.'
		return 0
	end

	-- Que el orden ingresado para el CUV sugerido, no esté siendo utilizado para un mismo CUV agotado.
	set @activo = 0

	select @activo = ProductoSugeridoID
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		--and ps.CUVSugerido = @CUVSugerido
		and ps.Orden = @Orden
		and ps.Estado = 1
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0)
	begin
		set @Return = '-7|El orden ingresado ya existe para el CUV Agotado configurado.'
		return 0
	end

	-- Que se haya seleccionado una foto
	if @ImagenProducto = '' 
	begin
		set @Return = '-8|No se ha seleccionado ninguna foto.'
		return 0
	end

	-- Productos con reemplazos configurados por campaña
	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		declare @id int = 0
		select @id = min(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		declare @cant int = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantProd int = 0
		select @cantProd = count(1)
			from (
			select CampaniaID, CUV
			from productoSugerido ps
			where ps.CampaniaID = @CampaniaID
			and ps.Estado = 1
			group by CampaniaID, CUV
		) as t			
					
		if ( @cant <= @cantProd and @ProductoSugeridoID = 0 )
		begin
			set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
			return 0
		end

		if @ProductoSugeridoID > 0
		begin 
					
			
			declare @cantProdDif int = 0
			select @cantProdDif = count(1)
			from (
				select CampaniaID, CUV
				from productoSugerido ps
				where ps.CampaniaID = @CampaniaID
				and ps.Estado = 1
				and ps.CUV != @CUV
				and ps.ProductoSugeridoID != @ProductoSugeridoID
				group by CampaniaID, CUV
			) as t

					
			if ( @cant <= @cantProdDif and @ProductoSugeridoID > 0 )
			begin
				set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
				return 0
			end

		end -- if @ProductoSugeridoID > 0

		
		
	end


	-- Reemplazos configurados por producto por campaña

	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		set @id = 0
		select @id = max(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		set @cant = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantSug int = 0
		declare @cantSugDif int = 0

		select @cantSug = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1	
		
		select @cantSugDif = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1
		and ProductoSugeridoID != @ProductoSugeridoID			
			
		if (@cant <= @cantSug and @ProductoSugeridoID = 0 ) or ( @cant <= @cantSugDif and @ProductoSugeridoID > 0 )
		begin
			set @Return = '-10|Ya se registró la cantidad máxima de sugerencias de reemplazo para este producto en la campaña.'
			return 0
		end
	end
END

GO
USE [BelcorpChile]
GO


ALTER PROCEDURE [dbo].[ValidProductoSugerido_SB2]
(
	 @Return varchar(1000) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@Usuario varchar(50)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
)
AS
BEGIN
	set @Return = ''
	
	set @ProductoSugeridoID = isnull(@ProductoSugeridoID, 0)
	set @CampaniaID = isnull(@CampaniaID, '')
	set @CUV = isnull(@CUV, '')
	set @CUVSugerido = isnull(@CUVSugerido, '')
	set @Orden = isnull(@Orden, '')
	set @ImagenProducto = isnull(@ImagenProducto, '')
	set @Estado = isnull(@Estado,-1)
	set @Usuario = isnull(@Usuario, '')

	if @ProductoSugeridoID <= 0 
		set @ProductoSugeridoID = 0
	if @Estado < 0 
		set @Estado = -1

	-- Que se hayan ingresado todos los datos
	if @CampaniaID = '' or @CUV = '' or @CUVSugerido = '' or @Orden = '' or @Estado = -1
	begin
		set @Return = '-1|La información ingresada se encuentra incompleta. Por favor, revisar.'	
		return 0
	end

	-- Que el CUV Agotado exista para la campaña y que sea digitable.
	declare @digita int = -1, @activo int = -1
	
	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUV

	set @digita = isnull(@digita, -1)
	if @digita = -1 or @digita = 0
	begin
		set @Return = '-2|El CUV Agotado no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido exista para la campaña, sea digitable y se encuentre activo.	
	set @digita = -1	
	set @activo = -1

	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUVSugerido
	
	set @digita = isnull(@digita, -1)
	set @activo = isnull(@activo, -1)
	if @digita = -1 or @digita = 0 or @activo = -1 or @activo = 0
	begin
		set @Return = '-3|El CUV Sugerido no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido no esté como faltante anunciado ni como producto faltante.
	set @activo = 1

	select @activo= count(1)
	from dbo.productofaltante
	where  CampaniaID = @CampaniaID
		and cuv = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'
		return 0
	end

	set @activo = 1
	select @activo= count(1)
	from ods.faltanteanunciado fa
		inner join ods.campania c on c.CampaniaID = fa.CampaniaID
	where c.Codigo = @CampaniaID
		and  fa.codigoVenta = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'		
		return 0
	end

	-- Que el CUV Sugerido sea diferente al CUV Agotado
	if @CUV = @CUVSugerido
	begin
		set @Return = '-5|El CUV Sugerido debe ser diferente al CUV Agotado.'
		return 0
	end

	-- Que no se haya cargado previamente el mismo CUV Sugerido para el mismo CUV Agotado
	set @activo = 0

	select @activo = ProductoSugeridoID
	-- select *
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		and ps.CUVSugerido = @CUVSugerido
		and ps.Estado = 1
		and ps.RegionID=@RegionID --/* HD-4289 */
		and ps.ZonaID=@ZonaID --/* HD-4289 */
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0 )
	begin
		set @Return = '-6|El CUV Sugerido ya fue cargado previamente al mismo CUV Agotado.'
		return 0
	end

	-- Que el orden ingresado para el CUV sugerido, no esté siendo utilizado para un mismo CUV agotado.
	set @activo = 0

	select @activo = ProductoSugeridoID
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		--and ps.CUVSugerido = @CUVSugerido
		and ps.Orden = @Orden
		and ps.Estado = 1
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0)
	begin
		set @Return = '-7|El orden ingresado ya existe para el CUV Agotado configurado.'
		return 0
	end

	-- Que se haya seleccionado una foto
	if @ImagenProducto = '' 
	begin
		set @Return = '-8|No se ha seleccionado ninguna foto.'
		return 0
	end

	-- Productos con reemplazos configurados por campaña
	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		declare @id int = 0
		select @id = min(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		declare @cant int = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantProd int = 0
		select @cantProd = count(1)
			from (
			select CampaniaID, CUV
			from productoSugerido ps
			where ps.CampaniaID = @CampaniaID
			and ps.Estado = 1
			group by CampaniaID, CUV
		) as t			
					
		if ( @cant <= @cantProd and @ProductoSugeridoID = 0 )
		begin
			set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
			return 0
		end

		if @ProductoSugeridoID > 0
		begin 
					
			
			declare @cantProdDif int = 0
			select @cantProdDif = count(1)
			from (
				select CampaniaID, CUV
				from productoSugerido ps
				where ps.CampaniaID = @CampaniaID
				and ps.Estado = 1
				and ps.CUV != @CUV
				and ps.ProductoSugeridoID != @ProductoSugeridoID
				group by CampaniaID, CUV
			) as t

					
			if ( @cant <= @cantProdDif and @ProductoSugeridoID > 0 )
			begin
				set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
				return 0
			end

		end -- if @ProductoSugeridoID > 0

		
		
	end


	-- Reemplazos configurados por producto por campaña

	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		set @id = 0
		select @id = max(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		set @cant = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantSug int = 0
		declare @cantSugDif int = 0

		select @cantSug = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1	
		
		select @cantSugDif = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1
		and ProductoSugeridoID != @ProductoSugeridoID			
			
		if (@cant <= @cantSug and @ProductoSugeridoID = 0 ) or ( @cant <= @cantSugDif and @ProductoSugeridoID > 0 )
		begin
			set @Return = '-10|Ya se registró la cantidad máxima de sugerencias de reemplazo para este producto en la campaña.'
			return 0
		end
	end
END

GO
USE [BelcorpColombia]
GO


ALTER PROCEDURE [dbo].[ValidProductoSugerido_SB2]
(
	 @Return varchar(1000) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@Usuario varchar(50)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
)
AS
BEGIN
	set @Return = ''
	
	set @ProductoSugeridoID = isnull(@ProductoSugeridoID, 0)
	set @CampaniaID = isnull(@CampaniaID, '')
	set @CUV = isnull(@CUV, '')
	set @CUVSugerido = isnull(@CUVSugerido, '')
	set @Orden = isnull(@Orden, '')
	set @ImagenProducto = isnull(@ImagenProducto, '')
	set @Estado = isnull(@Estado,-1)
	set @Usuario = isnull(@Usuario, '')

	if @ProductoSugeridoID <= 0 
		set @ProductoSugeridoID = 0
	if @Estado < 0 
		set @Estado = -1

	-- Que se hayan ingresado todos los datos
	if @CampaniaID = '' or @CUV = '' or @CUVSugerido = '' or @Orden = '' or @Estado = -1
	begin
		set @Return = '-1|La información ingresada se encuentra incompleta. Por favor, revisar.'	
		return 0
	end

	-- Que el CUV Agotado exista para la campaña y que sea digitable.
	declare @digita int = -1, @activo int = -1
	
	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUV

	set @digita = isnull(@digita, -1)
	if @digita = -1 or @digita = 0
	begin
		set @Return = '-2|El CUV Agotado no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido exista para la campaña, sea digitable y se encuentre activo.	
	set @digita = -1	
	set @activo = -1

	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUVSugerido
	
	set @digita = isnull(@digita, -1)
	set @activo = isnull(@activo, -1)
	if @digita = -1 or @digita = 0 or @activo = -1 or @activo = 0
	begin
		set @Return = '-3|El CUV Sugerido no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido no esté como faltante anunciado ni como producto faltante.
	set @activo = 1

	select @activo= count(1)
	from dbo.productofaltante
	where  CampaniaID = @CampaniaID
		and cuv = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'
		return 0
	end

	set @activo = 1
	select @activo= count(1)
	from ods.faltanteanunciado fa
		inner join ods.campania c on c.CampaniaID = fa.CampaniaID
	where c.Codigo = @CampaniaID
		and  fa.codigoVenta = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'		
		return 0
	end

	-- Que el CUV Sugerido sea diferente al CUV Agotado
	if @CUV = @CUVSugerido
	begin
		set @Return = '-5|El CUV Sugerido debe ser diferente al CUV Agotado.'
		return 0
	end

	-- Que no se haya cargado previamente el mismo CUV Sugerido para el mismo CUV Agotado
	set @activo = 0

	select @activo = ProductoSugeridoID
	-- select *
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		and ps.CUVSugerido = @CUVSugerido
		and ps.Estado = 1
		and ps.RegionID=@RegionID --/* HD-4289 */
		and ps.ZonaID=@ZonaID --/* HD-4289 */
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0 )
	begin
		set @Return = '-6|El CUV Sugerido ya fue cargado previamente al mismo CUV Agotado.'
		return 0
	end

	-- Que el orden ingresado para el CUV sugerido, no esté siendo utilizado para un mismo CUV agotado.
	set @activo = 0

	select @activo = ProductoSugeridoID
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		--and ps.CUVSugerido = @CUVSugerido
		and ps.Orden = @Orden
		and ps.Estado = 1
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0)
	begin
		set @Return = '-7|El orden ingresado ya existe para el CUV Agotado configurado.'
		return 0
	end

	-- Que se haya seleccionado una foto
	if @ImagenProducto = '' 
	begin
		set @Return = '-8|No se ha seleccionado ninguna foto.'
		return 0
	end

	-- Productos con reemplazos configurados por campaña
	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		declare @id int = 0
		select @id = min(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		declare @cant int = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantProd int = 0
		select @cantProd = count(1)
			from (
			select CampaniaID, CUV
			from productoSugerido ps
			where ps.CampaniaID = @CampaniaID
			and ps.Estado = 1
			group by CampaniaID, CUV
		) as t			
					
		if ( @cant <= @cantProd and @ProductoSugeridoID = 0 )
		begin
			set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
			return 0
		end

		if @ProductoSugeridoID > 0
		begin 
					
			
			declare @cantProdDif int = 0
			select @cantProdDif = count(1)
			from (
				select CampaniaID, CUV
				from productoSugerido ps
				where ps.CampaniaID = @CampaniaID
				and ps.Estado = 1
				and ps.CUV != @CUV
				and ps.ProductoSugeridoID != @ProductoSugeridoID
				group by CampaniaID, CUV
			) as t

					
			if ( @cant <= @cantProdDif and @ProductoSugeridoID > 0 )
			begin
				set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
				return 0
			end

		end -- if @ProductoSugeridoID > 0

		
		
	end


	-- Reemplazos configurados por producto por campaña

	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		set @id = 0
		select @id = max(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		set @cant = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantSug int = 0
		declare @cantSugDif int = 0

		select @cantSug = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1	
		
		select @cantSugDif = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1
		and ProductoSugeridoID != @ProductoSugeridoID			
			
		if (@cant <= @cantSug and @ProductoSugeridoID = 0 ) or ( @cant <= @cantSugDif and @ProductoSugeridoID > 0 )
		begin
			set @Return = '-10|Ya se registró la cantidad máxima de sugerencias de reemplazo para este producto en la campaña.'
			return 0
		end
	end
END

GO
USE [BelcorpCostaRica]
GO


ALTER PROCEDURE [dbo].[ValidProductoSugerido_SB2]
(
	 @Return varchar(1000) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@Usuario varchar(50)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
)
AS
BEGIN
	set @Return = ''
	
	set @ProductoSugeridoID = isnull(@ProductoSugeridoID, 0)
	set @CampaniaID = isnull(@CampaniaID, '')
	set @CUV = isnull(@CUV, '')
	set @CUVSugerido = isnull(@CUVSugerido, '')
	set @Orden = isnull(@Orden, '')
	set @ImagenProducto = isnull(@ImagenProducto, '')
	set @Estado = isnull(@Estado,-1)
	set @Usuario = isnull(@Usuario, '')

	if @ProductoSugeridoID <= 0 
		set @ProductoSugeridoID = 0
	if @Estado < 0 
		set @Estado = -1

	-- Que se hayan ingresado todos los datos
	if @CampaniaID = '' or @CUV = '' or @CUVSugerido = '' or @Orden = '' or @Estado = -1
	begin
		set @Return = '-1|La información ingresada se encuentra incompleta. Por favor, revisar.'	
		return 0
	end

	-- Que el CUV Agotado exista para la campaña y que sea digitable.
	declare @digita int = -1, @activo int = -1
	
	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUV

	set @digita = isnull(@digita, -1)
	if @digita = -1 or @digita = 0
	begin
		set @Return = '-2|El CUV Agotado no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido exista para la campaña, sea digitable y se encuentre activo.	
	set @digita = -1	
	set @activo = -1

	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUVSugerido
	
	set @digita = isnull(@digita, -1)
	set @activo = isnull(@activo, -1)
	if @digita = -1 or @digita = 0 or @activo = -1 or @activo = 0
	begin
		set @Return = '-3|El CUV Sugerido no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido no esté como faltante anunciado ni como producto faltante.
	set @activo = 1

	select @activo= count(1)
	from dbo.productofaltante
	where  CampaniaID = @CampaniaID
		and cuv = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'
		return 0
	end

	set @activo = 1
	select @activo= count(1)
	from ods.faltanteanunciado fa
		inner join ods.campania c on c.CampaniaID = fa.CampaniaID
	where c.Codigo = @CampaniaID
		and  fa.codigoVenta = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'		
		return 0
	end

	-- Que el CUV Sugerido sea diferente al CUV Agotado
	if @CUV = @CUVSugerido
	begin
		set @Return = '-5|El CUV Sugerido debe ser diferente al CUV Agotado.'
		return 0
	end

	-- Que no se haya cargado previamente el mismo CUV Sugerido para el mismo CUV Agotado
	set @activo = 0

	select @activo = ProductoSugeridoID
	-- select *
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		and ps.CUVSugerido = @CUVSugerido
		and ps.Estado = 1
		and ps.RegionID=@RegionID --/* HD-4289 */
		and ps.ZonaID=@ZonaID --/* HD-4289 */
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0 )
	begin
		set @Return = '-6|El CUV Sugerido ya fue cargado previamente al mismo CUV Agotado.'
		return 0
	end

	-- Que el orden ingresado para el CUV sugerido, no esté siendo utilizado para un mismo CUV agotado.
	set @activo = 0

	select @activo = ProductoSugeridoID
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		--and ps.CUVSugerido = @CUVSugerido
		and ps.Orden = @Orden
		and ps.Estado = 1
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0)
	begin
		set @Return = '-7|El orden ingresado ya existe para el CUV Agotado configurado.'
		return 0
	end

	-- Que se haya seleccionado una foto
	if @ImagenProducto = '' 
	begin
		set @Return = '-8|No se ha seleccionado ninguna foto.'
		return 0
	end

	-- Productos con reemplazos configurados por campaña
	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		declare @id int = 0
		select @id = min(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		declare @cant int = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantProd int = 0
		select @cantProd = count(1)
			from (
			select CampaniaID, CUV
			from productoSugerido ps
			where ps.CampaniaID = @CampaniaID
			and ps.Estado = 1
			group by CampaniaID, CUV
		) as t			
					
		if ( @cant <= @cantProd and @ProductoSugeridoID = 0 )
		begin
			set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
			return 0
		end

		if @ProductoSugeridoID > 0
		begin 
					
			
			declare @cantProdDif int = 0
			select @cantProdDif = count(1)
			from (
				select CampaniaID, CUV
				from productoSugerido ps
				where ps.CampaniaID = @CampaniaID
				and ps.Estado = 1
				and ps.CUV != @CUV
				and ps.ProductoSugeridoID != @ProductoSugeridoID
				group by CampaniaID, CUV
			) as t

					
			if ( @cant <= @cantProdDif and @ProductoSugeridoID > 0 )
			begin
				set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
				return 0
			end

		end -- if @ProductoSugeridoID > 0

		
		
	end


	-- Reemplazos configurados por producto por campaña

	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		set @id = 0
		select @id = max(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		set @cant = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantSug int = 0
		declare @cantSugDif int = 0

		select @cantSug = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1	
		
		select @cantSugDif = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1
		and ProductoSugeridoID != @ProductoSugeridoID			
			
		if (@cant <= @cantSug and @ProductoSugeridoID = 0 ) or ( @cant <= @cantSugDif and @ProductoSugeridoID > 0 )
		begin
			set @Return = '-10|Ya se registró la cantidad máxima de sugerencias de reemplazo para este producto en la campaña.'
			return 0
		end
	end
END

GO
USE [BelcorpDominicana]
GO


ALTER PROCEDURE [dbo].[ValidProductoSugerido_SB2]
(
	 @Return varchar(1000) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@Usuario varchar(50)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
)
AS
BEGIN
	set @Return = ''
	
	set @ProductoSugeridoID = isnull(@ProductoSugeridoID, 0)
	set @CampaniaID = isnull(@CampaniaID, '')
	set @CUV = isnull(@CUV, '')
	set @CUVSugerido = isnull(@CUVSugerido, '')
	set @Orden = isnull(@Orden, '')
	set @ImagenProducto = isnull(@ImagenProducto, '')
	set @Estado = isnull(@Estado,-1)
	set @Usuario = isnull(@Usuario, '')

	if @ProductoSugeridoID <= 0 
		set @ProductoSugeridoID = 0
	if @Estado < 0 
		set @Estado = -1

	-- Que se hayan ingresado todos los datos
	if @CampaniaID = '' or @CUV = '' or @CUVSugerido = '' or @Orden = '' or @Estado = -1
	begin
		set @Return = '-1|La información ingresada se encuentra incompleta. Por favor, revisar.'	
		return 0
	end

	-- Que el CUV Agotado exista para la campaña y que sea digitable.
	declare @digita int = -1, @activo int = -1
	
	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUV

	set @digita = isnull(@digita, -1)
	if @digita = -1 or @digita = 0
	begin
		set @Return = '-2|El CUV Agotado no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido exista para la campaña, sea digitable y se encuentre activo.	
	set @digita = -1	
	set @activo = -1

	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUVSugerido
	
	set @digita = isnull(@digita, -1)
	set @activo = isnull(@activo, -1)
	if @digita = -1 or @digita = 0 or @activo = -1 or @activo = 0
	begin
		set @Return = '-3|El CUV Sugerido no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido no esté como faltante anunciado ni como producto faltante.
	set @activo = 1

	select @activo= count(1)
	from dbo.productofaltante
	where  CampaniaID = @CampaniaID
		and cuv = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'
		return 0
	end

	set @activo = 1
	select @activo= count(1)
	from ods.faltanteanunciado fa
		inner join ods.campania c on c.CampaniaID = fa.CampaniaID
	where c.Codigo = @CampaniaID
		and  fa.codigoVenta = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'		
		return 0
	end

	-- Que el CUV Sugerido sea diferente al CUV Agotado
	if @CUV = @CUVSugerido
	begin
		set @Return = '-5|El CUV Sugerido debe ser diferente al CUV Agotado.'
		return 0
	end

	-- Que no se haya cargado previamente el mismo CUV Sugerido para el mismo CUV Agotado
	set @activo = 0

	select @activo = ProductoSugeridoID
	-- select *
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		and ps.CUVSugerido = @CUVSugerido
		and ps.Estado = 1
		and ps.RegionID=@RegionID --/* HD-4289 */
		and ps.ZonaID=@ZonaID --/* HD-4289 */
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0 )
	begin
		set @Return = '-6|El CUV Sugerido ya fue cargado previamente al mismo CUV Agotado.'
		return 0
	end

	-- Que el orden ingresado para el CUV sugerido, no esté siendo utilizado para un mismo CUV agotado.
	set @activo = 0

	select @activo = ProductoSugeridoID
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		--and ps.CUVSugerido = @CUVSugerido
		and ps.Orden = @Orden
		and ps.Estado = 1
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0)
	begin
		set @Return = '-7|El orden ingresado ya existe para el CUV Agotado configurado.'
		return 0
	end

	-- Que se haya seleccionado una foto
	if @ImagenProducto = '' 
	begin
		set @Return = '-8|No se ha seleccionado ninguna foto.'
		return 0
	end

	-- Productos con reemplazos configurados por campaña
	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		declare @id int = 0
		select @id = min(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		declare @cant int = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantProd int = 0
		select @cantProd = count(1)
			from (
			select CampaniaID, CUV
			from productoSugerido ps
			where ps.CampaniaID = @CampaniaID
			and ps.Estado = 1
			group by CampaniaID, CUV
		) as t			
					
		if ( @cant <= @cantProd and @ProductoSugeridoID = 0 )
		begin
			set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
			return 0
		end

		if @ProductoSugeridoID > 0
		begin 
					
			
			declare @cantProdDif int = 0
			select @cantProdDif = count(1)
			from (
				select CampaniaID, CUV
				from productoSugerido ps
				where ps.CampaniaID = @CampaniaID
				and ps.Estado = 1
				and ps.CUV != @CUV
				and ps.ProductoSugeridoID != @ProductoSugeridoID
				group by CampaniaID, CUV
			) as t

					
			if ( @cant <= @cantProdDif and @ProductoSugeridoID > 0 )
			begin
				set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
				return 0
			end

		end -- if @ProductoSugeridoID > 0

		
		
	end


	-- Reemplazos configurados por producto por campaña

	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		set @id = 0
		select @id = max(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		set @cant = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantSug int = 0
		declare @cantSugDif int = 0

		select @cantSug = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1	
		
		select @cantSugDif = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1
		and ProductoSugeridoID != @ProductoSugeridoID			
			
		if (@cant <= @cantSug and @ProductoSugeridoID = 0 ) or ( @cant <= @cantSugDif and @ProductoSugeridoID > 0 )
		begin
			set @Return = '-10|Ya se registró la cantidad máxima de sugerencias de reemplazo para este producto en la campaña.'
			return 0
		end
	end
END

GO
USE [BelcorpEcuador]
GO


ALTER PROCEDURE [dbo].[ValidProductoSugerido_SB2]
(
	 @Return varchar(1000) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@Usuario varchar(50)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
)
AS
BEGIN
	set @Return = ''
	
	set @ProductoSugeridoID = isnull(@ProductoSugeridoID, 0)
	set @CampaniaID = isnull(@CampaniaID, '')
	set @CUV = isnull(@CUV, '')
	set @CUVSugerido = isnull(@CUVSugerido, '')
	set @Orden = isnull(@Orden, '')
	set @ImagenProducto = isnull(@ImagenProducto, '')
	set @Estado = isnull(@Estado,-1)
	set @Usuario = isnull(@Usuario, '')

	if @ProductoSugeridoID <= 0 
		set @ProductoSugeridoID = 0
	if @Estado < 0 
		set @Estado = -1

	-- Que se hayan ingresado todos los datos
	if @CampaniaID = '' or @CUV = '' or @CUVSugerido = '' or @Orden = '' or @Estado = -1
	begin
		set @Return = '-1|La información ingresada se encuentra incompleta. Por favor, revisar.'	
		return 0
	end

	-- Que el CUV Agotado exista para la campaña y que sea digitable.
	declare @digita int = -1, @activo int = -1
	
	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUV

	set @digita = isnull(@digita, -1)
	if @digita = -1 or @digita = 0
	begin
		set @Return = '-2|El CUV Agotado no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido exista para la campaña, sea digitable y se encuentre activo.	
	set @digita = -1	
	set @activo = -1

	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUVSugerido
	
	set @digita = isnull(@digita, -1)
	set @activo = isnull(@activo, -1)
	if @digita = -1 or @digita = 0 or @activo = -1 or @activo = 0
	begin
		set @Return = '-3|El CUV Sugerido no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido no esté como faltante anunciado ni como producto faltante.
	set @activo = 1

	select @activo= count(1)
	from dbo.productofaltante
	where  CampaniaID = @CampaniaID
		and cuv = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'
		return 0
	end

	set @activo = 1
	select @activo= count(1)
	from ods.faltanteanunciado fa
		inner join ods.campania c on c.CampaniaID = fa.CampaniaID
	where c.Codigo = @CampaniaID
		and  fa.codigoVenta = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'		
		return 0
	end

	-- Que el CUV Sugerido sea diferente al CUV Agotado
	if @CUV = @CUVSugerido
	begin
		set @Return = '-5|El CUV Sugerido debe ser diferente al CUV Agotado.'
		return 0
	end

	-- Que no se haya cargado previamente el mismo CUV Sugerido para el mismo CUV Agotado
	set @activo = 0

	select @activo = ProductoSugeridoID
	-- select *
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		and ps.CUVSugerido = @CUVSugerido
		and ps.Estado = 1
		and ps.RegionID=@RegionID --/* HD-4289 */
		and ps.ZonaID=@ZonaID --/* HD-4289 */
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0 )
	begin
		set @Return = '-6|El CUV Sugerido ya fue cargado previamente al mismo CUV Agotado.'
		return 0
	end

	-- Que el orden ingresado para el CUV sugerido, no esté siendo utilizado para un mismo CUV agotado.
	set @activo = 0

	select @activo = ProductoSugeridoID
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		--and ps.CUVSugerido = @CUVSugerido
		and ps.Orden = @Orden
		and ps.Estado = 1
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0)
	begin
		set @Return = '-7|El orden ingresado ya existe para el CUV Agotado configurado.'
		return 0
	end

	-- Que se haya seleccionado una foto
	if @ImagenProducto = '' 
	begin
		set @Return = '-8|No se ha seleccionado ninguna foto.'
		return 0
	end

	-- Productos con reemplazos configurados por campaña
	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		declare @id int = 0
		select @id = min(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		declare @cant int = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantProd int = 0
		select @cantProd = count(1)
			from (
			select CampaniaID, CUV
			from productoSugerido ps
			where ps.CampaniaID = @CampaniaID
			and ps.Estado = 1
			group by CampaniaID, CUV
		) as t			
					
		if ( @cant <= @cantProd and @ProductoSugeridoID = 0 )
		begin
			set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
			return 0
		end

		if @ProductoSugeridoID > 0
		begin 
					
			
			declare @cantProdDif int = 0
			select @cantProdDif = count(1)
			from (
				select CampaniaID, CUV
				from productoSugerido ps
				where ps.CampaniaID = @CampaniaID
				and ps.Estado = 1
				and ps.CUV != @CUV
				and ps.ProductoSugeridoID != @ProductoSugeridoID
				group by CampaniaID, CUV
			) as t

					
			if ( @cant <= @cantProdDif and @ProductoSugeridoID > 0 )
			begin
				set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
				return 0
			end

		end -- if @ProductoSugeridoID > 0

		
		
	end


	-- Reemplazos configurados por producto por campaña

	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		set @id = 0
		select @id = max(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		set @cant = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantSug int = 0
		declare @cantSugDif int = 0

		select @cantSug = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1	
		
		select @cantSugDif = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1
		and ProductoSugeridoID != @ProductoSugeridoID			
			
		if (@cant <= @cantSug and @ProductoSugeridoID = 0 ) or ( @cant <= @cantSugDif and @ProductoSugeridoID > 0 )
		begin
			set @Return = '-10|Ya se registró la cantidad máxima de sugerencias de reemplazo para este producto en la campaña.'
			return 0
		end
	end
END

GO
USE [BelcorpGuatemala]
GO


ALTER PROCEDURE [dbo].[ValidProductoSugerido_SB2]
(
	 @Return varchar(1000) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@Usuario varchar(50)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
)
AS
BEGIN
	set @Return = ''
	
	set @ProductoSugeridoID = isnull(@ProductoSugeridoID, 0)
	set @CampaniaID = isnull(@CampaniaID, '')
	set @CUV = isnull(@CUV, '')
	set @CUVSugerido = isnull(@CUVSugerido, '')
	set @Orden = isnull(@Orden, '')
	set @ImagenProducto = isnull(@ImagenProducto, '')
	set @Estado = isnull(@Estado,-1)
	set @Usuario = isnull(@Usuario, '')

	if @ProductoSugeridoID <= 0 
		set @ProductoSugeridoID = 0
	if @Estado < 0 
		set @Estado = -1

	-- Que se hayan ingresado todos los datos
	if @CampaniaID = '' or @CUV = '' or @CUVSugerido = '' or @Orden = '' or @Estado = -1
	begin
		set @Return = '-1|La información ingresada se encuentra incompleta. Por favor, revisar.'	
		return 0
	end

	-- Que el CUV Agotado exista para la campaña y que sea digitable.
	declare @digita int = -1, @activo int = -1
	
	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUV

	set @digita = isnull(@digita, -1)
	if @digita = -1 or @digita = 0
	begin
		set @Return = '-2|El CUV Agotado no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido exista para la campaña, sea digitable y se encuentre activo.	
	set @digita = -1	
	set @activo = -1

	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUVSugerido
	
	set @digita = isnull(@digita, -1)
	set @activo = isnull(@activo, -1)
	if @digita = -1 or @digita = 0 or @activo = -1 or @activo = 0
	begin
		set @Return = '-3|El CUV Sugerido no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido no esté como faltante anunciado ni como producto faltante.
	set @activo = 1

	select @activo= count(1)
	from dbo.productofaltante
	where  CampaniaID = @CampaniaID
		and cuv = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'
		return 0
	end

	set @activo = 1
	select @activo= count(1)
	from ods.faltanteanunciado fa
		inner join ods.campania c on c.CampaniaID = fa.CampaniaID
	where c.Codigo = @CampaniaID
		and  fa.codigoVenta = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'		
		return 0
	end

	-- Que el CUV Sugerido sea diferente al CUV Agotado
	if @CUV = @CUVSugerido
	begin
		set @Return = '-5|El CUV Sugerido debe ser diferente al CUV Agotado.'
		return 0
	end

	-- Que no se haya cargado previamente el mismo CUV Sugerido para el mismo CUV Agotado
	set @activo = 0

	select @activo = ProductoSugeridoID
	-- select *
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		and ps.CUVSugerido = @CUVSugerido
		and ps.Estado = 1
		and ps.RegionID=@RegionID --/* HD-4289 */
		and ps.ZonaID=@ZonaID --/* HD-4289 */
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0 )
	begin
		set @Return = '-6|El CUV Sugerido ya fue cargado previamente al mismo CUV Agotado.'
		return 0
	end

	-- Que el orden ingresado para el CUV sugerido, no esté siendo utilizado para un mismo CUV agotado.
	set @activo = 0

	select @activo = ProductoSugeridoID
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		--and ps.CUVSugerido = @CUVSugerido
		and ps.Orden = @Orden
		and ps.Estado = 1
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0)
	begin
		set @Return = '-7|El orden ingresado ya existe para el CUV Agotado configurado.'
		return 0
	end

	-- Que se haya seleccionado una foto
	if @ImagenProducto = '' 
	begin
		set @Return = '-8|No se ha seleccionado ninguna foto.'
		return 0
	end

	-- Productos con reemplazos configurados por campaña
	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		declare @id int = 0
		select @id = min(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		declare @cant int = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantProd int = 0
		select @cantProd = count(1)
			from (
			select CampaniaID, CUV
			from productoSugerido ps
			where ps.CampaniaID = @CampaniaID
			and ps.Estado = 1
			group by CampaniaID, CUV
		) as t			
					
		if ( @cant <= @cantProd and @ProductoSugeridoID = 0 )
		begin
			set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
			return 0
		end

		if @ProductoSugeridoID > 0
		begin 
					
			
			declare @cantProdDif int = 0
			select @cantProdDif = count(1)
			from (
				select CampaniaID, CUV
				from productoSugerido ps
				where ps.CampaniaID = @CampaniaID
				and ps.Estado = 1
				and ps.CUV != @CUV
				and ps.ProductoSugeridoID != @ProductoSugeridoID
				group by CampaniaID, CUV
			) as t

					
			if ( @cant <= @cantProdDif and @ProductoSugeridoID > 0 )
			begin
				set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
				return 0
			end

		end -- if @ProductoSugeridoID > 0

		
		
	end


	-- Reemplazos configurados por producto por campaña

	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		set @id = 0
		select @id = max(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		set @cant = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantSug int = 0
		declare @cantSugDif int = 0

		select @cantSug = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1	
		
		select @cantSugDif = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1
		and ProductoSugeridoID != @ProductoSugeridoID			
			
		if (@cant <= @cantSug and @ProductoSugeridoID = 0 ) or ( @cant <= @cantSugDif and @ProductoSugeridoID > 0 )
		begin
			set @Return = '-10|Ya se registró la cantidad máxima de sugerencias de reemplazo para este producto en la campaña.'
			return 0
		end
	end
END

GO
USE [BelcorpMexico]
GO


ALTER PROCEDURE [dbo].[ValidProductoSugerido_SB2]
(
	 @Return varchar(1000) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@Usuario varchar(50)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
)
AS
BEGIN
	set @Return = ''
	
	set @ProductoSugeridoID = isnull(@ProductoSugeridoID, 0)
	set @CampaniaID = isnull(@CampaniaID, '')
	set @CUV = isnull(@CUV, '')
	set @CUVSugerido = isnull(@CUVSugerido, '')
	set @Orden = isnull(@Orden, '')
	set @ImagenProducto = isnull(@ImagenProducto, '')
	set @Estado = isnull(@Estado,-1)
	set @Usuario = isnull(@Usuario, '')

	if @ProductoSugeridoID <= 0 
		set @ProductoSugeridoID = 0
	if @Estado < 0 
		set @Estado = -1

	-- Que se hayan ingresado todos los datos
	if @CampaniaID = '' or @CUV = '' or @CUVSugerido = '' or @Orden = '' or @Estado = -1
	begin
		set @Return = '-1|La información ingresada se encuentra incompleta. Por favor, revisar.'	
		return 0
	end

	-- Que el CUV Agotado exista para la campaña y que sea digitable.
	declare @digita int = -1, @activo int = -1
	
	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUV

	set @digita = isnull(@digita, -1)
	if @digita = -1 or @digita = 0
	begin
		set @Return = '-2|El CUV Agotado no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido exista para la campaña, sea digitable y se encuentre activo.	
	set @digita = -1	
	set @activo = -1

	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUVSugerido
	
	set @digita = isnull(@digita, -1)
	set @activo = isnull(@activo, -1)
	if @digita = -1 or @digita = 0 or @activo = -1 or @activo = 0
	begin
		set @Return = '-3|El CUV Sugerido no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido no esté como faltante anunciado ni como producto faltante.
	set @activo = 1

	select @activo= count(1)
	from dbo.productofaltante
	where  CampaniaID = @CampaniaID
		and cuv = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'
		return 0
	end

	set @activo = 1
	select @activo= count(1)
	from ods.faltanteanunciado fa
		inner join ods.campania c on c.CampaniaID = fa.CampaniaID
	where c.Codigo = @CampaniaID
		and  fa.codigoVenta = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'		
		return 0
	end

	-- Que el CUV Sugerido sea diferente al CUV Agotado
	if @CUV = @CUVSugerido
	begin
		set @Return = '-5|El CUV Sugerido debe ser diferente al CUV Agotado.'
		return 0
	end

	-- Que no se haya cargado previamente el mismo CUV Sugerido para el mismo CUV Agotado
	set @activo = 0

	select @activo = ProductoSugeridoID
	-- select *
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		and ps.CUVSugerido = @CUVSugerido
		and ps.Estado = 1
		and ps.RegionID=@RegionID --/* HD-4289 */
		and ps.ZonaID=@ZonaID --/* HD-4289 */
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0 )
	begin
		set @Return = '-6|El CUV Sugerido ya fue cargado previamente al mismo CUV Agotado.'
		return 0
	end

	-- Que el orden ingresado para el CUV sugerido, no esté siendo utilizado para un mismo CUV agotado.
	set @activo = 0

	select @activo = ProductoSugeridoID
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		--and ps.CUVSugerido = @CUVSugerido
		and ps.Orden = @Orden
		and ps.Estado = 1
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0)
	begin
		set @Return = '-7|El orden ingresado ya existe para el CUV Agotado configurado.'
		return 0
	end

	-- Que se haya seleccionado una foto
	if @ImagenProducto = '' 
	begin
		set @Return = '-8|No se ha seleccionado ninguna foto.'
		return 0
	end

	-- Productos con reemplazos configurados por campaña
	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		declare @id int = 0
		select @id = min(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		declare @cant int = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantProd int = 0
		select @cantProd = count(1)
			from (
			select CampaniaID, CUV
			from productoSugerido ps
			where ps.CampaniaID = @CampaniaID
			and ps.Estado = 1
			group by CampaniaID, CUV
		) as t			
					
		if ( @cant <= @cantProd and @ProductoSugeridoID = 0 )
		begin
			set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
			return 0
		end

		if @ProductoSugeridoID > 0
		begin 
					
			
			declare @cantProdDif int = 0
			select @cantProdDif = count(1)
			from (
				select CampaniaID, CUV
				from productoSugerido ps
				where ps.CampaniaID = @CampaniaID
				and ps.Estado = 1
				and ps.CUV != @CUV
				and ps.ProductoSugeridoID != @ProductoSugeridoID
				group by CampaniaID, CUV
			) as t

					
			if ( @cant <= @cantProdDif and @ProductoSugeridoID > 0 )
			begin
				set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
				return 0
			end

		end -- if @ProductoSugeridoID > 0

		
		
	end


	-- Reemplazos configurados por producto por campaña

	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		set @id = 0
		select @id = max(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		set @cant = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantSug int = 0
		declare @cantSugDif int = 0

		select @cantSug = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1	
		
		select @cantSugDif = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1
		and ProductoSugeridoID != @ProductoSugeridoID			
			
		if (@cant <= @cantSug and @ProductoSugeridoID = 0 ) or ( @cant <= @cantSugDif and @ProductoSugeridoID > 0 )
		begin
			set @Return = '-10|Ya se registró la cantidad máxima de sugerencias de reemplazo para este producto en la campaña.'
			return 0
		end
	end
END

GO
USE [BelcorpPanama]
GO


ALTER PROCEDURE [dbo].[ValidProductoSugerido_SB2]
(
	 @Return varchar(1000) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@Usuario varchar(50)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
)
AS
BEGIN
	set @Return = ''
	
	set @ProductoSugeridoID = isnull(@ProductoSugeridoID, 0)
	set @CampaniaID = isnull(@CampaniaID, '')
	set @CUV = isnull(@CUV, '')
	set @CUVSugerido = isnull(@CUVSugerido, '')
	set @Orden = isnull(@Orden, '')
	set @ImagenProducto = isnull(@ImagenProducto, '')
	set @Estado = isnull(@Estado,-1)
	set @Usuario = isnull(@Usuario, '')

	if @ProductoSugeridoID <= 0 
		set @ProductoSugeridoID = 0
	if @Estado < 0 
		set @Estado = -1

	-- Que se hayan ingresado todos los datos
	if @CampaniaID = '' or @CUV = '' or @CUVSugerido = '' or @Orden = '' or @Estado = -1
	begin
		set @Return = '-1|La información ingresada se encuentra incompleta. Por favor, revisar.'	
		return 0
	end

	-- Que el CUV Agotado exista para la campaña y que sea digitable.
	declare @digita int = -1, @activo int = -1
	
	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUV

	set @digita = isnull(@digita, -1)
	if @digita = -1 or @digita = 0
	begin
		set @Return = '-2|El CUV Agotado no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido exista para la campaña, sea digitable y se encuentre activo.	
	set @digita = -1	
	set @activo = -1

	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUVSugerido
	
	set @digita = isnull(@digita, -1)
	set @activo = isnull(@activo, -1)
	if @digita = -1 or @digita = 0 or @activo = -1 or @activo = 0
	begin
		set @Return = '-3|El CUV Sugerido no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido no esté como faltante anunciado ni como producto faltante.
	set @activo = 1

	select @activo= count(1)
	from dbo.productofaltante
	where  CampaniaID = @CampaniaID
		and cuv = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'
		return 0
	end

	set @activo = 1
	select @activo= count(1)
	from ods.faltanteanunciado fa
		inner join ods.campania c on c.CampaniaID = fa.CampaniaID
	where c.Codigo = @CampaniaID
		and  fa.codigoVenta = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'		
		return 0
	end

	-- Que el CUV Sugerido sea diferente al CUV Agotado
	if @CUV = @CUVSugerido
	begin
		set @Return = '-5|El CUV Sugerido debe ser diferente al CUV Agotado.'
		return 0
	end

	-- Que no se haya cargado previamente el mismo CUV Sugerido para el mismo CUV Agotado
	set @activo = 0

	select @activo = ProductoSugeridoID
	-- select *
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		and ps.CUVSugerido = @CUVSugerido
		and ps.Estado = 1
		and ps.RegionID=@RegionID --/* HD-4289 */
		and ps.ZonaID=@ZonaID --/* HD-4289 */
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0 )
	begin
		set @Return = '-6|El CUV Sugerido ya fue cargado previamente al mismo CUV Agotado.'
		return 0
	end

	-- Que el orden ingresado para el CUV sugerido, no esté siendo utilizado para un mismo CUV agotado.
	set @activo = 0

	select @activo = ProductoSugeridoID
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		--and ps.CUVSugerido = @CUVSugerido
		and ps.Orden = @Orden
		and ps.Estado = 1
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0)
	begin
		set @Return = '-7|El orden ingresado ya existe para el CUV Agotado configurado.'
		return 0
	end

	-- Que se haya seleccionado una foto
	if @ImagenProducto = '' 
	begin
		set @Return = '-8|No se ha seleccionado ninguna foto.'
		return 0
	end

	-- Productos con reemplazos configurados por campaña
	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		declare @id int = 0
		select @id = min(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		declare @cant int = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantProd int = 0
		select @cantProd = count(1)
			from (
			select CampaniaID, CUV
			from productoSugerido ps
			where ps.CampaniaID = @CampaniaID
			and ps.Estado = 1
			group by CampaniaID, CUV
		) as t			
					
		if ( @cant <= @cantProd and @ProductoSugeridoID = 0 )
		begin
			set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
			return 0
		end

		if @ProductoSugeridoID > 0
		begin 
					
			
			declare @cantProdDif int = 0
			select @cantProdDif = count(1)
			from (
				select CampaniaID, CUV
				from productoSugerido ps
				where ps.CampaniaID = @CampaniaID
				and ps.Estado = 1
				and ps.CUV != @CUV
				and ps.ProductoSugeridoID != @ProductoSugeridoID
				group by CampaniaID, CUV
			) as t

					
			if ( @cant <= @cantProdDif and @ProductoSugeridoID > 0 )
			begin
				set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
				return 0
			end

		end -- if @ProductoSugeridoID > 0

		
		
	end


	-- Reemplazos configurados por producto por campaña

	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		set @id = 0
		select @id = max(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		set @cant = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantSug int = 0
		declare @cantSugDif int = 0

		select @cantSug = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1	
		
		select @cantSugDif = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1
		and ProductoSugeridoID != @ProductoSugeridoID			
			
		if (@cant <= @cantSug and @ProductoSugeridoID = 0 ) or ( @cant <= @cantSugDif and @ProductoSugeridoID > 0 )
		begin
			set @Return = '-10|Ya se registró la cantidad máxima de sugerencias de reemplazo para este producto en la campaña.'
			return 0
		end
	end
END

GO
USE [BelcorpPeru]
GO


ALTER PROCEDURE [dbo].[ValidProductoSugerido_SB2]
(
	 @Return varchar(1000) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@Usuario varchar(50)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
)
AS
BEGIN
	set @Return = ''
	
	set @ProductoSugeridoID = isnull(@ProductoSugeridoID, 0)
	set @CampaniaID = isnull(@CampaniaID, '')
	set @CUV = isnull(@CUV, '')
	set @CUVSugerido = isnull(@CUVSugerido, '')
	set @Orden = isnull(@Orden, '')
	set @ImagenProducto = isnull(@ImagenProducto, '')
	set @Estado = isnull(@Estado,-1)
	set @Usuario = isnull(@Usuario, '')

	if @ProductoSugeridoID <= 0 
		set @ProductoSugeridoID = 0
	if @Estado < 0 
		set @Estado = -1

	-- Que se hayan ingresado todos los datos
	if @CampaniaID = '' or @CUV = '' or @CUVSugerido = '' or @Orden = '' or @Estado = -1
	begin
		set @Return = '-1|La información ingresada se encuentra incompleta. Por favor, revisar.'	
		return 0
	end

	-- Que el CUV Agotado exista para la campaña y que sea digitable.
	declare @digita int = -1, @activo int = -1
	
	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUV

	set @digita = isnull(@digita, -1)
	if @digita = -1 or @digita = 0
	begin
		set @Return = '-2|El CUV Agotado no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido exista para la campaña, sea digitable y se encuentre activo.	
	set @digita = -1	
	set @activo = -1

	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUVSugerido
	
	set @digita = isnull(@digita, -1)
	set @activo = isnull(@activo, -1)
	if @digita = -1 or @digita = 0 or @activo = -1 or @activo = 0
	begin
		set @Return = '-3|El CUV Sugerido no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido no esté como faltante anunciado ni como producto faltante.
	set @activo = 1

	select @activo= count(1)
	from dbo.productofaltante
	where  CampaniaID = @CampaniaID
		and cuv = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'
		return 0
	end

	set @activo = 1
	select @activo= count(1)
	from ods.faltanteanunciado fa
		inner join ods.campania c on c.CampaniaID = fa.CampaniaID
	where c.Codigo = @CampaniaID
		and  fa.codigoVenta = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'		
		return 0
	end

	-- Que el CUV Sugerido sea diferente al CUV Agotado
	if @CUV = @CUVSugerido
	begin
		set @Return = '-5|El CUV Sugerido debe ser diferente al CUV Agotado.'
		return 0
	end

	-- Que no se haya cargado previamente el mismo CUV Sugerido para el mismo CUV Agotado
	set @activo = 0

	select @activo = ProductoSugeridoID
	-- select *
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		and ps.CUVSugerido = @CUVSugerido
		and ps.Estado = 1
		and ps.RegionID=@RegionID --/* HD-4289 */
		and ps.ZonaID=@ZonaID --/* HD-4289 */
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0 )
	begin
		set @Return = '-6|El CUV Sugerido ya fue cargado previamente al mismo CUV Agotado.'
		return 0
	end

	-- Que el orden ingresado para el CUV sugerido, no esté siendo utilizado para un mismo CUV agotado.
	set @activo = 0

	select @activo = ProductoSugeridoID
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		--and ps.CUVSugerido = @CUVSugerido
		and ps.Orden = @Orden
		and ps.Estado = 1
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0)
	begin
		set @Return = '-7|El orden ingresado ya existe para el CUV Agotado configurado.'
		return 0
	end

	-- Que se haya seleccionado una foto
	if @ImagenProducto = '' 
	begin
		set @Return = '-8|No se ha seleccionado ninguna foto.'
		return 0
	end

	-- Productos con reemplazos configurados por campaña
	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		declare @id int = 0
		select @id = min(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		declare @cant int = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantProd int = 0
		select @cantProd = count(1)
			from (
			select CampaniaID, CUV
			from productoSugerido ps
			where ps.CampaniaID = @CampaniaID
			and ps.Estado = 1
			group by CampaniaID, CUV
		) as t			
					
		if ( @cant <= @cantProd and @ProductoSugeridoID = 0 )
		begin
			set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
			return 0
		end

		if @ProductoSugeridoID > 0
		begin 
					
			
			declare @cantProdDif int = 0
			select @cantProdDif = count(1)
			from (
				select CampaniaID, CUV
				from productoSugerido ps
				where ps.CampaniaID = @CampaniaID
				and ps.Estado = 1
				and ps.CUV != @CUV
				and ps.ProductoSugeridoID != @ProductoSugeridoID
				group by CampaniaID, CUV
			) as t

					
			if ( @cant <= @cantProdDif and @ProductoSugeridoID > 0 )
			begin
				set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
				return 0
			end

		end -- if @ProductoSugeridoID > 0

		
		
	end


	-- Reemplazos configurados por producto por campaña

	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		set @id = 0
		select @id = max(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		set @cant = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantSug int = 0
		declare @cantSugDif int = 0

		select @cantSug = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1	
		
		select @cantSugDif = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1
		and ProductoSugeridoID != @ProductoSugeridoID			
			
		if (@cant <= @cantSug and @ProductoSugeridoID = 0 ) or ( @cant <= @cantSugDif and @ProductoSugeridoID > 0 )
		begin
			set @Return = '-10|Ya se registró la cantidad máxima de sugerencias de reemplazo para este producto en la campaña.'
			return 0
		end
	end
END

GO
USE [BelcorpPuertoRico]
GO


ALTER PROCEDURE [dbo].[ValidProductoSugerido_SB2]
(
	 @Return varchar(1000) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@Usuario varchar(50)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
)
AS
BEGIN
	set @Return = ''
	
	set @ProductoSugeridoID = isnull(@ProductoSugeridoID, 0)
	set @CampaniaID = isnull(@CampaniaID, '')
	set @CUV = isnull(@CUV, '')
	set @CUVSugerido = isnull(@CUVSugerido, '')
	set @Orden = isnull(@Orden, '')
	set @ImagenProducto = isnull(@ImagenProducto, '')
	set @Estado = isnull(@Estado,-1)
	set @Usuario = isnull(@Usuario, '')

	if @ProductoSugeridoID <= 0 
		set @ProductoSugeridoID = 0
	if @Estado < 0 
		set @Estado = -1

	-- Que se hayan ingresado todos los datos
	if @CampaniaID = '' or @CUV = '' or @CUVSugerido = '' or @Orden = '' or @Estado = -1
	begin
		set @Return = '-1|La información ingresada se encuentra incompleta. Por favor, revisar.'	
		return 0
	end

	-- Que el CUV Agotado exista para la campaña y que sea digitable.
	declare @digita int = -1, @activo int = -1
	
	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUV

	set @digita = isnull(@digita, -1)
	if @digita = -1 or @digita = 0
	begin
		set @Return = '-2|El CUV Agotado no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido exista para la campaña, sea digitable y se encuentre activo.	
	set @digita = -1	
	set @activo = -1

	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUVSugerido
	
	set @digita = isnull(@digita, -1)
	set @activo = isnull(@activo, -1)
	if @digita = -1 or @digita = 0 or @activo = -1 or @activo = 0
	begin
		set @Return = '-3|El CUV Sugerido no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido no esté como faltante anunciado ni como producto faltante.
	set @activo = 1

	select @activo= count(1)
	from dbo.productofaltante
	where  CampaniaID = @CampaniaID
		and cuv = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'
		return 0
	end

	set @activo = 1
	select @activo= count(1)
	from ods.faltanteanunciado fa
		inner join ods.campania c on c.CampaniaID = fa.CampaniaID
	where c.Codigo = @CampaniaID
		and  fa.codigoVenta = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'		
		return 0
	end

	-- Que el CUV Sugerido sea diferente al CUV Agotado
	if @CUV = @CUVSugerido
	begin
		set @Return = '-5|El CUV Sugerido debe ser diferente al CUV Agotado.'
		return 0
	end

	-- Que no se haya cargado previamente el mismo CUV Sugerido para el mismo CUV Agotado
	set @activo = 0

	select @activo = ProductoSugeridoID
	-- select *
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		and ps.CUVSugerido = @CUVSugerido
		and ps.Estado = 1
		and ps.RegionID=@RegionID --/* HD-4289 */
		and ps.ZonaID=@ZonaID --/* HD-4289 */
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0 )
	begin
		set @Return = '-6|El CUV Sugerido ya fue cargado previamente al mismo CUV Agotado.'
		return 0
	end

	-- Que el orden ingresado para el CUV sugerido, no esté siendo utilizado para un mismo CUV agotado.
	set @activo = 0

	select @activo = ProductoSugeridoID
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		--and ps.CUVSugerido = @CUVSugerido
		and ps.Orden = @Orden
		and ps.Estado = 1
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0)
	begin
		set @Return = '-7|El orden ingresado ya existe para el CUV Agotado configurado.'
		return 0
	end

	-- Que se haya seleccionado una foto
	if @ImagenProducto = '' 
	begin
		set @Return = '-8|No se ha seleccionado ninguna foto.'
		return 0
	end

	-- Productos con reemplazos configurados por campaña
	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		declare @id int = 0
		select @id = min(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		declare @cant int = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantProd int = 0
		select @cantProd = count(1)
			from (
			select CampaniaID, CUV
			from productoSugerido ps
			where ps.CampaniaID = @CampaniaID
			and ps.Estado = 1
			group by CampaniaID, CUV
		) as t			
					
		if ( @cant <= @cantProd and @ProductoSugeridoID = 0 )
		begin
			set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
			return 0
		end

		if @ProductoSugeridoID > 0
		begin 
					
			
			declare @cantProdDif int = 0
			select @cantProdDif = count(1)
			from (
				select CampaniaID, CUV
				from productoSugerido ps
				where ps.CampaniaID = @CampaniaID
				and ps.Estado = 1
				and ps.CUV != @CUV
				and ps.ProductoSugeridoID != @ProductoSugeridoID
				group by CampaniaID, CUV
			) as t

					
			if ( @cant <= @cantProdDif and @ProductoSugeridoID > 0 )
			begin
				set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
				return 0
			end

		end -- if @ProductoSugeridoID > 0

		
		
	end


	-- Reemplazos configurados por producto por campaña

	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		set @id = 0
		select @id = max(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		set @cant = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantSug int = 0
		declare @cantSugDif int = 0

		select @cantSug = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1	
		
		select @cantSugDif = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1
		and ProductoSugeridoID != @ProductoSugeridoID			
			
		if (@cant <= @cantSug and @ProductoSugeridoID = 0 ) or ( @cant <= @cantSugDif and @ProductoSugeridoID > 0 )
		begin
			set @Return = '-10|Ya se registró la cantidad máxima de sugerencias de reemplazo para este producto en la campaña.'
			return 0
		end
	end
END

GO
USE [BelcorpSalvador]
GO


ALTER PROCEDURE [dbo].[ValidProductoSugerido_SB2]
(
	 @Return varchar(1000) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@Usuario varchar(50)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
)
AS
BEGIN
	set @Return = ''
	
	set @ProductoSugeridoID = isnull(@ProductoSugeridoID, 0)
	set @CampaniaID = isnull(@CampaniaID, '')
	set @CUV = isnull(@CUV, '')
	set @CUVSugerido = isnull(@CUVSugerido, '')
	set @Orden = isnull(@Orden, '')
	set @ImagenProducto = isnull(@ImagenProducto, '')
	set @Estado = isnull(@Estado,-1)
	set @Usuario = isnull(@Usuario, '')

	if @ProductoSugeridoID <= 0 
		set @ProductoSugeridoID = 0
	if @Estado < 0 
		set @Estado = -1

	-- Que se hayan ingresado todos los datos
	if @CampaniaID = '' or @CUV = '' or @CUVSugerido = '' or @Orden = '' or @Estado = -1
	begin
		set @Return = '-1|La información ingresada se encuentra incompleta. Por favor, revisar.'	
		return 0
	end

	-- Que el CUV Agotado exista para la campaña y que sea digitable.
	declare @digita int = -1, @activo int = -1
	
	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUV

	set @digita = isnull(@digita, -1)
	if @digita = -1 or @digita = 0
	begin
		set @Return = '-2|El CUV Agotado no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido exista para la campaña, sea digitable y se encuentre activo.	
	set @digita = -1	
	set @activo = -1

	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUVSugerido
	
	set @digita = isnull(@digita, -1)
	set @activo = isnull(@activo, -1)
	if @digita = -1 or @digita = 0 or @activo = -1 or @activo = 0
	begin
		set @Return = '-3|El CUV Sugerido no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido no esté como faltante anunciado ni como producto faltante.
	set @activo = 1

	select @activo= count(1)
	from dbo.productofaltante
	where  CampaniaID = @CampaniaID
		and cuv = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'
		return 0
	end

	set @activo = 1
	select @activo= count(1)
	from ods.faltanteanunciado fa
		inner join ods.campania c on c.CampaniaID = fa.CampaniaID
	where c.Codigo = @CampaniaID
		and  fa.codigoVenta = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'		
		return 0
	end

	-- Que el CUV Sugerido sea diferente al CUV Agotado
	if @CUV = @CUVSugerido
	begin
		set @Return = '-5|El CUV Sugerido debe ser diferente al CUV Agotado.'
		return 0
	end

	-- Que no se haya cargado previamente el mismo CUV Sugerido para el mismo CUV Agotado
	set @activo = 0

	select @activo = ProductoSugeridoID
	-- select *
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		and ps.CUVSugerido = @CUVSugerido
		and ps.Estado = 1
		and ps.RegionID=@RegionID --/* HD-4289 */
		and ps.ZonaID=@ZonaID --/* HD-4289 */
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0 )
	begin
		set @Return = '-6|El CUV Sugerido ya fue cargado previamente al mismo CUV Agotado.'
		return 0
	end

	-- Que el orden ingresado para el CUV sugerido, no esté siendo utilizado para un mismo CUV agotado.
	set @activo = 0

	select @activo = ProductoSugeridoID
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		--and ps.CUVSugerido = @CUVSugerido
		and ps.Orden = @Orden
		and ps.Estado = 1
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0)
	begin
		set @Return = '-7|El orden ingresado ya existe para el CUV Agotado configurado.'
		return 0
	end

	-- Que se haya seleccionado una foto
	if @ImagenProducto = '' 
	begin
		set @Return = '-8|No se ha seleccionado ninguna foto.'
		return 0
	end

	-- Productos con reemplazos configurados por campaña
	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		declare @id int = 0
		select @id = min(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		declare @cant int = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantProd int = 0
		select @cantProd = count(1)
			from (
			select CampaniaID, CUV
			from productoSugerido ps
			where ps.CampaniaID = @CampaniaID
			and ps.Estado = 1
			group by CampaniaID, CUV
		) as t			
					
		if ( @cant <= @cantProd and @ProductoSugeridoID = 0 )
		begin
			set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
			return 0
		end

		if @ProductoSugeridoID > 0
		begin 
					
			
			declare @cantProdDif int = 0
			select @cantProdDif = count(1)
			from (
				select CampaniaID, CUV
				from productoSugerido ps
				where ps.CampaniaID = @CampaniaID
				and ps.Estado = 1
				and ps.CUV != @CUV
				and ps.ProductoSugeridoID != @ProductoSugeridoID
				group by CampaniaID, CUV
			) as t

					
			if ( @cant <= @cantProdDif and @ProductoSugeridoID > 0 )
			begin
				set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
				return 0
			end

		end -- if @ProductoSugeridoID > 0

		
		
	end


	-- Reemplazos configurados por producto por campaña

	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		set @id = 0
		select @id = max(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		set @cant = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantSug int = 0
		declare @cantSugDif int = 0

		select @cantSug = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1	
		
		select @cantSugDif = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1
		and ProductoSugeridoID != @ProductoSugeridoID			
			
		if (@cant <= @cantSug and @ProductoSugeridoID = 0 ) or ( @cant <= @cantSugDif and @ProductoSugeridoID > 0 )
		begin
			set @Return = '-10|Ya se registró la cantidad máxima de sugerencias de reemplazo para este producto en la campaña.'
			return 0
		end
	end
END

