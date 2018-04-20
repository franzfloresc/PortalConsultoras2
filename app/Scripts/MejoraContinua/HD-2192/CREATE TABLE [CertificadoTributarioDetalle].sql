USE BelcorpColombia 
GO

CREATE TABLE CertificadoTributarioDetalle
(
Anio INT
, Codigo varchar ( 50 )
, Cedula VARCHAR ( 50 )
, NombreCompleto VARCHAR ( 350 )
, CompraVDirecta MONEY
, IVACompraVDirecta MONEY
, Retail MONEY
, IVARetail MONEY
, TotalCompra MONEY
, IvaTotal MONEY
, FechaCreacion DATETIME
, UsuarioCreacion VARCHAR ( 50 )
, FechaModificacion DATETIME
, UsuarioModificacion VARCHAR ( 50 )
)
