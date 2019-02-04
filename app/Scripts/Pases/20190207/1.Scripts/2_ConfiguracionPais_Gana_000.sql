USE BelcorpPeru
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

INSERT INTO dbo.ConfiguracionPais 
(Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, OrdenBpt, MobileOrden, MobileOrdenBPT)
VALUES (@Codigo, 1, 'Microservicios personalización', 1,  0, 0, 0, 0, 0)

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@@IDENTITY, 'EstrategiaDisponible', 0, '101,001,005,007,008,009,010,030', NULL, NULL, 'Estrategia disponible en microservicio personalización', 1, NULL)

GO

USE BelcorpMexico
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

INSERT INTO dbo.ConfiguracionPais 
(Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, OrdenBpt, MobileOrden, MobileOrdenBPT)
VALUES (@Codigo, 1, 'Microservicios personalización', 0,  0, 0, 0, 0, 0)

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@@IDENTITY, 'EstrategiaDisponible', 0, ' ', NULL, NULL, 'Estrategia disponible en microservicio personalización', 1, NULL)

GO

USE BelcorpColombia
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

INSERT INTO dbo.ConfiguracionPais 
(Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, OrdenBpt, MobileOrden, MobileOrdenBPT)
VALUES (@Codigo, 1, 'Microservicios personalización', 1,  0, 0, 0, 0, 0)

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@@IDENTITY, 'EstrategiaDisponible', 0, '101,001,005,007,008,009,010,030', NULL, NULL, 'Estrategia disponible en microservicio personalización', 1, NULL)

GO

USE BelcorpSalvador
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

INSERT INTO dbo.ConfiguracionPais 
(Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, OrdenBpt, MobileOrden, MobileOrdenBPT)
VALUES (@Codigo, 1, 'Microservicios personalización', 0,  0, 0, 0, 0, 0)

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@@IDENTITY, 'EstrategiaDisponible', 0, ' ', NULL, NULL, 'Estrategia disponible en microservicio personalización', 1, NULL)

GO

USE BelcorpPuertoRico
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

INSERT INTO dbo.ConfiguracionPais 
(Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, OrdenBpt, MobileOrden, MobileOrdenBPT)
VALUES (@Codigo, 1, 'Microservicios personalización', 0,  0, 0, 0, 0, 0)

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@@IDENTITY, 'EstrategiaDisponible', 0, ' ', NULL, NULL, 'Estrategia disponible en microservicio personalización', 1, NULL)

GO

USE BelcorpPanama
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

INSERT INTO dbo.ConfiguracionPais 
(Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, OrdenBpt, MobileOrden, MobileOrdenBPT)
VALUES (@Codigo, 1, 'Microservicios personalización', 0,  0, 0, 0, 0, 0)

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@@IDENTITY, 'EstrategiaDisponible', 0, ' ', NULL, NULL, 'Estrategia disponible en microservicio personalización', 1, NULL)

GO

USE BelcorpGuatemala
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

INSERT INTO dbo.ConfiguracionPais 
(Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, OrdenBpt, MobileOrden, MobileOrdenBPT)
VALUES (@Codigo, 1, 'Microservicios personalización', 0,  0, 0, 0, 0, 0)

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@@IDENTITY, 'EstrategiaDisponible', 0, ' ', NULL, NULL, 'Estrategia disponible en microservicio personalización', 1, NULL)

GO

USE BelcorpEcuador
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

INSERT INTO dbo.ConfiguracionPais 
(Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, OrdenBpt, MobileOrden, MobileOrdenBPT)
VALUES (@Codigo, 1, 'Microservicios personalización', 0,  0, 0, 0, 0, 0)

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@@IDENTITY, 'EstrategiaDisponible', 0, ' ', NULL, NULL, 'Estrategia disponible en microservicio personalización', 1, NULL)

GO

USE BelcorpDominicana
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

INSERT INTO dbo.ConfiguracionPais 
(Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, OrdenBpt, MobileOrden, MobileOrdenBPT)
VALUES (@Codigo, 1, 'Microservicios personalización', 0,  0, 0, 0, 0, 0)

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@@IDENTITY, 'EstrategiaDisponible', 0, ' ', NULL, NULL, 'Estrategia disponible en microservicio personalización', 1, NULL)

GO

USE BelcorpCostaRica
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

INSERT INTO dbo.ConfiguracionPais 
(Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, OrdenBpt, MobileOrden, MobileOrdenBPT)
VALUES (@Codigo, 1, 'Microservicios personalización', 1,  0, 0, 0, 0, 0)

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@@IDENTITY, 'EstrategiaDisponible', 0, '101,001,005,007,008,009,010,030', NULL, NULL, 'Estrategia disponible en microservicio personalización', 1, NULL)

GO

USE BelcorpChile
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

INSERT INTO dbo.ConfiguracionPais 
(Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, OrdenBpt, MobileOrden, MobileOrdenBPT)
VALUES (@Codigo, 1, 'Microservicios personalización', 1,  0, 0, 0, 0, 0)

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@@IDENTITY, 'EstrategiaDisponible', 0, '101,001,005,007,008,009,010,030', NULL, NULL, 'Estrategia disponible en microservicio personalización', 1, NULL)

GO

USE BelcorpBolivia
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

INSERT INTO dbo.ConfiguracionPais 
(Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, OrdenBpt, MobileOrden, MobileOrdenBPT)
VALUES (@Codigo, 1, 'Microservicios personalización', 0,  0, 0, 0, 0, 0)

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@@IDENTITY, 'EstrategiaDisponible', 0, ' ', NULL, NULL, 'Estrategia disponible en microservicio personalización', 1, NULL)

GO


