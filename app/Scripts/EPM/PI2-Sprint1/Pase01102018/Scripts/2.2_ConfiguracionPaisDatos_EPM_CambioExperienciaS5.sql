GO
USE BelcorpPeru
GO

GO
/* *************************************** */
GO

--UPDATE [dbo].[ConfiguracionPaisDatos]
--SET
--	valor1 = 'gifofertasdigitales.gif'
--FROM [dbo].[ConfiguracionPaisDatos] D
--	JOIN [dbo].[ConfiguracionPais] P
--	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
--	and P.Codigo = 'RDI'
--where D.Codigo = 'LogoMenuOfertas';
GO
/* *************************************** */
GO
/* HOME  INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DBienvenidaIntriga', 'MBienvenidaIntriga');
/* HOME FIN */
GO
/* *************************************** */
GO
/* PASE PEDIDO INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DPedidoIntriga', 'MPedidoIntriga');
/* PASE PEDIDO FIN */
GO
/* *************************************** */
GO
/* CATALOGOS Y REVISTAS INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DCatalogoIntriga', 'MCatalogoIntriga');
/* CATALOGOS Y REVISTAS FIN */
GO
/* *************************************** */
GO
/* BANNER CONTENEDOR INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, BIENVENIDA A TU ESPACIO EXCLUSIVO'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo = 'DLandingBannerIntriga';
/* BANNER CONTENEDOR FIN */

/* *************************************** */
go


GO
USE BelcorpMexico
GO

GO
/* *************************************** */
GO

--UPDATE [dbo].[ConfiguracionPaisDatos]
--SET
--	valor1 = 'gifofertasdigitales.gif'
--FROM [dbo].[ConfiguracionPaisDatos] D
--	JOIN [dbo].[ConfiguracionPais] P
--	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
--	and P.Codigo = 'RDI'
--where D.Codigo = 'LogoMenuOfertas';
GO
/* *************************************** */
GO
/* HOME  INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DBienvenidaIntriga', 'MBienvenidaIntriga');
/* HOME FIN */
GO
/* *************************************** */
GO
/* PASE PEDIDO INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DPedidoIntriga', 'MPedidoIntriga');
/* PASE PEDIDO FIN */
GO
/* *************************************** */
GO
/* CATALOGOS Y REVISTAS INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DCatalogoIntriga', 'MCatalogoIntriga');
/* CATALOGOS Y REVISTAS FIN */
GO
/* *************************************** */
GO
/* BANNER CONTENEDOR INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, BIENVENIDA A TU ESPACIO EXCLUSIVO'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo = 'DLandingBannerIntriga';
/* BANNER CONTENEDOR FIN */

/* *************************************** */
go


GO
USE BelcorpColombia
GO

GO
/* *************************************** */
GO

--UPDATE [dbo].[ConfiguracionPaisDatos]
--SET
--	valor1 = 'gifofertasdigitales.gif'
--FROM [dbo].[ConfiguracionPaisDatos] D
--	JOIN [dbo].[ConfiguracionPais] P
--	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
--	and P.Codigo = 'RDI'
--where D.Codigo = 'LogoMenuOfertas';
GO
/* *************************************** */
GO
/* HOME  INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DBienvenidaIntriga', 'MBienvenidaIntriga');
/* HOME FIN */
GO
/* *************************************** */
GO
/* PASE PEDIDO INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DPedidoIntriga', 'MPedidoIntriga');
/* PASE PEDIDO FIN */
GO
/* *************************************** */
GO
/* CATALOGOS Y REVISTAS INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DCatalogoIntriga', 'MCatalogoIntriga');
/* CATALOGOS Y REVISTAS FIN */
GO
/* *************************************** */
GO
/* BANNER CONTENEDOR INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, BIENVENIDA A TU ESPACIO EXCLUSIVO'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo = 'DLandingBannerIntriga';
/* BANNER CONTENEDOR FIN */

/* *************************************** */
go


GO
USE BelcorpSalvador
GO

GO
/* *************************************** */
GO

--UPDATE [dbo].[ConfiguracionPaisDatos]
--SET
--	valor1 = 'gifofertasdigitales.gif'
--FROM [dbo].[ConfiguracionPaisDatos] D
--	JOIN [dbo].[ConfiguracionPais] P
--	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
--	and P.Codigo = 'RDI'
--where D.Codigo = 'LogoMenuOfertas';
GO
/* *************************************** */
GO
/* HOME  INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DBienvenidaIntriga', 'MBienvenidaIntriga');
/* HOME FIN */
GO
/* *************************************** */
GO
/* PASE PEDIDO INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DPedidoIntriga', 'MPedidoIntriga');
/* PASE PEDIDO FIN */
GO
/* *************************************** */
GO
/* CATALOGOS Y REVISTAS INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DCatalogoIntriga', 'MCatalogoIntriga');
/* CATALOGOS Y REVISTAS FIN */
GO
/* *************************************** */
GO
/* BANNER CONTENEDOR INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, BIENVENIDA A TU ESPACIO EXCLUSIVO'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo = 'DLandingBannerIntriga';
/* BANNER CONTENEDOR FIN */

/* *************************************** */
go


GO
USE BelcorpPuertoRico
GO

GO
/* *************************************** */
GO

--UPDATE [dbo].[ConfiguracionPaisDatos]
--SET
--	valor1 = 'gifofertasdigitales.gif'
--FROM [dbo].[ConfiguracionPaisDatos] D
--	JOIN [dbo].[ConfiguracionPais] P
--	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
--	and P.Codigo = 'RDI'
--where D.Codigo = 'LogoMenuOfertas';
GO
/* *************************************** */
GO
/* HOME  INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DBienvenidaIntriga', 'MBienvenidaIntriga');
/* HOME FIN */
GO
/* *************************************** */
GO
/* PASE PEDIDO INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DPedidoIntriga', 'MPedidoIntriga');
/* PASE PEDIDO FIN */
GO
/* *************************************** */
GO
/* CATALOGOS Y REVISTAS INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DCatalogoIntriga', 'MCatalogoIntriga');
/* CATALOGOS Y REVISTAS FIN */
GO
/* *************************************** */
GO
/* BANNER CONTENEDOR INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, BIENVENIDA A TU ESPACIO EXCLUSIVO'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo = 'DLandingBannerIntriga';
/* BANNER CONTENEDOR FIN */

/* *************************************** */
go


GO
USE BelcorpPanama
GO

GO
/* *************************************** */
GO

--UPDATE [dbo].[ConfiguracionPaisDatos]
--SET
--	valor1 = 'gifofertasdigitales.gif'
--FROM [dbo].[ConfiguracionPaisDatos] D
--	JOIN [dbo].[ConfiguracionPais] P
--	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
--	and P.Codigo = 'RDI'
--where D.Codigo = 'LogoMenuOfertas';
GO
/* *************************************** */
GO
/* HOME  INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DBienvenidaIntriga', 'MBienvenidaIntriga');
/* HOME FIN */
GO
/* *************************************** */
GO
/* PASE PEDIDO INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DPedidoIntriga', 'MPedidoIntriga');
/* PASE PEDIDO FIN */
GO
/* *************************************** */
GO
/* CATALOGOS Y REVISTAS INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DCatalogoIntriga', 'MCatalogoIntriga');
/* CATALOGOS Y REVISTAS FIN */
GO
/* *************************************** */
GO
/* BANNER CONTENEDOR INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, BIENVENIDA A TU ESPACIO EXCLUSIVO'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo = 'DLandingBannerIntriga';
/* BANNER CONTENEDOR FIN */

/* *************************************** */
go


GO
USE BelcorpGuatemala
GO

GO
/* *************************************** */
GO

--UPDATE [dbo].[ConfiguracionPaisDatos]
--SET
--	valor1 = 'gifofertasdigitales.gif'
--FROM [dbo].[ConfiguracionPaisDatos] D
--	JOIN [dbo].[ConfiguracionPais] P
--	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
--	and P.Codigo = 'RDI'
--where D.Codigo = 'LogoMenuOfertas';
GO
/* *************************************** */
GO
/* HOME  INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DBienvenidaIntriga', 'MBienvenidaIntriga');
/* HOME FIN */
GO
/* *************************************** */
GO
/* PASE PEDIDO INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DPedidoIntriga', 'MPedidoIntriga');
/* PASE PEDIDO FIN */
GO
/* *************************************** */
GO
/* CATALOGOS Y REVISTAS INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DCatalogoIntriga', 'MCatalogoIntriga');
/* CATALOGOS Y REVISTAS FIN */
GO
/* *************************************** */
GO
/* BANNER CONTENEDOR INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, BIENVENIDA A TU ESPACIO EXCLUSIVO'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo = 'DLandingBannerIntriga';
/* BANNER CONTENEDOR FIN */

/* *************************************** */
go


GO
USE BelcorpEcuador
GO

GO
/* *************************************** */
GO

--UPDATE [dbo].[ConfiguracionPaisDatos]
--SET
--	valor1 = 'gifofertasdigitales.gif'
--FROM [dbo].[ConfiguracionPaisDatos] D
--	JOIN [dbo].[ConfiguracionPais] P
--	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
--	and P.Codigo = 'RDI'
--where D.Codigo = 'LogoMenuOfertas';
GO
/* *************************************** */
GO
/* HOME  INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DBienvenidaIntriga', 'MBienvenidaIntriga');
/* HOME FIN */
GO
/* *************************************** */
GO
/* PASE PEDIDO INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DPedidoIntriga', 'MPedidoIntriga');
/* PASE PEDIDO FIN */
GO
/* *************************************** */
GO
/* CATALOGOS Y REVISTAS INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DCatalogoIntriga', 'MCatalogoIntriga');
/* CATALOGOS Y REVISTAS FIN */
GO
/* *************************************** */
GO
/* BANNER CONTENEDOR INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, BIENVENIDA A TU ESPACIO EXCLUSIVO'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo = 'DLandingBannerIntriga';
/* BANNER CONTENEDOR FIN */

/* *************************************** */
go


GO
USE BelcorpDominicana
GO

GO
/* *************************************** */
GO

--UPDATE [dbo].[ConfiguracionPaisDatos]
--SET
--	valor1 = 'gifofertasdigitales.gif'
--FROM [dbo].[ConfiguracionPaisDatos] D
--	JOIN [dbo].[ConfiguracionPais] P
--	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
--	and P.Codigo = 'RDI'
--where D.Codigo = 'LogoMenuOfertas';
GO
/* *************************************** */
GO
/* HOME  INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DBienvenidaIntriga', 'MBienvenidaIntriga');
/* HOME FIN */
GO
/* *************************************** */
GO
/* PASE PEDIDO INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DPedidoIntriga', 'MPedidoIntriga');
/* PASE PEDIDO FIN */
GO
/* *************************************** */
GO
/* CATALOGOS Y REVISTAS INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DCatalogoIntriga', 'MCatalogoIntriga');
/* CATALOGOS Y REVISTAS FIN */
GO
/* *************************************** */
GO
/* BANNER CONTENEDOR INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, BIENVENIDA A TU ESPACIO EXCLUSIVO'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo = 'DLandingBannerIntriga';
/* BANNER CONTENEDOR FIN */

/* *************************************** */
go


GO
USE BelcorpCostaRica
GO

GO
/* *************************************** */
GO

--UPDATE [dbo].[ConfiguracionPaisDatos]
--SET
--	valor1 = 'gifofertasdigitales.gif'
--FROM [dbo].[ConfiguracionPaisDatos] D
--	JOIN [dbo].[ConfiguracionPais] P
--	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
--	and P.Codigo = 'RDI'
--where D.Codigo = 'LogoMenuOfertas';
GO
/* *************************************** */
GO
/* HOME  INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DBienvenidaIntriga', 'MBienvenidaIntriga');
/* HOME FIN */
GO
/* *************************************** */
GO
/* PASE PEDIDO INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DPedidoIntriga', 'MPedidoIntriga');
/* PASE PEDIDO FIN */
GO
/* *************************************** */
GO
/* CATALOGOS Y REVISTAS INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DCatalogoIntriga', 'MCatalogoIntriga');
/* CATALOGOS Y REVISTAS FIN */
GO
/* *************************************** */
GO
/* BANNER CONTENEDOR INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, BIENVENIDA A TU ESPACIO EXCLUSIVO'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo = 'DLandingBannerIntriga';
/* BANNER CONTENEDOR FIN */

/* *************************************** */
go


GO
USE BelcorpChile
GO

GO
/* *************************************** */
GO

--UPDATE [dbo].[ConfiguracionPaisDatos]
--SET
--	valor1 = 'gifofertasdigitales.gif'
--FROM [dbo].[ConfiguracionPaisDatos] D
--	JOIN [dbo].[ConfiguracionPais] P
--	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
--	and P.Codigo = 'RDI'
--where D.Codigo = 'LogoMenuOfertas';
GO
/* *************************************** */
GO
/* HOME  INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DBienvenidaIntriga', 'MBienvenidaIntriga');
/* HOME FIN */
GO
/* *************************************** */
GO
/* PASE PEDIDO INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DPedidoIntriga', 'MPedidoIntriga');
/* PASE PEDIDO FIN */
GO
/* *************************************** */
GO
/* CATALOGOS Y REVISTAS INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DCatalogoIntriga', 'MCatalogoIntriga');
/* CATALOGOS Y REVISTAS FIN */
GO
/* *************************************** */
GO
/* BANNER CONTENEDOR INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, BIENVENIDA A TU ESPACIO EXCLUSIVO'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo = 'DLandingBannerIntriga';
/* BANNER CONTENEDOR FIN */

/* *************************************** */
go


GO
USE BelcorpBolivia
GO

GO
/* *************************************** */
GO

--UPDATE [dbo].[ConfiguracionPaisDatos]
--SET
--	valor1 = 'gifofertasdigitales.gif'
--FROM [dbo].[ConfiguracionPaisDatos] D
--	JOIN [dbo].[ConfiguracionPais] P
--	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
--	and P.Codigo = 'RDI'
--where D.Codigo = 'LogoMenuOfertas';
GO
/* *************************************** */
GO
/* HOME  INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DBienvenidaIntriga', 'MBienvenidaIntriga');
/* HOME FIN */
GO
/* *************************************** */
GO
/* PASE PEDIDO INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DPedidoIntriga', 'MPedidoIntriga');
/* PASE PEDIDO FIN */
GO
/* *************************************** */
GO
/* CATALOGOS Y REVISTAS INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, encuentra aquí las promociones de campaña'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo in ('DCatalogoIntriga', 'MCatalogoIntriga');
/* CATALOGOS Y REVISTAS FIN */
GO
/* *************************************** */
GO
/* BANNER CONTENEDOR INICIO */
UPDATE
	[dbo].[ConfiguracionPaisDatos]
SET
	Valor1 = '#NOMBRE, BIENVENIDA A TU ESPACIO EXCLUSIVO'
FROM [dbo].[ConfiguracionPaisDatos] D
	JOIN [dbo].[ConfiguracionPais] P
	ON D.ConfiguracionPaisID = P.ConfiguracionPaisID
	and P.Codigo = 'RDI'
WHERE D.Codigo = 'DLandingBannerIntriga';
/* BANNER CONTENEDOR FIN */

/* *************************************** */
go


GO
