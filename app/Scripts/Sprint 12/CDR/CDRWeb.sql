USE BelcorpPeru
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

/*
insert into CDRWebMotivoRechazo (CodigoRechazo, Tipo)
select CodigoRechazo,1 from ods.MotivoRechazoCDR

update CDRWebMotivoRechazo set Tipo = 2 where CDRWebMotivoRechazoID > 41
*/

IF EXISTS(
	SELECT *
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CrearSinonimo' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
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



GO

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
			isnull(P.Origen,'') as CanalIngreso
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Campania(NOLOCK) CA ON 
			P.CampaniaID=CA.CampaniaID
		INNER JOIN ods.Consultora(NOLOCK) CO ON 
			P.ConsultoraID=CO.ConsultoraID
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

IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebMotivoOperacion' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
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

IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebDescripcion' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebDescripcion
END

GO

CREATE PROCEDURE dbo.GetCDRWebDescripcion
	@CDRWebDescripcionID int,
	@CodigoSSIC VARCHAR(5),
	@Tipo VARCHAR(5)
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
GetCDRWebDetalle 1,707193021
GetCDRWebDetalle 0,707193021
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

IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
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



IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsCDRWebDetalle' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
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
as
/*
GetCDRWeb 2
GetCDRWeb 2,707193021,0
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
	order by CDRWebID desc

end

go


IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'UpdEstadoCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
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