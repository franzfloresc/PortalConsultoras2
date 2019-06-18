USE [BelcorpPeru_MC]
GO
/****** Object:  StoredProcedure [dbo].[InsIncentivo]    Script Date: 17/6/2019 15:11:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[InsIncentivo]
  @PaisID int, 
  @CampaniaIDInicio int, 
  @CampaniaIDFin int,
  @ConsultoraID bigint, 
  @Titulo varchar(1000), 
  @Subtitulo varchar(1000) = null,
  @ArchivoPortada varchar(3000), 
  @ArchivoPDF varchar(3000),
  @Url varchar(1000),
  @Zona varchar(MAX)  = null,
  @Segmento varchar(MAX) = null
as
  insert Incentivo (PaisID, CampaniaIDInicio, CampaniaIDFin, ConsultoraID, Titulo, Subtitulo, ArchivoPortada, ArchivoPDF, Url, Zona, Segmento)
  values (@PaisID, @CampaniaIDInicio, @CampaniaIDFin, @ConsultoraID, @Titulo, @Subtitulo, @ArchivoPortada, @ArchivoPDF, @Url, @Zona, @Segmento)
