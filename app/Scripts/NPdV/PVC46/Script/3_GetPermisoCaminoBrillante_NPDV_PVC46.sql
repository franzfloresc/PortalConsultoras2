USE BelcorpPeru
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPermisoCaminoBrillante'))
Begin
	Drop PROC GetPermisoCaminoBrillante
End
GO
CREATE FUNCTION [dbo].[GetPermisoCaminoBrillante]
(
	@CONSULTORA_COD varchar(20)
)
RETURNS INT
BEGIN
	DECLARE @RESULTADO INT = 0
	DECLARE @REGION_COD VARCHAR(20) = ''
	DECLARE @ZONA_COD VARCHAR(20) = ''
	DECLARE @SECCION_COD VARCHAR(20) = ''
	DECLARE @CONFIGURACION_ID INT = 0
	DECLARE @CONFIGURACION_DETA BIT = 0

	SELECT @CONFIGURACION_ID = ConfiguracionPaisID FROM ConfiguracionPais WHERE codigo = 'CAMINOBRILLANTE' AND ESTADO = 1;

	IF EXISTS(SELECT 1 FROM USUARIO (NOLOCK) WHERE CodigoConsultora =  @CONSULTORA_COD AND TipoUsuario != 2 AND @CONFIGURACION_ID != 0)
	BEGIN
		SELECT @REGION_COD = REG.Codigo, @ZONA_COD = ZON.Codigo
			FROM ODS.CONSULTORA (NOLOCK) AS CON 
			LEFT JOIN ODS.REGION (NOLOCK) AS REG
				ON  CON.RegionID = REG.RegionID
			LEFT JOIN ODS.ZONA (NOLOCK) AS ZON
				ON CON.ZonaID = ZON.ZonaID
			WHERE CON.Codigo = @CONSULTORA_COD;

		SELECT @CONFIGURACION_DETA = 1 
			FROM ConfiguracionPaisDetalle 
			WHERE ConfiguracionPaisID = @CONFIGURACION_ID 
				  AND Estado = 1
				  AND ( CodigoRegion IS NULL OR CodigoRegion IN ('', @REGION_COD))
				  AND ( CodigoZona IS NULL OR CodigoZona IN ('', @ZONA_COD))
				  AND ( CodigoSeccion IS NULL OR CodigoSeccion IN ('', @SECCION_COD))
				  AND (CodigoConsultora IS NULL OR CodigoConsultora IN ('', @CONSULTORA_COD));
		
		SELECT @RESULTADO = 1
			FROM ConfiguracionPais
			WHERE codigo = 'CAMINOBRILLANTE' 
				  AND ( (Excluyente = 1 AND @CONFIGURACION_DETA = 0 ) OR (Excluyente = 0 AND @CONFIGURACION_DETA = 1 ) )
	END

	return @RESULTADO
END
GO

USE BelcorpMexico
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPermisoCaminoBrillante'))
Begin
	Drop PROC GetPermisoCaminoBrillante
End
GO
CREATE FUNCTION [dbo].[GetPermisoCaminoBrillante]
(
	@CONSULTORA_COD varchar(20)
)
RETURNS INT
BEGIN
	DECLARE @RESULTADO INT = 0
	DECLARE @REGION_COD VARCHAR(20) = ''
	DECLARE @ZONA_COD VARCHAR(20) = ''
	DECLARE @SECCION_COD VARCHAR(20) = ''
	DECLARE @CONFIGURACION_ID INT = 0
	DECLARE @CONFIGURACION_DETA BIT = 0

	SELECT @CONFIGURACION_ID = ConfiguracionPaisID FROM ConfiguracionPais WHERE codigo = 'CAMINOBRILLANTE' AND ESTADO = 1;

	IF EXISTS(SELECT 1 FROM USUARIO (NOLOCK) WHERE CodigoConsultora =  @CONSULTORA_COD AND TipoUsuario != 2 AND @CONFIGURACION_ID != 0)
	BEGIN
		SELECT @REGION_COD = REG.Codigo, @ZONA_COD = ZON.Codigo
			FROM ODS.CONSULTORA (NOLOCK) AS CON 
			LEFT JOIN ODS.REGION (NOLOCK) AS REG
				ON  CON.RegionID = REG.RegionID
			LEFT JOIN ODS.ZONA (NOLOCK) AS ZON
				ON CON.ZonaID = ZON.ZonaID
			WHERE CON.Codigo = @CONSULTORA_COD;

		SELECT @CONFIGURACION_DETA = 1 
			FROM ConfiguracionPaisDetalle 
			WHERE ConfiguracionPaisID = @CONFIGURACION_ID 
				  AND Estado = 1
				  AND ( CodigoRegion IS NULL OR CodigoRegion IN ('', @REGION_COD))
				  AND ( CodigoZona IS NULL OR CodigoZona IN ('', @ZONA_COD))
				  AND ( CodigoSeccion IS NULL OR CodigoSeccion IN ('', @SECCION_COD))
				  AND (CodigoConsultora IS NULL OR CodigoConsultora IN ('', @CONSULTORA_COD));
		
		SELECT @RESULTADO = 1
			FROM ConfiguracionPais
			WHERE codigo = 'CAMINOBRILLANTE' 
				  AND ( (Excluyente = 1 AND @CONFIGURACION_DETA = 0 ) OR (Excluyente = 0 AND @CONFIGURACION_DETA = 1 ) )
	END

	return @RESULTADO
END
GO

USE BelcorpColombia
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPermisoCaminoBrillante'))
Begin
	Drop PROC GetPermisoCaminoBrillante
End
GO
CREATE FUNCTION [dbo].[GetPermisoCaminoBrillante]
(
	@CONSULTORA_COD varchar(20)
)
RETURNS INT
BEGIN
	DECLARE @RESULTADO INT = 0
	DECLARE @REGION_COD VARCHAR(20) = ''
	DECLARE @ZONA_COD VARCHAR(20) = ''
	DECLARE @SECCION_COD VARCHAR(20) = ''
	DECLARE @CONFIGURACION_ID INT = 0
	DECLARE @CONFIGURACION_DETA BIT = 0

	SELECT @CONFIGURACION_ID = ConfiguracionPaisID FROM ConfiguracionPais WHERE codigo = 'CAMINOBRILLANTE' AND ESTADO = 1;

	IF EXISTS(SELECT 1 FROM USUARIO (NOLOCK) WHERE CodigoConsultora =  @CONSULTORA_COD AND TipoUsuario != 2 AND @CONFIGURACION_ID != 0)
	BEGIN
		SELECT @REGION_COD = REG.Codigo, @ZONA_COD = ZON.Codigo
			FROM ODS.CONSULTORA (NOLOCK) AS CON 
			LEFT JOIN ODS.REGION (NOLOCK) AS REG
				ON  CON.RegionID = REG.RegionID
			LEFT JOIN ODS.ZONA (NOLOCK) AS ZON
				ON CON.ZonaID = ZON.ZonaID
			WHERE CON.Codigo = @CONSULTORA_COD;

		SELECT @CONFIGURACION_DETA = 1 
			FROM ConfiguracionPaisDetalle 
			WHERE ConfiguracionPaisID = @CONFIGURACION_ID 
				  AND Estado = 1
				  AND ( CodigoRegion IS NULL OR CodigoRegion IN ('', @REGION_COD))
				  AND ( CodigoZona IS NULL OR CodigoZona IN ('', @ZONA_COD))
				  AND ( CodigoSeccion IS NULL OR CodigoSeccion IN ('', @SECCION_COD))
				  AND (CodigoConsultora IS NULL OR CodigoConsultora IN ('', @CONSULTORA_COD));
		
		SELECT @RESULTADO = 1
			FROM ConfiguracionPais
			WHERE codigo = 'CAMINOBRILLANTE' 
				  AND ( (Excluyente = 1 AND @CONFIGURACION_DETA = 0 ) OR (Excluyente = 0 AND @CONFIGURACION_DETA = 1 ) )
	END

	return @RESULTADO
END
GO

USE BelcorpSalvador
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPermisoCaminoBrillante'))
Begin
	Drop PROC GetPermisoCaminoBrillante
End
GO
CREATE FUNCTION [dbo].[GetPermisoCaminoBrillante]
(
	@CONSULTORA_COD varchar(20)
)
RETURNS INT
BEGIN
	DECLARE @RESULTADO INT = 0
	DECLARE @REGION_COD VARCHAR(20) = ''
	DECLARE @ZONA_COD VARCHAR(20) = ''
	DECLARE @SECCION_COD VARCHAR(20) = ''
	DECLARE @CONFIGURACION_ID INT = 0
	DECLARE @CONFIGURACION_DETA BIT = 0

	SELECT @CONFIGURACION_ID = ConfiguracionPaisID FROM ConfiguracionPais WHERE codigo = 'CAMINOBRILLANTE' AND ESTADO = 1;

	IF EXISTS(SELECT 1 FROM USUARIO (NOLOCK) WHERE CodigoConsultora =  @CONSULTORA_COD AND TipoUsuario != 2 AND @CONFIGURACION_ID != 0)
	BEGIN
		SELECT @REGION_COD = REG.Codigo, @ZONA_COD = ZON.Codigo
			FROM ODS.CONSULTORA (NOLOCK) AS CON 
			LEFT JOIN ODS.REGION (NOLOCK) AS REG
				ON  CON.RegionID = REG.RegionID
			LEFT JOIN ODS.ZONA (NOLOCK) AS ZON
				ON CON.ZonaID = ZON.ZonaID
			WHERE CON.Codigo = @CONSULTORA_COD;

		SELECT @CONFIGURACION_DETA = 1 
			FROM ConfiguracionPaisDetalle 
			WHERE ConfiguracionPaisID = @CONFIGURACION_ID 
				  AND Estado = 1
				  AND ( CodigoRegion IS NULL OR CodigoRegion IN ('', @REGION_COD))
				  AND ( CodigoZona IS NULL OR CodigoZona IN ('', @ZONA_COD))
				  AND ( CodigoSeccion IS NULL OR CodigoSeccion IN ('', @SECCION_COD))
				  AND (CodigoConsultora IS NULL OR CodigoConsultora IN ('', @CONSULTORA_COD));
		
		SELECT @RESULTADO = 1
			FROM ConfiguracionPais
			WHERE codigo = 'CAMINOBRILLANTE' 
				  AND ( (Excluyente = 1 AND @CONFIGURACION_DETA = 0 ) OR (Excluyente = 0 AND @CONFIGURACION_DETA = 1 ) )
	END

	return @RESULTADO
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPermisoCaminoBrillante'))
Begin
	Drop PROC GetPermisoCaminoBrillante
End
GO
CREATE FUNCTION [dbo].[GetPermisoCaminoBrillante]
(
	@CONSULTORA_COD varchar(20)
)
RETURNS INT
BEGIN
	DECLARE @RESULTADO INT = 0
	DECLARE @REGION_COD VARCHAR(20) = ''
	DECLARE @ZONA_COD VARCHAR(20) = ''
	DECLARE @SECCION_COD VARCHAR(20) = ''
	DECLARE @CONFIGURACION_ID INT = 0
	DECLARE @CONFIGURACION_DETA BIT = 0

	SELECT @CONFIGURACION_ID = ConfiguracionPaisID FROM ConfiguracionPais WHERE codigo = 'CAMINOBRILLANTE' AND ESTADO = 1;

	IF EXISTS(SELECT 1 FROM USUARIO (NOLOCK) WHERE CodigoConsultora =  @CONSULTORA_COD AND TipoUsuario != 2 AND @CONFIGURACION_ID != 0)
	BEGIN
		SELECT @REGION_COD = REG.Codigo, @ZONA_COD = ZON.Codigo
			FROM ODS.CONSULTORA (NOLOCK) AS CON 
			LEFT JOIN ODS.REGION (NOLOCK) AS REG
				ON  CON.RegionID = REG.RegionID
			LEFT JOIN ODS.ZONA (NOLOCK) AS ZON
				ON CON.ZonaID = ZON.ZonaID
			WHERE CON.Codigo = @CONSULTORA_COD;

		SELECT @CONFIGURACION_DETA = 1 
			FROM ConfiguracionPaisDetalle 
			WHERE ConfiguracionPaisID = @CONFIGURACION_ID 
				  AND Estado = 1
				  AND ( CodigoRegion IS NULL OR CodigoRegion IN ('', @REGION_COD))
				  AND ( CodigoZona IS NULL OR CodigoZona IN ('', @ZONA_COD))
				  AND ( CodigoSeccion IS NULL OR CodigoSeccion IN ('', @SECCION_COD))
				  AND (CodigoConsultora IS NULL OR CodigoConsultora IN ('', @CONSULTORA_COD));
		
		SELECT @RESULTADO = 1
			FROM ConfiguracionPais
			WHERE codigo = 'CAMINOBRILLANTE' 
				  AND ( (Excluyente = 1 AND @CONFIGURACION_DETA = 0 ) OR (Excluyente = 0 AND @CONFIGURACION_DETA = 1 ) )
	END

	return @RESULTADO
END
GO

USE BelcorpPanama
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPermisoCaminoBrillante'))
Begin
	Drop PROC GetPermisoCaminoBrillante
End
GO
CREATE FUNCTION [dbo].[GetPermisoCaminoBrillante]
(
	@CONSULTORA_COD varchar(20)
)
RETURNS INT
BEGIN
	DECLARE @RESULTADO INT = 0
	DECLARE @REGION_COD VARCHAR(20) = ''
	DECLARE @ZONA_COD VARCHAR(20) = ''
	DECLARE @SECCION_COD VARCHAR(20) = ''
	DECLARE @CONFIGURACION_ID INT = 0
	DECLARE @CONFIGURACION_DETA BIT = 0

	SELECT @CONFIGURACION_ID = ConfiguracionPaisID FROM ConfiguracionPais WHERE codigo = 'CAMINOBRILLANTE' AND ESTADO = 1;

	IF EXISTS(SELECT 1 FROM USUARIO (NOLOCK) WHERE CodigoConsultora =  @CONSULTORA_COD AND TipoUsuario != 2 AND @CONFIGURACION_ID != 0)
	BEGIN
		SELECT @REGION_COD = REG.Codigo, @ZONA_COD = ZON.Codigo
			FROM ODS.CONSULTORA (NOLOCK) AS CON 
			LEFT JOIN ODS.REGION (NOLOCK) AS REG
				ON  CON.RegionID = REG.RegionID
			LEFT JOIN ODS.ZONA (NOLOCK) AS ZON
				ON CON.ZonaID = ZON.ZonaID
			WHERE CON.Codigo = @CONSULTORA_COD;

		SELECT @CONFIGURACION_DETA = 1 
			FROM ConfiguracionPaisDetalle 
			WHERE ConfiguracionPaisID = @CONFIGURACION_ID 
				  AND Estado = 1
				  AND ( CodigoRegion IS NULL OR CodigoRegion IN ('', @REGION_COD))
				  AND ( CodigoZona IS NULL OR CodigoZona IN ('', @ZONA_COD))
				  AND ( CodigoSeccion IS NULL OR CodigoSeccion IN ('', @SECCION_COD))
				  AND (CodigoConsultora IS NULL OR CodigoConsultora IN ('', @CONSULTORA_COD));
		
		SELECT @RESULTADO = 1
			FROM ConfiguracionPais
			WHERE codigo = 'CAMINOBRILLANTE' 
				  AND ( (Excluyente = 1 AND @CONFIGURACION_DETA = 0 ) OR (Excluyente = 0 AND @CONFIGURACION_DETA = 1 ) )
	END

	return @RESULTADO
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPermisoCaminoBrillante'))
Begin
	Drop PROC GetPermisoCaminoBrillante
End
GO
CREATE FUNCTION [dbo].[GetPermisoCaminoBrillante]
(
	@CONSULTORA_COD varchar(20)
)
RETURNS INT
BEGIN
	DECLARE @RESULTADO INT = 0
	DECLARE @REGION_COD VARCHAR(20) = ''
	DECLARE @ZONA_COD VARCHAR(20) = ''
	DECLARE @SECCION_COD VARCHAR(20) = ''
	DECLARE @CONFIGURACION_ID INT = 0
	DECLARE @CONFIGURACION_DETA BIT = 0

	SELECT @CONFIGURACION_ID = ConfiguracionPaisID FROM ConfiguracionPais WHERE codigo = 'CAMINOBRILLANTE' AND ESTADO = 1;

	IF EXISTS(SELECT 1 FROM USUARIO (NOLOCK) WHERE CodigoConsultora =  @CONSULTORA_COD AND TipoUsuario != 2 AND @CONFIGURACION_ID != 0)
	BEGIN
		SELECT @REGION_COD = REG.Codigo, @ZONA_COD = ZON.Codigo
			FROM ODS.CONSULTORA (NOLOCK) AS CON 
			LEFT JOIN ODS.REGION (NOLOCK) AS REG
				ON  CON.RegionID = REG.RegionID
			LEFT JOIN ODS.ZONA (NOLOCK) AS ZON
				ON CON.ZonaID = ZON.ZonaID
			WHERE CON.Codigo = @CONSULTORA_COD;

		SELECT @CONFIGURACION_DETA = 1 
			FROM ConfiguracionPaisDetalle 
			WHERE ConfiguracionPaisID = @CONFIGURACION_ID 
				  AND Estado = 1
				  AND ( CodigoRegion IS NULL OR CodigoRegion IN ('', @REGION_COD))
				  AND ( CodigoZona IS NULL OR CodigoZona IN ('', @ZONA_COD))
				  AND ( CodigoSeccion IS NULL OR CodigoSeccion IN ('', @SECCION_COD))
				  AND (CodigoConsultora IS NULL OR CodigoConsultora IN ('', @CONSULTORA_COD));
		
		SELECT @RESULTADO = 1
			FROM ConfiguracionPais
			WHERE codigo = 'CAMINOBRILLANTE' 
				  AND ( (Excluyente = 1 AND @CONFIGURACION_DETA = 0 ) OR (Excluyente = 0 AND @CONFIGURACION_DETA = 1 ) )
	END

	return @RESULTADO
END
GO

USE BelcorpEcuador
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPermisoCaminoBrillante'))
Begin
	Drop PROC GetPermisoCaminoBrillante
End
GO
CREATE FUNCTION [dbo].[GetPermisoCaminoBrillante]
(
	@CONSULTORA_COD varchar(20)
)
RETURNS INT
BEGIN
	DECLARE @RESULTADO INT = 0
	DECLARE @REGION_COD VARCHAR(20) = ''
	DECLARE @ZONA_COD VARCHAR(20) = ''
	DECLARE @SECCION_COD VARCHAR(20) = ''
	DECLARE @CONFIGURACION_ID INT = 0
	DECLARE @CONFIGURACION_DETA BIT = 0

	SELECT @CONFIGURACION_ID = ConfiguracionPaisID FROM ConfiguracionPais WHERE codigo = 'CAMINOBRILLANTE' AND ESTADO = 1;

	IF EXISTS(SELECT 1 FROM USUARIO (NOLOCK) WHERE CodigoConsultora =  @CONSULTORA_COD AND TipoUsuario != 2 AND @CONFIGURACION_ID != 0)
	BEGIN
		SELECT @REGION_COD = REG.Codigo, @ZONA_COD = ZON.Codigo
			FROM ODS.CONSULTORA (NOLOCK) AS CON 
			LEFT JOIN ODS.REGION (NOLOCK) AS REG
				ON  CON.RegionID = REG.RegionID
			LEFT JOIN ODS.ZONA (NOLOCK) AS ZON
				ON CON.ZonaID = ZON.ZonaID
			WHERE CON.Codigo = @CONSULTORA_COD;

		SELECT @CONFIGURACION_DETA = 1 
			FROM ConfiguracionPaisDetalle 
			WHERE ConfiguracionPaisID = @CONFIGURACION_ID 
				  AND Estado = 1
				  AND ( CodigoRegion IS NULL OR CodigoRegion IN ('', @REGION_COD))
				  AND ( CodigoZona IS NULL OR CodigoZona IN ('', @ZONA_COD))
				  AND ( CodigoSeccion IS NULL OR CodigoSeccion IN ('', @SECCION_COD))
				  AND (CodigoConsultora IS NULL OR CodigoConsultora IN ('', @CONSULTORA_COD));
		
		SELECT @RESULTADO = 1
			FROM ConfiguracionPais
			WHERE codigo = 'CAMINOBRILLANTE' 
				  AND ( (Excluyente = 1 AND @CONFIGURACION_DETA = 0 ) OR (Excluyente = 0 AND @CONFIGURACION_DETA = 1 ) )
	END

	return @RESULTADO
END
GO

USE BelcorpDominicana
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPermisoCaminoBrillante'))
Begin
	Drop PROC GetPermisoCaminoBrillante
End
GO
CREATE FUNCTION [dbo].[GetPermisoCaminoBrillante]
(
	@CONSULTORA_COD varchar(20)
)
RETURNS INT
BEGIN
	DECLARE @RESULTADO INT = 0
	DECLARE @REGION_COD VARCHAR(20) = ''
	DECLARE @ZONA_COD VARCHAR(20) = ''
	DECLARE @SECCION_COD VARCHAR(20) = ''
	DECLARE @CONFIGURACION_ID INT = 0
	DECLARE @CONFIGURACION_DETA BIT = 0

	SELECT @CONFIGURACION_ID = ConfiguracionPaisID FROM ConfiguracionPais WHERE codigo = 'CAMINOBRILLANTE' AND ESTADO = 1;

	IF EXISTS(SELECT 1 FROM USUARIO (NOLOCK) WHERE CodigoConsultora =  @CONSULTORA_COD AND TipoUsuario != 2 AND @CONFIGURACION_ID != 0)
	BEGIN
		SELECT @REGION_COD = REG.Codigo, @ZONA_COD = ZON.Codigo
			FROM ODS.CONSULTORA (NOLOCK) AS CON 
			LEFT JOIN ODS.REGION (NOLOCK) AS REG
				ON  CON.RegionID = REG.RegionID
			LEFT JOIN ODS.ZONA (NOLOCK) AS ZON
				ON CON.ZonaID = ZON.ZonaID
			WHERE CON.Codigo = @CONSULTORA_COD;

		SELECT @CONFIGURACION_DETA = 1 
			FROM ConfiguracionPaisDetalle 
			WHERE ConfiguracionPaisID = @CONFIGURACION_ID 
				  AND Estado = 1
				  AND ( CodigoRegion IS NULL OR CodigoRegion IN ('', @REGION_COD))
				  AND ( CodigoZona IS NULL OR CodigoZona IN ('', @ZONA_COD))
				  AND ( CodigoSeccion IS NULL OR CodigoSeccion IN ('', @SECCION_COD))
				  AND (CodigoConsultora IS NULL OR CodigoConsultora IN ('', @CONSULTORA_COD));
		
		SELECT @RESULTADO = 1
			FROM ConfiguracionPais
			WHERE codigo = 'CAMINOBRILLANTE' 
				  AND ( (Excluyente = 1 AND @CONFIGURACION_DETA = 0 ) OR (Excluyente = 0 AND @CONFIGURACION_DETA = 1 ) )
	END

	return @RESULTADO
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPermisoCaminoBrillante'))
Begin
	Drop PROC GetPermisoCaminoBrillante
End
GO
CREATE FUNCTION [dbo].[GetPermisoCaminoBrillante]
(
	@CONSULTORA_COD varchar(20)
)
RETURNS INT
BEGIN
	DECLARE @RESULTADO INT = 0
	DECLARE @REGION_COD VARCHAR(20) = ''
	DECLARE @ZONA_COD VARCHAR(20) = ''
	DECLARE @SECCION_COD VARCHAR(20) = ''
	DECLARE @CONFIGURACION_ID INT = 0
	DECLARE @CONFIGURACION_DETA BIT = 0

	SELECT @CONFIGURACION_ID = ConfiguracionPaisID FROM ConfiguracionPais WHERE codigo = 'CAMINOBRILLANTE' AND ESTADO = 1;

	IF EXISTS(SELECT 1 FROM USUARIO (NOLOCK) WHERE CodigoConsultora =  @CONSULTORA_COD AND TipoUsuario != 2 AND @CONFIGURACION_ID != 0)
	BEGIN
		SELECT @REGION_COD = REG.Codigo, @ZONA_COD = ZON.Codigo
			FROM ODS.CONSULTORA (NOLOCK) AS CON 
			LEFT JOIN ODS.REGION (NOLOCK) AS REG
				ON  CON.RegionID = REG.RegionID
			LEFT JOIN ODS.ZONA (NOLOCK) AS ZON
				ON CON.ZonaID = ZON.ZonaID
			WHERE CON.Codigo = @CONSULTORA_COD;

		SELECT @CONFIGURACION_DETA = 1 
			FROM ConfiguracionPaisDetalle 
			WHERE ConfiguracionPaisID = @CONFIGURACION_ID 
				  AND Estado = 1
				  AND ( CodigoRegion IS NULL OR CodigoRegion IN ('', @REGION_COD))
				  AND ( CodigoZona IS NULL OR CodigoZona IN ('', @ZONA_COD))
				  AND ( CodigoSeccion IS NULL OR CodigoSeccion IN ('', @SECCION_COD))
				  AND (CodigoConsultora IS NULL OR CodigoConsultora IN ('', @CONSULTORA_COD));
		
		SELECT @RESULTADO = 1
			FROM ConfiguracionPais
			WHERE codigo = 'CAMINOBRILLANTE' 
				  AND ( (Excluyente = 1 AND @CONFIGURACION_DETA = 0 ) OR (Excluyente = 0 AND @CONFIGURACION_DETA = 1 ) )
	END

	return @RESULTADO
END
GO

USE BelcorpChile
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPermisoCaminoBrillante'))
Begin
	Drop PROC GetPermisoCaminoBrillante
End
GO
CREATE FUNCTION [dbo].[GetPermisoCaminoBrillante]
(
	@CONSULTORA_COD varchar(20)
)
RETURNS INT
BEGIN
	DECLARE @RESULTADO INT = 0
	DECLARE @REGION_COD VARCHAR(20) = ''
	DECLARE @ZONA_COD VARCHAR(20) = ''
	DECLARE @SECCION_COD VARCHAR(20) = ''
	DECLARE @CONFIGURACION_ID INT = 0
	DECLARE @CONFIGURACION_DETA BIT = 0

	SELECT @CONFIGURACION_ID = ConfiguracionPaisID FROM ConfiguracionPais WHERE codigo = 'CAMINOBRILLANTE' AND ESTADO = 1;

	IF EXISTS(SELECT 1 FROM USUARIO (NOLOCK) WHERE CodigoConsultora =  @CONSULTORA_COD AND TipoUsuario != 2 AND @CONFIGURACION_ID != 0)
	BEGIN
		SELECT @REGION_COD = REG.Codigo, @ZONA_COD = ZON.Codigo
			FROM ODS.CONSULTORA (NOLOCK) AS CON 
			LEFT JOIN ODS.REGION (NOLOCK) AS REG
				ON  CON.RegionID = REG.RegionID
			LEFT JOIN ODS.ZONA (NOLOCK) AS ZON
				ON CON.ZonaID = ZON.ZonaID
			WHERE CON.Codigo = @CONSULTORA_COD;

		SELECT @CONFIGURACION_DETA = 1 
			FROM ConfiguracionPaisDetalle 
			WHERE ConfiguracionPaisID = @CONFIGURACION_ID 
				  AND Estado = 1
				  AND ( CodigoRegion IS NULL OR CodigoRegion IN ('', @REGION_COD))
				  AND ( CodigoZona IS NULL OR CodigoZona IN ('', @ZONA_COD))
				  AND ( CodigoSeccion IS NULL OR CodigoSeccion IN ('', @SECCION_COD))
				  AND (CodigoConsultora IS NULL OR CodigoConsultora IN ('', @CONSULTORA_COD));
		
		SELECT @RESULTADO = 1
			FROM ConfiguracionPais
			WHERE codigo = 'CAMINOBRILLANTE' 
				  AND ( (Excluyente = 1 AND @CONFIGURACION_DETA = 0 ) OR (Excluyente = 0 AND @CONFIGURACION_DETA = 1 ) )
	END

	return @RESULTADO
END
GO

USE BelcorpBolivia
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPermisoCaminoBrillante'))
Begin
	Drop PROC GetPermisoCaminoBrillante
End
GO
CREATE FUNCTION [dbo].[GetPermisoCaminoBrillante]
(
	@CONSULTORA_COD varchar(20)
)
RETURNS INT
BEGIN
	DECLARE @RESULTADO INT = 0
	DECLARE @REGION_COD VARCHAR(20) = ''
	DECLARE @ZONA_COD VARCHAR(20) = ''
	DECLARE @SECCION_COD VARCHAR(20) = ''
	DECLARE @CONFIGURACION_ID INT = 0
	DECLARE @CONFIGURACION_DETA BIT = 0

	SELECT @CONFIGURACION_ID = ConfiguracionPaisID FROM ConfiguracionPais WHERE codigo = 'CAMINOBRILLANTE' AND ESTADO = 1;

	IF EXISTS(SELECT 1 FROM USUARIO (NOLOCK) WHERE CodigoConsultora =  @CONSULTORA_COD AND TipoUsuario != 2 AND @CONFIGURACION_ID != 0)
	BEGIN
		SELECT @REGION_COD = REG.Codigo, @ZONA_COD = ZON.Codigo
			FROM ODS.CONSULTORA (NOLOCK) AS CON 
			LEFT JOIN ODS.REGION (NOLOCK) AS REG
				ON  CON.RegionID = REG.RegionID
			LEFT JOIN ODS.ZONA (NOLOCK) AS ZON
				ON CON.ZonaID = ZON.ZonaID
			WHERE CON.Codigo = @CONSULTORA_COD;

		SELECT @CONFIGURACION_DETA = 1 
			FROM ConfiguracionPaisDetalle 
			WHERE ConfiguracionPaisID = @CONFIGURACION_ID 
				  AND Estado = 1
				  AND ( CodigoRegion IS NULL OR CodigoRegion IN ('', @REGION_COD))
				  AND ( CodigoZona IS NULL OR CodigoZona IN ('', @ZONA_COD))
				  AND ( CodigoSeccion IS NULL OR CodigoSeccion IN ('', @SECCION_COD))
				  AND (CodigoConsultora IS NULL OR CodigoConsultora IN ('', @CONSULTORA_COD));
		
		SELECT @RESULTADO = 1
			FROM ConfiguracionPais
			WHERE codigo = 'CAMINOBRILLANTE' 
				  AND ( (Excluyente = 1 AND @CONFIGURACION_DETA = 0 ) OR (Excluyente = 0 AND @CONFIGURACION_DETA = 1 ) )
	END

	return @RESULTADO
END
GO

