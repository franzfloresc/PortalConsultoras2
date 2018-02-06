/*Insert into new table, event Id(OfertaShowRoomID, OfertaShowRoomDetalleID)
If id is register do not register Again ( prevent double migration)
*/
--IF (OBJECT_ID('dbo.MigracionShowRoom_Estrategia', 'P') IS NOT NULL)
--	EXEC ('DROP PROCEDURE dbo.MigracionShowRoom_Estrategia')
--GO
--CREATE PROCEDURE MigracionShowRoom_Estrategia
--AS
--BEGIN
BEGIN TRANSACTION Migracion_showRoom

BEGIN TRY
	IF COL_LENGTH('Estrategia', 'OfertaShowRoomID') IS NULL
	BEGIN
		ALTER TABLE Estrategia ADD DesktopColorFondo INT NULL
	END

	IF COL_LENGTH('EstrategiaProducto', 'OfertaShowRoomDetalleID') IS NULL
	BEGIN
		ALTER TABLE EstrategiaProducto ADD OfertaShowRoomDetalleID INT NULL
	END

	DECLARE @Campanias VARCHAR(250) = '201801,201802';
	DECLARE @Campanias_Table TABLE (value VARCHAR(25));

	INSERT INTO @Campanias_Table (value)
	SELECT *
	FROM fnSplitString(@Campanias, ',');

	/*Productos Show Room por migrar*/
	DECLARE @MaxEstrategiaID INT;

	SELECT @MaxEstrategiaID = max(EstrategiaID)
	FROM Estrategia;

	DECLARE @Temp_Estrategia TABLE (
		EstrategiaID int NOT NULL --si
		,TipoEstrategiaID int NOT NULL --si
		,CampaniaID int NOT NULL --si
		,Activo bit NULL --si
		,ImagenURL varchar(800) NULL --si
		,LimiteVenta int NULL --si
		,DescripcionCUV2 varchar(800) NULL --si
		--,CUV varchar(20) NULL
		,EtiquetaID int NOT NULL --si
		,Precio numeric(12, 2) NULL --si
		--,FlagCEP bit NULL
		,CUV2 varchar(20) NULL --si
		,EtiquetaID2 int NOT NULL --si
		,Precio2 numeric(12, 2) NULL --si
		,FlagCEP2 bit NULL
		,TextoLibre varchar(800) NULL --si
		,FlagTextoLibre bit NULL
		,Cantidad int NULL --si
		,FlagCantidad bit NULL
		,Zona varchar(8000) NULL
		,Limite int NULL
		,Orden int NULL --si
		,UsuarioCreacion varchar(100) NULL  --si
		,FechaCreacion datetime NULL --si
		,UsuarioModificacion varchar(100) NULL --si
		,FechaModificacion datetime NULL --si
		,ColorFondo varchar(20) NULL
		,FlagEstrella bit NULL
		,CodigoEstrategia varchar(100) NULL  --si
		,TieneVariedad int NULL 
		,EsOfertaIndependiente bit NULL
		,PrecioPublico decimal(18, 2) NOT NULL --si
		,Ganancia decimal(18, 2) NOT NULL  --si
		,CodigoPrograma varchar(3) NULL
		,CodigoConcurso varchar(6) NULL
		,ImagenMiniaturaURL varchar(200) NULL  --si
		,EsSubCampania bit NULL  --si
		,OfertaShowRoomID INT  --si
		)

	--TipoEstrategia
	INSERT INTO @Temp_Estrategia (
		EstrategiaID
		,TipoEstrategiaID
		,CampaniaID
		,CUV2
		,DescripcionCUV2
		,Precio
		,PrecioPublico
		,Cantidad
		,ImagenURL
		,LimiteVenta
		,Activo
		,ImagenMiniaturaURL
		,Orden
		,TextoLibre
		,Precio2
		,EsSubCampania
		,EtiquetaID
		,EtiquetaID2
		,Ganancia
		,UsuarioCreacion
		,FechaCreacion
		,UsuarioModificacion
		,FechaModificacion
		,OfertaShowRoomID
		)
	SELECT ROW_NUMBER() OVER (
			ORDER BY OfertaShowRoomID ASC
			) + @MaxEstrategiaID AS 'EstrategiaID'
		,ves.TipoEstrategiaId --showRoom
		,c.codigo AS 'CampaniaId'
		,osr.CUV AS 'CUV2'
		,osr.Descripcion AS 'DescripcionCUV2'
		,osr.PrecioValorizado AS 'Precio'
		,osr.PrecioValorizado AS 'PrecioPublico'
		,osr.Stock AS 'Cantidad'
		,osr.ImagenProducto AS 'ImagenURL'
		,osr.UnidadesPermitidas AS 'LimiteVenta'
		,osr.FlagHabilitarProducto AS 'Activo'
		,osr.ImagenMini AS 'ImagenMiniaturaURL'
		,osr.Orden
		,osr.TipNegocio AS 'TextoLibre'
		,osr.PrecioOferta AS 'Precio2'
		,osr.EsSubCampania
		,0 AS 'EtiquetaID'
		,0 AS 'EtiquetaID2'
		,osr.PrecioValorizado - osr.PrecioOferta AS 'Ganancia'
		,osr.UsuarioRegistro AS 'UsuarioCreacion'
		,osr.FechaRegistro AS 'FechaCreacion'
		,osr.UsuarioModificacion AS 'UsuarioModificacion'
		,osr.FechaModificacion AS 'FechaModificacion'
		,osr.OfertaShowRoomID
	FROM ShowRoom.OfertaShowRoom osr
	INNER JOIN ods.Campania c ON osr.CampaniaID = c.CampaniaID
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON osr.TipoOfertaSisID = ves.TipoOfertaSisID
	--AND osr.ConfiguracionOfertaID = ves.ConfiguracionOfertaID --No coincide en Colombia
	INNER JOIN @Campanias_Table cm ON c.Codigo = cm.value
	WHERE osr.OfertaShowRoomID NOT IN (SELECT OfertaShowRoomID FROM dbo.Estrategia);

	--Set identityInsert ON
	SET IDENTITY_INSERT dbo.Estrategia ON

	INSERT INTO Estrategia (
		EstrategiaID
		,TipoEstrategiaID
		,CampaniaID
		,CUV2
		,DescripcionCUV2
		,Precio
		,PrecioPublico
		,Cantidad
		,ImagenURL
		,LimiteVenta
		,Activo
		,ImagenMiniaturaURL
		,Orden
		,TextoLibre
		,Precio2
		,EsSubCampania
		,EtiquetaID
		,EtiquetaID2
		,Ganancia
		,UsuarioCreacion
		,FechaCreacion
		,UsuarioModificacion
		,FechaModificacion
		,OfertaShowRoomID
		)
	SELECT TOP 1 EstrategiaID
		,TipoEstrategiaID
		,CampaniaID
		,CUV2
		,DescripcionCUV2
		,Precio
		,PrecioPublico
		,Cantidad
		,ImagenURL
		,LimiteVenta
		,Activo
		,ImagenMiniaturaURL
		,Orden
		,TextoLibre
		,Precio2
		,EsSubCampania
		,EtiquetaID
		,EtiquetaID2
		,Ganancia
		,UsuarioCreacion
		,FechaCreacion
		,UsuarioModificacion
		,FechaModificacion
		,OfertaShowRoomID
	FROM @Temp_Estrategia

	--Set identityInsert OFF
	SET IDENTITY_INSERT dbo.Estrategia OFF

	/*Detalle show room por migrar*/
	DECLARE @MaxEstrategiaProductoID INT;

	SELECT @MaxEstrategiaProductoID = MAX(EstrategiaProductoId)
	FROM dbo.EstrategiaProducto

	DECLARE @MarcaEquivalencias TABLE (
		MarcaID TINYINT
		,Descripcion VARCHAR(20)
		);

	INSERT INTO @MarcaEquivalencias (
		MarcaId
		,Descripcion
		)
	SELECT MarcaId
		,LOWER(Descripcion)
	FROM dbo.Marca;

	INSERT INTO @MarcaEquivalencias
	VALUES (
		3
		,'cy°zone'
		)

	DECLARE @Temp_EstrategiaProducto TABLE (
		EstrategiaProductoId int NOT NULL  --si
		,EstrategiaId int NOT NULL  --si
		,Campania int NOT NULL  --si
		,CUV nvarchar(20) NOT NULL  --si
		,CodigoEstrategia nvarchar(100) NOT NULL  --si
		,Grupo nvarchar(20) NULL 
		,Orden int NULL  --si
		,CUV2 nvarchar(20) NULL 
		,SAP nvarchar(50) NULL  --si
		,Cantidad int NULL
		,Precio money NULL
		,PrecioValorizado money NULL
		,Digitable int NULL
		,CodigoError nvarchar(100) NULL
		,CodigoErrorObs nvarchar(4000) NULL
		,FactorCuadre int NULL
		,NombreProducto varchar(150) NULL  --si
		,Descripcion1 varchar(255) NULL  --si
		,ImagenProducto varchar(150) NULL --si
		,IdMarca tinyint NULL --si
		,Activo bit NULL
		,UsuarioCreacion varchar(30) NULL  --si
		,FechaCreacion datetime NULL --si
		,UsuarioModificacion varchar(30) NULL --si
		,FechaModificacion datetime NULL --si
		,OfertaShowRoomDetalleID int --si
		)

	INSERT INTO @Temp_EstrategiaProducto (
		EstrategiaProductoId
		,EstrategiaId
		,Campania
		,CUV
		,CodigoEstrategia
		,Orden
		,NombreProducto
		,Descripcion1
		,ImagenProducto
		,IdMarca
		,UsuarioCreacion
		,FechaCreacion
		,UsuarioModificacion
		,FechaModificacion
		,OfertaShowRoomDetalleID
		)
	SELECT ROW_NUMBER() OVER (
			ORDER BY OfertaShowRoomDetalleID ASC
			) + @MaxEstrategiaProductoID AS 'EstrategiaProductoId'
		,e.EstrategiaID
		,osd.CampaniaId
		,osd.CUV
		,'xxxx' AS 'CodigoEstrategia' -- osd.CodigoEstrategia --se actualizara con el proceso batch
		,osd.Posicion AS 'Orden'
		,osd.NombreProducto
		,osd.Descripcion1
		,osd.Imagen AS 'ImagenProducto'
		,m.MarcaID AS 'IdMarca'
		,osd.UsuarioCreacion AS 'UsuarioCreacion'
		,osd.FechaCreacion AS 'FechaCreacion'
		,osd.UsuarioModificacion AS 'UsuarioModificacion'
		,osd.FechaModificacion AS 'FechaModificacion'
		,OfertaShowRoomDetalleID
	FROM ShowRoom.OfertaShowRoomDetalle osd
	INNER JOIN @Temp_Estrategia e ON osd.CUV = e.CUV2
	INNER JOIN ods.Campania c ON osd.CampaniaID = c.Codigo
		AND e.CampaniaId = c.Codigo
	INNER JOIN @MarcaEquivalencias m ON LOWER(osd.MarcaProducto) = m.Descripcion
	WHERE osd.OfertaShowRoomDetalleID NOT IN (SELECT OfertaShowRoomDetalleID FROM dbo.EstrategiaProducto);

	--Set identityInsert ON
	SET IDENTITY_INSERT dbo.EstrategiaProducto ON

	INSERT INTO dbo.EstrategiaProducto (
		EstrategiaProductoId
		,EstrategiaId
		,Campania
		,CUV
		,CodigoEstrategia
		,Orden
		,NombreProducto
		,Descripcion1
		,ImagenProducto
		,IdMarca
		,UsuarioCreacion
		,FechaCreacion
		,UsuarioModificacion
		,FechaModificacion
		,OfertaShowRoomDetalleID
		)
	SELECT TOP 1 EstrategiaProductoId
		,EstrategiaId
		,Campania
		,CUV
		,CodigoEstrategia
		,Orden
		,NombreProducto
		,Descripcion1
		,ImagenProducto
		,IdMarca
		,UsuarioCreacion
		,FechaCreacion
		,UsuarioModificacion
		,FechaModificacion
		,OfertaShowRoomDetalleID
	FROM @Temp_EstrategiaProducto

	--Set identityInsert OFF
	SET IDENTITY_INSERT dbo.EstrategiaProducto OFF

	/*Pintando lo insertado*/
	SELECT *
	FROM @Temp_Estrategia

	SELECT *
	FROM @Temp_EstrategiaProducto;

	/*Pintando No insertados*/
	--WITH( o as ( select OfertaShowRoomDetalleID
	SELECT *
	FROM ShowRoom.OfertaShowRoom osr
	WHERE osr.OfertaShowRoomID NOT IN (
			SELECT OfertaShowRoomID
			FROM @Temp_EstrategiaProducto
			)

	SELECT *
	FROM ShowRoom.OfertaShowRoomDetalle osrd
	WHERE osrd.OfertaShowRoomDetalleID NOT IN (
			SELECT OfertaShowRoomDetalleID
			FROM @Temp_EstrategiaProducto
			)

	COMMIT TRANSACTION Migracion_showRoom
END TRY

BEGIN CATCH
	SET IDENTITY_INSERT dbo.Estrategia OFF
	SET IDENTITY_INSERT dbo.EstrategiaProducto OFF

	ROLLBACK TRANSACTION Migracion_showRoom;

	THROW;
END CATCH
	--END
