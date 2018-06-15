USE [BelcorpPeru]  
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetEstrategiaProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetEstrategiaProgramaNuevas
GO
CREATE PROCEDURE dbo.GetEstrategiaProgramaNuevas
@CampaniaID					int, 
@CUV						varchar (10),
@CodigoPrograma				varchar(10),
@CodigoEstrategia			varchar (10)
AS
BEGIN

	select 
		e.EstrategiaID				,
		e.TipoEstrategiaID			,
		e.CampaniaID				,
		e.CampaniaIDFin				,
		e.NumeroPedido				,
		e.Activo					,
		e.ImagenURL					,
		e.LimiteVenta				,
		e.DescripcionCUV2			,
		e.FlagDescripcion			,
		e.CUV						,
		e.EtiquetaID				,
		e.Precio					,
		e.FlagCEP					,
		e.CUV2						,
		e.EtiquetaID2				,
		e.Precio2					,
		e.FlagCEP2					,
		e.TextoLibre				,
		e.FlagTextoLibre			,
		e.Cantidad					,
		e.FlagCantidad				,
		e.Zona						,
		e.Limite					,
		e.Orden						,
		e.UsuarioCreacion			,
		e.FechaCreacion				,
		e.UsuarioModificacion		,
		e.FechaModificacion			,
		e.ColorFondo				,
		e.FlagEstrella				,
		e.CodigoEstrategia			,
		e.TieneVariedad				,
		e.EsOfertaIndependiente		,
		e.PrecioPublico				,
		e.Ganancia					,
		e.CodigoPrograma			,
		e.FlagImagenURL				,
		e.CodigoConcurso			,
		e.ImagenMiniaturaURL		,
		e.EsSubCampania				,
		e.OfertaShowRoomID			,
		e.Niveles					
	from Estrategia  e 
	inner join tipoestrategia t on t.TipoEstrategiaID = e.TipoEstrategiaID and t.flagActivo = 1
	where e.activo = 1
		and e.CodigoPrograma = @CodigoPrograma  
		and e.campaniaid= @CampaniaID 
		and e.cuv2  = @CUV    
		and t.Codigo=@CodigoEstrategia --'021' 
		
END
GO

USE [BelcorpBolivia]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetEstrategiaProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetEstrategiaProgramaNuevas
GO
CREATE PROCEDURE dbo.GetEstrategiaProgramaNuevas
@CampaniaID					int, 
@CUV						varchar (10),
@CodigoPrograma				varchar(10),
@CodigoEstrategia			varchar (10)
AS
BEGIN

	select 
		e.EstrategiaID				,
		e.TipoEstrategiaID			,
		e.CampaniaID				,
		e.CampaniaIDFin				,
		e.NumeroPedido				,
		e.Activo					,
		e.ImagenURL					,
		e.LimiteVenta				,
		e.DescripcionCUV2			,
		e.FlagDescripcion			,
		e.CUV						,
		e.EtiquetaID				,
		e.Precio					,
		e.FlagCEP					,
		e.CUV2						,
		e.EtiquetaID2				,
		e.Precio2					,
		e.FlagCEP2					,
		e.TextoLibre				,
		e.FlagTextoLibre			,
		e.Cantidad					,
		e.FlagCantidad				,
		e.Zona						,
		e.Limite					,
		e.Orden						,
		e.UsuarioCreacion			,
		e.FechaCreacion				,
		e.UsuarioModificacion		,
		e.FechaModificacion			,
		e.ColorFondo				,
		e.FlagEstrella				,
		e.CodigoEstrategia			,
		e.TieneVariedad				,
		e.EsOfertaIndependiente		,
		e.PrecioPublico				,
		e.Ganancia					,
		e.CodigoPrograma			,
		e.FlagImagenURL				,
		e.CodigoConcurso			,
		e.ImagenMiniaturaURL		,
		e.EsSubCampania				,
		e.OfertaShowRoomID			,
		e.Niveles					
	from Estrategia  e 
	inner join tipoestrategia t on t.TipoEstrategiaID = e.TipoEstrategiaID and t.flagActivo = 1
	where e.activo = 1
		and e.CodigoPrograma = @CodigoPrograma  
		and e.campaniaid= @CampaniaID 
		and e.cuv2  = @CUV    
		and t.Codigo=@CodigoEstrategia --'021' 
		
END
GO

USE [BelcorpChile]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetEstrategiaProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetEstrategiaProgramaNuevas
GO
CREATE PROCEDURE dbo.GetEstrategiaProgramaNuevas
@CampaniaID					int, 
@CUV						varchar (10),
@CodigoPrograma				varchar(10),
@CodigoEstrategia			varchar (10)
AS
BEGIN

	select 
		e.EstrategiaID				,
		e.TipoEstrategiaID			,
		e.CampaniaID				,
		e.CampaniaIDFin				,
		e.NumeroPedido				,
		e.Activo					,
		e.ImagenURL					,
		e.LimiteVenta				,
		e.DescripcionCUV2			,
		e.FlagDescripcion			,
		e.CUV						,
		e.EtiquetaID				,
		e.Precio					,
		e.FlagCEP					,
		e.CUV2						,
		e.EtiquetaID2				,
		e.Precio2					,
		e.FlagCEP2					,
		e.TextoLibre				,
		e.FlagTextoLibre			,
		e.Cantidad					,
		e.FlagCantidad				,
		e.Zona						,
		e.Limite					,
		e.Orden						,
		e.UsuarioCreacion			,
		e.FechaCreacion				,
		e.UsuarioModificacion		,
		e.FechaModificacion			,
		e.ColorFondo				,
		e.FlagEstrella				,
		e.CodigoEstrategia			,
		e.TieneVariedad				,
		e.EsOfertaIndependiente		,
		e.PrecioPublico				,
		e.Ganancia					,
		e.CodigoPrograma			,
		e.FlagImagenURL				,
		e.CodigoConcurso			,
		e.ImagenMiniaturaURL		,
		e.EsSubCampania				,
		e.OfertaShowRoomID			,
		e.Niveles					
	from Estrategia  e 
	inner join tipoestrategia t on t.TipoEstrategiaID = e.TipoEstrategiaID and t.flagActivo = 1
	where e.activo = 1
		and e.CodigoPrograma = @CodigoPrograma  
		and e.campaniaid= @CampaniaID 
		and e.cuv2  = @CUV    
		and t.Codigo=@CodigoEstrategia --'021' 
		
END
GO

USE [BelcorpColombia]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetEstrategiaProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetEstrategiaProgramaNuevas
GO
CREATE PROCEDURE dbo.GetEstrategiaProgramaNuevas
@CampaniaID					int, 
@CUV						varchar (10),
@CodigoPrograma				varchar(10),
@CodigoEstrategia			varchar (10)
AS
BEGIN

	select 
		e.EstrategiaID				,
		e.TipoEstrategiaID			,
		e.CampaniaID				,
		e.CampaniaIDFin				,
		e.NumeroPedido				,
		e.Activo					,
		e.ImagenURL					,
		e.LimiteVenta				,
		e.DescripcionCUV2			,
		e.FlagDescripcion			,
		e.CUV						,
		e.EtiquetaID				,
		e.Precio					,
		e.FlagCEP					,
		e.CUV2						,
		e.EtiquetaID2				,
		e.Precio2					,
		e.FlagCEP2					,
		e.TextoLibre				,
		e.FlagTextoLibre			,
		e.Cantidad					,
		e.FlagCantidad				,
		e.Zona						,
		e.Limite					,
		e.Orden						,
		e.UsuarioCreacion			,
		e.FechaCreacion				,
		e.UsuarioModificacion		,
		e.FechaModificacion			,
		e.ColorFondo				,
		e.FlagEstrella				,
		e.CodigoEstrategia			,
		e.TieneVariedad				,
		e.EsOfertaIndependiente		,
		e.PrecioPublico				,
		e.Ganancia					,
		e.CodigoPrograma			,
		e.FlagImagenURL				,
		e.CodigoConcurso			,
		e.ImagenMiniaturaURL		,
		e.EsSubCampania				,
		e.OfertaShowRoomID			,
		e.Niveles					
	from Estrategia  e 
	inner join tipoestrategia t on t.TipoEstrategiaID = e.TipoEstrategiaID and t.flagActivo = 1
	where e.activo = 1
		and e.CodigoPrograma = @CodigoPrograma  
		and e.campaniaid= @CampaniaID 
		and e.cuv2  = @CUV    
		and t.Codigo=@CodigoEstrategia --'021' 
		
END
GO

USE [BelcorpCostaRica]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetEstrategiaProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetEstrategiaProgramaNuevas
GO
CREATE PROCEDURE dbo.GetEstrategiaProgramaNuevas
@CampaniaID					int, 
@CUV						varchar (10),
@CodigoPrograma				varchar(10),
@CodigoEstrategia			varchar (10)
AS
BEGIN

	select 
		e.EstrategiaID				,
		e.TipoEstrategiaID			,
		e.CampaniaID				,
		e.CampaniaIDFin				,
		e.NumeroPedido				,
		e.Activo					,
		e.ImagenURL					,
		e.LimiteVenta				,
		e.DescripcionCUV2			,
		e.FlagDescripcion			,
		e.CUV						,
		e.EtiquetaID				,
		e.Precio					,
		e.FlagCEP					,
		e.CUV2						,
		e.EtiquetaID2				,
		e.Precio2					,
		e.FlagCEP2					,
		e.TextoLibre				,
		e.FlagTextoLibre			,
		e.Cantidad					,
		e.FlagCantidad				,
		e.Zona						,
		e.Limite					,
		e.Orden						,
		e.UsuarioCreacion			,
		e.FechaCreacion				,
		e.UsuarioModificacion		,
		e.FechaModificacion			,
		e.ColorFondo				,
		e.FlagEstrella				,
		e.CodigoEstrategia			,
		e.TieneVariedad				,
		e.EsOfertaIndependiente		,
		e.PrecioPublico				,
		e.Ganancia					,
		e.CodigoPrograma			,
		e.FlagImagenURL				,
		e.CodigoConcurso			,
		e.ImagenMiniaturaURL		,
		e.EsSubCampania				,
		e.OfertaShowRoomID			,
		e.Niveles					
	from Estrategia  e 
	inner join tipoestrategia t on t.TipoEstrategiaID = e.TipoEstrategiaID and t.flagActivo = 1
	where e.activo = 1
		and e.CodigoPrograma = @CodigoPrograma  
		and e.campaniaid= @CampaniaID 
		and e.cuv2  = @CUV    
		and t.Codigo=@CodigoEstrategia --'021' 
		
END
GO

USE [BelcorpDominicana]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetEstrategiaProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetEstrategiaProgramaNuevas
GO
CREATE PROCEDURE dbo.GetEstrategiaProgramaNuevas
@CampaniaID					int, 
@CUV						varchar (10),
@CodigoPrograma				varchar(10),
@CodigoEstrategia			varchar (10)
AS
BEGIN

	select 
		e.EstrategiaID				,
		e.TipoEstrategiaID			,
		e.CampaniaID				,
		e.CampaniaIDFin				,
		e.NumeroPedido				,
		e.Activo					,
		e.ImagenURL					,
		e.LimiteVenta				,
		e.DescripcionCUV2			,
		e.FlagDescripcion			,
		e.CUV						,
		e.EtiquetaID				,
		e.Precio					,
		e.FlagCEP					,
		e.CUV2						,
		e.EtiquetaID2				,
		e.Precio2					,
		e.FlagCEP2					,
		e.TextoLibre				,
		e.FlagTextoLibre			,
		e.Cantidad					,
		e.FlagCantidad				,
		e.Zona						,
		e.Limite					,
		e.Orden						,
		e.UsuarioCreacion			,
		e.FechaCreacion				,
		e.UsuarioModificacion		,
		e.FechaModificacion			,
		e.ColorFondo				,
		e.FlagEstrella				,
		e.CodigoEstrategia			,
		e.TieneVariedad				,
		e.EsOfertaIndependiente		,
		e.PrecioPublico				,
		e.Ganancia					,
		e.CodigoPrograma			,
		e.FlagImagenURL				,
		e.CodigoConcurso			,
		e.ImagenMiniaturaURL		,
		e.EsSubCampania				,
		e.OfertaShowRoomID			,
		e.Niveles					
	from Estrategia  e 
	inner join tipoestrategia t on t.TipoEstrategiaID = e.TipoEstrategiaID and t.flagActivo = 1
	where e.activo = 1
		and e.CodigoPrograma = @CodigoPrograma  
		and e.campaniaid= @CampaniaID 
		and e.cuv2  = @CUV    
		and t.Codigo=@CodigoEstrategia --'021' 
		
END
GO

USE [BelcorpEcuador]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetEstrategiaProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetEstrategiaProgramaNuevas
GO
CREATE PROCEDURE dbo.GetEstrategiaProgramaNuevas
@CampaniaID					int, 
@CUV						varchar (10),
@CodigoPrograma				varchar(10),
@CodigoEstrategia			varchar (10)
AS
BEGIN

	select 
		e.EstrategiaID				,
		e.TipoEstrategiaID			,
		e.CampaniaID				,
		e.CampaniaIDFin				,
		e.NumeroPedido				,
		e.Activo					,
		e.ImagenURL					,
		e.LimiteVenta				,
		e.DescripcionCUV2			,
		e.FlagDescripcion			,
		e.CUV						,
		e.EtiquetaID				,
		e.Precio					,
		e.FlagCEP					,
		e.CUV2						,
		e.EtiquetaID2				,
		e.Precio2					,
		e.FlagCEP2					,
		e.TextoLibre				,
		e.FlagTextoLibre			,
		e.Cantidad					,
		e.FlagCantidad				,
		e.Zona						,
		e.Limite					,
		e.Orden						,
		e.UsuarioCreacion			,
		e.FechaCreacion				,
		e.UsuarioModificacion		,
		e.FechaModificacion			,
		e.ColorFondo				,
		e.FlagEstrella				,
		e.CodigoEstrategia			,
		e.TieneVariedad				,
		e.EsOfertaIndependiente		,
		e.PrecioPublico				,
		e.Ganancia					,
		e.CodigoPrograma			,
		e.FlagImagenURL				,
		e.CodigoConcurso			,
		e.ImagenMiniaturaURL		,
		e.EsSubCampania				,
		e.OfertaShowRoomID			,
		e.Niveles					
	from Estrategia  e 
	inner join tipoestrategia t on t.TipoEstrategiaID = e.TipoEstrategiaID and t.flagActivo = 1
	where e.activo = 1
		and e.CodigoPrograma = @CodigoPrograma  
		and e.campaniaid= @CampaniaID 
		and e.cuv2  = @CUV    
		and t.Codigo=@CodigoEstrategia --'021' 
		
END
GO

USE [BelcorpGuatemala]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetEstrategiaProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetEstrategiaProgramaNuevas
GO
CREATE PROCEDURE dbo.GetEstrategiaProgramaNuevas
@CampaniaID					int, 
@CUV						varchar (10),
@CodigoPrograma				varchar(10),
@CodigoEstrategia			varchar (10)
AS
BEGIN

	select 
		e.EstrategiaID				,
		e.TipoEstrategiaID			,
		e.CampaniaID				,
		e.CampaniaIDFin				,
		e.NumeroPedido				,
		e.Activo					,
		e.ImagenURL					,
		e.LimiteVenta				,
		e.DescripcionCUV2			,
		e.FlagDescripcion			,
		e.CUV						,
		e.EtiquetaID				,
		e.Precio					,
		e.FlagCEP					,
		e.CUV2						,
		e.EtiquetaID2				,
		e.Precio2					,
		e.FlagCEP2					,
		e.TextoLibre				,
		e.FlagTextoLibre			,
		e.Cantidad					,
		e.FlagCantidad				,
		e.Zona						,
		e.Limite					,
		e.Orden						,
		e.UsuarioCreacion			,
		e.FechaCreacion				,
		e.UsuarioModificacion		,
		e.FechaModificacion			,
		e.ColorFondo				,
		e.FlagEstrella				,
		e.CodigoEstrategia			,
		e.TieneVariedad				,
		e.EsOfertaIndependiente		,
		e.PrecioPublico				,
		e.Ganancia					,
		e.CodigoPrograma			,
		e.FlagImagenURL				,
		e.CodigoConcurso			,
		e.ImagenMiniaturaURL		,
		e.EsSubCampania				,
		e.OfertaShowRoomID			,
		e.Niveles					
	from Estrategia  e 
	inner join tipoestrategia t on t.TipoEstrategiaID = e.TipoEstrategiaID and t.flagActivo = 1
	where e.activo = 1
		and e.CodigoPrograma = @CodigoPrograma  
		and e.campaniaid= @CampaniaID 
		and e.cuv2  = @CUV    
		and t.Codigo=@CodigoEstrategia --'021' 
		
END
GO

USE [BelcorpMexico]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetEstrategiaProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetEstrategiaProgramaNuevas
GO
CREATE PROCEDURE dbo.GetEstrategiaProgramaNuevas
@CampaniaID					int, 
@CUV						varchar (10),
@CodigoPrograma				varchar(10),
@CodigoEstrategia			varchar (10)
AS
BEGIN

	select 
		e.EstrategiaID				,
		e.TipoEstrategiaID			,
		e.CampaniaID				,
		e.CampaniaIDFin				,
		e.NumeroPedido				,
		e.Activo					,
		e.ImagenURL					,
		e.LimiteVenta				,
		e.DescripcionCUV2			,
		e.FlagDescripcion			,
		e.CUV						,
		e.EtiquetaID				,
		e.Precio					,
		e.FlagCEP					,
		e.CUV2						,
		e.EtiquetaID2				,
		e.Precio2					,
		e.FlagCEP2					,
		e.TextoLibre				,
		e.FlagTextoLibre			,
		e.Cantidad					,
		e.FlagCantidad				,
		e.Zona						,
		e.Limite					,
		e.Orden						,
		e.UsuarioCreacion			,
		e.FechaCreacion				,
		e.UsuarioModificacion		,
		e.FechaModificacion			,
		e.ColorFondo				,
		e.FlagEstrella				,
		e.CodigoEstrategia			,
		e.TieneVariedad				,
		e.EsOfertaIndependiente		,
		e.PrecioPublico				,
		e.Ganancia					,
		e.CodigoPrograma			,
		e.FlagImagenURL				,
		e.CodigoConcurso			,
		e.ImagenMiniaturaURL		,
		e.EsSubCampania				,
		e.OfertaShowRoomID			,
		e.Niveles					
	from Estrategia  e 
	inner join tipoestrategia t on t.TipoEstrategiaID = e.TipoEstrategiaID and t.flagActivo = 1
	where e.activo = 1
		and e.CodigoPrograma = @CodigoPrograma  
		and e.campaniaid= @CampaniaID 
		and e.cuv2  = @CUV    
		and t.Codigo=@CodigoEstrategia --'021' 
		
END
GO

USE [BelcorpPanama]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetEstrategiaProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetEstrategiaProgramaNuevas
GO
CREATE PROCEDURE dbo.GetEstrategiaProgramaNuevas
@CampaniaID					int, 
@CUV						varchar (10),
@CodigoPrograma				varchar(10),
@CodigoEstrategia			varchar (10)
AS
BEGIN

	select 
		e.EstrategiaID				,
		e.TipoEstrategiaID			,
		e.CampaniaID				,
		e.CampaniaIDFin				,
		e.NumeroPedido				,
		e.Activo					,
		e.ImagenURL					,
		e.LimiteVenta				,
		e.DescripcionCUV2			,
		e.FlagDescripcion			,
		e.CUV						,
		e.EtiquetaID				,
		e.Precio					,
		e.FlagCEP					,
		e.CUV2						,
		e.EtiquetaID2				,
		e.Precio2					,
		e.FlagCEP2					,
		e.TextoLibre				,
		e.FlagTextoLibre			,
		e.Cantidad					,
		e.FlagCantidad				,
		e.Zona						,
		e.Limite					,
		e.Orden						,
		e.UsuarioCreacion			,
		e.FechaCreacion				,
		e.UsuarioModificacion		,
		e.FechaModificacion			,
		e.ColorFondo				,
		e.FlagEstrella				,
		e.CodigoEstrategia			,
		e.TieneVariedad				,
		e.EsOfertaIndependiente		,
		e.PrecioPublico				,
		e.Ganancia					,
		e.CodigoPrograma			,
		e.FlagImagenURL				,
		e.CodigoConcurso			,
		e.ImagenMiniaturaURL		,
		e.EsSubCampania				,
		e.OfertaShowRoomID			,
		e.Niveles					
	from Estrategia  e 
	inner join tipoestrategia t on t.TipoEstrategiaID = e.TipoEstrategiaID and t.flagActivo = 1
	where e.activo = 1
		and e.CodigoPrograma = @CodigoPrograma  
		and e.campaniaid= @CampaniaID 
		and e.cuv2  = @CUV    
		and t.Codigo=@CodigoEstrategia --'021' 
		
END
GO

USE [BelcorpPuertoRico]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetEstrategiaProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetEstrategiaProgramaNuevas
GO
CREATE PROCEDURE dbo.GetEstrategiaProgramaNuevas
@CampaniaID					int, 
@CUV						varchar (10),
@CodigoPrograma				varchar(10),
@CodigoEstrategia			varchar (10)
AS
BEGIN

	select 
		e.EstrategiaID				,
		e.TipoEstrategiaID			,
		e.CampaniaID				,
		e.CampaniaIDFin				,
		e.NumeroPedido				,
		e.Activo					,
		e.ImagenURL					,
		e.LimiteVenta				,
		e.DescripcionCUV2			,
		e.FlagDescripcion			,
		e.CUV						,
		e.EtiquetaID				,
		e.Precio					,
		e.FlagCEP					,
		e.CUV2						,
		e.EtiquetaID2				,
		e.Precio2					,
		e.FlagCEP2					,
		e.TextoLibre				,
		e.FlagTextoLibre			,
		e.Cantidad					,
		e.FlagCantidad				,
		e.Zona						,
		e.Limite					,
		e.Orden						,
		e.UsuarioCreacion			,
		e.FechaCreacion				,
		e.UsuarioModificacion		,
		e.FechaModificacion			,
		e.ColorFondo				,
		e.FlagEstrella				,
		e.CodigoEstrategia			,
		e.TieneVariedad				,
		e.EsOfertaIndependiente		,
		e.PrecioPublico				,
		e.Ganancia					,
		e.CodigoPrograma			,
		e.FlagImagenURL				,
		e.CodigoConcurso			,
		e.ImagenMiniaturaURL		,
		e.EsSubCampania				,
		e.OfertaShowRoomID			,
		e.Niveles					
	from Estrategia  e 
	inner join tipoestrategia t on t.TipoEstrategiaID = e.TipoEstrategiaID and t.flagActivo = 1
	where e.activo = 1
		and e.CodigoPrograma = @CodigoPrograma  
		and e.campaniaid= @CampaniaID 
		and e.cuv2  = @CUV    
		and t.Codigo=@CodigoEstrategia --'021' 
		
END
GO

USE [BelcorpSalvador]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetEstrategiaProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetEstrategiaProgramaNuevas
GO
CREATE PROCEDURE dbo.GetEstrategiaProgramaNuevas
@CampaniaID					int, 
@CUV						varchar (10),
@CodigoPrograma				varchar(10),
@CodigoEstrategia			varchar (10)
AS
BEGIN

	select 
		e.EstrategiaID				,
		e.TipoEstrategiaID			,
		e.CampaniaID				,
		e.CampaniaIDFin				,
		e.NumeroPedido				,
		e.Activo					,
		e.ImagenURL					,
		e.LimiteVenta				,
		e.DescripcionCUV2			,
		e.FlagDescripcion			,
		e.CUV						,
		e.EtiquetaID				,
		e.Precio					,
		e.FlagCEP					,
		e.CUV2						,
		e.EtiquetaID2				,
		e.Precio2					,
		e.FlagCEP2					,
		e.TextoLibre				,
		e.FlagTextoLibre			,
		e.Cantidad					,
		e.FlagCantidad				,
		e.Zona						,
		e.Limite					,
		e.Orden						,
		e.UsuarioCreacion			,
		e.FechaCreacion				,
		e.UsuarioModificacion		,
		e.FechaModificacion			,
		e.ColorFondo				,
		e.FlagEstrella				,
		e.CodigoEstrategia			,
		e.TieneVariedad				,
		e.EsOfertaIndependiente		,
		e.PrecioPublico				,
		e.Ganancia					,
		e.CodigoPrograma			,
		e.FlagImagenURL				,
		e.CodigoConcurso			,
		e.ImagenMiniaturaURL		,
		e.EsSubCampania				,
		e.OfertaShowRoomID			,
		e.Niveles					
	from Estrategia  e 
	inner join tipoestrategia t on t.TipoEstrategiaID = e.TipoEstrategiaID and t.flagActivo = 1
	where e.activo = 1
		and e.CodigoPrograma = @CodigoPrograma  
		and e.campaniaid= @CampaniaID 
		and e.cuv2  = @CUV    
		and t.Codigo=@CodigoEstrategia --'021' 
		
END
GO
