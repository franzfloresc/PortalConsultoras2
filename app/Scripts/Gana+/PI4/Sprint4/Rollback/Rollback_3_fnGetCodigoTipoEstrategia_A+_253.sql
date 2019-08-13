USE BelcorpColombia_GANAMAS;
GO

IF(OBJECT_ID('dbo.fnGetCodigoTipoEstrategia','FN') IS NOT NULL)
BEGIN
	DROP FUNCTION [dbo].[fnGetCodigoTipoEstrategia];
END;
GO

CREATE FUNCTION [dbo].[fnGetCodigoTipoEstrategia]
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
		ELSE ''
	END;

	RETURN @Codigo
END;
GO

USE BelcorpPeru_GANAMAS;
GO

IF(OBJECT_ID('dbo.fnGetCodigoTipoEstrategia','FN') IS NOT NULL)
BEGIN
	DROP FUNCTION [dbo].[fnGetCodigoTipoEstrategia];
END;
GO

CREATE FUNCTION [dbo].[fnGetCodigoTipoEstrategia]
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
		ELSE ''
	END;

	RETURN @Codigo
END;
GO

USE BelcorpChile_GANAMAS;
GO

IF(OBJECT_ID('dbo.fnGetCodigoTipoEstrategia','FN') IS NOT NULL)
BEGIN
	DROP FUNCTION [dbo].[fnGetCodigoTipoEstrategia];
END;
GO

CREATE FUNCTION [dbo].[fnGetCodigoTipoEstrategia]
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
		ELSE ''
	END;

	RETURN @Codigo
END;
GO

USE BelcorpCostaRica_GANAMAS;
GO

IF(OBJECT_ID('dbo.fnGetCodigoTipoEstrategia','FN') IS NOT NULL)
BEGIN
	DROP FUNCTION [dbo].[fnGetCodigoTipoEstrategia];
END;
GO

CREATE FUNCTION [dbo].[fnGetCodigoTipoEstrategia]
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
		ELSE ''
	END;

	RETURN @Codigo
END;
GO

USE BelcorpEcuador_GANAMAS;
GO

IF(OBJECT_ID('dbo.fnGetCodigoTipoEstrategia','FN') IS NOT NULL)
BEGIN
	DROP FUNCTION [dbo].[fnGetCodigoTipoEstrategia];
END;
GO

CREATE FUNCTION [dbo].[fnGetCodigoTipoEstrategia]
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
		ELSE ''
	END;

	RETURN @Codigo
END;
GO

USE BelcorpMexico_GANAMAS;
GO

IF(OBJECT_ID('dbo.fnGetCodigoTipoEstrategia','FN') IS NOT NULL)
BEGIN
	DROP FUNCTION [dbo].[fnGetCodigoTipoEstrategia];
END;
GO

CREATE FUNCTION [dbo].[fnGetCodigoTipoEstrategia]
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
		ELSE ''
	END;

	RETURN @Codigo
END;
GO
