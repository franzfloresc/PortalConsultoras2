GO
USE BelcorpPeru
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetCodigoTipoEstrategia') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetCodigoTipoEstrategia]
GO
CREATE FUNCTION [fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion varchar(100)
)
returns varchar(100)
begin

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
	END
	return @Codigo
end
GO

GO
USE BelcorpMexico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetCodigoTipoEstrategia') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetCodigoTipoEstrategia]
GO
CREATE FUNCTION [fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion varchar(100)
)
returns varchar(100)
begin

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
	END
	return @Codigo
end
GO

GO
USE BelcorpColombia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetCodigoTipoEstrategia') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetCodigoTipoEstrategia]
GO
CREATE FUNCTION [fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion varchar(100)
)
returns varchar(100)
begin

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
	END
	return @Codigo
end
GO

GO
USE BelcorpSalvador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetCodigoTipoEstrategia') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetCodigoTipoEstrategia]
GO
CREATE FUNCTION [fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion varchar(100)
)
returns varchar(100)
begin

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
	END
	return @Codigo
end
GO

GO
USE BelcorpPuertoRico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetCodigoTipoEstrategia') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetCodigoTipoEstrategia]
GO
CREATE FUNCTION [fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion varchar(100)
)
returns varchar(100)
begin

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
	END
	return @Codigo
end
GO

GO
USE BelcorpPanama
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetCodigoTipoEstrategia') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetCodigoTipoEstrategia]
GO
CREATE FUNCTION [fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion varchar(100)
)
returns varchar(100)
begin

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
	END
	return @Codigo
end
GO

GO
USE BelcorpGuatemala
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetCodigoTipoEstrategia') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetCodigoTipoEstrategia]
GO
CREATE FUNCTION [fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion varchar(100)
)
returns varchar(100)
begin

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
	END
	return @Codigo
end
GO

GO
USE BelcorpEcuador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetCodigoTipoEstrategia') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetCodigoTipoEstrategia]
GO
CREATE FUNCTION [fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion varchar(100)
)
returns varchar(100)
begin

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
	END
	return @Codigo
end
GO

GO
USE BelcorpDominicana
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetCodigoTipoEstrategia') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetCodigoTipoEstrategia]
GO
CREATE FUNCTION [fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion varchar(100)
)
returns varchar(100)
begin

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
	END
	return @Codigo
end
GO

GO
USE BelcorpCostaRica
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetCodigoTipoEstrategia') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetCodigoTipoEstrategia]
GO
CREATE FUNCTION [fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion varchar(100)
)
returns varchar(100)
begin

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
	END
	return @Codigo
end
GO

GO
USE BelcorpChile
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetCodigoTipoEstrategia') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetCodigoTipoEstrategia]
GO
CREATE FUNCTION [fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion varchar(100)
)
returns varchar(100)
begin

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
	END
	return @Codigo
end
GO

GO
USE BelcorpBolivia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetCodigoTipoEstrategia') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetCodigoTipoEstrategia]
GO
CREATE FUNCTION [fnGetCodigoTipoEstrategia]
(
	@TipoPersonalizacion varchar(100)
)
returns varchar(100)
begin

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
	END
	return @Codigo
end
GO

GO
