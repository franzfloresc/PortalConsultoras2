USE BelcorpPeru
GO

--Landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801'
end 
GO

--Landing Categoria 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201'
end
GO

--Ficha desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202'
end
GO

--Ficha desde landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802'
end 
GO

--Ficha desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202'
end
GO

--Carrusel desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205'
end
GO

--Carrusel desde landing 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105'
end
GO

--Carrusel desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205'
end 
GO

USE BelcorpMexico
GO

--Landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801'
end 
GO

--Landing Categoria 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201'
end
GO

--Ficha desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202'
end
GO

--Ficha desde landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802'
end 
GO

--Ficha desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202'
end
GO

--Carrusel desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205'
end
GO

--Carrusel desde landing 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105'
end
GO

--Carrusel desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205'
end 
GO

USE BelcorpColombia
GO

--Landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801'
end 
GO

--Landing Categoria 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201'
end
GO

--Ficha desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202'
end
GO

--Ficha desde landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802'
end 
GO

--Ficha desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202'
end
GO

--Carrusel desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205'
end
GO

--Carrusel desde landing 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105'
end
GO

--Carrusel desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205'
end 
GO

USE BelcorpSalvador
GO

--Landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801'
end 
GO

--Landing Categoria 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201'
end
GO

--Ficha desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202'
end
GO

--Ficha desde landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802'
end 
GO

--Ficha desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202'
end
GO

--Carrusel desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205'
end
GO

--Carrusel desde landing 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105'
end
GO

--Carrusel desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205'
end 
GO

USE BelcorpPuertoRico
GO

--Landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801'
end 
GO

--Landing Categoria 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201'
end
GO

--Ficha desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202'
end
GO

--Ficha desde landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802'
end 
GO

--Ficha desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202'
end
GO

--Carrusel desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205'
end
GO

--Carrusel desde landing 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105'
end
GO

--Carrusel desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205'
end 
GO

USE BelcorpPanama
GO

--Landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801'
end 
GO

--Landing Categoria 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201'
end
GO

--Ficha desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202'
end
GO

--Ficha desde landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802'
end 
GO

--Ficha desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202'
end
GO

--Carrusel desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205'
end
GO

--Carrusel desde landing 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105'
end
GO

--Carrusel desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205'
end 
GO

USE BelcorpGuatemala
GO

--Landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801'
end 
GO

--Landing Categoria 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201'
end
GO

--Ficha desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202'
end
GO

--Ficha desde landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802'
end 
GO

--Ficha desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202'
end
GO

--Carrusel desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205'
end
GO

--Carrusel desde landing 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105'
end
GO

--Carrusel desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205'
end 
GO

USE BelcorpEcuador
GO

--Landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801'
end 
GO

--Landing Categoria 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201'
end
GO

--Ficha desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202'
end
GO

--Ficha desde landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802'
end 
GO

--Ficha desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202'
end
GO

--Carrusel desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205'
end
GO

--Carrusel desde landing 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105'
end
GO

--Carrusel desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205'
end 
GO

USE BelcorpDominicana
GO

--Landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801'
end 
GO

--Landing Categoria 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201'
end
GO

--Ficha desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202'
end
GO

--Ficha desde landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802'
end 
GO

--Ficha desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202'
end
GO

--Carrusel desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205'
end
GO

--Carrusel desde landing 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105'
end
GO

--Carrusel desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205'
end 
GO

USE BelcorpCostaRica
GO

--Landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801'
end 
GO

--Landing Categoria 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201'
end
GO

--Ficha desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202'
end
GO

--Ficha desde landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802'
end 
GO

--Ficha desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202'
end
GO

--Carrusel desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205'
end
GO

--Carrusel desde landing 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105'
end
GO

--Carrusel desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205'
end 
GO

USE BelcorpChile
GO

--Landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801'
end 
GO

--Landing Categoria 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201'
end
GO

--Ficha desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202'
end
GO

--Ficha desde landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802'
end 
GO

--Ficha desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202'
end
GO

--Carrusel desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205'
end
GO

--Carrusel desde landing 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105'
end
GO

--Carrusel desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205'
end 
GO

USE BelcorpBolivia
GO

--Landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050101'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111401'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000801'
end 
GO

--Landing Categoria 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170301'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170101'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170001'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171401'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170801'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170201'
end
GO

--Ficha desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080102'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4081402'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080802'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080202'
end
GO

--Ficha desde landing
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160302'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4070002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4111402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4000802'
end 
GO

--Ficha desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170302'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170102'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170002'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4171402'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170802'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170202'
end
GO

--Carrusel desde contenedor
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080305'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4080205'
end
GO

--Carrusel desde landing 
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4160305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4050105'
end
GO

--Carrusel desde landing categoria
if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170305'
end 
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170105'
end
GO

if exists (select 1 from origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205')
begin
DELETE origenPedidoWeb WHERE CodOrigenPedidoWeb = '4170205'
end 
GO

