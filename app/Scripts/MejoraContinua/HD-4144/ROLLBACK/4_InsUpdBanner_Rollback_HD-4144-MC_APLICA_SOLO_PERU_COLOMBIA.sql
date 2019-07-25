CREATE PROCEDURE InsUpdBanner

 @CampaniaID int,

 @BannerID int,

 @GrupoBannerID int,

 @Orden int,

 @Titulo varchar(50),

 @Archivo varchar(200),

 @URL varchar(300),

 @FlagGrupoConsultora bit,

 @FlagConsultoraNueva bit,

 @BannerIDOut int output,

 @Paises dbo.ListOfValues readonly,

 @UdpSoloBanner bit = 0,

 @TipoContenido int,

 @PaginaNueva int,

 @TituloComentario varchar(120) = null,

 @TextoComentario varchar(120) = null,

 @TipoAccion int,

 @CuvPedido varchar(50) = null,

 @CantCuvPedido int



as

begin try

 begin tran

 if (select count(*) where @URL like '%https://www.somosbelcorp.com/Superate/Index?URL=%') = 1

	SET @URL = REPLACE(@URL, '&', '*')



 if(select count(*) from [dbo].[GrupoBanner] where [CampaniaID] = @CampaniaID and [GrupoBannerID] = @GrupoBannerID) = 0

	insert into [dbo].[GrupoBanner]

	(CampaniaID, GrupoBannerID, TiempoRotacion)

	values

	(@CampaniaID, @GrupoBannerID, 1)



 if @BannerID = 0

 begin

  select @BannerID = coalesce(max(BannerID), 0) + 1 from dbo.Banner

  where CampaniaID = @CampaniaID  

  

  insert into dbo.Banner (  

   CampaniaID, BannerID, GrupoBannerID, Orden, Titulo, Archivo, URL, FlagGrupoConsultora, FlagConsultoraNueva, TipoContenido, PaginaNueva,

   TituloComentario, TextoComentario, TipoAccion, CUVpedido, CantCUVpedido)

  values (@CampaniaID, @BannerID, @GrupoBannerID, @Orden, @Titulo, @Archivo, @URL, @FlagGrupoConsultora, @FlagConsultoraNueva, @TipoContenido, @PaginaNueva,

   @TituloComentario, @TextoComentario, @TipoAccion, @CuvPedido, @CantCuvPedido)

 end

 else

 begin

  update dbo.Banner

  set GrupoBannerID = @GrupoBannerID,

   /*Orden = @Orden,*/ Titulo = @Titulo,

   Archivo = @Archivo, URL = @URL,

   FlagGrupoConsultora = @FlagGrupoConsultora,

   FlagConsultoraNueva = @FlagConsultoraNueva,

   TipoContenido = @TipoContenido,

   PaginaNueva = @PaginaNueva,

   TituloComentario = @TituloComentario,

   TextoComentario = @TextoComentario,

   TipoAccion = @TipoAccion,

   CuvPedido = @CuvPedido,

   CantCUVpedido = @CantCuvPedido

  where CampaniaID = @CampaniaID

   and BannerID = @BannerID

  

  if @UdpSoloBanner = 0

  begin  

   delete dbo.BannerPais  

   where CampaniaID = @CampaniaID  

    and BannerID = @BannerID

  end

 end

   

 if @UdpSoloBanner = 0

 begin

  insert into dbo.BannerPais (CampaniaID, BannerID, PaisID)

  select @CampaniaID, @BannerID, cast(Value as tinyint)

  from @Paises

 end

 set @BannerIDOut = @BannerID  

  

 commit tran

end try

begin catch

 rollback tran

 throw

end catch

