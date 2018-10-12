DELETE --OfertaShowRoomID
				FROM dbo.Estrategia
				WHERE OfertaShowRoomID IS NOT NULL

DELETE --OfertaShowRoomDetalleID
				FROM dbo.EstrategiaProducto
				WHERE OfertaShowRoomDetalleID IS NOT NULL

USE BelcorpPeru
GO

/*Insert into new table, event Id(OfertaShowRoomID, OfertaShowRoomDetalleID)
If id is register do not register Again ( prevent double migration)
*/
IF (OBJECT_ID('dbo.MigracionShowRoom_Estrategia', 'P') IS NOT NULL)
	EXEC ('DROP PROCEDURE dbo.MigracionShowRoom_Estrategia')
GO

CREATE PROCEDURE MigracionShowRoom_Estrategia (@Campanias VARCHAR(250))
AS
--MigracionShowRoom_Estrategia '201804,201805'
BEGIN
	BEGIN TRANSACTION Migracion_showRoom

	BEGIN TRY
		DECLARE @Campanias_Table TABLE (value VARCHAR(25));

		INSERT INTO @Campanias_Table (value)
		SELECT *
		FROM fnSplitString(@Campanias, ',');

		/*Productos Show Room por migrar*/
		DECLARE @MaxEstrategiaID INT;

		SELECT @MaxEstrategiaID = max(EstrategiaID)
		FROM Estrategia;

		DECLARE @Temp_Estrategia TABLE (
			EstrategiaID INT NOT NULL --si
			,TipoEstrategiaID INT NOT NULL --si
			,CampaniaID INT NOT NULL --si
			,Activo BIT NULL --si
			,ImagenURL VARCHAR(800) NULL --si
			,LimiteVenta INT NULL --si
			,DescripcionCUV2 VARCHAR(800) NULL --si
			--,CUV varchar(20) NULL
			,EtiquetaID INT NOT NULL --si
			,Precio NUMERIC(12, 2) NULL --si
			--,FlagCEP bit NULL
			,CUV2 VARCHAR(20) NULL --si
			,EtiquetaID2 INT NOT NULL --si
			,Precio2 NUMERIC(12, 2) NULL --si
			,FlagCEP2 BIT NULL
			,TextoLibre VARCHAR(800) NULL --si
			,FlagTextoLibre BIT NULL
			,Cantidad INT NULL --si
			,FlagCantidad BIT NULL
			,Zona VARCHAR(8000) NULL
			,Limite INT NULL
			,Orden INT NULL --si
			,UsuarioCreacion VARCHAR(100) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(100) NULL --si
			,FechaModificacion DATETIME NULL --si
			,ColorFondo VARCHAR(20) NULL
			,FlagEstrella BIT NULL
			,CodigoEstrategia VARCHAR(100) NULL --si
			,TieneVariedad INT NULL
			,EsOfertaIndependiente BIT NULL
			,PrecioPublico DECIMAL(18, 2) NOT NULL --si
			,Ganancia DECIMAL(18, 2) NOT NULL --si
			,CodigoPrograma VARCHAR(3) NULL
			,CodigoConcurso VARCHAR(6) NULL
			,ImagenMiniaturaURL VARCHAR(200) NULL --si
			,EsSubCampania BIT NULL --si
			,OfertaShowRoomID INT --si
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
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM dbo.Estrategia
				WHERE OfertaShowRoomID IS NOT NULL
				);

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
		SELECT EstrategiaID
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
			EstrategiaProductoId INT NOT NULL --si
			,EstrategiaId INT NOT NULL --si
			,Campania INT NOT NULL --si
			,CUV NVARCHAR(20) NOT NULL --si
			,CodigoEstrategia NVARCHAR(100) NOT NULL --si
			,Grupo NVARCHAR(20) NULL
			,Orden INT NULL --si
			,CUV2 NVARCHAR(20) NULL
			,SAP NVARCHAR(50) NULL --si
			,Cantidad INT NULL
			,Precio MONEY NULL
			,PrecioValorizado MONEY NULL
			,Digitable INT NULL
			,CodigoError NVARCHAR(100) NULL
			,CodigoErrorObs NVARCHAR(4000) NULL
			,FactorCuadre INT NULL
			,NombreProducto VARCHAR(150) NULL --si
			,Descripcion1 VARCHAR(255) NULL --si
			,ImagenProducto VARCHAR(150) NULL --si
			,IdMarca TINYINT NULL --si
			,Activo BIT NULL
			,UsuarioCreacion VARCHAR(30) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(30) NULL --si
			,FechaModificacion DATETIME NULL --si
			,OfertaShowRoomDetalleID INT --si
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
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
				SELECT *--OfertaShowRoomDetalleID
				FROM dbo.EstrategiaProducto
				WHERE OfertaShowRoomDetalleID IS NOT NULL
				);

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
		SELECT EstrategiaProductoId
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
		--WITH PosibleMigration as ( select * from @Temp_Estrategia)
		SELECT osr.*
		FROM ShowRoom.OfertaShowRoom osr
		INNER JOIN ods.Campania c ON osr.CampaniaID = c.CampaniaID
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON osr.TipoOfertaSisID = ves.TipoOfertaSisID
		INNER JOIN @Campanias_Table cm ON c.Codigo = cm.value
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM @Temp_Estrategia
				)

		SELECT osd.*
			,e.EstrategiaID
		FROM ShowRoom.OfertaShowRoomDetalle osd
		INNER JOIN @Temp_Estrategia e ON osd.CUV = e.CUV2
		INNER JOIN ods.Campania c ON osd.CampaniaID = c.Codigo
			AND e.CampaniaId = c.Codigo
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
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
END

GO

USE BelcorpMexico
GO

/*Insert into new table, event Id(OfertaShowRoomID, OfertaShowRoomDetalleID)
If id is register do not register Again ( prevent double migration)
*/
IF (OBJECT_ID('dbo.MigracionShowRoom_Estrategia', 'P') IS NOT NULL)
	EXEC ('DROP PROCEDURE dbo.MigracionShowRoom_Estrategia')
GO

CREATE PROCEDURE MigracionShowRoom_Estrategia (@Campanias VARCHAR(250))
AS
--MigracionShowRoom_Estrategia '201801,201802'
BEGIN
	BEGIN TRANSACTION Migracion_showRoom

	BEGIN TRY
		DECLARE @Campanias_Table TABLE (value VARCHAR(25));

		INSERT INTO @Campanias_Table (value)
		SELECT *
		FROM fnSplitString(@Campanias, ',');

		/*Productos Show Room por migrar*/
		DECLARE @MaxEstrategiaID INT;

		SELECT @MaxEstrategiaID = max(EstrategiaID)
		FROM Estrategia;

		DECLARE @Temp_Estrategia TABLE (
			EstrategiaID INT NOT NULL --si
			,TipoEstrategiaID INT NOT NULL --si
			,CampaniaID INT NOT NULL --si
			,Activo BIT NULL --si
			,ImagenURL VARCHAR(800) NULL --si
			,LimiteVenta INT NULL --si
			,DescripcionCUV2 VARCHAR(800) NULL --si
			--,CUV varchar(20) NULL
			,EtiquetaID INT NOT NULL --si
			,Precio NUMERIC(12, 2) NULL --si
			--,FlagCEP bit NULL
			,CUV2 VARCHAR(20) NULL --si
			,EtiquetaID2 INT NOT NULL --si
			,Precio2 NUMERIC(12, 2) NULL --si
			,FlagCEP2 BIT NULL
			,TextoLibre VARCHAR(800) NULL --si
			,FlagTextoLibre BIT NULL
			,Cantidad INT NULL --si
			,FlagCantidad BIT NULL
			,Zona VARCHAR(8000) NULL
			,Limite INT NULL
			,Orden INT NULL --si
			,UsuarioCreacion VARCHAR(100) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(100) NULL --si
			,FechaModificacion DATETIME NULL --si
			,ColorFondo VARCHAR(20) NULL
			,FlagEstrella BIT NULL
			,CodigoEstrategia VARCHAR(100) NULL --si
			,TieneVariedad INT NULL
			,EsOfertaIndependiente BIT NULL
			,PrecioPublico DECIMAL(18, 2) NOT NULL --si
			,Ganancia DECIMAL(18, 2) NOT NULL --si
			,CodigoPrograma VARCHAR(3) NULL
			,CodigoConcurso VARCHAR(6) NULL
			,ImagenMiniaturaURL VARCHAR(200) NULL --si
			,EsSubCampania BIT NULL --si
			,OfertaShowRoomID INT --si
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
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM dbo.Estrategia
				WHERE OfertaShowRoomID IS NOT NULL
				);

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
		SELECT EstrategiaID
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
			EstrategiaProductoId INT NOT NULL --si
			,EstrategiaId INT NOT NULL --si
			,Campania INT NOT NULL --si
			,CUV NVARCHAR(20) NOT NULL --si
			,CodigoEstrategia NVARCHAR(100) NOT NULL --si
			,Grupo NVARCHAR(20) NULL
			,Orden INT NULL --si
			,CUV2 NVARCHAR(20) NULL
			,SAP NVARCHAR(50) NULL --si
			,Cantidad INT NULL
			,Precio MONEY NULL
			,PrecioValorizado MONEY NULL
			,Digitable INT NULL
			,CodigoError NVARCHAR(100) NULL
			,CodigoErrorObs NVARCHAR(4000) NULL
			,FactorCuadre INT NULL
			,NombreProducto VARCHAR(150) NULL --si
			,Descripcion1 VARCHAR(255) NULL --si
			,ImagenProducto VARCHAR(150) NULL --si
			,IdMarca TINYINT NULL --si
			,Activo BIT NULL
			,UsuarioCreacion VARCHAR(30) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(30) NULL --si
			,FechaModificacion DATETIME NULL --si
			,OfertaShowRoomDetalleID INT --si
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
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
				SELECT OfertaShowRoomDetalleID
				FROM dbo.EstrategiaProducto
				WHERE OfertaShowRoomDetalleID IS NOT NULL
				);

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
		SELECT EstrategiaProductoId
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
		--WITH PosibleMigration as ( select * from @Temp_Estrategia)
		SELECT osr.*
		FROM ShowRoom.OfertaShowRoom osr
		INNER JOIN ods.Campania c ON osr.CampaniaID = c.CampaniaID
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON osr.TipoOfertaSisID = ves.TipoOfertaSisID
		INNER JOIN @Campanias_Table cm ON c.Codigo = cm.value
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM @Temp_Estrategia
				)

		SELECT osd.*
			,e.EstrategiaID
		FROM ShowRoom.OfertaShowRoomDetalle osd
		INNER JOIN @Temp_Estrategia e ON osd.CUV = e.CUV2
		INNER JOIN ods.Campania c ON osd.CampaniaID = c.Codigo
			AND e.CampaniaId = c.Codigo
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
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
END

GO

USE BelcorpColombia
GO

/*Insert into new table, event Id(OfertaShowRoomID, OfertaShowRoomDetalleID)
If id is register do not register Again ( prevent double migration)
*/
IF (OBJECT_ID('dbo.MigracionShowRoom_Estrategia', 'P') IS NOT NULL)
	EXEC ('DROP PROCEDURE dbo.MigracionShowRoom_Estrategia')
GO

CREATE PROCEDURE MigracionShowRoom_Estrategia (@Campanias VARCHAR(250))
AS
--MigracionShowRoom_Estrategia '201801,201802'
BEGIN
	BEGIN TRANSACTION Migracion_showRoom

	BEGIN TRY
		DECLARE @Campanias_Table TABLE (value VARCHAR(25));

		INSERT INTO @Campanias_Table (value)
		SELECT *
		FROM fnSplitString(@Campanias, ',');

		/*Productos Show Room por migrar*/
		DECLARE @MaxEstrategiaID INT;

		SELECT @MaxEstrategiaID = max(EstrategiaID)
		FROM Estrategia;

		DECLARE @Temp_Estrategia TABLE (
			EstrategiaID INT NOT NULL --si
			,TipoEstrategiaID INT NOT NULL --si
			,CampaniaID INT NOT NULL --si
			,Activo BIT NULL --si
			,ImagenURL VARCHAR(800) NULL --si
			,LimiteVenta INT NULL --si
			,DescripcionCUV2 VARCHAR(800) NULL --si
			--,CUV varchar(20) NULL
			,EtiquetaID INT NOT NULL --si
			,Precio NUMERIC(12, 2) NULL --si
			--,FlagCEP bit NULL
			,CUV2 VARCHAR(20) NULL --si
			,EtiquetaID2 INT NOT NULL --si
			,Precio2 NUMERIC(12, 2) NULL --si
			,FlagCEP2 BIT NULL
			,TextoLibre VARCHAR(800) NULL --si
			,FlagTextoLibre BIT NULL
			,Cantidad INT NULL --si
			,FlagCantidad BIT NULL
			,Zona VARCHAR(8000) NULL
			,Limite INT NULL
			,Orden INT NULL --si
			,UsuarioCreacion VARCHAR(100) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(100) NULL --si
			,FechaModificacion DATETIME NULL --si
			,ColorFondo VARCHAR(20) NULL
			,FlagEstrella BIT NULL
			,CodigoEstrategia VARCHAR(100) NULL --si
			,TieneVariedad INT NULL
			,EsOfertaIndependiente BIT NULL
			,PrecioPublico DECIMAL(18, 2) NOT NULL --si
			,Ganancia DECIMAL(18, 2) NOT NULL --si
			,CodigoPrograma VARCHAR(3) NULL
			,CodigoConcurso VARCHAR(6) NULL
			,ImagenMiniaturaURL VARCHAR(200) NULL --si
			,EsSubCampania BIT NULL --si
			,OfertaShowRoomID INT --si
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
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM dbo.Estrategia
				WHERE OfertaShowRoomID IS NOT NULL
				);

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
		SELECT EstrategiaID
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
			EstrategiaProductoId INT NOT NULL --si
			,EstrategiaId INT NOT NULL --si
			,Campania INT NOT NULL --si
			,CUV NVARCHAR(20) NOT NULL --si
			,CodigoEstrategia NVARCHAR(100) NOT NULL --si
			,Grupo NVARCHAR(20) NULL
			,Orden INT NULL --si
			,CUV2 NVARCHAR(20) NULL
			,SAP NVARCHAR(50) NULL --si
			,Cantidad INT NULL
			,Precio MONEY NULL
			,PrecioValorizado MONEY NULL
			,Digitable INT NULL
			,CodigoError NVARCHAR(100) NULL
			,CodigoErrorObs NVARCHAR(4000) NULL
			,FactorCuadre INT NULL
			,NombreProducto VARCHAR(150) NULL --si
			,Descripcion1 VARCHAR(255) NULL --si
			,ImagenProducto VARCHAR(150) NULL --si
			,IdMarca TINYINT NULL --si
			,Activo BIT NULL
			,UsuarioCreacion VARCHAR(30) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(30) NULL --si
			,FechaModificacion DATETIME NULL --si
			,OfertaShowRoomDetalleID INT --si
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
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
				SELECT OfertaShowRoomDetalleID
				FROM dbo.EstrategiaProducto
				WHERE OfertaShowRoomDetalleID IS NOT NULL
				);

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
		SELECT EstrategiaProductoId
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
		--WITH PosibleMigration as ( select * from @Temp_Estrategia)
		SELECT osr.*
		FROM ShowRoom.OfertaShowRoom osr
		INNER JOIN ods.Campania c ON osr.CampaniaID = c.CampaniaID
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON osr.TipoOfertaSisID = ves.TipoOfertaSisID
		INNER JOIN @Campanias_Table cm ON c.Codigo = cm.value
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM @Temp_Estrategia
				)

		SELECT osd.*
			,e.EstrategiaID
		FROM ShowRoom.OfertaShowRoomDetalle osd
		INNER JOIN @Temp_Estrategia e ON osd.CUV = e.CUV2
		INNER JOIN ods.Campania c ON osd.CampaniaID = c.Codigo
			AND e.CampaniaId = c.Codigo
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
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
END

GO

USE BelcorpVenezuela
GO

/*Insert into new table, event Id(OfertaShowRoomID, OfertaShowRoomDetalleID)
If id is register do not register Again ( prevent double migration)
*/
IF (OBJECT_ID('dbo.MigracionShowRoom_Estrategia', 'P') IS NOT NULL)
	EXEC ('DROP PROCEDURE dbo.MigracionShowRoom_Estrategia')
GO

CREATE PROCEDURE MigracionShowRoom_Estrategia (@Campanias VARCHAR(250))
AS
--MigracionShowRoom_Estrategia '201801,201802'
BEGIN
	BEGIN TRANSACTION Migracion_showRoom

	BEGIN TRY
		DECLARE @Campanias_Table TABLE (value VARCHAR(25));

		INSERT INTO @Campanias_Table (value)
		SELECT *
		FROM fnSplitString(@Campanias, ',');

		/*Productos Show Room por migrar*/
		DECLARE @MaxEstrategiaID INT;

		SELECT @MaxEstrategiaID = max(EstrategiaID)
		FROM Estrategia;

		DECLARE @Temp_Estrategia TABLE (
			EstrategiaID INT NOT NULL --si
			,TipoEstrategiaID INT NOT NULL --si
			,CampaniaID INT NOT NULL --si
			,Activo BIT NULL --si
			,ImagenURL VARCHAR(800) NULL --si
			,LimiteVenta INT NULL --si
			,DescripcionCUV2 VARCHAR(800) NULL --si
			--,CUV varchar(20) NULL
			,EtiquetaID INT NOT NULL --si
			,Precio NUMERIC(12, 2) NULL --si
			--,FlagCEP bit NULL
			,CUV2 VARCHAR(20) NULL --si
			,EtiquetaID2 INT NOT NULL --si
			,Precio2 NUMERIC(12, 2) NULL --si
			,FlagCEP2 BIT NULL
			,TextoLibre VARCHAR(800) NULL --si
			,FlagTextoLibre BIT NULL
			,Cantidad INT NULL --si
			,FlagCantidad BIT NULL
			,Zona VARCHAR(8000) NULL
			,Limite INT NULL
			,Orden INT NULL --si
			,UsuarioCreacion VARCHAR(100) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(100) NULL --si
			,FechaModificacion DATETIME NULL --si
			,ColorFondo VARCHAR(20) NULL
			,FlagEstrella BIT NULL
			,CodigoEstrategia VARCHAR(100) NULL --si
			,TieneVariedad INT NULL
			,EsOfertaIndependiente BIT NULL
			,PrecioPublico DECIMAL(18, 2) NOT NULL --si
			,Ganancia DECIMAL(18, 2) NOT NULL --si
			,CodigoPrograma VARCHAR(3) NULL
			,CodigoConcurso VARCHAR(6) NULL
			,ImagenMiniaturaURL VARCHAR(200) NULL --si
			,EsSubCampania BIT NULL --si
			,OfertaShowRoomID INT --si
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
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM dbo.Estrategia
				WHERE OfertaShowRoomID IS NOT NULL
				);

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
		SELECT EstrategiaID
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
			EstrategiaProductoId INT NOT NULL --si
			,EstrategiaId INT NOT NULL --si
			,Campania INT NOT NULL --si
			,CUV NVARCHAR(20) NOT NULL --si
			,CodigoEstrategia NVARCHAR(100) NOT NULL --si
			,Grupo NVARCHAR(20) NULL
			,Orden INT NULL --si
			,CUV2 NVARCHAR(20) NULL
			,SAP NVARCHAR(50) NULL --si
			,Cantidad INT NULL
			,Precio MONEY NULL
			,PrecioValorizado MONEY NULL
			,Digitable INT NULL
			,CodigoError NVARCHAR(100) NULL
			,CodigoErrorObs NVARCHAR(4000) NULL
			,FactorCuadre INT NULL
			,NombreProducto VARCHAR(150) NULL --si
			,Descripcion1 VARCHAR(255) NULL --si
			,ImagenProducto VARCHAR(150) NULL --si
			,IdMarca TINYINT NULL --si
			,Activo BIT NULL
			,UsuarioCreacion VARCHAR(30) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(30) NULL --si
			,FechaModificacion DATETIME NULL --si
			,OfertaShowRoomDetalleID INT --si
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
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
				SELECT OfertaShowRoomDetalleID
				FROM dbo.EstrategiaProducto
				WHERE OfertaShowRoomDetalleID IS NOT NULL
				);

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
		SELECT EstrategiaProductoId
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
		--WITH PosibleMigration as ( select * from @Temp_Estrategia)
		SELECT osr.*
		FROM ShowRoom.OfertaShowRoom osr
		INNER JOIN ods.Campania c ON osr.CampaniaID = c.CampaniaID
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON osr.TipoOfertaSisID = ves.TipoOfertaSisID
		INNER JOIN @Campanias_Table cm ON c.Codigo = cm.value
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM @Temp_Estrategia
				)

		SELECT osd.*
			,e.EstrategiaID
		FROM ShowRoom.OfertaShowRoomDetalle osd
		INNER JOIN @Temp_Estrategia e ON osd.CUV = e.CUV2
		INNER JOIN ods.Campania c ON osd.CampaniaID = c.Codigo
			AND e.CampaniaId = c.Codigo
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
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
END

GO

USE BelcorpSalvador
GO

/*Insert into new table, event Id(OfertaShowRoomID, OfertaShowRoomDetalleID)
If id is register do not register Again ( prevent double migration)
*/
IF (OBJECT_ID('dbo.MigracionShowRoom_Estrategia', 'P') IS NOT NULL)
	EXEC ('DROP PROCEDURE dbo.MigracionShowRoom_Estrategia')
GO

CREATE PROCEDURE MigracionShowRoom_Estrategia (@Campanias VARCHAR(250))
AS
--MigracionShowRoom_Estrategia '201801,201802'
BEGIN
	BEGIN TRANSACTION Migracion_showRoom

	BEGIN TRY
		DECLARE @Campanias_Table TABLE (value VARCHAR(25));

		INSERT INTO @Campanias_Table (value)
		SELECT *
		FROM fnSplitString(@Campanias, ',');

		/*Productos Show Room por migrar*/
		DECLARE @MaxEstrategiaID INT;

		SELECT @MaxEstrategiaID = max(EstrategiaID)
		FROM Estrategia;

		DECLARE @Temp_Estrategia TABLE (
			EstrategiaID INT NOT NULL --si
			,TipoEstrategiaID INT NOT NULL --si
			,CampaniaID INT NOT NULL --si
			,Activo BIT NULL --si
			,ImagenURL VARCHAR(800) NULL --si
			,LimiteVenta INT NULL --si
			,DescripcionCUV2 VARCHAR(800) NULL --si
			--,CUV varchar(20) NULL
			,EtiquetaID INT NOT NULL --si
			,Precio NUMERIC(12, 2) NULL --si
			--,FlagCEP bit NULL
			,CUV2 VARCHAR(20) NULL --si
			,EtiquetaID2 INT NOT NULL --si
			,Precio2 NUMERIC(12, 2) NULL --si
			,FlagCEP2 BIT NULL
			,TextoLibre VARCHAR(800) NULL --si
			,FlagTextoLibre BIT NULL
			,Cantidad INT NULL --si
			,FlagCantidad BIT NULL
			,Zona VARCHAR(8000) NULL
			,Limite INT NULL
			,Orden INT NULL --si
			,UsuarioCreacion VARCHAR(100) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(100) NULL --si
			,FechaModificacion DATETIME NULL --si
			,ColorFondo VARCHAR(20) NULL
			,FlagEstrella BIT NULL
			,CodigoEstrategia VARCHAR(100) NULL --si
			,TieneVariedad INT NULL
			,EsOfertaIndependiente BIT NULL
			,PrecioPublico DECIMAL(18, 2) NOT NULL --si
			,Ganancia DECIMAL(18, 2) NOT NULL --si
			,CodigoPrograma VARCHAR(3) NULL
			,CodigoConcurso VARCHAR(6) NULL
			,ImagenMiniaturaURL VARCHAR(200) NULL --si
			,EsSubCampania BIT NULL --si
			,OfertaShowRoomID INT --si
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
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM dbo.Estrategia
				WHERE OfertaShowRoomID IS NOT NULL
				);

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
		SELECT EstrategiaID
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
			EstrategiaProductoId INT NOT NULL --si
			,EstrategiaId INT NOT NULL --si
			,Campania INT NOT NULL --si
			,CUV NVARCHAR(20) NOT NULL --si
			,CodigoEstrategia NVARCHAR(100) NOT NULL --si
			,Grupo NVARCHAR(20) NULL
			,Orden INT NULL --si
			,CUV2 NVARCHAR(20) NULL
			,SAP NVARCHAR(50) NULL --si
			,Cantidad INT NULL
			,Precio MONEY NULL
			,PrecioValorizado MONEY NULL
			,Digitable INT NULL
			,CodigoError NVARCHAR(100) NULL
			,CodigoErrorObs NVARCHAR(4000) NULL
			,FactorCuadre INT NULL
			,NombreProducto VARCHAR(150) NULL --si
			,Descripcion1 VARCHAR(255) NULL --si
			,ImagenProducto VARCHAR(150) NULL --si
			,IdMarca TINYINT NULL --si
			,Activo BIT NULL
			,UsuarioCreacion VARCHAR(30) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(30) NULL --si
			,FechaModificacion DATETIME NULL --si
			,OfertaShowRoomDetalleID INT --si
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
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
				SELECT OfertaShowRoomDetalleID
				FROM dbo.EstrategiaProducto
				WHERE OfertaShowRoomDetalleID IS NOT NULL
				);

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
		SELECT EstrategiaProductoId
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
		--WITH PosibleMigration as ( select * from @Temp_Estrategia)
		SELECT osr.*
		FROM ShowRoom.OfertaShowRoom osr
		INNER JOIN ods.Campania c ON osr.CampaniaID = c.CampaniaID
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON osr.TipoOfertaSisID = ves.TipoOfertaSisID
		INNER JOIN @Campanias_Table cm ON c.Codigo = cm.value
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM @Temp_Estrategia
				)

		SELECT osd.*
			,e.EstrategiaID
		FROM ShowRoom.OfertaShowRoomDetalle osd
		INNER JOIN @Temp_Estrategia e ON osd.CUV = e.CUV2
		INNER JOIN ods.Campania c ON osd.CampaniaID = c.Codigo
			AND e.CampaniaId = c.Codigo
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
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
END

GO

USE BelcorpPuertoRico
GO

/*Insert into new table, event Id(OfertaShowRoomID, OfertaShowRoomDetalleID)
If id is register do not register Again ( prevent double migration)
*/
IF (OBJECT_ID('dbo.MigracionShowRoom_Estrategia', 'P') IS NOT NULL)
	EXEC ('DROP PROCEDURE dbo.MigracionShowRoom_Estrategia')
GO

CREATE PROCEDURE MigracionShowRoom_Estrategia (@Campanias VARCHAR(250))
AS
--MigracionShowRoom_Estrategia '201801,201802'
BEGIN
	BEGIN TRANSACTION Migracion_showRoom

	BEGIN TRY
		DECLARE @Campanias_Table TABLE (value VARCHAR(25));

		INSERT INTO @Campanias_Table (value)
		SELECT *
		FROM fnSplitString(@Campanias, ',');

		/*Productos Show Room por migrar*/
		DECLARE @MaxEstrategiaID INT;

		SELECT @MaxEstrategiaID = max(EstrategiaID)
		FROM Estrategia;

		DECLARE @Temp_Estrategia TABLE (
			EstrategiaID INT NOT NULL --si
			,TipoEstrategiaID INT NOT NULL --si
			,CampaniaID INT NOT NULL --si
			,Activo BIT NULL --si
			,ImagenURL VARCHAR(800) NULL --si
			,LimiteVenta INT NULL --si
			,DescripcionCUV2 VARCHAR(800) NULL --si
			--,CUV varchar(20) NULL
			,EtiquetaID INT NOT NULL --si
			,Precio NUMERIC(12, 2) NULL --si
			--,FlagCEP bit NULL
			,CUV2 VARCHAR(20) NULL --si
			,EtiquetaID2 INT NOT NULL --si
			,Precio2 NUMERIC(12, 2) NULL --si
			,FlagCEP2 BIT NULL
			,TextoLibre VARCHAR(800) NULL --si
			,FlagTextoLibre BIT NULL
			,Cantidad INT NULL --si
			,FlagCantidad BIT NULL
			,Zona VARCHAR(8000) NULL
			,Limite INT NULL
			,Orden INT NULL --si
			,UsuarioCreacion VARCHAR(100) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(100) NULL --si
			,FechaModificacion DATETIME NULL --si
			,ColorFondo VARCHAR(20) NULL
			,FlagEstrella BIT NULL
			,CodigoEstrategia VARCHAR(100) NULL --si
			,TieneVariedad INT NULL
			,EsOfertaIndependiente BIT NULL
			,PrecioPublico DECIMAL(18, 2) NOT NULL --si
			,Ganancia DECIMAL(18, 2) NOT NULL --si
			,CodigoPrograma VARCHAR(3) NULL
			,CodigoConcurso VARCHAR(6) NULL
			,ImagenMiniaturaURL VARCHAR(200) NULL --si
			,EsSubCampania BIT NULL --si
			,OfertaShowRoomID INT --si
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
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM dbo.Estrategia
				WHERE OfertaShowRoomID IS NOT NULL
				);

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
		SELECT EstrategiaID
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
			EstrategiaProductoId INT NOT NULL --si
			,EstrategiaId INT NOT NULL --si
			,Campania INT NOT NULL --si
			,CUV NVARCHAR(20) NOT NULL --si
			,CodigoEstrategia NVARCHAR(100) NOT NULL --si
			,Grupo NVARCHAR(20) NULL
			,Orden INT NULL --si
			,CUV2 NVARCHAR(20) NULL
			,SAP NVARCHAR(50) NULL --si
			,Cantidad INT NULL
			,Precio MONEY NULL
			,PrecioValorizado MONEY NULL
			,Digitable INT NULL
			,CodigoError NVARCHAR(100) NULL
			,CodigoErrorObs NVARCHAR(4000) NULL
			,FactorCuadre INT NULL
			,NombreProducto VARCHAR(150) NULL --si
			,Descripcion1 VARCHAR(255) NULL --si
			,ImagenProducto VARCHAR(150) NULL --si
			,IdMarca TINYINT NULL --si
			,Activo BIT NULL
			,UsuarioCreacion VARCHAR(30) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(30) NULL --si
			,FechaModificacion DATETIME NULL --si
			,OfertaShowRoomDetalleID INT --si
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
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
				SELECT OfertaShowRoomDetalleID
				FROM dbo.EstrategiaProducto
				WHERE OfertaShowRoomDetalleID IS NOT NULL
				);

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
		SELECT EstrategiaProductoId
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
		--WITH PosibleMigration as ( select * from @Temp_Estrategia)
		SELECT osr.*
		FROM ShowRoom.OfertaShowRoom osr
		INNER JOIN ods.Campania c ON osr.CampaniaID = c.CampaniaID
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON osr.TipoOfertaSisID = ves.TipoOfertaSisID
		INNER JOIN @Campanias_Table cm ON c.Codigo = cm.value
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM @Temp_Estrategia
				)

		SELECT osd.*
			,e.EstrategiaID
		FROM ShowRoom.OfertaShowRoomDetalle osd
		INNER JOIN @Temp_Estrategia e ON osd.CUV = e.CUV2
		INNER JOIN ods.Campania c ON osd.CampaniaID = c.Codigo
			AND e.CampaniaId = c.Codigo
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
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
END

GO

USE BelcorpPanama
GO

/*Insert into new table, event Id(OfertaShowRoomID, OfertaShowRoomDetalleID)
If id is register do not register Again ( prevent double migration)
*/
IF (OBJECT_ID('dbo.MigracionShowRoom_Estrategia', 'P') IS NOT NULL)
	EXEC ('DROP PROCEDURE dbo.MigracionShowRoom_Estrategia')
GO

CREATE PROCEDURE MigracionShowRoom_Estrategia (@Campanias VARCHAR(250))
AS
--MigracionShowRoom_Estrategia '201801,201802'
BEGIN
	BEGIN TRANSACTION Migracion_showRoom

	BEGIN TRY
		DECLARE @Campanias_Table TABLE (value VARCHAR(25));

		INSERT INTO @Campanias_Table (value)
		SELECT *
		FROM fnSplitString(@Campanias, ',');

		/*Productos Show Room por migrar*/
		DECLARE @MaxEstrategiaID INT;

		SELECT @MaxEstrategiaID = max(EstrategiaID)
		FROM Estrategia;

		DECLARE @Temp_Estrategia TABLE (
			EstrategiaID INT NOT NULL --si
			,TipoEstrategiaID INT NOT NULL --si
			,CampaniaID INT NOT NULL --si
			,Activo BIT NULL --si
			,ImagenURL VARCHAR(800) NULL --si
			,LimiteVenta INT NULL --si
			,DescripcionCUV2 VARCHAR(800) NULL --si
			--,CUV varchar(20) NULL
			,EtiquetaID INT NOT NULL --si
			,Precio NUMERIC(12, 2) NULL --si
			--,FlagCEP bit NULL
			,CUV2 VARCHAR(20) NULL --si
			,EtiquetaID2 INT NOT NULL --si
			,Precio2 NUMERIC(12, 2) NULL --si
			,FlagCEP2 BIT NULL
			,TextoLibre VARCHAR(800) NULL --si
			,FlagTextoLibre BIT NULL
			,Cantidad INT NULL --si
			,FlagCantidad BIT NULL
			,Zona VARCHAR(8000) NULL
			,Limite INT NULL
			,Orden INT NULL --si
			,UsuarioCreacion VARCHAR(100) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(100) NULL --si
			,FechaModificacion DATETIME NULL --si
			,ColorFondo VARCHAR(20) NULL
			,FlagEstrella BIT NULL
			,CodigoEstrategia VARCHAR(100) NULL --si
			,TieneVariedad INT NULL
			,EsOfertaIndependiente BIT NULL
			,PrecioPublico DECIMAL(18, 2) NOT NULL --si
			,Ganancia DECIMAL(18, 2) NOT NULL --si
			,CodigoPrograma VARCHAR(3) NULL
			,CodigoConcurso VARCHAR(6) NULL
			,ImagenMiniaturaURL VARCHAR(200) NULL --si
			,EsSubCampania BIT NULL --si
			,OfertaShowRoomID INT --si
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
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM dbo.Estrategia
				WHERE OfertaShowRoomID IS NOT NULL
				);

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
		SELECT EstrategiaID
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
			EstrategiaProductoId INT NOT NULL --si
			,EstrategiaId INT NOT NULL --si
			,Campania INT NOT NULL --si
			,CUV NVARCHAR(20) NOT NULL --si
			,CodigoEstrategia NVARCHAR(100) NOT NULL --si
			,Grupo NVARCHAR(20) NULL
			,Orden INT NULL --si
			,CUV2 NVARCHAR(20) NULL
			,SAP NVARCHAR(50) NULL --si
			,Cantidad INT NULL
			,Precio MONEY NULL
			,PrecioValorizado MONEY NULL
			,Digitable INT NULL
			,CodigoError NVARCHAR(100) NULL
			,CodigoErrorObs NVARCHAR(4000) NULL
			,FactorCuadre INT NULL
			,NombreProducto VARCHAR(150) NULL --si
			,Descripcion1 VARCHAR(255) NULL --si
			,ImagenProducto VARCHAR(150) NULL --si
			,IdMarca TINYINT NULL --si
			,Activo BIT NULL
			,UsuarioCreacion VARCHAR(30) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(30) NULL --si
			,FechaModificacion DATETIME NULL --si
			,OfertaShowRoomDetalleID INT --si
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
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
				SELECT OfertaShowRoomDetalleID
				FROM dbo.EstrategiaProducto
				WHERE OfertaShowRoomDetalleID IS NOT NULL
				);

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
		SELECT EstrategiaProductoId
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
		--WITH PosibleMigration as ( select * from @Temp_Estrategia)
		SELECT osr.*
		FROM ShowRoom.OfertaShowRoom osr
		INNER JOIN ods.Campania c ON osr.CampaniaID = c.CampaniaID
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON osr.TipoOfertaSisID = ves.TipoOfertaSisID
		INNER JOIN @Campanias_Table cm ON c.Codigo = cm.value
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM @Temp_Estrategia
				)

		SELECT osd.*
			,e.EstrategiaID
		FROM ShowRoom.OfertaShowRoomDetalle osd
		INNER JOIN @Temp_Estrategia e ON osd.CUV = e.CUV2
		INNER JOIN ods.Campania c ON osd.CampaniaID = c.Codigo
			AND e.CampaniaId = c.Codigo
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
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
END

GO

USE BelcorpGuatemala
GO

/*Insert into new table, event Id(OfertaShowRoomID, OfertaShowRoomDetalleID)
If id is register do not register Again ( prevent double migration)
*/
IF (OBJECT_ID('dbo.MigracionShowRoom_Estrategia', 'P') IS NOT NULL)
	EXEC ('DROP PROCEDURE dbo.MigracionShowRoom_Estrategia')
GO

CREATE PROCEDURE MigracionShowRoom_Estrategia (@Campanias VARCHAR(250))
AS
--MigracionShowRoom_Estrategia '201801,201802'
BEGIN
	BEGIN TRANSACTION Migracion_showRoom

	BEGIN TRY
		DECLARE @Campanias_Table TABLE (value VARCHAR(25));

		INSERT INTO @Campanias_Table (value)
		SELECT *
		FROM fnSplitString(@Campanias, ',');

		/*Productos Show Room por migrar*/
		DECLARE @MaxEstrategiaID INT;

		SELECT @MaxEstrategiaID = max(EstrategiaID)
		FROM Estrategia;

		DECLARE @Temp_Estrategia TABLE (
			EstrategiaID INT NOT NULL --si
			,TipoEstrategiaID INT NOT NULL --si
			,CampaniaID INT NOT NULL --si
			,Activo BIT NULL --si
			,ImagenURL VARCHAR(800) NULL --si
			,LimiteVenta INT NULL --si
			,DescripcionCUV2 VARCHAR(800) NULL --si
			--,CUV varchar(20) NULL
			,EtiquetaID INT NOT NULL --si
			,Precio NUMERIC(12, 2) NULL --si
			--,FlagCEP bit NULL
			,CUV2 VARCHAR(20) NULL --si
			,EtiquetaID2 INT NOT NULL --si
			,Precio2 NUMERIC(12, 2) NULL --si
			,FlagCEP2 BIT NULL
			,TextoLibre VARCHAR(800) NULL --si
			,FlagTextoLibre BIT NULL
			,Cantidad INT NULL --si
			,FlagCantidad BIT NULL
			,Zona VARCHAR(8000) NULL
			,Limite INT NULL
			,Orden INT NULL --si
			,UsuarioCreacion VARCHAR(100) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(100) NULL --si
			,FechaModificacion DATETIME NULL --si
			,ColorFondo VARCHAR(20) NULL
			,FlagEstrella BIT NULL
			,CodigoEstrategia VARCHAR(100) NULL --si
			,TieneVariedad INT NULL
			,EsOfertaIndependiente BIT NULL
			,PrecioPublico DECIMAL(18, 2) NOT NULL --si
			,Ganancia DECIMAL(18, 2) NOT NULL --si
			,CodigoPrograma VARCHAR(3) NULL
			,CodigoConcurso VARCHAR(6) NULL
			,ImagenMiniaturaURL VARCHAR(200) NULL --si
			,EsSubCampania BIT NULL --si
			,OfertaShowRoomID INT --si
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
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM dbo.Estrategia
				WHERE OfertaShowRoomID IS NOT NULL
				);

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
		SELECT EstrategiaID
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
			EstrategiaProductoId INT NOT NULL --si
			,EstrategiaId INT NOT NULL --si
			,Campania INT NOT NULL --si
			,CUV NVARCHAR(20) NOT NULL --si
			,CodigoEstrategia NVARCHAR(100) NOT NULL --si
			,Grupo NVARCHAR(20) NULL
			,Orden INT NULL --si
			,CUV2 NVARCHAR(20) NULL
			,SAP NVARCHAR(50) NULL --si
			,Cantidad INT NULL
			,Precio MONEY NULL
			,PrecioValorizado MONEY NULL
			,Digitable INT NULL
			,CodigoError NVARCHAR(100) NULL
			,CodigoErrorObs NVARCHAR(4000) NULL
			,FactorCuadre INT NULL
			,NombreProducto VARCHAR(150) NULL --si
			,Descripcion1 VARCHAR(255) NULL --si
			,ImagenProducto VARCHAR(150) NULL --si
			,IdMarca TINYINT NULL --si
			,Activo BIT NULL
			,UsuarioCreacion VARCHAR(30) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(30) NULL --si
			,FechaModificacion DATETIME NULL --si
			,OfertaShowRoomDetalleID INT --si
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
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
				SELECT OfertaShowRoomDetalleID
				FROM dbo.EstrategiaProducto
				WHERE OfertaShowRoomDetalleID IS NOT NULL
				);

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
		SELECT EstrategiaProductoId
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
		--WITH PosibleMigration as ( select * from @Temp_Estrategia)
		SELECT osr.*
		FROM ShowRoom.OfertaShowRoom osr
		INNER JOIN ods.Campania c ON osr.CampaniaID = c.CampaniaID
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON osr.TipoOfertaSisID = ves.TipoOfertaSisID
		INNER JOIN @Campanias_Table cm ON c.Codigo = cm.value
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM @Temp_Estrategia
				)

		SELECT osd.*
			,e.EstrategiaID
		FROM ShowRoom.OfertaShowRoomDetalle osd
		INNER JOIN @Temp_Estrategia e ON osd.CUV = e.CUV2
		INNER JOIN ods.Campania c ON osd.CampaniaID = c.Codigo
			AND e.CampaniaId = c.Codigo
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
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
END

GO

USE BelcorpEcuador
GO

/*Insert into new table, event Id(OfertaShowRoomID, OfertaShowRoomDetalleID)
If id is register do not register Again ( prevent double migration)
*/
IF (OBJECT_ID('dbo.MigracionShowRoom_Estrategia', 'P') IS NOT NULL)
	EXEC ('DROP PROCEDURE dbo.MigracionShowRoom_Estrategia')
GO

CREATE PROCEDURE MigracionShowRoom_Estrategia (@Campanias VARCHAR(250))
AS
--MigracionShowRoom_Estrategia '201801,201802'
BEGIN
	BEGIN TRANSACTION Migracion_showRoom

	BEGIN TRY
		DECLARE @Campanias_Table TABLE (value VARCHAR(25));

		INSERT INTO @Campanias_Table (value)
		SELECT *
		FROM fnSplitString(@Campanias, ',');

		/*Productos Show Room por migrar*/
		DECLARE @MaxEstrategiaID INT;

		SELECT @MaxEstrategiaID = max(EstrategiaID)
		FROM Estrategia;

		DECLARE @Temp_Estrategia TABLE (
			EstrategiaID INT NOT NULL --si
			,TipoEstrategiaID INT NOT NULL --si
			,CampaniaID INT NOT NULL --si
			,Activo BIT NULL --si
			,ImagenURL VARCHAR(800) NULL --si
			,LimiteVenta INT NULL --si
			,DescripcionCUV2 VARCHAR(800) NULL --si
			--,CUV varchar(20) NULL
			,EtiquetaID INT NOT NULL --si
			,Precio NUMERIC(12, 2) NULL --si
			--,FlagCEP bit NULL
			,CUV2 VARCHAR(20) NULL --si
			,EtiquetaID2 INT NOT NULL --si
			,Precio2 NUMERIC(12, 2) NULL --si
			,FlagCEP2 BIT NULL
			,TextoLibre VARCHAR(800) NULL --si
			,FlagTextoLibre BIT NULL
			,Cantidad INT NULL --si
			,FlagCantidad BIT NULL
			,Zona VARCHAR(8000) NULL
			,Limite INT NULL
			,Orden INT NULL --si
			,UsuarioCreacion VARCHAR(100) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(100) NULL --si
			,FechaModificacion DATETIME NULL --si
			,ColorFondo VARCHAR(20) NULL
			,FlagEstrella BIT NULL
			,CodigoEstrategia VARCHAR(100) NULL --si
			,TieneVariedad INT NULL
			,EsOfertaIndependiente BIT NULL
			,PrecioPublico DECIMAL(18, 2) NOT NULL --si
			,Ganancia DECIMAL(18, 2) NOT NULL --si
			,CodigoPrograma VARCHAR(3) NULL
			,CodigoConcurso VARCHAR(6) NULL
			,ImagenMiniaturaURL VARCHAR(200) NULL --si
			,EsSubCampania BIT NULL --si
			,OfertaShowRoomID INT --si
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
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM dbo.Estrategia
				WHERE OfertaShowRoomID IS NOT NULL
				);

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
		SELECT EstrategiaID
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
			EstrategiaProductoId INT NOT NULL --si
			,EstrategiaId INT NOT NULL --si
			,Campania INT NOT NULL --si
			,CUV NVARCHAR(20) NOT NULL --si
			,CodigoEstrategia NVARCHAR(100) NOT NULL --si
			,Grupo NVARCHAR(20) NULL
			,Orden INT NULL --si
			,CUV2 NVARCHAR(20) NULL
			,SAP NVARCHAR(50) NULL --si
			,Cantidad INT NULL
			,Precio MONEY NULL
			,PrecioValorizado MONEY NULL
			,Digitable INT NULL
			,CodigoError NVARCHAR(100) NULL
			,CodigoErrorObs NVARCHAR(4000) NULL
			,FactorCuadre INT NULL
			,NombreProducto VARCHAR(150) NULL --si
			,Descripcion1 VARCHAR(255) NULL --si
			,ImagenProducto VARCHAR(150) NULL --si
			,IdMarca TINYINT NULL --si
			,Activo BIT NULL
			,UsuarioCreacion VARCHAR(30) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(30) NULL --si
			,FechaModificacion DATETIME NULL --si
			,OfertaShowRoomDetalleID INT --si
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
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
				SELECT OfertaShowRoomDetalleID
				FROM dbo.EstrategiaProducto
				WHERE OfertaShowRoomDetalleID IS NOT NULL
				);

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
		SELECT EstrategiaProductoId
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
		--WITH PosibleMigration as ( select * from @Temp_Estrategia)
		SELECT osr.*
		FROM ShowRoom.OfertaShowRoom osr
		INNER JOIN ods.Campania c ON osr.CampaniaID = c.CampaniaID
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON osr.TipoOfertaSisID = ves.TipoOfertaSisID
		INNER JOIN @Campanias_Table cm ON c.Codigo = cm.value
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM @Temp_Estrategia
				)

		SELECT osd.*
			,e.EstrategiaID
		FROM ShowRoom.OfertaShowRoomDetalle osd
		INNER JOIN @Temp_Estrategia e ON osd.CUV = e.CUV2
		INNER JOIN ods.Campania c ON osd.CampaniaID = c.Codigo
			AND e.CampaniaId = c.Codigo
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
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
END

GO

USE BelcorpDominicana
GO

/*Insert into new table, event Id(OfertaShowRoomID, OfertaShowRoomDetalleID)
If id is register do not register Again ( prevent double migration)
*/
IF (OBJECT_ID('dbo.MigracionShowRoom_Estrategia', 'P') IS NOT NULL)
	EXEC ('DROP PROCEDURE dbo.MigracionShowRoom_Estrategia')
GO

CREATE PROCEDURE MigracionShowRoom_Estrategia (@Campanias VARCHAR(250))
AS
--MigracionShowRoom_Estrategia '201801,201802'
BEGIN
	BEGIN TRANSACTION Migracion_showRoom

	BEGIN TRY
		DECLARE @Campanias_Table TABLE (value VARCHAR(25));

		INSERT INTO @Campanias_Table (value)
		SELECT *
		FROM fnSplitString(@Campanias, ',');

		/*Productos Show Room por migrar*/
		DECLARE @MaxEstrategiaID INT;

		SELECT @MaxEstrategiaID = max(EstrategiaID)
		FROM Estrategia;

		DECLARE @Temp_Estrategia TABLE (
			EstrategiaID INT NOT NULL --si
			,TipoEstrategiaID INT NOT NULL --si
			,CampaniaID INT NOT NULL --si
			,Activo BIT NULL --si
			,ImagenURL VARCHAR(800) NULL --si
			,LimiteVenta INT NULL --si
			,DescripcionCUV2 VARCHAR(800) NULL --si
			--,CUV varchar(20) NULL
			,EtiquetaID INT NOT NULL --si
			,Precio NUMERIC(12, 2) NULL --si
			--,FlagCEP bit NULL
			,CUV2 VARCHAR(20) NULL --si
			,EtiquetaID2 INT NOT NULL --si
			,Precio2 NUMERIC(12, 2) NULL --si
			,FlagCEP2 BIT NULL
			,TextoLibre VARCHAR(800) NULL --si
			,FlagTextoLibre BIT NULL
			,Cantidad INT NULL --si
			,FlagCantidad BIT NULL
			,Zona VARCHAR(8000) NULL
			,Limite INT NULL
			,Orden INT NULL --si
			,UsuarioCreacion VARCHAR(100) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(100) NULL --si
			,FechaModificacion DATETIME NULL --si
			,ColorFondo VARCHAR(20) NULL
			,FlagEstrella BIT NULL
			,CodigoEstrategia VARCHAR(100) NULL --si
			,TieneVariedad INT NULL
			,EsOfertaIndependiente BIT NULL
			,PrecioPublico DECIMAL(18, 2) NOT NULL --si
			,Ganancia DECIMAL(18, 2) NOT NULL --si
			,CodigoPrograma VARCHAR(3) NULL
			,CodigoConcurso VARCHAR(6) NULL
			,ImagenMiniaturaURL VARCHAR(200) NULL --si
			,EsSubCampania BIT NULL --si
			,OfertaShowRoomID INT --si
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
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM dbo.Estrategia
				WHERE OfertaShowRoomID IS NOT NULL
				);

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
		SELECT EstrategiaID
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
			EstrategiaProductoId INT NOT NULL --si
			,EstrategiaId INT NOT NULL --si
			,Campania INT NOT NULL --si
			,CUV NVARCHAR(20) NOT NULL --si
			,CodigoEstrategia NVARCHAR(100) NOT NULL --si
			,Grupo NVARCHAR(20) NULL
			,Orden INT NULL --si
			,CUV2 NVARCHAR(20) NULL
			,SAP NVARCHAR(50) NULL --si
			,Cantidad INT NULL
			,Precio MONEY NULL
			,PrecioValorizado MONEY NULL
			,Digitable INT NULL
			,CodigoError NVARCHAR(100) NULL
			,CodigoErrorObs NVARCHAR(4000) NULL
			,FactorCuadre INT NULL
			,NombreProducto VARCHAR(150) NULL --si
			,Descripcion1 VARCHAR(255) NULL --si
			,ImagenProducto VARCHAR(150) NULL --si
			,IdMarca TINYINT NULL --si
			,Activo BIT NULL
			,UsuarioCreacion VARCHAR(30) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(30) NULL --si
			,FechaModificacion DATETIME NULL --si
			,OfertaShowRoomDetalleID INT --si
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
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
				SELECT OfertaShowRoomDetalleID
				FROM dbo.EstrategiaProducto
				WHERE OfertaShowRoomDetalleID IS NOT NULL
				);

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
		SELECT EstrategiaProductoId
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
		--WITH PosibleMigration as ( select * from @Temp_Estrategia)
		SELECT osr.*
		FROM ShowRoom.OfertaShowRoom osr
		INNER JOIN ods.Campania c ON osr.CampaniaID = c.CampaniaID
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON osr.TipoOfertaSisID = ves.TipoOfertaSisID
		INNER JOIN @Campanias_Table cm ON c.Codigo = cm.value
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM @Temp_Estrategia
				)

		SELECT osd.*
			,e.EstrategiaID
		FROM ShowRoom.OfertaShowRoomDetalle osd
		INNER JOIN @Temp_Estrategia e ON osd.CUV = e.CUV2
		INNER JOIN ods.Campania c ON osd.CampaniaID = c.Codigo
			AND e.CampaniaId = c.Codigo
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
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
END

GO

USE BelcorpCostaRica
GO

/*Insert into new table, event Id(OfertaShowRoomID, OfertaShowRoomDetalleID)
If id is register do not register Again ( prevent double migration)
*/
IF (OBJECT_ID('dbo.MigracionShowRoom_Estrategia', 'P') IS NOT NULL)
	EXEC ('DROP PROCEDURE dbo.MigracionShowRoom_Estrategia')
GO

CREATE PROCEDURE MigracionShowRoom_Estrategia (@Campanias VARCHAR(250))
AS
--MigracionShowRoom_Estrategia '201801,201802'
BEGIN
	BEGIN TRANSACTION Migracion_showRoom

	BEGIN TRY
		DECLARE @Campanias_Table TABLE (value VARCHAR(25));

		INSERT INTO @Campanias_Table (value)
		SELECT *
		FROM fnSplitString(@Campanias, ',');

		/*Productos Show Room por migrar*/
		DECLARE @MaxEstrategiaID INT;

		SELECT @MaxEstrategiaID = max(EstrategiaID)
		FROM Estrategia;

		DECLARE @Temp_Estrategia TABLE (
			EstrategiaID INT NOT NULL --si
			,TipoEstrategiaID INT NOT NULL --si
			,CampaniaID INT NOT NULL --si
			,Activo BIT NULL --si
			,ImagenURL VARCHAR(800) NULL --si
			,LimiteVenta INT NULL --si
			,DescripcionCUV2 VARCHAR(800) NULL --si
			--,CUV varchar(20) NULL
			,EtiquetaID INT NOT NULL --si
			,Precio NUMERIC(12, 2) NULL --si
			--,FlagCEP bit NULL
			,CUV2 VARCHAR(20) NULL --si
			,EtiquetaID2 INT NOT NULL --si
			,Precio2 NUMERIC(12, 2) NULL --si
			,FlagCEP2 BIT NULL
			,TextoLibre VARCHAR(800) NULL --si
			,FlagTextoLibre BIT NULL
			,Cantidad INT NULL --si
			,FlagCantidad BIT NULL
			,Zona VARCHAR(8000) NULL
			,Limite INT NULL
			,Orden INT NULL --si
			,UsuarioCreacion VARCHAR(100) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(100) NULL --si
			,FechaModificacion DATETIME NULL --si
			,ColorFondo VARCHAR(20) NULL
			,FlagEstrella BIT NULL
			,CodigoEstrategia VARCHAR(100) NULL --si
			,TieneVariedad INT NULL
			,EsOfertaIndependiente BIT NULL
			,PrecioPublico DECIMAL(18, 2) NOT NULL --si
			,Ganancia DECIMAL(18, 2) NOT NULL --si
			,CodigoPrograma VARCHAR(3) NULL
			,CodigoConcurso VARCHAR(6) NULL
			,ImagenMiniaturaURL VARCHAR(200) NULL --si
			,EsSubCampania BIT NULL --si
			,OfertaShowRoomID INT --si
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
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM dbo.Estrategia
				WHERE OfertaShowRoomID IS NOT NULL
				);

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
		SELECT EstrategiaID
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
			EstrategiaProductoId INT NOT NULL --si
			,EstrategiaId INT NOT NULL --si
			,Campania INT NOT NULL --si
			,CUV NVARCHAR(20) NOT NULL --si
			,CodigoEstrategia NVARCHAR(100) NOT NULL --si
			,Grupo NVARCHAR(20) NULL
			,Orden INT NULL --si
			,CUV2 NVARCHAR(20) NULL
			,SAP NVARCHAR(50) NULL --si
			,Cantidad INT NULL
			,Precio MONEY NULL
			,PrecioValorizado MONEY NULL
			,Digitable INT NULL
			,CodigoError NVARCHAR(100) NULL
			,CodigoErrorObs NVARCHAR(4000) NULL
			,FactorCuadre INT NULL
			,NombreProducto VARCHAR(150) NULL --si
			,Descripcion1 VARCHAR(255) NULL --si
			,ImagenProducto VARCHAR(150) NULL --si
			,IdMarca TINYINT NULL --si
			,Activo BIT NULL
			,UsuarioCreacion VARCHAR(30) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(30) NULL --si
			,FechaModificacion DATETIME NULL --si
			,OfertaShowRoomDetalleID INT --si
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
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
				SELECT OfertaShowRoomDetalleID
				FROM dbo.EstrategiaProducto
				WHERE OfertaShowRoomDetalleID IS NOT NULL
				);

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
		SELECT EstrategiaProductoId
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
		--WITH PosibleMigration as ( select * from @Temp_Estrategia)
		SELECT osr.*
		FROM ShowRoom.OfertaShowRoom osr
		INNER JOIN ods.Campania c ON osr.CampaniaID = c.CampaniaID
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON osr.TipoOfertaSisID = ves.TipoOfertaSisID
		INNER JOIN @Campanias_Table cm ON c.Codigo = cm.value
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM @Temp_Estrategia
				)

		SELECT osd.*
			,e.EstrategiaID
		FROM ShowRoom.OfertaShowRoomDetalle osd
		INNER JOIN @Temp_Estrategia e ON osd.CUV = e.CUV2
		INNER JOIN ods.Campania c ON osd.CampaniaID = c.Codigo
			AND e.CampaniaId = c.Codigo
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
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
END

GO

USE BelcorpChile
GO

/*Insert into new table, event Id(OfertaShowRoomID, OfertaShowRoomDetalleID)
If id is register do not register Again ( prevent double migration)
*/
IF (OBJECT_ID('dbo.MigracionShowRoom_Estrategia', 'P') IS NOT NULL)
	EXEC ('DROP PROCEDURE dbo.MigracionShowRoom_Estrategia')
GO

CREATE PROCEDURE MigracionShowRoom_Estrategia (@Campanias VARCHAR(250))
AS
--MigracionShowRoom_Estrategia '201801,201802'
BEGIN
	BEGIN TRANSACTION Migracion_showRoom

	BEGIN TRY
		DECLARE @Campanias_Table TABLE (value VARCHAR(25));

		INSERT INTO @Campanias_Table (value)
		SELECT *
		FROM fnSplitString(@Campanias, ',');

		/*Productos Show Room por migrar*/
		DECLARE @MaxEstrategiaID INT;

		SELECT @MaxEstrategiaID = max(EstrategiaID)
		FROM Estrategia;

		DECLARE @Temp_Estrategia TABLE (
			EstrategiaID INT NOT NULL --si
			,TipoEstrategiaID INT NOT NULL --si
			,CampaniaID INT NOT NULL --si
			,Activo BIT NULL --si
			,ImagenURL VARCHAR(800) NULL --si
			,LimiteVenta INT NULL --si
			,DescripcionCUV2 VARCHAR(800) NULL --si
			--,CUV varchar(20) NULL
			,EtiquetaID INT NOT NULL --si
			,Precio NUMERIC(12, 2) NULL --si
			--,FlagCEP bit NULL
			,CUV2 VARCHAR(20) NULL --si
			,EtiquetaID2 INT NOT NULL --si
			,Precio2 NUMERIC(12, 2) NULL --si
			,FlagCEP2 BIT NULL
			,TextoLibre VARCHAR(800) NULL --si
			,FlagTextoLibre BIT NULL
			,Cantidad INT NULL --si
			,FlagCantidad BIT NULL
			,Zona VARCHAR(8000) NULL
			,Limite INT NULL
			,Orden INT NULL --si
			,UsuarioCreacion VARCHAR(100) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(100) NULL --si
			,FechaModificacion DATETIME NULL --si
			,ColorFondo VARCHAR(20) NULL
			,FlagEstrella BIT NULL
			,CodigoEstrategia VARCHAR(100) NULL --si
			,TieneVariedad INT NULL
			,EsOfertaIndependiente BIT NULL
			,PrecioPublico DECIMAL(18, 2) NOT NULL --si
			,Ganancia DECIMAL(18, 2) NOT NULL --si
			,CodigoPrograma VARCHAR(3) NULL
			,CodigoConcurso VARCHAR(6) NULL
			,ImagenMiniaturaURL VARCHAR(200) NULL --si
			,EsSubCampania BIT NULL --si
			,OfertaShowRoomID INT --si
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
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM dbo.Estrategia
				WHERE OfertaShowRoomID IS NOT NULL
				);

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
		SELECT EstrategiaID
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
			EstrategiaProductoId INT NOT NULL --si
			,EstrategiaId INT NOT NULL --si
			,Campania INT NOT NULL --si
			,CUV NVARCHAR(20) NOT NULL --si
			,CodigoEstrategia NVARCHAR(100) NOT NULL --si
			,Grupo NVARCHAR(20) NULL
			,Orden INT NULL --si
			,CUV2 NVARCHAR(20) NULL
			,SAP NVARCHAR(50) NULL --si
			,Cantidad INT NULL
			,Precio MONEY NULL
			,PrecioValorizado MONEY NULL
			,Digitable INT NULL
			,CodigoError NVARCHAR(100) NULL
			,CodigoErrorObs NVARCHAR(4000) NULL
			,FactorCuadre INT NULL
			,NombreProducto VARCHAR(150) NULL --si
			,Descripcion1 VARCHAR(255) NULL --si
			,ImagenProducto VARCHAR(150) NULL --si
			,IdMarca TINYINT NULL --si
			,Activo BIT NULL
			,UsuarioCreacion VARCHAR(30) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(30) NULL --si
			,FechaModificacion DATETIME NULL --si
			,OfertaShowRoomDetalleID INT --si
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
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
				SELECT OfertaShowRoomDetalleID
				FROM dbo.EstrategiaProducto
				WHERE OfertaShowRoomDetalleID IS NOT NULL
				);

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
		SELECT EstrategiaProductoId
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
		--WITH PosibleMigration as ( select * from @Temp_Estrategia)
		SELECT osr.*
		FROM ShowRoom.OfertaShowRoom osr
		INNER JOIN ods.Campania c ON osr.CampaniaID = c.CampaniaID
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON osr.TipoOfertaSisID = ves.TipoOfertaSisID
		INNER JOIN @Campanias_Table cm ON c.Codigo = cm.value
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM @Temp_Estrategia
				)

		SELECT osd.*
			,e.EstrategiaID
		FROM ShowRoom.OfertaShowRoomDetalle osd
		INNER JOIN @Temp_Estrategia e ON osd.CUV = e.CUV2
		INNER JOIN ods.Campania c ON osd.CampaniaID = c.Codigo
			AND e.CampaniaId = c.Codigo
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
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
END

GO

USE BelcorpBolivia
GO

/*Insert into new table, event Id(OfertaShowRoomID, OfertaShowRoomDetalleID)
If id is register do not register Again ( prevent double migration)
*/
IF (OBJECT_ID('dbo.MigracionShowRoom_Estrategia', 'P') IS NOT NULL)
	EXEC ('DROP PROCEDURE dbo.MigracionShowRoom_Estrategia')
GO

CREATE PROCEDURE MigracionShowRoom_Estrategia (@Campanias VARCHAR(250))
AS
--MigracionShowRoom_Estrategia '201801,201802'
BEGIN
	BEGIN TRANSACTION Migracion_showRoom

	BEGIN TRY
		DECLARE @Campanias_Table TABLE (value VARCHAR(25));

		INSERT INTO @Campanias_Table (value)
		SELECT *
		FROM fnSplitString(@Campanias, ',');

		/*Productos Show Room por migrar*/
		DECLARE @MaxEstrategiaID INT;

		SELECT @MaxEstrategiaID = max(EstrategiaID)
		FROM Estrategia;

		DECLARE @Temp_Estrategia TABLE (
			EstrategiaID INT NOT NULL --si
			,TipoEstrategiaID INT NOT NULL --si
			,CampaniaID INT NOT NULL --si
			,Activo BIT NULL --si
			,ImagenURL VARCHAR(800) NULL --si
			,LimiteVenta INT NULL --si
			,DescripcionCUV2 VARCHAR(800) NULL --si
			--,CUV varchar(20) NULL
			,EtiquetaID INT NOT NULL --si
			,Precio NUMERIC(12, 2) NULL --si
			--,FlagCEP bit NULL
			,CUV2 VARCHAR(20) NULL --si
			,EtiquetaID2 INT NOT NULL --si
			,Precio2 NUMERIC(12, 2) NULL --si
			,FlagCEP2 BIT NULL
			,TextoLibre VARCHAR(800) NULL --si
			,FlagTextoLibre BIT NULL
			,Cantidad INT NULL --si
			,FlagCantidad BIT NULL
			,Zona VARCHAR(8000) NULL
			,Limite INT NULL
			,Orden INT NULL --si
			,UsuarioCreacion VARCHAR(100) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(100) NULL --si
			,FechaModificacion DATETIME NULL --si
			,ColorFondo VARCHAR(20) NULL
			,FlagEstrella BIT NULL
			,CodigoEstrategia VARCHAR(100) NULL --si
			,TieneVariedad INT NULL
			,EsOfertaIndependiente BIT NULL
			,PrecioPublico DECIMAL(18, 2) NOT NULL --si
			,Ganancia DECIMAL(18, 2) NOT NULL --si
			,CodigoPrograma VARCHAR(3) NULL
			,CodigoConcurso VARCHAR(6) NULL
			,ImagenMiniaturaURL VARCHAR(200) NULL --si
			,EsSubCampania BIT NULL --si
			,OfertaShowRoomID INT --si
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
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM dbo.Estrategia
				WHERE OfertaShowRoomID IS NOT NULL
				);

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
		SELECT EstrategiaID
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
			EstrategiaProductoId INT NOT NULL --si
			,EstrategiaId INT NOT NULL --si
			,Campania INT NOT NULL --si
			,CUV NVARCHAR(20) NOT NULL --si
			,CodigoEstrategia NVARCHAR(100) NOT NULL --si
			,Grupo NVARCHAR(20) NULL
			,Orden INT NULL --si
			,CUV2 NVARCHAR(20) NULL
			,SAP NVARCHAR(50) NULL --si
			,Cantidad INT NULL
			,Precio MONEY NULL
			,PrecioValorizado MONEY NULL
			,Digitable INT NULL
			,CodigoError NVARCHAR(100) NULL
			,CodigoErrorObs NVARCHAR(4000) NULL
			,FactorCuadre INT NULL
			,NombreProducto VARCHAR(150) NULL --si
			,Descripcion1 VARCHAR(255) NULL --si
			,ImagenProducto VARCHAR(150) NULL --si
			,IdMarca TINYINT NULL --si
			,Activo BIT NULL
			,UsuarioCreacion VARCHAR(30) NULL --si
			,FechaCreacion DATETIME NULL --si
			,UsuarioModificacion VARCHAR(30) NULL --si
			,FechaModificacion DATETIME NULL --si
			,OfertaShowRoomDetalleID INT --si
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
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
				SELECT OfertaShowRoomDetalleID
				FROM dbo.EstrategiaProducto
				WHERE OfertaShowRoomDetalleID IS NOT NULL
				);

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
		SELECT EstrategiaProductoId
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
		--WITH PosibleMigration as ( select * from @Temp_Estrategia)
		SELECT osr.*
		FROM ShowRoom.OfertaShowRoom osr
		INNER JOIN ods.Campania c ON osr.CampaniaID = c.CampaniaID
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON osr.TipoOfertaSisID = ves.TipoOfertaSisID
		INNER JOIN @Campanias_Table cm ON c.Codigo = cm.value
		WHERE osr.OfertaShowRoomID NOT IN (
				SELECT OfertaShowRoomID
				FROM @Temp_Estrategia
				)

		SELECT osd.*
			,e.EstrategiaID
		FROM ShowRoom.OfertaShowRoomDetalle osd
		INNER JOIN @Temp_Estrategia e ON osd.CUV = e.CUV2
		INNER JOIN ods.Campania c ON osd.CampaniaID = c.Codigo
			AND e.CampaniaId = c.Codigo
		WHERE osd.OfertaShowRoomDetalleID NOT IN (
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
END

GO

