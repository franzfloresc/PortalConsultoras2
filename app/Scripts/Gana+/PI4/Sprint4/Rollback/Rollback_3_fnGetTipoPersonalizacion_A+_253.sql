USE BelcorpColombia_GANAMAS;
GO

IF(OBJECT_ID('dbo.fnGetTipoPersonalizacion','FN') IS NOT NULL)
BEGIN
	DROP FUNCTION [dbo].[fnGetTipoPersonalizacion];
END;
GO

CREATE FUNCTION [dbo].[fnGetTipoPersonalizacion]
(
	@EstrategiaCodigo VARCHAR(100)
)
RETURNS VARCHAR(5)
BEGIN
	DECLARE @TipoPersonalizacion VARCHAR(5);

	SET @TipoPersonalizacion = CASE @EstrategiaCodigo
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE ''
	END;

	RETURN @TipoPersonalizacion
END;
GO

USE BelcorpPeru_GANAMAS;
GO

IF(OBJECT_ID('dbo.fnGetTipoPersonalizacion','FN') IS NOT NULL)
BEGIN
	DROP FUNCTION [dbo].[fnGetTipoPersonalizacion];
END;
GO

CREATE FUNCTION [dbo].[fnGetTipoPersonalizacion]
(
	@EstrategiaCodigo VARCHAR(100)
)
RETURNS VARCHAR(5)
BEGIN
	DECLARE @TipoPersonalizacion VARCHAR(5);

	SET @TipoPersonalizacion = CASE @EstrategiaCodigo
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE ''
	END;

	RETURN @TipoPersonalizacion
END;
GO

USE BelcorpChile_GANAMAS;
GO

IF(OBJECT_ID('dbo.fnGetTipoPersonalizacion','FN') IS NOT NULL)
BEGIN
	DROP FUNCTION [dbo].[fnGetTipoPersonalizacion];
END;
GO

CREATE FUNCTION [dbo].[fnGetTipoPersonalizacion]
(
	@EstrategiaCodigo VARCHAR(100)
)
RETURNS VARCHAR(5)
BEGIN
	DECLARE @TipoPersonalizacion VARCHAR(5);

	SET @TipoPersonalizacion = CASE @EstrategiaCodigo
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE ''
	END;

	RETURN @TipoPersonalizacion
END;
GO

USE BelcorpCostaRica_GANAMAS;
GO

IF(OBJECT_ID('dbo.fnGetTipoPersonalizacion','FN') IS NOT NULL)
BEGIN
	DROP FUNCTION [dbo].[fnGetTipoPersonalizacion];
END;
GO

CREATE FUNCTION [dbo].[fnGetTipoPersonalizacion]
(
	@EstrategiaCodigo VARCHAR(100)
)
RETURNS VARCHAR(5)
BEGIN
	DECLARE @TipoPersonalizacion VARCHAR(5);

	SET @TipoPersonalizacion = CASE @EstrategiaCodigo
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE ''
	END;

	RETURN @TipoPersonalizacion
END;
GO

USE BelcorpEcuador_GANAMAS;
GO

IF(OBJECT_ID('dbo.fnGetTipoPersonalizacion','FN') IS NOT NULL)
BEGIN
	DROP FUNCTION [dbo].[fnGetTipoPersonalizacion];
END;
GO

CREATE FUNCTION [dbo].[fnGetTipoPersonalizacion]
(
	@EstrategiaCodigo VARCHAR(100)
)
RETURNS VARCHAR(5)
BEGIN
	DECLARE @TipoPersonalizacion VARCHAR(5);

	SET @TipoPersonalizacion = CASE @EstrategiaCodigo
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE ''
	END;

	RETURN @TipoPersonalizacion
END;
GO

USE BelcorpMexico_GANAMAS;
GO

IF(OBJECT_ID('dbo.fnGetTipoPersonalizacion','FN') IS NOT NULL)
BEGIN
	DROP FUNCTION [dbo].[fnGetTipoPersonalizacion];
END;
GO

CREATE FUNCTION [dbo].[fnGetTipoPersonalizacion]
(
	@EstrategiaCodigo VARCHAR(100)
)
RETURNS VARCHAR(5)
BEGIN
	DECLARE @TipoPersonalizacion VARCHAR(5);

	SET @TipoPersonalizacion = CASE @EstrategiaCodigo
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE ''
	END;

	RETURN @TipoPersonalizacion
END;
GO
