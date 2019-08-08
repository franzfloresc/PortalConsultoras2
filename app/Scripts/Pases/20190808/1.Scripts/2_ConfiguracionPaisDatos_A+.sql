GO
USE BelcorpPeru
GO
begin
	declare @vMSPersonalizacion int;
	declare @vPalanca nvarchar(max);
	declare @tPalanca table(
		palanca nvarchar(1000)
	);

	set @vMSPersonalizacion = (select ConfiguracionPaisID from dbo.ConfiguracionPais where codigo = 'MSPersonalizacion');
	set @vPalanca = (select Valor1 from dbo.ConfiguracionPaisDatos where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible'));

	insert @tPalanca(palanca) select item from dbo.SplitString(@vPalanca,',');

	if(not exists(select 1 from @tPalanca where palanca = 'LMG'))
	begin
		insert into @tPalanca(palanca) values ('LMG');

		set @vPalanca = (select palanca = stuff((
			select ',' + convert(varchar(10),palanca) from @tPalanca for xml path (''), type
		).value('.','nvarchar(1000)'),1,1,''));

		update dbo.ConfiguracionPaisDatos set Valor1 = @vPalanca where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible');
	end;
end;

GO
USE BelcorpMexico
GO
begin
	declare @vMSPersonalizacion int;
	declare @vPalanca nvarchar(max);
	declare @tPalanca table(
		palanca nvarchar(1000)
	);

	set @vMSPersonalizacion = (select ConfiguracionPaisID from dbo.ConfiguracionPais where codigo = 'MSPersonalizacion');
	set @vPalanca = (select Valor1 from dbo.ConfiguracionPaisDatos where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible'));

	insert @tPalanca(palanca) select item from dbo.SplitString(@vPalanca,',');

	if(not exists(select 1 from @tPalanca where palanca = 'LMG'))
	begin
		insert into @tPalanca(palanca) values ('LMG');

		set @vPalanca = (select palanca = stuff((
			select ',' + convert(varchar(10),palanca) from @tPalanca for xml path (''), type
		).value('.','nvarchar(1000)'),1,1,''));

		update dbo.ConfiguracionPaisDatos set Valor1 = @vPalanca where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible');
	end;
end;

GO
USE BelcorpColombia
GO
begin
	declare @vMSPersonalizacion int;
	declare @vPalanca nvarchar(max);
	declare @tPalanca table(
		palanca nvarchar(1000)
	);

	set @vMSPersonalizacion = (select ConfiguracionPaisID from dbo.ConfiguracionPais where codigo = 'MSPersonalizacion');
	set @vPalanca = (select Valor1 from dbo.ConfiguracionPaisDatos where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible'));

	insert @tPalanca(palanca) select item from dbo.SplitString(@vPalanca,',');

	if(not exists(select 1 from @tPalanca where palanca = 'LMG'))
	begin
		insert into @tPalanca(palanca) values ('LMG');

		set @vPalanca = (select palanca = stuff((
			select ',' + convert(varchar(10),palanca) from @tPalanca for xml path (''), type
		).value('.','nvarchar(1000)'),1,1,''));

		update dbo.ConfiguracionPaisDatos set Valor1 = @vPalanca where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible');
	end;
end;

GO
USE BelcorpSalvador
GO
begin
	declare @vMSPersonalizacion int;
	declare @vPalanca nvarchar(max);
	declare @tPalanca table(
		palanca nvarchar(1000)
	);

	set @vMSPersonalizacion = (select ConfiguracionPaisID from dbo.ConfiguracionPais where codigo = 'MSPersonalizacion');
	set @vPalanca = (select Valor1 from dbo.ConfiguracionPaisDatos where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible'));

	insert @tPalanca(palanca) select item from dbo.SplitString(@vPalanca,',');

	if(not exists(select 1 from @tPalanca where palanca = 'LMG'))
	begin
		insert into @tPalanca(palanca) values ('LMG');

		set @vPalanca = (select palanca = stuff((
			select ',' + convert(varchar(10),palanca) from @tPalanca for xml path (''), type
		).value('.','nvarchar(1000)'),1,1,''));

		update dbo.ConfiguracionPaisDatos set Valor1 = @vPalanca where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible');
	end;
end;

GO
USE BelcorpPuertoRico
GO
begin
	declare @vMSPersonalizacion int;
	declare @vPalanca nvarchar(max);
	declare @tPalanca table(
		palanca nvarchar(1000)
	);

	set @vMSPersonalizacion = (select ConfiguracionPaisID from dbo.ConfiguracionPais where codigo = 'MSPersonalizacion');
	set @vPalanca = (select Valor1 from dbo.ConfiguracionPaisDatos where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible'));

	insert @tPalanca(palanca) select item from dbo.SplitString(@vPalanca,',');

	if(not exists(select 1 from @tPalanca where palanca = 'LMG'))
	begin
		insert into @tPalanca(palanca) values ('LMG');

		set @vPalanca = (select palanca = stuff((
			select ',' + convert(varchar(10),palanca) from @tPalanca for xml path (''), type
		).value('.','nvarchar(1000)'),1,1,''));

		update dbo.ConfiguracionPaisDatos set Valor1 = @vPalanca where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible');
	end;
end;

GO
USE BelcorpPanama
GO
begin
	declare @vMSPersonalizacion int;
	declare @vPalanca nvarchar(max);
	declare @tPalanca table(
		palanca nvarchar(1000)
	);

	set @vMSPersonalizacion = (select ConfiguracionPaisID from dbo.ConfiguracionPais where codigo = 'MSPersonalizacion');
	set @vPalanca = (select Valor1 from dbo.ConfiguracionPaisDatos where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible'));

	insert @tPalanca(palanca) select item from dbo.SplitString(@vPalanca,',');

	if(not exists(select 1 from @tPalanca where palanca = 'LMG'))
	begin
		insert into @tPalanca(palanca) values ('LMG');

		set @vPalanca = (select palanca = stuff((
			select ',' + convert(varchar(10),palanca) from @tPalanca for xml path (''), type
		).value('.','nvarchar(1000)'),1,1,''));

		update dbo.ConfiguracionPaisDatos set Valor1 = @vPalanca where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible');
	end;
end;

GO
USE BelcorpGuatemala
GO
begin
	declare @vMSPersonalizacion int;
	declare @vPalanca nvarchar(max);
	declare @tPalanca table(
		palanca nvarchar(1000)
	);

	set @vMSPersonalizacion = (select ConfiguracionPaisID from dbo.ConfiguracionPais where codigo = 'MSPersonalizacion');
	set @vPalanca = (select Valor1 from dbo.ConfiguracionPaisDatos where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible'));

	insert @tPalanca(palanca) select item from dbo.SplitString(@vPalanca,',');

	if(not exists(select 1 from @tPalanca where palanca = 'LMG'))
	begin
		insert into @tPalanca(palanca) values ('LMG');

		set @vPalanca = (select palanca = stuff((
			select ',' + convert(varchar(10),palanca) from @tPalanca for xml path (''), type
		).value('.','nvarchar(1000)'),1,1,''));

		update dbo.ConfiguracionPaisDatos set Valor1 = @vPalanca where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible');
	end;
end;

GO
USE BelcorpEcuador
GO
begin
	declare @vMSPersonalizacion int;
	declare @vPalanca nvarchar(max);
	declare @tPalanca table(
		palanca nvarchar(1000)
	);

	set @vMSPersonalizacion = (select ConfiguracionPaisID from dbo.ConfiguracionPais where codigo = 'MSPersonalizacion');
	set @vPalanca = (select Valor1 from dbo.ConfiguracionPaisDatos where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible'));

	insert @tPalanca(palanca) select item from dbo.SplitString(@vPalanca,',');

	if(not exists(select 1 from @tPalanca where palanca = 'LMG'))
	begin
		insert into @tPalanca(palanca) values ('LMG');

		set @vPalanca = (select palanca = stuff((
			select ',' + convert(varchar(10),palanca) from @tPalanca for xml path (''), type
		).value('.','nvarchar(1000)'),1,1,''));

		update dbo.ConfiguracionPaisDatos set Valor1 = @vPalanca where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible');
	end;
end;

GO
USE BelcorpDominicana
GO
begin
	declare @vMSPersonalizacion int;
	declare @vPalanca nvarchar(max);
	declare @tPalanca table(
		palanca nvarchar(1000)
	);

	set @vMSPersonalizacion = (select ConfiguracionPaisID from dbo.ConfiguracionPais where codigo = 'MSPersonalizacion');
	set @vPalanca = (select Valor1 from dbo.ConfiguracionPaisDatos where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible'));

	insert @tPalanca(palanca) select item from dbo.SplitString(@vPalanca,',');

	if(not exists(select 1 from @tPalanca where palanca = 'LMG'))
	begin
		insert into @tPalanca(palanca) values ('LMG');

		set @vPalanca = (select palanca = stuff((
			select ',' + convert(varchar(10),palanca) from @tPalanca for xml path (''), type
		).value('.','nvarchar(1000)'),1,1,''));

		update dbo.ConfiguracionPaisDatos set Valor1 = @vPalanca where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible');
	end;
end;

GO
USE BelcorpCostaRica
GO
begin
	declare @vMSPersonalizacion int;
	declare @vPalanca nvarchar(max);
	declare @tPalanca table(
		palanca nvarchar(1000)
	);

	set @vMSPersonalizacion = (select ConfiguracionPaisID from dbo.ConfiguracionPais where codigo = 'MSPersonalizacion');
	set @vPalanca = (select Valor1 from dbo.ConfiguracionPaisDatos where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible'));

	insert @tPalanca(palanca) select item from dbo.SplitString(@vPalanca,',');

	if(not exists(select 1 from @tPalanca where palanca = 'LMG'))
	begin
		insert into @tPalanca(palanca) values ('LMG');

		set @vPalanca = (select palanca = stuff((
			select ',' + convert(varchar(10),palanca) from @tPalanca for xml path (''), type
		).value('.','nvarchar(1000)'),1,1,''));

		update dbo.ConfiguracionPaisDatos set Valor1 = @vPalanca where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible');
	end;
end;

GO
USE BelcorpChile
GO
begin
	declare @vMSPersonalizacion int;
	declare @vPalanca nvarchar(max);
	declare @tPalanca table(
		palanca nvarchar(1000)
	);

	set @vMSPersonalizacion = (select ConfiguracionPaisID from dbo.ConfiguracionPais where codigo = 'MSPersonalizacion');
	set @vPalanca = (select Valor1 from dbo.ConfiguracionPaisDatos where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible'));

	insert @tPalanca(palanca) select item from dbo.SplitString(@vPalanca,',');

	if(not exists(select 1 from @tPalanca where palanca = 'LMG'))
	begin
		insert into @tPalanca(palanca) values ('LMG');

		set @vPalanca = (select palanca = stuff((
			select ',' + convert(varchar(10),palanca) from @tPalanca for xml path (''), type
		).value('.','nvarchar(1000)'),1,1,''));

		update dbo.ConfiguracionPaisDatos set Valor1 = @vPalanca where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible');
	end;
end;

GO
USE BelcorpBolivia
GO
begin
	declare @vMSPersonalizacion int;
	declare @vPalanca nvarchar(max);
	declare @tPalanca table(
		palanca nvarchar(1000)
	);

	set @vMSPersonalizacion = (select ConfiguracionPaisID from dbo.ConfiguracionPais where codigo = 'MSPersonalizacion');
	set @vPalanca = (select Valor1 from dbo.ConfiguracionPaisDatos where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible'));

	insert @tPalanca(palanca) select item from dbo.SplitString(@vPalanca,',');

	if(not exists(select 1 from @tPalanca where palanca = 'LMG'))
	begin
		insert into @tPalanca(palanca) values ('LMG');

		set @vPalanca = (select palanca = stuff((
			select ',' + convert(varchar(10),palanca) from @tPalanca for xml path (''), type
		).value('.','nvarchar(1000)'),1,1,''));

		update dbo.ConfiguracionPaisDatos set Valor1 = @vPalanca where (ConfiguracionPaisID = @vMSPersonalizacion) and (Codigo = 'EstrategiaDisponible');
	end;
end;

GO
