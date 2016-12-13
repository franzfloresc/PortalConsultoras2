
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'InsLogConfiguracionCronograma'))
BEGIN
	DROP PROCEDURE InsLogConfiguracionCronograma
END

CREATE PROCEDURE InsLogConfiguracionCronograma
(
  @CodigoUsuario VARCHAR(30), 
  @ListaEntidadXml XML
)
AS
INSERT INTO LogConfiguracionCronograma
(
	FechaRegistro,
	CodigoUsuario,
	CodigoRegion,
	CodigoZona,
	DiasDuracionAnterior,
	DiasDuracionActual

)
SELECT
	GETDATE(),
	@CodigoUsuario,
	p.value('@CodigoRegion','INT'), 
	p.value('@CodigoZona','INT'),
	p.value('@DiasDuracionAnterior','INT'),
	p.value('@DiasDuracionActual','INT')
FROM @ListaEntidadXml.nodes('/ROOT/LogConfiguracionCronograma')n(p);

GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'InsLogConfiguracionCronograma'))
BEGIN
	DROP PROCEDURE InsLogConfiguracionCronograma
END

CREATE PROCEDURE InsLogConfiguracionCronograma
(
  @CodigoUsuario VARCHAR(30), 
  @ListaEntidadXml XML
)
AS
INSERT INTO LogConfiguracionCronograma
(
	FechaRegistro,
	CodigoUsuario,
	CodigoRegion,
	CodigoZona,
	DiasDuracionAnterior,
	DiasDuracionActual

)
SELECT
	GETDATE(),
	@CodigoUsuario,
	p.value('@CodigoRegion','INT'), 
	p.value('@CodigoZona','INT'),
	p.value('@DiasDuracionAnterior','INT'),
	p.value('@DiasDuracionActual','INT')
FROM @ListaEntidadXml.nodes('/ROOT/LogConfiguracionCronograma')n(p);

GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'InsLogConfiguracionCronograma'))
BEGIN
	DROP PROCEDURE InsLogConfiguracionCronograma
END

CREATE PROCEDURE InsLogConfiguracionCronograma
(
  @CodigoUsuario VARCHAR(30), 
  @ListaEntidadXml XML
)
AS
INSERT INTO LogConfiguracionCronograma
(
	FechaRegistro,
	CodigoUsuario,
	CodigoRegion,
	CodigoZona,
	DiasDuracionAnterior,
	DiasDuracionActual

)
SELECT
	GETDATE(),
	@CodigoUsuario,
	p.value('@CodigoRegion','INT'), 
	p.value('@CodigoZona','INT'),
	p.value('@DiasDuracionAnterior','INT'),
	p.value('@DiasDuracionActual','INT')
FROM @ListaEntidadXml.nodes('/ROOT/LogConfiguracionCronograma')n(p);

GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'InsLogConfiguracionCronograma'))
BEGIN
	DROP PROCEDURE InsLogConfiguracionCronograma
END

CREATE PROCEDURE InsLogConfiguracionCronograma
(
  @CodigoUsuario VARCHAR(30), 
  @ListaEntidadXml XML
)
AS
INSERT INTO LogConfiguracionCronograma
(
	FechaRegistro,
	CodigoUsuario,
	CodigoRegion,
	CodigoZona,
	DiasDuracionAnterior,
	DiasDuracionActual

)
SELECT
	GETDATE(),
	@CodigoUsuario,
	p.value('@CodigoRegion','INT'), 
	p.value('@CodigoZona','INT'),
	p.value('@DiasDuracionAnterior','INT'),
	p.value('@DiasDuracionActual','INT')
FROM @ListaEntidadXml.nodes('/ROOT/LogConfiguracionCronograma')n(p);

GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'InsLogConfiguracionCronograma'))
BEGIN
	DROP PROCEDURE InsLogConfiguracionCronograma
END

CREATE PROCEDURE InsLogConfiguracionCronograma
(
  @CodigoUsuario VARCHAR(30), 
  @ListaEntidadXml XML
)
AS
INSERT INTO LogConfiguracionCronograma
(
	FechaRegistro,
	CodigoUsuario,
	CodigoRegion,
	CodigoZona,
	DiasDuracionAnterior,
	DiasDuracionActual

)
SELECT
	GETDATE(),
	@CodigoUsuario,
	p.value('@CodigoRegion','INT'), 
	p.value('@CodigoZona','INT'),
	p.value('@DiasDuracionAnterior','INT'),
	p.value('@DiasDuracionActual','INT')
FROM @ListaEntidadXml.nodes('/ROOT/LogConfiguracionCronograma')n(p);

GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'InsLogConfiguracionCronograma'))
BEGIN
	DROP PROCEDURE InsLogConfiguracionCronograma
END

CREATE PROCEDURE InsLogConfiguracionCronograma
(
  @CodigoUsuario VARCHAR(30), 
  @ListaEntidadXml XML
)
AS
INSERT INTO LogConfiguracionCronograma
(
	FechaRegistro,
	CodigoUsuario,
	CodigoRegion,
	CodigoZona,
	DiasDuracionAnterior,
	DiasDuracionActual

)
SELECT
	GETDATE(),
	@CodigoUsuario,
	p.value('@CodigoRegion','INT'), 
	p.value('@CodigoZona','INT'),
	p.value('@DiasDuracionAnterior','INT'),
	p.value('@DiasDuracionActual','INT')
FROM @ListaEntidadXml.nodes('/ROOT/LogConfiguracionCronograma')n(p);

GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'InsLogConfiguracionCronograma'))
BEGIN
	DROP PROCEDURE InsLogConfiguracionCronograma
END

CREATE PROCEDURE InsLogConfiguracionCronograma
(
  @CodigoUsuario VARCHAR(30), 
  @ListaEntidadXml XML
)
AS
INSERT INTO LogConfiguracionCronograma
(
	FechaRegistro,
	CodigoUsuario,
	CodigoRegion,
	CodigoZona,
	DiasDuracionAnterior,
	DiasDuracionActual

)
SELECT
	GETDATE(),
	@CodigoUsuario,
	p.value('@CodigoRegion','INT'), 
	p.value('@CodigoZona','INT'),
	p.value('@DiasDuracionAnterior','INT'),
	p.value('@DiasDuracionActual','INT')
FROM @ListaEntidadXml.nodes('/ROOT/LogConfiguracionCronograma')n(p);

GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'InsLogConfiguracionCronograma'))
BEGIN
	DROP PROCEDURE InsLogConfiguracionCronograma
END

CREATE PROCEDURE InsLogConfiguracionCronograma
(
  @CodigoUsuario VARCHAR(30), 
  @ListaEntidadXml XML
)
AS
INSERT INTO LogConfiguracionCronograma
(
	FechaRegistro,
	CodigoUsuario,
	CodigoRegion,
	CodigoZona,
	DiasDuracionAnterior,
	DiasDuracionActual

)
SELECT
	GETDATE(),
	@CodigoUsuario,
	p.value('@CodigoRegion','INT'), 
	p.value('@CodigoZona','INT'),
	p.value('@DiasDuracionAnterior','INT'),
	p.value('@DiasDuracionActual','INT')
FROM @ListaEntidadXml.nodes('/ROOT/LogConfiguracionCronograma')n(p);

GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'InsLogConfiguracionCronograma'))
BEGIN
	DROP PROCEDURE InsLogConfiguracionCronograma
END

CREATE PROCEDURE InsLogConfiguracionCronograma
(
  @CodigoUsuario VARCHAR(30), 
  @ListaEntidadXml XML
)
AS
INSERT INTO LogConfiguracionCronograma
(
	FechaRegistro,
	CodigoUsuario,
	CodigoRegion,
	CodigoZona,
	DiasDuracionAnterior,
	DiasDuracionActual

)
SELECT
	GETDATE(),
	@CodigoUsuario,
	p.value('@CodigoRegion','INT'), 
	p.value('@CodigoZona','INT'),
	p.value('@DiasDuracionAnterior','INT'),
	p.value('@DiasDuracionActual','INT')
FROM @ListaEntidadXml.nodes('/ROOT/LogConfiguracionCronograma')n(p);

GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'InsLogConfiguracionCronograma'))
BEGIN
	DROP PROCEDURE InsLogConfiguracionCronograma
END

CREATE PROCEDURE InsLogConfiguracionCronograma
(
  @CodigoUsuario VARCHAR(30), 
  @ListaEntidadXml XML
)
AS
INSERT INTO LogConfiguracionCronograma
(
	FechaRegistro,
	CodigoUsuario,
	CodigoRegion,
	CodigoZona,
	DiasDuracionAnterior,
	DiasDuracionActual

)
SELECT
	GETDATE(),
	@CodigoUsuario,
	p.value('@CodigoRegion','INT'), 
	p.value('@CodigoZona','INT'),
	p.value('@DiasDuracionAnterior','INT'),
	p.value('@DiasDuracionActual','INT')
FROM @ListaEntidadXml.nodes('/ROOT/LogConfiguracionCronograma')n(p);

GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'InsLogConfiguracionCronograma'))
BEGIN
	DROP PROCEDURE InsLogConfiguracionCronograma
END

CREATE PROCEDURE InsLogConfiguracionCronograma
(
  @CodigoUsuario VARCHAR(30), 
  @ListaEntidadXml XML
)
AS
INSERT INTO LogConfiguracionCronograma
(
	FechaRegistro,
	CodigoUsuario,
	CodigoRegion,
	CodigoZona,
	DiasDuracionAnterior,
	DiasDuracionActual

)
SELECT
	GETDATE(),
	@CodigoUsuario,
	p.value('@CodigoRegion','INT'), 
	p.value('@CodigoZona','INT'),
	p.value('@DiasDuracionAnterior','INT'),
	p.value('@DiasDuracionActual','INT')
FROM @ListaEntidadXml.nodes('/ROOT/LogConfiguracionCronograma')n(p);

GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'InsLogConfiguracionCronograma'))
BEGIN
	DROP PROCEDURE InsLogConfiguracionCronograma
END

CREATE PROCEDURE InsLogConfiguracionCronograma
(
  @CodigoUsuario VARCHAR(30), 
  @ListaEntidadXml XML
)
AS
INSERT INTO LogConfiguracionCronograma
(
	FechaRegistro,
	CodigoUsuario,
	CodigoRegion,
	CodigoZona,
	DiasDuracionAnterior,
	DiasDuracionActual

)
SELECT
	GETDATE(),
	@CodigoUsuario,
	p.value('@CodigoRegion','INT'), 
	p.value('@CodigoZona','INT'),
	p.value('@DiasDuracionAnterior','INT'),
	p.value('@DiasDuracionActual','INT')
FROM @ListaEntidadXml.nodes('/ROOT/LogConfiguracionCronograma')n(p);

GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'InsLogConfiguracionCronograma'))
BEGIN
	DROP PROCEDURE InsLogConfiguracionCronograma
END

CREATE PROCEDURE InsLogConfiguracionCronograma
(
  @CodigoUsuario VARCHAR(30), 
  @ListaEntidadXml XML
)
AS
INSERT INTO LogConfiguracionCronograma
(
	FechaRegistro,
	CodigoUsuario,
	CodigoRegion,
	CodigoZona,
	DiasDuracionAnterior,
	DiasDuracionActual

)
SELECT
	GETDATE(),
	@CodigoUsuario,
	p.value('@CodigoRegion','INT'), 
	p.value('@CodigoZona','INT'),
	p.value('@DiasDuracionAnterior','INT'),
	p.value('@DiasDuracionActual','INT')
FROM @ListaEntidadXml.nodes('/ROOT/LogConfiguracionCronograma')n(p);

GO

