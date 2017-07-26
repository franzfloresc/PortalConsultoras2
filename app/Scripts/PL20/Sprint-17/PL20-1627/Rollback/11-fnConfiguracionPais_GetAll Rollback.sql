use BelcorpPeru
go
if exists(select * from sysobjects where name = 'fnConfiguracionPais_GetAll' and xtype = 'tf')
drop function fnConfiguracionPais_GetAll
go
use BelcorpColombia
go
if exists(select * from sysobjects where name = 'fnConfiguracionPais_GetAll' and xtype = 'tf')
drop function fnConfiguracionPais_GetAll
go
