using System.Collections.Generic;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public interface IOfertaProductoBusinessLogic
    {
        int ActualizarItemsMostrarLiquidacion(int PaisID, int Cantidad);
        int ActualizarItemsMostrarZA(int PaisID, int Cantidad);
        int CantidadPedidoByConsultora(BEOfertaProducto entidad);
        List<BEOfertaProducto> ConsultarLiquidacionByCUV(BEOfertaProducto entidad);
        int DelConfiguracionOferta(int PaisID, int ConfiguracionOfertaID);
        int DelOfertaProducto(BEOfertaProducto entity);
        int EliminarTallaColor(BEOfertaProducto entidad);
        IList<BEConfiguracionOferta> GetConfiguracionOfertaAdministracion(int PaisID, int TipoOfertaSisID);
        IList<BEAdministracionOfertaProducto> GetDatosAdmStockMinimoCorreos(int paisID);
        IList<BEAdministracionOfertaProducto> GetDatosAdmStockMinimoCorreosZA(int paisID, int TipoOfertaSisID);
        IList<BEMatrizComercialImagen> GetImagenByNemotecnico(int paisID, int idMatrizImagen, string cuv2, string codigoSAP, int estrategiaID, int campaniaID, int tipoEstrategiaID, string nemotecnico, int tipoBusqueda, int numeroPagina, int registros);
        IList<BEMatrizComercial> GetImagenesByCodigoSAP(int paisID, string codigoSAP);
        IList<BEMatrizComercialImagen> GetImagenesByCodigoSAP(int paisID, string codigoSAP, int numeroPagina, int registros);
        IList<BEMatrizComercial> GetMatrizComercialByCodigoSAP(int paisID, string codigoSAP);
        IList<BEMatrizComercialImagen> GetMatrizComercialImagenByIdMatrizImagen(int paisID, int idMatrizComercial, int numeroPagina, int registros);
        IList<BEOfertaProducto> GetOfertaProductosPortal(int PaisID, int TipoOfertaSisID, int DuplaConsultora, int CodigoCampania);
        IList<BEOfertaProducto> GetOfertaProductosPortal2(int PaisID, int TipoOfertaSisID, int DuplaConsultora, int CodigoCampania, int Offset, int CantidadRegistros);
        int GetOrdenPriorizacion(int paisID, int ConfiguracionOfertaID, int CampaniaID);
        IList<BEOfertaProducto> GetProductosByTipoOferta(int paisID, int TipoOfertaSisID, int CampaniaID, string CodigoOferta);
        IList<BEOfertaProducto> GetProductosOfertaByCUVCampania(int paisID, int TipoOfertaSisID, int CampaniaID, string CUV);
        int GetStockOfertaProductoLiquidacion(int paisID, int CampaniaID, string CUV);
        List<BEOfertaProducto> GetTallaColor(BEOfertaProducto entidad);
        IList<BEConfiguracionOferta> GetTipoOfertasAdministracion(int paisID, int TipoOfertaSisID);
        int GetUnidadesPermitidasByCuv(int paisID, int CampaniaID, string CUV);
        int GetUnidadesPermitidasByCuvZA(int paisID, int CampaniaID, string CUV, int TipoOfertaSisID);
        int InsAdministracionStockMinimo(BEAdministracionOfertaProducto entity);
        int InsAdministracionStockMinimoZA(BEAdministracionOfertaProducto entity);
        int InsConfiguracionOferta(BEConfiguracionOferta entidad);
        int InsertTallaColorCUV(BEOfertaProducto entidad);
        int InsMatrizComercial(BEMatrizComercial entity);
        int InsMatrizComercialImagen(BEMatrizComercialImagen entity);
        int InsOfertaProducto(BEOfertaProducto entity);
        void InsPedidoWebDetalleOferta(BEPedidoWebDetalle pedidowebdetalle);
        int InsStockCargaLog(BEStockCargaLog entity);
        int ObtenerMaximoItemsaMostrarLiquidacion(int PaisID);
        int ObtenerMaximoItemsaMostrarZA(int PaisID);
        int RemoverOfertaLiquidacion(BEOfertaProducto entity);
        int UpdAdministracionStockMinimo(BEAdministracionOfertaProducto entity);
        int UpdAdministracionStockMinimoZA(BEAdministracionOfertaProducto entity);
        int UpdConfiguracionOferta(BEConfiguracionOferta entidad);
        int UpdMatrizComercial(BEMatrizComercial entity);
        int UpdMatrizComercialDescripcionComercial(BEMatrizComercialImagen entity);
        int UpdMatrizComercialDescripcionMasivo(int paisID, List<BEMatrizComercial> lstmatriz, string UsuarioRegistro);
        int UpdMatrizComercialImagen(BEMatrizComercialImagen entity);
        int UpdMatrizComercialNemotecnico(BEMatrizComercialImagen entity);
        int UpdOfertaProducto(BEOfertaProducto entity);
        int UpdOfertaProductoStockMasivo(int paisID, List<BEOfertaProducto> stockProductos);
        void UpdPedidoWebDetalleOferta(BEPedidoWebDetalle pedidowebdetalle);
        int ValidarCodigoOfertaAdministracion(int PaisID, string CodigoOferta);
        int ValidarPriorizacion(int paisID, int ConfiguracionOfertaID, int CampaniaID, int Orden);
        int ValidarUnidadesPermitidasEnPedido(int PaisID, int CampaniaID, string CUV, long ConsultoraID);
        int ValidarUnidadesPermitidasEnPedidoZA(int PaisID, int CampaniaID, string CUV, long ConsultoraID, int TipoOfertaSisID);
    }
}