GO
IF OBJECT_ID('GetProductoOfertaFIC') IS NULL
	exec sp_executesql N'CREATE PROCEDURE GetProductoOfertaFIC AS';
GO
ALTER PROCEDURE GetProductoOfertaFIC
	@CampaniaID int,
	@columnaOrder varchar(100),
	@tipoOrden varchar(10),
	@PaginaActual int,
	@FlagPaginacion bit,
	@RegistrosPorPagina int
AS
BEGIN    
	set nocount on;  
	DECLARE @Descripcion varchar(100)
	DECLARE @NombreImagen varchar(500)
	DECLARE @CUV varchar(20)  
	declare @Query nvarchar(max)    
	declare @QueryUnion nvarchar(max)    
	declare @OrderBy nvarchar(max)    
	declare @TotalRegistros decimal(10,3)    
	declare @TotalNumeroPagina int    
	declare @LastRow int = @PaginaActual * @RegistrosPorPagina    
	declare @FirstRow int = @LastRow - @RegistrosPorPagina + 1    
   
	if @columnaOrder = 'CUV'    
		set @columnaOrder = 'CUV'    
	else if @columnaOrder = 'Descripcion'    
		set @columnaOrder = 'Descripcion'    
	
	if @columnaOrder <> ''                                    
		set @OrderBy = 'order by ' + @columnaOrder + ' '                                    
			+ case @tipoOrden
				 when 'desc' then 'desc'
				 else 'asc'
			end
	else    
	declare @NroCampania Int
	select top 1 @NroCampania=nrocampanias from pais where nrocampanias is not null
	declare @CampaniaID_ Int
  
  if substring(cast(@CampaniaID as varchar(6)),5,2)='01'
  begin
	set @CampaniaID_=cast(cast( cast(substring(cast(@CampaniaID as varchar(6)),1,4)as int)-1 as varchar(4)) + cast(@NroCampania as varchar(2)) as int)
	
  end
  else
  begin  
	set @CampaniaID_= @CampaniaID-1	
  end
 declare @ColumnName  varchar(100),                                    
   @ColumnValue varchar(100),                                    
   @WhereAdd  varchar(max) = ''                      
 set @Query = N' with ProdUnion as
 (    
      SELECT T.CampaniaID,    
        T.CUV,        
        T.Descripcion,    
        T.Estado,
		NombreImagen    
        FROM     
       (select      
		    pf.CampaniaID,pf.CUV,pc.Descripcion, 1 as Estado, pf.NombreImagen   
            from     dbo.OfertaFIC pf      
            join  ods.ProductoComercial pc on pf.CUV = pc.CUV    
			where pf.CampaniaID =@CampaniaID and pc.AnoCampania=@CampaniaID_
       ) T   where T.CampaniaID = @CampaniaID
)         
, ProdFaltante (RowNumber,List_TotalRegistros,CampaniaID,CUV,Descripcion,Estado,NombreImagen  )    
 as     
(    
          select       
          row_number() over(' + @OrderBy + N'),    
          count(*) over (),    
          CampaniaID,    
          CUV,       
          Descripcion,    
          Estado  ,
		  NombreImagen  
          from ProdUnion    
)        
     select RowNumber, 
   List_TotalNumeroPagina = (List_TotalRegistros - 1) / @RegistrosPorPagina + 1,    
   List_TotalRegistros,    
      CampaniaID,    
      CUV,       
      Descripcion,    
      Estado  ,
	  NombreImagen  
     from ProdFaltante' +        
     case @FlagPaginacion when 1 then ' WHERE RowNumber BETWEEN @FirstRow AND @LastRow;' else ';' end    
 declare @paramDef nvarchar(max) = N' @RegistrosPorPagina int,    
          @FirstRow int,    
          @LastRow int,       
          @CUV varchar(6),    
          @Descripcion varchar(100),    
          @CampaniaID int,
		  @NombreImagen varchar(500),
		  @CampaniaID_ int'      
 exec sys.sp_executesql @Query,    
      @paramDef,    
      @RegistrosPorPagina,    
      @FirstRow,    
      @LastRow,       
      @CUV,    
      @Descripcion,    
      @CampaniaID,
	  @NombreImagen ,
	  @CampaniaID_   
END
GO