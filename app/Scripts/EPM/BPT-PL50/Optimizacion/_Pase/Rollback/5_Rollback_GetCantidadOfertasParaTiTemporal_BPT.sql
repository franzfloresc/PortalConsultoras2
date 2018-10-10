GO
USE BelcorpPeru
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTiTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO
create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	if @TipoConfigurado = 0
	begin
		select @resultado = count(*) from EstrategiaTemporal
		where
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end
GO

GO
USE BelcorpMexico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTiTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO
create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	if @TipoConfigurado = 0
	begin
		select @resultado = count(*) from EstrategiaTemporal
		where
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end
GO

GO
USE BelcorpColombia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTiTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO
create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	if @TipoConfigurado = 0
	begin
		select @resultado = count(*) from EstrategiaTemporal
		where
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end
GO

GO
USE BelcorpSalvador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTiTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO
create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	if @TipoConfigurado = 0
	begin
		select @resultado = count(*) from EstrategiaTemporal
		where
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end
GO

GO
USE BelcorpPuertoRico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTiTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO
create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	if @TipoConfigurado = 0
	begin
		select @resultado = count(*) from EstrategiaTemporal
		where
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end
GO

GO
USE BelcorpPanama
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTiTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO
create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	if @TipoConfigurado = 0
	begin
		select @resultado = count(*) from EstrategiaTemporal
		where
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end
GO

GO
USE BelcorpGuatemala
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTiTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO
create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	if @TipoConfigurado = 0
	begin
		select @resultado = count(*) from EstrategiaTemporal
		where
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end
GO

GO
USE BelcorpEcuador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTiTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO
create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	if @TipoConfigurado = 0
	begin
		select @resultado = count(*) from EstrategiaTemporal
		where
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end
GO

GO
USE BelcorpDominicana
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTiTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO
create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	if @TipoConfigurado = 0
	begin
		select @resultado = count(*) from EstrategiaTemporal
		where
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end
GO

GO
USE BelcorpCostaRica
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTiTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO
create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	if @TipoConfigurado = 0
	begin
		select @resultado = count(*) from EstrategiaTemporal
		where
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end
GO

GO
USE BelcorpChile
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTiTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO
create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	if @TipoConfigurado = 0
	begin
		select @resultado = count(*) from EstrategiaTemporal
		where
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end
GO

GO
USE BelcorpBolivia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTiTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO
create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	if @TipoConfigurado = 0
	begin
		select @resultado = count(*) from EstrategiaTemporal
		where
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end
GO

GO
