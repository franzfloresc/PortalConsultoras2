
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidosIngresadoFacturado]') AND type in (N'P', N'PC')) 
 DROP PROCEDURE [dbo].[GetPedidosIngresadoFacturado]
GO

-- GetPedidosIngresadoFacturado 2, 201612

/*
 unión de estas dos store
exec GetPedidosWebByConsultoraCampania 2, 201612
exec GetPedidosFacturados '000758833'
*/

create procedure dbo.GetPedidosIngresadoFacturado
	@ConsultoraID int,
	@CampaniaID int,
	@top int = 5
AS
begin

--declare @ConsultoraID int = 2,
--@CampaniaID int = 201612,

set @top = isnull(@top, 5)
if @top <= 0
	set @top = 5

DECLARE @T1 TABLE (
id int identity(1,1)
, EstadoPedido varchar(1)
, CampaniaID int 
, ImporteTotal money
, Flete money
, ImporteCredito money
, MotivoCreditoID int
, PaisID int
, Clientes smallint
, EstadoPedidoDesc varchar(12)
, ConsultoraID bigint
, PedidoID int
, FechaRegistro datetime
, CanalIngreso varchar(12)
, CantidadProductos int
)

-- agregar ingresados

INSERT INTO @T1
select top (@top) 
	'I' as EstadoPedido,
	PW.CampaniaID,  
    PW.ImporteTotal,  
	0 Flete,
    pw.ImporteCredito,  
    ISNULL(pw.MotivoCreditoID,0) MotivoCreditoID,  
    pw.PaisID,  
    PW.Clientes, 
	'INGRESADO' AS EstadoPedidoDesc,
    PW.ConsultoraID,  
    PW.PedidoID,
	PW.FechaRegistro,
	'WEB' as CanalIngreso,
	SUM(PWD.Cantidad) as CantidadProductos
FROM PedidoWeb PW
INNER JOIN PedidoWebDetalle(NOLOCK) PWD ON 
	PW.PedidoID=PWD.PedidoID
	and PW.ConsultoraID = PWD.ConsultoraID
	and PW.CampaniaID = PWD.CampaniaID
WHERE 
	pw.ConsultoraID = @ConsultoraID 
	and pw.CampaniaID <> @CampaniaID
	and	(select count(*) from PedidoWebDetalle(NOLOCK) where CampaniaID = PW.CampaniaID and ConsultoraID = PW.ConsultoraID) <> 0
group by PW.CampaniaID, PW.ImporteTotal, pw.ImporteCredito, ISNULL(pw.MotivoCreditoID,0),pw.PaisID,  
    PW.Clientes, PW.ConsultoraID, PW.PedidoID,	PW.FechaRegistro
ORDER BY 
	PW.CampaniaID desc 

-- agregar facturado

INSERT INTO @T1
SELECT top (@top) 
	'F',
	CA.CODIGO AS CampaniaID,
	P.MontoFacturado AS ImporteTotal,
	P.Flete,
	0 ImporteCredito,
	0 MotivoCreditoID,
	0 PaisID,
	'' Clientes,
	'FACTURADO' AS EstadoPedidoDesc,
	0 ConsultoraID,
	0 PedidoID,
	isnull(p.FechaFacturado,'1900-01-01') as FechaRegistro,
	isnull(P.Origen,'') as CanalIngreso,
	SUM(PD.Cantidad) as CantidadProductos
FROM ods.Pedido(NOLOCK) P 
INNER JOIN ods.PedidoDetalle(NOLOCK) PD ON 
	P.PedidoID=PD.PedidoID
iNNER JOIN ods.ProductoComercial (nolock) PC ON 
	PD.CampaniaID = PC.CampaniaID 
	and PD.CUV = PC.CUV
INNER JOIN ods.Campania(NOLOCK) CA ON 
	P.CampaniaID=CA.CampaniaID
INNER JOIN ods.Consultora(NOLOCK) CO ON 
	P.ConsultoraID=CO.ConsultoraID
WHERE 
	co.ConsultoraID=@ConsultoraID
	and	P.CampaniaID <> @CampaniaID
GROUP BY 
	P.PedidoID,CA.Codigo,P.MontoFacturado,P.Origen,P.Flete,p.FechaFacturado
ORDER BY 
	CA.Codigo desc 

-- eliminar repetido, <> @CampaniaID, prioridad F
delete @T1
FROM @T1 T
		INNER JOIN (
		select CampaniaID, count(EstadoPedido) AS CantEstado
		from @T1
		where CampaniaID <> @CampaniaID
		group by CampaniaID
		having count(EstadoPedido) > 1
) AS R
ON R.CampaniaID = T.CampaniaID AND T.EstadoPedido <> 'F'

SELECT top (@top)
 CampaniaID  
, ImporteTotal 
, Flete
, ImporteCredito 
, MotivoCreditoID 
, PaisID 
, Clientes 
, EstadoPedidoDesc 
, ConsultoraID 
, PedidoID
, FechaRegistro
, CanalIngreso 
, CantidadProductos 
FROM @T1 order by CampaniaID desc


end