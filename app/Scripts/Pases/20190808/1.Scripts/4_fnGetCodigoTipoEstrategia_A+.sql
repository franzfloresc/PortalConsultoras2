GO
USE BelcorpPeru
GO

ALTER FUNCTION [dbo].[fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion VARCHAR(100)
)
RETURNS VARCHAR(100)
BEGIN
	DECLARE @Codigo varchar(100)

	SET @Codigo = CASE @TipoPersonalizacion
		WHEN 'OPT' THEN '001'
		WHEN 'ODD' THEN '009'
		WHEN 'LAN' THEN '005'
		WHEN 'OPM' THEN '007'
		WHEN 'PAD' THEN '008'
		WHEN 'GND' THEN '010'
		WHEN 'SR' THEN '030'
		WHEN 'LMG' THEN 'LMG'
		ELSE ''
	END;

	RETURN @Codigo
END;


GO
USE BelcorpMexico
GO

ALTER FUNCTION [dbo].[fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion VARCHAR(100)
)
RETURNS VARCHAR(100)
BEGIN
	DECLARE @Codigo varchar(100)

	SET @Codigo = CASE @TipoPersonalizacion
		WHEN 'OPT' THEN '001'
		WHEN 'ODD' THEN '009'
		WHEN 'LAN' THEN '005'
		WHEN 'OPM' THEN '007'
		WHEN 'PAD' THEN '008'
		WHEN 'GND' THEN '010'
		WHEN 'SR' THEN '030'
		WHEN 'LMG' THEN 'LMG'
		ELSE ''
	END;

	RETURN @Codigo
END;


GO
USE BelcorpColombia
GO

ALTER FUNCTION [dbo].[fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion VARCHAR(100)
)
RETURNS VARCHAR(100)
BEGIN
	DECLARE @Codigo varchar(100)

	SET @Codigo = CASE @TipoPersonalizacion
		WHEN 'OPT' THEN '001'
		WHEN 'ODD' THEN '009'
		WHEN 'LAN' THEN '005'
		WHEN 'OPM' THEN '007'
		WHEN 'PAD' THEN '008'
		WHEN 'GND' THEN '010'
		WHEN 'SR' THEN '030'
		WHEN 'LMG' THEN 'LMG'
		ELSE ''
	END;

	RETURN @Codigo
END;


GO
USE BelcorpSalvador
GO

ALTER FUNCTION [dbo].[fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion VARCHAR(100)
)
RETURNS VARCHAR(100)
BEGIN
	DECLARE @Codigo varchar(100)

	SET @Codigo = CASE @TipoPersonalizacion
		WHEN 'OPT' THEN '001'
		WHEN 'ODD' THEN '009'
		WHEN 'LAN' THEN '005'
		WHEN 'OPM' THEN '007'
		WHEN 'PAD' THEN '008'
		WHEN 'GND' THEN '010'
		WHEN 'SR' THEN '030'
		WHEN 'LMG' THEN 'LMG'
		ELSE ''
	END;

	RETURN @Codigo
END;


GO
USE BelcorpPuertoRico
GO

ALTER FUNCTION [dbo].[fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion VARCHAR(100)
)
RETURNS VARCHAR(100)
BEGIN
	DECLARE @Codigo varchar(100)

	SET @Codigo = CASE @TipoPersonalizacion
		WHEN 'OPT' THEN '001'
		WHEN 'ODD' THEN '009'
		WHEN 'LAN' THEN '005'
		WHEN 'OPM' THEN '007'
		WHEN 'PAD' THEN '008'
		WHEN 'GND' THEN '010'
		WHEN 'SR' THEN '030'
		WHEN 'LMG' THEN 'LMG'
		ELSE ''
	END;

	RETURN @Codigo
END;


GO
USE BelcorpPanama
GO

ALTER FUNCTION [dbo].[fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion VARCHAR(100)
)
RETURNS VARCHAR(100)
BEGIN
	DECLARE @Codigo varchar(100)

	SET @Codigo = CASE @TipoPersonalizacion
		WHEN 'OPT' THEN '001'
		WHEN 'ODD' THEN '009'
		WHEN 'LAN' THEN '005'
		WHEN 'OPM' THEN '007'
		WHEN 'PAD' THEN '008'
		WHEN 'GND' THEN '010'
		WHEN 'SR' THEN '030'
		WHEN 'LMG' THEN 'LMG'
		ELSE ''
	END;

	RETURN @Codigo
END;


GO
USE BelcorpGuatemala
GO

ALTER FUNCTION [dbo].[fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion VARCHAR(100)
)
RETURNS VARCHAR(100)
BEGIN
	DECLARE @Codigo varchar(100)

	SET @Codigo = CASE @TipoPersonalizacion
		WHEN 'OPT' THEN '001'
		WHEN 'ODD' THEN '009'
		WHEN 'LAN' THEN '005'
		WHEN 'OPM' THEN '007'
		WHEN 'PAD' THEN '008'
		WHEN 'GND' THEN '010'
		WHEN 'SR' THEN '030'
		WHEN 'LMG' THEN 'LMG'
		ELSE ''
	END;

	RETURN @Codigo
END;


GO
USE BelcorpEcuador
GO

ALTER FUNCTION [dbo].[fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion VARCHAR(100)
)
RETURNS VARCHAR(100)
BEGIN
	DECLARE @Codigo varchar(100)

	SET @Codigo = CASE @TipoPersonalizacion
		WHEN 'OPT' THEN '001'
		WHEN 'ODD' THEN '009'
		WHEN 'LAN' THEN '005'
		WHEN 'OPM' THEN '007'
		WHEN 'PAD' THEN '008'
		WHEN 'GND' THEN '010'
		WHEN 'SR' THEN '030'
		WHEN 'LMG' THEN 'LMG'
		ELSE ''
	END;

	RETURN @Codigo
END;


GO
USE BelcorpDominicana
GO

ALTER FUNCTION [dbo].[fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion VARCHAR(100)
)
RETURNS VARCHAR(100)
BEGIN
	DECLARE @Codigo varchar(100)

	SET @Codigo = CASE @TipoPersonalizacion
		WHEN 'OPT' THEN '001'
		WHEN 'ODD' THEN '009'
		WHEN 'LAN' THEN '005'
		WHEN 'OPM' THEN '007'
		WHEN 'PAD' THEN '008'
		WHEN 'GND' THEN '010'
		WHEN 'SR' THEN '030'
		WHEN 'LMG' THEN 'LMG'
		ELSE ''
	END;

	RETURN @Codigo
END;


GO
USE BelcorpCostaRica
GO

ALTER FUNCTION [dbo].[fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion VARCHAR(100)
)
RETURNS VARCHAR(100)
BEGIN
	DECLARE @Codigo varchar(100)

	SET @Codigo = CASE @TipoPersonalizacion
		WHEN 'OPT' THEN '001'
		WHEN 'ODD' THEN '009'
		WHEN 'LAN' THEN '005'
		WHEN 'OPM' THEN '007'
		WHEN 'PAD' THEN '008'
		WHEN 'GND' THEN '010'
		WHEN 'SR' THEN '030'
		WHEN 'LMG' THEN 'LMG'
		ELSE ''
	END;

	RETURN @Codigo
END;


GO
USE BelcorpChile
GO

ALTER FUNCTION [dbo].[fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion VARCHAR(100)
)
RETURNS VARCHAR(100)
BEGIN
	DECLARE @Codigo varchar(100)

	SET @Codigo = CASE @TipoPersonalizacion
		WHEN 'OPT' THEN '001'
		WHEN 'ODD' THEN '009'
		WHEN 'LAN' THEN '005'
		WHEN 'OPM' THEN '007'
		WHEN 'PAD' THEN '008'
		WHEN 'GND' THEN '010'
		WHEN 'SR' THEN '030'
		WHEN 'LMG' THEN 'LMG'
		ELSE ''
	END;

	RETURN @Codigo
END;


GO
USE BelcorpBolivia
GO

ALTER FUNCTION [dbo].[fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion VARCHAR(100)
)
RETURNS VARCHAR(100)
BEGIN
	DECLARE @Codigo varchar(100)

	SET @Codigo = CASE @TipoPersonalizacion
		WHEN 'OPT' THEN '001'
		WHEN 'ODD' THEN '009'
		WHEN 'LAN' THEN '005'
		WHEN 'OPM' THEN '007'
		WHEN 'PAD' THEN '008'
		WHEN 'GND' THEN '010'
		WHEN 'SR' THEN '030'
		WHEN 'LMG' THEN 'LMG'
		ELSE ''
	END;

	RETURN @Codigo
END;


GO
