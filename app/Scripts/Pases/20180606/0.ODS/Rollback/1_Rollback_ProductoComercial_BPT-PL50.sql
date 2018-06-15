GO
USE ODS_PE
GO

go
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ProductoComercial' and COLUMN_NAME = 'NumeroNivel')
begin
	alter table ProductoComercial drop column CheckSumID
	alter table ProductoComercial drop column SeccionDetalleFactura
	alter table ProductoComercial drop column CodigoFactorCuadre
	alter table ProductoComercial drop column EstrategiaIDSicc
	alter table ProductoComercial drop column CodigoOferta
	alter table ProductoComercial drop column NumeroLineaOferta
	alter table ProductoComercial drop column GrupoOfertaID
	alter table ProductoComercial drop column NumeroGrupo
	alter table ProductoComercial drop column NumeroNivel
	alter table ProductoComercial
	add CheckSumID as checksum([CodigoProducto],[PrecioCatalogo],[PrecioValorizado],[PaisID],[Descripcion],[CodigoTipoOferta],[PrecioUnitario],[NumeroPagina],[CodigoCatalago],[FactorRepeticion],[CodigoMarca],[CodigoAcceso],[MarcaID],[NumeroUnidadesMaxima],[IndicadorProductoEstadisticable],[EstadoActivo],[IndicadorDigitable],[AnoCampania],[IndicadorMontoMinimo],[IndicadorDscto],[IndicadorPreUni],[IndicadorOferta])
end
go


GO
USE ODS_MX
GO

go
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ProductoComercial' and COLUMN_NAME = 'NumeroNivel')
begin
	alter table ProductoComercial drop column CheckSumID
	alter table ProductoComercial drop column SeccionDetalleFactura
	alter table ProductoComercial drop column CodigoFactorCuadre
	alter table ProductoComercial drop column EstrategiaIDSicc
	alter table ProductoComercial drop column CodigoOferta
	alter table ProductoComercial drop column NumeroLineaOferta
	alter table ProductoComercial drop column GrupoOfertaID
	alter table ProductoComercial drop column NumeroGrupo
	alter table ProductoComercial drop column NumeroNivel
	alter table ProductoComercial
	add CheckSumID as checksum([CodigoProducto],[PrecioCatalogo],[PrecioValorizado],[PaisID],[Descripcion],[CodigoTipoOferta],[PrecioUnitario],[NumeroPagina],[CodigoCatalago],[FactorRepeticion],[CodigoMarca],[CodigoAcceso],[MarcaID],[NumeroUnidadesMaxima],[IndicadorProductoEstadisticable],[EstadoActivo],[IndicadorDigitable],[AnoCampania],[IndicadorMontoMinimo],[IndicadorDscto],[IndicadorPreUni],[IndicadorOferta])
end
go


GO
USE ODS_CO
GO

go
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ProductoComercial' and COLUMN_NAME = 'NumeroNivel')
begin
	alter table ProductoComercial drop column CheckSumID
	alter table ProductoComercial drop column SeccionDetalleFactura
	alter table ProductoComercial drop column CodigoFactorCuadre
	alter table ProductoComercial drop column EstrategiaIDSicc
	alter table ProductoComercial drop column CodigoOferta
	alter table ProductoComercial drop column NumeroLineaOferta
	alter table ProductoComercial drop column GrupoOfertaID
	alter table ProductoComercial drop column NumeroGrupo
	alter table ProductoComercial drop column NumeroNivel
	alter table ProductoComercial
	add CheckSumID as checksum([CodigoProducto],[PrecioCatalogo],[PrecioValorizado],[PaisID],[Descripcion],[CodigoTipoOferta],[PrecioUnitario],[NumeroPagina],[CodigoCatalago],[FactorRepeticion],[CodigoMarca],[CodigoAcceso],[MarcaID],[NumeroUnidadesMaxima],[IndicadorProductoEstadisticable],[EstadoActivo],[IndicadorDigitable],[AnoCampania],[IndicadorMontoMinimo],[IndicadorDscto],[IndicadorPreUni],[IndicadorOferta])
end
go


GO
USE ODS_VE
GO

go
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ProductoComercial' and COLUMN_NAME = 'NumeroNivel')
begin
	alter table ProductoComercial drop column CheckSumID
	alter table ProductoComercial drop column SeccionDetalleFactura
	alter table ProductoComercial drop column CodigoFactorCuadre
	alter table ProductoComercial drop column EstrategiaIDSicc
	alter table ProductoComercial drop column CodigoOferta
	alter table ProductoComercial drop column NumeroLineaOferta
	alter table ProductoComercial drop column GrupoOfertaID
	alter table ProductoComercial drop column NumeroGrupo
	alter table ProductoComercial drop column NumeroNivel
	alter table ProductoComercial
	add CheckSumID as checksum([CodigoProducto],[PrecioCatalogo],[PrecioValorizado],[PaisID],[Descripcion],[CodigoTipoOferta],[PrecioUnitario],[NumeroPagina],[CodigoCatalago],[FactorRepeticion],[CodigoMarca],[CodigoAcceso],[MarcaID],[NumeroUnidadesMaxima],[IndicadorProductoEstadisticable],[EstadoActivo],[IndicadorDigitable],[AnoCampania],[IndicadorMontoMinimo],[IndicadorDscto],[IndicadorPreUni],[IndicadorOferta])
end
go


GO
USE ODS_SV
GO

go
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ProductoComercial' and COLUMN_NAME = 'NumeroNivel')
begin
	alter table ProductoComercial drop column CheckSumID
	alter table ProductoComercial drop column SeccionDetalleFactura
	alter table ProductoComercial drop column CodigoFactorCuadre
	alter table ProductoComercial drop column EstrategiaIDSicc
	alter table ProductoComercial drop column CodigoOferta
	alter table ProductoComercial drop column NumeroLineaOferta
	alter table ProductoComercial drop column GrupoOfertaID
	alter table ProductoComercial drop column NumeroGrupo
	alter table ProductoComercial drop column NumeroNivel
	alter table ProductoComercial
	add CheckSumID as checksum([CodigoProducto],[PrecioCatalogo],[PrecioValorizado],[PaisID],[Descripcion],[CodigoTipoOferta],[PrecioUnitario],[NumeroPagina],[CodigoCatalago],[FactorRepeticion],[CodigoMarca],[CodigoAcceso],[MarcaID],[NumeroUnidadesMaxima],[IndicadorProductoEstadisticable],[EstadoActivo],[IndicadorDigitable],[AnoCampania],[IndicadorMontoMinimo],[IndicadorDscto],[IndicadorPreUni],[IndicadorOferta])
end
go


GO
USE ODS_PR
GO

go
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ProductoComercial' and COLUMN_NAME = 'NumeroNivel')
begin
	alter table ProductoComercial drop column CheckSumID
	alter table ProductoComercial drop column SeccionDetalleFactura
	alter table ProductoComercial drop column CodigoFactorCuadre
	alter table ProductoComercial drop column EstrategiaIDSicc
	alter table ProductoComercial drop column CodigoOferta
	alter table ProductoComercial drop column NumeroLineaOferta
	alter table ProductoComercial drop column GrupoOfertaID
	alter table ProductoComercial drop column NumeroGrupo
	alter table ProductoComercial drop column NumeroNivel
	alter table ProductoComercial
	add CheckSumID as checksum([CodigoProducto],[PrecioCatalogo],[PrecioValorizado],[PaisID],[Descripcion],[CodigoTipoOferta],[PrecioUnitario],[NumeroPagina],[CodigoCatalago],[FactorRepeticion],[CodigoMarca],[CodigoAcceso],[MarcaID],[NumeroUnidadesMaxima],[IndicadorProductoEstadisticable],[EstadoActivo],[IndicadorDigitable],[AnoCampania],[IndicadorMontoMinimo],[IndicadorDscto],[IndicadorPreUni],[IndicadorOferta])
end
go


GO
USE ODS_PA
GO

go
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ProductoComercial' and COLUMN_NAME = 'NumeroNivel')
begin
	alter table ProductoComercial drop column CheckSumID
	alter table ProductoComercial drop column SeccionDetalleFactura
	alter table ProductoComercial drop column CodigoFactorCuadre
	alter table ProductoComercial drop column EstrategiaIDSicc
	alter table ProductoComercial drop column CodigoOferta
	alter table ProductoComercial drop column NumeroLineaOferta
	alter table ProductoComercial drop column GrupoOfertaID
	alter table ProductoComercial drop column NumeroGrupo
	alter table ProductoComercial drop column NumeroNivel
	alter table ProductoComercial
	add CheckSumID as checksum([CodigoProducto],[PrecioCatalogo],[PrecioValorizado],[PaisID],[Descripcion],[CodigoTipoOferta],[PrecioUnitario],[NumeroPagina],[CodigoCatalago],[FactorRepeticion],[CodigoMarca],[CodigoAcceso],[MarcaID],[NumeroUnidadesMaxima],[IndicadorProductoEstadisticable],[EstadoActivo],[IndicadorDigitable],[AnoCampania],[IndicadorMontoMinimo],[IndicadorDscto],[IndicadorPreUni],[IndicadorOferta])
end
go


GO
USE ODS_GT
GO

go
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ProductoComercial' and COLUMN_NAME = 'NumeroNivel')
begin
	alter table ProductoComercial drop column CheckSumID
	alter table ProductoComercial drop column SeccionDetalleFactura
	alter table ProductoComercial drop column CodigoFactorCuadre
	alter table ProductoComercial drop column EstrategiaIDSicc
	alter table ProductoComercial drop column CodigoOferta
	alter table ProductoComercial drop column NumeroLineaOferta
	alter table ProductoComercial drop column GrupoOfertaID
	alter table ProductoComercial drop column NumeroGrupo
	alter table ProductoComercial drop column NumeroNivel
	alter table ProductoComercial
	add CheckSumID as checksum([CodigoProducto],[PrecioCatalogo],[PrecioValorizado],[PaisID],[Descripcion],[CodigoTipoOferta],[PrecioUnitario],[NumeroPagina],[CodigoCatalago],[FactorRepeticion],[CodigoMarca],[CodigoAcceso],[MarcaID],[NumeroUnidadesMaxima],[IndicadorProductoEstadisticable],[EstadoActivo],[IndicadorDigitable],[AnoCampania],[IndicadorMontoMinimo],[IndicadorDscto],[IndicadorPreUni],[IndicadorOferta])
end
go


GO
USE ODS_EC
GO

go
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ProductoComercial' and COLUMN_NAME = 'NumeroNivel')
begin
	alter table ProductoComercial drop column CheckSumID
	alter table ProductoComercial drop column SeccionDetalleFactura
	alter table ProductoComercial drop column CodigoFactorCuadre
	alter table ProductoComercial drop column EstrategiaIDSicc
	alter table ProductoComercial drop column CodigoOferta
	alter table ProductoComercial drop column NumeroLineaOferta
	alter table ProductoComercial drop column GrupoOfertaID
	alter table ProductoComercial drop column NumeroGrupo
	alter table ProductoComercial drop column NumeroNivel
	alter table ProductoComercial
	add CheckSumID as checksum([CodigoProducto],[PrecioCatalogo],[PrecioValorizado],[PaisID],[Descripcion],[CodigoTipoOferta],[PrecioUnitario],[NumeroPagina],[CodigoCatalago],[FactorRepeticion],[CodigoMarca],[CodigoAcceso],[MarcaID],[NumeroUnidadesMaxima],[IndicadorProductoEstadisticable],[EstadoActivo],[IndicadorDigitable],[AnoCampania],[IndicadorMontoMinimo],[IndicadorDscto],[IndicadorPreUni],[IndicadorOferta])
end
go


GO
USE ODS_DO
GO

go
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ProductoComercial' and COLUMN_NAME = 'NumeroNivel')
begin
	alter table ProductoComercial drop column CheckSumID
	alter table ProductoComercial drop column SeccionDetalleFactura
	alter table ProductoComercial drop column CodigoFactorCuadre
	alter table ProductoComercial drop column EstrategiaIDSicc
	alter table ProductoComercial drop column CodigoOferta
	alter table ProductoComercial drop column NumeroLineaOferta
	alter table ProductoComercial drop column GrupoOfertaID
	alter table ProductoComercial drop column NumeroGrupo
	alter table ProductoComercial drop column NumeroNivel
	alter table ProductoComercial
	add CheckSumID as checksum([CodigoProducto],[PrecioCatalogo],[PrecioValorizado],[PaisID],[Descripcion],[CodigoTipoOferta],[PrecioUnitario],[NumeroPagina],[CodigoCatalago],[FactorRepeticion],[CodigoMarca],[CodigoAcceso],[MarcaID],[NumeroUnidadesMaxima],[IndicadorProductoEstadisticable],[EstadoActivo],[IndicadorDigitable],[AnoCampania],[IndicadorMontoMinimo],[IndicadorDscto],[IndicadorPreUni],[IndicadorOferta])
end
go


GO
USE ODS_CR
GO

go
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ProductoComercial' and COLUMN_NAME = 'NumeroNivel')
begin
	alter table ProductoComercial drop column CheckSumID
	alter table ProductoComercial drop column SeccionDetalleFactura
	alter table ProductoComercial drop column CodigoFactorCuadre
	alter table ProductoComercial drop column EstrategiaIDSicc
	alter table ProductoComercial drop column CodigoOferta
	alter table ProductoComercial drop column NumeroLineaOferta
	alter table ProductoComercial drop column GrupoOfertaID
	alter table ProductoComercial drop column NumeroGrupo
	alter table ProductoComercial drop column NumeroNivel
	alter table ProductoComercial
	add CheckSumID as checksum([CodigoProducto],[PrecioCatalogo],[PrecioValorizado],[PaisID],[Descripcion],[CodigoTipoOferta],[PrecioUnitario],[NumeroPagina],[CodigoCatalago],[FactorRepeticion],[CodigoMarca],[CodigoAcceso],[MarcaID],[NumeroUnidadesMaxima],[IndicadorProductoEstadisticable],[EstadoActivo],[IndicadorDigitable],[AnoCampania],[IndicadorMontoMinimo],[IndicadorDscto],[IndicadorPreUni],[IndicadorOferta])
end
go


GO
USE ODS_CL
GO

go
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ProductoComercial' and COLUMN_NAME = 'NumeroNivel')
begin
	alter table ProductoComercial drop column CheckSumID
	alter table ProductoComercial drop column SeccionDetalleFactura
	alter table ProductoComercial drop column CodigoFactorCuadre
	alter table ProductoComercial drop column EstrategiaIDSicc
	alter table ProductoComercial drop column CodigoOferta
	alter table ProductoComercial drop column NumeroLineaOferta
	alter table ProductoComercial drop column GrupoOfertaID
	alter table ProductoComercial drop column NumeroGrupo
	alter table ProductoComercial drop column NumeroNivel
	alter table ProductoComercial
	add CheckSumID as checksum([CodigoProducto],[PrecioCatalogo],[PrecioValorizado],[PaisID],[Descripcion],[CodigoTipoOferta],[PrecioUnitario],[NumeroPagina],[CodigoCatalago],[FactorRepeticion],[CodigoMarca],[CodigoAcceso],[MarcaID],[NumeroUnidadesMaxima],[IndicadorProductoEstadisticable],[EstadoActivo],[IndicadorDigitable],[AnoCampania],[IndicadorMontoMinimo],[IndicadorDscto],[IndicadorPreUni],[IndicadorOferta])
end
go


GO
USE ODS_BO
GO

go
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ProductoComercial' and COLUMN_NAME = 'NumeroNivel')
begin
	alter table ProductoComercial drop column CheckSumID
	alter table ProductoComercial drop column SeccionDetalleFactura
	alter table ProductoComercial drop column CodigoFactorCuadre
	alter table ProductoComercial drop column EstrategiaIDSicc
	alter table ProductoComercial drop column CodigoOferta
	alter table ProductoComercial drop column NumeroLineaOferta
	alter table ProductoComercial drop column GrupoOfertaID
	alter table ProductoComercial drop column NumeroGrupo
	alter table ProductoComercial drop column NumeroNivel
	alter table ProductoComercial
	add CheckSumID as checksum([CodigoProducto],[PrecioCatalogo],[PrecioValorizado],[PaisID],[Descripcion],[CodigoTipoOferta],[PrecioUnitario],[NumeroPagina],[CodigoCatalago],[FactorRepeticion],[CodigoMarca],[CodigoAcceso],[MarcaID],[NumeroUnidadesMaxima],[IndicadorProductoEstadisticable],[EstadoActivo],[IndicadorDigitable],[AnoCampania],[IndicadorMontoMinimo],[IndicadorDscto],[IndicadorPreUni],[IndicadorOferta])
end
go


GO
