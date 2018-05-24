

USE BelcorpChile

go

declare @origen varchar(10) = 'RD'

delete from AsesoraOnline where Origen = @origen

INSERT INTO AsesoraOnline 
(Origen, CodigoConsultora, ConfirmacionInscripcion, FechaCreacion)

SELECT @origen, s.CodigoConsultora, 1, dbo.fnObtenerFechaHoraPais() as FechaCreacion
FROM RevistaDigitalSuscripcion s

	INNER JOIN (select s1.CodigoConsultora, MAX(s1.CampaniaID) as CampaniaID
				FROM RevistaDigitalSuscripcion s1 GROUP BY s1.CodigoConsultora
	) AS sx
		on sx.CampaniaID = s.CampaniaID
		and sx.CodigoConsultora = s.CodigoConsultora

	LEFT JOIN AsesoraOnline a
		on a.CodigoConsultora = s.CodigoConsultora

WHERE isnull(s.CodigoConsultora, '') != '' 
	and isnull(s.CampaniaID, 0 ) > 0
	and isnull(s.EstadoRegistro, '') != ''
	and s.EstadoRegistro = 1
	and isnull(a.CodigoConsultora, '') = ''

ORDER BY s.CodigoConsultora, s.CampaniaID

go