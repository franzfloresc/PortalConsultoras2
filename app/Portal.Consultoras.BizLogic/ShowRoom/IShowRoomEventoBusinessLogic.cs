using System.Collections.Generic;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ShowRoom;

namespace Portal.Consultoras.BizLogic
{
    public interface IShowRoomEventoBusinessLogic
    {
        int CantidadPedidoByConsultoraShowRoom(BEOfertaProducto entidad);
        int CargarMasivaConsultora(int paisID, List<BEShowRoomEventoConsultora> listaConsultora);
        int CargarMasivaDescripcionSets(int paisID, int campaniaID, string usuarioCreacion, List<BEShowRoomOfertaDetalle> listaShowRoomOfertaDetalle, string nombreArchivoCargado, string nombreArchivoGuardado);
        int CargarProductoCpc(int paisId, int eventoId, string usuarioCreacion, List<BEShowRoomCompraPorCompra> listaShowRoomCompraPorCompra);
        void DeleteInsertShowRoomCategoriaByEvento(int paisId, int eventoId, List<BEShowRoomCategoria> listaCategoria);
        int DelOfertaShowRoom(int paisID, BEShowRoomOferta entity);
        int DeshabilitarShowRoomEvento(int paisID, BEShowRoomEvento beShowRoomEvento);
        int EliminarEstrategiaProductoAll(int paisID, int estrategiaID, string usuario);
        int EliminarOfertaShowRoomDetalle(int paisID, BEShowRoomOfertaDetalle beShowRoomOfertaDetalle);
        int EliminarOfertaShowRoomDetalleAll(int paisID, int campaniaID, string cuv);
        int EliminarShowRoomEvento(int paisID, BEShowRoomEvento beShowRoomEvento);
        int ExisteShowRoomTipoOferta(int paisId, BEShowRoomTipoOferta entity);
        bool GetEventoConsultoraRecibido(int paisID, string CodigoConsultora, int CampaniaID);
        int GetOrdenPriorizacionShowRoom(int paisID, int ConfiguracionOfertaID, int CampaniaID);
        List<BEShowRoomOferta> GetProductosCompraPorCompra(int paisId, int EventoID, int CampaniaID);
        IList<BEShowRoomOferta> GetProductosShowRoom(int paisID, int campaniaID);
        IList<BEShowRoomOfertaDetalle> GetProductosShowRoomDetalle(int paisID, int campaniaId, string cuv);
        BEShowRoomCategoria GetShowRoomCategoriaById(int paisId, int categoriaId);
        List<BEShowRoomCategoria> GetShowRoomCategorias(int paisId, int eventoId);
        BEShowRoomEventoConsultora GetShowRoomConsultora(int paisID, int campaniaID, string codigoConsultora, bool tienePersonalizacion);
        BEShowRoomEvento GetShowRoomEventoByCampaniaID(int paisID, int campaniaID);
        IList<BEShowRoomNivel> GetShowRoomNivel(int paisId);
        BEShowRoomOferta GetShowRoomOfertaById(int paisID, int ofertaShowRoomID);
        IList<BEShowRoomOferta> GetShowRoomOfertasConsultora(int paisID, int campaniaID, string codigoConsultora);
        IList<BEShowRoomPerfil> GetShowRoomPerfiles(int paisId, int eventoId);
        IList<BEShowRoomPerfilOferta> GetShowRoomPerfilOfertaCuvs(int paisId, BEShowRoomPerfilOferta beShowRoomPerfilOferta);
        IList<BEShowRoomPersonalizacion> GetShowRoomPersonalizacion(int paisId);
        IList<BEShowRoomPersonalizacionNivel> GetShowRoomPersonalizacionNivel(int paisId, int eventoId, int nivelId, int categoriaId);
        IList<BEShowRoomTipoOferta> GetShowRoomTipoOferta(int paisId);
        int GetStockOfertaShowRoom(int paisID, int CampaniaID, string CUV);
        int GetUnidadesPermitidasByCuvShowRoom(int paisID, int CampaniaID, string CUV);
        int GuardarImagenShowRoom(int paisID, int eventoId, string nombreImagenFinal, int tipo, string usuarioModificacion);
        void GuardarPerfilOfertaShowRoom(int paisId, int perfilId, int eventoId, int campaniaId, string cadenaCuv);
        void HabilitarShowRoomTipoOferta(int paisId, BEShowRoomTipoOferta entity);
        int InsertShowRoomEvento(int paisID, BEShowRoomEvento beShowRoomEvento);
        int InsertShowRoomPersonalizacionNivel(int paisID, BEShowRoomPersonalizacionNivel entity);
        int InsertShowRoomTipoOferta(int paisId, BEShowRoomTipoOferta entity);
        int InsOfertaShowRoom(int paisID, BEShowRoomOferta entity);
        int InsOfertaShowRoomDetalle(int paisID, BEShowRoomOfertaDetalle entity);
        int InsOrUpdOfertaShowRoom(int paisID, BEShowRoomOferta entity);
        int RemoverOfertaShowRoom(int paisID, BEShowRoomOferta entity);
        int ShowRoomProgramarAviso(int paisID, BEShowRoomEventoConsultora entity);
        void UpdateShowRoomConsultoraMostrarPopup(int paisID, int campaniaID, string codigoConsultora, bool mostrarPopup);
        void UpdateShowRoomDescripcionCategoria(int paisId, BEShowRoomCategoria categoria);
        void UpdateShowRoomEvento(int paisID, BEShowRoomEvento beShowRoomEvento);
        int UpdateShowRoomPersonalizacionNivel(int paisID, BEShowRoomPersonalizacionNivel entity);
        int UpdateShowRoomTipoOferta(int paisId, BEShowRoomTipoOferta entity);
        int UpdEventoConsultoraPopup(int paisID, BEShowRoomEventoConsultora entity, string tipo);
        int UpdOfertaShowRoom(int paisID, BEShowRoomOferta entity);
        int UpdOfertaShowRoomDetalle(int paisID, BEShowRoomOfertaDetalle entity);
        int UpdOfertaShowRoomStockMasivo(int paisID, List<BEShowRoomOferta> stockProductos);
        int UpdShowRoomEventoConsultoraEmailRecibido(int paisID, BEShowRoomEventoConsultora entity);
        int ValidadStockOfertaShowRoom(int paisID, BEShowRoomOferta entity);
        int ValidarPriorizacionShowRoom(int paisID, int ConfiguracionOfertaID, int CampaniaID, int Orden);
        int ValidarUnidadesPermitidasEnPedidoShowRoom(int paisID, int CampaniaID, string CUV, long ConsultoraID);
    }
}