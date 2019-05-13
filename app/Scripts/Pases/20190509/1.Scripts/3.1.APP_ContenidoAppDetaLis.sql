USE BelcorpPeru
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
	SELECT
		P.IdContenidoDeta,
		P.IdContenido,
		P.CodigoDetalle,
		P.Descripcion,
		P.RutaContenido,
		P.Accion,
		P.Orden,
		P.Tipo,
		P.Estado		
	FROM dbo.ContenidoAppDeta AS P
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;
END

GO

USE BelcorpMexico
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
	SELECT
		P.IdContenidoDeta,
		P.IdContenido,
		P.CodigoDetalle,
		P.Descripcion,
		P.RutaContenido,
		P.Accion,
		P.Orden,
		P.Tipo,
		P.Estado		
	FROM dbo.ContenidoAppDeta AS P
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;
END

GO

USE BelcorpColombia
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
	SELECT
		P.IdContenidoDeta,
		P.IdContenido,
		P.CodigoDetalle,
		P.Descripcion,
		P.RutaContenido,
		P.Accion,
		P.Orden,
		P.Tipo,
		P.Estado		
	FROM dbo.ContenidoAppDeta AS P
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;
END

GO

USE BelcorpSalvador
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
	SELECT
		P.IdContenidoDeta,
		P.IdContenido,
		P.CodigoDetalle,
		P.Descripcion,
		P.RutaContenido,
		P.Accion,
		P.Orden,
		P.Tipo,
		P.Estado		
	FROM dbo.ContenidoAppDeta AS P
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;
END

GO

USE BelcorpPuertoRico
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
	SELECT
		P.IdContenidoDeta,
		P.IdContenido,
		P.CodigoDetalle,
		P.Descripcion,
		P.RutaContenido,
		P.Accion,
		P.Orden,
		P.Tipo,
		P.Estado		
	FROM dbo.ContenidoAppDeta AS P
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;
END

GO

USE BelcorpPanama
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
	SELECT
		P.IdContenidoDeta,
		P.IdContenido,
		P.CodigoDetalle,
		P.Descripcion,
		P.RutaContenido,
		P.Accion,
		P.Orden,
		P.Tipo,
		P.Estado		
	FROM dbo.ContenidoAppDeta AS P
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;
END

GO

USE BelcorpGuatemala
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
	SELECT
		P.IdContenidoDeta,
		P.IdContenido,
		P.CodigoDetalle,
		P.Descripcion,
		P.RutaContenido,
		P.Accion,
		P.Orden,
		P.Tipo,
		P.Estado		
	FROM dbo.ContenidoAppDeta AS P
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;
END

GO

USE BelcorpEcuador
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
	SELECT
		P.IdContenidoDeta,
		P.IdContenido,
		P.CodigoDetalle,
		P.Descripcion,
		P.RutaContenido,
		P.Accion,
		P.Orden,
		P.Tipo,
		P.Estado		
	FROM dbo.ContenidoAppDeta AS P
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;
END

GO

USE BelcorpDominicana
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
	SELECT
		P.IdContenidoDeta,
		P.IdContenido,
		P.CodigoDetalle,
		P.Descripcion,
		P.RutaContenido,
		P.Accion,
		P.Orden,
		P.Tipo,
		P.Estado		
	FROM dbo.ContenidoAppDeta AS P
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;
END

GO

USE BelcorpCostaRica
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
	SELECT
		P.IdContenidoDeta,
		P.IdContenido,
		P.CodigoDetalle,
		P.Descripcion,
		P.RutaContenido,
		P.Accion,
		P.Orden,
		P.Tipo,
		P.Estado		
	FROM dbo.ContenidoAppDeta AS P
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;
END

GO

USE BelcorpChile
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
	SELECT
		P.IdContenidoDeta,
		P.IdContenido,
		P.CodigoDetalle,
		P.Descripcion,
		P.RutaContenido,
		P.Accion,
		P.Orden,
		P.Tipo,
		P.Estado		
	FROM dbo.ContenidoAppDeta AS P
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;
END

GO

USE BelcorpBolivia
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int
AS
BEGIN
	
	SELECT
		P.IdContenidoDeta,
		P.IdContenido,
		P.CodigoDetalle,
		P.Descripcion,
		P.RutaContenido,
		P.Accion,
		P.Orden,
		P.Tipo,
		P.Estado		
	FROM dbo.ContenidoAppDeta AS P
	WHERE
		P.IdContenido = @IdContenido AND
		P.Estado = 1
		order by P.Orden ASC;
END

GO