GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
CREATE PROC GetConsultoraProductoExclusivo
(
@CampaniaID int,
@CodigoConsultora varchar(20)
)
AS
BEGIN
	select 
		Cuv as cuv
	from
	ods.ProductoExclusivoConsultora with(nolock)
	where Campania = @CampaniaID
	and CodigoConsultora = @CodigoConsultora
END
GO