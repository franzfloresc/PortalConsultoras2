using Portal.Consultoras.Entities;
using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.ServiceModel;
using Portal.Consultoras.Entities.ProgramaNuevas;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface IODSService
    {
        [OperationContract]
        IList<BEProducto> GetProductoComercialByListaCuv(int paisID, int campaniaID, int regionID, int zonaID, string codigoRegion, string codigoZona, string listaCuv);

        [OperationContract]
        IList<BEProductoDescripcion> GetProductoComercialByPaisAndCampania(int CampaniaID, string codigo, int paisID, int rowCount);

        [OperationContract]
        IList<BEProducto> SelectProductoByCodigoDescripcion(int paisID, int campaniaID, string codigoDescripcion, int criterio, int rowCount);

        [OperationContract]
        IList<BEProducto> SelectProductoByCodigoDescripcionSearchRegionZona(int paisID, int campaniaID,
            string codigoDescripcion, int RegionID, int ZonaID, string CodigoRegion, string CodigoZona, int criterio,
            int rowCount, bool validarOpt);

        [OperationContract]
        IList<BEProducto> SearchListProductoChatbotByCampaniaRegionZona(string paisISO, int campaniaID,
            int RegionID, int ZonaID, string CodigoRegion, string CodigoZona, string textoBusqueda, int criterio, int rowCount);

        [OperationContract]
        IList<BEProducto> SearchSmartListProductoByCampaniaRegionZonaDescripcion(string paisISO, int campaniaID,
            int zonaID, string codigoRegion, string codigoZona, string textoBusqueda, int rowCount);

        [OperationContract]
        IList<BEProducto> SelectProductoByListaCuvSearchRegionZona(int paisID, int campaniaID,
        string codigoDescripcion, int regionID, int zonaID, string codigoRegion, string codigoZona, bool validarOpt);

        [OperationContract]
        IList<BEConsultoraCodigo> SelectConsultoraCodigo(int paisID, int regionID, int zonaID, string codigo, int rowCount);

        [OperationContract]
        IList<BEConsultoraCodigo> SelectConsultoraByCodigo(int paisID, string codigo);

        [OperationContract]
        IList<BEConsultoraCodigo> SelectConsultoraCodigo_A(int paisID, string codigo, int rowCount);

        [OperationContract]
        IList<BEConsultora> SelectConsultoraByID(int paisID, Int64 ConsultoraID);

        [OperationContract]
        IList<BEComprobantePercepcion> SelectComprobantePercepcion(int paisID, long ConsultoraID);

        [OperationContract]
        IList<BEComprobantePercepcionDetalle> SelectComprobantePercepcionDetalle(int paisID, int IdComprobantePercepcion);

        [OperationContract]
        void LoadConsultoraCodigo(int paisID);

        [OperationContract]
        decimal GetSaldoActualConsultora(int paisID, string Codigo);        

        [OperationContract]
        IList<BEMensajeCUV> GetMensajesCUVsByPaisAndCampania(int CampaniaID, int paisID);

        [OperationContract]
        bool SetMensajesCUVsByPaisAndCampania(int parametroID, int paisID, int campaniaID, string mensaje, string cuvs);

        [OperationContract]
        void DeleteMensajesCUVsByPaisAndCampania(int parametroID, int paisID);

        [OperationContract]
        BEMensajeCUV GetMensajeByCUV(int paisID, int campaniaID, string cuv);

        [OperationContract]
        long GetConsultoraIdByCodigo(int paisID, string CodigoConsultora);

        [OperationContract]
        IList<BEProducto> GetValidarCUVMisPedidos(int PaisID, int Campania, string InputCUV, int RegionID, int ZonaID, string CodigoRegion, string CodigoZona);


        #region Digitacion Distribuida

        #region Consultoras

        [OperationContract]
        IList<BEConsultoraDD> SelectConsultoraDatos(int paisID, string codigoZona, string codigoSeccion, string codigoConsultora, string nombreConsultora);

        [OperationContract]
        BEConsultoraDD GetConsultoraByCodigo(int paisID, string codigo);

        [OperationContract]
        BEConsultoraDD GetConsultoraByCodigoByZona(int paisID, string codigo, string codigoZona);

        [OperationContract]
        BEConsultoraDD GetConsultoraByNumeroDocumento(int paisID, string numeroDocumento);

        #endregion

        #region Producto Comercial

        [OperationContract]
        IList<BEProductoDescripcion> GetProductosByCampaniaCuv(int paisID, int anioCampania, string codigoVenta);

        [OperationContract]
        BEProductoDescripcion GetProductoByCampaniaCuv(int paisID, int anioCampania, string codigoZona, string codigoVenta);

        #endregion

        #region Tipo de Meta

        [OperationContract]
        List<BETipoMeta> GetTipoMeta(int paisID);

        [OperationContract]
        BETipoMeta GetTipoMetaPorCodigo(int paisID, string tipoMeta);

        #endregion

        #region Ubigeo

        [OperationContract]
        BEUbigeo GetUbigeoPorCodigoTerritorio(int paisID, string codigoZona, string codigoTerritorio);


        [OperationContract]
        BEUbigeo GetUbigeoPorCodigoUbigeo(int paisID, string codigoUbigeo);

        #endregion

        #endregion

        #region Productos Sugeridos

        [OperationContract]
        IList<BEProducto> GetProductoSugeridoByCUV(int paisID, int campaniaID, int consultoraID, string cuv, int regionID, int zonaID, string codigoRegion, string codigoZona);

        #endregion

        [OperationContract]
        IList<BEProducto> SelectProductoToKitInicio(int paisID, int campaniaID, string cuv);

        [OperationContract]
        string GetNombreProducto048ByCuv(int paisID, int campaniaId, string cuv);

        [OperationContract]
        IList<BEProductoAppCatalogo> GetNombreProducto048ByListaCUV(int paisID, int campaniaId, string listaCUV);

        [OperationContract]
        int InsProductoCompartido(BEProductoCompartido ProComp);

        [OperationContract]
        BEProductoCompartido GetProductoCompartido(int paisID, int ProCompID);

        [OperationContract]
        IList<BEProducto> GetListBrothersByCUV(int paisID, int codCampania, string cuv);

        #region ProgramaNuevas
        [OperationContract]
        Enumeradores.ValidacionProgramaNuevas ValidarBusquedaProgramaNuevas(int paisID, int campaniaID, int ConsultoraID, string codigoPrograma, int consecutivoNueva, string cuv);

        [OperationContract]
        int ValidarCantidadMaximaProgramaNuevas(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma, int cantidadEnPedido, string cuvIngresado, int cantidadIngresada);

        [OperationContract]
        Enumeradores.ValidarCuponesElectivos ValidaCuvElectivo(int paisID, int campaniaID, string cuvIngresado, int consecutivoNueva, string codigoPrograma, int CantidadElectivosPedido);
        #endregion

        #region ValidarVentaExclusiva
        [OperationContract]
        Enumeradores.ValidacionVentaExclusiva ValidarVentaExclusiva(int paisID, int campaniaID, string codigoConsultora, string cuv);
        #endregion
    }
}