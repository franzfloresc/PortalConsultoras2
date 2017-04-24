
GO
IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ConfiguracionPais]') AND (type = 'U') )
	DROP TABLE ConfiguracionPais
GO

create table ConfiguracionPais
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
	[FechaSuscripcion] [datetime] not null,
	[FechaDesuscripcion] [datetime] null,
	[EstadoRegistro] [int] null,
	[EstadoEnvio] [int] null,
	[IsoPais] [varchar](2) not null,
	[CodigoZona] [varchar](4) not null,
	[EMail] [varchar](100) not null
)

GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Registro]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
GO

CREATE PROCEDURE RevistaDigitalSuscripcion_Registro
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
	,@FechaSuscripcion datetime = null
	,@FechaDesuscripcion datetime = null
	,@EstadoRegistro int = -1
	,@EstadoEnvio int = 0
	,@IsoPais varchar(2) = ''
	,@CodigoZona varchar(4) = ''
	,@EMail varchar(100) = ''
	,@RetornoID int output
)
AS
BEGIN
	
	-- este store se considera para Suscripcion y Desuscripcion, cambiar para considerar ambos estados

	set @RetornoID = 0
	set @FechaSuscripcion = ISNULL(@FechaSuscripcion, GETDATE())

  	INSERT INTO RevistaDigitalSuscripcion
  	(
		 CodigoConsultora
		,CampaniaID
		,FechaSuscripcion
		,FechaDesuscripcion
		,EstadoRegistro
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	)
  	VALUES(
		 @CodigoConsultora
		,@CampaniaID
		,@FechaSuscripcion
		,@FechaDesuscripcion
		,@EstadoRegistro
		,@EstadoEnvio
		,@IsoPais
		,@CodigoZona
		,@EMail
	)

	set @RetornoID = 1
  
END
GO


go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Single]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
GO

CREATE PROCEDURE RevistaDigitalSuscripcion_Single
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
)
AS
BEGIN
	
	select top 1
		 RevistaDigitalSuscripcionID
		,CodigoConsultora
		,CampaniaID
		,FechaSuscripcion
		,FechaDesuscripcion
		,EstadoRegistro
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora
		and CampaniaID = @CampaniaID
	order by RevistaDigitalSuscripcionID desc
   
END
GO

-- Menu Revista Digital

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('Permiso') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE Permiso ADD Codigo varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('MenuMobile') and SYSCOLUMNS.NAME = N'Codigo') = 0
	ALTER TABLE MenuMobile ADD Codigo varchar(100)
go
-- menu desktop
go
if not exists(select 1 from Permiso where Codigo = 'RevistaDigital')
begin

	DECLARE @PermisoID INT = 0
	DECLARE @OrdenItem INT = 6

	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SET @PermisoID = isnull(@PermisoID, 0) + 1

  	INSERT INTO Permiso
  	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
  	VALUES(@PermisoID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'RevistaDigital/Index',0,'Header','',0,0,0, 1, 'RevistaDigital')
  
	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(1,@PermisoID,1,1)

	update Permiso
	set OrdenItem = @OrdenItem + 1
	where Descripcion = 'VENTA EXCLUSIVA WEB'

	update Permiso
	set Codigo = 'FDTC'
	where UrlItem = 'CatalogoPersonalizado/Index'
end
go

-- menu mobile
go
if not exists(select 1 from MenuMobile where Codigo = 'RevistaDigital')
begin

	DECLARE @ID INT = 0
	DECLARE @OrdenItem INT = 4

	SELECT @ID=MAX(MenuMobileID) FROM MenuMobile
	SET @ID = isnull(@ID, 0) + 1

  	INSERT INTO MenuMobile
  	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2, Codigo)
  	VALUES(@ID, 'ÉSIKA PARA MÍ', 0, @OrdenItem,'Mobile/RevistaDigital',null,0,'Menu','Mobile', 1, 'RevistaDigital')

	update MenuMobile
	set Codigo = 'FDTC'
	where UrlItem = 'Mobile/CatalogoPersonalizado/Index' or UrlItem = 'Mobile/CatalogoPersonalizado'
end
go
-- FIN 

go
ALTER PROCEDURE [dbo].GetPermisosByRol_SB2
(
	@RolID smallint
)
AS
/*
GetPermisosByRol_SB2 1
GetPermisosByRol_SB2 4
*/
BEGIN
	SELECT P.PermisoID,
			P.Descripcion,
			P.IdPadre,
			P.OrdenItem,
			P.UrlItem,
			P.PaginaNueva,
			P.UrlImagen,
			P.EsSoloImagen,
			P.EsMenuEspecial,
			P.EsServicios,
			RL.RolID,
			isnull(RL.Mostrar,1) As Mostrar,
			isnull(Posicion,'')[Posicion],
			Codigo
	FROM Permiso P
	INNER JOIN RolPermiso RL
	ON RL.PermisoID = P.PermisoID
	WHERE RL.Activo = 1
		AND RL.RolID = @RolID
		AND (@RolID != 1 or P.EsPrincipal = 1)
	order by Posicion, idpadre, ordenItem
END

GO

ALTER PROCEDURE [dbo].[GetMenuMobile_SB2]
AS
BEGIN
SET NOCOUNT ON;
	SELECT 
		MenuMobileID
		,Descripcion
		,MenuPadreID
		,OrdenItem
		,UrlItem
		,UrlImagen
		,PaginaNueva
		,Posicion
		,[Version]
		,EsSB2
		,Codigo
	FROM dbo.MenuMobile
	WHERE EsSB2=1
	order by Posicion, MenuPadreID, ordenItem
END
GO


go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ConfiguracionPais_GetAll]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetAll]
GO

CREATE PROCEDURE ConfiguracionPais_GetAll
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
BEGIN
SET NOCOUNT ON;
	
	--declare 
	--@Codigo varchar(100) = ''
	--,@CodigoRegion  varchar(100) = ''
	--,@CodigoZona  varchar(100) = '3033'
	--,@CodigoSeccion  varchar(100) = ''
	--,@CodigoConsultora  varchar(100) = ''

	set @CodigoRegion = ISNULL(@CodigoRegion, '')
	set @CodigoZona = ISNULL(@CodigoZona, '')
	set @CodigoSeccion = ISNULL(@CodigoSeccion, '')
	set @CodigoConsultora = ISNULL(@CodigoConsultora, '')

	declare @CodigoUbigeo  varchar(1000) = ''
	set @CodigoUbigeo = 
		case when @CodigoRegion = '' then '' else ('CR' + @CodigoRegion + ',') end
		+ case when @CodigoZona = '' then '' else ('CZ' + @CodigoZona + ',') end
		+ case when @CodigoSeccion = '' then '' else ('CS' + @CodigoSeccion + ',') end
		+ case when @CodigoConsultora = '' then '' else ('CC' + @CodigoConsultora + ',') end

	set @Codigo = isnull(@Codigo, '')

	select
		c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Estado
		,c.Descripcion
		,d.ConfiguracionPaisDetalleID
		,isnull(d.CodigoRegion,'') as CodigoRegion
		,isnull(d.CodigoZona,'') as CodigoZona
		,isnull(d.CodigoSeccion,'') as CodigoSeccion
		,isnull(d.CodigoConsultora,'') as CodigoConsultora
		, convert(varchar(1000), '') AS CodigoUbigeo
	into #Confi
	from ConfiguracionPais c
		inner join ConfiguracionPaisDetalle d
			on c.ConfiguracionPaisID = d.ConfiguracionPaisID
			and d.Estado = '1'
	where c.Estado = '1'and
		(c.Codigo = @Codigo OR @Codigo = '')

	update #Confi
	set  CodigoUbigeo = 'CR'+ CodigoRegion + ',CZ' + CodigoZona + ',CS' + CodigoSeccion + ',CC' + CodigoConsultora + ','

	delete FROM #Confi
	where CodigoUbigeo NOT like ('%' + @CodigoUbigeo + '%') AND Excluyente = 0
		
	delete FROM #Confi
	where CodigoUbigeo like ('%' + @CodigoUbigeo + '%') AND Excluyente = 1

	SELECT ConfiguracionPaisID
		,Codigo
		,Excluyente
		,Descripcion
		,Estado
	FROM #Confi
	WHERE Estado = 1

	DROP TABLE #Confi
END
GO