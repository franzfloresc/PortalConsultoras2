ALTER PROCEDURE [dbo].[sp_ReporteAutomatico]

(   

@FilasPagina INT,   

@Fila INT,   

@Cantidad INT,   

@ColumnaOrden VARCHAR (50),   

@DireccionOrden VARCHAR (5),  

@ValId INT  

)  

AS  

BEGIN  

  

 DECLARE @OrdenInverso NVARCHAR(1024),  

   @SentenciaSQL NVARCHAR(3072),  

   @SentenciaPrincipal NVARCHAR(3072),  

   @ParametroSQL NVARCHAR(512),  

   @Orden sysname  

  

 SET @Orden = CONCAT(@ColumnaOrden, ' ' , @DireccionOrden)  

 SET @OrdenInverso = CONCAT(@ColumnaOrden, ' ' , CASE WHEN    

@DireccionOrden = 'DESC' THEN 'ASC' ELSE 'DESC' END)  

  

 SET @SentenciaPrincipal = '  

       val.Zona,  

       CASE WHEN    

val.Estado = 2 AND val.EsMontoMinino = 0 THEN 6  

       WHEN val.Estado = 3    

AND val.EsMontoMinino = 0 THEN 7  

       ELSE val.Estado END    

as Estado,     

       CASE WHEN    

val.Estado = 1 THEN ''No Reservado - Pedido con P. Liquidación o Sin    

Productos de catálogo''  

       WHEN val.Estado = 2    

AND val.EsMontoMinino = 1 THEN ''No Reservado Monto Min''  

       WHEN val.Estado = 3    

AND val.EsMontoMinino = 1 THEN ''No Reservado Monto Min con Obs.''  

       WHEN val.Estado = 4    

THEN ''Reservado''  

       WHEN val.Estado = 5    

THEN ''Reservado con Obs.''  

       WHEN val.Estado = 2    

AND val.EsMontoMinino = 0 THEN ''No Reservado Monto Max''  

       WHEN val.Estado = 3    

AND val.EsMontoMinino = 0 THEN ''No Reservado Monto Max con Obs.''  

       WHEN val.Estado =    

99 THEN ''Error PROL'' END AS [DescripcionEstado],  

       ISNULL   

(EnvioCorreo,0) as EnvioCorreo,    

       CONVERT(VARCHAR   

(10),val.FechaFacturacion,103) AS FechaFacturacion ,      

       val.Codigo as    

CodigoConsultora,  

       c.NombreCompleto as    

NombreConsultora,val.montominimopedido MontoMinimo,val.montomaximopedido MontoMaximo,val.campaniaid Periodo,r.codigo Region,s.codigo Seccion,isnull(t.numero,'''') Telefono,
isnull(P.ImporteTotal,0) ImporteTotal

       FROM [dbo].   

[ValidacionAutomaticaPROLLog] val with(nolock)  

        INNER JOIN    

ods.Consultora c on val.codigo = c.codigo  

LEFT JOIN ODS.REGION R ON R.REGIONID=C.REGIONID

LEFT JOIN ODS.SECCION S ON S.SECCIONID=C.SECCIONID

LEFT JOIN ODS.TELEFONO T ON T.CONSULTORAID=C.CONSULTORAID AND T.CONSULTORAID=VAL.CONSULTORAID AND TIPOTELEFONO=''TM''

LEFT JOIN PedidoWeb P ON VAL.PEDIDOID=P.PEDIDOID
       WHERE    

val.ValAutomaticaPROLId = @ValId'  

   

 SET @SentenciaSQL = '  

     DECLARE @Residuo int ' +      

     'SET @Residuo = @Filas %    

@FilasPagina ' +      

     'SELECT * ' +   

      'FROM (' +      

       'SELECT TOP (CASE    

WHEN @Residuo = 0 AND @Filas>0 ' +      

       'OR @Filas /    

@FilasPagina > @Fila / @FilasPagina ' +      

       'THEN @FilasPagina    

ELSE @Residuo END) * ' +      

       'FROM(' +  

       'SELECT TOP    

(@FilasPagina + @Fila) ' +  

       @SentenciaPrincipal    

+  

        '  ORDER BY    

' + @Orden +  

        ') t ' +  

             

'  ORDER BY ' + @OrdenInverso +  

             

') t ' +  

      '  ORDER BY ' + @Orden  

  

 SET @ParametroSQL = '@FilasPagina int, ' +      

      '@Fila int, ' +  

      '@Filas int, ' +   

      '@ValId INT'  

  

  

 EXECUTE sp_executesql   

      @stmt             =    

@SentenciaSQL,      

      @params           =    

@ParametroSQL,      

      @FilasPagina      =    

@FilasPagina,      

      @Fila             = @Fila,   

      @Filas            =    

@Cantidad,  

      @ValId          =   @ValId     

   

  

   

  

END;  
