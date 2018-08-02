using System.Collections.Generic;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ShowRoom;

namespace Portal.Consultoras.BizLogic
{
    public interface IShowRoomEventoBusinessLogic
    {
        int CantidadPedidoByConsultoraShowRoom(BEOfertaProducto entidad);
        int CargarMasivaConsultora(int paisID, List<BEShowRoomEventoConsultora> listaConsultora);
        
        int CargarProductoCpc(int paisId, int eventoId, string usuarioCreacion, List<BEShowRoomCompraPorCompra> listaShowRoomCompraPorCompra);
        void DeleteInsertShowRoomCategoriaByEvento(int paisId, int eventoId, List<BEShowRoomCategoria> listaCategoria);
        
        int DeshabilitarShowRoomEvento(int paisID, BEShowRoomEvento beShowRoomEvento);
        int EliminarEstrategiaProductoAll(int paisID, int estrategiaID, string usuario);

        int EliminarShowRoomEvento(int paisID, BEShowRoomEvento beShowRoomEvento);
        int ExisteShowRoomTipoOferta(int paisId, BEShowRoomTipoOferta entity);
        bool GetEventoConsultoraRecibido(int paisID, string CodigoConsultora, int CampaniaID);
        
        IList<BEShowRoomOfertaDetalle> GetProductosShowRoomDetalle(int paisID, int campaniaId, string cuv);
        BEShowRoomCategoria GetShowRoomCategoriaById(int paisId, int categoriaId);
        List<BEShowRoomCategoria> GetShowRoomCategorias(int paisId, int eventoId);
        BEShowRoomEventoConsultora GetShowRoomConsultora(int paisID, int campaniaID, string codigoConsultora, bool tienePersonalizacion);
        BEShowRoomEvento GetShowRoomEventoByCampaniaID(int paisID, int campaniaID);
        IList<BEShowRoomNivel> GetShowRoomNivel(int paisId);
        BEShowRoomOferta GetShowRoomOfertaById(int paisID, int ofertaShowRoomID);
        
        IList<BEShowRoomPerfil> GetShowRoomPerfiles(int paisId, int eventoId);
        
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
        
        int ShowRoomProgramarAviso(int paisID, BEShowRoomEventoConsultora entity);
        void UpdateShowRoomConsultoraMostrarPopup(int paisID, int campaniaID, string codigoConsultora, bool mostrarPopup);
        void UpdateShowRoomDescripcionCategoria(int paisId, BEShowRoomCategoria categoria);
        void UpdateShowRoomEvento(int paisID, BEShowRoomEvento beShowRoomEvento);
        int UpdateShowRoomPersonalizacionNivel(int paisID, BEShowRoomPersonalizacionNivel entity);
        int UpdateShowRoomTipoOferta(int paisId, BEShowRoomTipoOferta entity);
        int UpdEventoConsultoraPopup(int paisID, BEShowRoomEventoConsultora entity, string tipo);
        
        int UpdShowRoomEventoConsultoraEmailRecibido(int paisID, BEShowRoomEventoConsultora entity);

        int ValidarUnidadesPermitidasEnPedidoShowRoom(int paisID, int CampaniaID, string CUV, long ConsultoraID);
    }
}