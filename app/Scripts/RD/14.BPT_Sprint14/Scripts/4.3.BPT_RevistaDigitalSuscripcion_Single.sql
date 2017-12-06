
go
ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN

	select top 1
		 RevistaDigitalSuscripcionID
		,CodigoConsultora
		,CampaniaID
		,CampaniaEfectiva
		,FechaSuscripcion
		,FechaDesuscripcion
		,EstadoRegistro
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	 (CampaniaID <= @CampaniaID or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END

go