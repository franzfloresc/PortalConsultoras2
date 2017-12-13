
go

declare @origen varchar(10) = 'RD'

delete from AsesoraOnline where Origen = @origen

INSERT INTO AsesoraOnline (Origen, CodigoConsultora, ConfirmacionInscripcion, FechaCreacion)
select @origen, s.CodigoConsultora, 1, dbo.fnObtenerFechaHoraPais() as FechaCreacion
from RevistaDigitalSuscripcion s
	inner join 
	(select s1.CodigoConsultora, MAX(s1.CampaniaID) as CampaniaID
		FROM RevistaDigitalSuscripcion s1
		group by s1.CodigoConsultora
	) AS sx
		on sx.CampaniaID = s.CampaniaID
		and sx.CodigoConsultora = s.CodigoConsultora
	left join AsesoraOnline a
		on a.CodigoConsultora = s.CodigoConsultora
where isnull(s.CodigoConsultora, '') != '' 
and isnull(s.CampaniaID, 0 ) > 0
and isnull(s.EstadoRegistro, '') != ''
and s.EstadoRegistro = 1
and isnull(a.CodigoConsultora, '') = ''

order by s.CodigoConsultora, s.CampaniaID

go