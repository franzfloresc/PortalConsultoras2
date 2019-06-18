USE [BelcorpPeru_MC]
GO
/****** Object:  StoredProcedure [dbo].[UpdIncentivo]    Script Date: 17/6/2019 15:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[UpdIncentivo]
  @IncentivoID int,
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
  update Incentivo
  set PaisID=@PaisID, 
  CampaniaIDInicio=@CampaniaIDInicio, 
  CampaniaIDFin=@CampaniaIDFin, 
  ConsultoraID=@ConsultoraID, 
  Titulo=@Titulo, 
  Subtitulo=@Subtitulo, 
  ArchivoPortada=@ArchivoPortada, 
  ArchivoPDF=@ArchivoPDF,
  Url=@Url,
  Zona=@Zona,
  Segmento=@Segmento
  where IncentivoID = @IncentivoID
