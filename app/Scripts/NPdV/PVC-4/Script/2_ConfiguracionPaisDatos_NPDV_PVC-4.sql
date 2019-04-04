USE BelcorpPeru
GO

IF not exists (select 1 from ConfiguracionPais where Codigo = 'CAMINOBRILLANTE')
begin
	declare @ConfiguracionPaisID int
	insert into ConfiguracionPais (Codigo ,Excluyente ,Descripcion ,Estado, TienePerfil, DesdeCampania, Orden, OrdenBpt, MobileOrden,MobileOrdenBPT)
	values ('CAMINOBRILLANTE', 1,'Camino brillante de las consultoras', 0, 0 , 0, 0, 0, 0, 0)
	set @ConfiguracionPaisID = SCOPE_IDENTITY()
	if not exists (select 1 from ConfiguracionPaisDatos where Codigo = 'HomeCaminoBrillante')
	begin
		insert into ConfiguracionPaisDatos values (@ConfiguracionPaisID, 'HomeCaminoBrillante', 0, 
											  '�Crece como {0} y obt�n m�s beneficios!', NULL, NULL, '0: Mensaje home Camino Brillante 1: -- 2: --', 1, 'CaminoBrillante')
	end
end
go

USE BelcorpMexico
GO

IF not exists (select 1 from ConfiguracionPais where Codigo = 'CAMINOBRILLANTE')
begin
	declare @ConfiguracionPaisID int
	insert into ConfiguracionPais (Codigo ,Excluyente ,Descripcion ,Estado, TienePerfil, DesdeCampania, Orden, OrdenBpt, MobileOrden,MobileOrdenBPT)
	values ('CAMINOBRILLANTE', 1,'Camino brillante de las consultoras', 0, 0 , 0, 0, 0, 0, 0)
	set @ConfiguracionPaisID = SCOPE_IDENTITY()
	if not exists (select 1 from ConfiguracionPaisDatos where Codigo = 'HomeCaminoBrillante')
	begin
		insert into ConfiguracionPaisDatos values (@ConfiguracionPaisID, 'HomeCaminoBrillante', 0, 
											  '�Crece como {0} y obt�n m�s beneficios!', NULL, NULL, '0: Mensaje home Camino Brillante 1: -- 2: --', 1, 'CaminoBrillante')
	end
end
go

USE BelcorpColombia
GO

IF not exists (select 1 from ConfiguracionPais where Codigo = 'CAMINOBRILLANTE')
begin
	declare @ConfiguracionPaisID int
	insert into ConfiguracionPais (Codigo ,Excluyente ,Descripcion ,Estado, TienePerfil, DesdeCampania, Orden, OrdenBpt, MobileOrden,MobileOrdenBPT)
	values ('CAMINOBRILLANTE', 1,'Camino brillante de las consultoras', 0, 0 , 0, 0, 0, 0, 0)
	set @ConfiguracionPaisID = SCOPE_IDENTITY()
	if not exists (select 1 from ConfiguracionPaisDatos where Codigo = 'HomeCaminoBrillante')
	begin
		insert into ConfiguracionPaisDatos values (@ConfiguracionPaisID, 'HomeCaminoBrillante', 0, 
											  '�Crece como {0} y obt�n m�s beneficios!', NULL, NULL, '0: Mensaje home Camino Brillante 1: -- 2: --', 1, 'CaminoBrillante')
	end
end
go

USE BelcorpSalvador
GO

IF not exists (select 1 from ConfiguracionPais where Codigo = 'CAMINOBRILLANTE')
begin
	declare @ConfiguracionPaisID int
	insert into ConfiguracionPais (Codigo ,Excluyente ,Descripcion ,Estado, TienePerfil, DesdeCampania, Orden, OrdenBpt, MobileOrden,MobileOrdenBPT)
	values ('CAMINOBRILLANTE', 1,'Camino brillante de las consultoras', 0, 0 , 0, 0, 0, 0, 0)
	set @ConfiguracionPaisID = SCOPE_IDENTITY()
	if not exists (select 1 from ConfiguracionPaisDatos where Codigo = 'HomeCaminoBrillante')
	begin
		insert into ConfiguracionPaisDatos values (@ConfiguracionPaisID, 'HomeCaminoBrillante', 0, 
											  '�Crece como {0} y obt�n m�s beneficios!', NULL, NULL, '0: Mensaje home Camino Brillante 1: -- 2: --', 1, 'CaminoBrillante')
	end
end
go

USE BelcorpPuertoRico
GO

IF not exists (select 1 from ConfiguracionPais where Codigo = 'CAMINOBRILLANTE')
begin
	declare @ConfiguracionPaisID int
	insert into ConfiguracionPais (Codigo ,Excluyente ,Descripcion ,Estado, TienePerfil, DesdeCampania, Orden, OrdenBpt, MobileOrden,MobileOrdenBPT)
	values ('CAMINOBRILLANTE', 1,'Camino brillante de las consultoras', 0, 0 , 0, 0, 0, 0, 0)
	set @ConfiguracionPaisID = SCOPE_IDENTITY()
	if not exists (select 1 from ConfiguracionPaisDatos where Codigo = 'HomeCaminoBrillante')
	begin
		insert into ConfiguracionPaisDatos values (@ConfiguracionPaisID, 'HomeCaminoBrillante', 0, 
											  '�Crece como {0} y obt�n m�s beneficios!', NULL, NULL, '0: Mensaje home Camino Brillante 1: -- 2: --', 1, 'CaminoBrillante')
	end
end
go

USE BelcorpPanama
GO

IF not exists (select 1 from ConfiguracionPais where Codigo = 'CAMINOBRILLANTE')
begin
	declare @ConfiguracionPaisID int
	insert into ConfiguracionPais (Codigo ,Excluyente ,Descripcion ,Estado, TienePerfil, DesdeCampania, Orden, OrdenBpt, MobileOrden,MobileOrdenBPT)
	values ('CAMINOBRILLANTE', 1,'Camino brillante de las consultoras', 0, 0 , 0, 0, 0, 0, 0)
	set @ConfiguracionPaisID = SCOPE_IDENTITY()
	if not exists (select 1 from ConfiguracionPaisDatos where Codigo = 'HomeCaminoBrillante')
	begin
		insert into ConfiguracionPaisDatos values (@ConfiguracionPaisID, 'HomeCaminoBrillante', 0, 
											  '�Crece como {0} y obt�n m�s beneficios!', NULL, NULL, '0: Mensaje home Camino Brillante 1: -- 2: --', 1, 'CaminoBrillante')
	end
end
go

USE BelcorpGuatemala
GO

IF not exists (select 1 from ConfiguracionPais where Codigo = 'CAMINOBRILLANTE')
begin
	declare @ConfiguracionPaisID int
	insert into ConfiguracionPais (Codigo ,Excluyente ,Descripcion ,Estado, TienePerfil, DesdeCampania, Orden, OrdenBpt, MobileOrden,MobileOrdenBPT)
	values ('CAMINOBRILLANTE', 1,'Camino brillante de las consultoras', 0, 0 , 0, 0, 0, 0, 0)
	set @ConfiguracionPaisID = SCOPE_IDENTITY()
	if not exists (select 1 from ConfiguracionPaisDatos where Codigo = 'HomeCaminoBrillante')
	begin
		insert into ConfiguracionPaisDatos values (@ConfiguracionPaisID, 'HomeCaminoBrillante', 0, 
											  '�Crece como {0} y obt�n m�s beneficios!', NULL, NULL, '0: Mensaje home Camino Brillante 1: -- 2: --', 1, 'CaminoBrillante')
	end
end
go

USE BelcorpEcuador
GO

IF not exists (select 1 from ConfiguracionPais where Codigo = 'CAMINOBRILLANTE')
begin
	declare @ConfiguracionPaisID int
	insert into ConfiguracionPais (Codigo ,Excluyente ,Descripcion ,Estado, TienePerfil, DesdeCampania, Orden, OrdenBpt, MobileOrden,MobileOrdenBPT)
	values ('CAMINOBRILLANTE', 1,'Camino brillante de las consultoras', 1, 0 , 0, 0, 0, 0, 0)
	set @ConfiguracionPaisID = SCOPE_IDENTITY()
	if not exists (select 1 from ConfiguracionPaisDatos where Codigo = 'HomeCaminoBrillante')
	begin
		insert into ConfiguracionPaisDatos values (@ConfiguracionPaisID, 'HomeCaminoBrillante', 0, 
											  '�Crece como {0} y obt�n m�s beneficios!', NULL, NULL, '0: Mensaje home Camino Brillante 1: -- 2: --', 1, 'CaminoBrillante')
	end
end
go

USE BelcorpDominicana
GO

IF not exists (select 1 from ConfiguracionPais where Codigo = 'CAMINOBRILLANTE')
begin
	declare @ConfiguracionPaisID int
	insert into ConfiguracionPais (Codigo ,Excluyente ,Descripcion ,Estado, TienePerfil, DesdeCampania, Orden, OrdenBpt, MobileOrden,MobileOrdenBPT)
	values ('CAMINOBRILLANTE', 1,'Camino brillante de las consultoras', 0, 0 , 0, 0, 0, 0, 0)
	set @ConfiguracionPaisID = SCOPE_IDENTITY()
	if not exists (select 1 from ConfiguracionPaisDatos where Codigo = 'HomeCaminoBrillante')
	begin
		insert into ConfiguracionPaisDatos values (@ConfiguracionPaisID, 'HomeCaminoBrillante', 0, 
											  '�Crece como {0} y obt�n m�s beneficios!', NULL, NULL, '0: Mensaje home Camino Brillante 1: -- 2: --', 1, 'CaminoBrillante')
	end
end
go

USE BelcorpCostaRica
GO

IF not exists (select 1 from ConfiguracionPais where Codigo = 'CAMINOBRILLANTE')
begin
	declare @ConfiguracionPaisID int
	insert into ConfiguracionPais (Codigo ,Excluyente ,Descripcion ,Estado, TienePerfil, DesdeCampania, Orden, OrdenBpt, MobileOrden,MobileOrdenBPT)
	values ('CAMINOBRILLANTE', 1,'Camino brillante de las consultoras', 1, 0 , 0, 0, 0, 0, 0)
	set @ConfiguracionPaisID = SCOPE_IDENTITY()
	if not exists (select 1 from ConfiguracionPaisDatos where Codigo = 'HomeCaminoBrillante')
	begin
		insert into ConfiguracionPaisDatos values (@ConfiguracionPaisID, 'HomeCaminoBrillante', 0, 
											  '�Crece como {0} y obt�n m�s beneficios!', NULL, NULL, '0: Mensaje home Camino Brillante 1: -- 2: --', 1, 'CaminoBrillante')
	end
end
go

USE BelcorpChile
GO

IF not exists (select 1 from ConfiguracionPais where Codigo = 'CAMINOBRILLANTE')
begin
	declare @ConfiguracionPaisID int
	insert into ConfiguracionPais (Codigo ,Excluyente ,Descripcion ,Estado, TienePerfil, DesdeCampania, Orden, OrdenBpt, MobileOrden,MobileOrdenBPT)
	values ('CAMINOBRILLANTE', 1,'Camino brillante de las consultoras', 1, 0 , 0, 0, 0, 0, 0)
	set @ConfiguracionPaisID = SCOPE_IDENTITY()
	if not exists (select 1 from ConfiguracionPaisDatos where Codigo = 'HomeCaminoBrillante')
	begin
		insert into ConfiguracionPaisDatos values (@ConfiguracionPaisID, 'HomeCaminoBrillante', 0, 
											  '�Crece como {0} y obt�n m�s beneficios!', NULL, NULL, '0: Mensaje home Camino Brillante 1: -- 2: --', 1, 'CaminoBrillante')
	end
end
go

USE BelcorpBolivia
GO

IF not exists (select 1 from ConfiguracionPais where Codigo = 'CAMINOBRILLANTE')
begin
	declare @ConfiguracionPaisID int
	insert into ConfiguracionPais (Codigo ,Excluyente ,Descripcion ,Estado, TienePerfil, DesdeCampania, Orden, OrdenBpt, MobileOrden,MobileOrdenBPT)
	values ('CAMINOBRILLANTE', 1,'Camino brillante de las consultoras', 1, 0 , 0, 0, 0, 0, 0)
	set @ConfiguracionPaisID = SCOPE_IDENTITY()
	if not exists (select 1 from ConfiguracionPaisDatos where Codigo = 'HomeCaminoBrillante')
	begin
		insert into ConfiguracionPaisDatos values (@ConfiguracionPaisID, 'HomeCaminoBrillante', 0, 
											  '�Crece como {0} y obt�n m�s beneficios!', NULL, NULL, '0: Mensaje home Camino Brillante 1: -- 2: --', 1, 'CaminoBrillante')
	end
end
go

