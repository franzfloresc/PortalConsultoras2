USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT
AS
BEGIN
	SELECT
		p.PedidoID,
		p.FechaRegistro FechaRegistro,
		CASE WHEN p.EstadoPedido = 202 
			THEN p.FechaReserva
			ELSE NULL
		END FechaReserva,
		p.CampaniaID CampaniaCodigo,
		s.Codigo Seccion,
		c.Codigo ConsultoraCodigo,
		c.NombreCompleto ConsultoraNombre,
		p.ImporteTotal,
		p.DescuentoProl,
		'' UsuarioResponsable,
		c.MontoSaldoActual ConsultoraSaldo,
		'Web' OrigenNombre,
		CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
			THEN 'SI'
			ELSE 'NO'
			END EstadoValidacionNombre,
		z.Codigo AS Zona,		
		r.Codigo AS Region,
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'WEB'), 0) AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable
	FROM dbo.PedidoWeb p (NOLOCK)
	INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
	INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
	INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
	INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
	WHERE 
		(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
		p.ImporteTotal <> 0  
		AND (@EstadoPedido = 0 OR @EstadoPedido = (
	CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
						ELSE
							201	
						END ))
		and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
		and (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
		and (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
END

GO
------------------------------------------------------------------------------

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT
AS
BEGIN
	SELECT
		p.PedidoID,
		p.FechaRegistro FechaRegistro,
		CASE WHEN p.EstadoPedido = 202 
			THEN p.FechaReserva
			ELSE NULL
		END FechaReserva,
		p.CampaniaID CampaniaCodigo,
		s.Codigo Seccion,
		c.Codigo ConsultoraCodigo,
		c.NombreCompleto ConsultoraNombre,
		p.ImporteTotal,
		p.DescuentoProl,
		'' UsuarioResponsable,
		c.MontoSaldoActual ConsultoraSaldo,
		'Web' OrigenNombre,
		CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
			THEN 'SI'
			ELSE 'NO'
			END EstadoValidacionNombre,
		z.Codigo AS Zona,		
		r.Codigo AS Region,
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'WEB'), 0) AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable
	FROM dbo.PedidoWeb p (NOLOCK)
	INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
	INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
	INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
	INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
	WHERE 
		(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
		p.ImporteTotal <> 0  
		AND (@EstadoPedido = 0 OR @EstadoPedido = (
	CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
						ELSE
							201	
						END ))
		and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
		and (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
		and (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
END

GO
------------------------------------------------------------------------------

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT
AS
BEGIN
	SELECT
		p.PedidoID,
		p.FechaRegistro FechaRegistro,
		CASE WHEN p.EstadoPedido = 202 
			THEN p.FechaReserva
			ELSE NULL
		END FechaReserva,
		p.CampaniaID CampaniaCodigo,
		s.Codigo Seccion,
		c.Codigo ConsultoraCodigo,
		c.NombreCompleto ConsultoraNombre,
		p.ImporteTotal,
		p.DescuentoProl,
		'' UsuarioResponsable,
		c.MontoSaldoActual ConsultoraSaldo,
		'Web' OrigenNombre,
		CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
			THEN 'SI'
			ELSE 'NO'
			END EstadoValidacionNombre,
		z.Codigo AS Zona,		
		r.Codigo AS Region,
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'WEB'), 0) AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable
	FROM dbo.PedidoWeb p (NOLOCK)
	INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
	INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
	INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
	INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
	WHERE 
		(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
		p.ImporteTotal <> 0  
		AND (@EstadoPedido = 0 OR @EstadoPedido = (
	CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
						ELSE
							201	
						END ))
		and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
		and (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
		and (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
END

GO
------------------------------------------------------------------------------

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT
AS
BEGIN
	SELECT
		p.PedidoID,
		p.FechaRegistro FechaRegistro,
		CASE WHEN p.EstadoPedido = 202 
			THEN p.FechaReserva
			ELSE NULL
		END FechaReserva,
		p.CampaniaID CampaniaCodigo,
		s.Codigo Seccion,
		c.Codigo ConsultoraCodigo,
		c.NombreCompleto ConsultoraNombre,
		p.ImporteTotal,
		p.DescuentoProl,
		'' UsuarioResponsable,
		c.MontoSaldoActual ConsultoraSaldo,
		'Web' OrigenNombre,
		CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
			THEN 'SI'
			ELSE 'NO'
			END EstadoValidacionNombre,
		z.Codigo AS Zona,		
		r.Codigo AS Region,
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'WEB'), 0) AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable
	FROM dbo.PedidoWeb p (NOLOCK)
	INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
	INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
	INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
	INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
	WHERE 
		(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
		p.ImporteTotal <> 0  
		AND (@EstadoPedido = 0 OR @EstadoPedido = (
	CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
						ELSE
							201	
						END ))
		and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
		and (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
		and (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
END

GO
------------------------------------------------------------------------------

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT
AS
BEGIN
	SELECT
		p.PedidoID,
		p.FechaRegistro FechaRegistro,
		CASE WHEN p.EstadoPedido = 202 
			THEN p.FechaReserva
			ELSE NULL
		END FechaReserva,
		p.CampaniaID CampaniaCodigo,
		s.Codigo Seccion,
		c.Codigo ConsultoraCodigo,
		c.NombreCompleto ConsultoraNombre,
		p.ImporteTotal,
		p.DescuentoProl,
		'' UsuarioResponsable,
		c.MontoSaldoActual ConsultoraSaldo,
		'Web' OrigenNombre,
		CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
			THEN 'SI'
			ELSE 'NO'
			END EstadoValidacionNombre,
		z.Codigo AS Zona,		
		r.Codigo AS Region,
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'WEB'), 0) AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable
	FROM dbo.PedidoWeb p (NOLOCK)
	INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
	INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
	INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
	INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
	WHERE 
		(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
		p.ImporteTotal <> 0  
		AND (@EstadoPedido = 0 OR @EstadoPedido = (
	CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
						ELSE
							201	
						END ))
		and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
		and (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
		and (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
END

GO
------------------------------------------------------------------------------

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT
AS
BEGIN
	SELECT
		p.PedidoID,
		p.FechaRegistro FechaRegistro,
		CASE WHEN p.EstadoPedido = 202 
			THEN p.FechaReserva
			ELSE NULL
		END FechaReserva,
		p.CampaniaID CampaniaCodigo,
		s.Codigo Seccion,
		c.Codigo ConsultoraCodigo,
		c.NombreCompleto ConsultoraNombre,
		p.ImporteTotal,
		p.DescuentoProl,
		'' UsuarioResponsable,
		c.MontoSaldoActual ConsultoraSaldo,
		'Web' OrigenNombre,
		CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
			THEN 'SI'
			ELSE 'NO'
			END EstadoValidacionNombre,
		z.Codigo AS Zona,		
		r.Codigo AS Region,
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'WEB'), 0) AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable
	FROM dbo.PedidoWeb p (NOLOCK)
	INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
	INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
	INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
	INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
	WHERE 
		(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
		p.ImporteTotal <> 0  
		AND (@EstadoPedido = 0 OR @EstadoPedido = (
	CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
						ELSE
							201	
						END ))
		and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
		and (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
		and (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
END

GO
------------------------------------------------------------------------------

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT
AS
BEGIN
	SELECT
		p.PedidoID,
		p.FechaRegistro FechaRegistro,
		CASE WHEN p.EstadoPedido = 202 
			THEN p.FechaReserva
			ELSE NULL
		END FechaReserva,
		p.CampaniaID CampaniaCodigo,
		s.Codigo Seccion,
		c.Codigo ConsultoraCodigo,
		c.NombreCompleto ConsultoraNombre,
		p.ImporteTotal,
		p.DescuentoProl,
		'' UsuarioResponsable,
		c.MontoSaldoActual ConsultoraSaldo,
		'Web' OrigenNombre,
		CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
			THEN 'SI'
			ELSE 'NO'
			END EstadoValidacionNombre,
		z.Codigo AS Zona,		
		r.Codigo AS Region,
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'WEB'), 0) AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable
	FROM dbo.PedidoWeb p (NOLOCK)
	INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
	INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
	INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
	INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
	WHERE 
		(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
		p.ImporteTotal <> 0  
		AND (@EstadoPedido = 0 OR @EstadoPedido = (
	CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
						ELSE
							201	
						END ))
		and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
		and (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
		and (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
END

GO
------------------------------------------------------------------------------

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT
AS
BEGIN
	SELECT
		p.PedidoID,
		p.FechaRegistro FechaRegistro,
		CASE WHEN p.EstadoPedido = 202 
			THEN p.FechaReserva
			ELSE NULL
		END FechaReserva,
		p.CampaniaID CampaniaCodigo,
		s.Codigo Seccion,
		c.Codigo ConsultoraCodigo,
		c.NombreCompleto ConsultoraNombre,
		p.ImporteTotal,
		p.DescuentoProl,
		'' UsuarioResponsable,
		c.MontoSaldoActual ConsultoraSaldo,
		'Web' OrigenNombre,
		CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
			THEN 'SI'
			ELSE 'NO'
			END EstadoValidacionNombre,
		z.Codigo AS Zona,		
		r.Codigo AS Region,
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'WEB'), 0) AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable
	FROM dbo.PedidoWeb p (NOLOCK)
	INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
	INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
	INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
	INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
	WHERE 
		(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
		p.ImporteTotal <> 0  
		AND (@EstadoPedido = 0 OR @EstadoPedido = (
	CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
						ELSE
							201	
						END ))
		and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
		and (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
		and (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
END

GO
------------------------------------------------------------------------------

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT
AS
BEGIN
	SELECT
		p.PedidoID,
		p.FechaRegistro FechaRegistro,
		CASE WHEN p.EstadoPedido = 202 
			THEN p.FechaReserva
			ELSE NULL
		END FechaReserva,
		p.CampaniaID CampaniaCodigo,
		s.Codigo Seccion,
		c.Codigo ConsultoraCodigo,
		c.NombreCompleto ConsultoraNombre,
		p.ImporteTotal,
		p.DescuentoProl,
		'' UsuarioResponsable,
		c.MontoSaldoActual ConsultoraSaldo,
		'Web' OrigenNombre,
		CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
			THEN 'SI'
			ELSE 'NO'
			END EstadoValidacionNombre,
		z.Codigo AS Zona,		
		r.Codigo AS Region,
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'WEB'), 0) AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable
	FROM dbo.PedidoWeb p (NOLOCK)
	INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
	INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
	INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
	INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
	WHERE 
		(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
		p.ImporteTotal <> 0  
		AND (@EstadoPedido = 0 OR @EstadoPedido = (
	CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
						ELSE
							201	
						END ))
		and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
		and (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
		and (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
END

GO
------------------------------------------------------------------------------

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT
AS
BEGIN
	SELECT
		p.PedidoID,
		p.FechaRegistro FechaRegistro,
		CASE WHEN p.EstadoPedido = 202 
			THEN p.FechaReserva
			ELSE NULL
		END FechaReserva,
		p.CampaniaID CampaniaCodigo,
		s.Codigo Seccion,
		c.Codigo ConsultoraCodigo,
		c.NombreCompleto ConsultoraNombre,
		p.ImporteTotal,
		p.DescuentoProl,
		'' UsuarioResponsable,
		c.MontoSaldoActual ConsultoraSaldo,
		'Web' OrigenNombre,
		CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
			THEN 'SI'
			ELSE 'NO'
			END EstadoValidacionNombre,
		z.Codigo AS Zona,		
		r.Codigo AS Region,
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'WEB'), 0) AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable
	FROM dbo.PedidoWeb p (NOLOCK)
	INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
	INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
	INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
	INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
	WHERE 
		(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
		p.ImporteTotal <> 0  
		AND (@EstadoPedido = 0 OR @EstadoPedido = (
	CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
						ELSE
							201	
						END ))
		and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
		and (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
		and (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
END

GO
------------------------------------------------------------------------------

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT
AS
BEGIN
	SELECT
		p.PedidoID,
		p.FechaRegistro FechaRegistro,
		CASE WHEN p.EstadoPedido = 202 
			THEN p.FechaReserva
			ELSE NULL
		END FechaReserva,
		p.CampaniaID CampaniaCodigo,
		s.Codigo Seccion,
		c.Codigo ConsultoraCodigo,
		c.NombreCompleto ConsultoraNombre,
		p.ImporteTotal,
		p.DescuentoProl,
		'' UsuarioResponsable,
		c.MontoSaldoActual ConsultoraSaldo,
		'Web' OrigenNombre,
		CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
			THEN 'SI'
			ELSE 'NO'
			END EstadoValidacionNombre,
		z.Codigo AS Zona,		
		r.Codigo AS Region,
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'WEB'), 0) AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable
	FROM dbo.PedidoWeb p (NOLOCK)
	INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
	INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
	INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
	INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
	WHERE 
		(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
		p.ImporteTotal <> 0  
		AND (@EstadoPedido = 0 OR @EstadoPedido = (
	CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
						ELSE
							201	
						END ))
		and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
		and (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
		and (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
END

GO
------------------------------------------------------------------------------

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT
AS
BEGIN
	SELECT
		p.PedidoID,
		p.FechaRegistro FechaRegistro,
		CASE WHEN p.EstadoPedido = 202 
			THEN p.FechaReserva
			ELSE NULL
		END FechaReserva,
		p.CampaniaID CampaniaCodigo,
		s.Codigo Seccion,
		c.Codigo ConsultoraCodigo,
		c.NombreCompleto ConsultoraNombre,
		p.ImporteTotal,
		p.DescuentoProl,
		'' UsuarioResponsable,
		c.MontoSaldoActual ConsultoraSaldo,
		'Web' OrigenNombre,
		CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
			THEN 'SI'
			ELSE 'NO'
			END EstadoValidacionNombre,
		z.Codigo AS Zona,		
		r.Codigo AS Region,
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'WEB'), 0) AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable
	FROM dbo.PedidoWeb p (NOLOCK)
	INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
	INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
	INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
	INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
	WHERE 
		(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
		p.ImporteTotal <> 0  
		AND (@EstadoPedido = 0 OR @EstadoPedido = (
	CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
						ELSE
							201	
						END ))
		and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
		and (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
		and (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
END

GO
------------------------------------------------------------------------------

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT
AS
BEGIN
	SELECT
		p.PedidoID,
		p.FechaRegistro FechaRegistro,
		CASE WHEN p.EstadoPedido = 202 
			THEN p.FechaReserva
			ELSE NULL
		END FechaReserva,
		p.CampaniaID CampaniaCodigo,
		s.Codigo Seccion,
		c.Codigo ConsultoraCodigo,
		c.NombreCompleto ConsultoraNombre,
		p.ImporteTotal,
		p.DescuentoProl,
		'' UsuarioResponsable,
		c.MontoSaldoActual ConsultoraSaldo,
		'Web' OrigenNombre,
		CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
			THEN 'SI'
			ELSE 'NO'
			END EstadoValidacionNombre,
		z.Codigo AS Zona,		
		r.Codigo AS Region,
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'WEB'), 0) AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable
	FROM dbo.PedidoWeb p (NOLOCK)
	INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
	INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
	INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
	INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
	WHERE 
		(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
		p.ImporteTotal <> 0  
		AND (@EstadoPedido = 0 OR @EstadoPedido = (
	CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
						ELSE
							201	
						END ))
		and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
		and (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
		and (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
END

GO
------------------------------------------------------------------------------

