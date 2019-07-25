
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetContenidoAppDetaAct]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetContenidoAppDetaAct]
GO
/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 16/05/2019   
DESCRIPCIÓN : Carga todos las url usadas para mobile
GetContenidoAppDetaAct 1
*/ 

CREATE PROCEDURE GetContenidoAppDetaAct 
	@Parent INT
AS
BEGIN
select 
IdContenidoAct
,Codigo
,Descripcion
,Parent
,Orden

 from dbo.ContenidoAppDetaAct where parent=@Parent
END
go
