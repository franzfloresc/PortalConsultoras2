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

