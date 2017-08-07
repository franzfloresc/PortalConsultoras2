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
	ADD TipoEstrategia VARCHAR(255);

	ALTER TABLE ConfiguracionPais
	ADD MostrarCampaniaSiguiente BIT default 'FALSE';

	ALTER TABLE ConfiguracionPais
	ADD MostrarPagInformativa BIT default 'FALSE';

	ALTER TABLE ConfiguracionPais
	ADD HImagenFondo VARCHAR(255);

	ALTER TABLE ConfiguracionPais
	ADD HTipoPresentacion int NOT NULL DEFAULT(0);

	ALTER TABLE ConfiguracionPais
	ADD HMaxProductos int NOT NULL DEFAULT(0);

	ALTER TABLE ConfiguracionPais
	ADD HTipoEstrategia VARCHAR(255);
END
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
           , 0 )
		--DROP COLUMN TienePerfil 
END
GO

--- STORES NECESARIO 

ALTER PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.TienePerfil = @TienePerfil
END


ALTER PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.ConfiguracionPaisID = @ConfiguracionPaisID
END


ALTER PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
	@ConfiguracionPaisID int,
	@Codigo int,
	@Excluyente int,
	@Descripcion int,
	@Estado varchar(250),
	@TienePerfil varchar(250),
	@DesdeCampania varchar(250),
	@TipoEstrategia varchar(250),
	@MostrarCampaniaSiguiente varchar(250),
	@MostrarPagInformativa varchar(250),
	@HImagenFondo varchar(250),
	@HTipoPresentacion date,
	@HMaxProductos date,
	@HTipoEstrategia varchar(250)
AS 
BEGIN
SET NOCOUNT ON;
DECLARE @insertedId = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Codigo, Excluyente, Descripcion, Estado, TienePerfil,
						DesdeCampania, TipoEstrategia, MostrarCampaniaSiguiente, MostrarPagInformativa, HImagenFondo, HTipoPresentacion, HMaxProductos, HTipoEstrategia)
		VALUES (@Codigo, @Excluyente, @Descripcion, @Estado, @TienePerfil,
					@DesdeCampania, @TipoEstrategia, @MostrarCampaniaSiguiente, @MostrarPagInformativa, @HImagenFondo, @HTipoPresentacion, @HMaxProductos, @HTipoEstrategia);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE Plant SET
			Codigo = @Codigo, 
			Excluyente = @Excluyente, 
			Descripcion = @Descripcion, 
			Estado = @Estado, 
			TienePerfil = @TienePerfil,
			DesdeCampania = @DesdeCampania, 
			TipoEstrategia = @TipoEstrategia, 
			MostrarCampaniaSiguiente = @MostrarCampaniaSiguiente, 
			MostrarPagInformativa = @MostrarPagInformativa, 
			HImagenFondo = @HImagenFondo, 
			HTipoPresentacion = @HTipoPresentacion, 
			HMaxProductos = @HMaxProductos, 
			HTipoEstrategia =@HTipoEstrategia
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @IdPlant;
	END
END


