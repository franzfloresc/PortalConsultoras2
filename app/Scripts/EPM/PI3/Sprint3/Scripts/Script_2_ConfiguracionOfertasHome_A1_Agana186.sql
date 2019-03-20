
--AGANA-186

GO
USE BelcorpPeru_BPT
GO

print db_name()

declare @Codigo varchar(100) = 'ATP'
declare @DesdeCampania int = 0

-- Verificar si existe la configuracion con Codigo ATP
if not exists (select 1 
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo and coh.CampaniaID = @DesdeCampania)
begin
	declare @ConfiguracionPaisID int
	declare @CampaniaID int
	declare @Orden int --Variable genérica para todos los campos orden

	select 
		@ConfiguracionPaisID = cp.ConfiguracionPaisID, 
		@CampaniaID = cp.DesdeCampania,
		@Orden = cp.orden
	from [dbo].[ConfiguracionPais] cp
	where cp.Codigo = @Codigo 
	and cp.DesdeCampania = @DesdeCampania
	
	print 'Empieza insert into [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	begin try 

	begin transaction InsertCOHCodigoATP;  

	insert into [dbo].[ConfiguracionOfertasHome](
		ConfiguracionPaisID, CampaniaID, DesktopOrden, MobileOrden, DesktopImagenFondo,
		MobileImagenFondo, DesktopTitulo, MobileTitulo, DesktopSubTitulo, MobileSubTitulo,
		DesktopTipoPresentacion, MobileTipoPresentacion, DesktopTipoEstrategia, MobileTipoEstrategia, DesktopCantidadProductos,
		MobileCantidadProductos, DesktopActivo, MobileActivo, UrlSeccion, DesktopOrdenBpt,
		MobileOrdenBpt, DesktopColorFondo, MobileColorFondo, DesktopUsarImagenFondo, MobileUsarImagenFondo,
		DesktopColorTexto, MobileColorTexto,BotonTexto1,BotonTexto2,BotonColor,	BotonColorTexto
	)
	values
	(
		@ConfiguracionPaisID, @CampaniaID, @Orden, @Orden, null,
		null,'ARMA TU PACK','','Elige #Cantidad y llévatelos al #PrecioTotal','',
		10,10,'004','004',0,
		0,1,1,'ArmaTuPack/Detalle',@Orden,
		@Orden,'#fa1702','#fa1702',0,0,
		null,null,'Comenzar','Modificar','#000000','#ffffff'
	)

	IF (@@TRANCOUNT > 0)  commit transaction InsertCOHCodigoATP; 

	print 'Registro insertado correctamente en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	end try
	begin catch
	    SELECT   
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
  
		IF (@@TRANCOUNT > 0) rollback transaction InsertCOHCodigoATP; 

		print 'Error al insertar registro en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
	end catch
end
else
begin
	print 'El registro en Configuracion Ofertas Home con Codigo ATP YA EXISTE'
end 
	print 'Finaliza insert into  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
go


