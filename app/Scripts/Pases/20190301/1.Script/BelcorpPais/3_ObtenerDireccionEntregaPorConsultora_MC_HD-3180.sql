USE BelcorpPeru
GO

IF EXISTS (
	SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerDireccionEntregaPorConsultora]') 
	AND type in (N'P', N'PC')
) 
  DROP PROCEDURE [dbo].[ObtenerDireccionEntregaPorConsultora]
GO
CREATE PROCEDURE ObtenerDireccionEntregaPorConsultora
	@ConsultoraID int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT  
       [DireccionEntregaID]
      ,[ConsultoraID]
      ,[CampaniaID]
      ,[CampaniaAnteriorID]
      ,[Ubigeo1]
      ,[Ubigeo2]
      ,[Ubigeo3]
      ,[Ubigeo1Anterior]
      ,[Ubigeo2Anterior]
      ,[Ubigeo3Anterior]
      ,[DireccionAnterior]
      ,[Direccion]
	  ,[ZonaAnterior]
	  ,[Zona]
      ,[Referencia]
      ,[CodigoConsultora]
      ,[Latitud]
      ,[Longitud]
      ,[LatitudAnterior]
      ,[LongitudAnterior]
  FROM [dbo].[DireccionEntrega] where ConsultoraID =@ConsultoraID
END
GO

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerDireccionEntregaPorConsultora]') 
	AND type in (N'P', N'PC')
) 
  DROP PROCEDURE [dbo].[ObtenerDireccionEntregaPorConsultora]
GO
CREATE PROCEDURE ObtenerDireccionEntregaPorConsultora
	@ConsultoraID int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT  
       [DireccionEntregaID]
      ,[ConsultoraID]
      ,[CampaniaID]
      ,[CampaniaAnteriorID]
      ,[Ubigeo1]
      ,[Ubigeo2]
      ,[Ubigeo3]
      ,[Ubigeo1Anterior]
      ,[Ubigeo2Anterior]
      ,[Ubigeo3Anterior]
      ,[DireccionAnterior]
      ,[Direccion]
	  ,[ZonaAnterior]
	  ,[Zona]
      ,[Referencia]
      ,[CodigoConsultora]
      ,[Latitud]
      ,[Longitud]
      ,[LatitudAnterior]
      ,[LongitudAnterior]
  FROM [dbo].[DireccionEntrega] where ConsultoraID =@ConsultoraID
END
GO

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerDireccionEntregaPorConsultora]') 
	AND type in (N'P', N'PC')
) 
  DROP PROCEDURE [dbo].[ObtenerDireccionEntregaPorConsultora]
GO
CREATE PROCEDURE ObtenerDireccionEntregaPorConsultora
	@ConsultoraID int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT  
       [DireccionEntregaID]
      ,[ConsultoraID]
      ,[CampaniaID]
      ,[CampaniaAnteriorID]
      ,[Ubigeo1]
      ,[Ubigeo2]
      ,[Ubigeo3]
      ,[Ubigeo1Anterior]
      ,[Ubigeo2Anterior]
      ,[Ubigeo3Anterior]
      ,[DireccionAnterior]
      ,[Direccion]
	  ,[ZonaAnterior]
	  ,[Zona]
      ,[Referencia]
      ,[CodigoConsultora]
      ,[Latitud]
      ,[Longitud]
      ,[LatitudAnterior]
      ,[LongitudAnterior]
  FROM [dbo].[DireccionEntrega] where ConsultoraID =@ConsultoraID
END
GO

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerDireccionEntregaPorConsultora]') 
	AND type in (N'P', N'PC')
) 
  DROP PROCEDURE [dbo].[ObtenerDireccionEntregaPorConsultora]
GO
CREATE PROCEDURE ObtenerDireccionEntregaPorConsultora
	@ConsultoraID int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT  
       [DireccionEntregaID]
      ,[ConsultoraID]
      ,[CampaniaID]
      ,[CampaniaAnteriorID]
      ,[Ubigeo1]
      ,[Ubigeo2]
      ,[Ubigeo3]
      ,[Ubigeo1Anterior]
      ,[Ubigeo2Anterior]
      ,[Ubigeo3Anterior]
      ,[DireccionAnterior]
      ,[Direccion]
	  ,[ZonaAnterior]
	  ,[Zona]
      ,[Referencia]
      ,[CodigoConsultora]
      ,[Latitud]
      ,[Longitud]
      ,[LatitudAnterior]
      ,[LongitudAnterior]
  FROM [dbo].[DireccionEntrega] where ConsultoraID =@ConsultoraID
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerDireccionEntregaPorConsultora]') 
	AND type in (N'P', N'PC')
) 
  DROP PROCEDURE [dbo].[ObtenerDireccionEntregaPorConsultora]
GO
CREATE PROCEDURE ObtenerDireccionEntregaPorConsultora
	@ConsultoraID int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT  
       [DireccionEntregaID]
      ,[ConsultoraID]
      ,[CampaniaID]
      ,[CampaniaAnteriorID]
      ,[Ubigeo1]
      ,[Ubigeo2]
      ,[Ubigeo3]
      ,[Ubigeo1Anterior]
      ,[Ubigeo2Anterior]
      ,[Ubigeo3Anterior]
      ,[DireccionAnterior]
      ,[Direccion]
	  ,[ZonaAnterior]
	  ,[Zona]
      ,[Referencia]
      ,[CodigoConsultora]
      ,[Latitud]
      ,[Longitud]
      ,[LatitudAnterior]
      ,[LongitudAnterior]
  FROM [dbo].[DireccionEntrega] where ConsultoraID =@ConsultoraID
END
GO

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerDireccionEntregaPorConsultora]') 
	AND type in (N'P', N'PC')
) 
  DROP PROCEDURE [dbo].[ObtenerDireccionEntregaPorConsultora]
GO
CREATE PROCEDURE ObtenerDireccionEntregaPorConsultora
	@ConsultoraID int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT  
       [DireccionEntregaID]
      ,[ConsultoraID]
      ,[CampaniaID]
      ,[CampaniaAnteriorID]
      ,[Ubigeo1]
      ,[Ubigeo2]
      ,[Ubigeo3]
      ,[Ubigeo1Anterior]
      ,[Ubigeo2Anterior]
      ,[Ubigeo3Anterior]
      ,[DireccionAnterior]
      ,[Direccion]
	  ,[ZonaAnterior]
	  ,[Zona]
      ,[Referencia]
      ,[CodigoConsultora]
      ,[Latitud]
      ,[Longitud]
      ,[LatitudAnterior]
      ,[LongitudAnterior]
  FROM [dbo].[DireccionEntrega] where ConsultoraID =@ConsultoraID
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerDireccionEntregaPorConsultora]') 
	AND type in (N'P', N'PC')
) 
  DROP PROCEDURE [dbo].[ObtenerDireccionEntregaPorConsultora]
GO
CREATE PROCEDURE ObtenerDireccionEntregaPorConsultora
	@ConsultoraID int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT  
       [DireccionEntregaID]
      ,[ConsultoraID]
      ,[CampaniaID]
      ,[CampaniaAnteriorID]
      ,[Ubigeo1]
      ,[Ubigeo2]
      ,[Ubigeo3]
      ,[Ubigeo1Anterior]
      ,[Ubigeo2Anterior]
      ,[Ubigeo3Anterior]
      ,[DireccionAnterior]
      ,[Direccion]
	  ,[ZonaAnterior]
	  ,[Zona]
      ,[Referencia]
      ,[CodigoConsultora]
      ,[Latitud]
      ,[Longitud]
      ,[LatitudAnterior]
      ,[LongitudAnterior]
  FROM [dbo].[DireccionEntrega] where ConsultoraID =@ConsultoraID
END
GO

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerDireccionEntregaPorConsultora]') 
	AND type in (N'P', N'PC')
) 
  DROP PROCEDURE [dbo].[ObtenerDireccionEntregaPorConsultora]
GO
CREATE PROCEDURE ObtenerDireccionEntregaPorConsultora
	@ConsultoraID int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT  
       [DireccionEntregaID]
      ,[ConsultoraID]
      ,[CampaniaID]
      ,[CampaniaAnteriorID]
      ,[Ubigeo1]
      ,[Ubigeo2]
      ,[Ubigeo3]
      ,[Ubigeo1Anterior]
      ,[Ubigeo2Anterior]
      ,[Ubigeo3Anterior]
      ,[DireccionAnterior]
      ,[Direccion]
	  ,[ZonaAnterior]
	  ,[Zona]
      ,[Referencia]
      ,[CodigoConsultora]
      ,[Latitud]
      ,[Longitud]
      ,[LatitudAnterior]
      ,[LongitudAnterior]
  FROM [dbo].[DireccionEntrega] where ConsultoraID =@ConsultoraID
END
GO

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerDireccionEntregaPorConsultora]') 
	AND type in (N'P', N'PC')
) 
  DROP PROCEDURE [dbo].[ObtenerDireccionEntregaPorConsultora]
GO
CREATE PROCEDURE ObtenerDireccionEntregaPorConsultora
	@ConsultoraID int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT  
       [DireccionEntregaID]
      ,[ConsultoraID]
      ,[CampaniaID]
      ,[CampaniaAnteriorID]
      ,[Ubigeo1]
      ,[Ubigeo2]
      ,[Ubigeo3]
      ,[Ubigeo1Anterior]
      ,[Ubigeo2Anterior]
      ,[Ubigeo3Anterior]
      ,[DireccionAnterior]
      ,[Direccion]
	  ,[ZonaAnterior]
	  ,[Zona]
      ,[Referencia]
      ,[CodigoConsultora]
      ,[Latitud]
      ,[Longitud]
      ,[LatitudAnterior]
      ,[LongitudAnterior]
  FROM [dbo].[DireccionEntrega] where ConsultoraID =@ConsultoraID
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerDireccionEntregaPorConsultora]') 
	AND type in (N'P', N'PC')
) 
  DROP PROCEDURE [dbo].[ObtenerDireccionEntregaPorConsultora]
GO
CREATE PROCEDURE ObtenerDireccionEntregaPorConsultora
	@ConsultoraID int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT  
       [DireccionEntregaID]
      ,[ConsultoraID]
      ,[CampaniaID]
      ,[CampaniaAnteriorID]
      ,[Ubigeo1]
      ,[Ubigeo2]
      ,[Ubigeo3]
      ,[Ubigeo1Anterior]
      ,[Ubigeo2Anterior]
      ,[Ubigeo3Anterior]
      ,[DireccionAnterior]
      ,[Direccion]
	  ,[ZonaAnterior]
	  ,[Zona]
      ,[Referencia]
      ,[CodigoConsultora]
      ,[Latitud]
      ,[Longitud]
      ,[LatitudAnterior]
      ,[LongitudAnterior]
  FROM [dbo].[DireccionEntrega] where ConsultoraID =@ConsultoraID
END
GO

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerDireccionEntregaPorConsultora]') 
	AND type in (N'P', N'PC')
) 
  DROP PROCEDURE [dbo].[ObtenerDireccionEntregaPorConsultora]
GO
CREATE PROCEDURE ObtenerDireccionEntregaPorConsultora
	@ConsultoraID int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT  
       [DireccionEntregaID]
      ,[ConsultoraID]
      ,[CampaniaID]
      ,[CampaniaAnteriorID]
      ,[Ubigeo1]
      ,[Ubigeo2]
      ,[Ubigeo3]
      ,[Ubigeo1Anterior]
      ,[Ubigeo2Anterior]
      ,[Ubigeo3Anterior]
      ,[DireccionAnterior]
      ,[Direccion]
	  ,[ZonaAnterior]
	  ,[Zona]
      ,[Referencia]
      ,[CodigoConsultora]
      ,[Latitud]
      ,[Longitud]
      ,[LatitudAnterior]
      ,[LongitudAnterior]
  FROM [dbo].[DireccionEntrega] where ConsultoraID =@ConsultoraID
END
GO

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerDireccionEntregaPorConsultora]') 
	AND type in (N'P', N'PC')
) 
  DROP PROCEDURE [dbo].[ObtenerDireccionEntregaPorConsultora]
GO
CREATE PROCEDURE ObtenerDireccionEntregaPorConsultora
	@ConsultoraID int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT  
       [DireccionEntregaID]
      ,[ConsultoraID]
      ,[CampaniaID]
      ,[CampaniaAnteriorID]
      ,[Ubigeo1]
      ,[Ubigeo2]
      ,[Ubigeo3]
      ,[Ubigeo1Anterior]
      ,[Ubigeo2Anterior]
      ,[Ubigeo3Anterior]
      ,[DireccionAnterior]
      ,[Direccion]
	  ,[ZonaAnterior]
	  ,[Zona]
      ,[Referencia]
      ,[CodigoConsultora]
      ,[Latitud]
      ,[Longitud]
      ,[LatitudAnterior]
      ,[LongitudAnterior]
  FROM [dbo].[DireccionEntrega] where ConsultoraID =@ConsultoraID
END
GO

