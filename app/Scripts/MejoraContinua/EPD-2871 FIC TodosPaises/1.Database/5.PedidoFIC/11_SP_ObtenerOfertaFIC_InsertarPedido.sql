GO
IF OBJECT_ID('ObtenerOfertaFIC_InsertarPedido') IS NULL
	exec sp_executesql N'CREATE PROCEDURE ObtenerOfertaFIC_InsertarPedido AS';
GO
ALTER PROCEDURE ObtenerOfertaFIC_InsertarPedido
	@CampaniaID INT,
	@ConsultoraID int,
	@PaisID int,
	@IPUsuario varchar(25) =NULL,
	@CodigoUsuarioCreacion varchar(25) = null
AS
BEGIN
	DECLARE @ProductoFaltanteTemp TABLE
	(CUV varchar(6))

	INSERT INTO @ProductoFaltanteTemp
	select distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante nolock
	where CampaniaID = @CampaniaID 
	UNION ALL
	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa (nolock)
	inner join ods.Campania c (nolock) on fa.CampaniaID = c.CampaniaID
	where c.Codigo = @CampaniaID and (fa.CodigoZona is null)
	DECLARE @Productos TABLE
	(
		Id INT IDENTITY(1,1),	
		CUV VARCHAR(50),
		Descripcion VARCHAR(100),
		PrecioCatalogo numeric(12, 2) NULL,
		MarcaID INT,
		EstaEnRevista INT,
		TieneStock INT,
		EsExpoOferta BIT,
		CUVRevista VARCHAR(20),
		CUVComplemento VARCHAR(20),
		PaisID INT,
		CampaniaID INT,
		CodigoCatalago VARCHAR(20),
		CodigoProducto VARCHAR(12),
		IndicadorMontoMinimo int
	)
	INSERT INTO @Productos
	select distinct  p.CUV, 
				coalesce(  pd.Descripcion, p.Descripcion) AS Descripcion,
				coalesce( pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo, 
				p.MarcaID, --
				0 AS EstaEnRevista,--
				(case when ISNULL(pf.CUV,0) = 0 then 1 when ISNULL(pf.CUV,0) > 0 then 0 end) AS TieneStock,--
				ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,--- 
				ISNULL(pcc.CUVRevista,'') AS CUVRevista,	---	
				'' AS CUVComplemento, ----
				p.PaisID, ---
				p.AnoCampania AS CampaniaID,----
				p.CodigoCatalago,----
				p.CodigoProducto,
				p.IndicadorMontoMinimo
		from	 OfertaFIC CA
		inner JOIN ods.ProductoComercial p ON p.AnoCampania = CA.CampaniaID -1 AND p.CUV = CA.CUV
		left join dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
		left join @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		left join ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
		where	p.AnoCampania = @CampaniaID AND 
				p.IndicadorDigitable = 1 AND
		NOT EXISTS (
				SELECT * 
					FROM OfertaProducto opr 
						inner join ods.Campania c on 
						opr.CampaniaID = c.CampaniaID
					WHERE opr.CampaniaID = p.CampaniaID
						  and opr.cuv = p.cuv
						  and opr.flaghabilitarproducto = 0
						  and c.codigo = @CampaniaID
					)
				AND 
				NOT EXISTS (
					SELECT * 
					FROM OfertaNueva opr 
					WHERE opr.cuv = p.cuv
						  and opr.flaghabilitaroferta = 0
						  and opr.CampaniaID = @CampaniaID
					)
	declare @p5 int
	set @p5=0
	exec dbo.InsPedidoWeb @CampaniaID,@ConsultoraID,@PaisID,@IPUsuario,@p5 output,@CodigoUsuarioCreacion
	--SELECT @p5
	DECLARE @i INTEGER
	SET @i=1
	DECLARE @contador INTEGER
	SELECT @contador=COUNT(*) FROM @Productos
	DECLARE @ImporteTotal numeric(12, 2)
	SET @ImporteTotal=0
	WHILE @i<=@contador
	BEGIN
		--PRINT 'Prueba'
		DECLARE @MarcaID INT
		DECLARE @PrecioUnidad numeric(12, 2)  
		DECLARE @CUV VARCHAR(50)
		DECLARE @OfertaWeb BIT
		SELECT @MarcaID=MarcaID,@PrecioUnidad=PrecioCatalogo,@CUV=CUV,@OfertaWeb=EsExpoOferta 
		FROM @Productos WHERE Id=@i
		declare @PedidoDetalleID int
		set @PedidoDetalleID=0
		select @PedidoDetalleID=count(PedidoDetalleID )
		from PedidoWebDetalle 
		where CUV=@CUV and CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID
		if @PedidoDetalleID =0
		begin
			SET @ImporteTotal=@ImporteTotal + @PrecioUnidad
			declare @p12 smallint
			set @p12=1
			exec dbo.InsPedidoWebDetalle @CampaniaID,@ConsultoraID,@MarcaID,NULL,1,@PrecioUnidad,@CUV,@p5,@OfertaWeb,0,0,@p12 output,@CodigoUsuarioCreacion, 0
		end
	
		SET @i=@i+1
	END
	exec dbo.UpdPedidoWebTotales @CampaniaID,@p5,0,@ImporteTotal,@CodigoUsuarioCreacion
	SELECT @p5;
END
GO