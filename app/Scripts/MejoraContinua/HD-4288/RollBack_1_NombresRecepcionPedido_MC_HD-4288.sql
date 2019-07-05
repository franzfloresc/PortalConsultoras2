﻿USE [BelcorpBolivia] 

go 

IF EXISTS (SELECT * 
           FROM   sys.columns C 
                  JOIN sys.objects O 
                    ON C.[object_id] = O.[object_id] 
           WHERE  O.type = 'U' 
                  AND O.NAME = 'pedidoweb' 
                  AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        DROP COLUMN nombresrecepcionpedido 
  END 

go 

USE [BelcorpChile] 

go 

IF EXISTS (SELECT * 
           FROM   sys.columns C 
                  JOIN sys.objects O 
                    ON C.[object_id] = O.[object_id] 
           WHERE  O.type = 'U' 
                  AND O.NAME = 'pedidoweb' 
                  AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        DROP COLUMN nombresrecepcionpedido 
  END 

go 

USE [BelcorpColombia] 

go 

IF EXISTS (SELECT * 
           FROM   sys.columns C 
                  JOIN sys.objects O 
                    ON C.[object_id] = O.[object_id] 
           WHERE  O.type = 'U' 
                  AND O.NAME = 'pedidoweb' 
                  AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        DROP COLUMN nombresrecepcionpedido 
  END 

go 

USE [BelcorpCostaRica] 

go 

IF EXISTS (SELECT * 
           FROM   sys.columns C 
                  JOIN sys.objects O 
                    ON C.[object_id] = O.[object_id] 
           WHERE  O.type = 'U' 
                  AND O.NAME = 'pedidoweb' 
                  AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        DROP COLUMN nombresrecepcionpedido 
  END 

go 

USE [BelcorpDominicana] 

go 

IF EXISTS (SELECT * 
           FROM   sys.columns C 
                  JOIN sys.objects O 
                    ON C.[object_id] = O.[object_id] 
           WHERE  O.type = 'U' 
                  AND O.NAME = 'pedidoweb' 
                  AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        DROP COLUMN nombresrecepcionpedido 
  END 

go 

USE [BelcorpEcuador] 

go 

IF EXISTS (SELECT * 
           FROM   sys.columns C 
                  JOIN sys.objects O 
                    ON C.[object_id] = O.[object_id] 
           WHERE  O.type = 'U' 
                  AND O.NAME = 'pedidoweb' 
                  AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        DROP COLUMN nombresrecepcionpedido 
  END 

go 

USE [BelcorpGuatemala] 

go 

IF EXISTS (SELECT * 
           FROM   sys.columns C 
                  JOIN sys.objects O 
                    ON C.[object_id] = O.[object_id] 
           WHERE  O.type = 'U' 
                  AND O.NAME = 'pedidoweb' 
                  AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        DROP COLUMN nombresrecepcionpedido 
  END 

go 

USE [BelcorpMexico] 

go 

IF EXISTS (SELECT * 
           FROM   sys.columns C 
                  JOIN sys.objects O 
                    ON C.[object_id] = O.[object_id] 
           WHERE  O.type = 'U' 
                  AND O.NAME = 'pedidoweb' 
                  AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        DROP COLUMN nombresrecepcionpedido 
  END 

go 

USE [BelcorpPanama] 

go 

IF EXISTS (SELECT * 
           FROM   sys.columns C 
                  JOIN sys.objects O 
                    ON C.[object_id] = O.[object_id] 
           WHERE  O.type = 'U' 
                  AND O.NAME = 'pedidoweb' 
                  AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        DROP COLUMN nombresrecepcionpedido 
  END 

go 

USE [BelcorpPeru] 

go 

IF EXISTS (SELECT * 
           FROM   sys.columns C 
                  JOIN sys.objects O 
                    ON C.[object_id] = O.[object_id] 
           WHERE  O.type = 'U' 
                  AND O.NAME = 'pedidoweb' 
                  AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        DROP COLUMN nombresrecepcionpedido 
  END 

go 

USE [BelcorpPuertoRico] 

go 

IF EXISTS (SELECT * 
           FROM   sys.columns C 
                  JOIN sys.objects O 
                    ON C.[object_id] = O.[object_id] 
           WHERE  O.type = 'U' 
                  AND O.NAME = 'pedidoweb' 
                  AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        DROP COLUMN nombresrecepcionpedido 
  END 

go 

USE [BelcorpSalvador] 

go 

IF EXISTS (SELECT * 
           FROM   sys.columns C 
                  JOIN sys.objects O 
                    ON C.[object_id] = O.[object_id] 
           WHERE  O.type = 'U' 
                  AND O.NAME = 'pedidoweb' 
                  AND C.NAME = 'NombresRecepcionPedido') 
  BEGIN 
      ALTER TABLE pedidoweb 
        DROP COLUMN nombresrecepcionpedido 
  END 

go 