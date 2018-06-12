GO
USE BelcorpPeru
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasPersonalizadasTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
GO
CREATE PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
(
	@TipoConfigurado int,
	@NroLote int
)
as
/*
exec GetCantidadOfertasPersonalizadasTemporal 201618,1
*/
begin
	declare @resultado int = 0

	if @TipoConfigurado = 0
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where NumeroLote = @NroLote
	end
	else if @TipoConfigurado = 1
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion != ''
			and NumeroLote = @NroLote
	end
	else
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion = ''
			and NumeroLote = @NroLote
	end
	select @resultado
end
go

GO
USE BelcorpMexico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasPersonalizadasTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
GO
CREATE PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
(
	@TipoConfigurado int,
	@NroLote int
)
as
/*
exec GetCantidadOfertasPersonalizadasTemporal 201618,1
*/
begin
	declare @resultado int = 0

	if @TipoConfigurado = 0
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where NumeroLote = @NroLote
	end
	else if @TipoConfigurado = 1
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion != ''
			and NumeroLote = @NroLote
	end
	else
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion = ''
			and NumeroLote = @NroLote
	end
	select @resultado
end
go

GO
USE BelcorpColombia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasPersonalizadasTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
GO
CREATE PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
(
	@TipoConfigurado int,
	@NroLote int
)
as
/*
exec GetCantidadOfertasPersonalizadasTemporal 201618,1
*/
begin
	declare @resultado int = 0

	if @TipoConfigurado = 0
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where NumeroLote = @NroLote
	end
	else if @TipoConfigurado = 1
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion != ''
			and NumeroLote = @NroLote
	end
	else
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion = ''
			and NumeroLote = @NroLote
	end
	select @resultado
end
go

GO
USE BelcorpSalvador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasPersonalizadasTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
GO
CREATE PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
(
	@TipoConfigurado int,
	@NroLote int
)
as
/*
exec GetCantidadOfertasPersonalizadasTemporal 201618,1
*/
begin
	declare @resultado int = 0

	if @TipoConfigurado = 0
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where NumeroLote = @NroLote
	end
	else if @TipoConfigurado = 1
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion != ''
			and NumeroLote = @NroLote
	end
	else
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion = ''
			and NumeroLote = @NroLote
	end
	select @resultado
end
go

GO
USE BelcorpPuertoRico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasPersonalizadasTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
GO
CREATE PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
(
	@TipoConfigurado int,
	@NroLote int
)
as
/*
exec GetCantidadOfertasPersonalizadasTemporal 201618,1
*/
begin
	declare @resultado int = 0

	if @TipoConfigurado = 0
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where NumeroLote = @NroLote
	end
	else if @TipoConfigurado = 1
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion != ''
			and NumeroLote = @NroLote
	end
	else
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion = ''
			and NumeroLote = @NroLote
	end
	select @resultado
end
go

GO
USE BelcorpPanama
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasPersonalizadasTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
GO
CREATE PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
(
	@TipoConfigurado int,
	@NroLote int
)
as
/*
exec GetCantidadOfertasPersonalizadasTemporal 201618,1
*/
begin
	declare @resultado int = 0

	if @TipoConfigurado = 0
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where NumeroLote = @NroLote
	end
	else if @TipoConfigurado = 1
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion != ''
			and NumeroLote = @NroLote
	end
	else
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion = ''
			and NumeroLote = @NroLote
	end
	select @resultado
end
go

GO
USE BelcorpGuatemala
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasPersonalizadasTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
GO
CREATE PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
(
	@TipoConfigurado int,
	@NroLote int
)
as
/*
exec GetCantidadOfertasPersonalizadasTemporal 201618,1
*/
begin
	declare @resultado int = 0

	if @TipoConfigurado = 0
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where NumeroLote = @NroLote
	end
	else if @TipoConfigurado = 1
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion != ''
			and NumeroLote = @NroLote
	end
	else
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion = ''
			and NumeroLote = @NroLote
	end
	select @resultado
end
go

GO
USE BelcorpEcuador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasPersonalizadasTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
GO
CREATE PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
(
	@TipoConfigurado int,
	@NroLote int
)
as
/*
exec GetCantidadOfertasPersonalizadasTemporal 201618,1
*/
begin
	declare @resultado int = 0

	if @TipoConfigurado = 0
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where NumeroLote = @NroLote
	end
	else if @TipoConfigurado = 1
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion != ''
			and NumeroLote = @NroLote
	end
	else
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion = ''
			and NumeroLote = @NroLote
	end
	select @resultado
end
go

GO
USE BelcorpDominicana
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasPersonalizadasTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
GO
CREATE PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
(
	@TipoConfigurado int,
	@NroLote int
)
as
/*
exec GetCantidadOfertasPersonalizadasTemporal 201618,1
*/
begin
	declare @resultado int = 0

	if @TipoConfigurado = 0
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where NumeroLote = @NroLote
	end
	else if @TipoConfigurado = 1
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion != ''
			and NumeroLote = @NroLote
	end
	else
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion = ''
			and NumeroLote = @NroLote
	end
	select @resultado
end
go

GO
USE BelcorpCostaRica
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasPersonalizadasTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
GO
CREATE PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
(
	@TipoConfigurado int,
	@NroLote int
)
as
/*
exec GetCantidadOfertasPersonalizadasTemporal 201618,1
*/
begin
	declare @resultado int = 0

	if @TipoConfigurado = 0
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where NumeroLote = @NroLote
	end
	else if @TipoConfigurado = 1
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion != ''
			and NumeroLote = @NroLote
	end
	else
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion = ''
			and NumeroLote = @NroLote
	end
	select @resultado
end
go

GO
USE BelcorpChile
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasPersonalizadasTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
GO
CREATE PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
(
	@TipoConfigurado int,
	@NroLote int
)
as
/*
exec GetCantidadOfertasPersonalizadasTemporal 201618,1
*/
begin
	declare @resultado int = 0

	if @TipoConfigurado = 0
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where NumeroLote = @NroLote
	end
	else if @TipoConfigurado = 1
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion != ''
			and NumeroLote = @NroLote
	end
	else
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion = ''
			and NumeroLote = @NroLote
	end
	select @resultado
end
go

GO
USE BelcorpBolivia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasPersonalizadasTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
GO
CREATE PROCEDURE dbo.GetCantidadOfertasPersonalizadasTemporal
(
	@TipoConfigurado int,
	@NroLote int
)
as
/*
exec GetCantidadOfertasPersonalizadasTemporal 201618,1
*/
begin
	declare @resultado int = 0

	if @TipoConfigurado = 0
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where NumeroLote = @NroLote
	end
	else if @TipoConfigurado = 1
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion != ''
			and NumeroLote = @NroLote
	end
	else
	begin
		select @resultado = count(*)
		from EstrategiaTemporal
		where Descripcion = ''
			and NumeroLote = @NroLote
	end
	select @resultado
end
go

GO
