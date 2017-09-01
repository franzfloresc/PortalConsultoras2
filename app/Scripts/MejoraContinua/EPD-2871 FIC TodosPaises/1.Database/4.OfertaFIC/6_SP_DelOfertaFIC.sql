GO
IF OBJECT_ID('DelOfertaFIC') IS NULL
	exec sp_executesql N'CREATE PROCEDURE DelOfertaFIC AS';
GO
ALTER PROCEDURE DelOfertaFIC
	@CampaniaID bigint,
	@CUV varchar(20),
	@Deleted bit output
as
begin try
	delete dbo.OfertaFIC
	where CampaniaID = @CampaniaID and CUV = @CUV;

	set @Deleted = 1;
end try
begin catch
	if error_number() = 547 
		set @Deleted = 0;
	else
		throw;
end catch;
GO