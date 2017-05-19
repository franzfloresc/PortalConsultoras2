---------------------------------------------------------
-- INSERTAR ESTRATEGIAS PARA LA REVISTA DIGITAL SOLO PERU
---------------------------------------------------------
USE BelcorpPeru
GO

IF NOT EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '002')
BEGIN
	INSERT INTO TipoEstrategia (DescripcionEstrategia, ImagenEstrategia, Orden, FlagActivo, UsuarioRegistro, 
							FechaRegistro, flagNueva, flagRecoProduc, flagRecoPerfil, CodigoPrograma, Codigo) 
	VALUES ('Pack Nuevas', '', (SELECT MAX(Orden) + 1 FROM TipoEstrategia), 1, 'ADMCONTENIDO',
			GETDATE(), 0, 0, 1, '', '002') 
END
GO
IF NOT EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '005')
BEGIN
	INSERT INTO TipoEstrategia (DescripcionEstrategia, ImagenEstrategia, Orden, FlagActivo, UsuarioRegistro, 
							FechaRegistro, flagNueva, flagRecoProduc, flagRecoPerfil, CodigoPrograma, Codigo) 
	VALUES ('Lanzamiento', '', (SELECT MAX(Orden) + 1 FROM TipoEstrategia), 1, 'ADMCONTENIDO',
			GETDATE(), 0, 0, 1, '', '005') 
END
GO
IF NOT EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '007')
BEGIN
	INSERT INTO TipoEstrategia (DescripcionEstrategia, ImagenEstrategia, Orden, FlagActivo, UsuarioRegistro, 
							FechaRegistro, flagNueva, flagRecoProduc, flagRecoPerfil, CodigoPrograma, Codigo) 
	VALUES ('Mis Ofertas Simples', '', (SELECT MAX(Orden) + 1 FROM TipoEstrategia), 1, 'ADMCONTENIDO',
			GETDATE(), 0, 0, 1, '', '007') 
END
GO
IF NOT EXISTS (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '008')
BEGIN
	INSERT INTO TipoEstrategia (DescripcionEstrategia, ImagenEstrategia, Orden, FlagActivo, UsuarioRegistro, 
							FechaRegistro, flagNueva, flagRecoProduc, flagRecoPerfil, CodigoPrograma, Codigo) 
	VALUES ('Mis Ofertas Niveles', '', (SELECT MAX(Orden) + 1 FROM TipoEstrategia), 1, 'ADMCONTENIDO',
			GETDATE(), 0, 0, 1, '', '008') 
END