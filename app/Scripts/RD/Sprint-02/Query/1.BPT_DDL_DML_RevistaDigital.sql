USE BelcorpPeru
GO

----------------------------------------------------
-- CREACION DE NUEVAS TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPais]') AND (type = 'U') )
	DROP TABLE ConfiguracionPais
GO

CREATE TABLE ConfiguracionPais
(
	[ConfiguracionPaisID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](100) NOT NULL,
	[Excluyente] [bit] not null,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPaisDetalle]') AND (type = 'U') )
	DROP TABLE ConfiguracionPaisDetalle
GO

CREATE TABLE [dbo].[ConfiguracionPaisDetalle]
(
	[ConfiguracionPaisDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[ConfiguracionPaisID] [int] NOT NULL,
	[CodigoRegion] [varchar](2) NULL,
	[CodigoZona] [varchar](4) NULL,
	[CodigoSeccion] [varchar](8) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[RevistaDigitalSuscripcion]') AND (type = 'U') )
	DROP TABLE RevistaDigitalSuscripcion
GO

CREATE TABLE [dbo].[RevistaDigitalSuscripcion]
(
	[RevistaDigitalSuscripcionID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[CampaniaID] [int] not null,
	[FechaSuscripcion] [datetime] null,
	[FechaDesuscripcion] [datetime] null,
	[EstadoRegistro] [int] null,
	[EstadoEnvio] [int] null,
	[IsoPais] [varchar](2) not null,
	[CodigoZona] [varchar](4) not null,
	[EMail] [varchar](100) not null
)

GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[SuscripcionHistorial]') AND (type = 'U') )
	DROP TABLE SuscripcionHistorial
GO

CREATE TABLE [dbo].[SuscripcionHistorial]
(
	[SuscripcionHistorialID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) not NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[Accion] [varchar](20) not null,
	[Fecha] [datetime] null
)
GO

----------------------------------------------------
-- MODIFICACION DE TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('Permiso') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE Permiso ADD Codigo varchar(100)
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('MenuMobile') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE MenuMobile ADD Codigo varchar(100)
GO

-------------------------------------------------------------
-- INSERCION DE INFORMACION DE TABLAS PARA LA REVISTA DIGITAL
-------------------------------------------------------------

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDS' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDS', 0, 'Revista Digital Suscripción', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDR' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDR', 0, 'Revista Digital Reducida', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RD' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RD', 0, 'Revista Digital Completa', 0)
END
GO

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Desktop
------------------------------------------------------------------------------------------------

if not exists(select 1 from Permiso where Codigo = 'RevistaDigital')
begin

	DECLARE @PermisoID INT = 0
	DECLARE @OrdenItem INT, @factorAumento int = 1

	select @OrdenItem = OrdenItem + @factorAumento from Permiso where Descripcion = 'VENTA EXCLUSIVA WEB'
	set @OrdenItem = isnull(@OrdenItem, 0)

	SET @PermisoID = isnull(@PermisoID, 0) + 1
	SELECT @PermisoID = MAX(PermisoID) FROM Permiso

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,0,0, 1, 'RevistaDigital')

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(1,@PermisoID,1,1)

	update Permiso
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB'

	update Permiso
	set Codigo = 'FDTC'
	where UrlItem = 'CatalogoPersonalizado/Index'
end
go

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Mobile
------------------------------------------------------------------------------------------------

if not exists(select 1 from MenuMobile where Codigo = 'RevistaDigital')
begin

	DECLARE @ID INT = 0
	DECLARE @OrdenItem INT = 0

	SELECT @ID=MAX(MenuMobileID) FROM MenuMobile
	SET @ID = isnull(@ID, 0) + 1

	
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where Posicion = 'Menu'
		and MenuPadreID = 0
		and EsSB2=1
		and OrdenItem >= @OrdenItem

	INSERT INTO MenuMobile
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2, Codigo)
	VALUES(@ID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',0,'Menu','Mobile', 1, 'RevistaDigital')

	update MenuMobile
	set Codigo = 'FDTC'
	where UrlItem = 'Mobile/CatalogoPersonalizado/Index' or UrlItem = 'Mobile/CatalogoPersonalizado'

	
	update MenuMobile
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB' and EsSB2=1


	update MenuMobile
	set Codigo = 'MiNegocio'
	 where Upper(Descripcion) = Upper('Mi Negocio') and EsSB2=1

end
go

----------------------------------------------------------------
-- Actualizacion de tipo de estrategias para el pack de nuevas
----------------------------------------------------------------

IF EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = NULL WHERE Codigo = '002'
END
GO

IF NOT EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = '002' WHERE DescripcionEstrategia LIKE '%Pack de Nuevas%'
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------

IF not EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
begin
	UPDATE PopupPais SET Orden = Orden + 1 WHERE Orden > 4; 
	INSERT INTO PopupPais (CodigoPopup, Descripcion, CodigoISO, Orden, Activo) 
	VALUES (9, 'Suscripcion Revista Digital', (select CodigoISO from Pais where EstadoActivo = 1), 5, 1)
end
GO
/*end*/

USE BelcorpMexico

GO

----------------------------------------------------
-- CREACION DE NUEVAS TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPais]') AND (type = 'U') )
	DROP TABLE ConfiguracionPais
GO

CREATE TABLE ConfiguracionPais
(
	[ConfiguracionPaisID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](100) NOT NULL,
	[Excluyente] [bit] not null,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPaisDetalle]') AND (type = 'U') )
	DROP TABLE ConfiguracionPaisDetalle
GO

CREATE TABLE [dbo].[ConfiguracionPaisDetalle]
(
	[ConfiguracionPaisDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[ConfiguracionPaisID] [int] NOT NULL,
	[CodigoRegion] [varchar](2) NULL,
	[CodigoZona] [varchar](4) NULL,
	[CodigoSeccion] [varchar](8) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[RevistaDigitalSuscripcion]') AND (type = 'U') )
	DROP TABLE RevistaDigitalSuscripcion
GO

CREATE TABLE [dbo].[RevistaDigitalSuscripcion]
(
	[RevistaDigitalSuscripcionID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[CampaniaID] [int] not null,
	[FechaSuscripcion] [datetime] null,
	[FechaDesuscripcion] [datetime] null,
	[EstadoRegistro] [int] null,
	[EstadoEnvio] [int] null,
	[IsoPais] [varchar](2) not null,
	[CodigoZona] [varchar](4) not null,
	[EMail] [varchar](100) not null
)

GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[SuscripcionHistorial]') AND (type = 'U') )
	DROP TABLE SuscripcionHistorial
GO

CREATE TABLE [dbo].[SuscripcionHistorial]
(
	[SuscripcionHistorialID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) not NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[Accion] [varchar](20) not null,
	[Fecha] [datetime] null
)
GO

----------------------------------------------------
-- MODIFICACION DE TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('Permiso') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE Permiso ADD Codigo varchar(100)
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('MenuMobile') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE MenuMobile ADD Codigo varchar(100)
GO

-------------------------------------------------------------
-- INSERCION DE INFORMACION DE TABLAS PARA LA REVISTA DIGITAL
-------------------------------------------------------------

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDS' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDS', 0, 'Revista Digital Suscripción', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDR' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDR', 0, 'Revista Digital Reducida', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RD' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RD', 0, 'Revista Digital Completa', 0)
END
GO

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Desktop
------------------------------------------------------------------------------------------------

if not exists(select 1 from Permiso where Codigo = 'RevistaDigital')
begin

	DECLARE @PermisoID INT = 0
	DECLARE @OrdenItem INT, @factorAumento int = 1

	select @OrdenItem = OrdenItem + @factorAumento from Permiso where Descripcion = 'VENTA EXCLUSIVA WEB'
	set @OrdenItem = isnull(@OrdenItem, 0)

	SELECT @PermisoID = MAX(PermisoID) FROM Permiso
	SET @PermisoID = isnull(@PermisoID, 0) + 1

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,0,0, 1, 'RevistaDigital')

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(1,@PermisoID,1,1)

	update Permiso
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB'

	update Permiso
	set Codigo = 'FDTC'
	where UrlItem = 'CatalogoPersonalizado/Index'
end
go

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Mobile
------------------------------------------------------------------------------------------------

if not exists(select 1 from MenuMobile where Codigo = 'RevistaDigital')
begin

	DECLARE @ID INT = 0
	DECLARE @OrdenItem INT = 0

	SELECT @ID=MAX(MenuMobileID) FROM MenuMobile
	SET @ID = isnull(@ID, 0) + 1

	
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where Posicion = 'Menu'
		and MenuPadreID = 0
		and EsSB2=1
		and OrdenItem >= @OrdenItem

	INSERT INTO MenuMobile
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2, Codigo)
	VALUES(@ID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',0,'Menu','Mobile', 1, 'RevistaDigital')

	update MenuMobile
	set Codigo = 'FDTC'
	where UrlItem = 'Mobile/CatalogoPersonalizado/Index' or UrlItem = 'Mobile/CatalogoPersonalizado'

	
	update MenuMobile
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB' and EsSB2=1


	update MenuMobile
	set Codigo = 'MiNegocio'
	 where Upper(Descripcion) = Upper('Mi Negocio') and EsSB2=1

end
go

----------------------------------------------------------------
-- Actualizacion de tipo de estrategias para el pack de nuevas
----------------------------------------------------------------

IF EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = NULL WHERE Codigo = '002'
END
GO

IF NOT EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = '002' WHERE DescripcionEstrategia LIKE '%Pack de Nuevas%'
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------

IF not EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
begin
	UPDATE PopupPais SET Orden = Orden + 1 WHERE Orden > 4; 
	INSERT INTO PopupPais (CodigoPopup, Descripcion, CodigoISO, Orden, Activo) 
	VALUES (9, 'Suscripcion Revista Digital', (select CodigoISO from Pais where EstadoActivo = 1), 5, 1)
end
GO
/*end*/

USE BelcorpColombia
GO

----------------------------------------------------
-- CREACION DE NUEVAS TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPais]') AND (type = 'U') )
	DROP TABLE ConfiguracionPais
GO

CREATE TABLE ConfiguracionPais
(
	[ConfiguracionPaisID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](100) NOT NULL,
	[Excluyente] [bit] not null,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPaisDetalle]') AND (type = 'U') )
	DROP TABLE ConfiguracionPaisDetalle
GO

CREATE TABLE [dbo].[ConfiguracionPaisDetalle]
(
	[ConfiguracionPaisDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[ConfiguracionPaisID] [int] NOT NULL,
	[CodigoRegion] [varchar](2) NULL,
	[CodigoZona] [varchar](4) NULL,
	[CodigoSeccion] [varchar](8) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[RevistaDigitalSuscripcion]') AND (type = 'U') )
	DROP TABLE RevistaDigitalSuscripcion
GO

CREATE TABLE [dbo].[RevistaDigitalSuscripcion]
(
	[RevistaDigitalSuscripcionID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[CampaniaID] [int] not null,
	[FechaSuscripcion] [datetime] null,
	[FechaDesuscripcion] [datetime] null,
	[EstadoRegistro] [int] null,
	[EstadoEnvio] [int] null,
	[IsoPais] [varchar](2) not null,
	[CodigoZona] [varchar](4) not null,
	[EMail] [varchar](100) not null
)

GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[SuscripcionHistorial]') AND (type = 'U') )
	DROP TABLE SuscripcionHistorial
GO

CREATE TABLE [dbo].[SuscripcionHistorial]
(
	[SuscripcionHistorialID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) not NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[Accion] [varchar](20) not null,
	[Fecha] [datetime] null
)
GO

----------------------------------------------------
-- MODIFICACION DE TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('Permiso') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE Permiso ADD Codigo varchar(100)
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('MenuMobile') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE MenuMobile ADD Codigo varchar(100)
GO

-------------------------------------------------------------
-- INSERCION DE INFORMACION DE TABLAS PARA LA REVISTA DIGITAL
-------------------------------------------------------------

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDS' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDS', 0, 'Revista Digital Suscripción', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDR' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDR', 0, 'Revista Digital Reducida', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RD' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RD', 0, 'Revista Digital Completa', 0)
END
GO

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Desktop
------------------------------------------------------------------------------------------------

if not exists(select 1 from Permiso where Codigo = 'RevistaDigital')
begin

	DECLARE @PermisoID INT = 0
	DECLARE @OrdenItem INT, @factorAumento int = 1

	select @OrdenItem = OrdenItem + @factorAumento from Permiso where Descripcion = 'VENTA EXCLUSIVA WEB'
	set @OrdenItem = isnull(@OrdenItem, 0)

	SELECT @PermisoID = MAX(PermisoID) FROM Permiso
	SET @PermisoID = isnull(@PermisoID, 0) + 1

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,0,0, 1, 'RevistaDigital')

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(1,@PermisoID,1,1)

	update Permiso
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB'

	update Permiso
	set Codigo = 'FDTC'
	where UrlItem = 'CatalogoPersonalizado/Index'
end
go

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Mobile
------------------------------------------------------------------------------------------------

if not exists(select 1 from MenuMobile where Codigo = 'RevistaDigital')
begin

	DECLARE @ID INT = 0
	DECLARE @OrdenItem INT = 0

	SELECT @ID=MAX(MenuMobileID) FROM MenuMobile
	SET @ID = isnull(@ID, 0) + 1

	
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where Posicion = 'Menu'
		and MenuPadreID = 0
		and EsSB2=1
		and OrdenItem >= @OrdenItem

	INSERT INTO MenuMobile
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2, Codigo)
	VALUES(@ID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',0,'Menu','Mobile', 1, 'RevistaDigital')

	update MenuMobile
	set Codigo = 'FDTC'
	where UrlItem = 'Mobile/CatalogoPersonalizado/Index' or UrlItem = 'Mobile/CatalogoPersonalizado'

	
	update MenuMobile
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB' and EsSB2=1


	update MenuMobile
	set Codigo = 'MiNegocio'
	 where Upper(Descripcion) = Upper('Mi Negocio') and EsSB2=1

end
go

----------------------------------------------------------------
-- Actualizacion de tipo de estrategias para el pack de nuevas
----------------------------------------------------------------

IF EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = NULL WHERE Codigo = '002'
END
GO

IF NOT EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = '002' WHERE DescripcionEstrategia LIKE '%Pack de Nuevas%'
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------

IF not EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
begin
	UPDATE PopupPais SET Orden = Orden + 1 WHERE Orden > 4; 
	INSERT INTO PopupPais (CodigoPopup, Descripcion, CodigoISO, Orden, Activo) 
	VALUES (9, 'Suscripcion Revista Digital', (select CodigoISO from Pais where EstadoActivo = 1), 5, 1)
end
GO
/*end*/

USE BelcorpVenezuela
GO

----------------------------------------------------
-- CREACION DE NUEVAS TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPais]') AND (type = 'U') )
	DROP TABLE ConfiguracionPais
GO

CREATE TABLE ConfiguracionPais
(
	[ConfiguracionPaisID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](100) NOT NULL,
	[Excluyente] [bit] not null,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPaisDetalle]') AND (type = 'U') )
	DROP TABLE ConfiguracionPaisDetalle
GO

CREATE TABLE [dbo].[ConfiguracionPaisDetalle]
(
	[ConfiguracionPaisDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[ConfiguracionPaisID] [int] NOT NULL,
	[CodigoRegion] [varchar](2) NULL,
	[CodigoZona] [varchar](4) NULL,
	[CodigoSeccion] [varchar](8) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[RevistaDigitalSuscripcion]') AND (type = 'U') )
	DROP TABLE RevistaDigitalSuscripcion
GO

CREATE TABLE [dbo].[RevistaDigitalSuscripcion]
(
	[RevistaDigitalSuscripcionID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[CampaniaID] [int] not null,
	[FechaSuscripcion] [datetime] null,
	[FechaDesuscripcion] [datetime] null,
	[EstadoRegistro] [int] null,
	[EstadoEnvio] [int] null,
	[IsoPais] [varchar](2) not null,
	[CodigoZona] [varchar](4) not null,
	[EMail] [varchar](100) not null
)

GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[SuscripcionHistorial]') AND (type = 'U') )
	DROP TABLE SuscripcionHistorial
GO

CREATE TABLE [dbo].[SuscripcionHistorial]
(
	[SuscripcionHistorialID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) not NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[Accion] [varchar](20) not null,
	[Fecha] [datetime] null
)
GO

----------------------------------------------------
-- MODIFICACION DE TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('Permiso') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE Permiso ADD Codigo varchar(100)
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('MenuMobile') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE MenuMobile ADD Codigo varchar(100)
GO

-------------------------------------------------------------
-- INSERCION DE INFORMACION DE TABLAS PARA LA REVISTA DIGITAL
-------------------------------------------------------------

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDS' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDS', 0, 'Revista Digital Suscripción', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDR' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDR', 0, 'Revista Digital Reducida', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RD' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RD', 0, 'Revista Digital Completa', 0)
END
GO

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Desktop
------------------------------------------------------------------------------------------------

if not exists(select 1 from Permiso where Codigo = 'RevistaDigital')
begin

	DECLARE @PermisoID INT = 0
	DECLARE @OrdenItem INT, @factorAumento int = 1

	select @OrdenItem = OrdenItem + @factorAumento from Permiso where Descripcion = 'VENTA EXCLUSIVA WEB'
	set @OrdenItem = isnull(@OrdenItem, 0)

	SELECT @PermisoID = MAX(PermisoID) FROM Permiso
	SET @PermisoID = isnull(@PermisoID, 0) + 1

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,0,0, 1, 'RevistaDigital')

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(1,@PermisoID,1,1)

	update Permiso
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB'

	update Permiso
	set Codigo = 'FDTC'
	where UrlItem = 'CatalogoPersonalizado/Index'
end
go

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Mobile
------------------------------------------------------------------------------------------------

if not exists(select 1 from MenuMobile where Codigo = 'RevistaDigital')
begin

	DECLARE @ID INT = 0
	DECLARE @OrdenItem INT = 0

	SELECT @ID=MAX(MenuMobileID) FROM MenuMobile
	SET @ID = isnull(@ID, 0) + 1

	
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where Posicion = 'Menu'
		and MenuPadreID = 0
		and EsSB2=1
		and OrdenItem >= @OrdenItem

	INSERT INTO MenuMobile
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2, Codigo)
	VALUES(@ID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',0,'Menu','Mobile', 1, 'RevistaDigital')

	update MenuMobile
	set Codigo = 'FDTC'
	where UrlItem = 'Mobile/CatalogoPersonalizado/Index' or UrlItem = 'Mobile/CatalogoPersonalizado'

	
	update MenuMobile
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB' and EsSB2=1


	update MenuMobile
	set Codigo = 'MiNegocio'
	 where Upper(Descripcion) = Upper('Mi Negocio') and EsSB2=1

end
go

----------------------------------------------------------------
-- Actualizacion de tipo de estrategias para el pack de nuevas
----------------------------------------------------------------

IF EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = NULL WHERE Codigo = '002'
END
GO

IF NOT EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = '002' WHERE DescripcionEstrategia LIKE '%Pack de Nuevas%'
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------

IF not EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
begin
	UPDATE PopupPais SET Orden = Orden + 1 WHERE Orden > 4; 
	INSERT INTO PopupPais (CodigoPopup, Descripcion, CodigoISO, Orden, Activo) 
	VALUES (9, 'Suscripcion Revista Digital', (select CodigoISO from Pais where EstadoActivo = 1), 5, 1)
end
GO
/*end*/

USE BelcorpSalvador
GO

----------------------------------------------------
-- CREACION DE NUEVAS TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPais]') AND (type = 'U') )
	DROP TABLE ConfiguracionPais
GO

CREATE TABLE ConfiguracionPais
(
	[ConfiguracionPaisID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](100) NOT NULL,
	[Excluyente] [bit] not null,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPaisDetalle]') AND (type = 'U') )
	DROP TABLE ConfiguracionPaisDetalle
GO

CREATE TABLE [dbo].[ConfiguracionPaisDetalle]
(
	[ConfiguracionPaisDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[ConfiguracionPaisID] [int] NOT NULL,
	[CodigoRegion] [varchar](2) NULL,
	[CodigoZona] [varchar](4) NULL,
	[CodigoSeccion] [varchar](8) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[RevistaDigitalSuscripcion]') AND (type = 'U') )
	DROP TABLE RevistaDigitalSuscripcion
GO

CREATE TABLE [dbo].[RevistaDigitalSuscripcion]
(
	[RevistaDigitalSuscripcionID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[CampaniaID] [int] not null,
	[FechaSuscripcion] [datetime] null,
	[FechaDesuscripcion] [datetime] null,
	[EstadoRegistro] [int] null,
	[EstadoEnvio] [int] null,
	[IsoPais] [varchar](2) not null,
	[CodigoZona] [varchar](4) not null,
	[EMail] [varchar](100) not null
)

GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[SuscripcionHistorial]') AND (type = 'U') )
	DROP TABLE SuscripcionHistorial
GO

CREATE TABLE [dbo].[SuscripcionHistorial]
(
	[SuscripcionHistorialID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) not NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[Accion] [varchar](20) not null,
	[Fecha] [datetime] null
)
GO

----------------------------------------------------
-- MODIFICACION DE TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('Permiso') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE Permiso ADD Codigo varchar(100)
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('MenuMobile') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE MenuMobile ADD Codigo varchar(100)
GO

-------------------------------------------------------------
-- INSERCION DE INFORMACION DE TABLAS PARA LA REVISTA DIGITAL
-------------------------------------------------------------

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDS' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDS', 0, 'Revista Digital Suscripción', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDR' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDR', 0, 'Revista Digital Reducida', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RD' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RD', 0, 'Revista Digital Completa', 0)
END
GO

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Desktop
------------------------------------------------------------------------------------------------

if not exists(select 1 from Permiso where Codigo = 'RevistaDigital')
begin

	DECLARE @PermisoID INT = 0
	DECLARE @OrdenItem INT, @factorAumento int = 1

	select @OrdenItem = OrdenItem + @factorAumento from Permiso where Descripcion = 'VENTA EXCLUSIVA WEB'
	set @OrdenItem = isnull(@OrdenItem, 0)

	SELECT @PermisoID = MAX(PermisoID) FROM Permiso
	SET @PermisoID = isnull(@PermisoID, 0) + 1

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,0,0, 1, 'RevistaDigital')

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(1,@PermisoID,1,1)

	update Permiso
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB'

	update Permiso
	set Codigo = 'FDTC'
	where UrlItem = 'CatalogoPersonalizado/Index'
end
go

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Mobile
------------------------------------------------------------------------------------------------

if not exists(select 1 from MenuMobile where Codigo = 'RevistaDigital')
begin

	DECLARE @ID INT = 0
	DECLARE @OrdenItem INT = 0

	SELECT @ID=MAX(MenuMobileID) FROM MenuMobile
	SET @ID = isnull(@ID, 0) + 1

	
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where Posicion = 'Menu'
		and MenuPadreID = 0
		and EsSB2=1
		and OrdenItem >= @OrdenItem

	INSERT INTO MenuMobile
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2, Codigo)
	VALUES(@ID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',0,'Menu','Mobile', 1, 'RevistaDigital')

	update MenuMobile
	set Codigo = 'FDTC'
	where UrlItem = 'Mobile/CatalogoPersonalizado/Index' or UrlItem = 'Mobile/CatalogoPersonalizado'

	
	update MenuMobile
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB' and EsSB2=1


	update MenuMobile
	set Codigo = 'MiNegocio'
	 where Upper(Descripcion) = Upper('Mi Negocio') and EsSB2=1

end
go

----------------------------------------------------------------
-- Actualizacion de tipo de estrategias para el pack de nuevas
----------------------------------------------------------------

IF EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = NULL WHERE Codigo = '002'
END
GO

IF NOT EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = '002' WHERE DescripcionEstrategia LIKE '%Pack de Nuevas%'
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------

IF not EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
begin
	UPDATE PopupPais SET Orden = Orden + 1 WHERE Orden > 4; 
	INSERT INTO PopupPais (CodigoPopup, Descripcion, CodigoISO, Orden, Activo) 
	VALUES (9, 'Suscripcion Revista Digital', (select CodigoISO from Pais where EstadoActivo = 1), 5, 1)
end
GO
/*end*/

USE BelcorpPuertoRico
GO

----------------------------------------------------
-- CREACION DE NUEVAS TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPais]') AND (type = 'U') )
	DROP TABLE ConfiguracionPais
GO

CREATE TABLE ConfiguracionPais
(
	[ConfiguracionPaisID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](100) NOT NULL,
	[Excluyente] [bit] not null,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPaisDetalle]') AND (type = 'U') )
	DROP TABLE ConfiguracionPaisDetalle
GO

CREATE TABLE [dbo].[ConfiguracionPaisDetalle]
(
	[ConfiguracionPaisDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[ConfiguracionPaisID] [int] NOT NULL,
	[CodigoRegion] [varchar](2) NULL,
	[CodigoZona] [varchar](4) NULL,
	[CodigoSeccion] [varchar](8) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[RevistaDigitalSuscripcion]') AND (type = 'U') )
	DROP TABLE RevistaDigitalSuscripcion
GO

CREATE TABLE [dbo].[RevistaDigitalSuscripcion]
(
	[RevistaDigitalSuscripcionID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[CampaniaID] [int] not null,
	[FechaSuscripcion] [datetime] null,
	[FechaDesuscripcion] [datetime] null,
	[EstadoRegistro] [int] null,
	[EstadoEnvio] [int] null,
	[IsoPais] [varchar](2) not null,
	[CodigoZona] [varchar](4) not null,
	[EMail] [varchar](100) not null
)

GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[SuscripcionHistorial]') AND (type = 'U') )
	DROP TABLE SuscripcionHistorial
GO

CREATE TABLE [dbo].[SuscripcionHistorial]
(
	[SuscripcionHistorialID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) not NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[Accion] [varchar](20) not null,
	[Fecha] [datetime] null
)
GO

----------------------------------------------------
-- MODIFICACION DE TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('Permiso') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE Permiso ADD Codigo varchar(100)
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('MenuMobile') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE MenuMobile ADD Codigo varchar(100)
GO

-------------------------------------------------------------
-- INSERCION DE INFORMACION DE TABLAS PARA LA REVISTA DIGITAL
-------------------------------------------------------------

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDS' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDS', 0, 'Revista Digital Suscripción', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDR' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDR', 0, 'Revista Digital Reducida', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RD' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RD', 0, 'Revista Digital Completa', 0)
END
GO

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Desktop
------------------------------------------------------------------------------------------------

if not exists(select 1 from Permiso where Codigo = 'RevistaDigital')
begin

	DECLARE @PermisoID INT = 0
	DECLARE @OrdenItem INT, @factorAumento int = 1

	select @OrdenItem = OrdenItem + @factorAumento from Permiso where Descripcion = 'VENTA EXCLUSIVA WEB'
	set @OrdenItem = isnull(@OrdenItem, 0)

	SELECT @PermisoID = MAX(PermisoID) FROM Permiso
	SET @PermisoID = isnull(@PermisoID, 0) + 1

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,0,0, 1, 'RevistaDigital')

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(1,@PermisoID,1,1)

	update Permiso
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB'

	update Permiso
	set Codigo = 'FDTC'
	where UrlItem = 'CatalogoPersonalizado/Index'
end
go

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Mobile
------------------------------------------------------------------------------------------------

if not exists(select 1 from MenuMobile where Codigo = 'RevistaDigital')
begin

	DECLARE @ID INT = 0
	DECLARE @OrdenItem INT = 0

	SELECT @ID=MAX(MenuMobileID) FROM MenuMobile
	SET @ID = isnull(@ID, 0) + 1

	
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where Posicion = 'Menu'
		and MenuPadreID = 0
		and EsSB2=1
		and OrdenItem >= @OrdenItem

	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2, Codigo)
	VALUES(@ID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',0,'Menu','Mobile', 1, 'RevistaDigital')
	INSERT INTO MenuMobile

	update MenuMobile
	set Codigo = 'FDTC'
	where UrlItem = 'Mobile/CatalogoPersonalizado/Index' or UrlItem = 'Mobile/CatalogoPersonalizado'

	
	update MenuMobile
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB' and EsSB2=1


	update MenuMobile
	set Codigo = 'MiNegocio'
	 where Upper(Descripcion) = Upper('Mi Negocio') and EsSB2=1

end
go

----------------------------------------------------------------
-- Actualizacion de tipo de estrategias para el pack de nuevas
----------------------------------------------------------------

IF EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = NULL WHERE Codigo = '002'
END
GO

IF NOT EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = '002' WHERE DescripcionEstrategia LIKE '%Pack de Nuevas%'
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------

IF not EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
begin
	UPDATE PopupPais SET Orden = Orden + 1 WHERE Orden > 4; 
	INSERT INTO PopupPais (CodigoPopup, Descripcion, CodigoISO, Orden, Activo) 
	VALUES (9, 'Suscripcion Revista Digital', (select CodigoISO from Pais where EstadoActivo = 1), 5, 1)
end
GO
/*end*/

USE BelcorpPanama
GO

----------------------------------------------------
-- CREACION DE NUEVAS TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPais]') AND (type = 'U') )
	DROP TABLE ConfiguracionPais
GO

CREATE TABLE ConfiguracionPais
(
	[ConfiguracionPaisID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](100) NOT NULL,
	[Excluyente] [bit] not null,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPaisDetalle]') AND (type = 'U') )
	DROP TABLE ConfiguracionPaisDetalle
GO

CREATE TABLE [dbo].[ConfiguracionPaisDetalle]
(
	[ConfiguracionPaisDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[ConfiguracionPaisID] [int] NOT NULL,
	[CodigoRegion] [varchar](2) NULL,
	[CodigoZona] [varchar](4) NULL,
	[CodigoSeccion] [varchar](8) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[RevistaDigitalSuscripcion]') AND (type = 'U') )
	DROP TABLE RevistaDigitalSuscripcion
GO

CREATE TABLE [dbo].[RevistaDigitalSuscripcion]
(
	[RevistaDigitalSuscripcionID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[CampaniaID] [int] not null,
	[FechaSuscripcion] [datetime] null,
	[FechaDesuscripcion] [datetime] null,
	[EstadoRegistro] [int] null,
	[EstadoEnvio] [int] null,
	[IsoPais] [varchar](2) not null,
	[CodigoZona] [varchar](4) not null,
	[EMail] [varchar](100) not null
)

GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[SuscripcionHistorial]') AND (type = 'U') )
	DROP TABLE SuscripcionHistorial
GO

CREATE TABLE [dbo].[SuscripcionHistorial]
(
	[SuscripcionHistorialID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) not NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[Accion] [varchar](20) not null,
	[Fecha] [datetime] null
)
GO

----------------------------------------------------
-- MODIFICACION DE TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('Permiso') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE Permiso ADD Codigo varchar(100)
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('MenuMobile') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE MenuMobile ADD Codigo varchar(100)
GO

-------------------------------------------------------------
-- INSERCION DE INFORMACION DE TABLAS PARA LA REVISTA DIGITAL
-------------------------------------------------------------

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDS' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDS', 0, 'Revista Digital Suscripción', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDR' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDR', 0, 'Revista Digital Reducida', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RD' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RD', 0, 'Revista Digital Completa', 0)
END
GO

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Desktop
------------------------------------------------------------------------------------------------

if not exists(select 1 from Permiso where Codigo = 'RevistaDigital')
begin

	DECLARE @PermisoID INT = 0
	DECLARE @OrdenItem INT, @factorAumento int = 1

	select @OrdenItem = OrdenItem + @factorAumento from Permiso where Descripcion = 'VENTA EXCLUSIVA WEB'
	set @OrdenItem = isnull(@OrdenItem, 0)

	SELECT @PermisoID = MAX(PermisoID) FROM Permiso
	SET @PermisoID = isnull(@PermisoID, 0) + 1

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,0,0, 1, 'RevistaDigital')

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(1,@PermisoID,1,1)

	update Permiso
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB'

	update Permiso
	set Codigo = 'FDTC'
	where UrlItem = 'CatalogoPersonalizado/Index'
end
go

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Mobile
------------------------------------------------------------------------------------------------

if not exists(select 1 from MenuMobile where Codigo = 'RevistaDigital')
begin

	DECLARE @ID INT = 0
	DECLARE @OrdenItem INT = 0

	SELECT @ID=MAX(MenuMobileID) FROM MenuMobile
	SET @ID = isnull(@ID, 0) + 1

	
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where Posicion = 'Menu'
		and MenuPadreID = 0
		and EsSB2=1
		and OrdenItem >= @OrdenItem

	INSERT INTO MenuMobile
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2, Codigo)
	VALUES(@ID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',0,'Menu','Mobile', 1, 'RevistaDigital')

	update MenuMobile
	set Codigo = 'FDTC'
	where UrlItem = 'Mobile/CatalogoPersonalizado/Index' or UrlItem = 'Mobile/CatalogoPersonalizado'

	
	update MenuMobile
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB' and EsSB2=1


	update MenuMobile
	set Codigo = 'MiNegocio'
	 where Upper(Descripcion) = Upper('Mi Negocio') and EsSB2=1

end
go

----------------------------------------------------------------
-- Actualizacion de tipo de estrategias para el pack de nuevas
----------------------------------------------------------------

IF EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = NULL WHERE Codigo = '002'
END
GO

IF NOT EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = '002' WHERE DescripcionEstrategia LIKE '%Pack de Nuevas%'
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------

IF not EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
begin
	UPDATE PopupPais SET Orden = Orden + 1 WHERE Orden > 4; 
	INSERT INTO PopupPais (CodigoPopup, Descripcion, CodigoISO, Orden, Activo) 
	VALUES (9, 'Suscripcion Revista Digital', (select CodigoISO from Pais where EstadoActivo = 1), 5, 1)
end
GO
/*end*/

USE BelcorpGuatemala
GO

----------------------------------------------------
-- CREACION DE NUEVAS TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPais]') AND (type = 'U') )
	DROP TABLE ConfiguracionPais
GO

CREATE TABLE ConfiguracionPais
(
	[ConfiguracionPaisID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](100) NOT NULL,
	[Excluyente] [bit] not null,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPaisDetalle]') AND (type = 'U') )
	DROP TABLE ConfiguracionPaisDetalle
GO

CREATE TABLE [dbo].[ConfiguracionPaisDetalle]
(
	[ConfiguracionPaisDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[ConfiguracionPaisID] [int] NOT NULL,
	[CodigoRegion] [varchar](2) NULL,
	[CodigoZona] [varchar](4) NULL,
	[CodigoSeccion] [varchar](8) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[RevistaDigitalSuscripcion]') AND (type = 'U') )
	DROP TABLE RevistaDigitalSuscripcion
GO

CREATE TABLE [dbo].[RevistaDigitalSuscripcion]
(
	[RevistaDigitalSuscripcionID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[CampaniaID] [int] not null,
	[FechaSuscripcion] [datetime] null,
	[FechaDesuscripcion] [datetime] null,
	[EstadoRegistro] [int] null,
	[EstadoEnvio] [int] null,
	[IsoPais] [varchar](2) not null,
	[CodigoZona] [varchar](4) not null,
	[EMail] [varchar](100) not null
)

GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[SuscripcionHistorial]') AND (type = 'U') )
	DROP TABLE SuscripcionHistorial
GO

CREATE TABLE [dbo].[SuscripcionHistorial]
(
	[SuscripcionHistorialID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) not NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[Accion] [varchar](20) not null,
	[Fecha] [datetime] null
)
GO

----------------------------------------------------
-- MODIFICACION DE TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('Permiso') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE Permiso ADD Codigo varchar(100)
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('MenuMobile') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE MenuMobile ADD Codigo varchar(100)
GO

-------------------------------------------------------------
-- INSERCION DE INFORMACION DE TABLAS PARA LA REVISTA DIGITAL
-------------------------------------------------------------

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDS' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDS', 0, 'Revista Digital Suscripción', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDR' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDR', 0, 'Revista Digital Reducida', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RD' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RD', 0, 'Revista Digital Completa', 0)
END
GO

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Desktop
------------------------------------------------------------------------------------------------

if not exists(select 1 from Permiso where Codigo = 'RevistaDigital')
begin

	DECLARE @PermisoID INT = 0
	DECLARE @OrdenItem INT, @factorAumento int = 1

	select @OrdenItem = OrdenItem + @factorAumento from Permiso where Descripcion = 'VENTA EXCLUSIVA WEB'
	set @OrdenItem = isnull(@OrdenItem, 0)

	SELECT @PermisoID = MAX(PermisoID) FROM Permiso
	SET @PermisoID = isnull(@PermisoID, 0) + 1

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,0,0, 1, 'RevistaDigital')

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(1,@PermisoID,1,1)

	update Permiso
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB'

	update Permiso
	set Codigo = 'FDTC'
	where UrlItem = 'CatalogoPersonalizado/Index'
end
go

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Mobile
------------------------------------------------------------------------------------------------

if not exists(select 1 from MenuMobile where Codigo = 'RevistaDigital')
begin

	DECLARE @ID INT = 0
	DECLARE @OrdenItem INT = 0

	SELECT @ID=MAX(MenuMobileID) FROM MenuMobile
	SET @ID = isnull(@ID, 0) + 1

	
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where Posicion = 'Menu'
		and MenuPadreID = 0
		and EsSB2=1
		and OrdenItem >= @OrdenItem

	INSERT INTO MenuMobile
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2, Codigo)
	VALUES(@ID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',0,'Menu','Mobile', 1, 'RevistaDigital')

	update MenuMobile
	set Codigo = 'FDTC'
	where UrlItem = 'Mobile/CatalogoPersonalizado/Index' or UrlItem = 'Mobile/CatalogoPersonalizado'

	
	update MenuMobile
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB' and EsSB2=1


	update MenuMobile
	set Codigo = 'MiNegocio'
	 where Upper(Descripcion) = Upper('Mi Negocio') and EsSB2=1

end
go

----------------------------------------------------------------
-- Actualizacion de tipo de estrategias para el pack de nuevas
----------------------------------------------------------------

IF EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = NULL WHERE Codigo = '002'
END
GO

IF NOT EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = '002' WHERE DescripcionEstrategia LIKE '%Pack de Nuevas%'
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------

IF not EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
begin
	UPDATE PopupPais SET Orden = Orden + 1 WHERE Orden > 4; 
	INSERT INTO PopupPais (CodigoPopup, Descripcion, CodigoISO, Orden, Activo) 
	VALUES (9, 'Suscripcion Revista Digital', (select CodigoISO from Pais where EstadoActivo = 1), 5, 1)
end
GO
/*end*/

USE BelcorpEcuador
GO

----------------------------------------------------
-- CREACION DE NUEVAS TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPais]') AND (type = 'U') )
	DROP TABLE ConfiguracionPais
GO

CREATE TABLE ConfiguracionPais
(
	[ConfiguracionPaisID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](100) NOT NULL,
	[Excluyente] [bit] not null,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPaisDetalle]') AND (type = 'U') )
	DROP TABLE ConfiguracionPaisDetalle
GO

CREATE TABLE [dbo].[ConfiguracionPaisDetalle]
(
	[ConfiguracionPaisDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[ConfiguracionPaisID] [int] NOT NULL,
	[CodigoRegion] [varchar](2) NULL,
	[CodigoZona] [varchar](4) NULL,
	[CodigoSeccion] [varchar](8) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[RevistaDigitalSuscripcion]') AND (type = 'U') )
	DROP TABLE RevistaDigitalSuscripcion
GO

CREATE TABLE [dbo].[RevistaDigitalSuscripcion]
(
	[RevistaDigitalSuscripcionID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[CampaniaID] [int] not null,
	[FechaSuscripcion] [datetime] null,
	[FechaDesuscripcion] [datetime] null,
	[EstadoRegistro] [int] null,
	[EstadoEnvio] [int] null,
	[IsoPais] [varchar](2) not null,
	[CodigoZona] [varchar](4) not null,
	[EMail] [varchar](100) not null
)

GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[SuscripcionHistorial]') AND (type = 'U') )
	DROP TABLE SuscripcionHistorial
GO

CREATE TABLE [dbo].[SuscripcionHistorial]
(
	[SuscripcionHistorialID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) not NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[Accion] [varchar](20) not null,
	[Fecha] [datetime] null
)
GO

----------------------------------------------------
-- MODIFICACION DE TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('Permiso') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE Permiso ADD Codigo varchar(100)
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('MenuMobile') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE MenuMobile ADD Codigo varchar(100)
GO

-------------------------------------------------------------
-- INSERCION DE INFORMACION DE TABLAS PARA LA REVISTA DIGITAL
-------------------------------------------------------------

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDS' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDS', 0, 'Revista Digital Suscripción', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDR' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDR', 0, 'Revista Digital Reducida', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RD' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RD', 0, 'Revista Digital Completa', 0)
END
GO

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Desktop
------------------------------------------------------------------------------------------------

if not exists(select 1 from Permiso where Codigo = 'RevistaDigital')
begin

	DECLARE @PermisoID INT = 0
	DECLARE @OrdenItem INT, @factorAumento int = 1

	select @OrdenItem = OrdenItem + @factorAumento from Permiso where Descripcion = 'VENTA EXCLUSIVA WEB'
	set @OrdenItem = isnull(@OrdenItem, 0)

	SELECT @PermisoID = MAX(PermisoID) FROM Permiso
	SET @PermisoID = isnull(@PermisoID, 0) + 1

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,0,0, 1, 'RevistaDigital')

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(1,@PermisoID,1,1)

	update Permiso
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB'

	update Permiso
	set Codigo = 'FDTC'
	where UrlItem = 'CatalogoPersonalizado/Index'
end
go

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Mobile
------------------------------------------------------------------------------------------------

if not exists(select 1 from MenuMobile where Codigo = 'RevistaDigital')
begin

	DECLARE @ID INT = 0
	DECLARE @OrdenItem INT = 0

	SELECT @ID=MAX(MenuMobileID) FROM MenuMobile
	SET @ID = isnull(@ID, 0) + 1

	
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where Posicion = 'Menu'
		and MenuPadreID = 0
		and EsSB2=1
		and OrdenItem >= @OrdenItem

	INSERT INTO MenuMobile
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2, Codigo)
	VALUES(@ID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',0,'Menu','Mobile', 1, 'RevistaDigital')

	update MenuMobile
	set Codigo = 'FDTC'
	where UrlItem = 'Mobile/CatalogoPersonalizado/Index' or UrlItem = 'Mobile/CatalogoPersonalizado'

	
	update MenuMobile
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB' and EsSB2=1


	update MenuMobile
	set Codigo = 'MiNegocio'
	 where Upper(Descripcion) = Upper('Mi Negocio') and EsSB2=1

end
go

----------------------------------------------------------------
-- Actualizacion de tipo de estrategias para el pack de nuevas
----------------------------------------------------------------

IF EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = NULL WHERE Codigo = '002'
END
GO

IF NOT EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = '002' WHERE DescripcionEstrategia LIKE '%Pack de Nuevas%'
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------

IF not EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
begin
	UPDATE PopupPais SET Orden = Orden + 1 WHERE Orden > 4; 
	INSERT INTO PopupPais (CodigoPopup, Descripcion, CodigoISO, Orden, Activo) 
	VALUES (9, 'Suscripcion Revista Digital', (select CodigoISO from Pais where EstadoActivo = 1), 5, 1)
end
GO
/*end*/

USE BelcorpDominicana
GO

----------------------------------------------------
-- CREACION DE NUEVAS TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPais]') AND (type = 'U') )
	DROP TABLE ConfiguracionPais
GO

CREATE TABLE ConfiguracionPais
(
	[ConfiguracionPaisID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](100) NOT NULL,
	[Excluyente] [bit] not null,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPaisDetalle]') AND (type = 'U') )
	DROP TABLE ConfiguracionPaisDetalle
GO

CREATE TABLE [dbo].[ConfiguracionPaisDetalle]
(
	[ConfiguracionPaisDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[ConfiguracionPaisID] [int] NOT NULL,
	[CodigoRegion] [varchar](2) NULL,
	[CodigoZona] [varchar](4) NULL,
	[CodigoSeccion] [varchar](8) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[RevistaDigitalSuscripcion]') AND (type = 'U') )
	DROP TABLE RevistaDigitalSuscripcion
GO

CREATE TABLE [dbo].[RevistaDigitalSuscripcion]
(
	[RevistaDigitalSuscripcionID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[CampaniaID] [int] not null,
	[FechaSuscripcion] [datetime] null,
	[FechaDesuscripcion] [datetime] null,
	[EstadoRegistro] [int] null,
	[EstadoEnvio] [int] null,
	[IsoPais] [varchar](2) not null,
	[CodigoZona] [varchar](4) not null,
	[EMail] [varchar](100) not null
)

GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[SuscripcionHistorial]') AND (type = 'U') )
	DROP TABLE SuscripcionHistorial
GO

CREATE TABLE [dbo].[SuscripcionHistorial]
(
	[SuscripcionHistorialID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) not NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[Accion] [varchar](20) not null,
	[Fecha] [datetime] null
)
GO

----------------------------------------------------
-- MODIFICACION DE TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('Permiso') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE Permiso ADD Codigo varchar(100)
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('MenuMobile') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE MenuMobile ADD Codigo varchar(100)
GO

-------------------------------------------------------------
-- INSERCION DE INFORMACION DE TABLAS PARA LA REVISTA DIGITAL
-------------------------------------------------------------

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDS' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDS', 0, 'Revista Digital Suscripción', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDR' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDR', 0, 'Revista Digital Reducida', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RD' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RD', 0, 'Revista Digital Completa', 0)
END
GO

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Desktop
------------------------------------------------------------------------------------------------

if not exists(select 1 from Permiso where Codigo = 'RevistaDigital')
begin

	DECLARE @PermisoID INT = 0
	DECLARE @OrdenItem INT, @factorAumento int = 1

	select @OrdenItem = OrdenItem + @factorAumento from Permiso where Descripcion = 'VENTA EXCLUSIVA WEB'
	set @OrdenItem = isnull(@OrdenItem, 0)

	SELECT @PermisoID = MAX(PermisoID) FROM Permiso
	SET @PermisoID = isnull(@PermisoID, 0) + 1

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,0,0, 1, 'RevistaDigital')

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(1,@PermisoID,1,1)

	update Permiso
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB'

	update Permiso
	set Codigo = 'FDTC'
	where UrlItem = 'CatalogoPersonalizado/Index'
end
go

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Mobile
------------------------------------------------------------------------------------------------

if not exists(select 1 from MenuMobile where Codigo = 'RevistaDigital')
begin

	DECLARE @ID INT = 0
	DECLARE @OrdenItem INT = 0

	SELECT @ID=MAX(MenuMobileID) FROM MenuMobile
	SET @ID = isnull(@ID, 0) + 1

	
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where Posicion = 'Menu'
		and MenuPadreID = 0
		and EsSB2=1
		and OrdenItem >= @OrdenItem

	INSERT INTO MenuMobile
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2, Codigo)
	VALUES(@ID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',0,'Menu','Mobile', 1, 'RevistaDigital')

	update MenuMobile
	set Codigo = 'FDTC'
	where UrlItem = 'Mobile/CatalogoPersonalizado/Index' or UrlItem = 'Mobile/CatalogoPersonalizado'

	
	update MenuMobile
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB' and EsSB2=1


	update MenuMobile
	set Codigo = 'MiNegocio'
	 where Upper(Descripcion) = Upper('Mi Negocio') and EsSB2=1

end
go

----------------------------------------------------------------
-- Actualizacion de tipo de estrategias para el pack de nuevas
----------------------------------------------------------------

IF EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = NULL WHERE Codigo = '002'
END
GO

IF NOT EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = '002' WHERE DescripcionEstrategia LIKE '%Pack de Nuevas%'
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------

IF not EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
begin
	UPDATE PopupPais SET Orden = Orden + 1 WHERE Orden > 4; 
	INSERT INTO PopupPais (CodigoPopup, Descripcion, CodigoISO, Orden, Activo) 
	VALUES (9, 'Suscripcion Revista Digital', (select CodigoISO from Pais where EstadoActivo = 1), 5, 1)
end
GO
/*end*/

USE BelcorpCostaRica
GO

----------------------------------------------------
-- CREACION DE NUEVAS TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPais]') AND (type = 'U') )
	DROP TABLE ConfiguracionPais
GO

CREATE TABLE ConfiguracionPais
(
	[ConfiguracionPaisID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](100) NOT NULL,
	[Excluyente] [bit] not null,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPaisDetalle]') AND (type = 'U') )
	DROP TABLE ConfiguracionPaisDetalle
GO

CREATE TABLE [dbo].[ConfiguracionPaisDetalle]
(
	[ConfiguracionPaisDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[ConfiguracionPaisID] [int] NOT NULL,
	[CodigoRegion] [varchar](2) NULL,
	[CodigoZona] [varchar](4) NULL,
	[CodigoSeccion] [varchar](8) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[RevistaDigitalSuscripcion]') AND (type = 'U') )
	DROP TABLE RevistaDigitalSuscripcion
GO

CREATE TABLE [dbo].[RevistaDigitalSuscripcion]
(
	[RevistaDigitalSuscripcionID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[CampaniaID] [int] not null,
	[FechaSuscripcion] [datetime] null,
	[FechaDesuscripcion] [datetime] null,
	[EstadoRegistro] [int] null,
	[EstadoEnvio] [int] null,
	[IsoPais] [varchar](2) not null,
	[CodigoZona] [varchar](4) not null,
	[EMail] [varchar](100) not null
)

GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[SuscripcionHistorial]') AND (type = 'U') )
	DROP TABLE SuscripcionHistorial
GO

CREATE TABLE [dbo].[SuscripcionHistorial]
(
	[SuscripcionHistorialID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) not NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[Accion] [varchar](20) not null,
	[Fecha] [datetime] null
)
GO

----------------------------------------------------
-- MODIFICACION DE TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('Permiso') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE Permiso ADD Codigo varchar(100)
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('MenuMobile') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE MenuMobile ADD Codigo varchar(100)
GO

-------------------------------------------------------------
-- INSERCION DE INFORMACION DE TABLAS PARA LA REVISTA DIGITAL
-------------------------------------------------------------

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDS' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDS', 0, 'Revista Digital Suscripción', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDR' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDR', 0, 'Revista Digital Reducida', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RD' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RD', 0, 'Revista Digital Completa', 0)
END
GO

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Desktop
------------------------------------------------------------------------------------------------

if not exists(select 1 from Permiso where Codigo = 'RevistaDigital')
begin

	DECLARE @PermisoID INT = 0
	DECLARE @OrdenItem INT, @factorAumento int = 1

	select @OrdenItem = OrdenItem + @factorAumento from Permiso where Descripcion = 'VENTA EXCLUSIVA WEB'
	set @OrdenItem = isnull(@OrdenItem, 0)

	SELECT @PermisoID = MAX(PermisoID) FROM Permiso
	SET @PermisoID = isnull(@PermisoID, 0) + 1

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,0,0, 1, 'RevistaDigital')

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(1,@PermisoID,1,1)

	update Permiso
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB'

	update Permiso
	set Codigo = 'FDTC'
	where UrlItem = 'CatalogoPersonalizado/Index'
end
go

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Mobile
------------------------------------------------------------------------------------------------

if not exists(select 1 from MenuMobile where Codigo = 'RevistaDigital')
begin

	DECLARE @ID INT = 0
	DECLARE @OrdenItem INT = 0

	SELECT @ID=MAX(MenuMobileID) FROM MenuMobile
	SET @ID = isnull(@ID, 0) + 1

	
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where Posicion = 'Menu'
		and MenuPadreID = 0
		and EsSB2=1
		and OrdenItem >= @OrdenItem

	INSERT INTO MenuMobile
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2, Codigo)
	VALUES(@ID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',0,'Menu','Mobile', 1, 'RevistaDigital')

	update MenuMobile
	set Codigo = 'FDTC'
	where UrlItem = 'Mobile/CatalogoPersonalizado/Index' or UrlItem = 'Mobile/CatalogoPersonalizado'

	
	update MenuMobile
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB' and EsSB2=1


	update MenuMobile
	set Codigo = 'MiNegocio'
	 where Upper(Descripcion) = Upper('Mi Negocio') and EsSB2=1

end
go

----------------------------------------------------------------
-- Actualizacion de tipo de estrategias para el pack de nuevas
----------------------------------------------------------------

IF EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = NULL WHERE Codigo = '002'
END
GO

IF NOT EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = '002' WHERE DescripcionEstrategia LIKE '%Pack de Nuevas%'
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------

IF not EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
begin
	UPDATE PopupPais SET Orden = Orden + 1 WHERE Orden > 4; 
	INSERT INTO PopupPais (CodigoPopup, Descripcion, CodigoISO, Orden, Activo) 
	VALUES (9, 'Suscripcion Revista Digital', (select CodigoISO from Pais where EstadoActivo = 1), 5, 1)
end
GO
/*end*/

USE BelcorpChile
GO

----------------------------------------------------
-- CREACION DE NUEVAS TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPais]') AND (type = 'U') )
	DROP TABLE ConfiguracionPais
GO

CREATE TABLE ConfiguracionPais
(
	[ConfiguracionPaisID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](100) NOT NULL,
	[Excluyente] [bit] not null,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPaisDetalle]') AND (type = 'U') )
	DROP TABLE ConfiguracionPaisDetalle
GO

CREATE TABLE [dbo].[ConfiguracionPaisDetalle]
(
	[ConfiguracionPaisDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[ConfiguracionPaisID] [int] NOT NULL,
	[CodigoRegion] [varchar](2) NULL,
	[CodigoZona] [varchar](4) NULL,
	[CodigoSeccion] [varchar](8) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[RevistaDigitalSuscripcion]') AND (type = 'U') )
	DROP TABLE RevistaDigitalSuscripcion
GO

CREATE TABLE [dbo].[RevistaDigitalSuscripcion]
(
	[RevistaDigitalSuscripcionID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[CampaniaID] [int] not null,
	[FechaSuscripcion] [datetime] null,
	[FechaDesuscripcion] [datetime] null,
	[EstadoRegistro] [int] null,
	[EstadoEnvio] [int] null,
	[IsoPais] [varchar](2) not null,
	[CodigoZona] [varchar](4) not null,
	[EMail] [varchar](100) not null
)

GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[SuscripcionHistorial]') AND (type = 'U') )
	DROP TABLE SuscripcionHistorial
GO

CREATE TABLE [dbo].[SuscripcionHistorial]
(
	[SuscripcionHistorialID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) not NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[Accion] [varchar](20) not null,
	[Fecha] [datetime] null
)
GO

----------------------------------------------------
-- MODIFICACION DE TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('Permiso') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE Permiso ADD Codigo varchar(100)
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('MenuMobile') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE MenuMobile ADD Codigo varchar(100)
GO

-------------------------------------------------------------
-- INSERCION DE INFORMACION DE TABLAS PARA LA REVISTA DIGITAL
-------------------------------------------------------------

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDS' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDS', 0, 'Revista Digital Suscripción', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDR' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDR', 0, 'Revista Digital Reducida', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RD' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RD', 0, 'Revista Digital Completa', 0)
END
GO

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Desktop
------------------------------------------------------------------------------------------------

if not exists(select 1 from Permiso where Codigo = 'RevistaDigital')
begin

	DECLARE @PermisoID INT = 0
	DECLARE @OrdenItem INT, @factorAumento int = 1

	select @OrdenItem = OrdenItem + @factorAumento from Permiso where Descripcion = 'VENTA EXCLUSIVA WEB'
	set @OrdenItem = isnull(@OrdenItem, 0)

	SELECT @PermisoID = MAX(PermisoID) FROM Permiso
	SET @PermisoID = isnull(@PermisoID, 0) + 1

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,0,0, 1, 'RevistaDigital')

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(1,@PermisoID,1,1)

	update Permiso
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB'

	update Permiso
	set Codigo = 'FDTC'
	where UrlItem = 'CatalogoPersonalizado/Index'
end
go

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Mobile
------------------------------------------------------------------------------------------------

if not exists(select 1 from MenuMobile where Codigo = 'RevistaDigital')
begin

	DECLARE @ID INT = 0
	DECLARE @OrdenItem INT = 0

	SELECT @ID=MAX(MenuMobileID) FROM MenuMobile
	SET @ID = isnull(@ID, 0) + 1

	
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where Posicion = 'Menu'
		and MenuPadreID = 0
		and EsSB2=1
		and OrdenItem >= @OrdenItem

	INSERT INTO MenuMobile
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2, Codigo)
	VALUES(@ID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',0,'Menu','Mobile', 1, 'RevistaDigital')

	update MenuMobile
	set Codigo = 'FDTC'
	where UrlItem = 'Mobile/CatalogoPersonalizado/Index' or UrlItem = 'Mobile/CatalogoPersonalizado'

	
	update MenuMobile
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB' and EsSB2=1


	update MenuMobile
	set Codigo = 'MiNegocio'
	 where Upper(Descripcion) = Upper('Mi Negocio') and EsSB2=1

end
go

----------------------------------------------------------------
-- Actualizacion de tipo de estrategias para el pack de nuevas
----------------------------------------------------------------

IF EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = NULL WHERE Codigo = '002'
END
GO

IF NOT EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = '002' WHERE DescripcionEstrategia LIKE '%Pack de Nuevas%'
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------

IF not EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
begin
	UPDATE PopupPais SET Orden = Orden + 1 WHERE Orden > 4; 
	INSERT INTO PopupPais (CodigoPopup, Descripcion, CodigoISO, Orden, Activo) 
	VALUES (9, 'Suscripcion Revista Digital', (select CodigoISO from Pais where EstadoActivo = 1), 5, 1)
end
GO
/*end*/

USE BelcorpBolivia
GO

----------------------------------------------------
-- CREACION DE NUEVAS TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPais]') AND (type = 'U') )
	DROP TABLE ConfiguracionPais
GO

CREATE TABLE ConfiguracionPais
(
	[ConfiguracionPaisID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](100) NOT NULL,
	[Excluyente] [bit] not null,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPaisDetalle]') AND (type = 'U') )
	DROP TABLE ConfiguracionPaisDetalle
GO

CREATE TABLE [dbo].[ConfiguracionPaisDetalle]
(
	[ConfiguracionPaisDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[ConfiguracionPaisID] [int] NOT NULL,
	[CodigoRegion] [varchar](2) NULL,
	[CodigoZona] [varchar](4) NULL,
	[CodigoSeccion] [varchar](8) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[Estado] [bit] NOT NULL
)

GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[RevistaDigitalSuscripcion]') AND (type = 'U') )
	DROP TABLE RevistaDigitalSuscripcion
GO

CREATE TABLE [dbo].[RevistaDigitalSuscripcion]
(
	[RevistaDigitalSuscripcionID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[CampaniaID] [int] not null,
	[FechaSuscripcion] [datetime] null,
	[FechaDesuscripcion] [datetime] null,
	[EstadoRegistro] [int] null,
	[EstadoEnvio] [int] null,
	[IsoPais] [varchar](2) not null,
	[CodigoZona] [varchar](4) not null,
	[EMail] [varchar](100) not null
)

GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[SuscripcionHistorial]') AND (type = 'U') )
	DROP TABLE SuscripcionHistorial
GO

CREATE TABLE [dbo].[SuscripcionHistorial]
(
	[SuscripcionHistorialID] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) not NULL,
	[CodigoConsultora] [varchar](20) not NULL,
	[Accion] [varchar](20) not null,
	[Fecha] [datetime] null
)
GO

----------------------------------------------------
-- MODIFICACION DE TABLAS PARA LA REVISTA DIGITAL
----------------------------------------------------

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('Permiso') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE Permiso ADD Codigo varchar(100)
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('MenuMobile') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE MenuMobile ADD Codigo varchar(100)
GO

-------------------------------------------------------------
-- INSERCION DE INFORMACION DE TABLAS PARA LA REVISTA DIGITAL
-------------------------------------------------------------

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDS' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDS', 0, 'Revista Digital Suscripción', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RDR' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RDR', 0, 'Revista Digital Reducida', 0)
END
GO

IF  not EXISTS ( SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'RD' )
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	VALUES('RD', 0, 'Revista Digital Completa', 0)
END
GO

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Desktop
------------------------------------------------------------------------------------------------

if not exists(select 1 from Permiso where Codigo = 'RevistaDigital')
begin

	DECLARE @PermisoID INT = 0
	DECLARE @OrdenItem INT, @factorAumento int = 1

	select @OrdenItem = OrdenItem + @factorAumento from Permiso where Descripcion = 'VENTA EXCLUSIVA WEB'
	set @OrdenItem = isnull(@OrdenItem, 0)

	SELECT @PermisoID = MAX(PermisoID) FROM Permiso
	SET @PermisoID = isnull(@PermisoID, 0) + 1

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,0,0, 1, 'RevistaDigital')

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(1,@PermisoID,1,1)

	update Permiso
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB'

	update Permiso
	set Codigo = 'FDTC'
	where UrlItem = 'CatalogoPersonalizado/Index'
end
go

------------------------------------------------------------------------------------------------
-- Menu Revista Digital Mobile
------------------------------------------------------------------------------------------------

if not exists(select 1 from MenuMobile where Codigo = 'RevistaDigital')
begin

	DECLARE @ID INT = 0
	DECLARE @OrdenItem INT = 0

	SELECT @ID=MAX(MenuMobileID) FROM MenuMobile
	SET @ID = isnull(@ID, 0) + 1

	
	update MenuMobile
	set OrdenItem = OrdenItem + 1
	where Posicion = 'Menu'
		and MenuPadreID = 0
		and EsSB2=1
		and OrdenItem >= @OrdenItem

	INSERT INTO MenuMobile
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2, Codigo)
	VALUES(@ID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',0,'Menu','Mobile', 1, 'RevistaDigital')

	update MenuMobile
	set Codigo = 'FDTC'
	where UrlItem = 'Mobile/CatalogoPersonalizado/Index' or UrlItem = 'Mobile/CatalogoPersonalizado'

	
	update MenuMobile
	set Codigo = 'ShowRoom'
	where Descripcion = 'VENTA EXCLUSIVA WEB' and EsSB2=1


	update MenuMobile
	set Codigo = 'MiNegocio'
	 where Upper(Descripcion) = Upper('Mi Negocio') and EsSB2=1

end
go

----------------------------------------------------------------
-- Actualizacion de tipo de estrategias para el pack de nuevas
----------------------------------------------------------------

IF EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = NULL WHERE Codigo = '002'
END
GO

IF NOT EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	UPDATE TipoEstrategia SET Codigo = '002' WHERE DescripcionEstrategia LIKE '%Pack de Nuevas%'
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------

IF not EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
begin
	UPDATE PopupPais SET Orden = Orden + 1 WHERE Orden > 4; 
	INSERT INTO PopupPais (CodigoPopup, Descripcion, CodigoISO, Orden, Activo) 
	VALUES (9, 'Suscripcion Revista Digital', (select CodigoISO from Pais where EstadoActivo = 1), 5, 1)
end
GO
