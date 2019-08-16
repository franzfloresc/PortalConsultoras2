GO
USE BelcorpPeru
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultadoDetalle_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultadoDetalle_List] AS'
END
GO
ALTER PROCEDURE EncuestaResultadoDetalle_List
@CodigoCampania varchar(6),
@RegionID int=0,
@ZonaID int=0
AS
BEGIN

	SELECT B.EncuestaResultadoId,
	       A.CodigoCampania,
		   A.CodigoConsultora,
		   E.NombreCompleto AS Consultora,
		   E.RegionID,
		   R.Codigo AS Region,
		   E.ZonaID,
		   Z.Codigo AS Zona,
		   IIF(TipoEncuestaMotivoId=2,B.Observacion,C.Descripcion) AS Motivo,
		   D.Descripcion AS Calificacion
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	INNER JOIN ods.Region R ON E.RegionID=R.Regionid
	INNER JOIN ods.Zona Z ON E.ZonaId=Z.ZonaId
	INNER JOIN dbo.EncuestaResultadoDetalle B ON A.Id=B.EncuestaResultadoId
	INNER JOIN dbo.EncuestaMotivo C ON B.MotivoId=C.Id
	INNER JOIN dbo.EncuestaCalificacion D ON C.EncuestaCalificacionId=D.Id
	WHERE A.CodigoCampania=@CodigoCampania
	AND A.SeleccionoMotivo=1
	AND (E.RegionID=@RegionID OR @RegionID=0)
	AND (E.ZonaID=@ZonaID OR @ZonaID=0)



END


GO
USE BelcorpMexico
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultadoDetalle_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultadoDetalle_List] AS'
END
GO
ALTER PROCEDURE EncuestaResultadoDetalle_List
@CodigoCampania varchar(6),
@RegionID int=0,
@ZonaID int=0
AS
BEGIN

	SELECT B.EncuestaResultadoId,
	       A.CodigoCampania,
		   A.CodigoConsultora,
		   E.NombreCompleto AS Consultora,
		   E.RegionID,
		   R.Codigo AS Region,
		   E.ZonaID,
		   Z.Codigo AS Zona,
		   IIF(TipoEncuestaMotivoId=2,B.Observacion,C.Descripcion) AS Motivo,
		   D.Descripcion AS Calificacion
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	INNER JOIN ods.Region R ON E.RegionID=R.Regionid
	INNER JOIN ods.Zona Z ON E.ZonaId=Z.ZonaId
	INNER JOIN dbo.EncuestaResultadoDetalle B ON A.Id=B.EncuestaResultadoId
	INNER JOIN dbo.EncuestaMotivo C ON B.MotivoId=C.Id
	INNER JOIN dbo.EncuestaCalificacion D ON C.EncuestaCalificacionId=D.Id
	WHERE A.CodigoCampania=@CodigoCampania
	AND A.SeleccionoMotivo=1
	AND (E.RegionID=@RegionID OR @RegionID=0)
	AND (E.ZonaID=@ZonaID OR @ZonaID=0)



END


GO
USE BelcorpColombia
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultadoDetalle_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultadoDetalle_List] AS'
END
GO
ALTER PROCEDURE EncuestaResultadoDetalle_List
@CodigoCampania varchar(6),
@RegionID int=0,
@ZonaID int=0
AS
BEGIN

	SELECT B.EncuestaResultadoId,
	       A.CodigoCampania,
		   A.CodigoConsultora,
		   E.NombreCompleto AS Consultora,
		   E.RegionID,
		   R.Codigo AS Region,
		   E.ZonaID,
		   Z.Codigo AS Zona,
		   IIF(TipoEncuestaMotivoId=2,B.Observacion,C.Descripcion) AS Motivo,
		   D.Descripcion AS Calificacion
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	INNER JOIN ods.Region R ON E.RegionID=R.Regionid
	INNER JOIN ods.Zona Z ON E.ZonaId=Z.ZonaId
	INNER JOIN dbo.EncuestaResultadoDetalle B ON A.Id=B.EncuestaResultadoId
	INNER JOIN dbo.EncuestaMotivo C ON B.MotivoId=C.Id
	INNER JOIN dbo.EncuestaCalificacion D ON C.EncuestaCalificacionId=D.Id
	WHERE A.CodigoCampania=@CodigoCampania
	AND A.SeleccionoMotivo=1
	AND (E.RegionID=@RegionID OR @RegionID=0)
	AND (E.ZonaID=@ZonaID OR @ZonaID=0)



END


GO
USE BelcorpSalvador
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultadoDetalle_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultadoDetalle_List] AS'
END
GO
ALTER PROCEDURE EncuestaResultadoDetalle_List
@CodigoCampania varchar(6),
@RegionID int=0,
@ZonaID int=0
AS
BEGIN

	SELECT B.EncuestaResultadoId,
	       A.CodigoCampania,
		   A.CodigoConsultora,
		   E.NombreCompleto AS Consultora,
		   E.RegionID,
		   R.Codigo AS Region,
		   E.ZonaID,
		   Z.Codigo AS Zona,
		   IIF(TipoEncuestaMotivoId=2,B.Observacion,C.Descripcion) AS Motivo,
		   D.Descripcion AS Calificacion
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	INNER JOIN ods.Region R ON E.RegionID=R.Regionid
	INNER JOIN ods.Zona Z ON E.ZonaId=Z.ZonaId
	INNER JOIN dbo.EncuestaResultadoDetalle B ON A.Id=B.EncuestaResultadoId
	INNER JOIN dbo.EncuestaMotivo C ON B.MotivoId=C.Id
	INNER JOIN dbo.EncuestaCalificacion D ON C.EncuestaCalificacionId=D.Id
	WHERE A.CodigoCampania=@CodigoCampania
	AND A.SeleccionoMotivo=1
	AND (E.RegionID=@RegionID OR @RegionID=0)
	AND (E.ZonaID=@ZonaID OR @ZonaID=0)



END


GO
USE BelcorpPuertoRico
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultadoDetalle_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultadoDetalle_List] AS'
END
GO
ALTER PROCEDURE EncuestaResultadoDetalle_List
@CodigoCampania varchar(6),
@RegionID int=0,
@ZonaID int=0
AS
BEGIN

	SELECT B.EncuestaResultadoId,
	       A.CodigoCampania,
		   A.CodigoConsultora,
		   E.NombreCompleto AS Consultora,
		   E.RegionID,
		   R.Codigo AS Region,
		   E.ZonaID,
		   Z.Codigo AS Zona,
		   IIF(TipoEncuestaMotivoId=2,B.Observacion,C.Descripcion) AS Motivo,
		   D.Descripcion AS Calificacion
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	INNER JOIN ods.Region R ON E.RegionID=R.Regionid
	INNER JOIN ods.Zona Z ON E.ZonaId=Z.ZonaId
	INNER JOIN dbo.EncuestaResultadoDetalle B ON A.Id=B.EncuestaResultadoId
	INNER JOIN dbo.EncuestaMotivo C ON B.MotivoId=C.Id
	INNER JOIN dbo.EncuestaCalificacion D ON C.EncuestaCalificacionId=D.Id
	WHERE A.CodigoCampania=@CodigoCampania
	AND A.SeleccionoMotivo=1
	AND (E.RegionID=@RegionID OR @RegionID=0)
	AND (E.ZonaID=@ZonaID OR @ZonaID=0)



END


GO
USE BelcorpPanama
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultadoDetalle_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultadoDetalle_List] AS'
END
GO
ALTER PROCEDURE EncuestaResultadoDetalle_List
@CodigoCampania varchar(6),
@RegionID int=0,
@ZonaID int=0
AS
BEGIN

	SELECT B.EncuestaResultadoId,
	       A.CodigoCampania,
		   A.CodigoConsultora,
		   E.NombreCompleto AS Consultora,
		   E.RegionID,
		   R.Codigo AS Region,
		   E.ZonaID,
		   Z.Codigo AS Zona,
		   IIF(TipoEncuestaMotivoId=2,B.Observacion,C.Descripcion) AS Motivo,
		   D.Descripcion AS Calificacion
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	INNER JOIN ods.Region R ON E.RegionID=R.Regionid
	INNER JOIN ods.Zona Z ON E.ZonaId=Z.ZonaId
	INNER JOIN dbo.EncuestaResultadoDetalle B ON A.Id=B.EncuestaResultadoId
	INNER JOIN dbo.EncuestaMotivo C ON B.MotivoId=C.Id
	INNER JOIN dbo.EncuestaCalificacion D ON C.EncuestaCalificacionId=D.Id
	WHERE A.CodigoCampania=@CodigoCampania
	AND A.SeleccionoMotivo=1
	AND (E.RegionID=@RegionID OR @RegionID=0)
	AND (E.ZonaID=@ZonaID OR @ZonaID=0)



END


GO
USE BelcorpGuatemala
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultadoDetalle_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultadoDetalle_List] AS'
END
GO
ALTER PROCEDURE EncuestaResultadoDetalle_List
@CodigoCampania varchar(6),
@RegionID int=0,
@ZonaID int=0
AS
BEGIN

	SELECT B.EncuestaResultadoId,
	       A.CodigoCampania,
		   A.CodigoConsultora,
		   E.NombreCompleto AS Consultora,
		   E.RegionID,
		   R.Codigo AS Region,
		   E.ZonaID,
		   Z.Codigo AS Zona,
		   IIF(TipoEncuestaMotivoId=2,B.Observacion,C.Descripcion) AS Motivo,
		   D.Descripcion AS Calificacion
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	INNER JOIN ods.Region R ON E.RegionID=R.Regionid
	INNER JOIN ods.Zona Z ON E.ZonaId=Z.ZonaId
	INNER JOIN dbo.EncuestaResultadoDetalle B ON A.Id=B.EncuestaResultadoId
	INNER JOIN dbo.EncuestaMotivo C ON B.MotivoId=C.Id
	INNER JOIN dbo.EncuestaCalificacion D ON C.EncuestaCalificacionId=D.Id
	WHERE A.CodigoCampania=@CodigoCampania
	AND A.SeleccionoMotivo=1
	AND (E.RegionID=@RegionID OR @RegionID=0)
	AND (E.ZonaID=@ZonaID OR @ZonaID=0)



END


GO
USE BelcorpEcuador
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultadoDetalle_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultadoDetalle_List] AS'
END
GO
ALTER PROCEDURE EncuestaResultadoDetalle_List
@CodigoCampania varchar(6),
@RegionID int=0,
@ZonaID int=0
AS
BEGIN

	SELECT B.EncuestaResultadoId,
	       A.CodigoCampania,
		   A.CodigoConsultora,
		   E.NombreCompleto AS Consultora,
		   E.RegionID,
		   R.Codigo AS Region,
		   E.ZonaID,
		   Z.Codigo AS Zona,
		   IIF(TipoEncuestaMotivoId=2,B.Observacion,C.Descripcion) AS Motivo,
		   D.Descripcion AS Calificacion
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	INNER JOIN ods.Region R ON E.RegionID=R.Regionid
	INNER JOIN ods.Zona Z ON E.ZonaId=Z.ZonaId
	INNER JOIN dbo.EncuestaResultadoDetalle B ON A.Id=B.EncuestaResultadoId
	INNER JOIN dbo.EncuestaMotivo C ON B.MotivoId=C.Id
	INNER JOIN dbo.EncuestaCalificacion D ON C.EncuestaCalificacionId=D.Id
	WHERE A.CodigoCampania=@CodigoCampania
	AND A.SeleccionoMotivo=1
	AND (E.RegionID=@RegionID OR @RegionID=0)
	AND (E.ZonaID=@ZonaID OR @ZonaID=0)



END


GO
USE BelcorpDominicana
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultadoDetalle_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultadoDetalle_List] AS'
END
GO
ALTER PROCEDURE EncuestaResultadoDetalle_List
@CodigoCampania varchar(6),
@RegionID int=0,
@ZonaID int=0
AS
BEGIN

	SELECT B.EncuestaResultadoId,
	       A.CodigoCampania,
		   A.CodigoConsultora,
		   E.NombreCompleto AS Consultora,
		   E.RegionID,
		   R.Codigo AS Region,
		   E.ZonaID,
		   Z.Codigo AS Zona,
		   IIF(TipoEncuestaMotivoId=2,B.Observacion,C.Descripcion) AS Motivo,
		   D.Descripcion AS Calificacion
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	INNER JOIN ods.Region R ON E.RegionID=R.Regionid
	INNER JOIN ods.Zona Z ON E.ZonaId=Z.ZonaId
	INNER JOIN dbo.EncuestaResultadoDetalle B ON A.Id=B.EncuestaResultadoId
	INNER JOIN dbo.EncuestaMotivo C ON B.MotivoId=C.Id
	INNER JOIN dbo.EncuestaCalificacion D ON C.EncuestaCalificacionId=D.Id
	WHERE A.CodigoCampania=@CodigoCampania
	AND A.SeleccionoMotivo=1
	AND (E.RegionID=@RegionID OR @RegionID=0)
	AND (E.ZonaID=@ZonaID OR @ZonaID=0)



END


GO
USE BelcorpCostaRica
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultadoDetalle_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultadoDetalle_List] AS'
END
GO
ALTER PROCEDURE EncuestaResultadoDetalle_List
@CodigoCampania varchar(6),
@RegionID int=0,
@ZonaID int=0
AS
BEGIN

	SELECT B.EncuestaResultadoId,
	       A.CodigoCampania,
		   A.CodigoConsultora,
		   E.NombreCompleto AS Consultora,
		   E.RegionID,
		   R.Codigo AS Region,
		   E.ZonaID,
		   Z.Codigo AS Zona,
		   IIF(TipoEncuestaMotivoId=2,B.Observacion,C.Descripcion) AS Motivo,
		   D.Descripcion AS Calificacion
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	INNER JOIN ods.Region R ON E.RegionID=R.Regionid
	INNER JOIN ods.Zona Z ON E.ZonaId=Z.ZonaId
	INNER JOIN dbo.EncuestaResultadoDetalle B ON A.Id=B.EncuestaResultadoId
	INNER JOIN dbo.EncuestaMotivo C ON B.MotivoId=C.Id
	INNER JOIN dbo.EncuestaCalificacion D ON C.EncuestaCalificacionId=D.Id
	WHERE A.CodigoCampania=@CodigoCampania
	AND A.SeleccionoMotivo=1
	AND (E.RegionID=@RegionID OR @RegionID=0)
	AND (E.ZonaID=@ZonaID OR @ZonaID=0)



END


GO
USE BelcorpChile
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultadoDetalle_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultadoDetalle_List] AS'
END
GO
ALTER PROCEDURE EncuestaResultadoDetalle_List
@CodigoCampania varchar(6),
@RegionID int=0,
@ZonaID int=0
AS
BEGIN

	SELECT B.EncuestaResultadoId,
	       A.CodigoCampania,
		   A.CodigoConsultora,
		   E.NombreCompleto AS Consultora,
		   E.RegionID,
		   R.Codigo AS Region,
		   E.ZonaID,
		   Z.Codigo AS Zona,
		   IIF(TipoEncuestaMotivoId=2,B.Observacion,C.Descripcion) AS Motivo,
		   D.Descripcion AS Calificacion
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	INNER JOIN ods.Region R ON E.RegionID=R.Regionid
	INNER JOIN ods.Zona Z ON E.ZonaId=Z.ZonaId
	INNER JOIN dbo.EncuestaResultadoDetalle B ON A.Id=B.EncuestaResultadoId
	INNER JOIN dbo.EncuestaMotivo C ON B.MotivoId=C.Id
	INNER JOIN dbo.EncuestaCalificacion D ON C.EncuestaCalificacionId=D.Id
	WHERE A.CodigoCampania=@CodigoCampania
	AND A.SeleccionoMotivo=1
	AND (E.RegionID=@RegionID OR @RegionID=0)
	AND (E.ZonaID=@ZonaID OR @ZonaID=0)



END


GO
USE BelcorpBolivia
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncuestaResultadoDetalle_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EncuestaResultadoDetalle_List] AS'
END
GO
ALTER PROCEDURE EncuestaResultadoDetalle_List
@CodigoCampania varchar(6),
@RegionID int=0,
@ZonaID int=0
AS
BEGIN

	SELECT B.EncuestaResultadoId,
	       A.CodigoCampania,
		   A.CodigoConsultora,
		   E.NombreCompleto AS Consultora,
		   E.RegionID,
		   R.Codigo AS Region,
		   E.ZonaID,
		   Z.Codigo AS Zona,
		   IIF(TipoEncuestaMotivoId=2,B.Observacion,C.Descripcion) AS Motivo,
		   D.Descripcion AS Calificacion
	FROM dbo.EncuestaResultado A
	INNER JOIN ods.Consultora E ON A.CodigoConsultora=E.Codigo
	INNER JOIN ods.Region R ON E.RegionID=R.Regionid
	INNER JOIN ods.Zona Z ON E.ZonaId=Z.ZonaId
	INNER JOIN dbo.EncuestaResultadoDetalle B ON A.Id=B.EncuestaResultadoId
	INNER JOIN dbo.EncuestaMotivo C ON B.MotivoId=C.Id
	INNER JOIN dbo.EncuestaCalificacion D ON C.EncuestaCalificacionId=D.Id
	WHERE A.CodigoCampania=@CodigoCampania
	AND A.SeleccionoMotivo=1
	AND (E.RegionID=@RegionID OR @RegionID=0)
	AND (E.ZonaID=@ZonaID OR @ZonaID=0)



END


GO
