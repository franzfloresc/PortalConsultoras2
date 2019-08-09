GO
USE BelcorpPeru
GO
ALTER FUNCTION [dbo].[fnGetTipoPersonalizacion]
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
USE BelcorpMexico
GO
ALTER FUNCTION [dbo].[fnGetTipoPersonalizacion]
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
USE BelcorpColombia
GO
ALTER FUNCTION [dbo].[fnGetTipoPersonalizacion]
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
USE BelcorpSalvador
GO
ALTER FUNCTION [dbo].[fnGetTipoPersonalizacion]
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
USE BelcorpPuertoRico
GO
ALTER FUNCTION [dbo].[fnGetTipoPersonalizacion]
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
USE BelcorpPanama
GO
ALTER FUNCTION [dbo].[fnGetTipoPersonalizacion]
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
USE BelcorpGuatemala
GO
ALTER FUNCTION [dbo].[fnGetTipoPersonalizacion]
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
USE BelcorpEcuador
GO
ALTER FUNCTION [dbo].[fnGetTipoPersonalizacion]
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
USE BelcorpDominicana
GO
ALTER FUNCTION [dbo].[fnGetTipoPersonalizacion]
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
USE BelcorpCostaRica
GO
ALTER FUNCTION [dbo].[fnGetTipoPersonalizacion]
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
USE BelcorpChile
GO
ALTER FUNCTION [dbo].[fnGetTipoPersonalizacion]
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
USE BelcorpBolivia
GO
ALTER FUNCTION [dbo].[fnGetTipoPersonalizacion]
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
