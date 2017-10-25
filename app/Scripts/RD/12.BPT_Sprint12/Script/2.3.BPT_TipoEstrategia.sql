USE [BelcorpPeru_BPT]
GO

INSERT INTO [dbo].[TipoEstrategia]
           ([DescripcionEstrategia]
           ,[ImagenEstrategia]
           ,[Orden]
           ,[FlagActivo]
           ,[UsuarioRegistro]
           ,[FechaRegistro]
           ,[UsuarioModificacion]
           ,[FechaModificacion]
           ,[flagNueva]
           ,[flagRecoProduc]
           ,[flagRecoPerfil]
           ,[CodigoPrograma]
           ,[FlagMostrarImg]
           ,[Codigo]
           ,[MostrarImgOfertaIndependiente]
           ,[ImagenOfertaIndependiente])
     VALUES
           ('Guía de negocio'
           , ''
           , 13
           , 1
           , 'ADMCONTENIDO'
           , getdate()
           , 'ADMCONTENIDO'
           , getdate()
           , 0
           , 0
           , 1
           , ''
           , 0
           , '010'
           , 0
           , '')
GO

