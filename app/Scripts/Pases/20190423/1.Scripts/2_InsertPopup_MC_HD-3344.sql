USE [BelcorpBolivia];
GO
if ((select count(2) from TablaLogicaDatos where Codigo='9000') = 0) begin

declare  @TablaLogicaDatosID int
declare  @TablaLogicaIDP int

select  @TablaLogicaIDP=max(TablaLogicaID) + 1 from TablaLogica
select  @TablaLogicaDatosID=max(TablaLogicaDatosID) + 1 from TablaLogicaDatos

insert into TablaLogica(TablaLogicaID,Descripcion )
select @TablaLogicaIDP, 'Popup informativos'

insert into TablaLogicaDatos
(
TablaLogicaDatosID,
TablaLogicaID
,Codigo
,Descripcion
,Valor
)
select @TablaLogicaDatosID,
 @TablaLogicaIDP,
 '9000', 
 'Valida si el popup que se muestra cuando tienen pendiente algun dato en mi perfil está activo o inactivo',
 '1'

print('Se realizò el registro ')
 end
 else 
 begin
 print('No se realizò el registro porque ya existe el dato ')

GO
USE [BelcorpChile];
GO
if ((select count(2) from TablaLogicaDatos where Codigo='9000') = 0) begin

declare  @TablaLogicaDatosID int
declare  @TablaLogicaIDP int

select  @TablaLogicaIDP=max(TablaLogicaID) + 1 from TablaLogica
select  @TablaLogicaDatosID=max(TablaLogicaDatosID) + 1 from TablaLogicaDatos

insert into TablaLogica(TablaLogicaID,Descripcion )
select @TablaLogicaIDP, 'Popup informativos'

insert into TablaLogicaDatos
(
TablaLogicaDatosID,
TablaLogicaID
,Codigo
,Descripcion
,Valor
)
select @TablaLogicaDatosID,
 @TablaLogicaIDP,
 '9000', 
 'Valida si el popup que se muestra cuando tienen pendiente algun dato en mi perfil está activo o inactivo',
 '1'

print('Se realizò el registro ')
 end
 else 
 begin
 print('No se realizò el registro porque ya existe el dato ')

GO
USE [BelcorpColombia];
GO
if ((select count(2) from TablaLogicaDatos where Codigo='9000') = 0) begin

declare  @TablaLogicaDatosID int
declare  @TablaLogicaIDP int

select  @TablaLogicaIDP=max(TablaLogicaID) + 1 from TablaLogica
select  @TablaLogicaDatosID=max(TablaLogicaDatosID) + 1 from TablaLogicaDatos

insert into TablaLogica(TablaLogicaID,Descripcion )
select @TablaLogicaIDP, 'Popup informativos'

insert into TablaLogicaDatos
(
TablaLogicaDatosID,
TablaLogicaID
,Codigo
,Descripcion
,Valor
)
select @TablaLogicaDatosID,
 @TablaLogicaIDP,
 '9000', 
 'Valida si el popup que se muestra cuando tienen pendiente algun dato en mi perfil está activo o inactivo',
 '1'

print('Se realizò el registro ')
 end
 else 
 begin
 print('No se realizò el registro porque ya existe el dato ')

GO
USE [BelcorpCostaRica];
GO
if ((select count(2) from TablaLogicaDatos where Codigo='9000') = 0) begin

declare  @TablaLogicaDatosID int
declare  @TablaLogicaIDP int

select  @TablaLogicaIDP=max(TablaLogicaID) + 1 from TablaLogica
select  @TablaLogicaDatosID=max(TablaLogicaDatosID) + 1 from TablaLogicaDatos

insert into TablaLogica(TablaLogicaID,Descripcion )
select @TablaLogicaIDP, 'Popup informativos'

insert into TablaLogicaDatos
(
TablaLogicaDatosID,
TablaLogicaID
,Codigo
,Descripcion
,Valor
)
select @TablaLogicaDatosID,
 @TablaLogicaIDP,
 '9000', 
 'Valida si el popup que se muestra cuando tienen pendiente algun dato en mi perfil está activo o inactivo',
 '1'

print('Se realizò el registro ')
 end
 else 
 begin
 print('No se realizò el registro porque ya existe el dato ')

GO
USE [BelcorpDominicana];
GO
if ((select count(2) from TablaLogicaDatos where Codigo='9000') = 0) begin

declare  @TablaLogicaDatosID int
declare  @TablaLogicaIDP int

select  @TablaLogicaIDP=max(TablaLogicaID) + 1 from TablaLogica
select  @TablaLogicaDatosID=max(TablaLogicaDatosID) + 1 from TablaLogicaDatos

insert into TablaLogica(TablaLogicaID,Descripcion )
select @TablaLogicaIDP, 'Popup informativos'

insert into TablaLogicaDatos
(
TablaLogicaDatosID,
TablaLogicaID
,Codigo
,Descripcion
,Valor
)
select @TablaLogicaDatosID,
 @TablaLogicaIDP,
 '9000', 
 'Valida si el popup que se muestra cuando tienen pendiente algun dato en mi perfil está activo o inactivo',
 '1'

print('Se realizò el registro ')
 end
 else 
 begin
 print('No se realizò el registro porque ya existe el dato ')

GO
USE [BelcorpEcuador];
GO
if ((select count(2) from TablaLogicaDatos where Codigo='9000') = 0) begin

declare  @TablaLogicaDatosID int
declare  @TablaLogicaIDP int

select  @TablaLogicaIDP=max(TablaLogicaID) + 1 from TablaLogica
select  @TablaLogicaDatosID=max(TablaLogicaDatosID) + 1 from TablaLogicaDatos

insert into TablaLogica(TablaLogicaID,Descripcion )
select @TablaLogicaIDP, 'Popup informativos'

insert into TablaLogicaDatos
(
TablaLogicaDatosID,
TablaLogicaID
,Codigo
,Descripcion
,Valor
)
select @TablaLogicaDatosID,
 @TablaLogicaIDP,
 '9000', 
 'Valida si el popup que se muestra cuando tienen pendiente algun dato en mi perfil está activo o inactivo',
 '1'

print('Se realizò el registro ')
 end
 else 
 begin
 print('No se realizò el registro porque ya existe el dato ')

GO
USE [BelcorpGuatemala];
GO
if ((select count(2) from TablaLogicaDatos where Codigo='9000') = 0) begin

declare  @TablaLogicaDatosID int
declare  @TablaLogicaIDP int

select  @TablaLogicaIDP=max(TablaLogicaID) + 1 from TablaLogica
select  @TablaLogicaDatosID=max(TablaLogicaDatosID) + 1 from TablaLogicaDatos

insert into TablaLogica(TablaLogicaID,Descripcion )
select @TablaLogicaIDP, 'Popup informativos'

insert into TablaLogicaDatos
(
TablaLogicaDatosID,
TablaLogicaID
,Codigo
,Descripcion
,Valor
)
select @TablaLogicaDatosID,
 @TablaLogicaIDP,
 '9000', 
 'Valida si el popup que se muestra cuando tienen pendiente algun dato en mi perfil está activo o inactivo',
 '1'

print('Se realizò el registro ')
 end
 else 
 begin
 print('No se realizò el registro porque ya existe el dato ')

GO
USE [BelcorpMexico];
GO
if ((select count(2) from TablaLogicaDatos where Codigo='9000') = 0) begin

declare  @TablaLogicaDatosID int
declare  @TablaLogicaIDP int

select  @TablaLogicaIDP=max(TablaLogicaID) + 1 from TablaLogica
select  @TablaLogicaDatosID=max(TablaLogicaDatosID) + 1 from TablaLogicaDatos

insert into TablaLogica(TablaLogicaID,Descripcion )
select @TablaLogicaIDP, 'Popup informativos'

insert into TablaLogicaDatos
(
TablaLogicaDatosID,
TablaLogicaID
,Codigo
,Descripcion
,Valor
)
select @TablaLogicaDatosID,
 @TablaLogicaIDP,
 '9000', 
 'Valida si el popup que se muestra cuando tienen pendiente algun dato en mi perfil está activo o inactivo',
 '1'

print('Se realizò el registro ')
 end
 else 
 begin
 print('No se realizò el registro porque ya existe el dato ')

GO
USE [BelcorpPanama];
GO
if ((select count(2) from TablaLogicaDatos where Codigo='9000') = 0) begin

declare  @TablaLogicaDatosID int
declare  @TablaLogicaIDP int

select  @TablaLogicaIDP=max(TablaLogicaID) + 1 from TablaLogica
select  @TablaLogicaDatosID=max(TablaLogicaDatosID) + 1 from TablaLogicaDatos

insert into TablaLogica(TablaLogicaID,Descripcion )
select @TablaLogicaIDP, 'Popup informativos'

insert into TablaLogicaDatos
(
TablaLogicaDatosID,
TablaLogicaID
,Codigo
,Descripcion
,Valor
)
select @TablaLogicaDatosID,
 @TablaLogicaIDP,
 '9000', 
 'Valida si el popup que se muestra cuando tienen pendiente algun dato en mi perfil está activo o inactivo',
 '1'

print('Se realizò el registro ')
 end
 else 
 begin
 print('No se realizò el registro porque ya existe el dato ')

GO
USE [BelcorpPeru];
GO
if ((select count(2) from TablaLogicaDatos where Codigo='9000') = 0) begin

declare  @TablaLogicaDatosID int
declare  @TablaLogicaIDP int

select  @TablaLogicaIDP=max(TablaLogicaID) + 1 from TablaLogica
select  @TablaLogicaDatosID=max(TablaLogicaDatosID) + 1 from TablaLogicaDatos

insert into TablaLogica(TablaLogicaID,Descripcion )
select @TablaLogicaIDP, 'Popup informativos'

insert into TablaLogicaDatos
(
TablaLogicaDatosID,
TablaLogicaID
,Codigo
,Descripcion
,Valor
)
select @TablaLogicaDatosID,
 @TablaLogicaIDP,
 '9000', 
 'Valida si el popup que se muestra cuando tienen pendiente algun dato en mi perfil está activo o inactivo',
 '1'

print('Se realizò el registro ')
 end
 else 
 begin
 print('No se realizò el registro porque ya existe el dato ')

GO
USE [BelcorpPuertoRico];
GO
if ((select count(2) from TablaLogicaDatos where Codigo='9000') = 0) begin

declare  @TablaLogicaDatosID int
declare  @TablaLogicaIDP int

select  @TablaLogicaIDP=max(TablaLogicaID) + 1 from TablaLogica
select  @TablaLogicaDatosID=max(TablaLogicaDatosID) + 1 from TablaLogicaDatos

insert into TablaLogica(TablaLogicaID,Descripcion )
select @TablaLogicaIDP, 'Popup informativos'

insert into TablaLogicaDatos
(
TablaLogicaDatosID,
TablaLogicaID
,Codigo
,Descripcion
,Valor
)
select @TablaLogicaDatosID,
 @TablaLogicaIDP,
 '9000', 
 'Valida si el popup que se muestra cuando tienen pendiente algun dato en mi perfil está activo o inactivo',
 '1'

print('Se realizò el registro ')
 end
 else 
 begin
 print('No se realizò el registro porque ya existe el dato ')

GO
USE [BelcorpSalvador];
GO
if ((select count(2) from TablaLogicaDatos where Codigo='9000') = 0) begin

declare  @TablaLogicaDatosID int
declare  @TablaLogicaIDP int

select  @TablaLogicaIDP=max(TablaLogicaID) + 1 from TablaLogica
select  @TablaLogicaDatosID=max(TablaLogicaDatosID) + 1 from TablaLogicaDatos

insert into TablaLogica(TablaLogicaID,Descripcion )
select @TablaLogicaIDP, 'Popup informativos'

insert into TablaLogicaDatos
(
TablaLogicaDatosID,
TablaLogicaID
,Codigo
,Descripcion
,Valor
)
select @TablaLogicaDatosID,
 @TablaLogicaIDP,
 '9000', 
 'Valida si el popup que se muestra cuando tienen pendiente algun dato en mi perfil está activo o inactivo',
 '1'

print('Se realizò el registro ')
 end
 else 
 begin
 print('No se realizò el registro porque ya existe el dato ')

GO
