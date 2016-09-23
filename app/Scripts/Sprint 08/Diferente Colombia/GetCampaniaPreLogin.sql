
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
DECLARE @ZonaHoraria INT  
DECLARE @NroCampanias INT

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
		--ISNULL(CONVERT(datetime, cr.FechaFinWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti),        
		--CONVERT(datetime, c.FechaFinFacturacion) + CONVERT(datetime, @HoraCierreZonaNormal)) < @FechaGeneral       
		CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma -1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion),0)) + CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral        
ORDER BY c.CampaniaID DESC        

declare @IndicadorEnviado bit = 0  
DECLARE @esRechazado int = -1

IF(@Campania <> 0)        
BEGIN       
	SET @Campania = @Campania - @Anio        
	IF(@Campania = @NroCampanias)        
		SET @Campania = @Anio + 101        
	ELSE        
		SET @Campania = @Anio + @Campania + 1    

		--Colocar nueva lógica    

	
		SELECT @esRechazado = esRechazado, @IndicadorEnviado = IndicadorEnviado
		FROM  EsPedidoRechazado_SB2(@ConsultoraID, @Campania)
				
		if @IndicadorEnviado = 1 and @esRechazado = 2 -- no rechazado (sigue con el proceso normal=> cambio de campaña)
		begin
			SET @Campania = @Campania - @Anio
			IF(@Campania = @NroCampanias)
				SET @Campania = @Anio + 101
			ELSE
				SET @Campania = @Anio + @Campania + 1
		END
		

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
 

		SELECT @esRechazado = esRechazado, @IndicadorEnviado = IndicadorEnviado
		FROM  EsPedidoRechazado_SB2(@ConsultoraID, @Campania)
				
		if @IndicadorEnviado = 1 and @esRechazado = 2 -- no rechazado (sigue con el proceso normal=> cambio de campaña)
		begin
			SET @Campania = @Campania - @Anio
			IF(@Campania = @NroCampanias)
				SET @Campania = @Anio + 101
			ELSE
				SET @Campania = @Anio + @Campania + 1
		END
			

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

