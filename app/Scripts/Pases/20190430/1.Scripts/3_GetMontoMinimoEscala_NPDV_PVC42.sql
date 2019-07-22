USE BelcorpPeru
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoEscala'))
Begin
	DROP PROCEDURE [dbo].[GetMontoMinimoEscala]
end
GO
CREATE PROCEDURE [dbo].[GetMontoMinimoEscala]
(@ConsultoraID BIGINT)
AS
BEGIN
    SELECT ISNULL(MontoMinimoPedido, 0) AS MontoMinimoEscala
	FROM ods.consultora WITH (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID AND MontoMaximoPedido  
		  IN ( 0.00,99999999.00,999999999.00, 9999999999.00, 99999999999.00, 999999999999.00 );
END
GO

USE BelcorpMexico
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoEscala'))
Begin
	DROP PROCEDURE [dbo].[GetMontoMinimoEscala]
end
GO
CREATE PROCEDURE [dbo].[GetMontoMinimoEscala]
(@ConsultoraID BIGINT)
AS
BEGIN
    SELECT ISNULL(MontoMinimoPedido, 0) AS MontoMinimoEscala
	FROM ods.consultora WITH (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID AND MontoMaximoPedido  
		  IN ( 0.00,99999999.00,999999999.00, 9999999999.00, 99999999999.00, 999999999999.00 );
END
GO

USE BelcorpColombia
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoEscala'))
Begin
	DROP PROCEDURE [dbo].[GetMontoMinimoEscala]
end
GO
CREATE PROCEDURE [dbo].[GetMontoMinimoEscala]
(@ConsultoraID BIGINT)
AS
BEGIN
    SELECT ISNULL(MontoMinimoPedido, 0) AS MontoMinimoEscala
	FROM ods.consultora WITH (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID AND MontoMaximoPedido  
		  IN ( 0.00,99999999.00,999999999.00, 9999999999.00, 99999999999.00, 999999999999.00 );
END
GO

USE BelcorpSalvador
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoEscala'))
Begin
	DROP PROCEDURE [dbo].[GetMontoMinimoEscala]
end
GO
CREATE PROCEDURE [dbo].[GetMontoMinimoEscala]
(@ConsultoraID BIGINT)
AS
BEGIN
    SELECT ISNULL(MontoMinimoPedido, 0) AS MontoMinimoEscala
	FROM ods.consultora WITH (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID AND MontoMaximoPedido  
		  IN ( 0.00,99999999.00,999999999.00, 9999999999.00, 99999999999.00, 999999999999.00 );
END
GO

USE BelcorpPuertoRico
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoEscala'))
Begin
	DROP PROCEDURE [dbo].[GetMontoMinimoEscala]
end
GO
CREATE PROCEDURE [dbo].[GetMontoMinimoEscala]
(@ConsultoraID BIGINT)
AS
BEGIN
    SELECT ISNULL(MontoMinimoPedido, 0) AS MontoMinimoEscala
	FROM ods.consultora WITH (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID AND MontoMaximoPedido  
		  IN ( 0.00,99999999.00,999999999.00, 9999999999.00, 99999999999.00, 999999999999.00 );
END
GO

USE BelcorpPanama
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoEscala'))
Begin
	DROP PROCEDURE [dbo].[GetMontoMinimoEscala]
end
GO
CREATE PROCEDURE [dbo].[GetMontoMinimoEscala]
(@ConsultoraID BIGINT)
AS
BEGIN
    SELECT ISNULL(MontoMinimoPedido, 0) AS MontoMinimoEscala
	FROM ods.consultora WITH (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID AND MontoMaximoPedido  
		  IN ( 0.00,99999999.00,999999999.00, 9999999999.00, 99999999999.00, 999999999999.00 );
END
GO

USE BelcorpGuatemala
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoEscala'))
Begin
	DROP PROCEDURE [dbo].[GetMontoMinimoEscala]
end
GO
CREATE PROCEDURE [dbo].[GetMontoMinimoEscala]
(@ConsultoraID BIGINT)
AS
BEGIN
    SELECT ISNULL(MontoMinimoPedido, 0) AS MontoMinimoEscala
	FROM ods.consultora WITH (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID AND MontoMaximoPedido  
		  IN ( 0.00,99999999.00,999999999.00, 9999999999.00, 99999999999.00, 999999999999.00 );
END
GO

USE BelcorpEcuador
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoEscala'))
Begin
	DROP PROCEDURE [dbo].[GetMontoMinimoEscala]
end
GO
CREATE PROCEDURE [dbo].[GetMontoMinimoEscala]
(@ConsultoraID BIGINT)
AS
BEGIN
    SELECT ISNULL(MontoMinimoPedido, 0) AS MontoMinimoEscala
	FROM ods.consultora WITH (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID AND MontoMaximoPedido  
		  IN ( 0.00,99999999.00,999999999.00, 9999999999.00, 99999999999.00, 999999999999.00 );
END
GO

USE BelcorpDominicana
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoEscala'))
Begin
	DROP PROCEDURE [dbo].[GetMontoMinimoEscala]
end
GO
CREATE PROCEDURE [dbo].[GetMontoMinimoEscala]
(@ConsultoraID BIGINT)
AS
BEGIN
    SELECT ISNULL(MontoMinimoPedido, 0) AS MontoMinimoEscala
	FROM ods.consultora WITH (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID AND MontoMaximoPedido  
		  IN ( 0.00,99999999.00,999999999.00, 9999999999.00, 99999999999.00, 999999999999.00 );
END
GO

USE BelcorpCostaRica
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoEscala'))
Begin
	DROP PROCEDURE [dbo].[GetMontoMinimoEscala]
end
GO
CREATE PROCEDURE [dbo].[GetMontoMinimoEscala]
(@ConsultoraID BIGINT)
AS
BEGIN
    SELECT ISNULL(MontoMinimoPedido, 0) AS MontoMinimoEscala
	FROM ods.consultora WITH (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID AND MontoMaximoPedido  
		  IN ( 0.00,99999999.00,999999999.00, 9999999999.00, 99999999999.00, 999999999999.00 );
END
GO

USE BelcorpChile
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoEscala'))
Begin
	DROP PROCEDURE [dbo].[GetMontoMinimoEscala]
end
GO
CREATE PROCEDURE [dbo].[GetMontoMinimoEscala]
(@ConsultoraID BIGINT)
AS
BEGIN
    SELECT ISNULL(MontoMinimoPedido, 0) AS MontoMinimoEscala
	FROM ods.consultora WITH (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID AND MontoMaximoPedido  
		  IN ( 0.00,99999999.00,999999999.00, 9999999999.00, 99999999999.00, 999999999999.00 );
END
GO

USE BelcorpBolivia
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoEscala'))
Begin
	DROP PROCEDURE [dbo].[GetMontoMinimoEscala]
end
GO
CREATE PROCEDURE [dbo].[GetMontoMinimoEscala]
(@ConsultoraID BIGINT)
AS
BEGIN
    SELECT ISNULL(MontoMinimoPedido, 0) AS MontoMinimoEscala
	FROM ods.consultora WITH (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID AND MontoMaximoPedido  
		  IN ( 0.00,99999999.00,999999999.00, 9999999999.00, 99999999999.00, 999999999999.00 );
END
GO

