GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarSetDetalle') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarSetDetalle
GO

CREATE PROCEDURE EstrategiaTemporalActualizarSetDetalle
(
	@CampaniaID INT,
	@EstrategiaCodigo VARCHAR(5),
	@JoinCuvd INT
)
AS
BEGIN
	DECLARE @tipoPer varchar(5)
	set @tipoPer = dbo.fnGetTipoPersonalizacion(@EstrategiaCodigo)
	select @tipoPer

END
GO