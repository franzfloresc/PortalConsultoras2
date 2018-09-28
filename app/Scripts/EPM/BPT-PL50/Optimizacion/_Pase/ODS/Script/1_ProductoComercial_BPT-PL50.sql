GO
USE ODS_PE
GO

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

GO
USE ODS_MX
GO

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

GO
USE ODS_CO
GO

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

GO
USE ODS_VE
GO

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

GO
USE ODS_SV
GO

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

GO
USE ODS_PR
GO

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

GO
USE ODS_PA
GO

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

GO
USE ODS_GT
GO

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

GO
USE ODS_EC
GO

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

GO
USE ODS_DO
GO

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

GO
USE ODS_CR
GO

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

GO
USE ODS_CL
GO

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

GO
USE ODS_BO
GO

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

GO
