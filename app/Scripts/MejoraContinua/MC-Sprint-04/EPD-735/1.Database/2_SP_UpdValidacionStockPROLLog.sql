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
	drop type dbo.StockProlLogType
end
GO
create type dbo.StockProlLogType as table(
	ValidacionStockPROLLogId bigint not null,
	StockDisponible int not null
);
GO
alter procedure UpdValidacionStockPROLLog
	@ListadoStockProlLog dbo.StockProlLogType readonly,
	@EnvioCorreo bit,
	@ErrorEnvioCorreo varchar(200)
as
begin
	update ValidacionStockPROLLog
	set
		StockDisponible = LSPL.StockDisponible,
		EnvioCorreo = @EnvioCorreo,
		ErrorEnvioCorreo = @ErrorEnvioCorreo,
		FechaHoraEnvioCorreo = dbo.fnObtenerFechaHoraPais()
	from ValidacionStockPROLLog VSPL
	inner join @ListadoStockProlLog LSPL on VSPL.ValidacionStockPROLLogId = LSPL.ValidacionStockPROLLogId;
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
	drop type dbo.StockProlLogType
end
GO
create type dbo.StockProlLogType as table(
	ValidacionStockPROLLogId bigint not null,
	StockDisponible int not null
);
GO
alter procedure UpdValidacionStockPROLLog
	@ListadoStockProlLog dbo.StockProlLogType readonly,
	@EnvioCorreo bit,
	@ErrorEnvioCorreo varchar(200)
as
begin
	update ValidacionStockPROLLog
	set
		StockDisponible = LSPL.StockDisponible,
		EnvioCorreo = @EnvioCorreo,
		ErrorEnvioCorreo = @ErrorEnvioCorreo,
		FechaHoraEnvioCorreo = dbo.fnObtenerFechaHoraPais()
	from ValidacionStockPROLLog VSPL
	inner join @ListadoStockProlLog LSPL on VSPL.ValidacionStockPROLLogId = LSPL.ValidacionStockPROLLogId;
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
	drop type dbo.StockProlLogType
end
GO
create type dbo.StockProlLogType as table(
	ValidacionStockPROLLogId bigint not null,
	StockDisponible int not null
);
GO
alter procedure UpdValidacionStockPROLLog
	@ListadoStockProlLog dbo.StockProlLogType readonly,
	@EnvioCorreo bit,
	@ErrorEnvioCorreo varchar(200)
as
begin
	update ValidacionStockPROLLog
	set
		StockDisponible = LSPL.StockDisponible,
		EnvioCorreo = @EnvioCorreo,
		ErrorEnvioCorreo = @ErrorEnvioCorreo,
		FechaHoraEnvioCorreo = dbo.fnObtenerFechaHoraPais()
	from ValidacionStockPROLLog VSPL
	inner join @ListadoStockProlLog LSPL on VSPL.ValidacionStockPROLLogId = LSPL.ValidacionStockPROLLogId;
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
	drop type dbo.StockProlLogType
end
GO
create type dbo.StockProlLogType as table(
	ValidacionStockPROLLogId bigint not null,
	StockDisponible int not null
);
GO
alter procedure UpdValidacionStockPROLLog
	@ListadoStockProlLog dbo.StockProlLogType readonly,
	@EnvioCorreo bit,
	@ErrorEnvioCorreo varchar(200)
as
begin
	update ValidacionStockPROLLog
	set
		StockDisponible = LSPL.StockDisponible,
		EnvioCorreo = @EnvioCorreo,
		ErrorEnvioCorreo = @ErrorEnvioCorreo,
		FechaHoraEnvioCorreo = dbo.fnObtenerFechaHoraPais()
	from ValidacionStockPROLLog VSPL
	inner join @ListadoStockProlLog LSPL on VSPL.ValidacionStockPROLLogId = LSPL.ValidacionStockPROLLogId;
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
	drop type dbo.StockProlLogType
end
GO
create type dbo.StockProlLogType as table(
	ValidacionStockPROLLogId bigint not null,
	StockDisponible int not null
);
GO
alter procedure UpdValidacionStockPROLLog
	@ListadoStockProlLog dbo.StockProlLogType readonly,
	@EnvioCorreo bit,
	@ErrorEnvioCorreo varchar(200)
as
begin
	update ValidacionStockPROLLog
	set
		StockDisponible = LSPL.StockDisponible,
		EnvioCorreo = @EnvioCorreo,
		ErrorEnvioCorreo = @ErrorEnvioCorreo,
		FechaHoraEnvioCorreo = dbo.fnObtenerFechaHoraPais()
	from ValidacionStockPROLLog VSPL
	inner join @ListadoStockProlLog LSPL on VSPL.ValidacionStockPROLLogId = LSPL.ValidacionStockPROLLogId;
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
	drop type dbo.StockProlLogType
end
GO
create type dbo.StockProlLogType as table(
	ValidacionStockPROLLogId bigint not null,
	StockDisponible int not null
);
GO
alter procedure UpdValidacionStockPROLLog
	@ListadoStockProlLog dbo.StockProlLogType readonly,
	@EnvioCorreo bit,
	@ErrorEnvioCorreo varchar(200)
as
begin
	update ValidacionStockPROLLog
	set
		StockDisponible = LSPL.StockDisponible,
		EnvioCorreo = @EnvioCorreo,
		ErrorEnvioCorreo = @ErrorEnvioCorreo,
		FechaHoraEnvioCorreo = dbo.fnObtenerFechaHoraPais()
	from ValidacionStockPROLLog VSPL
	inner join @ListadoStockProlLog LSPL on VSPL.ValidacionStockPROLLogId = LSPL.ValidacionStockPROLLogId;
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
	drop type dbo.StockProlLogType
end
GO
create type dbo.StockProlLogType as table(
	ValidacionStockPROLLogId bigint not null,
	StockDisponible int not null
);
GO
alter procedure UpdValidacionStockPROLLog
	@ListadoStockProlLog dbo.StockProlLogType readonly,
	@EnvioCorreo bit,
	@ErrorEnvioCorreo varchar(200)
as
begin
	update ValidacionStockPROLLog
	set
		StockDisponible = LSPL.StockDisponible,
		EnvioCorreo = @EnvioCorreo,
		ErrorEnvioCorreo = @ErrorEnvioCorreo,
		FechaHoraEnvioCorreo = dbo.fnObtenerFechaHoraPais()
	from ValidacionStockPROLLog VSPL
	inner join @ListadoStockProlLog LSPL on VSPL.ValidacionStockPROLLogId = LSPL.ValidacionStockPROLLogId;
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
	drop type dbo.StockProlLogType
end
GO
create type dbo.StockProlLogType as table(
	ValidacionStockPROLLogId bigint not null,
	StockDisponible int not null
);
GO
alter procedure UpdValidacionStockPROLLog
	@ListadoStockProlLog dbo.StockProlLogType readonly,
	@EnvioCorreo bit,
	@ErrorEnvioCorreo varchar(200)
as
begin
	update ValidacionStockPROLLog
	set
		StockDisponible = LSPL.StockDisponible,
		EnvioCorreo = @EnvioCorreo,
		ErrorEnvioCorreo = @ErrorEnvioCorreo,
		FechaHoraEnvioCorreo = dbo.fnObtenerFechaHoraPais()
	from ValidacionStockPROLLog VSPL
	inner join @ListadoStockProlLog LSPL on VSPL.ValidacionStockPROLLogId = LSPL.ValidacionStockPROLLogId;
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
	drop type dbo.StockProlLogType
end
GO
create type dbo.StockProlLogType as table(
	ValidacionStockPROLLogId bigint not null,
	StockDisponible int not null
);
GO
alter procedure UpdValidacionStockPROLLog
	@ListadoStockProlLog dbo.StockProlLogType readonly,
	@EnvioCorreo bit,
	@ErrorEnvioCorreo varchar(200)
as
begin
	update ValidacionStockPROLLog
	set
		StockDisponible = LSPL.StockDisponible,
		EnvioCorreo = @EnvioCorreo,
		ErrorEnvioCorreo = @ErrorEnvioCorreo,
		FechaHoraEnvioCorreo = dbo.fnObtenerFechaHoraPais()
	from ValidacionStockPROLLog VSPL
	inner join @ListadoStockProlLog LSPL on VSPL.ValidacionStockPROLLogId = LSPL.ValidacionStockPROLLogId;
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
	drop type dbo.StockProlLogType
end
GO
create type dbo.StockProlLogType as table(
	ValidacionStockPROLLogId bigint not null,
	StockDisponible int not null
);
GO
alter procedure UpdValidacionStockPROLLog
	@ListadoStockProlLog dbo.StockProlLogType readonly,
	@EnvioCorreo bit,
	@ErrorEnvioCorreo varchar(200)
as
begin
	update ValidacionStockPROLLog
	set
		StockDisponible = LSPL.StockDisponible,
		EnvioCorreo = @EnvioCorreo,
		ErrorEnvioCorreo = @ErrorEnvioCorreo,
		FechaHoraEnvioCorreo = dbo.fnObtenerFechaHoraPais()
	from ValidacionStockPROLLog VSPL
	inner join @ListadoStockProlLog LSPL on VSPL.ValidacionStockPROLLogId = LSPL.ValidacionStockPROLLogId;
end
GO