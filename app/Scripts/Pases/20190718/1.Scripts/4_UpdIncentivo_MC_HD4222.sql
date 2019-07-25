GO
USE BelcorpPeru
GO
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

GO
USE BelcorpMexico
GO
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

GO
USE BelcorpColombia
GO
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

GO
USE BelcorpSalvador
GO
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

GO
USE BelcorpPuertoRico
GO
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

GO
USE BelcorpPanama
GO
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

GO
USE BelcorpGuatemala
GO
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

GO
USE BelcorpEcuador
GO
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

GO
USE BelcorpDominicana
GO
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

GO
USE BelcorpCostaRica
GO
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

GO
USE BelcorpChile
GO
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

GO
USE BelcorpBolivia
GO
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

GO
