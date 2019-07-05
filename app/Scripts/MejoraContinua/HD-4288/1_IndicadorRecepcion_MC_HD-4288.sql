USE [BelcorpBolivia] 

go 

IF NOT EXISTS (SELECT * 
               FROM   sys.columns C 
                      JOIN sys.objects O 
                        ON C.[object_id] = O.[object_id] 
               WHERE  O.type = 'U' 
                      AND O.NAME = 'pedidoweb' 
                      AND C.NAME = 'IndicadorRecepcion') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD indicadorrecepcion BIT NOT NULL CONSTRAINT 
        [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0) 
  END 

go 

USE [BelcorpChile] 

go 

IF NOT EXISTS (SELECT * 
               FROM   sys.columns C 
                      JOIN sys.objects O 
                        ON C.[object_id] = O.[object_id] 
               WHERE  O.type = 'U' 
                      AND O.NAME = 'pedidoweb' 
                      AND C.NAME = 'IndicadorRecepcion') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD indicadorrecepcion BIT NOT NULL CONSTRAINT 
        [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0) 
  END 

go 

USE [BelcorpColombia] 

go 

IF NOT EXISTS (SELECT * 
               FROM   sys.columns C 
                      JOIN sys.objects O 
                        ON C.[object_id] = O.[object_id] 
               WHERE  O.type = 'U' 
                      AND O.NAME = 'pedidoweb' 
                      AND C.NAME = 'IndicadorRecepcion') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD indicadorrecepcion BIT NOT NULL CONSTRAINT 
        [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0) 
  END 

go 

USE [BelcorpCostaRica] 

go 

IF NOT EXISTS (SELECT * 
               FROM   sys.columns C 
                      JOIN sys.objects O 
                        ON C.[object_id] = O.[object_id] 
               WHERE  O.type = 'U' 
                      AND O.NAME = 'pedidoweb' 
                      AND C.NAME = 'IndicadorRecepcion') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD indicadorrecepcion BIT NOT NULL CONSTRAINT 
        [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0) 
  END 

go 

USE [BelcorpDominicana] 

go 

IF NOT EXISTS (SELECT * 
               FROM   sys.columns C 
                      JOIN sys.objects O 
                        ON C.[object_id] = O.[object_id] 
               WHERE  O.type = 'U' 
                      AND O.NAME = 'pedidoweb' 
                      AND C.NAME = 'IndicadorRecepcion') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD indicadorrecepcion BIT NOT NULL CONSTRAINT 
        [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0) 
  END 

go 

USE [BelcorpEcuador] 

go 

IF NOT EXISTS (SELECT * 
               FROM   sys.columns C 
                      JOIN sys.objects O 
                        ON C.[object_id] = O.[object_id] 
               WHERE  O.type = 'U' 
                      AND O.NAME = 'pedidoweb' 
                      AND C.NAME = 'IndicadorRecepcion') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD indicadorrecepcion BIT NOT NULL CONSTRAINT 
        [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0) 
  END 

go 

USE [BelcorpGuatemala] 

go 

IF NOT EXISTS (SELECT * 
               FROM   sys.columns C 
                      JOIN sys.objects O 
                        ON C.[object_id] = O.[object_id] 
               WHERE  O.type = 'U' 
                      AND O.NAME = 'pedidoweb' 
                      AND C.NAME = 'IndicadorRecepcion') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD indicadorrecepcion BIT NOT NULL CONSTRAINT 
        [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0) 
  END 

go 

USE [BelcorpMexico] 

go 

IF NOT EXISTS (SELECT * 
               FROM   sys.columns C 
                      JOIN sys.objects O 
                        ON C.[object_id] = O.[object_id] 
               WHERE  O.type = 'U' 
                      AND O.NAME = 'pedidoweb' 
                      AND C.NAME = 'IndicadorRecepcion') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD indicadorrecepcion BIT NOT NULL CONSTRAINT 
        [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0) 
  END 

go 

USE [BelcorpPanama] 

go 

IF NOT EXISTS (SELECT * 
               FROM   sys.columns C 
                      JOIN sys.objects O 
                        ON C.[object_id] = O.[object_id] 
               WHERE  O.type = 'U' 
                      AND O.NAME = 'pedidoweb' 
                      AND C.NAME = 'IndicadorRecepcion') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD indicadorrecepcion BIT NOT NULL CONSTRAINT 
        [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0) 
  END 

go 

USE [BelcorpPeru] 

go 

IF NOT EXISTS (SELECT * 
               FROM   sys.columns C 
                      JOIN sys.objects O 
                        ON C.[object_id] = O.[object_id] 
               WHERE  O.type = 'U' 
                      AND O.NAME = 'pedidoweb' 
                      AND C.NAME = 'IndicadorRecepcion') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD indicadorrecepcion BIT NOT NULL CONSTRAINT 
        [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0) 
  END 

go 

USE [BelcorpPuertoRico] 

go 

IF NOT EXISTS (SELECT * 
               FROM   sys.columns C 
                      JOIN sys.objects O 
                        ON C.[object_id] = O.[object_id] 
               WHERE  O.type = 'U' 
                      AND O.NAME = 'pedidoweb' 
                      AND C.NAME = 'IndicadorRecepcion') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD indicadorrecepcion BIT NOT NULL CONSTRAINT 
        [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0) 
  END 

go 

USE [BelcorpSalvador] 

go 

IF NOT EXISTS (SELECT * 
               FROM   sys.columns C 
                      JOIN sys.objects O 
                        ON C.[object_id] = O.[object_id] 
               WHERE  O.type = 'U' 
                      AND O.NAME = 'pedidoweb' 
                      AND C.NAME = 'IndicadorRecepcion') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD indicadorrecepcion BIT NOT NULL CONSTRAINT 
        [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0) 
  END 

go 