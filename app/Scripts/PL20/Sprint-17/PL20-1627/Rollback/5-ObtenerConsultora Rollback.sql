use BelcorpPeru
go
if exists(select 1 from sysobjects where name = 'ObtenerConsultora' and xtype = 'p')
Drop Procedure ObtenerConsultora
go
use BelcorpColombia
go
if exists(select 1 from sysobjects where name = 'ObtenerConsultora' and xtype = 'p')
Drop Procedure ObtenerConsultora
go
use BelcorpMexico
go
if exists(select 1 from sysobjects where name = 'ObtenerConsultora' and xtype = 'p')
Drop Procedure ObtenerConsultora
go
use BelcorpChile
go
if exists(select 1 from sysobjects where name = 'ObtenerConsultora' and xtype = 'p')
Drop Procedure ObtenerConsultora
go