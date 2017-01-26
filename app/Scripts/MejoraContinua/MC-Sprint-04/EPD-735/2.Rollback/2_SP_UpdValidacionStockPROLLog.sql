USE BelcorpCostaRica
GO
alter procedure UpdValidacionStockPROLLog
	@ValidacionStockPROLLogId bigint,
	@EnvioCorreo bit,
	@ErrorEnvioCorreo varchar(200)
as
begin
	update ValidacionStockPROLLog
	set EnvioCorreo = @EnvioCorreo,
		ErrorEnvioCorreo = @ErrorEnvioCorreo,
		FechaHoraEnvioCorreo = dbo.fnObtenerFechaHoraPais()
	where ValidacionStockPROLLogId = @ValidacionStockPROLLogId;
end
GO
if type_id('dbo.StockProlLogType') is not null
begin
	DROP TYPE dbo.StockProlLogType
end
GO
/*end*/

USE BelcorpDominicana
GO
alter procedure UpdValidacionStockPROLLog
	@ValidacionStockPROLLogId bigint,
	@EnvioCorreo bit,
	@ErrorEnvioCorreo varchar(200)
as
begin
	update ValidacionStockPROLLog
	set EnvioCorreo = @EnvioCorreo,
		ErrorEnvioCorreo = @ErrorEnvioCorreo,
		FechaHoraEnvioCorreo = dbo.fnObtenerFechaHoraPais()
	where ValidacionStockPROLLogId = @ValidacionStockPROLLogId;
end
GO
if type_id('dbo.StockProlLogType') is not null
begin
	DROP TYPE dbo.StockProlLogType
end
GO
/*end*/

USE BelcorpEcuador
GO
alter procedure UpdValidacionStockPROLLog
	@ValidacionStockPROLLogId bigint,
	@EnvioCorreo bit,
	@ErrorEnvioCorreo varchar(200)
as
begin
	update ValidacionStockPROLLog
	set EnvioCorreo = @EnvioCorreo,
		ErrorEnvioCorreo = @ErrorEnvioCorreo,
		FechaHoraEnvioCorreo = dbo.fnObtenerFechaHoraPais()
	where ValidacionStockPROLLogId = @ValidacionStockPROLLogId;
end
GO
if type_id('dbo.StockProlLogType') is not null
begin
	DROP TYPE dbo.StockProlLogType
end
GO
/*end*/

USE BelcorpGuatemala
GO
alter procedure UpdValidacionStockPROLLog
	@ValidacionStockPROLLogId bigint,
	@EnvioCorreo bit,
	@ErrorEnvioCorreo varchar(200)
as
begin
	update ValidacionStockPROLLog
	set EnvioCorreo = @EnvioCorreo,
		ErrorEnvioCorreo = @ErrorEnvioCorreo,
		FechaHoraEnvioCorreo = dbo.fnObtenerFechaHoraPais()
	where ValidacionStockPROLLogId = @ValidacionStockPROLLogId;
end
GO
if type_id('dbo.StockProlLogType') is not null
begin
	DROP TYPE dbo.StockProlLogType
end
GO
/*end*/

USE BelcorpPanama
GO
alter procedure UpdValidacionStockPROLLog
	@ValidacionStockPROLLogId bigint,
	@EnvioCorreo bit,
	@ErrorEnvioCorreo varchar(200)
as
begin
	update ValidacionStockPROLLog
	set EnvioCorreo = @EnvioCorreo,
		ErrorEnvioCorreo = @ErrorEnvioCorreo,
		FechaHoraEnvioCorreo = dbo.fnObtenerFechaHoraPais()
	where ValidacionStockPROLLogId = @ValidacionStockPROLLogId;
end
GO
if type_id('dbo.StockProlLogType') is not null
begin
	DROP TYPE dbo.StockProlLogType
end
GO
/*end*/

USE BelcorpPuertoRico
GO
alter procedure UpdValidacionStockPROLLog
	@ValidacionStockPROLLogId bigint,
	@EnvioCorreo bit,
	@ErrorEnvioCorreo varchar(200)
as
begin
	update ValidacionStockPROLLog
	set EnvioCorreo = @EnvioCorreo,
		ErrorEnvioCorreo = @ErrorEnvioCorreo,
		FechaHoraEnvioCorreo = dbo.fnObtenerFechaHoraPais()
	where ValidacionStockPROLLogId = @ValidacionStockPROLLogId;
end
GO
if type_id('dbo.StockProlLogType') is not null
begin
	DROP TYPE dbo.StockProlLogType
end
GO
/*end*/

USE BelcorpSalvador
GO
alter procedure UpdValidacionStockPROLLog
	@ValidacionStockPROLLogId bigint,
	@EnvioCorreo bit,
	@ErrorEnvioCorreo varchar(200)
as
begin
	update ValidacionStockPROLLog
	set EnvioCorreo = @EnvioCorreo,
		ErrorEnvioCorreo = @ErrorEnvioCorreo,
		FechaHoraEnvioCorreo = dbo.fnObtenerFechaHoraPais()
	where ValidacionStockPROLLogId = @ValidacionStockPROLLogId;
end
GO
if type_id('dbo.StockProlLogType') is not null
begin
	DROP TYPE dbo.StockProlLogType
end
GO
/*end*/

USE BelcorpColombia
GO
alter procedure UpdValidacionStockPROLLog
	@ValidacionStockPROLLogId bigint,
	@EnvioCorreo bit,
	@ErrorEnvioCorreo varchar(200)
as
begin
	update ValidacionStockPROLLog
	set EnvioCorreo = @EnvioCorreo,
		ErrorEnvioCorreo = @ErrorEnvioCorreo,
		FechaHoraEnvioCorreo = dbo.fnObtenerFechaHoraPais()
	where ValidacionStockPROLLogId = @ValidacionStockPROLLogId;
end
GO
if type_id('dbo.StockProlLogType') is not null
begin
	DROP TYPE dbo.StockProlLogType
end
GO
/*end*/

USE BelcorpMexico
GO
alter procedure UpdValidacionStockPROLLog
	@ValidacionStockPROLLogId bigint,
	@EnvioCorreo bit,
	@ErrorEnvioCorreo varchar(200)
as
begin
	update ValidacionStockPROLLog
	set EnvioCorreo = @EnvioCorreo,
		ErrorEnvioCorreo = @ErrorEnvioCorreo,
		FechaHoraEnvioCorreo = dbo.fnObtenerFechaHoraPais()
	where ValidacionStockPROLLogId = @ValidacionStockPROLLogId;
end
GO
if type_id('dbo.StockProlLogType') is not null
begin
	DROP TYPE dbo.StockProlLogType
end
GO
/*end*/

USE BelcorpPeru
GO
alter procedure UpdValidacionStockPROLLog
	@ValidacionStockPROLLogId bigint,
	@EnvioCorreo bit,
	@ErrorEnvioCorreo varchar(200)
as
begin
	update ValidacionStockPROLLog
	set EnvioCorreo = @EnvioCorreo,
		ErrorEnvioCorreo = @ErrorEnvioCorreo,
		FechaHoraEnvioCorreo = dbo.fnObtenerFechaHoraPais()
	where ValidacionStockPROLLogId = @ValidacionStockPROLLogId;
end
GO
if type_id('dbo.StockProlLogType') is not null
begin
	DROP TYPE dbo.StockProlLogType
end
GO