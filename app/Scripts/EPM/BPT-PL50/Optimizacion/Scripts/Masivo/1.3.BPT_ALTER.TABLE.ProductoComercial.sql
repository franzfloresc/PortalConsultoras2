--use ODS_PE_PL50
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ProductoComercial' and COLUMN_NAME = 'NumeroNivel')
begin
	alter table ProductoComercial
	drop column CheckSumID

	alter table ProductoComercial
	add SeccionDetalleFactura int,
		CodigoFactorCuadre numeric(12, 2),
		EstrategiaIDSicc int,
		CodigoOferta int,
		NumeroLineaOferta int,
		GrupoOfertaID int,
		NumeroGrupo int,
		NumeroNivel int

	alter table ProductoComercial
	add CheckSumID as checksum([CodigoProducto],[PrecioCatalogo],[PrecioValorizado],[PaisID],[Descripcion],[CodigoTipoOferta],[PrecioUnitario],[NumeroPagina],[CodigoCatalago],[FactorRepeticion],[CodigoMarca],[CodigoAcceso],[MarcaID],[NumeroUnidadesMaxima],[IndicadorProductoEstadisticable],[EstadoActivo],[IndicadorDigitable],[AnoCampania],[IndicadorMontoMinimo],[IndicadorDscto],[IndicadorPreUni],[IndicadorOferta],SeccionDetalleFactura,CodigoFactorCuadre,EstrategiaIDSicc,CodigoOferta,NumeroLineaOferta,GrupoOfertaID,NumeroGrupo,NumeroNivel)
end

go
if exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'ProductoNivel')
begin
	drop table ProductoNivel
end
go

create table ProductoNivel
(
	IDNIVEL int identity,
	Campana varchar(8),
	NumeroNivel int,
	CodigoCatalogo int,
	PaginaCatalogo int,
	CodigoVenta varchar(50),
	CodigoProducto varchar(8),
	FactorCuadre int,
	PrecioUnitario numeric(12, 2),
	TipoNivel int
)
go