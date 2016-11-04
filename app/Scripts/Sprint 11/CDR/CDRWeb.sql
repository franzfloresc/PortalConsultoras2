
go

IF EXISTS(
	SELECT *
	FROM INFORMATION_SCHEMA.tables 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_TYPE='BASE TABLE' AND TABLE_NAME = 'CDRWeb'
)
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
	ConsultoraID int,
	FechaRegistro datetime,
	Estado int,
	FechaCulminado datetime,
	FechaAtencion datetime,
	Importe decimal(15,2)
)


go

IF EXISTS(
	SELECT *
	FROM INFORMATION_SCHEMA.tables 
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
	MotivoRechazo varchar(1),
	Observacion varchar(1000),
	Eliminado bit
)

go

IF EXISTS(
	SELECT *
	FROM INFORMATION_SCHEMA.tables 
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
	Tipo varchar(100),
	Estado int,
	CONSTRAINT pk_CDRWebMotivoOperacion PRIMARY KEY (CodigoOperacion, CodigoReclamo)	
)

go

IF EXISTS(
	SELECT *
	FROM INFORMATION_SCHEMA.tables 
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
	Tipo varchar(100),
	Descripcion varchar(1000)
)

go

go

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

IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidosFacturadoSegunDias_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2
END

GO

CREATE PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2
	@ConsultoraID int,
	@CampaniaID int,
	@maxDias int
AS

-- GetPedidosFacturadoSegunDias_SB2 49627031, 201618, 160
BEGIN

	set @maxDias = isnull(@maxDias, 0)


	DECLARE @FechaDesde DATETIME
	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()

	set @FechaDesde = @FechaDesde - @maxDias
	

		SELECT --TOP 10
			CA.CODIGO AS CampaniaID,
			P.MontoFacturado AS ImporteTotal,
			P.Flete,
			P.PedidoID,
			isnull(p.FechaFacturado,'1900-01-01') as FechaRegistro,
			isnull(P.Origen,'') as CanalIngreso,
			--SUM(PD.Cantidad) as CantidadProductos
			-- pd.PedidoDetalleID,
			pd.CUV,
			pd.Cantidad
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
			--AND p.FechaFacturado IS NOT NULL
			and convert(date, p.FechaFacturado) >= convert(date, @FechaDesde)
		--GROUP BY 
		--	P.PedidoID,CA.Codigo,P.MontoFacturado,P.Origen,P.Flete,p.FechaFacturado
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

-- GetCDRWebMotivoOperacion 239106, 201615, 160
BEGIN

	set @CodigoOperacion = isnull(@CodigoOperacion, '')
	set @CodigoOperacion = RTRIM(LTRIM(@CodigoOperacion))
		
	set @CodigoReclamo = isnull(@CodigoReclamo, '')
	set @CodigoReclamo = RTRIM(LTRIM(@CodigoReclamo))


	SELECT 
		 mo.CodigoOperacion
		,mo.CodigoReclamo
		,mo.Prioridad
		,mo.Tipo
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

go



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

BEGIN
	
	set @CDRWebDescripcionID = isnull(@CDRWebDescripcionID, 0)

	set @CodigoSSIC = isnull(@CodigoSSIC, '')
	set @CodigoSSIC = RTRIM(LTRIM(@CodigoSSIC))
		
	set @Tipo = isnull(@Tipo, '')
	set @Tipo = RTRIM(LTRIM(@Tipo))

	SELECT 
		 CDRWebDescripcionID
		,CodigoSSIC
		,Tipo
		,Descripcion
	FROM CDRWebDescripcion
	WHERE (CDRWebDescripcionID = @CDRWebDescripcionID or @CDRWebDescripcionID = 0)
		and (CodigoSSIC = @CodigoSSIC OR @CodigoSSIC = '')
		AND (Tipo = @Tipo OR @Tipo = '')


END

go



GO

IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebDetalle' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebDetalle
END

GO

CREATE PROCEDURE dbo.GetCDRWebDetalle
	@CDRWebID int
AS

BEGIN
	
	set @CDRWebID = isnull(@CDRWebID, 0)

	SELECT 
		 CDRWebDetalleID
		,CDRWebID
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
	FROM GetCDRWebDetalle
	WHERE CDRWebID = @CDRWebID
		and Eliminado = 0


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




