----------------------------------------------------------------------------------------------------
-- CREACION DE LA TABLA ESTRATEGIA DETALLE PARA ALMACENA LAS IMAGENES ADICIONALES (TODOS LOS PAISES)
----------------------------------------------------------------------------------------------------
USE BelcorpPeru
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

USE BelcorpMexico
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

USE BelcorpColombia
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

USE BelcorpVenezuela
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

USE BelcorpSalvador
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

USE BelcorpPuertoRico
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

USE BelcorpPanama
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

USE BelcorpGuatemala
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

USE BelcorpEcuador
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

USE BelcorpDominicana
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

USE BelcorpCostaRica
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

USE BelcorpChile
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

USE BelcorpBolivia
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

