USE BelcorpPeru
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
alter procedure [dbo].[ValidarDesactivaRevistaGana](  
@CampaniaID int,  
@Codigo Varchar(15)  
)  
AS  
------------------------------------------------------------------------------------  
-- Nombre: [dbo].[ValidarDesactivaRevistaGana]  
-- Objetivo: Verificar si la revista gana se desactiva para esta campaña  
-- Valores Prueba: [dbo].[ValidarDesactivaRevistaGana] 201415, '1509'  
-- Creacion: BLC(RALM) 20141001  
-- Ultima Notificacion: BLC(RALM) 20141001  
------------------------------------------------------------------------------------  
BEGIN TRY  
 SET NOCOUNT ON  
  
 SELECT COUNT(*)AS CUENTA  
 FROM [dbo].[DesactivaRevistaGana]   
 WHERE CampaniaID = @CampaniaID  
  AND CodigoZona = @Codigo  
  
 SET NOCOUNT OFF  
END TRY  
BEGIN CATCH  
  
 DECLARE @ErrorMessage VARCHAR(4000),@ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @ErrorLine INT, @ErrorProcedure VARCHAR(200)  
 SELECT @ErrorNumber = ERROR_NUMBER()  
 , @ErrorSeverity = ERROR_SEVERITY()  
 , @ErrorState = ERROR_STATE()  
 , @ErrorLine = ERROR_LINE()  
 , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(),'-')  
  
 SELECT @ErrorMessage = N'ERROR:%d|Nivel%d|Procedimiento %s|Linea%d|'+  
 'Mensaje: '+ ERROR_MESSAGE()  
   
 RAISERROR (@ErrorMessage,@ErrorSeverity,1,@ErrorNumber,@ErrorSeverity,@ErrorState,@ErrorProcedure,@ErrorLine)  
  
END CATCH  
GO

USE BelcorpMexico
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
alter procedure [dbo].[ValidarDesactivaRevistaGana](  
@CampaniaID int,  
@Codigo Varchar(15)  
)  
AS  
------------------------------------------------------------------------------------  
-- Nombre: [dbo].[ValidarDesactivaRevistaGana]  
-- Objetivo: Verificar si la revista gana se desactiva para esta campaña  
-- Valores Prueba: [dbo].[ValidarDesactivaRevistaGana] 201415, '1509'  
-- Creacion: BLC(RALM) 20141001  
-- Ultima Notificacion: BLC(RALM) 20141001  
------------------------------------------------------------------------------------  
BEGIN TRY  
 SET NOCOUNT ON  
  
 SELECT COUNT(*)AS CUENTA  
 FROM [dbo].[DesactivaRevistaGana]   
 WHERE CampaniaID = @CampaniaID  
  AND CodigoZona = @Codigo  
  
 SET NOCOUNT OFF  
END TRY  
BEGIN CATCH  
  
 DECLARE @ErrorMessage VARCHAR(4000),@ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @ErrorLine INT, @ErrorProcedure VARCHAR(200)  
 SELECT @ErrorNumber = ERROR_NUMBER()  
 , @ErrorSeverity = ERROR_SEVERITY()  
 , @ErrorState = ERROR_STATE()  
 , @ErrorLine = ERROR_LINE()  
 , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(),'-')  
  
 SELECT @ErrorMessage = N'ERROR:%d|Nivel%d|Procedimiento %s|Linea%d|'+  
 'Mensaje: '+ ERROR_MESSAGE()  
   
 RAISERROR (@ErrorMessage,@ErrorSeverity,1,@ErrorNumber,@ErrorSeverity,@ErrorState,@ErrorProcedure,@ErrorLine)  
  
END CATCH  
GO

USE BelcorpColombia
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
alter procedure [dbo].[ValidarDesactivaRevistaGana](  
@CampaniaID int,  
@Codigo Varchar(15)  
)  
AS  
------------------------------------------------------------------------------------  
-- Nombre: [dbo].[ValidarDesactivaRevistaGana]  
-- Objetivo: Verificar si la revista gana se desactiva para esta campaña  
-- Valores Prueba: [dbo].[ValidarDesactivaRevistaGana] 201415, '1509'  
-- Creacion: BLC(RALM) 20141001  
-- Ultima Notificacion: BLC(RALM) 20141001  
------------------------------------------------------------------------------------  
BEGIN TRY  
 SET NOCOUNT ON  
  
 SELECT COUNT(*)AS CUENTA  
 FROM [dbo].[DesactivaRevistaGana]   
 WHERE CampaniaID = @CampaniaID  
  AND CodigoZona = @Codigo  
  
 SET NOCOUNT OFF  
END TRY  
BEGIN CATCH  
  
 DECLARE @ErrorMessage VARCHAR(4000),@ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @ErrorLine INT, @ErrorProcedure VARCHAR(200)  
 SELECT @ErrorNumber = ERROR_NUMBER()  
 , @ErrorSeverity = ERROR_SEVERITY()  
 , @ErrorState = ERROR_STATE()  
 , @ErrorLine = ERROR_LINE()  
 , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(),'-')  
  
 SELECT @ErrorMessage = N'ERROR:%d|Nivel%d|Procedimiento %s|Linea%d|'+  
 'Mensaje: '+ ERROR_MESSAGE()  
   
 RAISERROR (@ErrorMessage,@ErrorSeverity,1,@ErrorNumber,@ErrorSeverity,@ErrorState,@ErrorProcedure,@ErrorLine)  
  
END CATCH  
GO

USE BelcorpSalvador
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
alter procedure [dbo].[ValidarDesactivaRevistaGana](  
@CampaniaID int,  
@Codigo Varchar(15)  
)  
AS  
------------------------------------------------------------------------------------  
-- Nombre: [dbo].[ValidarDesactivaRevistaGana]  
-- Objetivo: Verificar si la revista gana se desactiva para esta campaña  
-- Valores Prueba: [dbo].[ValidarDesactivaRevistaGana] 201415, '1509'  
-- Creacion: BLC(RALM) 20141001  
-- Ultima Notificacion: BLC(RALM) 20141001  
------------------------------------------------------------------------------------  
BEGIN TRY  
 SET NOCOUNT ON  
  
 SELECT COUNT(*)AS CUENTA  
 FROM [dbo].[DesactivaRevistaGana]   
 WHERE CampaniaID = @CampaniaID  
  AND CodigoZona = @Codigo  
  
 SET NOCOUNT OFF  
END TRY  
BEGIN CATCH  
  
 DECLARE @ErrorMessage VARCHAR(4000),@ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @ErrorLine INT, @ErrorProcedure VARCHAR(200)  
 SELECT @ErrorNumber = ERROR_NUMBER()  
 , @ErrorSeverity = ERROR_SEVERITY()  
 , @ErrorState = ERROR_STATE()  
 , @ErrorLine = ERROR_LINE()  
 , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(),'-')  
  
 SELECT @ErrorMessage = N'ERROR:%d|Nivel%d|Procedimiento %s|Linea%d|'+  
 'Mensaje: '+ ERROR_MESSAGE()  
   
 RAISERROR (@ErrorMessage,@ErrorSeverity,1,@ErrorNumber,@ErrorSeverity,@ErrorState,@ErrorProcedure,@ErrorLine)  
  
END CATCH  
GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
alter procedure [dbo].[ValidarDesactivaRevistaGana](  
@CampaniaID int,  
@Codigo Varchar(15)  
)  
AS  
------------------------------------------------------------------------------------  
-- Nombre: [dbo].[ValidarDesactivaRevistaGana]  
-- Objetivo: Verificar si la revista gana se desactiva para esta campaña  
-- Valores Prueba: [dbo].[ValidarDesactivaRevistaGana] 201415, '1509'  
-- Creacion: BLC(RALM) 20141001  
-- Ultima Notificacion: BLC(RALM) 20141001  
------------------------------------------------------------------------------------  
BEGIN TRY  
 SET NOCOUNT ON  
  
 SELECT COUNT(*)AS CUENTA  
 FROM [dbo].[DesactivaRevistaGana]   
 WHERE CampaniaID = @CampaniaID  
  AND CodigoZona = @Codigo  
  
 SET NOCOUNT OFF  
END TRY  
BEGIN CATCH  
  
 DECLARE @ErrorMessage VARCHAR(4000),@ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @ErrorLine INT, @ErrorProcedure VARCHAR(200)  
 SELECT @ErrorNumber = ERROR_NUMBER()  
 , @ErrorSeverity = ERROR_SEVERITY()  
 , @ErrorState = ERROR_STATE()  
 , @ErrorLine = ERROR_LINE()  
 , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(),'-')  
  
 SELECT @ErrorMessage = N'ERROR:%d|Nivel%d|Procedimiento %s|Linea%d|'+  
 'Mensaje: '+ ERROR_MESSAGE()  
   
 RAISERROR (@ErrorMessage,@ErrorSeverity,1,@ErrorNumber,@ErrorSeverity,@ErrorState,@ErrorProcedure,@ErrorLine)  
  
END CATCH  
GO

USE BelcorpPanama
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
alter procedure [dbo].[ValidarDesactivaRevistaGana](  
@CampaniaID int,  
@Codigo Varchar(15)  
)  
AS  
------------------------------------------------------------------------------------  
-- Nombre: [dbo].[ValidarDesactivaRevistaGana]  
-- Objetivo: Verificar si la revista gana se desactiva para esta campaña  
-- Valores Prueba: [dbo].[ValidarDesactivaRevistaGana] 201415, '1509'  
-- Creacion: BLC(RALM) 20141001  
-- Ultima Notificacion: BLC(RALM) 20141001  
------------------------------------------------------------------------------------  
BEGIN TRY  
 SET NOCOUNT ON  
  
 SELECT COUNT(*)AS CUENTA  
 FROM [dbo].[DesactivaRevistaGana]   
 WHERE CampaniaID = @CampaniaID  
  AND CodigoZona = @Codigo  
  
 SET NOCOUNT OFF  
END TRY  
BEGIN CATCH  
  
 DECLARE @ErrorMessage VARCHAR(4000),@ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @ErrorLine INT, @ErrorProcedure VARCHAR(200)  
 SELECT @ErrorNumber = ERROR_NUMBER()  
 , @ErrorSeverity = ERROR_SEVERITY()  
 , @ErrorState = ERROR_STATE()  
 , @ErrorLine = ERROR_LINE()  
 , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(),'-')  
  
 SELECT @ErrorMessage = N'ERROR:%d|Nivel%d|Procedimiento %s|Linea%d|'+  
 'Mensaje: '+ ERROR_MESSAGE()  
   
 RAISERROR (@ErrorMessage,@ErrorSeverity,1,@ErrorNumber,@ErrorSeverity,@ErrorState,@ErrorProcedure,@ErrorLine)  
  
END CATCH  
GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
alter procedure [dbo].[ValidarDesactivaRevistaGana](  
@CampaniaID int,  
@Codigo Varchar(15)  
)  
AS  
------------------------------------------------------------------------------------  
-- Nombre: [dbo].[ValidarDesactivaRevistaGana]  
-- Objetivo: Verificar si la revista gana se desactiva para esta campaña  
-- Valores Prueba: [dbo].[ValidarDesactivaRevistaGana] 201415, '1509'  
-- Creacion: BLC(RALM) 20141001  
-- Ultima Notificacion: BLC(RALM) 20141001  
------------------------------------------------------------------------------------  
BEGIN TRY  
 SET NOCOUNT ON  
  
 SELECT COUNT(*)AS CUENTA  
 FROM [dbo].[DesactivaRevistaGana]   
 WHERE CampaniaID = @CampaniaID  
  AND CodigoZona = @Codigo  
  
 SET NOCOUNT OFF  
END TRY  
BEGIN CATCH  
  
 DECLARE @ErrorMessage VARCHAR(4000),@ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @ErrorLine INT, @ErrorProcedure VARCHAR(200)  
 SELECT @ErrorNumber = ERROR_NUMBER()  
 , @ErrorSeverity = ERROR_SEVERITY()  
 , @ErrorState = ERROR_STATE()  
 , @ErrorLine = ERROR_LINE()  
 , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(),'-')  
  
 SELECT @ErrorMessage = N'ERROR:%d|Nivel%d|Procedimiento %s|Linea%d|'+  
 'Mensaje: '+ ERROR_MESSAGE()  
   
 RAISERROR (@ErrorMessage,@ErrorSeverity,1,@ErrorNumber,@ErrorSeverity,@ErrorState,@ErrorProcedure,@ErrorLine)  
  
END CATCH  
GO

USE BelcorpEcuador
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
alter procedure [dbo].[ValidarDesactivaRevistaGana](  
@CampaniaID int,  
@Codigo Varchar(15)  
)  
AS  
------------------------------------------------------------------------------------  
-- Nombre: [dbo].[ValidarDesactivaRevistaGana]  
-- Objetivo: Verificar si la revista gana se desactiva para esta campaña  
-- Valores Prueba: [dbo].[ValidarDesactivaRevistaGana] 201415, '1509'  
-- Creacion: BLC(RALM) 20141001  
-- Ultima Notificacion: BLC(RALM) 20141001  
------------------------------------------------------------------------------------  
BEGIN TRY  
 SET NOCOUNT ON  
  
 SELECT COUNT(*)AS CUENTA  
 FROM [dbo].[DesactivaRevistaGana]   
 WHERE CampaniaID = @CampaniaID  
  AND CodigoZona = @Codigo  
  
 SET NOCOUNT OFF  
END TRY  
BEGIN CATCH  
  
 DECLARE @ErrorMessage VARCHAR(4000),@ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @ErrorLine INT, @ErrorProcedure VARCHAR(200)  
 SELECT @ErrorNumber = ERROR_NUMBER()  
 , @ErrorSeverity = ERROR_SEVERITY()  
 , @ErrorState = ERROR_STATE()  
 , @ErrorLine = ERROR_LINE()  
 , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(),'-')  
  
 SELECT @ErrorMessage = N'ERROR:%d|Nivel%d|Procedimiento %s|Linea%d|'+  
 'Mensaje: '+ ERROR_MESSAGE()  
   
 RAISERROR (@ErrorMessage,@ErrorSeverity,1,@ErrorNumber,@ErrorSeverity,@ErrorState,@ErrorProcedure,@ErrorLine)  
  
END CATCH  
GO

USE BelcorpDominicana
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
alter procedure [dbo].[ValidarDesactivaRevistaGana](  
@CampaniaID int,  
@Codigo Varchar(15)  
)  
AS  
------------------------------------------------------------------------------------  
-- Nombre: [dbo].[ValidarDesactivaRevistaGana]  
-- Objetivo: Verificar si la revista gana se desactiva para esta campaña  
-- Valores Prueba: [dbo].[ValidarDesactivaRevistaGana] 201415, '1509'  
-- Creacion: BLC(RALM) 20141001  
-- Ultima Notificacion: BLC(RALM) 20141001  
------------------------------------------------------------------------------------  
BEGIN TRY  
 SET NOCOUNT ON  
  
 SELECT COUNT(*)AS CUENTA  
 FROM [dbo].[DesactivaRevistaGana]   
 WHERE CampaniaID = @CampaniaID  
  AND CodigoZona = @Codigo  
  
 SET NOCOUNT OFF  
END TRY  
BEGIN CATCH  
  
 DECLARE @ErrorMessage VARCHAR(4000),@ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @ErrorLine INT, @ErrorProcedure VARCHAR(200)  
 SELECT @ErrorNumber = ERROR_NUMBER()  
 , @ErrorSeverity = ERROR_SEVERITY()  
 , @ErrorState = ERROR_STATE()  
 , @ErrorLine = ERROR_LINE()  
 , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(),'-')  
  
 SELECT @ErrorMessage = N'ERROR:%d|Nivel%d|Procedimiento %s|Linea%d|'+  
 'Mensaje: '+ ERROR_MESSAGE()  
   
 RAISERROR (@ErrorMessage,@ErrorSeverity,1,@ErrorNumber,@ErrorSeverity,@ErrorState,@ErrorProcedure,@ErrorLine)  
  
END CATCH  
GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
alter procedure [dbo].[ValidarDesactivaRevistaGana](  
@CampaniaID int,  
@Codigo Varchar(15)  
)  
AS  
------------------------------------------------------------------------------------  
-- Nombre: [dbo].[ValidarDesactivaRevistaGana]  
-- Objetivo: Verificar si la revista gana se desactiva para esta campaña  
-- Valores Prueba: [dbo].[ValidarDesactivaRevistaGana] 201415, '1509'  
-- Creacion: BLC(RALM) 20141001  
-- Ultima Notificacion: BLC(RALM) 20141001  
------------------------------------------------------------------------------------  
BEGIN TRY  
 SET NOCOUNT ON  
  
 SELECT COUNT(*)AS CUENTA  
 FROM [dbo].[DesactivaRevistaGana]   
 WHERE CampaniaID = @CampaniaID  
  AND CodigoZona = @Codigo  
  
 SET NOCOUNT OFF  
END TRY  
BEGIN CATCH  
  
 DECLARE @ErrorMessage VARCHAR(4000),@ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @ErrorLine INT, @ErrorProcedure VARCHAR(200)  
 SELECT @ErrorNumber = ERROR_NUMBER()  
 , @ErrorSeverity = ERROR_SEVERITY()  
 , @ErrorState = ERROR_STATE()  
 , @ErrorLine = ERROR_LINE()  
 , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(),'-')  
  
 SELECT @ErrorMessage = N'ERROR:%d|Nivel%d|Procedimiento %s|Linea%d|'+  
 'Mensaje: '+ ERROR_MESSAGE()  
   
 RAISERROR (@ErrorMessage,@ErrorSeverity,1,@ErrorNumber,@ErrorSeverity,@ErrorState,@ErrorProcedure,@ErrorLine)  
  
END CATCH  
GO

USE BelcorpChile
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
alter procedure [dbo].[ValidarDesactivaRevistaGana](  
@CampaniaID int,  
@Codigo Varchar(15)  
)  
AS  
------------------------------------------------------------------------------------  
-- Nombre: [dbo].[ValidarDesactivaRevistaGana]  
-- Objetivo: Verificar si la revista gana se desactiva para esta campaña  
-- Valores Prueba: [dbo].[ValidarDesactivaRevistaGana] 201415, '1509'  
-- Creacion: BLC(RALM) 20141001  
-- Ultima Notificacion: BLC(RALM) 20141001  
------------------------------------------------------------------------------------  
BEGIN TRY  
 SET NOCOUNT ON  
  
 SELECT COUNT(*)AS CUENTA  
 FROM [dbo].[DesactivaRevistaGana]   
 WHERE CampaniaID = @CampaniaID  
  AND CodigoZona = @Codigo  
  
 SET NOCOUNT OFF  
END TRY  
BEGIN CATCH  
  
 DECLARE @ErrorMessage VARCHAR(4000),@ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @ErrorLine INT, @ErrorProcedure VARCHAR(200)  
 SELECT @ErrorNumber = ERROR_NUMBER()  
 , @ErrorSeverity = ERROR_SEVERITY()  
 , @ErrorState = ERROR_STATE()  
 , @ErrorLine = ERROR_LINE()  
 , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(),'-')  
  
 SELECT @ErrorMessage = N'ERROR:%d|Nivel%d|Procedimiento %s|Linea%d|'+  
 'Mensaje: '+ ERROR_MESSAGE()  
   
 RAISERROR (@ErrorMessage,@ErrorSeverity,1,@ErrorNumber,@ErrorSeverity,@ErrorState,@ErrorProcedure,@ErrorLine)  
  
END CATCH  
GO

USE BelcorpBolivia
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
alter procedure [dbo].[ValidarDesactivaRevistaGana](  
@CampaniaID int,  
@Codigo Varchar(15)  
)  
AS  
------------------------------------------------------------------------------------  
-- Nombre: [dbo].[ValidarDesactivaRevistaGana]  
-- Objetivo: Verificar si la revista gana se desactiva para esta campaña  
-- Valores Prueba: [dbo].[ValidarDesactivaRevistaGana] 201415, '1509'  
-- Creacion: BLC(RALM) 20141001  
-- Ultima Notificacion: BLC(RALM) 20141001  
------------------------------------------------------------------------------------  
BEGIN TRY  
 SET NOCOUNT ON  
  
 SELECT COUNT(*)AS CUENTA  
 FROM [dbo].[DesactivaRevistaGana]   
 WHERE CampaniaID = @CampaniaID  
  AND CodigoZona = @Codigo  
  
 SET NOCOUNT OFF  
END TRY  
BEGIN CATCH  
  
 DECLARE @ErrorMessage VARCHAR(4000),@ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @ErrorLine INT, @ErrorProcedure VARCHAR(200)  
 SELECT @ErrorNumber = ERROR_NUMBER()  
 , @ErrorSeverity = ERROR_SEVERITY()  
 , @ErrorState = ERROR_STATE()  
 , @ErrorLine = ERROR_LINE()  
 , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(),'-')  
  
 SELECT @ErrorMessage = N'ERROR:%d|Nivel%d|Procedimiento %s|Linea%d|'+  
 'Mensaje: '+ ERROR_MESSAGE()  
   
 RAISERROR (@ErrorMessage,@ErrorSeverity,1,@ErrorNumber,@ErrorSeverity,@ErrorState,@ErrorProcedure,@ErrorLine)  
  
END CATCH  
GO

