GO
USE BelcorpPeru
GO
IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioActiva'
		)
BEGIN
	UPDATE configuracionpaisdatos
	SET valor1 = 'gana_mas_tag_seleccionado.svg'
		,valor2 = 'gana_mas_tag_seleccionado.svg'
	WHERE codigo = 'LogoMenuInicioActiva';
END

IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioNoActiva'
		)
BEGIN
update configuracionpaisdatos set valor1='gana_mas_tag_no_seleccionado.svg', valor2='gana_mas_tag_no_seleccionado.svg' where codigo='LogoMenuInicioNoActiva';
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoSuscrita'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RD'),
				   'LogoMenuInicioNoSuscrita'
				   ,0
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,null
				   ,'Logo del menu inicio para desktop y mobile no suscrita'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoActivaNoSuscrita'
		)
BEGIN


			INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RD'),
					   'LogoMenuInicioNoActivaNoSuscrita'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo Menu Inicio No Activa No Suscrita'
					   ,1
					   ,null)
END
GO

IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaActiva'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RDI'),
				   'LogoMenuRevistaDigitaIntrigaActiva'
				   ,0
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,null
				   ,'Logo de Menu RevistaDigitaIntriga Activa'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaNoActivo'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RDI'),
					   'LogoMenuRevistaDigitaIntrigaNoActivo'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo de Menu RevistaDigita Intriga No Activo'
					   ,1
					   ,null)
END



GO

GO
USE BelcorpMexico
GO
IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioActiva'
		)
BEGIN
	UPDATE configuracionpaisdatos
	SET valor1 = 'gana_mas_tag_seleccionado.svg'
		,valor2 = 'gana_mas_tag_seleccionado.svg'
	WHERE codigo = 'LogoMenuInicioActiva';
END

IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioNoActiva'
		)
BEGIN
update configuracionpaisdatos set valor1='gana_mas_tag_no_seleccionado.svg', valor2='gana_mas_tag_no_seleccionado.svg' where codigo='LogoMenuInicioNoActiva';
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoSuscrita'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RD'),
				   'LogoMenuInicioNoSuscrita'
				   ,0
				   ,'ofertas_digitales_lbel_tag_seleccionado.svg'
				   ,'ofertas_digitales_lbel_tag_seleccionado.svg'
				   ,null
				   ,'Logo del menu inicio para desktop y mobile no suscrita'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoActivaNoSuscrita'
		)
BEGIN


			INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RD'),
					   'LogoMenuInicioNoActivaNoSuscrita'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo Menu Inicio No Activa No Suscrita'
					   ,1
					   ,null)
END
GO

IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaActiva'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RDI'),
				   'LogoMenuRevistaDigitaIntrigaActiva'
				   ,0
				   ,'ofertas_digitales_lbel_tag_seleccionado.svg'
				   ,'ofertas_digitales_lbel_tag_seleccionado.svg'
				   ,null
				   ,'Logo de Menu RevistaDigitaIntriga Activa'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaNoActivo'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RDI'),
					   'LogoMenuRevistaDigitaIntrigaNoActivo'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo de Menu RevistaDigita Intriga No Activo'
					   ,1
					   ,null)
END



GO

GO
USE BelcorpColombia
GO
IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioActiva'
		)
BEGIN
	UPDATE configuracionpaisdatos
	SET valor1 = 'gana_mas_tag_seleccionado.svg'
		,valor2 = 'gana_mas_tag_seleccionado.svg'
	WHERE codigo = 'LogoMenuInicioActiva';
END

IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioNoActiva'
		)
BEGIN
update configuracionpaisdatos set valor1='gana_mas_tag_no_seleccionado.svg', valor2='gana_mas_tag_no_seleccionado.svg' where codigo='LogoMenuInicioNoActiva';
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoSuscrita'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RD'),
				   'LogoMenuInicioNoSuscrita'
				   ,0
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,null
				   ,'Logo del menu inicio para desktop y mobile no suscrita'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoActivaNoSuscrita'
		)
BEGIN


			INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RD'),
					   'LogoMenuInicioNoActivaNoSuscrita'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo Menu Inicio No Activa No Suscrita'
					   ,1
					   ,null)
END
GO

IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaActiva'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RDI'),
				   'LogoMenuRevistaDigitaIntrigaActiva'
				   ,0
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,null
				   ,'Logo de Menu RevistaDigitaIntriga Activa'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaNoActivo'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RDI'),
					   'LogoMenuRevistaDigitaIntrigaNoActivo'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo de Menu RevistaDigita Intriga No Activo'
					   ,1
					   ,null)
END



GO

GO
USE BelcorpSalvador
GO
IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioActiva'
		)
BEGIN
	UPDATE configuracionpaisdatos
	SET valor1 = 'gana_mas_tag_seleccionado.svg'
		,valor2 = 'gana_mas_tag_seleccionado.svg'
	WHERE codigo = 'LogoMenuInicioActiva';
END

IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioNoActiva'
		)
BEGIN
update configuracionpaisdatos set valor1='gana_mas_tag_no_seleccionado.svg', valor2='gana_mas_tag_no_seleccionado.svg' where codigo='LogoMenuInicioNoActiva';
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoSuscrita'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RD'),
				   'LogoMenuInicioNoSuscrita'
				   ,0
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,null
				   ,'Logo del menu inicio para desktop y mobile no suscrita'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoActivaNoSuscrita'
		)
BEGIN


			INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RD'),
					   'LogoMenuInicioNoActivaNoSuscrita'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo Menu Inicio No Activa No Suscrita'
					   ,1
					   ,null)
END
GO

IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaActiva'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RDI'),
				   'LogoMenuRevistaDigitaIntrigaActiva'
				   ,0
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,null
				   ,'Logo de Menu RevistaDigitaIntriga Activa'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaNoActivo'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RDI'),
					   'LogoMenuRevistaDigitaIntrigaNoActivo'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo de Menu RevistaDigita Intriga No Activo'
					   ,1
					   ,null)
END



GO

GO
USE BelcorpPuertoRico
GO
IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioActiva'
		)
BEGIN
	UPDATE configuracionpaisdatos
	SET valor1 = 'gana_mas_tag_seleccionado.svg'
		,valor2 = 'gana_mas_tag_seleccionado.svg'
	WHERE codigo = 'LogoMenuInicioActiva';
END

IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioNoActiva'
		)
BEGIN
update configuracionpaisdatos set valor1='gana_mas_tag_no_seleccionado.svg', valor2='gana_mas_tag_no_seleccionado.svg' where codigo='LogoMenuInicioNoActiva';
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoSuscrita'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RD'),
				   'LogoMenuInicioNoSuscrita'
				   ,0
				   ,'ofertas_digitales_lbel_tag_seleccionado.svg'
				   ,'ofertas_digitales_lbel_tag_seleccionado.svg'
				   ,null
				   ,'Logo del menu inicio para desktop y mobile no suscrita'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoActivaNoSuscrita'
		)
BEGIN


			INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RD'),
					   'LogoMenuInicioNoActivaNoSuscrita'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo Menu Inicio No Activa No Suscrita'
					   ,1
					   ,null)
END
GO

IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaActiva'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RDI'),
				   'LogoMenuRevistaDigitaIntrigaActiva'
				   ,0
				   ,'ofertas_digitales_lbel_tag_seleccionado.svg'
				   ,'ofertas_digitales_lbel_tag_seleccionado.svg'
				   ,null
				   ,'Logo de Menu RevistaDigitaIntriga Activa'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaNoActivo'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RDI'),
					   'LogoMenuRevistaDigitaIntrigaNoActivo'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo de Menu RevistaDigita Intriga No Activo'
					   ,1
					   ,null)
END



GO

GO
USE BelcorpPanama
GO
IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioActiva'
		)
BEGIN
	UPDATE configuracionpaisdatos
	SET valor1 = 'gana_mas_tag_seleccionado.svg'
		,valor2 = 'gana_mas_tag_seleccionado.svg'
	WHERE codigo = 'LogoMenuInicioActiva';
END

IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioNoActiva'
		)
BEGIN
update configuracionpaisdatos set valor1='gana_mas_tag_no_seleccionado.svg', valor2='gana_mas_tag_no_seleccionado.svg' where codigo='LogoMenuInicioNoActiva';
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoSuscrita'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RD'),
				   'LogoMenuInicioNoSuscrita'
				   ,0
				   ,'ofertas_digitales_lbel_tag_seleccionado.svg'
				   ,'ofertas_digitales_lbel_tag_seleccionado.svg'
				   ,null
				   ,'Logo del menu inicio para desktop y mobile no suscrita'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoActivaNoSuscrita'
		)
BEGIN


			INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RD'),
					   'LogoMenuInicioNoActivaNoSuscrita'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo Menu Inicio No Activa No Suscrita'
					   ,1
					   ,null)
END
GO

IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaActiva'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RDI'),
				   'LogoMenuRevistaDigitaIntrigaActiva'
				   ,0
				   ,'ofertas_digitales_lbel_tag_seleccionado.svg'
				   ,'ofertas_digitales_lbel_tag_seleccionado.svg'
				   ,null
				   ,'Logo de Menu RevistaDigitaIntriga Activa'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaNoActivo'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RDI'),
					   'LogoMenuRevistaDigitaIntrigaNoActivo'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo de Menu RevistaDigita Intriga No Activo'
					   ,1
					   ,null)
END



GO

GO
USE BelcorpGuatemala
GO
IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioActiva'
		)
BEGIN
	UPDATE configuracionpaisdatos
	SET valor1 = 'gana_mas_tag_seleccionado.svg'
		,valor2 = 'gana_mas_tag_seleccionado.svg'
	WHERE codigo = 'LogoMenuInicioActiva';
END

IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioNoActiva'
		)
BEGIN
update configuracionpaisdatos set valor1='gana_mas_tag_no_seleccionado.svg', valor2='gana_mas_tag_no_seleccionado.svg' where codigo='LogoMenuInicioNoActiva';
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoSuscrita'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RD'),
				   'LogoMenuInicioNoSuscrita'
				   ,0
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,null
				   ,'Logo del menu inicio para desktop y mobile no suscrita'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoActivaNoSuscrita'
		)
BEGIN


			INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RD'),
					   'LogoMenuInicioNoActivaNoSuscrita'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo Menu Inicio No Activa No Suscrita'
					   ,1
					   ,null)
END
GO

IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaActiva'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RDI'),
				   'LogoMenuRevistaDigitaIntrigaActiva'
				   ,0
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,null
				   ,'Logo de Menu RevistaDigitaIntriga Activa'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaNoActivo'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RDI'),
					   'LogoMenuRevistaDigitaIntrigaNoActivo'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo de Menu RevistaDigita Intriga No Activo'
					   ,1
					   ,null)
END



GO

GO
USE BelcorpEcuador
GO
IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioActiva'
		)
BEGIN
	UPDATE configuracionpaisdatos
	SET valor1 = 'gana_mas_tag_seleccionado.svg'
		,valor2 = 'gana_mas_tag_seleccionado.svg'
	WHERE codigo = 'LogoMenuInicioActiva';
END

IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioNoActiva'
		)
BEGIN
update configuracionpaisdatos set valor1='gana_mas_tag_no_seleccionado.svg', valor2='gana_mas_tag_no_seleccionado.svg' where codigo='LogoMenuInicioNoActiva';
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoSuscrita'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RD'),
				   'LogoMenuInicioNoSuscrita'
				   ,0
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,null
				   ,'Logo del menu inicio para desktop y mobile no suscrita'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoActivaNoSuscrita'
		)
BEGIN


			INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RD'),
					   'LogoMenuInicioNoActivaNoSuscrita'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo Menu Inicio No Activa No Suscrita'
					   ,1
					   ,null)
END
GO

IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaActiva'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RDI'),
				   'LogoMenuRevistaDigitaIntrigaActiva'
				   ,0
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,null
				   ,'Logo de Menu RevistaDigitaIntriga Activa'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaNoActivo'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RDI'),
					   'LogoMenuRevistaDigitaIntrigaNoActivo'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo de Menu RevistaDigita Intriga No Activo'
					   ,1
					   ,null)
END



GO

GO
USE BelcorpDominicana
GO
IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioActiva'
		)
BEGIN
	UPDATE configuracionpaisdatos
	SET valor1 = 'gana_mas_tag_seleccionado.svg'
		,valor2 = 'gana_mas_tag_seleccionado.svg'
	WHERE codigo = 'LogoMenuInicioActiva';
END

IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioNoActiva'
		)
BEGIN
update configuracionpaisdatos set valor1='gana_mas_tag_no_seleccionado.svg', valor2='gana_mas_tag_no_seleccionado.svg' where codigo='LogoMenuInicioNoActiva';
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoSuscrita'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RD'),
				   'LogoMenuInicioNoSuscrita'
				   ,0
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,null
				   ,'Logo del menu inicio para desktop y mobile no suscrita'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoActivaNoSuscrita'
		)
BEGIN


			INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RD'),
					   'LogoMenuInicioNoActivaNoSuscrita'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo Menu Inicio No Activa No Suscrita'
					   ,1
					   ,null)
END
GO

IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaActiva'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RDI'),
				   'LogoMenuRevistaDigitaIntrigaActiva'
				   ,0
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,null
				   ,'Logo de Menu RevistaDigitaIntriga Activa'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaNoActivo'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RDI'),
					   'LogoMenuRevistaDigitaIntrigaNoActivo'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo de Menu RevistaDigita Intriga No Activo'
					   ,1
					   ,null)
END



GO

GO
USE BelcorpCostaRica
GO
IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioActiva'
		)
BEGIN
	UPDATE configuracionpaisdatos
	SET valor1 = 'gana_mas_tag_seleccionado.svg'
		,valor2 = 'gana_mas_tag_seleccionado.svg'
	WHERE codigo = 'LogoMenuInicioActiva';
END

IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioNoActiva'
		)
BEGIN
update configuracionpaisdatos set valor1='gana_mas_tag_no_seleccionado.svg', valor2='gana_mas_tag_no_seleccionado.svg' where codigo='LogoMenuInicioNoActiva';
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoSuscrita'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RD'),
				   'LogoMenuInicioNoSuscrita'
				   ,0
				   ,'ofertas_digitales_lbel_tag_seleccionado.svg'
				   ,'ofertas_digitales_lbel_tag_seleccionado.svg'
				   ,null
				   ,'Logo del menu inicio para desktop y mobile no suscrita'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoActivaNoSuscrita'
		)
BEGIN


			INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RD'),
					   'LogoMenuInicioNoActivaNoSuscrita'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo Menu Inicio No Activa No Suscrita'
					   ,1
					   ,null)
END
GO

IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaActiva'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RDI'),
				   'LogoMenuRevistaDigitaIntrigaActiva'
				   ,0
				   ,'ofertas_digitales_lbel_tag_seleccionado.svg'
				   ,'ofertas_digitales_lbel_tag_seleccionado.svg'
				   ,null
				   ,'Logo de Menu RevistaDigitaIntriga Activa'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaNoActivo'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RDI'),
					   'LogoMenuRevistaDigitaIntrigaNoActivo'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo de Menu RevistaDigita Intriga No Activo'
					   ,1
					   ,null)
END



GO

GO
USE BelcorpChile
GO
IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioActiva'
		)
BEGIN
	UPDATE configuracionpaisdatos
	SET valor1 = 'gana_mas_tag_seleccionado.svg'
		,valor2 = 'gana_mas_tag_seleccionado.svg'
	WHERE codigo = 'LogoMenuInicioActiva';
END

IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioNoActiva'
		)
BEGIN
update configuracionpaisdatos set valor1='gana_mas_tag_no_seleccionado.svg', valor2='gana_mas_tag_no_seleccionado.svg' where codigo='LogoMenuInicioNoActiva';
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoSuscrita'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RD'),
				   'LogoMenuInicioNoSuscrita'
				   ,0
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,null
				   ,'Logo del menu inicio para desktop y mobile no suscrita'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoActivaNoSuscrita'
		)
BEGIN


			INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RD'),
					   'LogoMenuInicioNoActivaNoSuscrita'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo Menu Inicio No Activa No Suscrita'
					   ,1
					   ,null)
END
GO

IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaActiva'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RDI'),
				   'LogoMenuRevistaDigitaIntrigaActiva'
				   ,0
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,null
				   ,'Logo de Menu RevistaDigitaIntriga Activa'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaNoActivo'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RDI'),
					   'LogoMenuRevistaDigitaIntrigaNoActivo'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo de Menu RevistaDigita Intriga No Activo'
					   ,1
					   ,null)
END



GO

GO
USE BelcorpBolivia
GO
IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioActiva'
		)
BEGIN
	UPDATE configuracionpaisdatos
	SET valor1 = 'gana_mas_tag_seleccionado.svg'
		,valor2 = 'gana_mas_tag_seleccionado.svg'
	WHERE codigo = 'LogoMenuInicioActiva';
END

IF  EXISTS (
		SELECT 1
		FROM configuracionpaisdatos
		WHERE codigo = 'LogoMenuInicioNoActiva'
		)
BEGIN
update configuracionpaisdatos set valor1='gana_mas_tag_no_seleccionado.svg', valor2='gana_mas_tag_no_seleccionado.svg' where codigo='LogoMenuInicioNoActiva';
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoSuscrita'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RD'),
				   'LogoMenuInicioNoSuscrita'
				   ,0
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,null
				   ,'Logo del menu inicio para desktop y mobile no suscrita'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoActivaNoSuscrita'
		)
BEGIN


			INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RD'),
					   'LogoMenuInicioNoActivaNoSuscrita'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo Menu Inicio No Activa No Suscrita'
					   ,1
					   ,null)
END
GO

IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaActiva'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
				   (
				   configuracionpaisid,
				   [Codigo]
				   ,[CampaniaID]
				   ,[Valor1]
				   ,[Valor2]
				   ,[Valor3]
				   ,[Descripcion]
				   ,[Estado]
				   ,[Componente])
			 VALUES
				   (
				  ( select configuracionpaisid from configuracionpais where codigo='RDI'),
				   'LogoMenuRevistaDigitaIntrigaActiva'
				   ,0
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,'ofertas_digitales_esika_tag_seleccionado.svg'
				   ,null
				   ,'Logo de Menu RevistaDigitaIntriga Activa'
				   ,1
				   ,null)
END
GO
IF NOT EXISTS (
	 select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaNoActivo'
		)
BEGIN
 INSERT INTO [dbo].[ConfiguracionPaisDatos]
					   (
					   configuracionpaisid,
					   [Codigo]
					   ,[CampaniaID]
					   ,[Valor1]
					   ,[Valor2]
					   ,[Valor3]
					   ,[Descripcion]
					   ,[Estado]
					   ,[Componente])
				 VALUES
					   (
						 ( select configuracionpaisid from configuracionpais where codigo='RDI'),
					   'LogoMenuRevistaDigitaIntrigaNoActivo'
					   ,0
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,'ofertas_digitales_tag_no_seleccionado.svg'
					   ,null
					   ,'Logo de Menu RevistaDigita Intriga No Activo'
					   ,1
					   ,null)
END



GO

GO

