use ODS_PE
GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivoConsultora')
begin
	create table ProductoExclusivoConsultora
	(
		Campania int,
		CodigoConsultora varchar(25),
		Cuv char(5),
		primary key clustered(Campania, CodigoConsultora, Cuv)
	)
end

GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivo')
begin
	create table ProductoExclusivo(
		Campania int,
		Cuv char(5),
		primary key clustered(Campania, Cuv)
	)
end
GO

use ODS_BO
GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivoConsultora')
begin
	create table ProductoExclusivoConsultora
	(
		Campania int,
		CodigoConsultora varchar(25),
		Cuv char(5),
		primary key clustered(Campania, CodigoConsultora, Cuv)
	)
end

GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivo')
begin
	create table ProductoExclusivo(
		Campania int,
		Cuv char(5),
		primary key clustered(Campania, Cuv)
	)
end
GO

use ODS_CL
GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivoConsultora')
begin
	create table ProductoExclusivoConsultora
	(
		Campania int,
		CodigoConsultora varchar(25),
		Cuv char(5),
		primary key clustered(Campania, CodigoConsultora, Cuv)
	)
end

GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivo')
begin
	create table ProductoExclusivo(
		Campania int,
		Cuv char(5),
		primary key clustered(Campania, Cuv)
	)
end
GO

use ODS_CO
GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivoConsultora')
begin
	create table ProductoExclusivoConsultora
	(
		Campania int,
		CodigoConsultora varchar(25),
		Cuv char(5),
		primary key clustered(Campania, CodigoConsultora, Cuv)
	)
end

GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivo')
begin
	create table ProductoExclusivo(
		Campania int,
		Cuv char(5),
		primary key clustered(Campania, Cuv)
	)
end
GO

use ODS_CR
GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivoConsultora')
begin
	create table ProductoExclusivoConsultora
	(
		Campania int,
		CodigoConsultora varchar(25),
		Cuv char(5),
		primary key clustered(Campania, CodigoConsultora, Cuv)
	)
end

GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivo')
begin
	create table ProductoExclusivo(
		Campania int,
		Cuv char(5),
		primary key clustered(Campania, Cuv)
	)
end
GO

use ODS_DO
GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivoConsultora')
begin
	create table ProductoExclusivoConsultora
	(
		Campania int,
		CodigoConsultora varchar(25),
		Cuv char(5),
		primary key clustered(Campania, CodigoConsultora, Cuv)
	)
end

GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivo')
begin
	create table ProductoExclusivo(
		Campania int,
		Cuv char(5),
		primary key clustered(Campania, Cuv)
	)
end
GO

use ODS_EC
GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivoConsultora')
begin
	create table ProductoExclusivoConsultora
	(
		Campania int,
		CodigoConsultora varchar(25),
		Cuv char(5),
		primary key clustered(Campania, CodigoConsultora, Cuv)
	)
end

GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivo')
begin
	create table ProductoExclusivo(
		Campania int,
		Cuv char(5),
		primary key clustered(Campania, Cuv)
	)
end
GO

use ODS_GT
GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivoConsultora')
begin
	create table ProductoExclusivoConsultora
	(
		Campania int,
		CodigoConsultora varchar(25),
		Cuv char(5),
		primary key clustered(Campania, CodigoConsultora, Cuv)
	)
end

GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivo')
begin
	create table ProductoExclusivo(
		Campania int,
		Cuv char(5),
		primary key clustered(Campania, Cuv)
	)
end
GO

use ODS_MX
GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivoConsultora')
begin
	create table ProductoExclusivoConsultora
	(
		Campania int,
		CodigoConsultora varchar(25),
		Cuv char(5),
		primary key clustered(Campania, CodigoConsultora, Cuv)
	)
end

GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivo')
begin
	create table ProductoExclusivo(
		Campania int,
		Cuv char(5),
		primary key clustered(Campania, Cuv)
	)
end
GO

use ODS_PA
GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivoConsultora')
begin
	create table ProductoExclusivoConsultora
	(
		Campania int,
		CodigoConsultora varchar(25),
		Cuv char(5),
		primary key clustered(Campania, CodigoConsultora, Cuv)
	)
end

GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivo')
begin
	create table ProductoExclusivo(
		Campania int,
		Cuv char(5),
		primary key clustered(Campania, Cuv)
	)
end
GO

use ODS_PR
GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivoConsultora')
begin
	create table ProductoExclusivoConsultora
	(
		Campania int,
		CodigoConsultora varchar(25),
		Cuv char(5),
		primary key clustered(Campania, CodigoConsultora, Cuv)
	)
end

GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivo')
begin
	create table ProductoExclusivo(
		Campania int,
		Cuv char(5),
		primary key clustered(Campania, Cuv)
	)
end
GO

use ODS_SV
GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivoConsultora')
begin
	create table ProductoExclusivoConsultora
	(
		Campania int,
		CodigoConsultora varchar(25),
		Cuv char(5),
		primary key clustered(Campania, CodigoConsultora, Cuv)
	)
end

GO
if not exists(select 1 from sys.objects where type = 'U' and name = 'ProductoExclusivo')
begin
	create table ProductoExclusivo(
		Campania int,
		Cuv char(5),
		primary key clustered(Campania, Cuv)
	)
end
GO
