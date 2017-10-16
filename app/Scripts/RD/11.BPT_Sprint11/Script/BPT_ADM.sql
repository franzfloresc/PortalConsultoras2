USE BelcorpPeru_BPT

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia ADD PrecioPublico NUMERIC (12, 2) NOT NULL CONSTRAINT CONS_Estrategia_PrecioPublico DEFAULT(0.0) 
END
GO

IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia DROP CONSTRAINT CONS_Estrategia_PrecioPublico
	ALTER TABLE Estrategia DROP COLUMN PrecioPublico
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD PrecioPublico NUMERIC (12, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_PrecioPublico DEFAULT(0.0) 
END
GO

IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE EstrategiaTemporal DROP CONSTRAINT CONS_EstrategiaTemp_PrecioPublico
	ALTER TABLE EstrategiaTemporal DROP COLUMN PrecioPublico
END
GO


ALTER PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
	@CampaniaID int,
	@TipoConfigurado int,
	@EstrategiaCodigo varchar(20) = '001'
AS
BEGIN
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int,
		ImagenURL varchar(250),
		PrecioPublico decimal(12, 2)
	)

	DECLARE @tablaCuvsOPT TABLE (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @EstrategiaCodigo 
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		ELSE 'OPT'
	END;

	INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV, ISNULL(MAX(FlagUltMinuto),0), ISNULL(MAX(LimUnidades),99)
		FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion= @EstrategiaCodigo
		GROUP BY CUV;
	
	IF @TipoConfigurado = 0
	BEGIN
		INSERT INTO @tablaResultado
		SELECT 
			t.CUV,
			COALESCE(mci.DescripcionComercial, e.DescripcionCUV2, pd.Descripcion,  p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta,
			mci.Foto
		FROM @tablaCuvsOPT t
			INNER JOIN ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			LEFT JOIN Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			LEFT JOIN dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			LEFT JOIN MatrizComercial mc on
				p.CodigoProducto = mc.CodigoSAP
			LEFT JOIN MatrizComercialImagen mci on 
				mci.IdMatrizComercial = mc.IdMatrizComercial AND 
				mci.NemoTecnico IS NOT NULL
		WHERE 
			p.AnoCampania = @CampaniaID
			
		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0,''
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	END
	ELSE IF @TipoConfigurado = 1
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(mci.DescripcionComercial, e.DescripcionCUV2, pd.Descripcion, p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta,
			mci.Foto
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		INNER JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		LEFT JOIN MatrizComercial mc on
			p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN MatrizComercialImagen mci on 
			mci.IdMatrizComercial = mc.IdMatrizComercial and 
			mci.NemoTecnico IS NOT NULL
		WHERE e.CampaniaID = @CampaniaID
	END

	ELSE
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(mci.DescripcionComercial, e.DescripcionCUV2, pd.Descripcion, p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta,
			mci.Foto
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		LEFT JOIN MatrizComercial mc on
			p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN MatrizComercialImagen mci on 
			mci.IdMatrizComercial = mc.IdMatrizComercial and 
			mci.NemoTecnico IS NOT NULL
		WHERE 
			t.CampaniaID = @CampaniaID
			and e.CUV2 is null
	END
	SELECT * FROM @tablaResultado WHERE Id in (
		SELECT min(id) FROM @tablaResultado
		group by CUV2
	)
END
GO

ALTER PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @NumeroLote INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	SELECT @NumeroLote = isnull(max(NumeroLote),0) FROM EstrategiaTemporal
	SET @NumeroLote = @NumeroLote + 1

	INSERT INTO EstrategiaTemporal 
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad,
		PrecioPublico)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad,
		PrecioPublico
	FROM @EstrategiaTemporal
END
GO

ALTER PROCEDURE [dbo].[ConsultarOfertaByCUV]

	@CampaniaID		  INT,
	@CUV2			  VARCHAR(20),
	@TipoEstrategiaID INT,
	@CUV1			  VARCHAR(20),
	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }

AS
BEGIN
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3

	SET NOCOUNT ON;

	BEGIN TRY

		IF @flag = 0 OR @flag = 2
		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC
				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			-- VALIDAR SI EL CUV EXISTE PARA EL TIPO DE OFERTA SELECCIONADO
			IF NOT EXISTS(
				SELECT 1
				FROM ODS.PRODUCTOCOMERCIAL
				WHERE
					CUV = @CUV2
					AND AnoCampania = @CampaniaID
					AND CODIGOTIPOOFERTA IN (
						SELECT CodigoOferta
						FROM TipoEstrategiaOferta TEO
						INNER JOIN Oferta O ON O.OfertaID = TEO.OfertaID
						WHERE TipoEstrategiaID = @TipoEstrategiaID
				)
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no pertenece al tipo de estrategia seleccionada.', 16, 1)
			END

			DECLARE @FlagNueva INT, @FlagRecoProduc INT, @FlagRecoPerfil INT, @FlagOferta INT
			SET @FlagOferta = -1

			SELECT @FlagNueva = FlagNueva, @FlagRecoProduc = FlagRecoProduc, @FlagRecoPerfil = FlagRecoPerfil 
			FROM TipoEstrategia 
			WHERE TipoEstrategiaID = @TipoEstrategiaID

			IF @FlagRecoProduc = '1' OR @FlagRecoPerfil = '1'

				SET @FlagOferta = 0;

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ODS.PRODUCTOCOMERCIAL PC
			INNER JOIN ODS.CAMPANIA C ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN MATRIZCOMERCIAL MC ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE
				CODIGOTIPOOFERTA IN (
					SELECT CODIGOOFERTA
					FROM TIPOESTRATEGIAOFERTA TE
					INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
					WHERE TIPOESTRATEGIAID = @TipoEstrategiaID OR 0 = @FlagOferta
				)
				AND C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;
		END

		ELSE IF @flag = 1
		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC
				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
    			WHERE C.codigo = @CampaniaID AND CUV = @CUV1
			)
			BEGIN

				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)
			END

			DECLARE @codigoSAP VARCHAR(20) = NULL;
			SELECT TOP 1 @codigoSAP = CodigoProducto
			FROM ods.ProductoComercial pc
			INNER JOIN ods.Campania c ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.Codigo = @CampaniaID AND CUV = @CUV2;

			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)
			BEGIN
			RAISERROR
					('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)

			END

			SELECT 
				PC.CUV,
				PC.Descripcion DescripcionCUV2,
				PC.PrecioUnitario, 
				'0' IdMatrizComercial,
				'' CodigoSAP,
				1 AS EnMatrizComercial
			FROM ODS.PRODUCTOCOMERCIAL PC
			INNER JOIN ODS.CAMPANIA C ON PC.CAMPANIAID = C.CampaniaID
			WHERE C.CODIGO = @CampaniaID AND PC.CodigoProducto = @codigoSAP AND PC.CUV = @CUV1;

		END

		ELSE IF @flag = 3
		BEGIN

			DECLARE @numeroTallas INT = (SELECT COUNT(1) FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2);

			IF @numeroTallas = 1

			BEGIN
				DELETE FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2
			END

			ELSE IF @numeroTallas > 1

			BEGIN

				SELECT 
					'' CUV,
					'' DescripcionCUV2,
					COUNT(1) PrecioUnitario,
					'' IdMatrizComercial,
					'' CodigoSAP
				FROM TallaColorCUV
				WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2 AND Tipo = '0';

			END

			ELSE

			BEGIN
				SELECT
					'' CUV,
					'' DescripcionCUV2,
					-1 PrecioUnitario,
					'' IdMatrizComercial,
					1 AS EnMatrizComercial,
					'' CodigoSAP;
			END

		END

		ELSE IF @flag = 4 OR @flag = 9 OR @flag = 10 OR @flag = 11
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL
			DECLARE  @codigoEstrategia VARCHAR(5) = '';
			SET @codigoEstrategia = CASE @flag 
				WHEN 4 THEN 'ODD'
				WHEN 9 THEN 'LAN'
				WHEN 10 THEN 'OPM'
				WHEN 11 THEN 'PAD'
			END

			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC
				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			/*
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.OfertasPersonalizadas EP
				WHERE tipopersonalizacion = @codigoEstrategia
				AND aniocampanaventa = @CampaniaID AND cuv = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe en la oferta personalizada.', 16, 1)
			END
			*/

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ODS.PRODUCTOCOMERCIAL PC
				INNER JOIN ODS.CAMPANIA C ON PC.CAMPANIAID = C.CAMPANIAID
				LEFT JOIN MATRIZCOMERCIAL MC ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE
				C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;
	
		END 
		ELSE IF @flag = 99
		BEGIN
			SELECT DescripcionCUV2,
				 Precio2 PrecioUnitario,
				 mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			 FROM ESTRATEGIA E
			INNER JOIN ODS.CAMPANIA C ON E.CAMPANIAID = C.Codigo
			LEFT JOIN ODS.PRODUCTOCOMERCIAL PC ON PC.CAMPANIAID = C.CAMPANIAID AND PC.CUV = E.CUV2
			LEFT JOIN MATRIZCOMERCIAL MC ON PC.CODIGOPRODUCTO = MC.CODIGOSAP	
			WHERE
				C.CODIGO = @CampaniaID AND E.CUV2 = @CUV2;
		END

	END TRY

	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END