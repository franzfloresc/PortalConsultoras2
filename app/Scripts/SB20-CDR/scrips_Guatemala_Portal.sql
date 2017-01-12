USE BelcorpGuatemala
go

--DECLARE @PermisoID INT
--DECLARE @OrdenItem INT

--if not exists(select 1 from Permiso where Descripcion = 'Cambios y Devoluciones')
--begin

--	SELECT @PermisoID=MAX(PermisoID), @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = 1003;
--	SELECT @PermisoID, @OrdenItem

--	INSERT INTO Permiso
--	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
--	VALUES(@PermisoID+1, 'Cambios y Devoluciones', 1003, @OrdenItem+1,'MisReclamos/Index',0,'Header','',0,0,0,1)
--	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(1,@PermisoID+1,1,1)

--end

--go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Pais') and SYSCOLUMNS.NAME = N'TieneCDR') = 0
	ALTER TABLE dbo.Pais ADD TieneCDR int
go

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.tables 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_TYPE='BASE TABLE' AND TABLE_NAME = 'CDRWeb')
BEGIN
    DROP TABLE dbo.CDRWeb
END


go

CREATE TABLE CDRWeb
(
	CDRWebID int IDENTITY(1,1) PRIMARY KEY,
	PedidoID int,
	PedidoNumero int,
	CampaniaID int,
	ConsultoraID bigint,
	FechaRegistro datetime,
	Estado int,
	FechaCulminado datetime,
	FechaAtencion datetime,
	Importe decimal(15,2)
)


go

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.tables 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_TYPE='BASE TABLE' AND TABLE_NAME = 'CDRWebDetalle'
)
BEGIN
    DROP TABLE dbo.CDRWebDetalle
END

go

CREATE TABLE CDRWebDetalle
(
	CDRWebDetalleID int IDENTITY(1,1) PRIMARY KEY,
	CDRWebID int,
	CodigoOperacion varchar(5),
	CodigoReclamo varchar(5),
	CUV varchar(5),
	Cantidad int,
	CUV2 varchar(5),
	Cantidad2 int,
	FechaRegistro datetime,
	Estado int,
	MotivoRechazo varchar(10),
	Observacion varchar(1000),
	Eliminado bit
)

go

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.tables 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_TYPE='BASE TABLE' AND TABLE_NAME = 'CDRWebMotivoOperacion'
)
BEGIN
    DROP TABLE dbo.CDRWebMotivoOperacion
END

go

CREATE TABLE CDRWebMotivoOperacion
(
	CodigoOperacion varchar(5),
	CodigoReclamo varchar(5),
	Prioridad int,
	Estado int,
	CONSTRAINT pk_CDRWebMotivoOperacion PRIMARY KEY (CodigoOperacion, CodigoReclamo)	
)

go

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.tables 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_TYPE='BASE TABLE' AND TABLE_NAME = 'CDRWebDescripcion'
)
BEGIN
    DROP TABLE dbo.CDRWebDescripcion
END

go

CREATE TABLE CDRWebDescripcion
(
	CDRWebDescripcionID int IDENTITY(1,1) PRIMARY KEY,
	CodigoSSIC varchar(100),
	EntidadSSIC varchar(100),
	Tipo varchar(100),
	Descripcion varchar(1000)
)

go

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.tables 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_TYPE='BASE TABLE' AND TABLE_NAME = 'CDRWebMotivoRechazo'
)
BEGIN
    DROP TABLE dbo.CDRWebMotivoRechazo
END

go

create table CDRWebMotivoRechazo
(
	CDRWebMotivoRechazoID int IDENTITY(1,1) PRIMARY KEY,
	CodigoRechazo varchar(10),
	Tipo int
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CDRWebRegionZona]') AND (type = 'U') )
	DROP TABLE [dbo].[CDRWebRegionZona]
GO

create table dbo.CDRWebRegionZona
(
	CDRWebRegionZonaID int primary key identity(1,1),
	CodigoRegion varchar(2),
	CodigoZona varchar(4),
	Estado bit
)

go
/*
insert into CDRWebRegionZona values('50','5052',1)
*/

insert into CDRWebMotivoRechazo (CodigoRechazo, Tipo)
select CodigoRechazo,2 from ods.MotivoRechazoCDR

insert into CDRWebMotivoOperacion (CodigoOperacion,CodigoReclamo,Prioridad,Estado) values('C','07',1,1)
insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('07','MotivoRechazo','Motivo','Me llegó en mal Estado')
insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('C','TipoOperacion','Solucion','REENVÍO DEL MISMO PRODUCTO')
insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('C','TipoOperacion','Propuesta','VAMOS A REENVIARTE EL MISMO PRODUCTO')
insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('C','TipoOperacion','TenerEnCuenta','Es importante que le entregues al transportista el producto a cambiar en la entrega de tu siguiente pedido, en caso contrario, el cambio será anulado y se cargará nuevamente el monto a tu saldo')
insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('C','TipoOperacion','Finalizado','Reenvío')
insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('C','TipoOperacion','MensajeFinalizado','Reenvío del mismo producto')

insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('D','TipoOperacion','Solucion','DEVOLUCIÓN DEL DINERO')
insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('D','TipoOperacion','Propuesta','VAS A DEVOLVER EL SIGUIENTE PRODUCTO')
insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('D','TipoOperacion','TenerEnCuenta','Debes entregarle al transportista el producto a devolver en la entrega de tu siguiente pedido, en caso contrario, la devolución será anulada y se cargará nuevamente el monto a tu saldo. Se descontará el puntaje del producto que vas a devolver')
insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('D','TipoOperacion','Finalizado','Devolución')
insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('D','TipoOperacion','MensajeFinalizado','Devolución del producto')

insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('03','MotivoRechazo','Motivo','No le gustó a mi cliente')
insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('08','MotivoRechazo','Motivo','Me equivoqué al solicitarlo')
insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('01','MotivoRechazo','Motivo','Me llegó sin solicitarlo')
insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('06','MotivoRechazo','Motivo','La promoción me llegó incompleta')

insert into CDRWebMotivoOperacion (CodigoOperacion,CodigoReclamo,Prioridad,Estado) values('D','07',3,1)
--insert into CDRWebMotivoOperacion (CodigoOperacion,CodigoReclamo,Prioridad,Estado) values('D','03',2,1)
insert into CDRWebMotivoOperacion (CodigoOperacion,CodigoReclamo,Prioridad,Estado) values('D','08',2,1)
insert into CDRWebMotivoOperacion (CodigoOperacion,CodigoReclamo,Prioridad,Estado) values('D','01',2,1)
insert into CDRWebMotivoOperacion (CodigoOperacion,CodigoReclamo,Prioridad,Estado) values('D','06',2,1)

--insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('10','MotivoRechazo','Motivo','No me llegó')

--insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('F','TipoOperacion','Solucion','ENVIO DEL PRODUCTO')
--insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('F','TipoOperacion','Propuesta','VAMOS A ENVIARTE EL SIGUIENTE PRODUCTO')
--insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('F','TipoOperacion','TenerEnCuenta','El producto reclamado se va a facturar de nuevo con tu siguiente pedido con las mismas condiciones de la oferta de la campaña original')
--insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('F','TipoOperacion','Finalizado','Enviar Producto')
--insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('F','TipoOperacion','MensajeFinalizado','Envío del producto facturado')

--insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('G','TipoOperacion','Solucion','DEVOLUCION DEL DINERO')
--insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('G','TipoOperacion','Propuesta','VAMOS A DESCONTAR EL PRODUCTO EN TU PROXIMO PEDIDO')
--insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('G','TipoOperacion','TenerEnCuenta','El producto será descontado en tu siguiente pedido')
--insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('G','TipoOperacion','Finalizado','Devolución')
--insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('G','TipoOperacion','MensajeFinalizado','Devolución del dinero')

--insert into CDRWebMotivoOperacion (CodigoOperacion,CodigoReclamo,Prioridad,Estado) values('F','10',1,1)
--insert into CDRWebMotivoOperacion (CodigoOperacion,CodigoReclamo,Prioridad,Estado) values('G','10',2,1)

insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('T','TipoOperacion','Solucion','CAMBIARLO POR OTRO PRODUCTO')
insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('T','TipoOperacion','Propuesta','CAMBIARLO POR OTRO PRODUCTO')
insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('T','TipoOperacion','TenerEnCuenta','Es importante que le entregues al transportista el producto a cambiar en la entrega de tu siguiente pedido, en caso contrario, el cambio será anulado y se cargará nuevamente el monto a tu saldo')
insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('T','TipoOperacion','Finalizado','Cambiar por')
insert into CDRWebDescripcion (CodigoSSIC,EntidadSSIC,Tipo,Descripcion) values ('T','TipoOperacion','MensajeFinalizado','Producto solicitado para el cambio')

insert into CDRWebMotivoOperacion (CodigoOperacion,CodigoReclamo,Prioridad,Estado) values('T','07',2,1)
insert into CDRWebMotivoOperacion (CodigoOperacion,CodigoReclamo,Prioridad,Estado) values('T','03',1,1)
insert into CDRWebMotivoOperacion (CodigoOperacion,CodigoReclamo,Prioridad,Estado) values('T','08',1,1)
insert into CDRWebMotivoOperacion (CodigoOperacion,CodigoReclamo,Prioridad,Estado) values('T','01',1,1)
insert into CDRWebMotivoOperacion (CodigoOperacion,CodigoReclamo,Prioridad,Estado) values('T','06',1,1)

go

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = 'CrearSinonimo' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE')
BEGIN
    DROP PROCEDURE dbo.CrearSinonimo
END

go

create procedure dbo.CrearSinonimo
(
	 @nametabla varchar(100)
)
as
begin
	
	declare @tabla varchar(100)
	set @tabla = isnull(@nametabla, '')
	set @tabla = RTRIM(LTRIM(@tabla))

	if	@tabla != ''
	begin
	
		declare @PrefijoPais varchar(2), @cadenaSYNONYM varchar(1000)

		IF EXISTS ( SELECT * FROM sys.synonyms WHERE name = @tabla )
		begin
			set @cadenaSYNONYM = 'DROP SYNONYM [ods].['+@tabla+']'
			exec (@cadenaSYNONYM)
		end
				

		select @PrefijoPais = PrefijoPais from pais where EstadoActivo = 1

		set @cadenaSYNONYM = 'CREATE SYNONYM ods.'+@tabla+' FOR ODS_'+@PrefijoPais+'.dbo.'+@tabla
		exec (@cadenaSYNONYM)

	end


end

go


exec CrearSinonimo 'MotivoReclamoCDR'

go

exec CrearSinonimo 'TipoOperacionesCDR'

go

exec CrearSinonimo 'MotivoRechazoCDR'

go

exec CrearSinonimo 'ParametriaCDR'

go

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = 'GetPedidosFacturadoSegunDias_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE')
BEGIN
    DROP PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2
END

GO

CREATE PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2
	@ConsultoraID int,
	@CampaniaID int,
	@maxDias int
AS
/*
GetPedidosFacturadoSegunDias_SB2 2, 201617, 142
GetPedidosFacturadoSegunDias_SB2 49401160, 201617, 142
*/
BEGIN
	set @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME
	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()

	set @FechaDesde = @FechaDesde - @maxDias
	
		SELECT
			CA.CODIGO AS CampaniaID,
			P.MontoFacturado AS ImporteTotal,
			P.Flete,
			P.PedidoID,
			isnull(p.FechaFacturado,'1900-01-01') as FechaRegistro,
			isnull(P.Origen,'') as CanalIngreso,
			isnull(p.NumeroPedido,0) as NumeroPedido,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.CDRWebID
			end as CDRWebID,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.Estado
			end as CDRWebEstado
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Campania(NOLOCK) CA ON 
			P.CampaniaID=CA.CampaniaID
		INNER JOIN ods.Consultora(NOLOCK) CO ON 
			P.ConsultoraID=CO.ConsultoraID
		LEFT JOIN CDRWeb C on
			P.PedidoID = C.PedidoID
		WHERE 
			co.ConsultoraID=@ConsultoraID
			and	P.CampaniaID <> @CampaniaID
			and convert(date, p.FechaFacturado) >= convert(date, @FechaDesde)
		ORDER BY 
			CA.Codigo desc 
END

GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = 'GetPedidosFacturadoDetalle_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE')
BEGIN
    DROP PROCEDURE dbo.GetPedidosFacturadoDetalle_SB2
END

GO

CREATE PROCEDURE dbo.GetPedidosFacturadoDetalle_SB2
	@PedidoID int
AS
/*
GetPedidosFacturadoDetalle_SB2 707193021
*/
BEGIN
		SELECT --TOP 10
			CA.CODIGO AS CampaniaID,
			pd.CUV,
			pc.Descripcion as DescripcionProd,
			pd.Cantidad,
			pd.PedidoID,
			pd.PrecioUnidad,
			pd.PrecioTotal as ImporteTotal
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
			PD.PedidoID=@PedidoID
		ORDER BY 
			CA.Codigo desc 
END

GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = 'GetCDRWebMotivoOperacion' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE')
BEGIN
    DROP PROCEDURE dbo.GetCDRWebMotivoOperacion
END

GO

CREATE PROCEDURE dbo.GetCDRWebMotivoOperacion
	@CodigoOperacion VARCHAR(5),
	@CodigoReclamo VARCHAR(5)
AS
/*
GetCDRWebMotivoOperacion null,null
*/
BEGIN

	set @CodigoOperacion = isnull(@CodigoOperacion, '')
	set @CodigoOperacion = RTRIM(LTRIM(@CodigoOperacion))
		
	set @CodigoReclamo = isnull(@CodigoReclamo, '')
	set @CodigoReclamo = RTRIM(LTRIM(@CodigoReclamo))


	SELECT 
		 mo.CodigoOperacion
		,mo.CodigoReclamo
		,mo.Prioridad
		,mo.Estado
		,o.DescripcionOperacion
		,o.NumeroDiasAtrasOperacion
		,m.DescripcionReclamo
	FROM CDRWebMotivoOperacion mo
		inner join ods.TipoOperacionesCDR o on o.CodigoOperacion = mo.CodigoOperacion
		inner join ods.MotivoReclamoCDR m on m.CodigoReclamo = mo.CodigoReclamo
	WHERE (mo.CodigoOperacion = @CodigoOperacion OR @CodigoOperacion = '')
		AND (mo.CodigoReclamo = @CodigoReclamo OR @CodigoReclamo = '')


END

GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = 'GetCDRWebDescripcion' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE')
BEGIN
    DROP PROCEDURE dbo.GetCDRWebDescripcion
END

GO

CREATE PROCEDURE dbo.GetCDRWebDescripcion
	@CDRWebDescripcionID int = null,
	@CodigoSSIC VARCHAR(5) = null,
	@Tipo VARCHAR(5) = null
AS
/*
GetCDRWebDescripcion null,null,null
*/
BEGIN
	
	set @CDRWebDescripcionID = isnull(@CDRWebDescripcionID, 0)

	set @CodigoSSIC = isnull(@CodigoSSIC, '')
	set @CodigoSSIC = RTRIM(LTRIM(@CodigoSSIC))
		
	set @Tipo = isnull(@Tipo, '')
	set @Tipo = RTRIM(LTRIM(@Tipo))

	SELECT 
		CDRWebDescripcionID
		,EntidadSSIC
		,CodigoSSIC
		,Tipo
		,Descripcion
	FROM CDRWebDescripcion
	WHERE (CDRWebDescripcionID = @CDRWebDescripcionID or @CDRWebDescripcionID = 0)
		and (CodigoSSIC = @CodigoSSIC OR @CodigoSSIC = '')
		AND (Tipo = @Tipo OR @Tipo = '')


END

GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = 'GetCDRWebDetalle' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE')
BEGIN
    DROP PROCEDURE dbo.GetCDRWebDetalle
END

GO

CREATE PROCEDURE dbo.GetCDRWebDetalle
(
	@CDRWebID int,
	@PedidoID int = 0
)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	declare @CampaniaId int = 0
	select @CampaniaId = CampaniaID from CDRWeb where CDRWebID = @CDRWebID
	
	set @CDRWebID = isnull(@CDRWebID, 0)

	--Obtener el CDRWebID
	if (@CDRWebID = 0)
	begin
		select top 1
			@CDRWebID = CDRWebID, 
			@CampaniaId = CampaniaID 
		from CDRWeb where PedidoID = @PedidoID
	end

	SELECT 
		cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,case 
			when cd.CUV2 is null or cd.CUV2='' then cd.CUV
			else cd.CUV2 end as CUV2
		,case
			when cd.CUV2 is null or cd.CUV2='' then cd.Cantidad
			else cd.Cantidad2 end as Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.Observacion
		,cd.Eliminado
		,pc.Descripcion as Descripcion
		,case
			when cd.CUV2 is null or cd.CUV2='' then pc.Descripcion
			else pc2.Descripcion end as Descripcion2
		,(pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad) as Precio
		,case
			when cd.CUV2 is null or cd.CUV2='' then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2) end as Precio2		
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc on
		cd.CUV = pc.CUV
		and pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on
		cd.CUV2 = pc2.CUV
		and pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on
		pwd.CUV = cd.CUV
		and pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr on
		cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE		 
		cd.CDRWebID = @CDRWebID
		and cd.Eliminado = 0		
END

go

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = 'InsCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE')
BEGIN
    DROP PROCEDURE dbo.InsCDRWeb
END

GO

CREATE PROCEDURE dbo.InsCDRWeb
(
	 @CDRWebID int
	,@PedidoID int
	,@PedidoNumero int
	,@CampaniaID int
	,@ConsultoraID int
	--,@FechaRegistro datetime
	--,@Estado int
	--,@FechaCulminado datetime
	,@Importe decimal(9,2)
	,@RetornoID int output
)
AS

BEGIN
	
	SET @RetornoID = 0
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	if	@CDRWebID = 0
	begin
		insert into CDRWeb(
				PedidoID
				,PedidoNumero
				,CampaniaID
				,ConsultoraID
				,FechaRegistro
				,Estado
				,FechaCulminado
				,Importe
		) values(
				 @PedidoID
				,@PedidoNumero
				,@CampaniaID
				,@ConsultoraID
				,@FechaGeneral
				,'1'
				,NULL
				,NULL
		)

		SET @RetornoID = SCOPE_IDENTITY()
	end
	else
		SET @RetornoID = @CDRWebID
END

go



IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = 'InsCDRWebDetalle' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE')
BEGIN
    DROP PROCEDURE dbo.InsCDRWebDetalle
END

GO

CREATE PROCEDURE dbo.InsCDRWebDetalle
(
	 @CDRWebDetalleID int
	,@CDRWebID int
	,@CodigoOperacion varchar(5)
	,@CodigoReclamo varchar(5)
	,@CUV varchar(5)
	,@Cantidad int
	,@CUV2 varchar(5)
	,@Cantidad2 int
	--,@FechaRegistro datetime
	--,@Estado int
	--,@MotivoRechazo varchar(1)
	--,@Observacion varchar(1000)
	--,@Eliminado bit
	,@RetornoID int output
)
AS

BEGIN
	
	SET @RetornoID = 0
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	if	@CDRWebDetalleID = 0 and @CDRWebID > 0
	begin
		insert into CDRWebDetalle(
				 CDRWebID
				,CodigoOperacion
				,CodigoReclamo
				,CUV
				,Cantidad
				,CUV2
				,Cantidad2
				,FechaRegistro
				,Estado
				,MotivoRechazo
				,Observacion
				,Eliminado
		) values(
				 @CDRWebID
				,@CodigoOperacion
				,@CodigoReclamo
				,@CUV
				,@Cantidad
				,@CUV2
				,@Cantidad2
				,@FechaGeneral
				,'1'
				,null
				,null
				,0
		)
		SET @RetornoID = SCOPE_IDENTITY()
	end
	else
		if  @CDRWebID > 0
			SET @RetornoID = @CDRWebDetalleID 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCDRWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCDRWeb
GO

create procedure dbo.GetCDRWeb
@ConsultoraID bigint
,@PedidoID int = 0
,@CampaniaID int = 0
,@CDRWebID int = 0
as
/*
GetCDRWeb 2
GetCDRWeb 2,707193021,0
GetCDRWeb 2,0,0,1
*/
begin

	select top 20
			CDRWebID,
			PedidoID,
			PedidoNumero,
			CampaniaID,
			ConsultoraID,
			FechaRegistro,
			Estado,
			FechaCulminado,
			FechaAtencion,
			Importe				
	from CDRWeb
	where ConsultoraID = @ConsultoraID
		and (PedidoID = @PedidoID or @PedidoID = 0)
		and (CampaniaID = @CampaniaID or @CampaniaID = 0)
		and (CDRWebID = @CDRWebID or @CDRWebID = 0)
	order by CDRWebID desc

end

go

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = 'UpdEstadoCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE')
BEGIN
    DROP PROCEDURE dbo.UpdEstadoCDRWeb
END

GO

CREATE PROCEDURE dbo.UpdEstadoCDRWeb
(
	 @CDRWebID int
	 ,@Estado int
	,@RetornoID int output
)
AS
/*
declare @retorno int
execute UpdEstadoCDRWeb 1,2,@retorno output
*/
BEGIN
	
	SET @RetornoID = 0
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	set @CDRWebID = isnull(@CDRWebID, 0)
	set @Estado = isnull(@Estado, 0)

	if	@CDRWebID > 0 and @Estado > 0
	begin
		update CDRWeb
		set Estado = @Estado
		, FechaCulminado = case when @Estado = 2 then @FechaGeneral else FechaCulminado end
		, FechaAtencion = case when @Estado = 2 then null else FechaAtencion end
		where CDRWebID = @CDRWebID
		
		if @Estado = 2 or @Estado = 1
		begin				
			update CDRWebDetalle
			set Estado = @Estado
			where CDRWebID = @CDRWebID
			
			SET @RetornoID = 1
		end

	end

END

go

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = 'DelCDRWebDetalle' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE')
BEGIN
    DROP PROCEDURE dbo.DelCDRWebDetalle
END

GO

create procedure dbo.DelCDRWebDetalle
@CDRWebDetalleID int
as
begin

delete from CDRWebDetalle
where CDRWebDetalleID = @CDRWebDetalleID

end

go

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = 'UpdCdrWebDetalleCantidadObservado' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE')
BEGIN
    DROP PROCEDURE dbo.UpdCdrWebDetalleCantidadObservado
END

GO

create procedure dbo.UpdCdrWebDetalleCantidadObservado
@CDRWebDetalleID int,
@Cantidad int
as
begin

update CDRWebDetalle
set
	Cantidad = @Cantidad
where 
	CDRWebDetalleID = @CDRWebDetalleID
	
end

go

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = 'GetCDRParametria' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE')
BEGIN
    DROP PROCEDURE dbo.GetCDRParametria
END

GO

create procedure dbo.GetCDRParametria
@CodigoParametria varchar(20) = null
as
/*
GetCDRParametria
GetCDRParametria 'STO_DESV_TRQ'
*/
begin

set @CodigoParametria = isnull(@CodigoParametria,'')

select 
	CodigoParametria,
	DescripcionParametria,
	ValorParametria
from ods.ParametriaCDR
where
	CodigoParametria = @CodigoParametria or @CodigoParametria = ''
	

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCDRWebById]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCDRWebById
GO

create procedure dbo.GetCDRWebById
@CDRWebID int
as
/*
GetCDRWebById 1
*/
begin

	select
			CDRWebID,
			PedidoID,
			PedidoNumero,
			CampaniaID,
			ConsultoraID,
			FechaRegistro,
			Estado,
			FechaCulminado,
			FechaAtencion,
			Importe				
	from CDRWeb
	where CDRWebID = @CDRWebID

end

go

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = 'GetCDRWebDetalleLog' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE')
BEGIN
    DROP PROCEDURE dbo.GetCDRWebDetalleLog
END

GO

CREATE PROCEDURE dbo.GetCDRWebDetalleLog
(
	@LogCDRWebID int
)
AS
/*
GetCDRWebDetalleLog 16
*/
BEGIN	
	declare @Campania int = 0
	declare @CDRWebId int = 0
	select @Campania = CampaniaId, @CDRWebId = CDRWebId from interfaces.LogCDRWeb
	where LogCDRWebID = @LogCDRWebID  

	declare @PedidoId int = 0
	select @PedidoId = PedidoId from CDRWeb
	where CDRWebId = @CDRWebId

	SELECT 
		cd.CDRWebDetalleID
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR as CodigoOperacion
		,cd.CodigoMotivoCDR as CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR as Estado
		,cd.CodigoRechazo as MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.ObservacionRechazo as Observacion		
		,pc.Descripcion as Descripcion
		,isnull(pc2.Descripcion,'') as Descripcion2
		,(pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad) as Precio
		,isnull((pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2),0) as Precio2		
	FROM interfaces.LogCDRWeb c		
	INNER JOIN interfaces.LogCDRWebDetalle cd on
		c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on
		c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on
		cd.CUV = pc.CUV
		and pc.AnoCampania = @Campania
	LEFT JOIN ods.ProductoComercial pc2 on
		cd.CUV2 = pc2.CUV
		and pc2.AnoCampania = @Campania
	INNER JOIN ods.PedidoDetalle pwd on
		pwd.CUV = cd.CUV
		and pwd.PedidoID = @PedidoId
	LEFT JOIN CDRWebMotivoRechazo cmr on
		cd.CodigoRechazo = cmr.CodigoRechazo
	WHERE		 
		c.LogCDRWebID = @LogCDRWebID		
END

go

ALTER PROCEDURE [dbo].[GetSesionUsuario_SB2]
	@CodigoConsultora varchar(25)
AS
/*
GetSesionUsuario_SB2 '0100007'
*/
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int

	DECLARE @FechaLimitePago SMALLDATETIME
	DECLARE @ODSCampaniaID INT

	declare @PaisID int
	declare @UsuarioPrueba bit
	declare @CodConsultora varchar(20)
	declare @CampaniaID int
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint
	declare @IndicadorPermiso int
	declare @CodigoFicticio varchar(20)
	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoConsultora

	declare @CountCodigoNivel bigint

	/*Oferta Final, Catalogo Personalizado, CDR*/
	declare @EsOfertaFinalZonaValida bit = 0
	declare @EsOFGanaMasZonaValida bit = 0
	declare @EsCatalogoPersonalizadoZonaValida bit = 0
	declare @EsCDRWebZonaValida  bit = 0
	declare @CodigoZona varchar(4) = ''
	declare @CodigoRegion varchar(2) = ''

	select
		@CodigoZona = IsNull(z.Codigo,''),
		@CodigoRegion = IsNull(r.Codigo,'')
	from ods.consultora c with(nolock)
	inner join ods.Region r on
		c.RegionID = r.RegionID
	inner join ods.Zona z on
		c.ZonaID = z.ZonaID
	where c.codigo = @CodConsultora

	if not exists (select 1 from OfertaFinalRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOfertaFinalZonaValida = 1

	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
	
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1
	
	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/

	IF @UsuarioPrueba = 0
	BEGIN
		select @ZonaID = IsNull(ZonaID,0),
			@RegionID = IsNull(RegionID,0),
			@ConsultoraID = IsNull(ConsultoraID,0)
		from ods.consultora with(nolock)
		where codigo = @CodConsultora

		select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

			-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
			declare @CampaniaFacturada int = 0

			 select top 1 @CampaniaFacturada = p.CampaniaID
			FROM ods.Pedido(NOLOCK) P
				INNER JOIN ods.Consultora(NOLOCK) CO ON
					P.ConsultoraID=CO.ConsultoraID
				WHERE
					co.ConsultoraID=@ConsultoraID
					and	P.CampaniaID <> @ODSCampaniaID
					and	CO.RegionID=@RegionID
					and	CO.ZonaID=@ZonaID
			order by PedidoID desc

			SET @FechaLimitePago = (
				SELECT FECHALIMITEPAGO
				FROM ODS.Cronograma
				WHERE CampaniaID=@CampaniaFacturada AND RegionID=@RegionID AND ZonaID = @ZonaID  AND EstadoActivo=1
			)
			SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @IndicadorPermiso = (Select dbo.GetPermisoFIC(@CodigoConsultora,@ZonaID,@CampaniaID))

		--SSAP CGI(Id Solicitud=1402)
		--begin
		declare @IndicadorOfertaFIC int
		declare @ImagenUrlOfertaFIC varchar(500)
		SET @IndicadorOfertaFIC = (SELECT dbo.GetIndicadorOfertaFIC(@CampaniaID))
		if @IndicadorOfertaFIC>=1
		begin
			SET @ImagenUrlOfertaFIC = (SELECT dbo.GetImagenOfertaFIC(@CampaniaID))
		end
		else
		begin
			SET @ImagenUrlOfertaFIC = ''
		end
		--end
		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID

		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			@IndicadorPermiso IndicadorPermisoFIC,
			ro.Descripcion as RolDescripcion,
			@IndicadorOfertaFIC IndicadorOfertaFIC,--SSAP CGI(Id Solicitud=1402)
			@ImagenUrlOfertaFIC ImagenUrlOfertaFIC,--SSAP CGI(Id Solicitud=1402)
			(select top 1 isnull(NroCampanias,0) from pais where CodigoISO=p.CodigoISO) NroCampanias,
			isnull(c.EsJoven,0) EsJoven,
			(case
				when @CountCodigoNivel =0 then 0  --1589
				when @CountCodigoNivel>0 then 1 End) Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			null as ConsultoraAsociada, --1688
			isnull(si.descripcion,null) SegmentoConstancia, --2469
			isnull(se.Codigo,null) Seccion, --2469
			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469
			case When cl.ConsultoraID is null then 0
			else 1 end esConsultoraLider,
			u.EMailActivo, --2532
			si.SegmentoInternoId,
			isnull(p.OfertaFinal,0) as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR
		FROM [dbo].[Usuario] u with(nolock)
		LEFT JOIN (
		select *
		from ods.consultora with(nolock)
		where ConsultoraId = @ConsultoraID
		) c ON u.CodigoConsultora = c.Codigo
		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID
		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469
		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469
		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t with(nolock) ON c.TerritorioID = t.TerritorioID
            AND c.SeccionID = t.SeccionID AND c.ZonaID = t.ZonaID
            AND c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		WHERE
			ro.Sistema = 1
			and u.CodigoUsuario = @CodigoConsultora
	END
	ELSE
	BEGIN
		SET @CodigoFicticio = (SELECT TOP 1 CodigoConsultoraAsociada FROM UsuarioPrueba with(nolock) WHERE CodigoFicticio = @CodConsultora)
		SET @IndicadorPermiso = (SELECT dbo.GetPermisoFIC(@CodigoConsultora,@ZonaID,@CampaniaID))

		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			@IndicadorPermiso IndicadorPermisoFIC,
			ro.Descripcion as RolDescripcion,
			@IndicadorOfertaFIC IndicadorOfertaFIC,--SSAP CGI(Id Solicitud=1402)
			@ImagenUrlOfertaFIC ImagenUrlOfertaFIC,--SSAP CGI(Id Solicitud=1402)
			(select top 1 isnull(NroCampanias,0) from pais where CodigoISO=p.CodigoISO) NroCampanias,
			(case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1 End) Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			isnull(p.OfertaFinal,0) as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR
		FROM [dbo].[Usuario] u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON c.TerritorioID = t.TerritorioID
			AND c.SeccionID = t.SeccionID
            AND c.ZonaID = t.ZonaID
            AND c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		WHERE
			ro.Sistema = 1
			and u.CodigoUsuario = @CodigoConsultora
	END
END

go

IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetLogCDRWebByLogCDRWebId' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE interfaces.GetLogCDRWebByLogCDRWebId
END
GO
CREATE PROCEDURE interfaces.GetLogCDRWebByLogCDRWebId
	@LogCDRWebId BIGINT
AS
/*
interfaces.GetLogCDRWebByLogCDRWebId 2
*/
BEGIN		
	SELECT
		LogCDRWebId,
		CDRWebId,
		CampaniaId,
		PedidoFacturadoId,
		ConsultoraId,
		CodigoConsultora,
		FechaRegistro,
		FechaCulminado,
		FechaAtencion,
		EstadoCDR
	FROM interfaces.LogCDRWeb
	WHERE LogCDRWebId = @LogCDRWebId;
END
GO

IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdLogCDRWebVisualizado' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE interfaces.UpdLogCDRWebVisualizado
END
GO
CREATE PROCEDURE interfaces.UpdLogCDRWebVisualizado
	@LogCDRWebId BIGINT
AS
BEGIN
	UPDATE interfaces.LogCDRWeb
	SET Visualizado = 1
	WHERE LogCDRWebId = @LogCDRWebId;
END
GO

ALTER PROCEDURE dbo.GetNotificacionesConsultora
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN
	declare @Temporal table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidación datetime,
		EnvioCorreo bit,
		Proceso varchar(20),
		Estado int,
		Observaciones varchar(500),
		FechaFacturacion date,
		Asunto varchar(500),
		FacturaHoy bit,
		Visualizado bit,
		EsMontoMinino bit,
		FlagProcedencia bit
	)

	declare @TemporalStock table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidación datetime,
		EnvioCorreo bit,
		Proceso varchar(20),
		Estado int,
		Observaciones varchar(500),
		FechaFacturacion date,
		Asunto varchar(500),
		FacturaHoy bit,
		Visualizado bit,
		EsMontoMinino bit,
		FlagProcedencia bit
	)

	insert into @TemporalStock
	select MIN(vs.ValidacionStockPROLLogId) as ProcesoId,0 as CampaniaId, '' as EstadoPROL,
	v.FechaHoraInicio as FechaHoraValidación, 0 as EnvioCorreo, 'VALSTOCK' as Proceso, 0 as Estado, cast(vs.ValidacionStockProlId as varchar) as Observaciones,
	'2000-01-01' as FechaFacturacion, 'Validación de Stock' as Asunto , 0 as FacturaHoy, 0 as Visualizado, 0 as EsMontoMinino,0 as 'FlagProcedencia' 
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.Consultora c with(nolock) on vs.Codigo = c.Codigo
	inner join ValidacionStockPROL v with(nolock) on vs.ValidacionStockProlId = v.ValidacionStockProlId
	where c.ConsultoraId = @ConsultoraId and vs.Enviocorreo = 1
	group by vs.ValidacionStockProlId,v.FechaHOraInicio;

	insert into @Temporal
	select ValAutomaticaPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,
	ISNULL(EnvioCorreo,0) as EnvioCorreo, 'VALAUTO' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con éxito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto mínimo','Pedido no reservado por monto máximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia'
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId
	
	UNION ALL
	
	select ValidacionMovilPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,
	0 as EnvioCorreo, 'VALMOVIL' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con éxito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto mínimo','Pedido no reservado por monto máximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia'
	from ValidacionMovilPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL
	
	select st.ProcesoId,
		st.CampaniaId,
		st.EstadoPROL,
		st.FechaHoraValidación,
		st.EnvioCorreo,
		st.Proceso,
		st.Estado,
		st.Observaciones,
		st.FechaFacturacion,
		st.Asunto,
		st.FacturaHoy,
		ISNULL(i.Visualizado,0),
		st.EsMontoMinino,
		0 as 'FlagProcedencia'
	from @TemporalStock st
	left join ValidacionStockPROLInfo i with(nolock) on st.ProcesoId = i.ValidacionStockPROLLogId

	UNION ALL
	
	select
		SolicitudClienteID as ProcesoId,
		Campania as CampaniaId,
		'' as EstadoPROL,
		FechaSolicitud as FechaHoraValidación,
		cast(1 as bit) as EnvioCorreo,
		'BUSCACONS' as Proceso,
		IIF(Estado IS NULL, 0, 1) as Estado,
		'' as Observaciones,
		GETDATE()  as FechaFacturacion,
		CONCAT('Pedido de nuevo cliente ',UPPER(NombreCompleto)) as Asunto,
		cast(0 as bit) as FacturaHoy,
		Leido as Visualizado,
		cast(0 as bit) as EsMontoMinino,
		1 as 'FlagProcedencia'
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))

	UNION ALL
	
	select 
		S.SolicitudClienteCatalogoID as ProcesoId,
		S.Campania as CampaniaId,
		'' as EstadoPROL,
		S.FechaRegistro as FechaHoraValidación,
		cast(0 as bit) as EnvioCorreo,
		'CATALOGO' as Proceso,
		1  as Estado,
		'' as Observaciones,
		GETDATE()  as FechaFacturacion, 
		S.AsuntoNotificacion as Asunto,
		cast(0 as bit) as FacturaHoy,
		S.Visualizado AS Visualizado,
		cast(0 as bit) as EsMontoMinino,
		1 as FlagProcedencia
	from SolicitudClienteCatalogo S
	INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId  AND S.CodigoConsultora = C.Codigo
	
	UNION ALL
	
	SELECT
		LGPRV.LogGPRValidacionId AS ProcesoId,
		PR.Campania AS CampaniaId,
		'' AS EstadoPROL,
		LGPRV.FechaFinValidacion AS FechaHoraValidación,
		CAST(0 AS BIT) as EnvioCorreo,
		'PEDREC' AS Proceso,
		1 AS Estado,
		'' AS Observaciones,
		GETDATE()  AS FechaFacturacion, 
		CONCAT('Pedido Rechazado: ', LGPRV.DescripcionRechazo) AS Asunto,
		CAST(0 AS BIT) AS FacturaHoy,
		LGPRV.Visualizado AS Visualizado,
		CAST(0 AS BIT) AS EsMontoMinino,
		1 AS FlagProcedencia
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId;

	IF(@ShowCDR = 1)
	BEGIN
		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.CampaniaId,
			'' AS EstadoPROL,
			LCDRW.FechaAtencion AS FechaHoraValidación,
			LCDRW.EnvioCorreo,
			'CDR' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE() AS FechaFacturacion,
			CONCAT('CDR: ', IIF(LCDRW.EstadoCDR = 3, 'APROBADO', 'RECHAZADO')) AS Asunto,
			CAST(0 AS BIT) AS FacturaHoy,
			LCDRW.Visualizado AS Visualizado,
			CAST(0 AS BIT) AS EsMontoMinino,
			1 AS FlagProcedencia
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId;
	END

	select top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
	Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
	from @Temporal
	order by FechaHoraValidación desc;
END
GO