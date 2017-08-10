-- SCRIPTS NECESARIOS PARA CONFIGURACION PAIS PERFIL

-- Agregar colummna para las palancas 
IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD TienePerfil BIT default 'FALSE';
		--DROP COLUMN TienePerfil 
	ALTER TABLE ConfiguracionPais
	ADD DesdeCampania int NOT NULL DEFAULT(0);

	ALTER TABLE ConfiguracionPais
	ADD MobileTituloMenu VARCHAR(255);

	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloMenu VARCHAR(255);

	ALTER TABLE ConfiguracionPais
	ADD Logo VARCHAR(255);

	ALTER TABLE ConfiguracionPais
	ADD Orden int NOT NULL DEFAULT(0);

	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloBanner VARCHAR(255);

	ALTER TABLE ConfiguracionPais
	ADD MobileTituloBanner VARCHAR(255);

	ALTER TABLE ConfiguracionPais
	ADD DesktopSubTituloBanner VARCHAR(255);

	ALTER TABLE ConfiguracionPais
	ADD MobileSubTituloBanner VARCHAR(255);

	ALTER TABLE ConfiguracionPais
	ADD Color VARCHAR(255);
END
GO
-- Agregar Tipo de presentacion en la Tabla logica datos

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')

GO

-- Agregar campo del menu para configuracion del perfil de la estrategia

IF NOT EXISTS (
  SELECT [PermisoID] 
  FROM   [dbo].[Permiso] 
  WHERE  PermisoID = 141
)
BEGIN
	INSERT INTO [dbo].[Permiso]
           ([PermisoID]
           ,[Descripcion]
           ,[IdPadre]
           ,[OrdenItem]
           ,[UrlItem]
           ,[PaginaNueva]
           ,[Posicion]
           ,[UrlImagen]
           ,[EsSoloImagen]
           ,[EsMenuEspecial]
           ,[EsServicios]
           ,[EsPrincipal]
           ,[Codigo])
     VALUES
           ( 141
           , 'Configurar Palanca'
           , 111
           , 28
           , 'AdministrarPalanca/Index'
           , 0
           , 'Header'
           , ''
           , 0
           , 0
           , 0
           , 0
           , null )

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar)
	VALUES (4, 141, 1, 1)
END
GO

--- STORES NECESARIO 

ALTER PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.TienePerfil = @TienePerfil
END
GO

ALTER PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

ALTER PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
	@ConfiguracionPaisID int,
	@Excluyente bit,
	@Descripcion varchar(250),
	@Estado bit,
	@DesdeCampania int,
	@MobileTituloMenu varchar(250),
	@DesktopTituloMenu varchar(250),
	@Logo varchar(250),
	@Color varchar(250),
	@Orden int,
	@DesktopTituloBanner varchar(250),
	@MobileTituloBanner varchar(250),
	@DesktopSubTituloBanner varchar(250),
	@MobileSubTituloBanner varchar(250)
AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Descripcion, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Color, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner)
		VALUES (@Excluyente, @Descripcion, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Color, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionPais SET
			Excluyente = @Excluyente, 
			Descripcion = @Descripcion, 
			Estado = @Estado,
			DesdeCampania = @DesdeCampania, 
			MobileTituloMenu = @MobileTituloMenu, 
			DesktopTituloMenu = @DesktopTituloMenu,
			Logo = @Logo, 
			Color = @Color, 
			Orden = @Orden, 
			DesktopTituloBanner = @DesktopTituloBanner, 
			MobileTituloBanner = @MobileTituloBanner,
			DesktopSubTituloBanner = @DesktopSubTituloBanner, 
			MobileSubTituloBanner = @MobileSubTituloBanner
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END


