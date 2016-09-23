
ALTER FUNCTION [dbo].[GetCampaniaPreLogin](

@PaisID tinyint,        
@ZonaID int,        
@RegionID int,    
@ConsultoraID bigint 

)
RETURNS @TablaDatos TABLE
(
	CampaniaId int
)
AS      

BEGIN

DECLARE @HoraCierreZonaNormal TIME(0)        
DECLARE @HoraCierreZonaDemAnti TIME(0)        
DECLARE @NroCampanias INT
DECLARE @ZonaHoraria INT  

select	@ZonaHoraria = ISNULL(ZonaHoraria,0),        
		@HoraCierreZonaNormal = HoraCierreZonaNormal,        
		@HoraCierreZonaDemAnti = HoraCierreZonaDemAnti,
		@NroCampanias = NroCampanias  
from Pais (nolock)        
where PaisId = @PaisID        

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = DATEADD(HH,@ZonaHoraria,getdate())        

----Validar        

DECLARE @HoraInicio time(0)        
DECLARE @HoraFin time(0)        
DECLARE @DiasAntes tinyint        
DECLARE @HoraInicioNoFacturable time(0)        
DECLARE @HoraCierreNoFacturable time(0)              

SELECT	@HoraInicio = HoraInicio,        
		@HoraFin = HoraFin,        
		@DiasAntes = DiasAntes,        
		@HoraInicioNoFacturable = HoraInicioNoFacturable,        
		@HoraCierreNoFacturable = HoraCierreNoFacturable        
FROM [dbo].[ConfiguracionValidacion] (nolock)        
WHERE  PaisID = @PaisID                

DECLARE @ZonaValida int        
DECLARE @DiasDuracionCronograma int
set @DiasDuracionCronograma = 1

SELECT @ZonaValida = ZonaID, @DiasDuracionCronograma = DiasDuracionCronograma     
FROM [dbo].[ConfiguracionValidacionZona] (nolock)        
WHERE ZonaID = @ZonaID        

----          

DECLARE @Campania INT        
DECLARE @Anio INT        
SET @Campania = 0        

SELECT TOP 1 @Campania = ca.Codigo, @Anio = ca.Anio * 100        
FROM [ods].[Cronograma] c (nolock)            
INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID        
LEFT JOIN [dbo].[Cronograma] cr (nolock) ON c.CampaniaID = cr.CampaniaID AND         
											c.RegionID = cr.RegionID AND         
											c.ZonaID = cr.ZonaID   
WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND         
  ISNULL(CONVERT(datetime, cr.FechaInicioDD) + CONVERT(datetime, @HoraCierreZonaDemAnti),        
    CONVERT(datetime, c.FechaInicioReFacturacion) + CONVERT(datetime, @HoraCierreZonaNormal)) < @FechaGeneral         
   --CONVERT(datetime, c.FechaFinFacturacion) + CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral          
ORDER BY c.CampaniaID DESC 
--WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND         
--		--ISNULL(CONVERT(datetime, cr.FechaFinWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti),        
--		--CONVERT(datetime, c.FechaFinFacturacion) + CONVERT(datetime, @HoraCierreZonaNormal)) < @FechaGeneral       
--		CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma -1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion),0)) + CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral        
--ORDER BY c.CampaniaID DESC        

IF(@Campania <> 0)        
BEGIN       
	SET @Campania = @Campania - @Anio        
	IF(@Campania = @NroCampanias)        
		SET @Campania = @Anio + 101        
	ELSE        
		SET @Campania = @Anio + @Campania + 1    

  --Colocar nueva l�gica    


	declare @IndicadorEnviado bit    
	set @IndicadorEnviado = 0    

	Select @IndicadorEnviado  = IndicadorEnviado    
	From pedidoweb (nolock)  
	Where CampaniaID = @campania and consultoraid = @consultoraid    

	If(@IndicadorEnviado = 1)    
	Begin    
		SET @Campania = @Campania - @Anio      
		IF(@Campania = @NroCampanias)      
			SET @Campania = @Anio + 101      
		ELSE      
			SET @Campania = @Anio + @Campania + 1      
	end  

	INSERT INTO @TablaDatos
	(CampaniaId)
	SELECT	ca.Codigo AS CampaniaID  
	FROM [ods].[Cronograma] c (nolock)        
	INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID        
	LEFT JOIN [dbo].[Cronograma] cr (nolock) ON	c.CampaniaID = cr.CampaniaID AND         
												c.RegionID = cr.RegionID AND         
												c.ZonaID = cr.ZonaID          
	WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania   
END
ELSE
BEGIN

	SELECT TOP 1 @Campania = ca.Codigo, @Anio = ca.Anio * 100        
	FROM [ods].[Cronograma] c (nolock)              
	INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
	WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID
	ORDER BY c.FechaFinFacturacion ASC

	declare @IndicadorEnviado2 bit   
	set @IndicadorEnviado2 = 0    

	Select @IndicadorEnviado2  = IndicadorEnviado    
	From pedidoweb (nolock)   
	Where CampaniaID = @campania and consultoraid = @consultoraid    

	If(@IndicadorEnviado2 = 1)    
	Begin    
		SET @Campania = @Campania - @Anio      
		IF(@Campania = @NroCampanias)      
			SET @Campania = @Anio + 101      
		ELSE      
			SET @Campania = @Anio + @Campania + 1      
	end

	INSERT INTO @TablaDatos
	(CampaniaId)
	SELECT ca.Codigo AS CampaniaID    
	FROM [ods].[Cronograma] c (nolock)          
	INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID        
	LEFT JOIN [dbo].[Cronograma] cr (nolock) ON c.CampaniaID = cr.CampaniaID AND         
												c.RegionID = cr.RegionID AND        
												c.ZonaID = cr.ZonaID          
	WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
END
	RETURN
END


