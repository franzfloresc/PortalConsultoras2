use BelcorpBolivia
go

if(exists(SELECT  OBJECT_NAME(object_id) FROM sys.objects WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'))
begin


declare @ConstraintName nvarchar(100),@sqlCommand nvarchar(100)
SELECT @ConstraintName= OBJECT_NAME(object_id) 
FROM sys.objects

WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'
SET @sqlCommand = 'alter table estrategiaproducto drop constraint ' + @ConstraintName

EXEC (@sqlCommand)

alter table estrategiaproducto 
 add constraint df_estrategiaproducto_1
 default 0 for [Activo]


 end
 go
 use BelcorpChile
go

if(exists(SELECT  OBJECT_NAME(object_id) FROM sys.objects WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'))
begin


declare @ConstraintName nvarchar(100),@sqlCommand nvarchar(100)
SELECT @ConstraintName= OBJECT_NAME(object_id) 
FROM sys.objects

WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'
SET @sqlCommand = 'alter table estrategiaproducto drop constraint ' + @ConstraintName

EXEC (@sqlCommand)

alter table estrategiaproducto 
 add constraint df_estrategiaproducto_1
 default 0 for [Activo]


 end
 go
use BelcorpColombia
go

if(exists(SELECT  OBJECT_NAME(object_id) FROM sys.objects WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'))
begin


declare @ConstraintName nvarchar(100),@sqlCommand nvarchar(100)
SELECT @ConstraintName= OBJECT_NAME(object_id) 
FROM sys.objects

WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'
SET @sqlCommand = 'alter table estrategiaproducto drop constraint ' + @ConstraintName

EXEC (@sqlCommand)

alter table estrategiaproducto 
 add constraint df_estrategiaproducto_1
 default 0 for [Activo]


 end
 go
use BelcorpCostaRica
go

if(exists(SELECT  OBJECT_NAME(object_id) FROM sys.objects WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'))
begin


declare @ConstraintName nvarchar(100),@sqlCommand nvarchar(100)
SELECT @ConstraintName= OBJECT_NAME(object_id) 
FROM sys.objects

WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'
SET @sqlCommand = 'alter table estrategiaproducto drop constraint ' + @ConstraintName

EXEC (@sqlCommand)

alter table estrategiaproducto 
 add constraint df_estrategiaproducto_1
 default 0 for [Activo]


 end
 go
use BelcorpDominicana
go

if(exists(SELECT  OBJECT_NAME(object_id) FROM sys.objects WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'))
begin


declare @ConstraintName nvarchar(100),@sqlCommand nvarchar(100)
SELECT @ConstraintName= OBJECT_NAME(object_id) 
FROM sys.objects

WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'
SET @sqlCommand = 'alter table estrategiaproducto drop constraint ' + @ConstraintName

EXEC (@sqlCommand)

alter table estrategiaproducto 
 add constraint df_estrategiaproducto_1
 default 0 for [Activo]


 end
 go
use BelcorpEcuador
go

if(exists(SELECT  OBJECT_NAME(object_id) FROM sys.objects WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'))
begin


declare @ConstraintName nvarchar(100),@sqlCommand nvarchar(100)
SELECT @ConstraintName= OBJECT_NAME(object_id) 
FROM sys.objects

WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'
SET @sqlCommand = 'alter table estrategiaproducto drop constraint ' + @ConstraintName

EXEC (@sqlCommand)

alter table estrategiaproducto 
 add constraint df_estrategiaproducto_1
 default 0 for [Activo]


 end
 go
use BelcorpGuatemala
go

if(exists(SELECT  OBJECT_NAME(object_id) FROM sys.objects WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'))
begin


declare @ConstraintName nvarchar(100),@sqlCommand nvarchar(100)
SELECT @ConstraintName= OBJECT_NAME(object_id) 
FROM sys.objects

WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'
SET @sqlCommand = 'alter table estrategiaproducto drop constraint ' + @ConstraintName

EXEC (@sqlCommand)

alter table estrategiaproducto 
 add constraint df_estrategiaproducto_1
 default 0 for [Activo]


 end
 go
use BelcorpMexico
go

if(exists(SELECT  OBJECT_NAME(object_id) FROM sys.objects WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'))
begin


declare @ConstraintName nvarchar(100),@sqlCommand nvarchar(100)
SELECT @ConstraintName= OBJECT_NAME(object_id) 
FROM sys.objects

WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'
SET @sqlCommand = 'alter table estrategiaproducto drop constraint ' + @ConstraintName

EXEC (@sqlCommand)

alter table estrategiaproducto 
 add constraint df_estrategiaproducto_1
 default 0 for [Activo]


 end
 go
use BelcorpPanama
go

if(exists(SELECT  OBJECT_NAME(object_id) FROM sys.objects WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'))
begin


declare @ConstraintName nvarchar(100),@sqlCommand nvarchar(100)
SELECT @ConstraintName= OBJECT_NAME(object_id) 
FROM sys.objects

WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'
SET @sqlCommand = 'alter table estrategiaproducto drop constraint ' + @ConstraintName

EXEC (@sqlCommand)

alter table estrategiaproducto 
 add constraint df_estrategiaproducto_1
 default 0 for [Activo]


 end
 go
use BelcorpPeru
go

if(exists(SELECT  OBJECT_NAME(object_id) FROM sys.objects WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'))
begin


declare @ConstraintName nvarchar(100),@sqlCommand nvarchar(100)
SELECT @ConstraintName= OBJECT_NAME(object_id) 
FROM sys.objects

WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'
SET @sqlCommand = 'alter table estrategiaproducto drop constraint ' + @ConstraintName

EXEC (@sqlCommand)

alter table estrategiaproducto 
 add constraint df_estrategiaproducto_1
 default 0 for [Activo]


 end
 go
use BelcorpPuertoRico
go

if(exists(SELECT  OBJECT_NAME(object_id) FROM sys.objects WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'))
begin


declare @ConstraintName nvarchar(100),@sqlCommand nvarchar(100)
SELECT @ConstraintName= OBJECT_NAME(object_id) 
FROM sys.objects

WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'
SET @sqlCommand = 'alter table estrategiaproducto drop constraint ' + @ConstraintName

EXEC (@sqlCommand)

alter table estrategiaproducto 
 add constraint df_estrategiaproducto_1
 default 0 for [Activo]


 end
 go
 use BelcorpSalvador
go

if(exists(SELECT  OBJECT_NAME(object_id) FROM sys.objects WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'))
begin


declare @ConstraintName nvarchar(100),@sqlCommand nvarchar(100)
SELECT @ConstraintName= OBJECT_NAME(object_id) 
FROM sys.objects

WHERE type_desc LIKE '%DEFAULT_CONSTRAINT' AND OBJECT_NAME(parent_object_id)='estrategiaproducto'
SET @sqlCommand = 'alter table estrategiaproducto drop constraint ' + @ConstraintName

EXEC (@sqlCommand)

alter table estrategiaproducto 
 add constraint df_estrategiaproducto_1
 default 0 for [Activo]


 end
 go
