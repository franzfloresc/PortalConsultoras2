USE SoporteConsultoras;
GO
DECLARE @URL VARCHAR(256)='Consultoras/ReporteProductoSugeridoNivelConsultora'
DECLARE @MAXIMO INT

IF NOT EXISTS (SELECT * 
           FROM   MENU 
           WHERE  URL = @URL ) 
BEGIN

SELECT @MAXIMO=MAX(IDMENU) +1 FROM MENU

INSERT INTO MENU	   
(
IDMENU
,SECCION
,NOMBRE
,ORDEN
,URL
,ESTADOACTIVO
)   
SELECT 	@MAXIMO, 'Consultoras','Reporte sugerido de consultoras',21, 'Consultoras/ReporteProductoSugeridoNivelConsultora',1
END 
