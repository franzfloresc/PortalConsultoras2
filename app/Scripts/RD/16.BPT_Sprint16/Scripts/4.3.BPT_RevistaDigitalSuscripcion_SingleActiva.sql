
GO
ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
)
AS
BEGIN

	select top 1
		 RevistaDigitalSuscripcionID
		,Origen
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
		and	CampaniaEfectiva <= @CampaniaID
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc

END

GO
