
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RevistaDigitalSuscripcion_SingleActiva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
)
AS
BEGIN

	select top 1
		 RevistaDigitalSuscripcionID
		,CodigoConsultora
		,CampaniaID
		,FechaSuscripcion
		,FechaDesuscripcion
		,EstadoRegistro
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
		,CampaniaEfectiva
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	CampaniaEfectiva <= @CampaniaID
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END

GO
