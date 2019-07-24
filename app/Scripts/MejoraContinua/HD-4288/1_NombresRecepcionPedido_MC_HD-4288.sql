﻿USE [BelcorpBolivia] 

go 

IF NOT EXISTS (SELECT * 
               FROM   sys.columns C 
                      JOIN sys.objects O 
                        ON C.[object_id] = O.[object_id] 
               WHERE  O.type = 'U' 
                      AND O.NAME = 'pedidoweb' 
                      AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD nombresrecepcionpedido VARCHAR(512) NULL 
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
                      AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD nombresrecepcionpedido VARCHAR(512) NULL 
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
                      AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD nombresrecepcionpedido VARCHAR(512) NULL 
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
                      AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD nombresrecepcionpedido VARCHAR(512) NULL 
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
                      AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD nombresrecepcionpedido VARCHAR(512) NULL 
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
                      AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD nombresrecepcionpedido VARCHAR(512) NULL 
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
                      AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD nombresrecepcionpedido VARCHAR(512) NULL 
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
                      AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD nombresrecepcionpedido VARCHAR(512) NULL 
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
                      AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD nombresrecepcionpedido VARCHAR(512) NULL 
  END 

go 

USE [Belcorpperu] 

go 

IF NOT EXISTS (SELECT * 
               FROM   sys.columns C 
                      JOIN sys.objects O 
                        ON C.[object_id] = O.[object_id] 
               WHERE  O.type = 'U' 
                      AND O.NAME = 'pedidoweb' 
                      AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD nombresrecepcionpedido VARCHAR(512) NULL 
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
                      AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD nombresrecepcionpedido VARCHAR(512) NULL 
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
                      AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        ADD nombresrecepcionpedido VARCHAR(512) NULL 
  END 

go 