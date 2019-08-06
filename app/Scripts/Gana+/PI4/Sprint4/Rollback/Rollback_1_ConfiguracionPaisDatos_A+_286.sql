use BelcorpColombia_GANAMAS;
go

begin
	declare @vMSPersonalizacion int;
	declare @vPalanca nvarchar(max);
	declare @tPalanca table(
		palanca nvarchar(1000)
	);

	set @vMSPersonalizacion = (select ConfiguracionPaisID from dbo.ConfiguracionPais where codigo = 'MSPersonalizacion');
	set @vPalanca = (select Valor1 from dbo.ConfiguracionPaisDatos where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible'));

	insert @tPalanca(palanca) select item from dbo.SplitString(@vPalanca,',');

	if(exists(select 1 from @tPalanca where palanca = 'LMG'))
	begin
		delete from @tPalanca where palanca = 'LMG';

		set @vPalanca = (select palanca = stuff((
			select ',' + convert(varchar(10),palanca) from @tPalanca for xml path (''), type
		).value('.','nvarchar(1000)'),1,1,''));

		update dbo.ConfiguracionPaisDatos set Valor1 = @vPalanca where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible');
	end;
end;
go

use BelcorpPeru_GANAMAS;
go

begin
	declare @vMSPersonalizacion int;
	declare @vPalanca nvarchar(max);
	declare @tPalanca table(
		palanca nvarchar(1000)
	);

	set @vMSPersonalizacion = (select ConfiguracionPaisID from dbo.ConfiguracionPais where codigo = 'MSPersonalizacion');
	set @vPalanca = (select Valor1 from dbo.ConfiguracionPaisDatos where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible'));

	insert @tPalanca(palanca) select item from dbo.SplitString(@vPalanca,',');

	if(exists(select 1 from @tPalanca where palanca = 'LMG'))
	begin
		delete from @tPalanca where palanca = 'LMG';

		set @vPalanca = (select palanca = stuff((
			select ',' + convert(varchar(10),palanca) from @tPalanca for xml path (''), type
		).value('.','nvarchar(1000)'),1,1,''));

		update dbo.ConfiguracionPaisDatos set Valor1 = @vPalanca where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible');
	end;
end;
go

use BelcorpChile_GANAMAS;
go

begin
	declare @vMSPersonalizacion int;
	declare @vPalanca nvarchar(max);
	declare @tPalanca table(
		palanca nvarchar(1000)
	);

	set @vMSPersonalizacion = (select ConfiguracionPaisID from dbo.ConfiguracionPais where codigo = 'MSPersonalizacion');
	set @vPalanca = (select Valor1 from dbo.ConfiguracionPaisDatos where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible'));

	insert @tPalanca(palanca) select item from dbo.SplitString(@vPalanca,',');

	if(exists(select 1 from @tPalanca where palanca = 'LMG'))
	begin
		delete from @tPalanca where palanca = 'LMG';

		set @vPalanca = (select palanca = stuff((
			select ',' + convert(varchar(10),palanca) from @tPalanca for xml path (''), type
		).value('.','nvarchar(1000)'),1,1,''));

		update dbo.ConfiguracionPaisDatos set Valor1 = @vPalanca where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible');
	end;
end;
go

use BelcorpCostaRica_GANAMAS;
go

begin
	declare @vMSPersonalizacion int;
	declare @vPalanca nvarchar(max);
	declare @tPalanca table(
		palanca nvarchar(1000)
	);

	set @vMSPersonalizacion = (select ConfiguracionPaisID from dbo.ConfiguracionPais where codigo = 'MSPersonalizacion');
	set @vPalanca = (select Valor1 from dbo.ConfiguracionPaisDatos where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible'));

	insert @tPalanca(palanca) select item from dbo.SplitString(@vPalanca,',');

	if(exists(select 1 from @tPalanca where palanca = 'LMG'))
	begin
		delete from @tPalanca where palanca = 'LMG';

		set @vPalanca = (select palanca = stuff((
			select ',' + convert(varchar(10),palanca) from @tPalanca for xml path (''), type
		).value('.','nvarchar(1000)'),1,1,''));

		update dbo.ConfiguracionPaisDatos set Valor1 = @vPalanca where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible');
	end;
end;
go

use BelcorpEcuador_GANAMAS;
go

begin
	declare @vMSPersonalizacion int;
	declare @vPalanca nvarchar(max);
	declare @tPalanca table(
		palanca nvarchar(1000)
	);

	set @vMSPersonalizacion = (select ConfiguracionPaisID from dbo.ConfiguracionPais where codigo = 'MSPersonalizacion');
	set @vPalanca = (select Valor1 from dbo.ConfiguracionPaisDatos where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible'));

	insert @tPalanca(palanca) select item from dbo.SplitString(@vPalanca,',');

	if(exists(select 1 from @tPalanca where palanca = 'LMG'))
	begin
		delete from @tPalanca where palanca = 'LMG';

		set @vPalanca = (select palanca = stuff((
			select ',' + convert(varchar(10),palanca) from @tPalanca for xml path (''), type
		).value('.','nvarchar(1000)'),1,1,''));

		update dbo.ConfiguracionPaisDatos set Valor1 = @vPalanca where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible');
	end;
end;
go

use BelcorpMexico_GANAMAS;
go

begin
	declare @vMSPersonalizacion int;
	declare @vPalanca nvarchar(max);
	declare @tPalanca table(
		palanca nvarchar(1000)
	);

	set @vMSPersonalizacion = (select ConfiguracionPaisID from dbo.ConfiguracionPais where codigo = 'MSPersonalizacion');
	set @vPalanca = (select Valor1 from dbo.ConfiguracionPaisDatos where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible'));

	insert @tPalanca(palanca) select item from dbo.SplitString(@vPalanca,',');

	if(exists(select 1 from @tPalanca where palanca = 'LMG'))
	begin
		delete from @tPalanca where palanca = 'LMG';

		set @vPalanca = (select palanca = stuff((
			select ',' + convert(varchar(10),palanca) from @tPalanca for xml path (''), type
		).value('.','nvarchar(1000)'),1,1,''));

		update dbo.ConfiguracionPaisDatos set Valor1 = @vPalanca where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible');
	end;
end;
go
