USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetCodigosNivelBrillante]') 
AND type in (N'FN', N'IF',N'TF', N'FS', N'FT'))
BEGIN
	drop function [dbo].[fn_GetCodigosNivelBrillante]
END
GO
CREATE FUNCTION [dbo].[fn_GetCodigosNivelBrillante]
(
@TablaLogicaID int,
@TipoOferta varchar(3)
)
RETURNS TABLE
AS
RETURN 
	SELECT distinct
		Codigo,
		Valor
	FROM
	TablaLogicaDatos
	WHERE TablaLogicaID = 178
	and Codigo like '%' + @TipoOferta + '%'
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetCodigosNivelBrillante]') 
AND type in (N'FN', N'IF',N'TF', N'FS', N'FT'))
BEGIN
	drop function [dbo].[fn_GetCodigosNivelBrillante]
END
GO
CREATE FUNCTION [dbo].[fn_GetCodigosNivelBrillante]
(
@TablaLogicaID int,
@TipoOferta varchar(3)
)
RETURNS TABLE
AS
RETURN 
	SELECT distinct
		Codigo,
		Valor
	FROM
	TablaLogicaDatos
	WHERE TablaLogicaID = 178
	and Codigo like '%' + @TipoOferta + '%'
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetCodigosNivelBrillante]') 
AND type in (N'FN', N'IF',N'TF', N'FS', N'FT'))
BEGIN
	drop function [dbo].[fn_GetCodigosNivelBrillante]
END
GO
CREATE FUNCTION [dbo].[fn_GetCodigosNivelBrillante]
(
@TablaLogicaID int,
@TipoOferta varchar(3)
)
RETURNS TABLE
AS
RETURN 
	SELECT distinct
		Codigo,
		Valor
	FROM
	TablaLogicaDatos
	WHERE TablaLogicaID = 178
	and Codigo like '%' + @TipoOferta + '%'
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetCodigosNivelBrillante]') 
AND type in (N'FN', N'IF',N'TF', N'FS', N'FT'))
BEGIN
	drop function [dbo].[fn_GetCodigosNivelBrillante]
END
GO
CREATE FUNCTION [dbo].[fn_GetCodigosNivelBrillante]
(
@TablaLogicaID int,
@TipoOferta varchar(3)
)
RETURNS TABLE
AS
RETURN 
	SELECT distinct
		Codigo,
		Valor
	FROM
	TablaLogicaDatos
	WHERE TablaLogicaID = 178
	and Codigo like '%' + @TipoOferta + '%'
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetCodigosNivelBrillante]') 
AND type in (N'FN', N'IF',N'TF', N'FS', N'FT'))
BEGIN
	drop function [dbo].[fn_GetCodigosNivelBrillante]
END
GO
CREATE FUNCTION [dbo].[fn_GetCodigosNivelBrillante]
(
@TablaLogicaID int,
@TipoOferta varchar(3)
)
RETURNS TABLE
AS
RETURN 
	SELECT distinct
		Codigo,
		Valor
	FROM
	TablaLogicaDatos
	WHERE TablaLogicaID = 178
	and Codigo like '%' + @TipoOferta + '%'
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetCodigosNivelBrillante]') 
AND type in (N'FN', N'IF',N'TF', N'FS', N'FT'))
BEGIN
	drop function [dbo].[fn_GetCodigosNivelBrillante]
END
GO
CREATE FUNCTION [dbo].[fn_GetCodigosNivelBrillante]
(
@TablaLogicaID int,
@TipoOferta varchar(3)
)
RETURNS TABLE
AS
RETURN 
	SELECT distinct
		Codigo,
		Valor
	FROM
	TablaLogicaDatos
	WHERE TablaLogicaID = 178
	and Codigo like '%' + @TipoOferta + '%'
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetCodigosNivelBrillante]') 
AND type in (N'FN', N'IF',N'TF', N'FS', N'FT'))
BEGIN
	drop function [dbo].[fn_GetCodigosNivelBrillante]
END
GO
CREATE FUNCTION [dbo].[fn_GetCodigosNivelBrillante]
(
@TablaLogicaID int,
@TipoOferta varchar(3)
)
RETURNS TABLE
AS
RETURN 
	SELECT distinct
		Codigo,
		Valor
	FROM
	TablaLogicaDatos
	WHERE TablaLogicaID = 178
	and Codigo like '%' + @TipoOferta + '%'
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetCodigosNivelBrillante]') 
AND type in (N'FN', N'IF',N'TF', N'FS', N'FT'))
BEGIN
	drop function [dbo].[fn_GetCodigosNivelBrillante]
END
GO
CREATE FUNCTION [dbo].[fn_GetCodigosNivelBrillante]
(
@TablaLogicaID int,
@TipoOferta varchar(3)
)
RETURNS TABLE
AS
RETURN 
	SELECT distinct
		Codigo,
		Valor
	FROM
	TablaLogicaDatos
	WHERE TablaLogicaID = 178
	and Codigo like '%' + @TipoOferta + '%'
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetCodigosNivelBrillante]') 
AND type in (N'FN', N'IF',N'TF', N'FS', N'FT'))
BEGIN
	drop function [dbo].[fn_GetCodigosNivelBrillante]
END
GO
CREATE FUNCTION [dbo].[fn_GetCodigosNivelBrillante]
(
@TablaLogicaID int,
@TipoOferta varchar(3)
)
RETURNS TABLE
AS
RETURN 
	SELECT distinct
		Codigo,
		Valor
	FROM
	TablaLogicaDatos
	WHERE TablaLogicaID = 178
	and Codigo like '%' + @TipoOferta + '%'
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetCodigosNivelBrillante]') 
AND type in (N'FN', N'IF',N'TF', N'FS', N'FT'))
BEGIN
	drop function [dbo].[fn_GetCodigosNivelBrillante]
END
GO
CREATE FUNCTION [dbo].[fn_GetCodigosNivelBrillante]
(
@TablaLogicaID int,
@TipoOferta varchar(3)
)
RETURNS TABLE
AS
RETURN 
	SELECT distinct
		Codigo,
		Valor
	FROM
	TablaLogicaDatos
	WHERE TablaLogicaID = 178
	and Codigo like '%' + @TipoOferta + '%'
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetCodigosNivelBrillante]') 
AND type in (N'FN', N'IF',N'TF', N'FS', N'FT'))
BEGIN
	drop function [dbo].[fn_GetCodigosNivelBrillante]
END
GO
CREATE FUNCTION [dbo].[fn_GetCodigosNivelBrillante]
(
@TablaLogicaID int,
@TipoOferta varchar(3)
)
RETURNS TABLE
AS
RETURN 
	SELECT distinct
		Codigo,
		Valor
	FROM
	TablaLogicaDatos
	WHERE TablaLogicaID = 178
	and Codigo like '%' + @TipoOferta + '%'
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetCodigosNivelBrillante]') 
AND type in (N'FN', N'IF',N'TF', N'FS', N'FT'))
BEGIN
	drop function [dbo].[fn_GetCodigosNivelBrillante]
END
GO
CREATE FUNCTION [dbo].[fn_GetCodigosNivelBrillante]
(
@TablaLogicaID int,
@TipoOferta varchar(3)
)
RETURNS TABLE
AS
RETURN 
	SELECT distinct
		Codigo,
		Valor
	FROM
	TablaLogicaDatos
	WHERE TablaLogicaID = 178
	and Codigo like '%' + @TipoOferta + '%'
GO

