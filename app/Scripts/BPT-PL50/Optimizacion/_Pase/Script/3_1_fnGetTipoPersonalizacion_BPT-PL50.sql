GO
USE BelcorpPeru
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoPersonalizacion') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoPersonalizacion]
GO
CREATE FUNCTION [fnGetTipoPersonalizacion]
(
	@EstrategiaCodigo varchar(100)
)
returns varchar(5)
begin

	DECLARE @TipoPersonalizacion varchar(5)
	SET @TipoPersonalizacion = CASE @EstrategiaCodigo
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE ''
	END
	return @TipoPersonalizacion
end
GO

GO
USE BelcorpMexico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoPersonalizacion') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoPersonalizacion]
GO
CREATE FUNCTION [fnGetTipoPersonalizacion]
(
	@EstrategiaCodigo varchar(100)
)
returns varchar(5)
begin

	DECLARE @TipoPersonalizacion varchar(5)
	SET @TipoPersonalizacion = CASE @EstrategiaCodigo
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE ''
	END
	return @TipoPersonalizacion
end
GO

GO
USE BelcorpColombia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoPersonalizacion') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoPersonalizacion]
GO
CREATE FUNCTION [fnGetTipoPersonalizacion]
(
	@EstrategiaCodigo varchar(100)
)
returns varchar(5)
begin

	DECLARE @TipoPersonalizacion varchar(5)
	SET @TipoPersonalizacion = CASE @EstrategiaCodigo
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE ''
	END
	return @TipoPersonalizacion
end
GO

GO
USE BelcorpSalvador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoPersonalizacion') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoPersonalizacion]
GO
CREATE FUNCTION [fnGetTipoPersonalizacion]
(
	@EstrategiaCodigo varchar(100)
)
returns varchar(5)
begin

	DECLARE @TipoPersonalizacion varchar(5)
	SET @TipoPersonalizacion = CASE @EstrategiaCodigo
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE ''
	END
	return @TipoPersonalizacion
end
GO

GO
USE BelcorpPuertoRico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoPersonalizacion') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoPersonalizacion]
GO
CREATE FUNCTION [fnGetTipoPersonalizacion]
(
	@EstrategiaCodigo varchar(100)
)
returns varchar(5)
begin

	DECLARE @TipoPersonalizacion varchar(5)
	SET @TipoPersonalizacion = CASE @EstrategiaCodigo
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE ''
	END
	return @TipoPersonalizacion
end
GO

GO
USE BelcorpPanama
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoPersonalizacion') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoPersonalizacion]
GO
CREATE FUNCTION [fnGetTipoPersonalizacion]
(
	@EstrategiaCodigo varchar(100)
)
returns varchar(5)
begin

	DECLARE @TipoPersonalizacion varchar(5)
	SET @TipoPersonalizacion = CASE @EstrategiaCodigo
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE ''
	END
	return @TipoPersonalizacion
end
GO

GO
USE BelcorpGuatemala
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoPersonalizacion') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoPersonalizacion]
GO
CREATE FUNCTION [fnGetTipoPersonalizacion]
(
	@EstrategiaCodigo varchar(100)
)
returns varchar(5)
begin

	DECLARE @TipoPersonalizacion varchar(5)
	SET @TipoPersonalizacion = CASE @EstrategiaCodigo
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE ''
	END
	return @TipoPersonalizacion
end
GO

GO
USE BelcorpEcuador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoPersonalizacion') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoPersonalizacion]
GO
CREATE FUNCTION [fnGetTipoPersonalizacion]
(
	@EstrategiaCodigo varchar(100)
)
returns varchar(5)
begin

	DECLARE @TipoPersonalizacion varchar(5)
	SET @TipoPersonalizacion = CASE @EstrategiaCodigo
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE ''
	END
	return @TipoPersonalizacion
end
GO

GO
USE BelcorpDominicana
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoPersonalizacion') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoPersonalizacion]
GO
CREATE FUNCTION [fnGetTipoPersonalizacion]
(
	@EstrategiaCodigo varchar(100)
)
returns varchar(5)
begin

	DECLARE @TipoPersonalizacion varchar(5)
	SET @TipoPersonalizacion = CASE @EstrategiaCodigo
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE ''
	END
	return @TipoPersonalizacion
end
GO

GO
USE BelcorpCostaRica
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoPersonalizacion') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoPersonalizacion]
GO
CREATE FUNCTION [fnGetTipoPersonalizacion]
(
	@EstrategiaCodigo varchar(100)
)
returns varchar(5)
begin

	DECLARE @TipoPersonalizacion varchar(5)
	SET @TipoPersonalizacion = CASE @EstrategiaCodigo
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE ''
	END
	return @TipoPersonalizacion
end
GO

GO
USE BelcorpChile
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoPersonalizacion') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoPersonalizacion]
GO
CREATE FUNCTION [fnGetTipoPersonalizacion]
(
	@EstrategiaCodigo varchar(100)
)
returns varchar(5)
begin

	DECLARE @TipoPersonalizacion varchar(5)
	SET @TipoPersonalizacion = CASE @EstrategiaCodigo
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE ''
	END
	return @TipoPersonalizacion
end
GO

GO
USE BelcorpBolivia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoPersonalizacion') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetTipoPersonalizacion]
GO
CREATE FUNCTION [fnGetTipoPersonalizacion]
(
	@EstrategiaCodigo varchar(100)
)
returns varchar(5)
begin

	DECLARE @TipoPersonalizacion varchar(5)
	SET @TipoPersonalizacion = CASE @EstrategiaCodigo
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE ''
	END
	return @TipoPersonalizacion
end
GO

GO
