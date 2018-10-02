GO
USE BelcorpPeru
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoEstrategiaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoEstrategiaId]
GO
CREATE FUNCTION [fnGetTipoEstrategiaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	select @tipoId = TipoEstrategiaId  from TipoEstrategia where Codigo = @EstrategiaCodigo

	return @tipoId
end
GO

GO
USE BelcorpMexico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoEstrategiaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoEstrategiaId]
GO
CREATE FUNCTION [fnGetTipoEstrategiaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	select @tipoId = TipoEstrategiaId  from TipoEstrategia where Codigo = @EstrategiaCodigo

	return @tipoId
end
GO

GO
USE BelcorpColombia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoEstrategiaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoEstrategiaId]
GO
CREATE FUNCTION [fnGetTipoEstrategiaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	select @tipoId = TipoEstrategiaId  from TipoEstrategia where Codigo = @EstrategiaCodigo

	return @tipoId
end
GO

GO
USE BelcorpSalvador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoEstrategiaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoEstrategiaId]
GO
CREATE FUNCTION [fnGetTipoEstrategiaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	select @tipoId = TipoEstrategiaId  from TipoEstrategia where Codigo = @EstrategiaCodigo

	return @tipoId
end
GO

GO
USE BelcorpPuertoRico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoEstrategiaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoEstrategiaId]
GO
CREATE FUNCTION [fnGetTipoEstrategiaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	select @tipoId = TipoEstrategiaId  from TipoEstrategia where Codigo = @EstrategiaCodigo

	return @tipoId
end
GO

GO
USE BelcorpPanama
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoEstrategiaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoEstrategiaId]
GO
CREATE FUNCTION [fnGetTipoEstrategiaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	select @tipoId = TipoEstrategiaId  from TipoEstrategia where Codigo = @EstrategiaCodigo

	return @tipoId
end
GO

GO
USE BelcorpGuatemala
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoEstrategiaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoEstrategiaId]
GO
CREATE FUNCTION [fnGetTipoEstrategiaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	select @tipoId = TipoEstrategiaId  from TipoEstrategia where Codigo = @EstrategiaCodigo

	return @tipoId
end
GO

GO
USE BelcorpEcuador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoEstrategiaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoEstrategiaId]
GO
CREATE FUNCTION [fnGetTipoEstrategiaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	select @tipoId = TipoEstrategiaId  from TipoEstrategia where Codigo = @EstrategiaCodigo

	return @tipoId
end
GO

GO
USE BelcorpDominicana
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoEstrategiaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoEstrategiaId]
GO
CREATE FUNCTION [fnGetTipoEstrategiaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	select @tipoId = TipoEstrategiaId  from TipoEstrategia where Codigo = @EstrategiaCodigo

	return @tipoId
end
GO

GO
USE BelcorpCostaRica
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoEstrategiaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoEstrategiaId]
GO
CREATE FUNCTION [fnGetTipoEstrategiaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	select @tipoId = TipoEstrategiaId  from TipoEstrategia where Codigo = @EstrategiaCodigo

	return @tipoId
end
GO

GO
USE BelcorpChile
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoEstrategiaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoEstrategiaId]
GO
CREATE FUNCTION [fnGetTipoEstrategiaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	select @tipoId = TipoEstrategiaId  from TipoEstrategia where Codigo = @EstrategiaCodigo

	return @tipoId
end
GO

GO
USE BelcorpBolivia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoEstrategiaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoEstrategiaId]
GO
CREATE FUNCTION [fnGetTipoEstrategiaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	select @tipoId = TipoEstrategiaId  from TipoEstrategia where Codigo = @EstrategiaCodigo

	return @tipoId
end
GO

GO
