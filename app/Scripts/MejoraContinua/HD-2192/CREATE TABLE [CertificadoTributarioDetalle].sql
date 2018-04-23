USE BelcorpColombia 
GO

IF EXISTS(SELECT * FROM sys.SYSOBJECTS A INNER JOIN SYS.SCHEMAS B ON A.uid =B.schema_id 
    WHERE A.NAME='CertificadoTributarioDetalle' AND B.name='DBO')
 DROP PROCEDURE CertificadoTributarioDetalle 
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
