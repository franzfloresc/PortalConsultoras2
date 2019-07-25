GO
USE BelcorpPeru
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisesFFVV]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListConfiguracionPaisesFFVV]
GO

CREATE PROC ListConfiguracionPaisesFFVV
(
@CodigoISO varchar(2)
)
AS
BEGIN
	 SELECT
	  ID
	 ,CodPais
	 ,DesarrolloNivelCumplimientoHabilitado
	 ,EdicionFichaConsultoraHabilitado
	 ,MinimoNumeroDigitosTelefonoTrabajoConsultora
	 ,MaximoNumeroDigitosTelefonoTrabajoConsultora
	 ,DiasCobranza
	 ,FlagDigitoVerificador
	 ,FlagGeo
	 ,FlagHanna
	 ,FlagPC
	 ,FlagRDD
	 ,FlagGanaMas
	 ,FlagPDV
	 ,FlagConfZonasUnete
	 from FFVV.ConfiguracionPaisesFFVV
	WHERE CodPais = @CodigoISO
	and  FlagConfZonasUnete = 1
END

GO
USE BelcorpMexico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisesFFVV]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListConfiguracionPaisesFFVV]
GO

CREATE PROC ListConfiguracionPaisesFFVV
(
@CodigoISO varchar(2)
)
AS
BEGIN
	 SELECT
	  ID
	 ,CodPais
	 ,DesarrolloNivelCumplimientoHabilitado
	 ,EdicionFichaConsultoraHabilitado
	 ,MinimoNumeroDigitosTelefonoTrabajoConsultora
	 ,MaximoNumeroDigitosTelefonoTrabajoConsultora
	 ,DiasCobranza
	 ,FlagDigitoVerificador
	 ,FlagGeo
	 ,FlagHanna
	 ,FlagPC
	 ,FlagRDD
	 ,FlagGanaMas
	 ,FlagPDV
	 ,FlagConfZonasUnete
	 from FFVV.ConfiguracionPaisesFFVV
	WHERE CodPais = @CodigoISO
	and  FlagConfZonasUnete = 1
END

GO
USE BelcorpColombia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisesFFVV]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListConfiguracionPaisesFFVV]
GO

CREATE PROC ListConfiguracionPaisesFFVV
(
@CodigoISO varchar(2)
)
AS
BEGIN
	 SELECT
	  ID
	 ,CodPais
	 ,DesarrolloNivelCumplimientoHabilitado
	 ,EdicionFichaConsultoraHabilitado
	 ,MinimoNumeroDigitosTelefonoTrabajoConsultora
	 ,MaximoNumeroDigitosTelefonoTrabajoConsultora
	 ,DiasCobranza
	 ,FlagDigitoVerificador
	 ,FlagGeo
	 ,FlagHanna
	 ,FlagPC
	 ,FlagRDD
	 ,FlagGanaMas
	 ,FlagPDV
	 ,FlagConfZonasUnete
	 from FFVV.ConfiguracionPaisesFFVV
	WHERE CodPais = @CodigoISO
	and  FlagConfZonasUnete = 1
END

GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisesFFVV]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListConfiguracionPaisesFFVV]
GO

CREATE PROC ListConfiguracionPaisesFFVV
(
@CodigoISO varchar(2)
)
AS
BEGIN
	 SELECT
	  ID
	 ,CodPais
	 ,DesarrolloNivelCumplimientoHabilitado
	 ,EdicionFichaConsultoraHabilitado
	 ,MinimoNumeroDigitosTelefonoTrabajoConsultora
	 ,MaximoNumeroDigitosTelefonoTrabajoConsultora
	 ,DiasCobranza
	 ,FlagDigitoVerificador
	 ,FlagGeo
	 ,FlagHanna
	 ,FlagPC
	 ,FlagRDD
	 ,FlagGanaMas
	 ,FlagPDV
	 ,FlagConfZonasUnete
	 from FFVV.ConfiguracionPaisesFFVV
	WHERE CodPais = @CodigoISO
	and  FlagConfZonasUnete = 1
END

GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisesFFVV]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListConfiguracionPaisesFFVV]
GO

CREATE PROC ListConfiguracionPaisesFFVV
(
@CodigoISO varchar(2)
)
AS
BEGIN
	 SELECT
	  ID
	 ,CodPais
	 ,DesarrolloNivelCumplimientoHabilitado
	 ,EdicionFichaConsultoraHabilitado
	 ,MinimoNumeroDigitosTelefonoTrabajoConsultora
	 ,MaximoNumeroDigitosTelefonoTrabajoConsultora
	 ,DiasCobranza
	 ,FlagDigitoVerificador
	 ,FlagGeo
	 ,FlagHanna
	 ,FlagPC
	 ,FlagRDD
	 ,FlagGanaMas
	 ,FlagPDV
	 ,FlagConfZonasUnete
	 from FFVV.ConfiguracionPaisesFFVV
	WHERE CodPais = @CodigoISO
	and  FlagConfZonasUnete = 1
END

GO
USE BelcorpPanama
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisesFFVV]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListConfiguracionPaisesFFVV]
GO

CREATE PROC ListConfiguracionPaisesFFVV
(
@CodigoISO varchar(2)
)
AS
BEGIN
	 SELECT
	  ID
	 ,CodPais
	 ,DesarrolloNivelCumplimientoHabilitado
	 ,EdicionFichaConsultoraHabilitado
	 ,MinimoNumeroDigitosTelefonoTrabajoConsultora
	 ,MaximoNumeroDigitosTelefonoTrabajoConsultora
	 ,DiasCobranza
	 ,FlagDigitoVerificador
	 ,FlagGeo
	 ,FlagHanna
	 ,FlagPC
	 ,FlagRDD
	 ,FlagGanaMas
	 ,FlagPDV
	 ,FlagConfZonasUnete
	 from FFVV.ConfiguracionPaisesFFVV
	WHERE CodPais = @CodigoISO
	and  FlagConfZonasUnete = 1
END

GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisesFFVV]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListConfiguracionPaisesFFVV]
GO

CREATE PROC ListConfiguracionPaisesFFVV
(
@CodigoISO varchar(2)
)
AS
BEGIN
	 SELECT
	  ID
	 ,CodPais
	 ,DesarrolloNivelCumplimientoHabilitado
	 ,EdicionFichaConsultoraHabilitado
	 ,MinimoNumeroDigitosTelefonoTrabajoConsultora
	 ,MaximoNumeroDigitosTelefonoTrabajoConsultora
	 ,DiasCobranza
	 ,FlagDigitoVerificador
	 ,FlagGeo
	 ,FlagHanna
	 ,FlagPC
	 ,FlagRDD
	 ,FlagGanaMas
	 ,FlagPDV
	 ,FlagConfZonasUnete
	 from FFVV.ConfiguracionPaisesFFVV
	WHERE CodPais = @CodigoISO
	and  FlagConfZonasUnete = 1
END

GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisesFFVV]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListConfiguracionPaisesFFVV]
GO

CREATE PROC ListConfiguracionPaisesFFVV
(
@CodigoISO varchar(2)
)
AS
BEGIN
	 SELECT
	  ID
	 ,CodPais
	 ,DesarrolloNivelCumplimientoHabilitado
	 ,EdicionFichaConsultoraHabilitado
	 ,MinimoNumeroDigitosTelefonoTrabajoConsultora
	 ,MaximoNumeroDigitosTelefonoTrabajoConsultora
	 ,DiasCobranza
	 ,FlagDigitoVerificador
	 ,FlagGeo
	 ,FlagHanna
	 ,FlagPC
	 ,FlagRDD
	 ,FlagGanaMas
	 ,FlagPDV
	 ,FlagConfZonasUnete
	 from FFVV.ConfiguracionPaisesFFVV
	WHERE CodPais = @CodigoISO
	and  FlagConfZonasUnete = 1
END

GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisesFFVV]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListConfiguracionPaisesFFVV]
GO

CREATE PROC ListConfiguracionPaisesFFVV
(
@CodigoISO varchar(2)
)
AS
BEGIN
	 SELECT
	  ID
	 ,CodPais
	 ,DesarrolloNivelCumplimientoHabilitado
	 ,EdicionFichaConsultoraHabilitado
	 ,MinimoNumeroDigitosTelefonoTrabajoConsultora
	 ,MaximoNumeroDigitosTelefonoTrabajoConsultora
	 ,DiasCobranza
	 ,FlagDigitoVerificador
	 ,FlagGeo
	 ,FlagHanna
	 ,FlagPC
	 ,FlagRDD
	 ,FlagGanaMas
	 ,FlagPDV
	 ,FlagConfZonasUnete
	 from FFVV.ConfiguracionPaisesFFVV
	WHERE CodPais = @CodigoISO
	and  FlagConfZonasUnete = 1
END

GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisesFFVV]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListConfiguracionPaisesFFVV]
GO

CREATE PROC ListConfiguracionPaisesFFVV
(
@CodigoISO varchar(2)
)
AS
BEGIN
	 SELECT
	  ID
	 ,CodPais
	 ,DesarrolloNivelCumplimientoHabilitado
	 ,EdicionFichaConsultoraHabilitado
	 ,MinimoNumeroDigitosTelefonoTrabajoConsultora
	 ,MaximoNumeroDigitosTelefonoTrabajoConsultora
	 ,DiasCobranza
	 ,FlagDigitoVerificador
	 ,FlagGeo
	 ,FlagHanna
	 ,FlagPC
	 ,FlagRDD
	 ,FlagGanaMas
	 ,FlagPDV
	 ,FlagConfZonasUnete
	 from FFVV.ConfiguracionPaisesFFVV
	WHERE CodPais = @CodigoISO
	and  FlagConfZonasUnete = 1
END

GO
USE BelcorpChile
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisesFFVV]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListConfiguracionPaisesFFVV]
GO

CREATE PROC ListConfiguracionPaisesFFVV
(
@CodigoISO varchar(2)
)
AS
BEGIN
	 SELECT
	  ID
	 ,CodPais
	 ,DesarrolloNivelCumplimientoHabilitado
	 ,EdicionFichaConsultoraHabilitado
	 ,MinimoNumeroDigitosTelefonoTrabajoConsultora
	 ,MaximoNumeroDigitosTelefonoTrabajoConsultora
	 ,DiasCobranza
	 ,FlagDigitoVerificador
	 ,FlagGeo
	 ,FlagHanna
	 ,FlagPC
	 ,FlagRDD
	 ,FlagGanaMas
	 ,FlagPDV
	 ,FlagConfZonasUnete
	 from FFVV.ConfiguracionPaisesFFVV
	WHERE CodPais = @CodigoISO
	and  FlagConfZonasUnete = 1
END

GO
USE BelcorpBolivia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisesFFVV]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListConfiguracionPaisesFFVV]
GO

CREATE PROC ListConfiguracionPaisesFFVV
(
@CodigoISO varchar(2)
)
AS
BEGIN
	 SELECT
	  ID
	 ,CodPais
	 ,DesarrolloNivelCumplimientoHabilitado
	 ,EdicionFichaConsultoraHabilitado
	 ,MinimoNumeroDigitosTelefonoTrabajoConsultora
	 ,MaximoNumeroDigitosTelefonoTrabajoConsultora
	 ,DiasCobranza
	 ,FlagDigitoVerificador
	 ,FlagGeo
	 ,FlagHanna
	 ,FlagPC
	 ,FlagRDD
	 ,FlagGanaMas
	 ,FlagPDV
	 ,FlagConfZonasUnete
	 from FFVV.ConfiguracionPaisesFFVV
	WHERE CodPais = @CodigoISO
	and  FlagConfZonasUnete = 1
END

GO
