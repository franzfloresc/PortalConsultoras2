use belcorpPeru_bpt
go

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MuestraPopup'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MuestraPopup BIT NULL

END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MontoInicial'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MontoInicial decimal(18,2) NULL

END
go

--=================================================================

use belcorpBolivia
go

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MuestraPopup'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MuestraPopup BIT NULL

END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MontoInicial'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MontoInicial decimal(18,2) NULL

END
go
use belcorpChile
go

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MuestraPopup'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MuestraPopup BIT NULL

END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MontoInicial'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MontoInicial decimal(18,2) NULL

END
go
use belcorpColombia
go

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MuestraPopup'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MuestraPopup BIT NULL

END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MontoInicial'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MontoInicial decimal(18,2) NULL

END
go
use belcorpCostaRica
go

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MuestraPopup'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MuestraPopup BIT NULL

END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MontoInicial'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MontoInicial decimal(18,2) NULL

END
go
use belcorpDominicana
go

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MuestraPopup'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MuestraPopup BIT NULL

END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MontoInicial'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MontoInicial decimal(18,2) NULL

END
go
use belcorpEcuador
go

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MuestraPopup'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MuestraPopup BIT NULL

END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MontoInicial'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MontoInicial decimal(18,2) NULL

END
go
use belcorpGuatemala
go

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MuestraPopup'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MuestraPopup BIT NULL

END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MontoInicial'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MontoInicial decimal(18,2) NULL

END
go
use belcorpMexico
go

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MuestraPopup'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MuestraPopup BIT NULL

END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MontoInicial'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MontoInicial decimal(18,2) NULL

END
go
use belcorpPanama
go

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MuestraPopup'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MuestraPopup BIT NULL

END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MontoInicial'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MontoInicial decimal(18,2) NULL

END
go
use belcorpPeru
go

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MuestraPopup'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MuestraPopup BIT NULL

END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MontoInicial'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MontoInicial decimal(18,2) NULL

END
go
use belcorpPuertoRico
go

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MuestraPopup'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MuestraPopup BIT NULL

END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MontoInicial'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MontoInicial decimal(18,2) NULL

END
go
use belcorpSalvador
go

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MuestraPopup'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MuestraPopup BIT NULL

END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') 
         AND name = 'MontoInicial'
)
BEGIN

   ALTER TABLE [dbo].[OfertaFinalConsultora_Log]
    ADD MontoInicial decimal(18,2) NULL

END
go
