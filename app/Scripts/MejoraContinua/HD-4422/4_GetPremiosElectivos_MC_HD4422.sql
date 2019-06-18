USE [BelcorpBolivia];
GO
ALTER PROC GetPremiosElectivos
(
@CampaniaID int,
@CodigoPrograma varchar(10),
@CodigoNivel varchar(2)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		@CampaniaID AS CampaniaID	,
		e.ImagenURL					,
		e.DescripcionCUV2			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		pc.MarcaId					,
		m.Descripcion AS DescripcionMarca,
		e.TipoEstrategiaId			,
		c.PrecioUnitario
	FROM ods.CuponesProgramaNuevas c With(nolock)
	LEFT join dbo.Estrategia e  With(nolock) on 
		c.CodigoCupon = e.CUV2 and
		c.CodigoPrograma = e.CodigoPrograma and
		e.activo = 1 and
		e.campaniaid <= @CampaniaID and e.campaniaidfin >= @CampaniaID
	LEFT JOIN ods.Campania ca with(nolock) ON @CampaniaID = ca.Codigo
	LEFT join ods.ProductoComercial pc with(nolock) ON ca.CampaniaID = pc.CampaniaID AND c.CodigoCupon = pc.CUV
	LEFT JOIN dbo.Marca m WITH (NOLOCK) ON pc.MarcaId = m.MarcaId

	where 
		isnull(c.Campana,'') != ''
		and c.CodigoPrograma = @CodigoPrograma
		and c.CodigoNivel = @CodigoNivel
		and c.Campana = cast(@CampaniaID as varchar(6))
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
USE [BelcorpChile];
GO
ALTER PROC GetPremiosElectivos
(
@CampaniaID int,
@CodigoPrograma varchar(10),
@CodigoNivel varchar(2)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		@CampaniaID AS CampaniaID	,
		e.ImagenURL					,
		e.DescripcionCUV2			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		pc.MarcaId					,
		m.Descripcion AS DescripcionMarca,
		e.TipoEstrategiaId			,
		c.PrecioUnitario
	FROM ods.CuponesProgramaNuevas c With(nolock)
	LEFT join dbo.Estrategia e  With(nolock) on 
		c.CodigoCupon = e.CUV2 and
		c.CodigoPrograma = e.CodigoPrograma and
		e.activo = 1 and
		e.campaniaid <= @CampaniaID and e.campaniaidfin >= @CampaniaID
	LEFT JOIN ods.Campania ca with(nolock) ON @CampaniaID = ca.Codigo
	LEFT join ods.ProductoComercial pc with(nolock) ON ca.CampaniaID = pc.CampaniaID AND c.CodigoCupon = pc.CUV
	LEFT JOIN dbo.Marca m WITH (NOLOCK) ON pc.MarcaId = m.MarcaId

	where 
		isnull(c.Campana,'') != ''
		and c.CodigoPrograma = @CodigoPrograma
		and c.CodigoNivel = @CodigoNivel
		and c.Campana = cast(@CampaniaID as varchar(6))
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
USE [BelcorpColombia];
GO
ALTER PROC GetPremiosElectivos
(
@CampaniaID int,
@CodigoPrograma varchar(10),
@CodigoNivel varchar(2)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		@CampaniaID AS CampaniaID	,
		e.ImagenURL					,
		e.DescripcionCUV2			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		pc.MarcaId					,
		m.Descripcion AS DescripcionMarca,
		e.TipoEstrategiaId			,
		c.PrecioUnitario
	FROM ods.CuponesProgramaNuevas c With(nolock)
	LEFT join dbo.Estrategia e  With(nolock) on 
		c.CodigoCupon = e.CUV2 and
		c.CodigoPrograma = e.CodigoPrograma and
		e.activo = 1 and
		e.campaniaid <= @CampaniaID and e.campaniaidfin >= @CampaniaID
	LEFT JOIN ods.Campania ca with(nolock) ON @CampaniaID = ca.Codigo
	LEFT join ods.ProductoComercial pc with(nolock) ON ca.CampaniaID = pc.CampaniaID AND c.CodigoCupon = pc.CUV
	LEFT JOIN dbo.Marca m WITH (NOLOCK) ON pc.MarcaId = m.MarcaId

	where 
		isnull(c.Campana,'') != ''
		and c.CodigoPrograma = @CodigoPrograma
		and c.CodigoNivel = @CodigoNivel
		and c.Campana = cast(@CampaniaID as varchar(6))
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
USE [BelcorpCostaRica];
GO
ALTER PROC GetPremiosElectivos
(
@CampaniaID int,
@CodigoPrograma varchar(10),
@CodigoNivel varchar(2)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		@CampaniaID AS CampaniaID	,
		e.ImagenURL					,
		e.DescripcionCUV2			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		pc.MarcaId					,
		m.Descripcion AS DescripcionMarca,
		e.TipoEstrategiaId			,
		c.PrecioUnitario
	FROM ods.CuponesProgramaNuevas c With(nolock)
	LEFT join dbo.Estrategia e  With(nolock) on 
		c.CodigoCupon = e.CUV2 and
		c.CodigoPrograma = e.CodigoPrograma and
		e.activo = 1 and
		e.campaniaid <= @CampaniaID and e.campaniaidfin >= @CampaniaID
	LEFT JOIN ods.Campania ca with(nolock) ON @CampaniaID = ca.Codigo
	LEFT join ods.ProductoComercial pc with(nolock) ON ca.CampaniaID = pc.CampaniaID AND c.CodigoCupon = pc.CUV
	LEFT JOIN dbo.Marca m WITH (NOLOCK) ON pc.MarcaId = m.MarcaId

	where 
		isnull(c.Campana,'') != ''
		and c.CodigoPrograma = @CodigoPrograma
		and c.CodigoNivel = @CodigoNivel
		and c.Campana = cast(@CampaniaID as varchar(6))
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
USE [BelcorpDominicana];
GO
ALTER PROC GetPremiosElectivos
(
@CampaniaID int,
@CodigoPrograma varchar(10),
@CodigoNivel varchar(2)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		@CampaniaID AS CampaniaID	,
		e.ImagenURL					,
		e.DescripcionCUV2			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		pc.MarcaId					,
		m.Descripcion AS DescripcionMarca,
		e.TipoEstrategiaId			,
		c.PrecioUnitario
	FROM ods.CuponesProgramaNuevas c With(nolock)
	LEFT join dbo.Estrategia e  With(nolock) on 
		c.CodigoCupon = e.CUV2 and
		c.CodigoPrograma = e.CodigoPrograma and
		e.activo = 1 and
		e.campaniaid <= @CampaniaID and e.campaniaidfin >= @CampaniaID
	LEFT JOIN ods.Campania ca with(nolock) ON @CampaniaID = ca.Codigo
	LEFT join ods.ProductoComercial pc with(nolock) ON ca.CampaniaID = pc.CampaniaID AND c.CodigoCupon = pc.CUV
	LEFT JOIN dbo.Marca m WITH (NOLOCK) ON pc.MarcaId = m.MarcaId

	where 
		isnull(c.Campana,'') != ''
		and c.CodigoPrograma = @CodigoPrograma
		and c.CodigoNivel = @CodigoNivel
		and c.Campana = cast(@CampaniaID as varchar(6))
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
USE [BelcorpEcuador];
GO
ALTER PROC GetPremiosElectivos
(
@CampaniaID int,
@CodigoPrograma varchar(10),
@CodigoNivel varchar(2)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		@CampaniaID AS CampaniaID	,
		e.ImagenURL					,
		e.DescripcionCUV2			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		pc.MarcaId					,
		m.Descripcion AS DescripcionMarca,
		e.TipoEstrategiaId			,
		c.PrecioUnitario
	FROM ods.CuponesProgramaNuevas c With(nolock)
	LEFT join dbo.Estrategia e  With(nolock) on 
		c.CodigoCupon = e.CUV2 and
		c.CodigoPrograma = e.CodigoPrograma and
		e.activo = 1 and
		e.campaniaid <= @CampaniaID and e.campaniaidfin >= @CampaniaID
	LEFT JOIN ods.Campania ca with(nolock) ON @CampaniaID = ca.Codigo
	LEFT join ods.ProductoComercial pc with(nolock) ON ca.CampaniaID = pc.CampaniaID AND c.CodigoCupon = pc.CUV
	LEFT JOIN dbo.Marca m WITH (NOLOCK) ON pc.MarcaId = m.MarcaId

	where 
		isnull(c.Campana,'') != ''
		and c.CodigoPrograma = @CodigoPrograma
		and c.CodigoNivel = @CodigoNivel
		and c.Campana = cast(@CampaniaID as varchar(6))
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
USE [BelcorpGuatemala];
GO
ALTER PROC GetPremiosElectivos
(
@CampaniaID int,
@CodigoPrograma varchar(10),
@CodigoNivel varchar(2)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		@CampaniaID AS CampaniaID	,
		e.ImagenURL					,
		e.DescripcionCUV2			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		pc.MarcaId					,
		m.Descripcion AS DescripcionMarca,
		e.TipoEstrategiaId			,
		c.PrecioUnitario
	FROM ods.CuponesProgramaNuevas c With(nolock)
	LEFT join dbo.Estrategia e  With(nolock) on 
		c.CodigoCupon = e.CUV2 and
		c.CodigoPrograma = e.CodigoPrograma and
		e.activo = 1 and
		e.campaniaid <= @CampaniaID and e.campaniaidfin >= @CampaniaID
	LEFT JOIN ods.Campania ca with(nolock) ON @CampaniaID = ca.Codigo
	LEFT join ods.ProductoComercial pc with(nolock) ON ca.CampaniaID = pc.CampaniaID AND c.CodigoCupon = pc.CUV
	LEFT JOIN dbo.Marca m WITH (NOLOCK) ON pc.MarcaId = m.MarcaId

	where 
		isnull(c.Campana,'') != ''
		and c.CodigoPrograma = @CodigoPrograma
		and c.CodigoNivel = @CodigoNivel
		and c.Campana = cast(@CampaniaID as varchar(6))
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
USE [BelcorpMexico];
GO
ALTER PROC GetPremiosElectivos
(
@CampaniaID int,
@CodigoPrograma varchar(10),
@CodigoNivel varchar(2)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		@CampaniaID AS CampaniaID	,
		e.ImagenURL					,
		e.DescripcionCUV2			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		pc.MarcaId					,
		m.Descripcion AS DescripcionMarca,
		e.TipoEstrategiaId			,
		c.PrecioUnitario
	FROM ods.CuponesProgramaNuevas c With(nolock)
	LEFT join dbo.Estrategia e  With(nolock) on 
		c.CodigoCupon = e.CUV2 and
		c.CodigoPrograma = e.CodigoPrograma and
		e.activo = 1 and
		e.campaniaid <= @CampaniaID and e.campaniaidfin >= @CampaniaID
	LEFT JOIN ods.Campania ca with(nolock) ON @CampaniaID = ca.Codigo
	LEFT join ods.ProductoComercial pc with(nolock) ON ca.CampaniaID = pc.CampaniaID AND c.CodigoCupon = pc.CUV
	LEFT JOIN dbo.Marca m WITH (NOLOCK) ON pc.MarcaId = m.MarcaId

	where 
		isnull(c.Campana,'') != ''
		and c.CodigoPrograma = @CodigoPrograma
		and c.CodigoNivel = @CodigoNivel
		and c.Campana = cast(@CampaniaID as varchar(6))
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
USE [BelcorpPanama];
GO
ALTER PROC GetPremiosElectivos
(
@CampaniaID int,
@CodigoPrograma varchar(10),
@CodigoNivel varchar(2)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		@CampaniaID AS CampaniaID	,
		e.ImagenURL					,
		e.DescripcionCUV2			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		pc.MarcaId					,
		m.Descripcion AS DescripcionMarca,
		e.TipoEstrategiaId			,
		c.PrecioUnitario
	FROM ods.CuponesProgramaNuevas c With(nolock)
	LEFT join dbo.Estrategia e  With(nolock) on 
		c.CodigoCupon = e.CUV2 and
		c.CodigoPrograma = e.CodigoPrograma and
		e.activo = 1 and
		e.campaniaid <= @CampaniaID and e.campaniaidfin >= @CampaniaID
	LEFT JOIN ods.Campania ca with(nolock) ON @CampaniaID = ca.Codigo
	LEFT join ods.ProductoComercial pc with(nolock) ON ca.CampaniaID = pc.CampaniaID AND c.CodigoCupon = pc.CUV
	LEFT JOIN dbo.Marca m WITH (NOLOCK) ON pc.MarcaId = m.MarcaId

	where 
		isnull(c.Campana,'') != ''
		and c.CodigoPrograma = @CodigoPrograma
		and c.CodigoNivel = @CodigoNivel
		and c.Campana = cast(@CampaniaID as varchar(6))
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
USE [BelcorpPeru];
GO
ALTER PROC GetPremiosElectivos
(
@CampaniaID int,
@CodigoPrograma varchar(10),
@CodigoNivel varchar(2)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		@CampaniaID AS CampaniaID	,
		e.ImagenURL					,
		e.DescripcionCUV2			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		pc.MarcaId					,
		m.Descripcion AS DescripcionMarca,
		e.TipoEstrategiaId			,
		c.PrecioUnitario
	FROM ods.CuponesProgramaNuevas c With(nolock)
	LEFT join dbo.Estrategia e  With(nolock) on 
		c.CodigoCupon = e.CUV2 and
		c.CodigoPrograma = e.CodigoPrograma and
		e.activo = 1 and
		e.campaniaid <= @CampaniaID and e.campaniaidfin >= @CampaniaID
	LEFT JOIN ods.Campania ca with(nolock) ON @CampaniaID = ca.Codigo
	LEFT join ods.ProductoComercial pc with(nolock) ON ca.CampaniaID = pc.CampaniaID AND c.CodigoCupon = pc.CUV
	LEFT JOIN dbo.Marca m WITH (NOLOCK) ON pc.MarcaId = m.MarcaId

	where 
		isnull(c.Campana,'') != ''
		and c.CodigoPrograma = @CodigoPrograma
		and c.CodigoNivel = @CodigoNivel
		and c.Campana = cast(@CampaniaID as varchar(6))
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
USE [BelcorpPuertoRico];
GO
ALTER PROC GetPremiosElectivos
(
@CampaniaID int,
@CodigoPrograma varchar(10),
@CodigoNivel varchar(2)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		@CampaniaID AS CampaniaID	,
		e.ImagenURL					,
		e.DescripcionCUV2			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		pc.MarcaId					,
		m.Descripcion AS DescripcionMarca,
		e.TipoEstrategiaId			,
		c.PrecioUnitario
	FROM ods.CuponesProgramaNuevas c With(nolock)
	LEFT join dbo.Estrategia e  With(nolock) on 
		c.CodigoCupon = e.CUV2 and
		c.CodigoPrograma = e.CodigoPrograma and
		e.activo = 1 and
		e.campaniaid <= @CampaniaID and e.campaniaidfin >= @CampaniaID
	LEFT JOIN ods.Campania ca with(nolock) ON @CampaniaID = ca.Codigo
	LEFT join ods.ProductoComercial pc with(nolock) ON ca.CampaniaID = pc.CampaniaID AND c.CodigoCupon = pc.CUV
	LEFT JOIN dbo.Marca m WITH (NOLOCK) ON pc.MarcaId = m.MarcaId

	where 
		isnull(c.Campana,'') != ''
		and c.CodigoPrograma = @CodigoPrograma
		and c.CodigoNivel = @CodigoNivel
		and c.Campana = cast(@CampaniaID as varchar(6))
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
USE [BelcorpSalvador];
GO
ALTER PROC GetPremiosElectivos
(
@CampaniaID int,
@CodigoPrograma varchar(10),
@CodigoNivel varchar(2)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		@CampaniaID AS CampaniaID	,
		e.ImagenURL					,
		e.DescripcionCUV2			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		pc.MarcaId					,
		m.Descripcion AS DescripcionMarca,
		e.TipoEstrategiaId			,
		c.PrecioUnitario
	FROM ods.CuponesProgramaNuevas c With(nolock)
	LEFT join dbo.Estrategia e  With(nolock) on 
		c.CodigoCupon = e.CUV2 and
		c.CodigoPrograma = e.CodigoPrograma and
		e.activo = 1 and
		e.campaniaid <= @CampaniaID and e.campaniaidfin >= @CampaniaID
	LEFT JOIN ods.Campania ca with(nolock) ON @CampaniaID = ca.Codigo
	LEFT join ods.ProductoComercial pc with(nolock) ON ca.CampaniaID = pc.CampaniaID AND c.CodigoCupon = pc.CUV
	LEFT JOIN dbo.Marca m WITH (NOLOCK) ON pc.MarcaId = m.MarcaId

	where 
		isnull(c.Campana,'') != ''
		and c.CodigoPrograma = @CodigoPrograma
		and c.CodigoNivel = @CodigoNivel
		and c.Campana = cast(@CampaniaID as varchar(6))
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
