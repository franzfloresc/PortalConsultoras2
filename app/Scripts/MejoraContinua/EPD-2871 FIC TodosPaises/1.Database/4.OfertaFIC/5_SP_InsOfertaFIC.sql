GO
IF OBJECT_ID('InsOfertaFIC') IS NULL
	exec sp_executesql N'CREATE PROCEDURE InsOfertaFIC AS';
GO
ALTER PROCEDURE InsOfertaFIC
	@OfertaFIC dbo.OfertaFICType READONLY
AS
BEGIN
	INSERT INTO [dbo].[OfertaFIC] (
		CampaniaID,
		CUV,
		ImagenUrl,
		PaisISO,
		UsuarioRegistro,
		NombreImagen
	)
	select 
		CampaniaID,
		CUV,
		ImagenUrl,
		PaisISO,
		UsuarioRegistro,
		NombreImagen
	from @OfertaFIC pf
	where not exists (
		select 1
		from dbo.OfertaFIC
		where
			CampaniaID = pf.CampaniaID 
			and
			PaisISO = pf.PaisISO
	);
END
GO