USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[GetCDRWebMotivoOperacion]
       @CodigoOperacion VARCHAR(5),
       @CodigoReclamo VARCHAR(5)
AS
/*
GetCDRWebMotivoOperacion null,nullr
*/
BEGIN
 
       set @CodigoOperacion = isnull(@CodigoOperacion, '')
       set @CodigoOperacion = RTRIM(LTRIM(@CodigoOperacion))
            
       set @CodigoReclamo = isnull(@CodigoReclamo, '')
       set @CodigoReclamo = RTRIM(LTRIM(@CodigoReclamo))
 
 
       SELECT
              mo.CodigoOperacion
             ,mo.CodigoReclamo
             ,mo.Prioridad
             ,mo.Estado
             ,o.DescripcionOperacion
             ,CASE
                    WHEN isnull(CAST(t.NumeroDiasAtrasOperacion AS VARCHAR(20)), '') = '' THEN o.NumeroDiasAtrasOperacion
                    ELSE t.NumeroDiasAtrasOperacion
             END AS NumeroDiasAtrasOperacion
             --,t.NumeroDiasAtrasOperacion
             ,m.DescripcionReclamo
       FROM CDRWebMotivoOperacion mo
             left join dbo.TipoOperacionesCDR t on t.CodigoOperacion = mo.CodigoOperacion
             inner join ods.TipoOperacionesCDR o on o.CodigoOperacion = mo.CodigoOperacion
             inner join ods.MotivoReclamoCDR m on m.CodigoReclamo = mo.CodigoReclamo
       WHERE (mo.CodigoOperacion = @CodigoOperacion OR @CodigoOperacion = '')
             AND (mo.CodigoReclamo = @CodigoReclamo OR @CodigoReclamo = '')
			 ORDER BY mo.Orden asc
END

GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[GetCDRWebMotivoOperacion]
       @CodigoOperacion VARCHAR(5),
       @CodigoReclamo VARCHAR(5)
AS
/*
GetCDRWebMotivoOperacion null,nullr
*/
BEGIN
 
       set @CodigoOperacion = isnull(@CodigoOperacion, '')
       set @CodigoOperacion = RTRIM(LTRIM(@CodigoOperacion))
            
       set @CodigoReclamo = isnull(@CodigoReclamo, '')
       set @CodigoReclamo = RTRIM(LTRIM(@CodigoReclamo))
 
 
       SELECT
              mo.CodigoOperacion
             ,mo.CodigoReclamo
             ,mo.Prioridad
             ,mo.Estado
             ,o.DescripcionOperacion
             ,CASE
                    WHEN isnull(CAST(t.NumeroDiasAtrasOperacion AS VARCHAR(20)), '') = '' THEN o.NumeroDiasAtrasOperacion
                    ELSE t.NumeroDiasAtrasOperacion
             END AS NumeroDiasAtrasOperacion
             --,t.NumeroDiasAtrasOperacion
             ,m.DescripcionReclamo
       FROM CDRWebMotivoOperacion mo
             left join dbo.TipoOperacionesCDR t on t.CodigoOperacion = mo.CodigoOperacion
             inner join ods.TipoOperacionesCDR o on o.CodigoOperacion = mo.CodigoOperacion
             inner join ods.MotivoReclamoCDR m on m.CodigoReclamo = mo.CodigoReclamo
       WHERE (mo.CodigoOperacion = @CodigoOperacion OR @CodigoOperacion = '')
             AND (mo.CodigoReclamo = @CodigoReclamo OR @CodigoReclamo = '')
			 ORDER BY mo.Orden asc
END

GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[GetCDRWebMotivoOperacion]
       @CodigoOperacion VARCHAR(5),
       @CodigoReclamo VARCHAR(5)
AS
/*
GetCDRWebMotivoOperacion null,nullr
*/
BEGIN
 
       set @CodigoOperacion = isnull(@CodigoOperacion, '')
       set @CodigoOperacion = RTRIM(LTRIM(@CodigoOperacion))
            
       set @CodigoReclamo = isnull(@CodigoReclamo, '')
       set @CodigoReclamo = RTRIM(LTRIM(@CodigoReclamo))
 
 
       SELECT
              mo.CodigoOperacion
             ,mo.CodigoReclamo
             ,mo.Prioridad
             ,mo.Estado
             ,o.DescripcionOperacion
             ,CASE
                    WHEN isnull(CAST(t.NumeroDiasAtrasOperacion AS VARCHAR(20)), '') = '' THEN o.NumeroDiasAtrasOperacion
                    ELSE t.NumeroDiasAtrasOperacion
             END AS NumeroDiasAtrasOperacion
             --,t.NumeroDiasAtrasOperacion
             ,m.DescripcionReclamo
       FROM CDRWebMotivoOperacion mo
             left join dbo.TipoOperacionesCDR t on t.CodigoOperacion = mo.CodigoOperacion
             inner join ods.TipoOperacionesCDR o on o.CodigoOperacion = mo.CodigoOperacion
             inner join ods.MotivoReclamoCDR m on m.CodigoReclamo = mo.CodigoReclamo
       WHERE (mo.CodigoOperacion = @CodigoOperacion OR @CodigoOperacion = '')
             AND (mo.CodigoReclamo = @CodigoReclamo OR @CodigoReclamo = '')
			 ORDER BY mo.Orden asc
END

GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[GetCDRWebMotivoOperacion]
       @CodigoOperacion VARCHAR(5),
       @CodigoReclamo VARCHAR(5)
AS
/*
GetCDRWebMotivoOperacion null,nullr
*/
BEGIN
 
       set @CodigoOperacion = isnull(@CodigoOperacion, '')
       set @CodigoOperacion = RTRIM(LTRIM(@CodigoOperacion))
            
       set @CodigoReclamo = isnull(@CodigoReclamo, '')
       set @CodigoReclamo = RTRIM(LTRIM(@CodigoReclamo))
 
 
       SELECT
              mo.CodigoOperacion
             ,mo.CodigoReclamo
             ,mo.Prioridad
             ,mo.Estado
             ,o.DescripcionOperacion
             ,CASE
                    WHEN isnull(CAST(t.NumeroDiasAtrasOperacion AS VARCHAR(20)), '') = '' THEN o.NumeroDiasAtrasOperacion
                    ELSE t.NumeroDiasAtrasOperacion
             END AS NumeroDiasAtrasOperacion
             --,t.NumeroDiasAtrasOperacion
             ,m.DescripcionReclamo
       FROM CDRWebMotivoOperacion mo
             left join dbo.TipoOperacionesCDR t on t.CodigoOperacion = mo.CodigoOperacion
             inner join ods.TipoOperacionesCDR o on o.CodigoOperacion = mo.CodigoOperacion
             inner join ods.MotivoReclamoCDR m on m.CodigoReclamo = mo.CodigoReclamo
       WHERE (mo.CodigoOperacion = @CodigoOperacion OR @CodigoOperacion = '')
             AND (mo.CodigoReclamo = @CodigoReclamo OR @CodigoReclamo = '')
			 ORDER BY mo.Orden asc
END

GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[GetCDRWebMotivoOperacion]
       @CodigoOperacion VARCHAR(5),
       @CodigoReclamo VARCHAR(5)
AS
/*
GetCDRWebMotivoOperacion null,nullr
*/
BEGIN
 
       set @CodigoOperacion = isnull(@CodigoOperacion, '')
       set @CodigoOperacion = RTRIM(LTRIM(@CodigoOperacion))
            
       set @CodigoReclamo = isnull(@CodigoReclamo, '')
       set @CodigoReclamo = RTRIM(LTRIM(@CodigoReclamo))
 
 
       SELECT
              mo.CodigoOperacion
             ,mo.CodigoReclamo
             ,mo.Prioridad
             ,mo.Estado
             ,o.DescripcionOperacion
             ,CASE
                    WHEN isnull(CAST(t.NumeroDiasAtrasOperacion AS VARCHAR(20)), '') = '' THEN o.NumeroDiasAtrasOperacion
                    ELSE t.NumeroDiasAtrasOperacion
             END AS NumeroDiasAtrasOperacion
             --,t.NumeroDiasAtrasOperacion
             ,m.DescripcionReclamo
       FROM CDRWebMotivoOperacion mo
             left join dbo.TipoOperacionesCDR t on t.CodigoOperacion = mo.CodigoOperacion
             inner join ods.TipoOperacionesCDR o on o.CodigoOperacion = mo.CodigoOperacion
             inner join ods.MotivoReclamoCDR m on m.CodigoReclamo = mo.CodigoReclamo
       WHERE (mo.CodigoOperacion = @CodigoOperacion OR @CodigoOperacion = '')
             AND (mo.CodigoReclamo = @CodigoReclamo OR @CodigoReclamo = '')
			 ORDER BY mo.Orden asc
END

GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[GetCDRWebMotivoOperacion]
       @CodigoOperacion VARCHAR(5),
       @CodigoReclamo VARCHAR(5)
AS
/*
GetCDRWebMotivoOperacion null,nullr
*/
BEGIN
 
       set @CodigoOperacion = isnull(@CodigoOperacion, '')
       set @CodigoOperacion = RTRIM(LTRIM(@CodigoOperacion))
            
       set @CodigoReclamo = isnull(@CodigoReclamo, '')
       set @CodigoReclamo = RTRIM(LTRIM(@CodigoReclamo))
 
 
       SELECT
              mo.CodigoOperacion
             ,mo.CodigoReclamo
             ,mo.Prioridad
             ,mo.Estado
             ,o.DescripcionOperacion
             ,CASE
                    WHEN isnull(CAST(t.NumeroDiasAtrasOperacion AS VARCHAR(20)), '') = '' THEN o.NumeroDiasAtrasOperacion
                    ELSE t.NumeroDiasAtrasOperacion
             END AS NumeroDiasAtrasOperacion
             --,t.NumeroDiasAtrasOperacion
             ,m.DescripcionReclamo
       FROM CDRWebMotivoOperacion mo
             left join dbo.TipoOperacionesCDR t on t.CodigoOperacion = mo.CodigoOperacion
             inner join ods.TipoOperacionesCDR o on o.CodigoOperacion = mo.CodigoOperacion
             inner join ods.MotivoReclamoCDR m on m.CodigoReclamo = mo.CodigoReclamo
       WHERE (mo.CodigoOperacion = @CodigoOperacion OR @CodigoOperacion = '')
             AND (mo.CodigoReclamo = @CodigoReclamo OR @CodigoReclamo = '')
			 ORDER BY mo.Orden asc
END

GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[GetCDRWebMotivoOperacion]
       @CodigoOperacion VARCHAR(5),
       @CodigoReclamo VARCHAR(5)
AS
/*
GetCDRWebMotivoOperacion null,nullr
*/
BEGIN
 
       set @CodigoOperacion = isnull(@CodigoOperacion, '')
       set @CodigoOperacion = RTRIM(LTRIM(@CodigoOperacion))
            
       set @CodigoReclamo = isnull(@CodigoReclamo, '')
       set @CodigoReclamo = RTRIM(LTRIM(@CodigoReclamo))
 
 
       SELECT
              mo.CodigoOperacion
             ,mo.CodigoReclamo
             ,mo.Prioridad
             ,mo.Estado
             ,o.DescripcionOperacion
             ,CASE
                    WHEN isnull(CAST(t.NumeroDiasAtrasOperacion AS VARCHAR(20)), '') = '' THEN o.NumeroDiasAtrasOperacion
                    ELSE t.NumeroDiasAtrasOperacion
             END AS NumeroDiasAtrasOperacion
             --,t.NumeroDiasAtrasOperacion
             ,m.DescripcionReclamo
       FROM CDRWebMotivoOperacion mo
             left join dbo.TipoOperacionesCDR t on t.CodigoOperacion = mo.CodigoOperacion
             inner join ods.TipoOperacionesCDR o on o.CodigoOperacion = mo.CodigoOperacion
             inner join ods.MotivoReclamoCDR m on m.CodigoReclamo = mo.CodigoReclamo
       WHERE (mo.CodigoOperacion = @CodigoOperacion OR @CodigoOperacion = '')
             AND (mo.CodigoReclamo = @CodigoReclamo OR @CodigoReclamo = '')
			 ORDER BY mo.Orden asc
END

GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[GetCDRWebMotivoOperacion]
       @CodigoOperacion VARCHAR(5),
       @CodigoReclamo VARCHAR(5)
AS
/*
GetCDRWebMotivoOperacion null,nullr
*/
BEGIN
 
       set @CodigoOperacion = isnull(@CodigoOperacion, '')
       set @CodigoOperacion = RTRIM(LTRIM(@CodigoOperacion))
            
       set @CodigoReclamo = isnull(@CodigoReclamo, '')
       set @CodigoReclamo = RTRIM(LTRIM(@CodigoReclamo))
 
 
       SELECT
              mo.CodigoOperacion
             ,mo.CodigoReclamo
             ,mo.Prioridad
             ,mo.Estado
             ,o.DescripcionOperacion
             ,CASE
                    WHEN isnull(CAST(t.NumeroDiasAtrasOperacion AS VARCHAR(20)), '') = '' THEN o.NumeroDiasAtrasOperacion
                    ELSE t.NumeroDiasAtrasOperacion
             END AS NumeroDiasAtrasOperacion
             --,t.NumeroDiasAtrasOperacion
             ,m.DescripcionReclamo
       FROM CDRWebMotivoOperacion mo
             left join dbo.TipoOperacionesCDR t on t.CodigoOperacion = mo.CodigoOperacion
             inner join ods.TipoOperacionesCDR o on o.CodigoOperacion = mo.CodigoOperacion
             inner join ods.MotivoReclamoCDR m on m.CodigoReclamo = mo.CodigoReclamo
       WHERE (mo.CodigoOperacion = @CodigoOperacion OR @CodigoOperacion = '')
             AND (mo.CodigoReclamo = @CodigoReclamo OR @CodigoReclamo = '')
			 ORDER BY mo.Orden asc
END

GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[GetCDRWebMotivoOperacion]
       @CodigoOperacion VARCHAR(5),
       @CodigoReclamo VARCHAR(5)
AS
/*
GetCDRWebMotivoOperacion null,nullr
*/
BEGIN
 
       set @CodigoOperacion = isnull(@CodigoOperacion, '')
       set @CodigoOperacion = RTRIM(LTRIM(@CodigoOperacion))
            
       set @CodigoReclamo = isnull(@CodigoReclamo, '')
       set @CodigoReclamo = RTRIM(LTRIM(@CodigoReclamo))
 
 
       SELECT
              mo.CodigoOperacion
             ,mo.CodigoReclamo
             ,mo.Prioridad
             ,mo.Estado
             ,o.DescripcionOperacion
             ,CASE
                    WHEN isnull(CAST(t.NumeroDiasAtrasOperacion AS VARCHAR(20)), '') = '' THEN o.NumeroDiasAtrasOperacion
                    ELSE t.NumeroDiasAtrasOperacion
             END AS NumeroDiasAtrasOperacion
             --,t.NumeroDiasAtrasOperacion
             ,m.DescripcionReclamo
       FROM CDRWebMotivoOperacion mo
             left join dbo.TipoOperacionesCDR t on t.CodigoOperacion = mo.CodigoOperacion
             inner join ods.TipoOperacionesCDR o on o.CodigoOperacion = mo.CodigoOperacion
             inner join ods.MotivoReclamoCDR m on m.CodigoReclamo = mo.CodigoReclamo
       WHERE (mo.CodigoOperacion = @CodigoOperacion OR @CodigoOperacion = '')
             AND (mo.CodigoReclamo = @CodigoReclamo OR @CodigoReclamo = '')
			 ORDER BY mo.Orden asc
END

GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[GetCDRWebMotivoOperacion]
       @CodigoOperacion VARCHAR(5),
       @CodigoReclamo VARCHAR(5)
AS
/*
GetCDRWebMotivoOperacion null,nullr
*/
BEGIN
 
       set @CodigoOperacion = isnull(@CodigoOperacion, '')
       set @CodigoOperacion = RTRIM(LTRIM(@CodigoOperacion))
            
       set @CodigoReclamo = isnull(@CodigoReclamo, '')
       set @CodigoReclamo = RTRIM(LTRIM(@CodigoReclamo))
 
 
       SELECT
              mo.CodigoOperacion
             ,mo.CodigoReclamo
             ,mo.Prioridad
             ,mo.Estado
             ,o.DescripcionOperacion
             ,CASE
                    WHEN isnull(CAST(t.NumeroDiasAtrasOperacion AS VARCHAR(20)), '') = '' THEN o.NumeroDiasAtrasOperacion
                    ELSE t.NumeroDiasAtrasOperacion
             END AS NumeroDiasAtrasOperacion
             --,t.NumeroDiasAtrasOperacion
             ,m.DescripcionReclamo
       FROM CDRWebMotivoOperacion mo
             left join dbo.TipoOperacionesCDR t on t.CodigoOperacion = mo.CodigoOperacion
             inner join ods.TipoOperacionesCDR o on o.CodigoOperacion = mo.CodigoOperacion
             inner join ods.MotivoReclamoCDR m on m.CodigoReclamo = mo.CodigoReclamo
       WHERE (mo.CodigoOperacion = @CodigoOperacion OR @CodigoOperacion = '')
             AND (mo.CodigoReclamo = @CodigoReclamo OR @CodigoReclamo = '')
			 ORDER BY mo.Orden asc
END

GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[GetCDRWebMotivoOperacion]
       @CodigoOperacion VARCHAR(5),
       @CodigoReclamo VARCHAR(5)
AS
/*
GetCDRWebMotivoOperacion null,nullr
*/
BEGIN
 
       set @CodigoOperacion = isnull(@CodigoOperacion, '')
       set @CodigoOperacion = RTRIM(LTRIM(@CodigoOperacion))
            
       set @CodigoReclamo = isnull(@CodigoReclamo, '')
       set @CodigoReclamo = RTRIM(LTRIM(@CodigoReclamo))
 
 
       SELECT
              mo.CodigoOperacion
             ,mo.CodigoReclamo
             ,mo.Prioridad
             ,mo.Estado
             ,o.DescripcionOperacion
             ,CASE
                    WHEN isnull(CAST(t.NumeroDiasAtrasOperacion AS VARCHAR(20)), '') = '' THEN o.NumeroDiasAtrasOperacion
                    ELSE t.NumeroDiasAtrasOperacion
             END AS NumeroDiasAtrasOperacion
             --,t.NumeroDiasAtrasOperacion
             ,m.DescripcionReclamo
       FROM CDRWebMotivoOperacion mo
             left join dbo.TipoOperacionesCDR t on t.CodigoOperacion = mo.CodigoOperacion
             inner join ods.TipoOperacionesCDR o on o.CodigoOperacion = mo.CodigoOperacion
             inner join ods.MotivoReclamoCDR m on m.CodigoReclamo = mo.CodigoReclamo
       WHERE (mo.CodigoOperacion = @CodigoOperacion OR @CodigoOperacion = '')
             AND (mo.CodigoReclamo = @CodigoReclamo OR @CodigoReclamo = '')
			 ORDER BY mo.Orden asc
END

GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[GetCDRWebMotivoOperacion]
       @CodigoOperacion VARCHAR(5),
       @CodigoReclamo VARCHAR(5)
AS
/*
GetCDRWebMotivoOperacion null,nullr
*/
BEGIN
 
       set @CodigoOperacion = isnull(@CodigoOperacion, '')
       set @CodigoOperacion = RTRIM(LTRIM(@CodigoOperacion))
            
       set @CodigoReclamo = isnull(@CodigoReclamo, '')
       set @CodigoReclamo = RTRIM(LTRIM(@CodigoReclamo))
 
 
       SELECT
              mo.CodigoOperacion
             ,mo.CodigoReclamo
             ,mo.Prioridad
             ,mo.Estado
             ,o.DescripcionOperacion
             ,CASE
                    WHEN isnull(CAST(t.NumeroDiasAtrasOperacion AS VARCHAR(20)), '') = '' THEN o.NumeroDiasAtrasOperacion
                    ELSE t.NumeroDiasAtrasOperacion
             END AS NumeroDiasAtrasOperacion
             --,t.NumeroDiasAtrasOperacion
             ,m.DescripcionReclamo
       FROM CDRWebMotivoOperacion mo
             left join dbo.TipoOperacionesCDR t on t.CodigoOperacion = mo.CodigoOperacion
             inner join ods.TipoOperacionesCDR o on o.CodigoOperacion = mo.CodigoOperacion
             inner join ods.MotivoReclamoCDR m on m.CodigoReclamo = mo.CodigoReclamo
       WHERE (mo.CodigoOperacion = @CodigoOperacion OR @CodigoOperacion = '')
             AND (mo.CodigoReclamo = @CodigoReclamo OR @CodigoReclamo = '')
			 ORDER BY mo.Orden asc
END

GO

