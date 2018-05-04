USE BelcorpBolivia
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	ADD TieneProl3 BIT CONSTRAINT DF_ConfiguracionValidacion_TieneProl3 DEFAULT(0) NOT NULL;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int = 201301
as
begin
	select
		CampaniaID,
		PaisID,
		DiasAntes,
		HoraInicio,
		HoraFin,
		HoraInicioNoFacturable,
		HoraCierreNoFacturable,
		FlagNoValidados,
		ProcesoRegular,
		ProcesoDA,
		ProcesoDAPRD,
		HabilitarRestriccionHoraria,
		HorasDuracionRestriccion,
		CronogramaAutomatico,
		ContingenciaActivacionPROL,
		ValidacionAutomaticaPostActivacion,
		ValidacionInteractiva,
		MensajeValidacionInteractiva,
		TieneProl3
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado
END
GO
create table dbo.PedidoWebDetalleExplotado(
	PedidoWebDetalleExplotadoID bigint identity(1,1) primary key,
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
)

create nonclustered index IX_PedidoWebDetalleExplotado_CampaniaID_PedidoID on dbo.PedidoWebDetalleExplotado(CampaniaID, PedidoID)
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
create proc dbo.DeletePedidoWebDetalleExplotadoByPedidoID
	@CampaniaID int,
	@PedidoID int
as
begin
	delete from PedidoWebDetalleExplotado
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
create type dbo.PedidoWebDetalleExplotadoType as table(
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
);
GO
create proc dbo.InsertListPedidoWebDetalleExplotado
	@ListPedidoWebDetalleExplotado dbo.PedidoWebDetalleExplotadoType readonly
as
begin
	insert into PedidoWebDetalleExplotado(
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	)
	select
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	from @ListPedidoWebDetalleExplotado;
end
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD PedidoSapId BIGINT NOT NULL
	CONSTRAINT DF_PedidoWeb_PedidoSapId DEFAULT 0;
END
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD VersionProl TINYINT NULL;
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
create proc dbo.GetPedidoSapId
	@CampaniaID int,
	@PedidoID int
as
begin
	SELECT PedidoSapId
	FROM PedidoWeb (nolock)
	WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
create proc dbo.UpdListBackOrderPedidoWebDetalle
	@CampaniaID INT,
	@PedidoID INT,
	@ListPedidoDetalleID dbo.IdSmallintType readonly
AS
BEGIN
	update dbo.PedidoWebDetalle
	set EsBackOrder = 0
	where
		CampaniaID = @CampaniaID and
		PedidoID = @PedidoID and
		AceptoBackOrder = 0;

	if exists (select 1 from @ListPedidoDetalleID)
	begin
		update dbo.PedidoWebDetalle
		set
			EsBackOrder = 1,
			AceptoBackOrder = 0
		from dbo.PedidoWebDetalle PWD
		inner join @ListPedidoDetalleID PDI ON
			PWD.CampaniaID = @CampaniaID and
			PWD.PedidoID = @PedidoID and
			PWD.PedidoDetalleID = PDI.Id;
	end
END
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(180) NOT NULL;
GO
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name='IX_TablaLogicaDatos_TablaLogicaID')
BEGIN
	CREATE INDEX IX_TablaLogicaDatos_TablaLogicaID ON dbo.TablaLogicaDatos(TablaLogicaID);
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
/*end*/

USE BelcorpChile
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	ADD TieneProl3 BIT CONSTRAINT DF_ConfiguracionValidacion_TieneProl3 DEFAULT(0) NOT NULL;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int = 201301
as
begin
	select
		CampaniaID,
		PaisID,
		DiasAntes,
		HoraInicio,
		HoraFin,
		HoraInicioNoFacturable,
		HoraCierreNoFacturable,
		FlagNoValidados,
		ProcesoRegular,
		ProcesoDA,
		ProcesoDAPRD,
		HabilitarRestriccionHoraria,
		HorasDuracionRestriccion,
		CronogramaAutomatico,
		ContingenciaActivacionPROL,
		ValidacionAutomaticaPostActivacion,
		ValidacionInteractiva,
		MensajeValidacionInteractiva,
		TieneProl3
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado
END
GO
create table dbo.PedidoWebDetalleExplotado(
	PedidoWebDetalleExplotadoID bigint identity(1,1) primary key,
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
)

create nonclustered index IX_PedidoWebDetalleExplotado_CampaniaID_PedidoID on dbo.PedidoWebDetalleExplotado(CampaniaID, PedidoID)
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
create proc dbo.DeletePedidoWebDetalleExplotadoByPedidoID
	@CampaniaID int,
	@PedidoID int
as
begin
	delete from PedidoWebDetalleExplotado
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
create type dbo.PedidoWebDetalleExplotadoType as table(
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
);
GO
create proc dbo.InsertListPedidoWebDetalleExplotado
	@ListPedidoWebDetalleExplotado dbo.PedidoWebDetalleExplotadoType readonly
as
begin
	insert into PedidoWebDetalleExplotado(
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	)
	select
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	from @ListPedidoWebDetalleExplotado;
end
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD PedidoSapId BIGINT NOT NULL
	CONSTRAINT DF_PedidoWeb_PedidoSapId DEFAULT 0;
END
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD VersionProl TINYINT NULL;
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
create proc dbo.GetPedidoSapId
	@CampaniaID int,
	@PedidoID int
as
begin
	SELECT PedidoSapId
	FROM PedidoWeb (nolock)
	WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
create proc dbo.UpdListBackOrderPedidoWebDetalle
	@CampaniaID INT,
	@PedidoID INT,
	@ListPedidoDetalleID dbo.IdSmallintType readonly
AS
BEGIN
	update dbo.PedidoWebDetalle
	set EsBackOrder = 0
	where
		CampaniaID = @CampaniaID and
		PedidoID = @PedidoID and
		AceptoBackOrder = 0;

	if exists (select 1 from @ListPedidoDetalleID)
	begin
		update dbo.PedidoWebDetalle
		set
			EsBackOrder = 1,
			AceptoBackOrder = 0
		from dbo.PedidoWebDetalle PWD
		inner join @ListPedidoDetalleID PDI ON
			PWD.CampaniaID = @CampaniaID and
			PWD.PedidoID = @PedidoID and
			PWD.PedidoDetalleID = PDI.Id;
	end
END
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(180) NOT NULL;
GO
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name='IX_TablaLogicaDatos_TablaLogicaID')
BEGIN
	CREATE INDEX IX_TablaLogicaDatos_TablaLogicaID ON dbo.TablaLogicaDatos(TablaLogicaID);
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
/*end*/

USE BelcorpColombia
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	ADD TieneProl3 BIT CONSTRAINT DF_ConfiguracionValidacion_TieneProl3 DEFAULT(0) NOT NULL;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int = 201301
as
begin
	select
		CampaniaID,
		PaisID,
		DiasAntes,
		HoraInicio,
		HoraFin,
		HoraInicioNoFacturable,
		HoraCierreNoFacturable,
		FlagNoValidados,
		ProcesoRegular,
		ProcesoDA,
		ProcesoDAPRD,
		HabilitarRestriccionHoraria,
		HorasDuracionRestriccion,
		CronogramaAutomatico,
		ContingenciaActivacionPROL,
		ValidacionAutomaticaPostActivacion,
		ValidacionInteractiva,
		MensajeValidacionInteractiva,
		TieneProl3
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado
END
GO
create table dbo.PedidoWebDetalleExplotado(
	PedidoWebDetalleExplotadoID bigint identity(1,1) primary key,
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
)

create nonclustered index IX_PedidoWebDetalleExplotado_CampaniaID_PedidoID on dbo.PedidoWebDetalleExplotado(CampaniaID, PedidoID)
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
create proc dbo.DeletePedidoWebDetalleExplotadoByPedidoID
	@CampaniaID int,
	@PedidoID int
as
begin
	delete from PedidoWebDetalleExplotado
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
create type dbo.PedidoWebDetalleExplotadoType as table(
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
);
GO
create proc dbo.InsertListPedidoWebDetalleExplotado
	@ListPedidoWebDetalleExplotado dbo.PedidoWebDetalleExplotadoType readonly
as
begin
	insert into PedidoWebDetalleExplotado(
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	)
	select
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	from @ListPedidoWebDetalleExplotado;
end
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD PedidoSapId BIGINT NOT NULL
	CONSTRAINT DF_PedidoWeb_PedidoSapId DEFAULT 0;
END
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD VersionProl TINYINT NULL;
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
create proc dbo.GetPedidoSapId
	@CampaniaID int,
	@PedidoID int
as
begin
	SELECT PedidoSapId
	FROM PedidoWeb (nolock)
	WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
create proc dbo.UpdListBackOrderPedidoWebDetalle
	@CampaniaID INT,
	@PedidoID INT,
	@ListPedidoDetalleID dbo.IdSmallintType readonly
AS
BEGIN
	update dbo.PedidoWebDetalle
	set EsBackOrder = 0
	where
		CampaniaID = @CampaniaID and
		PedidoID = @PedidoID and
		AceptoBackOrder = 0;

	if exists (select 1 from @ListPedidoDetalleID)
	begin
		update dbo.PedidoWebDetalle
		set
			EsBackOrder = 1,
			AceptoBackOrder = 0
		from dbo.PedidoWebDetalle PWD
		inner join @ListPedidoDetalleID PDI ON
			PWD.CampaniaID = @CampaniaID and
			PWD.PedidoID = @PedidoID and
			PWD.PedidoDetalleID = PDI.Id;
	end
END
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(180) NOT NULL;
GO
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name='IX_TablaLogicaDatos_TablaLogicaID')
BEGIN
	CREATE INDEX IX_TablaLogicaDatos_TablaLogicaID ON dbo.TablaLogicaDatos(TablaLogicaID);
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	ADD TieneProl3 BIT CONSTRAINT DF_ConfiguracionValidacion_TieneProl3 DEFAULT(0) NOT NULL;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int = 201301
as
begin
	select
		CampaniaID,
		PaisID,
		DiasAntes,
		HoraInicio,
		HoraFin,
		HoraInicioNoFacturable,
		HoraCierreNoFacturable,
		FlagNoValidados,
		ProcesoRegular,
		ProcesoDA,
		ProcesoDAPRD,
		HabilitarRestriccionHoraria,
		HorasDuracionRestriccion,
		CronogramaAutomatico,
		ContingenciaActivacionPROL,
		ValidacionAutomaticaPostActivacion,
		ValidacionInteractiva,
		MensajeValidacionInteractiva,
		TieneProl3
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado
END
GO
create table dbo.PedidoWebDetalleExplotado(
	PedidoWebDetalleExplotadoID bigint identity(1,1) primary key,
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
)

create nonclustered index IX_PedidoWebDetalleExplotado_CampaniaID_PedidoID on dbo.PedidoWebDetalleExplotado(CampaniaID, PedidoID)
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
create proc dbo.DeletePedidoWebDetalleExplotadoByPedidoID
	@CampaniaID int,
	@PedidoID int
as
begin
	delete from PedidoWebDetalleExplotado
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
create type dbo.PedidoWebDetalleExplotadoType as table(
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
);
GO
create proc dbo.InsertListPedidoWebDetalleExplotado
	@ListPedidoWebDetalleExplotado dbo.PedidoWebDetalleExplotadoType readonly
as
begin
	insert into PedidoWebDetalleExplotado(
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	)
	select
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	from @ListPedidoWebDetalleExplotado;
end
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD PedidoSapId BIGINT NOT NULL
	CONSTRAINT DF_PedidoWeb_PedidoSapId DEFAULT 0;
END
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD VersionProl TINYINT NULL;
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
create proc dbo.GetPedidoSapId
	@CampaniaID int,
	@PedidoID int
as
begin
	SELECT PedidoSapId
	FROM PedidoWeb (nolock)
	WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
create proc dbo.UpdListBackOrderPedidoWebDetalle
	@CampaniaID INT,
	@PedidoID INT,
	@ListPedidoDetalleID dbo.IdSmallintType readonly
AS
BEGIN
	update dbo.PedidoWebDetalle
	set EsBackOrder = 0
	where
		CampaniaID = @CampaniaID and
		PedidoID = @PedidoID and
		AceptoBackOrder = 0;

	if exists (select 1 from @ListPedidoDetalleID)
	begin
		update dbo.PedidoWebDetalle
		set
			EsBackOrder = 1,
			AceptoBackOrder = 0
		from dbo.PedidoWebDetalle PWD
		inner join @ListPedidoDetalleID PDI ON
			PWD.CampaniaID = @CampaniaID and
			PWD.PedidoID = @PedidoID and
			PWD.PedidoDetalleID = PDI.Id;
	end
END
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(180) NOT NULL;
GO
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name='IX_TablaLogicaDatos_TablaLogicaID')
BEGIN
	CREATE INDEX IX_TablaLogicaDatos_TablaLogicaID ON dbo.TablaLogicaDatos(TablaLogicaID);
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
/*end*/

USE BelcorpDominicana
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	ADD TieneProl3 BIT CONSTRAINT DF_ConfiguracionValidacion_TieneProl3 DEFAULT(0) NOT NULL;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int = 201301
as
begin
	select
		CampaniaID,
		PaisID,
		DiasAntes,
		HoraInicio,
		HoraFin,
		HoraInicioNoFacturable,
		HoraCierreNoFacturable,
		FlagNoValidados,
		ProcesoRegular,
		ProcesoDA,
		ProcesoDAPRD,
		HabilitarRestriccionHoraria,
		HorasDuracionRestriccion,
		CronogramaAutomatico,
		ContingenciaActivacionPROL,
		ValidacionAutomaticaPostActivacion,
		ValidacionInteractiva,
		MensajeValidacionInteractiva,
		TieneProl3
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado
END
GO
create table dbo.PedidoWebDetalleExplotado(
	PedidoWebDetalleExplotadoID bigint identity(1,1) primary key,
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
)

create nonclustered index IX_PedidoWebDetalleExplotado_CampaniaID_PedidoID on dbo.PedidoWebDetalleExplotado(CampaniaID, PedidoID)
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
create proc dbo.DeletePedidoWebDetalleExplotadoByPedidoID
	@CampaniaID int,
	@PedidoID int
as
begin
	delete from PedidoWebDetalleExplotado
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
create type dbo.PedidoWebDetalleExplotadoType as table(
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
);
GO
create proc dbo.InsertListPedidoWebDetalleExplotado
	@ListPedidoWebDetalleExplotado dbo.PedidoWebDetalleExplotadoType readonly
as
begin
	insert into PedidoWebDetalleExplotado(
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	)
	select
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	from @ListPedidoWebDetalleExplotado;
end
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD PedidoSapId BIGINT NOT NULL
	CONSTRAINT DF_PedidoWeb_PedidoSapId DEFAULT 0;
END
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD VersionProl TINYINT NULL;
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
create proc dbo.GetPedidoSapId
	@CampaniaID int,
	@PedidoID int
as
begin
	SELECT PedidoSapId
	FROM PedidoWeb (nolock)
	WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
create proc dbo.UpdListBackOrderPedidoWebDetalle
	@CampaniaID INT,
	@PedidoID INT,
	@ListPedidoDetalleID dbo.IdSmallintType readonly
AS
BEGIN
	update dbo.PedidoWebDetalle
	set EsBackOrder = 0
	where
		CampaniaID = @CampaniaID and
		PedidoID = @PedidoID and
		AceptoBackOrder = 0;

	if exists (select 1 from @ListPedidoDetalleID)
	begin
		update dbo.PedidoWebDetalle
		set
			EsBackOrder = 1,
			AceptoBackOrder = 0
		from dbo.PedidoWebDetalle PWD
		inner join @ListPedidoDetalleID PDI ON
			PWD.CampaniaID = @CampaniaID and
			PWD.PedidoID = @PedidoID and
			PWD.PedidoDetalleID = PDI.Id;
	end
END
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(180) NOT NULL;
GO
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name='IX_TablaLogicaDatos_TablaLogicaID')
BEGIN
	CREATE INDEX IX_TablaLogicaDatos_TablaLogicaID ON dbo.TablaLogicaDatos(TablaLogicaID);
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
/*end*/

USE BelcorpEcuador
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	ADD TieneProl3 BIT CONSTRAINT DF_ConfiguracionValidacion_TieneProl3 DEFAULT(0) NOT NULL;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int = 201301
as
begin
	select
		CampaniaID,
		PaisID,
		DiasAntes,
		HoraInicio,
		HoraFin,
		HoraInicioNoFacturable,
		HoraCierreNoFacturable,
		FlagNoValidados,
		ProcesoRegular,
		ProcesoDA,
		ProcesoDAPRD,
		HabilitarRestriccionHoraria,
		HorasDuracionRestriccion,
		CronogramaAutomatico,
		ContingenciaActivacionPROL,
		ValidacionAutomaticaPostActivacion,
		ValidacionInteractiva,
		MensajeValidacionInteractiva,
		TieneProl3
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado
END
GO
create table dbo.PedidoWebDetalleExplotado(
	PedidoWebDetalleExplotadoID bigint identity(1,1) primary key,
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
)

create nonclustered index IX_PedidoWebDetalleExplotado_CampaniaID_PedidoID on dbo.PedidoWebDetalleExplotado(CampaniaID, PedidoID)
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
create proc dbo.DeletePedidoWebDetalleExplotadoByPedidoID
	@CampaniaID int,
	@PedidoID int
as
begin
	delete from PedidoWebDetalleExplotado
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
create type dbo.PedidoWebDetalleExplotadoType as table(
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
);
GO
create proc dbo.InsertListPedidoWebDetalleExplotado
	@ListPedidoWebDetalleExplotado dbo.PedidoWebDetalleExplotadoType readonly
as
begin
	insert into PedidoWebDetalleExplotado(
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	)
	select
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	from @ListPedidoWebDetalleExplotado;
end
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD PedidoSapId BIGINT NOT NULL
	CONSTRAINT DF_PedidoWeb_PedidoSapId DEFAULT 0;
END
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD VersionProl TINYINT NULL;
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
create proc dbo.GetPedidoSapId
	@CampaniaID int,
	@PedidoID int
as
begin
	SELECT PedidoSapId
	FROM PedidoWeb (nolock)
	WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
create proc dbo.UpdListBackOrderPedidoWebDetalle
	@CampaniaID INT,
	@PedidoID INT,
	@ListPedidoDetalleID dbo.IdSmallintType readonly
AS
BEGIN
	update dbo.PedidoWebDetalle
	set EsBackOrder = 0
	where
		CampaniaID = @CampaniaID and
		PedidoID = @PedidoID and
		AceptoBackOrder = 0;

	if exists (select 1 from @ListPedidoDetalleID)
	begin
		update dbo.PedidoWebDetalle
		set
			EsBackOrder = 1,
			AceptoBackOrder = 0
		from dbo.PedidoWebDetalle PWD
		inner join @ListPedidoDetalleID PDI ON
			PWD.CampaniaID = @CampaniaID and
			PWD.PedidoID = @PedidoID and
			PWD.PedidoDetalleID = PDI.Id;
	end
END
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(180) NOT NULL;
GO
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name='IX_TablaLogicaDatos_TablaLogicaID')
BEGIN
	CREATE INDEX IX_TablaLogicaDatos_TablaLogicaID ON dbo.TablaLogicaDatos(TablaLogicaID);
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	ADD TieneProl3 BIT CONSTRAINT DF_ConfiguracionValidacion_TieneProl3 DEFAULT(0) NOT NULL;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int = 201301
as
begin
	select
		CampaniaID,
		PaisID,
		DiasAntes,
		HoraInicio,
		HoraFin,
		HoraInicioNoFacturable,
		HoraCierreNoFacturable,
		FlagNoValidados,
		ProcesoRegular,
		ProcesoDA,
		ProcesoDAPRD,
		HabilitarRestriccionHoraria,
		HorasDuracionRestriccion,
		CronogramaAutomatico,
		ContingenciaActivacionPROL,
		ValidacionAutomaticaPostActivacion,
		ValidacionInteractiva,
		MensajeValidacionInteractiva,
		TieneProl3
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado
END
GO
create table dbo.PedidoWebDetalleExplotado(
	PedidoWebDetalleExplotadoID bigint identity(1,1) primary key,
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
)

create nonclustered index IX_PedidoWebDetalleExplotado_CampaniaID_PedidoID on dbo.PedidoWebDetalleExplotado(CampaniaID, PedidoID)
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
create proc dbo.DeletePedidoWebDetalleExplotadoByPedidoID
	@CampaniaID int,
	@PedidoID int
as
begin
	delete from PedidoWebDetalleExplotado
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
create type dbo.PedidoWebDetalleExplotadoType as table(
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
);
GO
create proc dbo.InsertListPedidoWebDetalleExplotado
	@ListPedidoWebDetalleExplotado dbo.PedidoWebDetalleExplotadoType readonly
as
begin
	insert into PedidoWebDetalleExplotado(
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	)
	select
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	from @ListPedidoWebDetalleExplotado;
end
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD PedidoSapId BIGINT NOT NULL
	CONSTRAINT DF_PedidoWeb_PedidoSapId DEFAULT 0;
END
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD VersionProl TINYINT NULL;
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
create proc dbo.GetPedidoSapId
	@CampaniaID int,
	@PedidoID int
as
begin
	SELECT PedidoSapId
	FROM PedidoWeb (nolock)
	WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
create proc dbo.UpdListBackOrderPedidoWebDetalle
	@CampaniaID INT,
	@PedidoID INT,
	@ListPedidoDetalleID dbo.IdSmallintType readonly
AS
BEGIN
	update dbo.PedidoWebDetalle
	set EsBackOrder = 0
	where
		CampaniaID = @CampaniaID and
		PedidoID = @PedidoID and
		AceptoBackOrder = 0;

	if exists (select 1 from @ListPedidoDetalleID)
	begin
		update dbo.PedidoWebDetalle
		set
			EsBackOrder = 1,
			AceptoBackOrder = 0
		from dbo.PedidoWebDetalle PWD
		inner join @ListPedidoDetalleID PDI ON
			PWD.CampaniaID = @CampaniaID and
			PWD.PedidoID = @PedidoID and
			PWD.PedidoDetalleID = PDI.Id;
	end
END
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(180) NOT NULL;
GO
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name='IX_TablaLogicaDatos_TablaLogicaID')
BEGIN
	CREATE INDEX IX_TablaLogicaDatos_TablaLogicaID ON dbo.TablaLogicaDatos(TablaLogicaID);
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
/*end*/

USE BelcorpMexico
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	ADD TieneProl3 BIT CONSTRAINT DF_ConfiguracionValidacion_TieneProl3 DEFAULT(0) NOT NULL;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int = 201301
as
begin
	select
		CampaniaID,
		PaisID,
		DiasAntes,
		HoraInicio,
		HoraFin,
		HoraInicioNoFacturable,
		HoraCierreNoFacturable,
		FlagNoValidados,
		ProcesoRegular,
		ProcesoDA,
		ProcesoDAPRD,
		HabilitarRestriccionHoraria,
		HorasDuracionRestriccion,
		CronogramaAutomatico,
		ContingenciaActivacionPROL,
		ValidacionAutomaticaPostActivacion,
		ValidacionInteractiva,
		MensajeValidacionInteractiva,
		TieneProl3
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado
END
GO
create table dbo.PedidoWebDetalleExplotado(
	PedidoWebDetalleExplotadoID bigint identity(1,1) primary key,
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
)

create nonclustered index IX_PedidoWebDetalleExplotado_CampaniaID_PedidoID on dbo.PedidoWebDetalleExplotado(CampaniaID, PedidoID)
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
create proc dbo.DeletePedidoWebDetalleExplotadoByPedidoID
	@CampaniaID int,
	@PedidoID int
as
begin
	delete from PedidoWebDetalleExplotado
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
create type dbo.PedidoWebDetalleExplotadoType as table(
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
);
GO
create proc dbo.InsertListPedidoWebDetalleExplotado
	@ListPedidoWebDetalleExplotado dbo.PedidoWebDetalleExplotadoType readonly
as
begin
	insert into PedidoWebDetalleExplotado(
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	)
	select
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	from @ListPedidoWebDetalleExplotado;
end
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD PedidoSapId BIGINT NOT NULL
	CONSTRAINT DF_PedidoWeb_PedidoSapId DEFAULT 0;
END
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD VersionProl TINYINT NULL;
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
create proc dbo.GetPedidoSapId
	@CampaniaID int,
	@PedidoID int
as
begin
	SELECT PedidoSapId
	FROM PedidoWeb (nolock)
	WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
create proc dbo.UpdListBackOrderPedidoWebDetalle
	@CampaniaID INT,
	@PedidoID INT,
	@ListPedidoDetalleID dbo.IdSmallintType readonly
AS
BEGIN
	update dbo.PedidoWebDetalle
	set EsBackOrder = 0
	where
		CampaniaID = @CampaniaID and
		PedidoID = @PedidoID and
		AceptoBackOrder = 0;

	if exists (select 1 from @ListPedidoDetalleID)
	begin
		update dbo.PedidoWebDetalle
		set
			EsBackOrder = 1,
			AceptoBackOrder = 0
		from dbo.PedidoWebDetalle PWD
		inner join @ListPedidoDetalleID PDI ON
			PWD.CampaniaID = @CampaniaID and
			PWD.PedidoID = @PedidoID and
			PWD.PedidoDetalleID = PDI.Id;
	end
END
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(180) NOT NULL;
GO
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name='IX_TablaLogicaDatos_TablaLogicaID')
BEGIN
	CREATE INDEX IX_TablaLogicaDatos_TablaLogicaID ON dbo.TablaLogicaDatos(TablaLogicaID);
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
/*end*/

USE BelcorpPanama
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	ADD TieneProl3 BIT CONSTRAINT DF_ConfiguracionValidacion_TieneProl3 DEFAULT(0) NOT NULL;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int = 201301
as
begin
	select
		CampaniaID,
		PaisID,
		DiasAntes,
		HoraInicio,
		HoraFin,
		HoraInicioNoFacturable,
		HoraCierreNoFacturable,
		FlagNoValidados,
		ProcesoRegular,
		ProcesoDA,
		ProcesoDAPRD,
		HabilitarRestriccionHoraria,
		HorasDuracionRestriccion,
		CronogramaAutomatico,
		ContingenciaActivacionPROL,
		ValidacionAutomaticaPostActivacion,
		ValidacionInteractiva,
		MensajeValidacionInteractiva,
		TieneProl3
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado
END
GO
create table dbo.PedidoWebDetalleExplotado(
	PedidoWebDetalleExplotadoID bigint identity(1,1) primary key,
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
)

create nonclustered index IX_PedidoWebDetalleExplotado_CampaniaID_PedidoID on dbo.PedidoWebDetalleExplotado(CampaniaID, PedidoID)
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
create proc dbo.DeletePedidoWebDetalleExplotadoByPedidoID
	@CampaniaID int,
	@PedidoID int
as
begin
	delete from PedidoWebDetalleExplotado
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
create type dbo.PedidoWebDetalleExplotadoType as table(
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
);
GO
create proc dbo.InsertListPedidoWebDetalleExplotado
	@ListPedidoWebDetalleExplotado dbo.PedidoWebDetalleExplotadoType readonly
as
begin
	insert into PedidoWebDetalleExplotado(
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	)
	select
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	from @ListPedidoWebDetalleExplotado;
end
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD PedidoSapId BIGINT NOT NULL
	CONSTRAINT DF_PedidoWeb_PedidoSapId DEFAULT 0;
END
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD VersionProl TINYINT NULL;
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
create proc dbo.GetPedidoSapId
	@CampaniaID int,
	@PedidoID int
as
begin
	SELECT PedidoSapId
	FROM PedidoWeb (nolock)
	WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
create proc dbo.UpdListBackOrderPedidoWebDetalle
	@CampaniaID INT,
	@PedidoID INT,
	@ListPedidoDetalleID dbo.IdSmallintType readonly
AS
BEGIN
	update dbo.PedidoWebDetalle
	set EsBackOrder = 0
	where
		CampaniaID = @CampaniaID and
		PedidoID = @PedidoID and
		AceptoBackOrder = 0;

	if exists (select 1 from @ListPedidoDetalleID)
	begin
		update dbo.PedidoWebDetalle
		set
			EsBackOrder = 1,
			AceptoBackOrder = 0
		from dbo.PedidoWebDetalle PWD
		inner join @ListPedidoDetalleID PDI ON
			PWD.CampaniaID = @CampaniaID and
			PWD.PedidoID = @PedidoID and
			PWD.PedidoDetalleID = PDI.Id;
	end
END
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(180) NOT NULL;
GO
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name='IX_TablaLogicaDatos_TablaLogicaID')
BEGIN
	CREATE INDEX IX_TablaLogicaDatos_TablaLogicaID ON dbo.TablaLogicaDatos(TablaLogicaID);
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
/*end*/

USE BelcorpPeru
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	ADD TieneProl3 BIT CONSTRAINT DF_ConfiguracionValidacion_TieneProl3 DEFAULT(0) NOT NULL;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int = 201301
as
begin
	select
		CampaniaID,
		PaisID,
		DiasAntes,
		HoraInicio,
		HoraFin,
		HoraInicioNoFacturable,
		HoraCierreNoFacturable,
		FlagNoValidados,
		ProcesoRegular,
		ProcesoDA,
		ProcesoDAPRD,
		HabilitarRestriccionHoraria,
		HorasDuracionRestriccion,
		CronogramaAutomatico,
		ContingenciaActivacionPROL,
		ValidacionAutomaticaPostActivacion,
		ValidacionInteractiva,
		MensajeValidacionInteractiva,
		TieneProl3
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado
END
GO
create table dbo.PedidoWebDetalleExplotado(
	PedidoWebDetalleExplotadoID bigint identity(1,1) primary key,
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
)

create nonclustered index IX_PedidoWebDetalleExplotado_CampaniaID_PedidoID on dbo.PedidoWebDetalleExplotado(CampaniaID, PedidoID)
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
create proc dbo.DeletePedidoWebDetalleExplotadoByPedidoID
	@CampaniaID int,
	@PedidoID int
as
begin
	delete from PedidoWebDetalleExplotado
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
create type dbo.PedidoWebDetalleExplotadoType as table(
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
);
GO
create proc dbo.InsertListPedidoWebDetalleExplotado
	@ListPedidoWebDetalleExplotado dbo.PedidoWebDetalleExplotadoType readonly
as
begin
	insert into PedidoWebDetalleExplotado(
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	)
	select
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	from @ListPedidoWebDetalleExplotado;
end
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD PedidoSapId BIGINT NOT NULL
	CONSTRAINT DF_PedidoWeb_PedidoSapId DEFAULT 0;
END
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD VersionProl TINYINT NULL;
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
create proc dbo.GetPedidoSapId
	@CampaniaID int,
	@PedidoID int
as
begin
	SELECT PedidoSapId
	FROM PedidoWeb (nolock)
	WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
create proc dbo.UpdListBackOrderPedidoWebDetalle
	@CampaniaID INT,
	@PedidoID INT,
	@ListPedidoDetalleID dbo.IdSmallintType readonly
AS
BEGIN
	update dbo.PedidoWebDetalle
	set EsBackOrder = 0
	where
		CampaniaID = @CampaniaID and
		PedidoID = @PedidoID and
		AceptoBackOrder = 0;

	if exists (select 1 from @ListPedidoDetalleID)
	begin
		update dbo.PedidoWebDetalle
		set
			EsBackOrder = 1,
			AceptoBackOrder = 0
		from dbo.PedidoWebDetalle PWD
		inner join @ListPedidoDetalleID PDI ON
			PWD.CampaniaID = @CampaniaID and
			PWD.PedidoID = @PedidoID and
			PWD.PedidoDetalleID = PDI.Id;
	end
END
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(180) NOT NULL;
GO
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name='IX_TablaLogicaDatos_TablaLogicaID')
BEGIN
	CREATE INDEX IX_TablaLogicaDatos_TablaLogicaID ON dbo.TablaLogicaDatos(TablaLogicaID);
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	ADD TieneProl3 BIT CONSTRAINT DF_ConfiguracionValidacion_TieneProl3 DEFAULT(0) NOT NULL;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int = 201301
as
begin
	select
		CampaniaID,
		PaisID,
		DiasAntes,
		HoraInicio,
		HoraFin,
		HoraInicioNoFacturable,
		HoraCierreNoFacturable,
		FlagNoValidados,
		ProcesoRegular,
		ProcesoDA,
		ProcesoDAPRD,
		HabilitarRestriccionHoraria,
		HorasDuracionRestriccion,
		CronogramaAutomatico,
		ContingenciaActivacionPROL,
		ValidacionAutomaticaPostActivacion,
		ValidacionInteractiva,
		MensajeValidacionInteractiva,
		TieneProl3
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado
END
GO
create table dbo.PedidoWebDetalleExplotado(
	PedidoWebDetalleExplotadoID bigint identity(1,1) primary key,
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
)

create nonclustered index IX_PedidoWebDetalleExplotado_CampaniaID_PedidoID on dbo.PedidoWebDetalleExplotado(CampaniaID, PedidoID)
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
create proc dbo.DeletePedidoWebDetalleExplotadoByPedidoID
	@CampaniaID int,
	@PedidoID int
as
begin
	delete from PedidoWebDetalleExplotado
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
create type dbo.PedidoWebDetalleExplotadoType as table(
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
);
GO
create proc dbo.InsertListPedidoWebDetalleExplotado
	@ListPedidoWebDetalleExplotado dbo.PedidoWebDetalleExplotadoType readonly
as
begin
	insert into PedidoWebDetalleExplotado(
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	)
	select
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	from @ListPedidoWebDetalleExplotado;
end
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD PedidoSapId BIGINT NOT NULL
	CONSTRAINT DF_PedidoWeb_PedidoSapId DEFAULT 0;
END
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD VersionProl TINYINT NULL;
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
create proc dbo.GetPedidoSapId
	@CampaniaID int,
	@PedidoID int
as
begin
	SELECT PedidoSapId
	FROM PedidoWeb (nolock)
	WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
create proc dbo.UpdListBackOrderPedidoWebDetalle
	@CampaniaID INT,
	@PedidoID INT,
	@ListPedidoDetalleID dbo.IdSmallintType readonly
AS
BEGIN
	update dbo.PedidoWebDetalle
	set EsBackOrder = 0
	where
		CampaniaID = @CampaniaID and
		PedidoID = @PedidoID and
		AceptoBackOrder = 0;

	if exists (select 1 from @ListPedidoDetalleID)
	begin
		update dbo.PedidoWebDetalle
		set
			EsBackOrder = 1,
			AceptoBackOrder = 0
		from dbo.PedidoWebDetalle PWD
		inner join @ListPedidoDetalleID PDI ON
			PWD.CampaniaID = @CampaniaID and
			PWD.PedidoID = @PedidoID and
			PWD.PedidoDetalleID = PDI.Id;
	end
END
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(180) NOT NULL;
GO
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name='IX_TablaLogicaDatos_TablaLogicaID')
BEGIN
	CREATE INDEX IX_TablaLogicaDatos_TablaLogicaID ON dbo.TablaLogicaDatos(TablaLogicaID);
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
/*end*/

USE BelcorpSalvador
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	ADD TieneProl3 BIT CONSTRAINT DF_ConfiguracionValidacion_TieneProl3 DEFAULT(0) NOT NULL;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int = 201301
as
begin
	select
		CampaniaID,
		PaisID,
		DiasAntes,
		HoraInicio,
		HoraFin,
		HoraInicioNoFacturable,
		HoraCierreNoFacturable,
		FlagNoValidados,
		ProcesoRegular,
		ProcesoDA,
		ProcesoDAPRD,
		HabilitarRestriccionHoraria,
		HorasDuracionRestriccion,
		CronogramaAutomatico,
		ContingenciaActivacionPROL,
		ValidacionAutomaticaPostActivacion,
		ValidacionInteractiva,
		MensajeValidacionInteractiva,
		TieneProl3
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado
END
GO
create table dbo.PedidoWebDetalleExplotado(
	PedidoWebDetalleExplotadoID bigint identity(1,1) primary key,
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
)

create nonclustered index IX_PedidoWebDetalleExplotado_CampaniaID_PedidoID on dbo.PedidoWebDetalleExplotado(CampaniaID, PedidoID)
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
create proc dbo.DeletePedidoWebDetalleExplotadoByPedidoID
	@CampaniaID int,
	@PedidoID int
as
begin
	delete from PedidoWebDetalleExplotado
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
create type dbo.PedidoWebDetalleExplotadoType as table(
	CampaniaID int not null,
	PedidoID int not null,
	CodigoSap varchar(20) not null,
	CUV varchar(6) not null,
	EscalaDescuento decimal(12,2) not null,
	FactorCuadre decimal(12,2) not null,
	FactorRepeticion int not null,
	GrupoDescuento varchar(4) not null,
	ImporteDescuento1 decimal(12,2) not null,
	ImporteDescuento2 decimal(12,2) not null,
	IndAccion bit not null,
	IndLimiteVenta bit not null,
	IndRecuperacion bit not null,
	NumUnidOrig int not null,
	NumSeccionDetalle int not null,
	Observaciones varchar(300) not null,
	IdCatalogo int not null,
	IdDetaOferta int not null,
	IdEstrategia int not null,
	IdFormaPago int not null,
	IdGrupoOferta int not null,
	IdIndicadorCuadre int not null,
	IdNiveOferta int not null,
	IdNiveOfertaGratis int not null,
	IdNiveOfertaRango int not null,
	IdOferta int not null,
	IdPosicion int not null,
	IdProducto int not null,
	IdSubTipoPosicion int not null,
	DescripcionSap varchar(500) not null,
	IdTipoPosicion int not null,
	Pagina int not null,
	PorcentajeDescuento decimal(12,2) not null,
	PrecioCatalogo decimal(12,2) not null,
	PrecioContable decimal(12,2) not null,
	PrecioPublico decimal(12,2) not null,
	PrecioUnitario decimal(12,2) not null,
	Ranking varchar(4) not null,
	UnidadesDemandadas int not null,
	UnidadesPorAtender int not null,
	ValCodiOrig varchar(6) not null,
	OportunidadAhorro decimal(12,2) not null,
	UnidadesReservadasSap int not null,
	OrigenPedidoWeb int not null
);
GO
create proc dbo.InsertListPedidoWebDetalleExplotado
	@ListPedidoWebDetalleExplotado dbo.PedidoWebDetalleExplotadoType readonly
as
begin
	insert into PedidoWebDetalleExplotado(
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	)
	select
		CampaniaID,
		PedidoID,
		CodigoSap,
		CUV,
		EscalaDescuento,
		FactorCuadre,
		FactorRepeticion,
		GrupoDescuento,
		ImporteDescuento1,
		ImporteDescuento2,
		IndAccion,
		IndLimiteVenta,
		IndRecuperacion,
		NumUnidOrig,
		NumSeccionDetalle,
		Observaciones,
		IdCatalogo,
		IdDetaOferta,
		IdEstrategia,
		IdFormaPago,
		IdGrupoOferta,
		IdIndicadorCuadre,
		IdNiveOferta,
		IdNiveOfertaGratis,
		IdNiveOfertaRango,
		IdOferta,
		IdPosicion,
		IdProducto,
		IdSubTipoPosicion,
		DescripcionSap,
		IdTipoPosicion,
		Pagina,
		PorcentajeDescuento,
		PrecioCatalogo,
		PrecioContable,
		PrecioPublico,
		PrecioUnitario,
		Ranking,
		UnidadesDemandadas,
		UnidadesPorAtender,
		ValCodiOrig,
		OportunidadAhorro,
		UnidadesReservadasSap,
		OrigenPedidoWeb
	from @ListPedidoWebDetalleExplotado;
end
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD PedidoSapId BIGINT NOT NULL
	CONSTRAINT DF_PedidoWeb_PedidoSapId DEFAULT 0;
END
GO
IF (NOT EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	ADD VersionProl TINYINT NULL;
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
create proc dbo.GetPedidoSapId
	@CampaniaID int,
	@PedidoID int
as
begin
	SELECT PedidoSapId
	FROM PedidoWeb (nolock)
	WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
create proc dbo.UpdListBackOrderPedidoWebDetalle
	@CampaniaID INT,
	@PedidoID INT,
	@ListPedidoDetalleID dbo.IdSmallintType readonly
AS
BEGIN
	update dbo.PedidoWebDetalle
	set EsBackOrder = 0
	where
		CampaniaID = @CampaniaID and
		PedidoID = @PedidoID and
		AceptoBackOrder = 0;

	if exists (select 1 from @ListPedidoDetalleID)
	begin
		update dbo.PedidoWebDetalle
		set
			EsBackOrder = 1,
			AceptoBackOrder = 0
		from dbo.PedidoWebDetalle PWD
		inner join @ListPedidoDetalleID PDI ON
			PWD.CampaniaID = @CampaniaID and
			PWD.PedidoID = @PedidoID and
			PWD.PedidoDetalleID = PDI.Id;
	end
END
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(180) NOT NULL;
GO
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name='IX_TablaLogicaDatos_TablaLogicaID')
BEGIN
	CREATE INDEX IX_TablaLogicaDatos_TablaLogicaID ON dbo.TablaLogicaDatos(TablaLogicaID);
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO