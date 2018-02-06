USE BelcorpPeru_PL50
GO
IF NOT EXISTS (SELECT column_name 
                 FROM information_schema.columns 
                 WHERE table_schema='dbo' 
                   and table_name='Estrategia' 
                   and column_name='ImagenMiniaturaURL')
    ALTER TABLE dbo.Estrategia ADD ImagenMiniaturaURL VARCHAR (200)
ELSE
   PRINT 'El campo ya existe ImagenMiniaturaURL';
GO
IF NOT EXISTS (SELECT column_name 
                 FROM information_schema.columns 
                 WHERE table_schema='dbo' 
                   and table_name='Estrategia' 
                   and column_name='EsSubCampania')
   ALTER TABLE dbo.Estrategia ADD EsSubCampania BIT
ELSE
   PRINT 'El campo ya existe EsSubCampania';

