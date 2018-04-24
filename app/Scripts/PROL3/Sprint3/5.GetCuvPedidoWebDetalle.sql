USE BelcorpPeru
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCuvPedidoWebDetalle')
BEGIN
	DROP PROC GetCuvPedidoWebDetalle
END
GO
CREATE PROC GetCuvPedidoWebDetalle
(
@ConsultoraID int,
@CampaniaID int
)
AS
BEGIN
	select 
		Isnull(CUV, '') as cuv,
		Isnull(Cantidad, 0) as cantidad
	from PedidoWebDetalle with(nolock)
	where ConsultoraID = @ConsultoraID 
	and CampaniaID = @CampaniaID 
END
GO

USE BelcorpMexico
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCuvPedidoWebDetalle')
BEGIN
	DROP PROC GetCuvPedidoWebDetalle
END
GO
CREATE PROC GetCuvPedidoWebDetalle
(
@ConsultoraID int,
@CampaniaID int
)
AS
BEGIN
	select 
		Isnull(CUV, '') as cuv,
		Isnull(Cantidad, 0) as cantidad
	from PedidoWebDetalle with(nolock)
	where ConsultoraID = @ConsultoraID 
	and CampaniaID = @CampaniaID 
END
GO

USE BelcorpColombia
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCuvPedidoWebDetalle')
BEGIN
	DROP PROC GetCuvPedidoWebDetalle
END
GO
CREATE PROC GetCuvPedidoWebDetalle
(
@ConsultoraID int,
@CampaniaID int
)
AS
BEGIN
	select 
		Isnull(CUV, '') as cuv,
		Isnull(Cantidad, 0) as cantidad
	from PedidoWebDetalle with(nolock)
	where ConsultoraID = @ConsultoraID 
	and CampaniaID = @CampaniaID 
END
GO

USE BelcorpSalvador
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCuvPedidoWebDetalle')
BEGIN
	DROP PROC GetCuvPedidoWebDetalle
END
GO
CREATE PROC GetCuvPedidoWebDetalle
(
@ConsultoraID int,
@CampaniaID int
)
AS
BEGIN
	select 
		Isnull(CUV, '') as cuv,
		Isnull(Cantidad, 0) as cantidad
	from PedidoWebDetalle with(nolock)
	where ConsultoraID = @ConsultoraID 
	and CampaniaID = @CampaniaID 
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCuvPedidoWebDetalle')
BEGIN
	DROP PROC GetCuvPedidoWebDetalle
END
GO
CREATE PROC GetCuvPedidoWebDetalle
(
@ConsultoraID int,
@CampaniaID int
)
AS
BEGIN
	select 
		Isnull(CUV, '') as cuv,
		Isnull(Cantidad, 0) as cantidad
	from PedidoWebDetalle with(nolock)
	where ConsultoraID = @ConsultoraID 
	and CampaniaID = @CampaniaID 
END
GO

USE BelcorpPanama
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCuvPedidoWebDetalle')
BEGIN
	DROP PROC GetCuvPedidoWebDetalle
END
GO
CREATE PROC GetCuvPedidoWebDetalle
(
@ConsultoraID int,
@CampaniaID int
)
AS
BEGIN
	select 
		Isnull(CUV, '') as cuv,
		Isnull(Cantidad, 0) as cantidad
	from PedidoWebDetalle with(nolock)
	where ConsultoraID = @ConsultoraID 
	and CampaniaID = @CampaniaID 
END
GO

USE BelcorpGuatemala
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCuvPedidoWebDetalle')
BEGIN
	DROP PROC GetCuvPedidoWebDetalle
END
GO
CREATE PROC GetCuvPedidoWebDetalle
(
@ConsultoraID int,
@CampaniaID int
)
AS
BEGIN
	select 
		Isnull(CUV, '') as cuv,
		Isnull(Cantidad, 0) as cantidad
	from PedidoWebDetalle with(nolock)
	where ConsultoraID = @ConsultoraID 
	and CampaniaID = @CampaniaID 
END
GO

USE BelcorpEcuador
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCuvPedidoWebDetalle')
BEGIN
	DROP PROC GetCuvPedidoWebDetalle
END
GO
CREATE PROC GetCuvPedidoWebDetalle
(
@ConsultoraID int,
@CampaniaID int
)
AS
BEGIN
	select 
		Isnull(CUV, '') as cuv,
		Isnull(Cantidad, 0) as cantidad
	from PedidoWebDetalle with(nolock)
	where ConsultoraID = @ConsultoraID 
	and CampaniaID = @CampaniaID 
END
GO

USE BelcorpDominicana
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCuvPedidoWebDetalle')
BEGIN
	DROP PROC GetCuvPedidoWebDetalle
END
GO
CREATE PROC GetCuvPedidoWebDetalle
(
@ConsultoraID int,
@CampaniaID int
)
AS
BEGIN
	select 
		Isnull(CUV, '') as cuv,
		Isnull(Cantidad, 0) as cantidad
	from PedidoWebDetalle with(nolock)
	where ConsultoraID = @ConsultoraID 
	and CampaniaID = @CampaniaID 
END
GO

USE BelcorpCostaRica
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCuvPedidoWebDetalle')
BEGIN
	DROP PROC GetCuvPedidoWebDetalle
END
GO
CREATE PROC GetCuvPedidoWebDetalle
(
@ConsultoraID int,
@CampaniaID int
)
AS
BEGIN
	select 
		Isnull(CUV, '') as cuv,
		Isnull(Cantidad, 0) as cantidad
	from PedidoWebDetalle with(nolock)
	where ConsultoraID = @ConsultoraID 
	and CampaniaID = @CampaniaID 
END
GO

USE BelcorpChile
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCuvPedidoWebDetalle')
BEGIN
	DROP PROC GetCuvPedidoWebDetalle
END
GO
CREATE PROC GetCuvPedidoWebDetalle
(
@ConsultoraID int,
@CampaniaID int
)
AS
BEGIN
	select 
		Isnull(CUV, '') as cuv,
		Isnull(Cantidad, 0) as cantidad
	from PedidoWebDetalle with(nolock)
	where ConsultoraID = @ConsultoraID 
	and CampaniaID = @CampaniaID 
END
GO

USE BelcorpBolivia
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCuvPedidoWebDetalle')
BEGIN
	DROP PROC GetCuvPedidoWebDetalle
END
GO
CREATE PROC GetCuvPedidoWebDetalle
(
@ConsultoraID int,
@CampaniaID int
)
AS
BEGIN
	select 
		Isnull(CUV, '') as cuv,
		Isnull(Cantidad, 0) as cantidad
	from PedidoWebDetalle with(nolock)
	where ConsultoraID = @ConsultoraID 
	and CampaniaID = @CampaniaID 
END
GO

