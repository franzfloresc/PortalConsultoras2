 use belcorpmexico_pl50
 go
if(not exists(select * from configuracionpais where Codigo='SETAGR'))
begin


INSERT INTO [dbo].[ConfiguracionPais]
           ([Codigo]
           ,[Excluyente]
           ,[Descripcion]
           ,[Estado]
           ,[TienePerfil]
           ,[DesdeCampania]
           ,[MobileTituloMenu]
           ,[DesktopTituloMenu]
           ,[Logo]
           ,[Orden]
           ,[DesktopTituloBanner]
           ,[MobileTituloBanner]
           ,[DesktopSubTituloBanner]
           ,[MobileSubTituloBanner]
           ,[DesktopFondoBanner]
           ,[MobileFondoBanner]
           ,[DesktopLogoBanner]
           ,[MobileLogoBanner]
           ,[UrlMenu]
           ,[OrdenBpt]
           ,[MobileOrden]
           ,[MobileOrdenBPT])
     VALUES
           ('SETAGR',
           0
           ,NULL
           ,0
           ,0
           ,0
           ,NULL
           ,NULL
           ,NULL
           ,0
           ,NULL
            ,NULL
            ,NULL
            ,NULL
            ,NULL
            ,NULL
            ,NULL
            ,NULL
            ,NULL
           ,0
           ,0
           ,0)
end


if((not exists(select * from configuracionpaisdatos where Codigo='InicioFechaSetAGrupados'))AND exists(select * from configuracionpais where Codigo='SETAGR'))
begin

 

INSERT INTO [dbo].[ConfiguracionPaisDatos]
           ([ConfiguracionPaisID]
           ,[Codigo]
           ,[CampaniaID]
           ,[Valor1]
           ,[Valor2]
           ,[Valor3]
           ,[Descripcion]
           ,[Estado]
           ,[Componente])
     VALUES
           ((select ConfiguracionPaisID from configuracionpais where Codigo='SETAGR') 
           ,'InicioFechaSetAGrupados'
           ,0
           ,'2010'
           ,'04'
           ,'18'
           ,'YEAR - MONTH - DAY, para sets agrupados'
           ,0
           ,null)
 



end

---update ConfiguracionPaisDatos set valor1=2019 where codigo ='InicioFechaSetAGrupados'