USE BelcorpBolivia
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
(
@Campania varchar(50),
@CodigoRegion varchar(50),
@CodigoZona varchar(50),
@CodigoNivel varchar(2)
)
AS
BEGIN
	
	declare @CodigoRegionx varchar(50) = ''
	,@CodigoZonax varchar(50) = ''
	,@ExisteRegistro int = 0
	,@CodigoPrograma varchar(50) = ''
	,@add bit = 1

	
	select @ExisteRegistro = COUNT(1)
	from ods.ConfiguracionProgramaNuevasUA
	where CodigoRegion = @CodigoRegion
	

	if @ExisteRegistro > 0
	begin
			--set @add = 0
			set @CodigoPrograma = ''

			select @CodigoPrograma = isnull(c.CodigoPrograma, '')
			from  ods.premiosprogramanuevas c
				inner join ods.ConfiguracionProgramaNuevasUA cua 
					on cua.CodigoPrograma = c.CodigoPrograma
			where cua.CodigoRegion = @CodigoRegion
				and c.AnoCampana = @Campania
				and c.CodigoNivel = @CodigoNivel
				and c.PrecioUnitario > 0

			set @CodigoPrograma = LTRIM(RTRIM(isnull(@CodigoPrograma, '')))

			if @CodigoPrograma != ''
			begin
					--set @add = 1
					set @CodigoZonax = ''
			
					select @CodigoZonax = isnull(CodigoZona, '')
					from ods.ConfiguracionProgramaNuevasUA
					where codigoprograma = @CodigoPrograma
						and CodigoRegion = @CodigoRegion
						--and CodigoZona = @CodigoZona

					set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))

					if @CodigoZonax != ''
					begin
					
						set @add = 0
						set @CodigoZonax = ''
			
						select @CodigoZonax = isnull(CodigoZona, '')
						from ods.ConfiguracionProgramaNuevasUA
						where codigoprograma = @CodigoPrograma
							and CodigoRegion = @CodigoRegion
							and CodigoZona = @CodigoZona

						set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))
						if @CodigoZonax != ''
							set @add = 1
						
					end

			end

	end

	
	if @add = 1
	begin

			select 
					 CodigoPrograma
					,CUV as CUVKit
			from  ods.premiosprogramanuevas
			where AnoCampana = @Campania and CodigoNivel = @CodigoNivel
				and PrecioUnitario > 0
				and (CodigoPrograma = @CodigoPrograma or @CodigoPrograma = '')


	end

END
GO
/*end*/

USE BelcorpChile
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
(
@Campania varchar(50),
@CodigoRegion varchar(50),
@CodigoZona varchar(50),
@CodigoNivel varchar(2)
)
AS
BEGIN
	
	declare @CodigoRegionx varchar(50) = ''
	,@CodigoZonax varchar(50) = ''
	,@ExisteRegistro int = 0
	,@CodigoPrograma varchar(50) = ''
	,@add bit = 1

	
	select @ExisteRegistro = COUNT(1)
	from ods.ConfiguracionProgramaNuevasUA
	where CodigoRegion = @CodigoRegion
	

	if @ExisteRegistro > 0
	begin
			--set @add = 0
			set @CodigoPrograma = ''

			select @CodigoPrograma = isnull(c.CodigoPrograma, '')
			from  ods.premiosprogramanuevas c
				inner join ods.ConfiguracionProgramaNuevasUA cua 
					on cua.CodigoPrograma = c.CodigoPrograma
			where cua.CodigoRegion = @CodigoRegion
				and c.AnoCampana = @Campania
				and c.CodigoNivel = @CodigoNivel
				and c.PrecioUnitario > 0

			set @CodigoPrograma = LTRIM(RTRIM(isnull(@CodigoPrograma, '')))

			if @CodigoPrograma != ''
			begin
					--set @add = 1
					set @CodigoZonax = ''
			
					select @CodigoZonax = isnull(CodigoZona, '')
					from ods.ConfiguracionProgramaNuevasUA
					where codigoprograma = @CodigoPrograma
						and CodigoRegion = @CodigoRegion
						--and CodigoZona = @CodigoZona

					set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))

					if @CodigoZonax != ''
					begin
					
						set @add = 0
						set @CodigoZonax = ''
			
						select @CodigoZonax = isnull(CodigoZona, '')
						from ods.ConfiguracionProgramaNuevasUA
						where codigoprograma = @CodigoPrograma
							and CodigoRegion = @CodigoRegion
							and CodigoZona = @CodigoZona

						set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))
						if @CodigoZonax != ''
							set @add = 1
						
					end

			end

	end

	
	if @add = 1
	begin

			select 
					 CodigoPrograma
					,CUV as CUVKit
			from  ods.premiosprogramanuevas
			where AnoCampana = @Campania and CodigoNivel = @CodigoNivel
				and PrecioUnitario > 0
				and (CodigoPrograma = @CodigoPrograma or @CodigoPrograma = '')


	end

END
GO
/*end*/

USE BelcorpColombia
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
(
@Campania varchar(50),
@CodigoRegion varchar(50),
@CodigoZona varchar(50),
@CodigoNivel varchar(2)
)
AS
BEGIN
	
	declare @CodigoRegionx varchar(50) = ''
	,@CodigoZonax varchar(50) = ''
	,@ExisteRegistro int = 0
	,@CodigoPrograma varchar(50) = ''
	,@add bit = 1

	
	select @ExisteRegistro = COUNT(1)
	from ods.ConfiguracionProgramaNuevasUA
	where CodigoRegion = @CodigoRegion
	

	if @ExisteRegistro > 0
	begin
			--set @add = 0
			set @CodigoPrograma = ''

			select @CodigoPrograma = isnull(c.CodigoPrograma, '')
			from  ods.premiosprogramanuevas c
				inner join ods.ConfiguracionProgramaNuevasUA cua 
					on cua.CodigoPrograma = c.CodigoPrograma
			where cua.CodigoRegion = @CodigoRegion
				and c.AnoCampana = @Campania
				and c.CodigoNivel = @CodigoNivel
				and c.PrecioUnitario > 0

			set @CodigoPrograma = LTRIM(RTRIM(isnull(@CodigoPrograma, '')))

			if @CodigoPrograma != ''
			begin
					--set @add = 1
					set @CodigoZonax = ''
			
					select @CodigoZonax = isnull(CodigoZona, '')
					from ods.ConfiguracionProgramaNuevasUA
					where codigoprograma = @CodigoPrograma
						and CodigoRegion = @CodigoRegion
						--and CodigoZona = @CodigoZona

					set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))

					if @CodigoZonax != ''
					begin
					
						set @add = 0
						set @CodigoZonax = ''
			
						select @CodigoZonax = isnull(CodigoZona, '')
						from ods.ConfiguracionProgramaNuevasUA
						where codigoprograma = @CodigoPrograma
							and CodigoRegion = @CodigoRegion
							and CodigoZona = @CodigoZona

						set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))
						if @CodigoZonax != ''
							set @add = 1
						
					end

			end

	end

	
	if @add = 1
	begin

			select 
					 CodigoPrograma
					,CUV as CUVKit
			from  ods.premiosprogramanuevas
			where AnoCampana = @Campania and CodigoNivel = @CodigoNivel
				and PrecioUnitario > 0
				and (CodigoPrograma = @CodigoPrograma or @CodigoPrograma = '')


	end

END
GO
/*end*/

USE BelcorpCostaRica
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
(
@Campania varchar(50),
@CodigoRegion varchar(50),
@CodigoZona varchar(50),
@CodigoNivel varchar(2)
)
AS
BEGIN
	
	declare @CodigoRegionx varchar(50) = ''
	,@CodigoZonax varchar(50) = ''
	,@ExisteRegistro int = 0
	,@CodigoPrograma varchar(50) = ''
	,@add bit = 1

	
	select @ExisteRegistro = COUNT(1)
	from ods.ConfiguracionProgramaNuevasUA
	where CodigoRegion = @CodigoRegion
	

	if @ExisteRegistro > 0
	begin
			--set @add = 0
			set @CodigoPrograma = ''

			select @CodigoPrograma = isnull(c.CodigoPrograma, '')
			from  ods.premiosprogramanuevas c
				inner join ods.ConfiguracionProgramaNuevasUA cua 
					on cua.CodigoPrograma = c.CodigoPrograma
			where cua.CodigoRegion = @CodigoRegion
				and c.AnoCampana = @Campania
				and c.CodigoNivel = @CodigoNivel
				and c.PrecioUnitario > 0

			set @CodigoPrograma = LTRIM(RTRIM(isnull(@CodigoPrograma, '')))

			if @CodigoPrograma != ''
			begin
					--set @add = 1
					set @CodigoZonax = ''
			
					select @CodigoZonax = isnull(CodigoZona, '')
					from ods.ConfiguracionProgramaNuevasUA
					where codigoprograma = @CodigoPrograma
						and CodigoRegion = @CodigoRegion
						--and CodigoZona = @CodigoZona

					set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))

					if @CodigoZonax != ''
					begin
					
						set @add = 0
						set @CodigoZonax = ''
			
						select @CodigoZonax = isnull(CodigoZona, '')
						from ods.ConfiguracionProgramaNuevasUA
						where codigoprograma = @CodigoPrograma
							and CodigoRegion = @CodigoRegion
							and CodigoZona = @CodigoZona

						set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))
						if @CodigoZonax != ''
							set @add = 1
						
					end

			end

	end

	
	if @add = 1
	begin

			select 
					 CodigoPrograma
					,CUV as CUVKit
			from  ods.premiosprogramanuevas
			where AnoCampana = @Campania and CodigoNivel = @CodigoNivel
				and PrecioUnitario > 0
				and (CodigoPrograma = @CodigoPrograma or @CodigoPrograma = '')


	end

END
GO
/*end*/

USE BelcorpDominicana
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
(
@Campania varchar(50),
@CodigoRegion varchar(50),
@CodigoZona varchar(50),
@CodigoNivel varchar(2)
)
AS
BEGIN
	
	declare @CodigoRegionx varchar(50) = ''
	,@CodigoZonax varchar(50) = ''
	,@ExisteRegistro int = 0
	,@CodigoPrograma varchar(50) = ''
	,@add bit = 1

	
	select @ExisteRegistro = COUNT(1)
	from ods.ConfiguracionProgramaNuevasUA
	where CodigoRegion = @CodigoRegion
	

	if @ExisteRegistro > 0
	begin
			--set @add = 0
			set @CodigoPrograma = ''

			select @CodigoPrograma = isnull(c.CodigoPrograma, '')
			from  ods.premiosprogramanuevas c
				inner join ods.ConfiguracionProgramaNuevasUA cua 
					on cua.CodigoPrograma = c.CodigoPrograma
			where cua.CodigoRegion = @CodigoRegion
				and c.AnoCampana = @Campania
				and c.CodigoNivel = @CodigoNivel
				and c.PrecioUnitario > 0

			set @CodigoPrograma = LTRIM(RTRIM(isnull(@CodigoPrograma, '')))

			if @CodigoPrograma != ''
			begin
					--set @add = 1
					set @CodigoZonax = ''
			
					select @CodigoZonax = isnull(CodigoZona, '')
					from ods.ConfiguracionProgramaNuevasUA
					where codigoprograma = @CodigoPrograma
						and CodigoRegion = @CodigoRegion
						--and CodigoZona = @CodigoZona

					set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))

					if @CodigoZonax != ''
					begin
					
						set @add = 0
						set @CodigoZonax = ''
			
						select @CodigoZonax = isnull(CodigoZona, '')
						from ods.ConfiguracionProgramaNuevasUA
						where codigoprograma = @CodigoPrograma
							and CodigoRegion = @CodigoRegion
							and CodigoZona = @CodigoZona

						set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))
						if @CodigoZonax != ''
							set @add = 1
						
					end

			end

	end

	
	if @add = 1
	begin

			select 
					 CodigoPrograma
					,CUV as CUVKit
			from  ods.premiosprogramanuevas
			where AnoCampana = @Campania and CodigoNivel = @CodigoNivel
				and PrecioUnitario > 0
				and (CodigoPrograma = @CodigoPrograma or @CodigoPrograma = '')


	end

END
GO
/*end*/

USE BelcorpEcuador
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
(
@Campania varchar(50),
@CodigoRegion varchar(50),
@CodigoZona varchar(50),
@CodigoNivel varchar(2)
)
AS
BEGIN
	
	declare @CodigoRegionx varchar(50) = ''
	,@CodigoZonax varchar(50) = ''
	,@ExisteRegistro int = 0
	,@CodigoPrograma varchar(50) = ''
	,@add bit = 1

	
	select @ExisteRegistro = COUNT(1)
	from ods.ConfiguracionProgramaNuevasUA
	where CodigoRegion = @CodigoRegion
	

	if @ExisteRegistro > 0
	begin
			--set @add = 0
			set @CodigoPrograma = ''

			select @CodigoPrograma = isnull(c.CodigoPrograma, '')
			from  ods.premiosprogramanuevas c
				inner join ods.ConfiguracionProgramaNuevasUA cua 
					on cua.CodigoPrograma = c.CodigoPrograma
			where cua.CodigoRegion = @CodigoRegion
				and c.AnoCampana = @Campania
				and c.CodigoNivel = @CodigoNivel
				and c.PrecioUnitario > 0

			set @CodigoPrograma = LTRIM(RTRIM(isnull(@CodigoPrograma, '')))

			if @CodigoPrograma != ''
			begin
					--set @add = 1
					set @CodigoZonax = ''
			
					select @CodigoZonax = isnull(CodigoZona, '')
					from ods.ConfiguracionProgramaNuevasUA
					where codigoprograma = @CodigoPrograma
						and CodigoRegion = @CodigoRegion
						--and CodigoZona = @CodigoZona

					set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))

					if @CodigoZonax != ''
					begin
					
						set @add = 0
						set @CodigoZonax = ''
			
						select @CodigoZonax = isnull(CodigoZona, '')
						from ods.ConfiguracionProgramaNuevasUA
						where codigoprograma = @CodigoPrograma
							and CodigoRegion = @CodigoRegion
							and CodigoZona = @CodigoZona

						set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))
						if @CodigoZonax != ''
							set @add = 1
						
					end

			end

	end

	
	if @add = 1
	begin

			select 
					 CodigoPrograma
					,CUV as CUVKit
			from  ods.premiosprogramanuevas
			where AnoCampana = @Campania and CodigoNivel = @CodigoNivel
				and PrecioUnitario > 0
				and (CodigoPrograma = @CodigoPrograma or @CodigoPrograma = '')


	end

END
GO
/*end*/

USE BelcorpGuatemala
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
(
@Campania varchar(50),
@CodigoRegion varchar(50),
@CodigoZona varchar(50),
@CodigoNivel varchar(2)
)
AS
BEGIN
	
	declare @CodigoRegionx varchar(50) = ''
	,@CodigoZonax varchar(50) = ''
	,@ExisteRegistro int = 0
	,@CodigoPrograma varchar(50) = ''
	,@add bit = 1

	
	select @ExisteRegistro = COUNT(1)
	from ods.ConfiguracionProgramaNuevasUA
	where CodigoRegion = @CodigoRegion
	

	if @ExisteRegistro > 0
	begin
			--set @add = 0
			set @CodigoPrograma = ''

			select @CodigoPrograma = isnull(c.CodigoPrograma, '')
			from  ods.premiosprogramanuevas c
				inner join ods.ConfiguracionProgramaNuevasUA cua 
					on cua.CodigoPrograma = c.CodigoPrograma
			where cua.CodigoRegion = @CodigoRegion
				and c.AnoCampana = @Campania
				and c.CodigoNivel = @CodigoNivel
				and c.PrecioUnitario > 0

			set @CodigoPrograma = LTRIM(RTRIM(isnull(@CodigoPrograma, '')))

			if @CodigoPrograma != ''
			begin
					--set @add = 1
					set @CodigoZonax = ''
			
					select @CodigoZonax = isnull(CodigoZona, '')
					from ods.ConfiguracionProgramaNuevasUA
					where codigoprograma = @CodigoPrograma
						and CodigoRegion = @CodigoRegion
						--and CodigoZona = @CodigoZona

					set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))

					if @CodigoZonax != ''
					begin
					
						set @add = 0
						set @CodigoZonax = ''
			
						select @CodigoZonax = isnull(CodigoZona, '')
						from ods.ConfiguracionProgramaNuevasUA
						where codigoprograma = @CodigoPrograma
							and CodigoRegion = @CodigoRegion
							and CodigoZona = @CodigoZona

						set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))
						if @CodigoZonax != ''
							set @add = 1
						
					end

			end

	end

	
	if @add = 1
	begin

			select 
					 CodigoPrograma
					,CUV as CUVKit
			from  ods.premiosprogramanuevas
			where AnoCampana = @Campania and CodigoNivel = @CodigoNivel
				and PrecioUnitario > 0
				and (CodigoPrograma = @CodigoPrograma or @CodigoPrograma = '')


	end

END
GO
/*end*/

USE BelcorpMexico
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
(
@Campania varchar(50),
@CodigoRegion varchar(50),
@CodigoZona varchar(50),
@CodigoNivel varchar(2)
)
AS
BEGIN
	
	declare @CodigoRegionx varchar(50) = ''
	,@CodigoZonax varchar(50) = ''
	,@ExisteRegistro int = 0
	,@CodigoPrograma varchar(50) = ''
	,@add bit = 1

	
	select @ExisteRegistro = COUNT(1)
	from ods.ConfiguracionProgramaNuevasUA
	where CodigoRegion = @CodigoRegion
	

	if @ExisteRegistro > 0
	begin
			--set @add = 0
			set @CodigoPrograma = ''

			select @CodigoPrograma = isnull(c.CodigoPrograma, '')
			from  ods.premiosprogramanuevas c
				inner join ods.ConfiguracionProgramaNuevasUA cua 
					on cua.CodigoPrograma = c.CodigoPrograma
			where cua.CodigoRegion = @CodigoRegion
				and c.AnoCampana = @Campania
				and c.CodigoNivel = @CodigoNivel
				and c.PrecioUnitario > 0

			set @CodigoPrograma = LTRIM(RTRIM(isnull(@CodigoPrograma, '')))

			if @CodigoPrograma != ''
			begin
					--set @add = 1
					set @CodigoZonax = ''
			
					select @CodigoZonax = isnull(CodigoZona, '')
					from ods.ConfiguracionProgramaNuevasUA
					where codigoprograma = @CodigoPrograma
						and CodigoRegion = @CodigoRegion
						--and CodigoZona = @CodigoZona

					set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))

					if @CodigoZonax != ''
					begin
					
						set @add = 0
						set @CodigoZonax = ''
			
						select @CodigoZonax = isnull(CodigoZona, '')
						from ods.ConfiguracionProgramaNuevasUA
						where codigoprograma = @CodigoPrograma
							and CodigoRegion = @CodigoRegion
							and CodigoZona = @CodigoZona

						set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))
						if @CodigoZonax != ''
							set @add = 1
						
					end

			end

	end

	
	if @add = 1
	begin

			select 
					 CodigoPrograma
					,CUV as CUVKit
			from  ods.premiosprogramanuevas
			where AnoCampana = @Campania and CodigoNivel = @CodigoNivel
				and PrecioUnitario > 0
				and (CodigoPrograma = @CodigoPrograma or @CodigoPrograma = '')


	end

END
GO
/*end*/

USE BelcorpPanama
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
(
@Campania varchar(50),
@CodigoRegion varchar(50),
@CodigoZona varchar(50),
@CodigoNivel varchar(2)
)
AS
BEGIN
	
	declare @CodigoRegionx varchar(50) = ''
	,@CodigoZonax varchar(50) = ''
	,@ExisteRegistro int = 0
	,@CodigoPrograma varchar(50) = ''
	,@add bit = 1

	
	select @ExisteRegistro = COUNT(1)
	from ods.ConfiguracionProgramaNuevasUA
	where CodigoRegion = @CodigoRegion
	

	if @ExisteRegistro > 0
	begin
			--set @add = 0
			set @CodigoPrograma = ''

			select @CodigoPrograma = isnull(c.CodigoPrograma, '')
			from  ods.premiosprogramanuevas c
				inner join ods.ConfiguracionProgramaNuevasUA cua 
					on cua.CodigoPrograma = c.CodigoPrograma
			where cua.CodigoRegion = @CodigoRegion
				and c.AnoCampana = @Campania
				and c.CodigoNivel = @CodigoNivel
				and c.PrecioUnitario > 0

			set @CodigoPrograma = LTRIM(RTRIM(isnull(@CodigoPrograma, '')))

			if @CodigoPrograma != ''
			begin
					--set @add = 1
					set @CodigoZonax = ''
			
					select @CodigoZonax = isnull(CodigoZona, '')
					from ods.ConfiguracionProgramaNuevasUA
					where codigoprograma = @CodigoPrograma
						and CodigoRegion = @CodigoRegion
						--and CodigoZona = @CodigoZona

					set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))

					if @CodigoZonax != ''
					begin
					
						set @add = 0
						set @CodigoZonax = ''
			
						select @CodigoZonax = isnull(CodigoZona, '')
						from ods.ConfiguracionProgramaNuevasUA
						where codigoprograma = @CodigoPrograma
							and CodigoRegion = @CodigoRegion
							and CodigoZona = @CodigoZona

						set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))
						if @CodigoZonax != ''
							set @add = 1
						
					end

			end

	end

	
	if @add = 1
	begin

			select 
					 CodigoPrograma
					,CUV as CUVKit
			from  ods.premiosprogramanuevas
			where AnoCampana = @Campania and CodigoNivel = @CodigoNivel
				and PrecioUnitario > 0
				and (CodigoPrograma = @CodigoPrograma or @CodigoPrograma = '')


	end

END
GO
/*end*/

USE BelcorpPeru
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
(
@Campania varchar(50),
@CodigoRegion varchar(50),
@CodigoZona varchar(50),
@CodigoNivel varchar(2)
)
AS
BEGIN
	
	declare @CodigoRegionx varchar(50) = ''
	,@CodigoZonax varchar(50) = ''
	,@ExisteRegistro int = 0
	,@CodigoPrograma varchar(50) = ''
	,@add bit = 1

	
	select @ExisteRegistro = COUNT(1)
	from ods.ConfiguracionProgramaNuevasUA
	where CodigoRegion = @CodigoRegion
	

	if @ExisteRegistro > 0
	begin
			--set @add = 0
			set @CodigoPrograma = ''

			select @CodigoPrograma = isnull(c.CodigoPrograma, '')
			from  ods.premiosprogramanuevas c
				inner join ods.ConfiguracionProgramaNuevasUA cua 
					on cua.CodigoPrograma = c.CodigoPrograma
			where cua.CodigoRegion = @CodigoRegion
				and c.AnoCampana = @Campania
				and c.CodigoNivel = @CodigoNivel
				and c.PrecioUnitario > 0

			set @CodigoPrograma = LTRIM(RTRIM(isnull(@CodigoPrograma, '')))

			if @CodigoPrograma != ''
			begin
					--set @add = 1
					set @CodigoZonax = ''
			
					select @CodigoZonax = isnull(CodigoZona, '')
					from ods.ConfiguracionProgramaNuevasUA
					where codigoprograma = @CodigoPrograma
						and CodigoRegion = @CodigoRegion
						--and CodigoZona = @CodigoZona

					set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))

					if @CodigoZonax != ''
					begin
					
						set @add = 0
						set @CodigoZonax = ''
			
						select @CodigoZonax = isnull(CodigoZona, '')
						from ods.ConfiguracionProgramaNuevasUA
						where codigoprograma = @CodigoPrograma
							and CodigoRegion = @CodigoRegion
							and CodigoZona = @CodigoZona

						set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))
						if @CodigoZonax != ''
							set @add = 1
						
					end

			end

	end

	
	if @add = 1
	begin

			select 
					 CodigoPrograma
					,CUV as CUVKit
			from  ods.premiosprogramanuevas
			where AnoCampana = @Campania and CodigoNivel = @CodigoNivel
				and PrecioUnitario > 0
				and (CodigoPrograma = @CodigoPrograma or @CodigoPrograma = '')


	end

END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
(
@Campania varchar(50),
@CodigoRegion varchar(50),
@CodigoZona varchar(50),
@CodigoNivel varchar(2)
)
AS
BEGIN
	
	declare @CodigoRegionx varchar(50) = ''
	,@CodigoZonax varchar(50) = ''
	,@ExisteRegistro int = 0
	,@CodigoPrograma varchar(50) = ''
	,@add bit = 1

	
	select @ExisteRegistro = COUNT(1)
	from ods.ConfiguracionProgramaNuevasUA
	where CodigoRegion = @CodigoRegion
	

	if @ExisteRegistro > 0
	begin
			--set @add = 0
			set @CodigoPrograma = ''

			select @CodigoPrograma = isnull(c.CodigoPrograma, '')
			from  ods.premiosprogramanuevas c
				inner join ods.ConfiguracionProgramaNuevasUA cua 
					on cua.CodigoPrograma = c.CodigoPrograma
			where cua.CodigoRegion = @CodigoRegion
				and c.AnoCampana = @Campania
				and c.CodigoNivel = @CodigoNivel
				and c.PrecioUnitario > 0

			set @CodigoPrograma = LTRIM(RTRIM(isnull(@CodigoPrograma, '')))

			if @CodigoPrograma != ''
			begin
					--set @add = 1
					set @CodigoZonax = ''
			
					select @CodigoZonax = isnull(CodigoZona, '')
					from ods.ConfiguracionProgramaNuevasUA
					where codigoprograma = @CodigoPrograma
						and CodigoRegion = @CodigoRegion
						--and CodigoZona = @CodigoZona

					set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))

					if @CodigoZonax != ''
					begin
					
						set @add = 0
						set @CodigoZonax = ''
			
						select @CodigoZonax = isnull(CodigoZona, '')
						from ods.ConfiguracionProgramaNuevasUA
						where codigoprograma = @CodigoPrograma
							and CodigoRegion = @CodigoRegion
							and CodigoZona = @CodigoZona

						set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))
						if @CodigoZonax != ''
							set @add = 1
						
					end

			end

	end

	
	if @add = 1
	begin

			select 
					 CodigoPrograma
					,CUV as CUVKit
			from  ods.premiosprogramanuevas
			where AnoCampana = @Campania and CodigoNivel = @CodigoNivel
				and PrecioUnitario > 0
				and (CodigoPrograma = @CodigoPrograma or @CodigoPrograma = '')


	end

END
GO
/*end*/

USE BelcorpSalvador
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
(
@Campania varchar(50),
@CodigoRegion varchar(50),
@CodigoZona varchar(50),
@CodigoNivel varchar(2)
)
AS
BEGIN
	
	declare @CodigoRegionx varchar(50) = ''
	,@CodigoZonax varchar(50) = ''
	,@ExisteRegistro int = 0
	,@CodigoPrograma varchar(50) = ''
	,@add bit = 1

	
	select @ExisteRegistro = COUNT(1)
	from ods.ConfiguracionProgramaNuevasUA
	where CodigoRegion = @CodigoRegion
	

	if @ExisteRegistro > 0
	begin
			--set @add = 0
			set @CodigoPrograma = ''

			select @CodigoPrograma = isnull(c.CodigoPrograma, '')
			from  ods.premiosprogramanuevas c
				inner join ods.ConfiguracionProgramaNuevasUA cua 
					on cua.CodigoPrograma = c.CodigoPrograma
			where cua.CodigoRegion = @CodigoRegion
				and c.AnoCampana = @Campania
				and c.CodigoNivel = @CodigoNivel
				and c.PrecioUnitario > 0

			set @CodigoPrograma = LTRIM(RTRIM(isnull(@CodigoPrograma, '')))

			if @CodigoPrograma != ''
			begin
					--set @add = 1
					set @CodigoZonax = ''
			
					select @CodigoZonax = isnull(CodigoZona, '')
					from ods.ConfiguracionProgramaNuevasUA
					where codigoprograma = @CodigoPrograma
						and CodigoRegion = @CodigoRegion
						--and CodigoZona = @CodigoZona

					set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))

					if @CodigoZonax != ''
					begin
					
						set @add = 0
						set @CodigoZonax = ''
			
						select @CodigoZonax = isnull(CodigoZona, '')
						from ods.ConfiguracionProgramaNuevasUA
						where codigoprograma = @CodigoPrograma
							and CodigoRegion = @CodigoRegion
							and CodigoZona = @CodigoZona

						set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))
						if @CodigoZonax != ''
							set @add = 1
						
					end

			end

	end

	
	if @add = 1
	begin

			select 
					 CodigoPrograma
					,CUV as CUVKit
			from  ods.premiosprogramanuevas
			where AnoCampana = @Campania and CodigoNivel = @CodigoNivel
				and PrecioUnitario > 0
				and (CodigoPrograma = @CodigoPrograma or @CodigoPrograma = '')


	end

END
GO