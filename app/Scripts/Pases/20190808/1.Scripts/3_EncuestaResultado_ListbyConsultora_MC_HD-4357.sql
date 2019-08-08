GO
USE BelcorpPeru
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultado_ListbyConsultora]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultado_ListbyConsultora] AS'
END
GO
ALTER PROCEDURE EncuestaResultado_ListbyConsultora
@CodigoConsultora nvarchar(50)
AS
BEGIN

	SELECT A.Id AS EncuestaResultadoId,
	       A.CodigoConsultora,
	       A.CodigoCampania,
		   E.ConsultoraID,
		   A.SeleccionoMotivo AS FlagTieneEncuesta
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	WHERE A.CodigoConsultora=@CodigoConsultora
	ORDER BY A.CodigoCampania DESC

END


GO
USE BelcorpMexico
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultado_ListbyConsultora]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultado_ListbyConsultora] AS'
END
GO
ALTER PROCEDURE EncuestaResultado_ListbyConsultora
@CodigoConsultora nvarchar(50)
AS
BEGIN

	SELECT A.Id AS EncuestaResultadoId,
	       A.CodigoConsultora,
	       A.CodigoCampania,
		   E.ConsultoraID,
		   A.SeleccionoMotivo AS FlagTieneEncuesta
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	WHERE A.CodigoConsultora=@CodigoConsultora
	ORDER BY A.CodigoCampania DESC

END


GO
USE BelcorpColombia
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultado_ListbyConsultora]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultado_ListbyConsultora] AS'
END
GO
ALTER PROCEDURE EncuestaResultado_ListbyConsultora
@CodigoConsultora nvarchar(50)
AS
BEGIN

	SELECT A.Id AS EncuestaResultadoId,
	       A.CodigoConsultora,
	       A.CodigoCampania,
		   E.ConsultoraID,
		   A.SeleccionoMotivo AS FlagTieneEncuesta
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	WHERE A.CodigoConsultora=@CodigoConsultora
	ORDER BY A.CodigoCampania DESC

END


GO
USE BelcorpSalvador
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultado_ListbyConsultora]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultado_ListbyConsultora] AS'
END
GO
ALTER PROCEDURE EncuestaResultado_ListbyConsultora
@CodigoConsultora nvarchar(50)
AS
BEGIN

	SELECT A.Id AS EncuestaResultadoId,
	       A.CodigoConsultora,
	       A.CodigoCampania,
		   E.ConsultoraID,
		   A.SeleccionoMotivo AS FlagTieneEncuesta
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	WHERE A.CodigoConsultora=@CodigoConsultora
	ORDER BY A.CodigoCampania DESC

END


GO
USE BelcorpPuertoRico
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultado_ListbyConsultora]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultado_ListbyConsultora] AS'
END
GO
ALTER PROCEDURE EncuestaResultado_ListbyConsultora
@CodigoConsultora nvarchar(50)
AS
BEGIN

	SELECT A.Id AS EncuestaResultadoId,
	       A.CodigoConsultora,
	       A.CodigoCampania,
		   E.ConsultoraID,
		   A.SeleccionoMotivo AS FlagTieneEncuesta
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	WHERE A.CodigoConsultora=@CodigoConsultora
	ORDER BY A.CodigoCampania DESC

END


GO
USE BelcorpPanama
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultado_ListbyConsultora]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultado_ListbyConsultora] AS'
END
GO
ALTER PROCEDURE EncuestaResultado_ListbyConsultora
@CodigoConsultora nvarchar(50)
AS
BEGIN

	SELECT A.Id AS EncuestaResultadoId,
	       A.CodigoConsultora,
	       A.CodigoCampania,
		   E.ConsultoraID,
		   A.SeleccionoMotivo AS FlagTieneEncuesta
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	WHERE A.CodigoConsultora=@CodigoConsultora
	ORDER BY A.CodigoCampania DESC

END


GO
USE BelcorpGuatemala
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultado_ListbyConsultora]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultado_ListbyConsultora] AS'
END
GO
ALTER PROCEDURE EncuestaResultado_ListbyConsultora
@CodigoConsultora nvarchar(50)
AS
BEGIN

	SELECT A.Id AS EncuestaResultadoId,
	       A.CodigoConsultora,
	       A.CodigoCampania,
		   E.ConsultoraID,
		   A.SeleccionoMotivo AS FlagTieneEncuesta
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	WHERE A.CodigoConsultora=@CodigoConsultora
	ORDER BY A.CodigoCampania DESC

END


GO
USE BelcorpEcuador
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultado_ListbyConsultora]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultado_ListbyConsultora] AS'
END
GO
ALTER PROCEDURE EncuestaResultado_ListbyConsultora
@CodigoConsultora nvarchar(50)
AS
BEGIN

	SELECT A.Id AS EncuestaResultadoId,
	       A.CodigoConsultora,
	       A.CodigoCampania,
		   E.ConsultoraID,
		   A.SeleccionoMotivo AS FlagTieneEncuesta
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	WHERE A.CodigoConsultora=@CodigoConsultora
	ORDER BY A.CodigoCampania DESC

END


GO
USE BelcorpDominicana
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultado_ListbyConsultora]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultado_ListbyConsultora] AS'
END
GO
ALTER PROCEDURE EncuestaResultado_ListbyConsultora
@CodigoConsultora nvarchar(50)
AS
BEGIN

	SELECT A.Id AS EncuestaResultadoId,
	       A.CodigoConsultora,
	       A.CodigoCampania,
		   E.ConsultoraID,
		   A.SeleccionoMotivo AS FlagTieneEncuesta
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	WHERE A.CodigoConsultora=@CodigoConsultora
	ORDER BY A.CodigoCampania DESC

END


GO
USE BelcorpCostaRica
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultado_ListbyConsultora]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultado_ListbyConsultora] AS'
END
GO
ALTER PROCEDURE EncuestaResultado_ListbyConsultora
@CodigoConsultora nvarchar(50)
AS
BEGIN

	SELECT A.Id AS EncuestaResultadoId,
	       A.CodigoConsultora,
	       A.CodigoCampania,
		   E.ConsultoraID,
		   A.SeleccionoMotivo AS FlagTieneEncuesta
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	WHERE A.CodigoConsultora=@CodigoConsultora
	ORDER BY A.CodigoCampania DESC

END


GO
USE BelcorpChile
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultado_ListbyConsultora]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultado_ListbyConsultora] AS'
END
GO
ALTER PROCEDURE EncuestaResultado_ListbyConsultora
@CodigoConsultora nvarchar(50)
AS
BEGIN

	SELECT A.Id AS EncuestaResultadoId,
	       A.CodigoConsultora,
	       A.CodigoCampania,
		   E.ConsultoraID,
		   A.SeleccionoMotivo AS FlagTieneEncuesta
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	WHERE A.CodigoConsultora=@CodigoConsultora
	ORDER BY A.CodigoCampania DESC

END


GO
USE BelcorpBolivia
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultado_ListbyConsultora]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultado_ListbyConsultora] AS'
END
GO
ALTER PROCEDURE EncuestaResultado_ListbyConsultora
@CodigoConsultora nvarchar(50)
AS
BEGIN

	SELECT A.Id AS EncuestaResultadoId,
	       A.CodigoConsultora,
	       A.CodigoCampania,
		   E.ConsultoraID,
		   A.SeleccionoMotivo AS FlagTieneEncuesta
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	WHERE A.CodigoConsultora=@CodigoConsultora
	ORDER BY A.CodigoCampania DESC

END


GO
