GO
USE BelcorpPeru
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_List] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_List
@CampaniaID int,
@ConsultoraID int
AS
BEGIN

SELECT [LogConsultoraPagoContadoID]
      ,[CampaniaID]
      ,[ConsultoraID]
      ,[TotalAtendido]
      ,[TotalDescuento]
      ,[TotalFlete]
      ,[PagoTotalSinDeuda]
	  ,[PagoTotal]
	  ,[TotalDeuda]
      ,[Activo]
      ,[FechaActualizacion]
  FROM [dbo].[LogConsultoraPagoContado]
  WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

END

GO
USE BelcorpMexico
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_List] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_List
@CampaniaID int,
@ConsultoraID int
AS
BEGIN

SELECT [LogConsultoraPagoContadoID]
      ,[CampaniaID]
      ,[ConsultoraID]
      ,[TotalAtendido]
      ,[TotalDescuento]
      ,[TotalFlete]
      ,[PagoTotalSinDeuda]
	  ,[PagoTotal]
	  ,[TotalDeuda]
      ,[Activo]
      ,[FechaActualizacion]
  FROM [dbo].[LogConsultoraPagoContado]
  WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

END

GO
USE BelcorpColombia
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_List] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_List
@CampaniaID int,
@ConsultoraID int
AS
BEGIN

SELECT [LogConsultoraPagoContadoID]
      ,[CampaniaID]
      ,[ConsultoraID]
      ,[TotalAtendido]
      ,[TotalDescuento]
      ,[TotalFlete]
      ,[PagoTotalSinDeuda]
	  ,[PagoTotal]
	  ,[TotalDeuda]
      ,[Activo]
      ,[FechaActualizacion]
  FROM [dbo].[LogConsultoraPagoContado]
  WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

END

GO
USE BelcorpSalvador
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_List] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_List
@CampaniaID int,
@ConsultoraID int
AS
BEGIN

SELECT [LogConsultoraPagoContadoID]
      ,[CampaniaID]
      ,[ConsultoraID]
      ,[TotalAtendido]
      ,[TotalDescuento]
      ,[TotalFlete]
      ,[PagoTotalSinDeuda]
	  ,[PagoTotal]
	  ,[TotalDeuda]
      ,[Activo]
      ,[FechaActualizacion]
  FROM [dbo].[LogConsultoraPagoContado]
  WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

END

GO
USE BelcorpPuertoRico
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_List] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_List
@CampaniaID int,
@ConsultoraID int
AS
BEGIN

SELECT [LogConsultoraPagoContadoID]
      ,[CampaniaID]
      ,[ConsultoraID]
      ,[TotalAtendido]
      ,[TotalDescuento]
      ,[TotalFlete]
      ,[PagoTotalSinDeuda]
	  ,[PagoTotal]
	  ,[TotalDeuda]
      ,[Activo]
      ,[FechaActualizacion]
  FROM [dbo].[LogConsultoraPagoContado]
  WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

END

GO
USE BelcorpPanama
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_List] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_List
@CampaniaID int,
@ConsultoraID int
AS
BEGIN

SELECT [LogConsultoraPagoContadoID]
      ,[CampaniaID]
      ,[ConsultoraID]
      ,[TotalAtendido]
      ,[TotalDescuento]
      ,[TotalFlete]
      ,[PagoTotalSinDeuda]
	  ,[PagoTotal]
	  ,[TotalDeuda]
      ,[Activo]
      ,[FechaActualizacion]
  FROM [dbo].[LogConsultoraPagoContado]
  WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

END

GO
USE BelcorpGuatemala
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_List] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_List
@CampaniaID int,
@ConsultoraID int
AS
BEGIN

SELECT [LogConsultoraPagoContadoID]
      ,[CampaniaID]
      ,[ConsultoraID]
      ,[TotalAtendido]
      ,[TotalDescuento]
      ,[TotalFlete]
      ,[PagoTotalSinDeuda]
	  ,[PagoTotal]
	  ,[TotalDeuda]
      ,[Activo]
      ,[FechaActualizacion]
  FROM [dbo].[LogConsultoraPagoContado]
  WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

END

GO
USE BelcorpEcuador
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_List] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_List
@CampaniaID int,
@ConsultoraID int
AS
BEGIN

SELECT [LogConsultoraPagoContadoID]
      ,[CampaniaID]
      ,[ConsultoraID]
      ,[TotalAtendido]
      ,[TotalDescuento]
      ,[TotalFlete]
      ,[PagoTotalSinDeuda]
	  ,[PagoTotal]
	  ,[TotalDeuda]
      ,[Activo]
      ,[FechaActualizacion]
  FROM [dbo].[LogConsultoraPagoContado]
  WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

END

GO
USE BelcorpDominicana
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_List] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_List
@CampaniaID int,
@ConsultoraID int
AS
BEGIN

SELECT [LogConsultoraPagoContadoID]
      ,[CampaniaID]
      ,[ConsultoraID]
      ,[TotalAtendido]
      ,[TotalDescuento]
      ,[TotalFlete]
      ,[PagoTotalSinDeuda]
	  ,[PagoTotal]
	  ,[TotalDeuda]
      ,[Activo]
      ,[FechaActualizacion]
  FROM [dbo].[LogConsultoraPagoContado]
  WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

END

GO
USE BelcorpCostaRica
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_List] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_List
@CampaniaID int,
@ConsultoraID int
AS
BEGIN

SELECT [LogConsultoraPagoContadoID]
      ,[CampaniaID]
      ,[ConsultoraID]
      ,[TotalAtendido]
      ,[TotalDescuento]
      ,[TotalFlete]
      ,[PagoTotalSinDeuda]
	  ,[PagoTotal]
	  ,[TotalDeuda]
      ,[Activo]
      ,[FechaActualizacion]
  FROM [dbo].[LogConsultoraPagoContado]
  WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

END

GO
USE BelcorpChile
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_List] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_List
@CampaniaID int,
@ConsultoraID int
AS
BEGIN

SELECT [LogConsultoraPagoContadoID]
      ,[CampaniaID]
      ,[ConsultoraID]
      ,[TotalAtendido]
      ,[TotalDescuento]
      ,[TotalFlete]
      ,[PagoTotalSinDeuda]
	  ,[PagoTotal]
	  ,[TotalDeuda]
      ,[Activo]
      ,[FechaActualizacion]
  FROM [dbo].[LogConsultoraPagoContado]
  WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

END

GO
USE BelcorpBolivia
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_List]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_List] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_List
@CampaniaID int,
@ConsultoraID int
AS
BEGIN

SELECT [LogConsultoraPagoContadoID]
      ,[CampaniaID]
      ,[ConsultoraID]
      ,[TotalAtendido]
      ,[TotalDescuento]
      ,[TotalFlete]
      ,[PagoTotalSinDeuda]
	  ,[PagoTotal]
	  ,[TotalDeuda]
      ,[Activo]
      ,[FechaActualizacion]
  FROM [dbo].[LogConsultoraPagoContado]
  WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

END

GO
