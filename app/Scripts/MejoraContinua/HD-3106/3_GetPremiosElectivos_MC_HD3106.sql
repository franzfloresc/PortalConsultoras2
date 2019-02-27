<<<<<<< HEAD
﻿USE BelcorpBolivia
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos
GO
CREATE PROC GetPremiosElectivos
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
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END
GO

USE BelcorpChile
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos
GO
=======
﻿USE BelcorpBolivia;
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos

GO


>>>>>>> origin/HD-2849
CREATE PROC GetPremiosElectivos
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
<<<<<<< HEAD
=======
		e.TipoEstrategiaID			,
>>>>>>> origin/HD-2849
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END
<<<<<<< HEAD
GO

USE BelcorpColombia
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos
GO
=======

GO
USE BelcorpChile;
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos

GO


>>>>>>> origin/HD-2849
CREATE PROC GetPremiosElectivos
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
<<<<<<< HEAD
=======
		e.TipoEstrategiaID			,
>>>>>>> origin/HD-2849
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END
<<<<<<< HEAD
GO

USE BelcorpCostaRica
=======

GO
USE BelcorpColombia;
>>>>>>> origin/HD-2849
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos
GO
CREATE PROC GetPremiosElectivos
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
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END
GO

USE BelcorpDominicana
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos
GO
CREATE PROC GetPremiosElectivos
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
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END
GO

USE BelcorpEcuador
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos
GO
CREATE PROC GetPremiosElectivos
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
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END
GO

USE BelcorpGuatemala
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos
GO
CREATE PROC GetPremiosElectivos
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
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END
GO

USE BelcorpMexico
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos
GO
CREATE PROC GetPremiosElectivos
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
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END
GO

USE BelcorpPanama
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos
GO
CREATE PROC GetPremiosElectivos
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
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END
GO

USE BelcorpPeru
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos
GO
CREATE PROC GetPremiosElectivos
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
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END
GO

USE BelcorpPuertoRico
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos
GO
CREATE PROC GetPremiosElectivos
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
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END
GO

USE BelcorpSalvador
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos
GO
CREATE PROC GetPremiosElectivos
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
		e.TipoEstrategiaID			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END
<<<<<<< HEAD
GO
=======

GO
USE BelcorpCostaRica;
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos

GO


CREATE PROC GetPremiosElectivos
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
		e.TipoEstrategiaID			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
USE BelcorpDominicana;
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos

GO


CREATE PROC GetPremiosElectivos
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
		e.TipoEstrategiaID			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
USE BelcorpEcuador;
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos

GO


CREATE PROC GetPremiosElectivos
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
		e.TipoEstrategiaID			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
USE BelcorpGuatemala;
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos

GO


CREATE PROC GetPremiosElectivos
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
		e.TipoEstrategiaID			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
USE BelcorpMexico;
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos

GO


CREATE PROC GetPremiosElectivos
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
		e.TipoEstrategiaID			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
USE BelcorpPanama;
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos

GO


CREATE PROC GetPremiosElectivos
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
		e.TipoEstrategiaID			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
USE BelcorpPeru;
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos

GO


CREATE PROC GetPremiosElectivos
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
		e.TipoEstrategiaID			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
USE BelcorpPuertoRico;
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos

GO


CREATE PROC GetPremiosElectivos
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
		e.TipoEstrategiaID			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
USE BelcorpSalvador;
GO
if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos

GO


CREATE PROC GetPremiosElectivos
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
		e.TipoEstrategiaID			,
		c.CodigoCupon AS CUV2		,
		1 AS FlagNueva				,
		c.CodigoPrograma			,
		c.INC_CUPO_ELEC_DEFA		,
		m.Descripcion AS DescripcionMarca
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
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1
	order by e.Orden ASC
END

GO
>>>>>>> origin/HD-2849
