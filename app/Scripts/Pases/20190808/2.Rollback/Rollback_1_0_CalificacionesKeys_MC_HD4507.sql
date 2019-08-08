USE [BelcorpBolivia];
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
USE [BelcorpChile];
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
USE [BelcorpColombia];
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
USE [BelcorpCostaRica];
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
USE [BelcorpDominicana];
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
USE [BelcorpEcuador];
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
USE [BelcorpGuatemala];
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
USE [BelcorpMexico];
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
USE [BelcorpPanama];
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
USE [BelcorpPeru];
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
USE [BelcorpPuertoRico];
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
USE [BelcorpSalvador];
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
