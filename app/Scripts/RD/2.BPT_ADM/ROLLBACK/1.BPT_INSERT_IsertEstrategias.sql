---------------------------------------------------------
-- ELIMINAR ESTRATEGIAS PARA LA REVISTA DIGITAL SOLO PERU
---------------------------------------------------------
USE BelcorpPeru
GO

IF EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	DELETE FROM TipoEstrategia WHERE Codigo = '002'
END
GO
IF NOT EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '005')
BEGIN
	DELETE FROM TipoEstrategia WHERE Codigo = '005'
END
GO
IF NOT EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '007')
BEGIN
	DELETE FROM TipoEstrategia WHERE Codigo = '007'
END
GO
IF NOT EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '008')
BEGIN
	DELETE FROM TipoEstrategia WHERE Codigo = '008'
END
