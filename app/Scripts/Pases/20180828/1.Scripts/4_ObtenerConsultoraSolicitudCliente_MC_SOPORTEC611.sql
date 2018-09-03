USE BelcorpPeru
GO

ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @Temp_Consultora1 TABLE
	(
		Codigo VARCHAR(20),
		ZonaID INT,
		TerritorioID INT,
		CodigoUsuario VARCHAR(20)
	)

	DECLARE @CodigoConsultora VARCHAR(50);
	INSERT INTO @Temp_Consultora1 
	SELECT co.Codigo, CO.ZonaID, CO.TerritorioID, USU.CodigoUsuario
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	DECLARE @Temp_Consultora2 TABLE
	(
		Codigo varchar(20),
		CodigoUsuario varchar(20)
	)

	INSERT INTO @Temp_Consultora2
	SELECT 
		Codigo, CodigoUsuario
	FROM @Temp_Consultora1
	WHERE 
	iif(@PaisValido = 1, ZonaID, TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) 

	SELECT TOP 1 @CodigoConsultora = Codigo from @Temp_Consultora2
	WHERE dbo.ValidarAutorizacion(@PaisID, CodigoUsuario) = 3

	RETURN ISNULL(@CodigoConsultora, '');
END
GO

USE BelcorpMexico
GO

ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @Temp_Consultora1 TABLE
	(
		Codigo VARCHAR(20),
		ZonaID INT,
		TerritorioID INT,
		CodigoUsuario VARCHAR(20)
	)

	DECLARE @CodigoConsultora VARCHAR(50);
	INSERT INTO @Temp_Consultora1 
	SELECT co.Codigo, CO.ZonaID, CO.TerritorioID, USU.CodigoUsuario
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	DECLARE @Temp_Consultora2 TABLE
	(
		Codigo varchar(20),
		CodigoUsuario varchar(20)
	)

	INSERT INTO @Temp_Consultora2
	SELECT 
		Codigo, CodigoUsuario
	FROM @Temp_Consultora1
	WHERE 
	iif(@PaisValido = 1, ZonaID, TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) 

	SELECT TOP 1 @CodigoConsultora = Codigo from @Temp_Consultora2
	WHERE dbo.ValidarAutorizacion(@PaisID, CodigoUsuario) = 3

	RETURN ISNULL(@CodigoConsultora, '');
END
GO

USE BelcorpColombia
GO

ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @Temp_Consultora1 TABLE
	(
		Codigo VARCHAR(20),
		ZonaID INT,
		TerritorioID INT,
		CodigoUsuario VARCHAR(20)
	)

	DECLARE @CodigoConsultora VARCHAR(50);
	INSERT INTO @Temp_Consultora1 
	SELECT co.Codigo, CO.ZonaID, CO.TerritorioID, USU.CodigoUsuario
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	DECLARE @Temp_Consultora2 TABLE
	(
		Codigo varchar(20),
		CodigoUsuario varchar(20)
	)

	INSERT INTO @Temp_Consultora2
	SELECT 
		Codigo, CodigoUsuario
	FROM @Temp_Consultora1
	WHERE 
	iif(@PaisValido = 1, ZonaID, TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) 

	SELECT TOP 1 @CodigoConsultora = Codigo from @Temp_Consultora2
	WHERE dbo.ValidarAutorizacion(@PaisID, CodigoUsuario) = 3

	RETURN ISNULL(@CodigoConsultora, '');
END
GO

USE BelcorpSalvador
GO

ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @Temp_Consultora1 TABLE
	(
		Codigo VARCHAR(20),
		ZonaID INT,
		TerritorioID INT,
		CodigoUsuario VARCHAR(20)
	)

	DECLARE @CodigoConsultora VARCHAR(50);
	INSERT INTO @Temp_Consultora1 
	SELECT co.Codigo, CO.ZonaID, CO.TerritorioID, USU.CodigoUsuario
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	DECLARE @Temp_Consultora2 TABLE
	(
		Codigo varchar(20),
		CodigoUsuario varchar(20)
	)

	INSERT INTO @Temp_Consultora2
	SELECT 
		Codigo, CodigoUsuario
	FROM @Temp_Consultora1
	WHERE 
	iif(@PaisValido = 1, ZonaID, TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) 

	SELECT TOP 1 @CodigoConsultora = Codigo from @Temp_Consultora2
	WHERE dbo.ValidarAutorizacion(@PaisID, CodigoUsuario) = 3

	RETURN ISNULL(@CodigoConsultora, '');
END
GO

USE BelcorpPuertoRico
GO

ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @Temp_Consultora1 TABLE
	(
		Codigo VARCHAR(20),
		ZonaID INT,
		TerritorioID INT,
		CodigoUsuario VARCHAR(20)
	)

	DECLARE @CodigoConsultora VARCHAR(50);
	INSERT INTO @Temp_Consultora1 
	SELECT co.Codigo, CO.ZonaID, CO.TerritorioID, USU.CodigoUsuario
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	DECLARE @Temp_Consultora2 TABLE
	(
		Codigo varchar(20),
		CodigoUsuario varchar(20)
	)

	INSERT INTO @Temp_Consultora2
	SELECT 
		Codigo, CodigoUsuario
	FROM @Temp_Consultora1
	WHERE 
	iif(@PaisValido = 1, ZonaID, TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) 

	SELECT TOP 1 @CodigoConsultora = Codigo from @Temp_Consultora2
	WHERE dbo.ValidarAutorizacion(@PaisID, CodigoUsuario) = 3

	RETURN ISNULL(@CodigoConsultora, '');
END
GO

USE BelcorpPanama
GO

ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @Temp_Consultora1 TABLE
	(
		Codigo VARCHAR(20),
		ZonaID INT,
		TerritorioID INT,
		CodigoUsuario VARCHAR(20)
	)

	DECLARE @CodigoConsultora VARCHAR(50);
	INSERT INTO @Temp_Consultora1 
	SELECT co.Codigo, CO.ZonaID, CO.TerritorioID, USU.CodigoUsuario
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	DECLARE @Temp_Consultora2 TABLE
	(
		Codigo varchar(20),
		CodigoUsuario varchar(20)
	)

	INSERT INTO @Temp_Consultora2
	SELECT 
		Codigo, CodigoUsuario
	FROM @Temp_Consultora1
	WHERE 
	iif(@PaisValido = 1, ZonaID, TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) 

	SELECT TOP 1 @CodigoConsultora = Codigo from @Temp_Consultora2
	WHERE dbo.ValidarAutorizacion(@PaisID, CodigoUsuario) = 3

	RETURN ISNULL(@CodigoConsultora, '');
END
GO

USE BelcorpGuatemala
GO

ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @Temp_Consultora1 TABLE
	(
		Codigo VARCHAR(20),
		ZonaID INT,
		TerritorioID INT,
		CodigoUsuario VARCHAR(20)
	)

	DECLARE @CodigoConsultora VARCHAR(50);
	INSERT INTO @Temp_Consultora1 
	SELECT co.Codigo, CO.ZonaID, CO.TerritorioID, USU.CodigoUsuario
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	DECLARE @Temp_Consultora2 TABLE
	(
		Codigo varchar(20),
		CodigoUsuario varchar(20)
	)

	INSERT INTO @Temp_Consultora2
	SELECT 
		Codigo, CodigoUsuario
	FROM @Temp_Consultora1
	WHERE 
	iif(@PaisValido = 1, ZonaID, TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) 

	SELECT TOP 1 @CodigoConsultora = Codigo from @Temp_Consultora2
	WHERE dbo.ValidarAutorizacion(@PaisID, CodigoUsuario) = 3

	RETURN ISNULL(@CodigoConsultora, '');
END
GO

USE BelcorpEcuador
GO

ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @Temp_Consultora1 TABLE
	(
		Codigo VARCHAR(20),
		ZonaID INT,
		TerritorioID INT,
		CodigoUsuario VARCHAR(20)
	)

	DECLARE @CodigoConsultora VARCHAR(50);
	INSERT INTO @Temp_Consultora1 
	SELECT co.Codigo, CO.ZonaID, CO.TerritorioID, USU.CodigoUsuario
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	DECLARE @Temp_Consultora2 TABLE
	(
		Codigo varchar(20),
		CodigoUsuario varchar(20)
	)

	INSERT INTO @Temp_Consultora2
	SELECT 
		Codigo, CodigoUsuario
	FROM @Temp_Consultora1
	WHERE 
	iif(@PaisValido = 1, ZonaID, TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) 

	SELECT TOP 1 @CodigoConsultora = Codigo from @Temp_Consultora2
	WHERE dbo.ValidarAutorizacion(@PaisID, CodigoUsuario) = 3

	RETURN ISNULL(@CodigoConsultora, '');
END
GO

USE BelcorpDominicana
GO

ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @Temp_Consultora1 TABLE
	(
		Codigo VARCHAR(20),
		ZonaID INT,
		TerritorioID INT,
		CodigoUsuario VARCHAR(20)
	)

	DECLARE @CodigoConsultora VARCHAR(50);
	INSERT INTO @Temp_Consultora1 
	SELECT co.Codigo, CO.ZonaID, CO.TerritorioID, USU.CodigoUsuario
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	DECLARE @Temp_Consultora2 TABLE
	(
		Codigo varchar(20),
		CodigoUsuario varchar(20)
	)

	INSERT INTO @Temp_Consultora2
	SELECT 
		Codigo, CodigoUsuario
	FROM @Temp_Consultora1
	WHERE 
	iif(@PaisValido = 1, ZonaID, TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) 

	SELECT TOP 1 @CodigoConsultora = Codigo from @Temp_Consultora2
	WHERE dbo.ValidarAutorizacion(@PaisID, CodigoUsuario) = 3

	RETURN ISNULL(@CodigoConsultora, '');
END
GO

USE BelcorpCostaRica
GO

ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @Temp_Consultora1 TABLE
	(
		Codigo VARCHAR(20),
		ZonaID INT,
		TerritorioID INT,
		CodigoUsuario VARCHAR(20)
	)

	DECLARE @CodigoConsultora VARCHAR(50);
	INSERT INTO @Temp_Consultora1 
	SELECT co.Codigo, CO.ZonaID, CO.TerritorioID, USU.CodigoUsuario
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	DECLARE @Temp_Consultora2 TABLE
	(
		Codigo varchar(20),
		CodigoUsuario varchar(20)
	)

	INSERT INTO @Temp_Consultora2
	SELECT 
		Codigo, CodigoUsuario
	FROM @Temp_Consultora1
	WHERE 
	iif(@PaisValido = 1, ZonaID, TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) 

	SELECT TOP 1 @CodigoConsultora = Codigo from @Temp_Consultora2
	WHERE dbo.ValidarAutorizacion(@PaisID, CodigoUsuario) = 3

	RETURN ISNULL(@CodigoConsultora, '');
END
GO

USE BelcorpChile
GO

ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @Temp_Consultora1 TABLE
	(
		Codigo VARCHAR(20),
		ZonaID INT,
		TerritorioID INT,
		CodigoUsuario VARCHAR(20)
	)

	DECLARE @CodigoConsultora VARCHAR(50);
	INSERT INTO @Temp_Consultora1 
	SELECT co.Codigo, CO.ZonaID, CO.TerritorioID, USU.CodigoUsuario
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	DECLARE @Temp_Consultora2 TABLE
	(
		Codigo varchar(20),
		CodigoUsuario varchar(20)
	)

	INSERT INTO @Temp_Consultora2
	SELECT 
		Codigo, CodigoUsuario
	FROM @Temp_Consultora1
	WHERE 
	iif(@PaisValido = 1, ZonaID, TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) 

	SELECT TOP 1 @CodigoConsultora = Codigo from @Temp_Consultora2
	WHERE dbo.ValidarAutorizacion(@PaisID, CodigoUsuario) = 3

	RETURN ISNULL(@CodigoConsultora, '');
END
GO

USE BelcorpBolivia
GO

ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @Temp_Consultora1 TABLE
	(
		Codigo VARCHAR(20),
		ZonaID INT,
		TerritorioID INT,
		CodigoUsuario VARCHAR(20)
	)

	DECLARE @CodigoConsultora VARCHAR(50);
	INSERT INTO @Temp_Consultora1 
	SELECT co.Codigo, CO.ZonaID, CO.TerritorioID, USU.CodigoUsuario
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	DECLARE @Temp_Consultora2 TABLE
	(
		Codigo varchar(20),
		CodigoUsuario varchar(20)
	)

	INSERT INTO @Temp_Consultora2
	SELECT 
		Codigo, CodigoUsuario
	FROM @Temp_Consultora1
	WHERE 
	iif(@PaisValido = 1, ZonaID, TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) 

	SELECT TOP 1 @CodigoConsultora = Codigo from @Temp_Consultora2
	WHERE dbo.ValidarAutorizacion(@PaisID, CodigoUsuario) = 3

	RETURN ISNULL(@CodigoConsultora, '');
END
GO

