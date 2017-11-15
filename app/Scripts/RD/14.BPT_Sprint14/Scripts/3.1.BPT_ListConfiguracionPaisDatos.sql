IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ListConfiguracionPaisDatos') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ListConfiguracionPaisDatos
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisDatos
	@ConfiguracionPaisID int = 0
	,@DesdeCampania int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = '60'
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
AS
BEGIN
	SET @DesdeCampania = ISNULL(@DesdeCampania, 0)

	SELECT @Codigo = Codigo
	FROM ConfiguracionPais
	WHERE ConfiguracionPaisID = @ConfiguracionPaisID

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado 
	FROM ConfiguracionPaisDatos D
		INNER JOIN  (
				select
				c.ConfiguracionPaisID
				from dbo.fnConfiguracionPais_GetAll(
				@Codigo,
				@CodigoRegion,
				@CodigoZona,
				@CodigoSeccion,
				@CodigoConsultora
				) as c
				WHERE (C.DesdeCampania <= @DesdeCampania OR @DesdeCampania = 0)
		) P
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
END