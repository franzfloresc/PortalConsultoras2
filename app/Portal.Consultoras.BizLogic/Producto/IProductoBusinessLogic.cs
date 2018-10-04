using System.Collections.Generic;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities.ProgramaNuevas;

namespace Portal.Consultoras.BizLogic
{
    public interface IProductoBusinessLogic
    {
        IList<BEProducto> GetListBrothersByCUV(int paisID, int codCampania, string cuv);
        string GetNombreProducto048ByCuv(int paisID, int campaniaID, string cuv);
        IList<BEProductoAppCatalogo> GetNombreProducto048ByListaCUV(int paisID, int campaniaID, string listaCUV);
        BEProductoDescripcion GetProductoByCampaniaCuv(int paisID, int anioCampania, string codigoZona, string codigoVenta);
        IList<BEProducto> GetProductoComercialByListaCuv(int paisID, int campaniaID, int regionID, int zonaID, string codigoRegion, string codigoZona, string listaCuv);

        IList<BEProductoDescripcion> GetProductoComercialByPaisAndCampania(int campaniaID, string codigo, int paisID, int rowCount);
        BEProductoCompartido GetProductoCompartido(int paisID, int ProCompID);
        List<BEProductoDescripcion> GetProductoDescripcionByCUVandCampania(int paisID, int campaniaID, string CUV);
        IList<BEProductoDescripcion> GetProductosByCampaniaCuv(int paisID, int anioCampania, string codigoVenta);
        IList<BEProducto> GetProductoSugeridoByCUV(int paisID, int campaniaID, int consultoraID, string cuv, int regionID, int zonaID, string codigoRegion, string codigoZona);
        int InsProductoCompartido(BEProductoCompartido ProComp);
        IList<BEProducto> SearchListProductoChatbotByCampaniaRegionZona(string paisISO, int campaniaID, int regionID, int zonaID, string codigoRegion, string codigoZona, string textoBusqueda, int criterio, int rowCount);
        IList<BEProducto> SearchSmartListProductoByCampaniaRegionZonaDescripcion(string paisISO, int campaniaID, int zonaID, string codigoRegion, string codigoZona, string textoBusqueda, int rowCount);
        IList<BEProducto> SelectProductoByCodigoDescripcion(int paisID, int campaniaID, string codigoDescripcion, int criterio, int rowCount);
        IList<BEProducto> SelectProductoByCodigoDescripcionSearch(int paisID, int campaniaID, string codigoDescripcion, int criterio, int rowCount);
        IList<BEProducto> SelectProductoByCodigoDescripcionSearchRegionZona(int paisID, int campaniaID, string codigoDescripcion, int RegionID, int ZonaID, string CodigoRegion, string CodigoZona, int criterio, int rowCount, bool validarOpt);
        IList<BEProducto> SelectProductoByListaCuvSearchRegionZona(int paisID, int campaniaID, string listaCuv, int regionID, int zonaID, string codigoRegion, string codigoZona, bool validarOpt);
        IList<BEProducto> SelectProductoToKitInicio(int paisID, int campaniaID, string cuv);
        int UpdProductoDescripcion(BEProductoDescripcion producto, string codigoUsuario);
        Enumeradores.ValidacionProgramaNuevas ValidarBusquedaProgramaNuevas(int paisID, int campaniaID, int ConsultoraID, string codigoPrograma, int consecutivoNueva, string cuv);
        int ValidarCantidadMaximaProgramaNuevas(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma, int cantidadEnPedido, string cuvIngresado, int cantidadIngresada);
        BERespValidarElectivos ValidaCuvElectivo(int paisID, int campaniaID, string cuvIngresado, int consecutivoNueva, string codigoPrograma, List<string> lstCuvPedido);
        bool EsCuvDuoPerfecto(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma, string cuv);
        bool TieneListaDuoPerfecto(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma, List<string> lstCuv);
        Enumeradores.ValidacionVentaExclusiva ValidarVentaExclusiva(int paisID, int campaniaID, string codigoConsultora, string cuv);
    }
}