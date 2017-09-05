GO
IF OBJECT_ID('ValidarAsesoraOnlineConfiguracionPais', 'P') IS NOT NULL
	DROP PROC ValidarAsesoraOnlineConfiguracionPais
GO
CREATE PROCEDURE ValidarAsesoraOnlineConfiguracionPais
	@CodigoConsultora varchar(20)
AS
BEGIN
	Declare @habilitadoPais int;
	Declare @habilitadoPaisDetalle int;
	Declare @resultado int;

	Select @habilitadoPais = Estado from ConfiguracionPais where Codigo LIKE 'AO';
	Select @habilitadoPaisDetalle = cpd.Estado 
	from ConfiguracionPaisDetalle cpd
	inner join ConfiguracionPais cp on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
	where cp.Codigo LIKE 'AO' and cpd.CodigoConsultora = @CodigoConsultora;

	IF (@habilitadoPais=1 AND @habilitadoPaisDetalle=1)
		set @resultado = 1;
	ELSE 
		set @resultado = 0;

	select @resultado;
END
GO