GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarPrecioNivel') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarPrecioNivel
GO

CREATE PROCEDURE EstrategiaTemporalActualizarPrecioNivel
(
	@CampaniaID INT,
	@EstrategiaCodigo VARCHAR(100),
	@JoinCuvd INT
)
AS
BEGIN
	
	DECLARE @tipoPer varchar(5)
	set @tipoPer = dbo.fnGetTipoPersonalizacion(@EstrategiaCodigo)
	select @tipoPer

END
GO