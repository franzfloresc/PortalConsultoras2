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