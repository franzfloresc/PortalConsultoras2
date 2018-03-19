USE BelcorpPeru
GO
IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where codigo = 'InformativoVideo')
update ConfiguracionPaisDatos set Valor1 = 'hgzyfCc3X-U', Valor2 = 'hgzyfCc3X-U' where codigo = 'InformativoVideo'

USE BelcorpChile
GO
IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where codigo = 'InformativoVideo')
update ConfiguracionPaisDatos set Valor1 = '6e2qMb_j8lI', Valor2 = '6e2qMb_j8lI' where codigo = 'InformativoVideo'

USE BelcorpCostaRica
GO
IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where codigo = 'InformativoVideo')
update ConfiguracionPaisDatos set Valor1 = 'JAMnm-vG9Fs', Valor2 = 'JAMnm-vG9Fs' where codigo = 'InformativoVideo'