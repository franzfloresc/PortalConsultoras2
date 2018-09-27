use belcorpchile_bpt
go


update configuracionpaisdatos set valor1='gana_mas_seleccionado.svg', valor2='gana_mas_seleccionado.svg' where codigo='LogoMenuInicioActiva';
go
update configuracionpaisdatos set valor1='gana_mas_no_seleccionado.svg', valor2='gana_mas_no_seleccionado.svg' where codigo='LogoMenuInicioNoActiva';
go


if(not(exists(select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoSuscrita' )))
begin

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
				   ,'ofertas_digitales_seleccionado.svg'
				   ,'ofertas_digitales_seleccionado.svg'
				   ,null
				   ,'Logo del menu inicio para desktop y mobile para la consultora Activa'
				   ,1
				   ,null)


end

GO

if(not(exists(select 1 from configuracionpaisdatos where codigo='LogoMenuInicioNoActivaNoSuscrita' )))
begin



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
					   ,'ofertas_digitales_no_seleccionado.svg'
					   ,'ofertas_digitales_no_seleccionado.svg'
					   ,null
					   ,'Logo del menu inicio para desktop y mobile para la consultora Activa'
					   ,1
					   ,null)

end
GO




if(not(exists(select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaActiva' )))
begin

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
				   ,'ofertas_digitales_seleccionado.svg'
				   ,'ofertas_digitales_seleccionado.svg'
				   ,null
				   ,'Logo del menu inicio para desktop y mobile para la consultora Activa'
				   ,1
				   ,null)


end

GO


if(not(exists(select 1 from configuracionpaisdatos where codigo='LogoMenuRevistaDigitaIntrigaNoActivo' )))
begin



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
					   ,'ofertas_digitales_no_seleccionado.svg'
					   ,'ofertas_digitales_no_seleccionado.svg'
					   ,null
					   ,'Logo del menu inicio para desktop y mobile para la consultora '
					   ,1
					   ,null)

end
GO



