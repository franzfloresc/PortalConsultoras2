GO
USE BelcorpPeru
GO
IF EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
  DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
  DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @id
  DELETE FROM configuracionpais WHERE ConfiguracionPaisID = @id
END

GO
USE BelcorpMexico
GO
IF EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
  DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
  DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @id
  DELETE FROM configuracionpais WHERE ConfiguracionPaisID = @id
END

GO
USE BelcorpColombia
GO
IF EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
  DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
  DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @id
  DELETE FROM configuracionpais WHERE ConfiguracionPaisID = @id
END

GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
  DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
  DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @id
  DELETE FROM configuracionpais WHERE ConfiguracionPaisID = @id
END

GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
  DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
  DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @id
  DELETE FROM configuracionpais WHERE ConfiguracionPaisID = @id
END

GO
USE BelcorpPanama
GO
IF EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
  DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
  DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @id
  DELETE FROM configuracionpais WHERE ConfiguracionPaisID = @id
END

GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
  DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
  DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @id
  DELETE FROM configuracionpais WHERE ConfiguracionPaisID = @id
END

GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
  DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
  DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @id
  DELETE FROM configuracionpais WHERE ConfiguracionPaisID = @id
END

GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
  DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
  DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @id
  DELETE FROM configuracionpais WHERE ConfiguracionPaisID = @id
END

GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
  DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
  DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @id
  DELETE FROM configuracionpais WHERE ConfiguracionPaisID = @id
END

GO
USE BelcorpChile
GO
IF EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
  DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
  DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @id
  DELETE FROM configuracionpais WHERE ConfiguracionPaisID = @id
END

GO
USE BelcorpBolivia
GO
IF EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
  DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
  DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @id
  DELETE FROM configuracionpais WHERE ConfiguracionPaisID = @id
END

GO
