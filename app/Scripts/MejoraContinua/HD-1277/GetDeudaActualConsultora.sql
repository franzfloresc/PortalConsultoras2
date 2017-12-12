USE BelcorpPeru
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'GetDeudaActualConsultora')
	DROP PROC [dbo].[GetDeudaActualConsultora]

GO
CREATE PROCEDURE GetDeudaActualConsultora
(
@ConsultoraID int
)
AS 
BEGIN
	SELECT 
		MontoSaldoActual
	FROM ods.consultora 
	where ConsultoraID = @ConsultoraID
END
GO

USE BelcorpMexico
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'GetDeudaActualConsultora')
	DROP PROC [dbo].[GetDeudaActualConsultora]

GO
CREATE PROCEDURE GetDeudaActualConsultora
(
@ConsultoraID int
)
AS 
BEGIN
	SELECT 
		MontoSaldoActual
	FROM ods.consultora 
	where ConsultoraID = @ConsultoraID
END
GO

USE BelcorpColombia
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'GetDeudaActualConsultora')
	DROP PROC [dbo].[GetDeudaActualConsultora]

GO
CREATE PROCEDURE GetDeudaActualConsultora
(
@ConsultoraID int
)
AS 
BEGIN
	SELECT 
		MontoSaldoActual
	FROM ods.consultora 
	where ConsultoraID = @ConsultoraID
END
GO

USE BelcorpVenezuela
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'GetDeudaActualConsultora')
	DROP PROC [dbo].[GetDeudaActualConsultora]

GO
CREATE PROCEDURE GetDeudaActualConsultora
(
@ConsultoraID int
)
AS 
BEGIN
	SELECT 
		MontoSaldoActual
	FROM ods.consultora 
	where ConsultoraID = @ConsultoraID
END
GO

USE BelcorpSalvador
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'GetDeudaActualConsultora')
	DROP PROC [dbo].[GetDeudaActualConsultora]

GO
CREATE PROCEDURE GetDeudaActualConsultora
(
@ConsultoraID int
)
AS 
BEGIN
	SELECT 
		MontoSaldoActual
	FROM ods.consultora 
	where ConsultoraID = @ConsultoraID
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'GetDeudaActualConsultora')
	DROP PROC [dbo].[GetDeudaActualConsultora]

GO
CREATE PROCEDURE GetDeudaActualConsultora
(
@ConsultoraID int
)
AS 
BEGIN
	SELECT 
		MontoSaldoActual
	FROM ods.consultora 
	where ConsultoraID = @ConsultoraID
END
GO

USE BelcorpPanama
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'GetDeudaActualConsultora')
	DROP PROC [dbo].[GetDeudaActualConsultora]

GO
CREATE PROCEDURE GetDeudaActualConsultora
(
@ConsultoraID int
)
AS 
BEGIN
	SELECT 
		MontoSaldoActual
	FROM ods.consultora 
	where ConsultoraID = @ConsultoraID
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'GetDeudaActualConsultora')
	DROP PROC [dbo].[GetDeudaActualConsultora]

GO
CREATE PROCEDURE GetDeudaActualConsultora
(
@ConsultoraID int
)
AS 
BEGIN
	SELECT 
		MontoSaldoActual
	FROM ods.consultora 
	where ConsultoraID = @ConsultoraID
END
GO

USE BelcorpEcuador
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'GetDeudaActualConsultora')
	DROP PROC [dbo].[GetDeudaActualConsultora]

GO
CREATE PROCEDURE GetDeudaActualConsultora
(
@ConsultoraID int
)
AS 
BEGIN
	SELECT 
		MontoSaldoActual
	FROM ods.consultora 
	where ConsultoraID = @ConsultoraID
END
GO

USE BelcorpDominicana
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'GetDeudaActualConsultora')
	DROP PROC [dbo].[GetDeudaActualConsultora]

GO
CREATE PROCEDURE GetDeudaActualConsultora
(
@ConsultoraID int
)
AS 
BEGIN
	SELECT 
		MontoSaldoActual
	FROM ods.consultora 
	where ConsultoraID = @ConsultoraID
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'GetDeudaActualConsultora')
	DROP PROC [dbo].[GetDeudaActualConsultora]

GO
CREATE PROCEDURE GetDeudaActualConsultora
(
@ConsultoraID int
)
AS 
BEGIN
	SELECT 
		MontoSaldoActual
	FROM ods.consultora 
	where ConsultoraID = @ConsultoraID
END
GO

USE BelcorpChile
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'GetDeudaActualConsultora')
	DROP PROC [dbo].[GetDeudaActualConsultora]

GO
CREATE PROCEDURE GetDeudaActualConsultora
(
@ConsultoraID int
)
AS 
BEGIN
	SELECT 
		MontoSaldoActual
	FROM ods.consultora 
	where ConsultoraID = @ConsultoraID
END
GO

USE BelcorpBolivia
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'GetDeudaActualConsultora')
	DROP PROC [dbo].[GetDeudaActualConsultora]

GO
CREATE PROCEDURE GetDeudaActualConsultora
(
@ConsultoraID int
)
AS 
BEGIN
	SELECT 
		MontoSaldoActual
	FROM ods.consultora 
	where ConsultoraID = @ConsultoraID
END
GO

