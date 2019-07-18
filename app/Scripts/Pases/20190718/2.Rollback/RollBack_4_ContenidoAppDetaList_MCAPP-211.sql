USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
Declare @numReg AS int;
set @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = @IdContenido);
	SELECT
		top (@numReg)
		*	
	FROM dbo.ContenidoAppDeta AS P with(nolock)
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;

END

GO
USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
Declare @numReg AS int;
set @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = @IdContenido);
	SELECT
		top (@numReg)
		*	
	FROM dbo.ContenidoAppDeta AS P with(nolock)
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;

END

GO
USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
Declare @numReg AS int;
set @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = @IdContenido);
	SELECT
		top (@numReg)
		*	
	FROM dbo.ContenidoAppDeta AS P with(nolock)
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;

END

GO
USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
Declare @numReg AS int;
set @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = @IdContenido);
	SELECT
		top (@numReg)
		*	
	FROM dbo.ContenidoAppDeta AS P with(nolock)
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;

END

GO
USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
Declare @numReg AS int;
set @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = @IdContenido);
	SELECT
		top (@numReg)
		*	
	FROM dbo.ContenidoAppDeta AS P with(nolock)
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;

END

GO
USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
Declare @numReg AS int;
set @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = @IdContenido);
	SELECT
		top (@numReg)
		*	
	FROM dbo.ContenidoAppDeta AS P with(nolock)
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;

END

GO
USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
Declare @numReg AS int;
set @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = @IdContenido);
	SELECT
		top (@numReg)
		*	
	FROM dbo.ContenidoAppDeta AS P with(nolock)
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;

END

GO
USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
Declare @numReg AS int;
set @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = @IdContenido);
	SELECT
		top (@numReg)
		*	
	FROM dbo.ContenidoAppDeta AS P with(nolock)
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;

END

GO
USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
Declare @numReg AS int;
set @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = @IdContenido);
	SELECT
		top (@numReg)
		*	
	FROM dbo.ContenidoAppDeta AS P with(nolock)
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;

END

GO
USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
Declare @numReg AS int;
set @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = @IdContenido);
	SELECT
		top (@numReg)
		*	
	FROM dbo.ContenidoAppDeta AS P with(nolock)
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;

END

GO
USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
Declare @numReg AS int;
set @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = @IdContenido);
	SELECT
		top (@numReg)
		*	
	FROM dbo.ContenidoAppDeta AS P with(nolock)
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;

END

GO
USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
Declare @numReg AS int;
set @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = @IdContenido);
	SELECT
		top (@numReg)
		*	
	FROM dbo.ContenidoAppDeta AS P with(nolock)
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;

END

