USE BelcorpPeru
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.DelBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.DelBeneficioCaminoBrillante
END
GO
CREATE PROCEDURE DelBeneficioCaminoBrillante 
(
@CodigoNivel varchar(3),
@CodigoBeneficio varchar(15)
)
AS
BEGIN
Update BeneficioCaminoBrillante Set Estado = 0, FechaActualizacion = GETDATE()
		 Where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio
END
GO

USE BelcorpMexico
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.DelBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.DelBeneficioCaminoBrillante
END
GO
CREATE PROCEDURE DelBeneficioCaminoBrillante 
(
@CodigoNivel varchar(3),
@CodigoBeneficio varchar(15)
)
AS
BEGIN
Update BeneficioCaminoBrillante Set Estado = 0, FechaActualizacion = GETDATE()
		 Where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio
END
GO

USE BelcorpColombia
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.DelBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.DelBeneficioCaminoBrillante
END
GO
CREATE PROCEDURE DelBeneficioCaminoBrillante 
(
@CodigoNivel varchar(3),
@CodigoBeneficio varchar(15)
)
AS
BEGIN
Update BeneficioCaminoBrillante Set Estado = 0, FechaActualizacion = GETDATE()
		 Where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio
END
GO

USE BelcorpSalvador
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.DelBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.DelBeneficioCaminoBrillante
END
GO
CREATE PROCEDURE DelBeneficioCaminoBrillante 
(
@CodigoNivel varchar(3),
@CodigoBeneficio varchar(15)
)
AS
BEGIN
Update BeneficioCaminoBrillante Set Estado = 0, FechaActualizacion = GETDATE()
		 Where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.DelBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.DelBeneficioCaminoBrillante
END
GO
CREATE PROCEDURE DelBeneficioCaminoBrillante 
(
@CodigoNivel varchar(3),
@CodigoBeneficio varchar(15)
)
AS
BEGIN
Update BeneficioCaminoBrillante Set Estado = 0, FechaActualizacion = GETDATE()
		 Where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio
END
GO

USE BelcorpPanama
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.DelBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.DelBeneficioCaminoBrillante
END
GO
CREATE PROCEDURE DelBeneficioCaminoBrillante 
(
@CodigoNivel varchar(3),
@CodigoBeneficio varchar(15)
)
AS
BEGIN
Update BeneficioCaminoBrillante Set Estado = 0, FechaActualizacion = GETDATE()
		 Where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.DelBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.DelBeneficioCaminoBrillante
END
GO
CREATE PROCEDURE DelBeneficioCaminoBrillante 
(
@CodigoNivel varchar(3),
@CodigoBeneficio varchar(15)
)
AS
BEGIN
Update BeneficioCaminoBrillante Set Estado = 0, FechaActualizacion = GETDATE()
		 Where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio
END
GO

USE BelcorpEcuador
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.DelBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.DelBeneficioCaminoBrillante
END
GO
CREATE PROCEDURE DelBeneficioCaminoBrillante 
(
@CodigoNivel varchar(3),
@CodigoBeneficio varchar(15)
)
AS
BEGIN
Update BeneficioCaminoBrillante Set Estado = 0, FechaActualizacion = GETDATE()
		 Where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio
END
GO

USE BelcorpDominicana
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.DelBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.DelBeneficioCaminoBrillante
END
GO
CREATE PROCEDURE DelBeneficioCaminoBrillante 
(
@CodigoNivel varchar(3),
@CodigoBeneficio varchar(15)
)
AS
BEGIN
Update BeneficioCaminoBrillante Set Estado = 0, FechaActualizacion = GETDATE()
		 Where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.DelBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.DelBeneficioCaminoBrillante
END
GO
CREATE PROCEDURE DelBeneficioCaminoBrillante 
(
@CodigoNivel varchar(3),
@CodigoBeneficio varchar(15)
)
AS
BEGIN
Update BeneficioCaminoBrillante Set Estado = 0, FechaActualizacion = GETDATE()
		 Where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio
END
GO

USE BelcorpChile
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.DelBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.DelBeneficioCaminoBrillante
END
GO
CREATE PROCEDURE DelBeneficioCaminoBrillante 
(
@CodigoNivel varchar(3),
@CodigoBeneficio varchar(15)
)
AS
BEGIN
Update BeneficioCaminoBrillante Set Estado = 0, FechaActualizacion = GETDATE()
		 Where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio
END
GO

USE BelcorpBolivia
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.DelBeneficioCaminoBrillante'))
BEGIN
	DROP PROC dbo.DelBeneficioCaminoBrillante
END
GO
CREATE PROCEDURE DelBeneficioCaminoBrillante 
(
@CodigoNivel varchar(3),
@CodigoBeneficio varchar(15)
)
AS
BEGIN
Update BeneficioCaminoBrillante Set Estado = 0, FechaActualizacion = GETDATE()
		 Where CodigoNivel = @CodigoNivel and CodigoBeneficio = @CodigoBeneficio
END
GO