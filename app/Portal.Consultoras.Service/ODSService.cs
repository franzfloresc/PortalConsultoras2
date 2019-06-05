﻿using Portal.Consultoras.BizLogic;
using Portal.Consultoras.BizLogic.ArmaTuPack;
using Portal.Consultoras.BizLogic.CaminoBrillante;
using Portal.Consultoras.BizLogic.LimiteVenta;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.CaminoBrillante;
using Portal.Consultoras.Entities.LimiteVenta;
using Portal.Consultoras.Entities.ProgramaNuevas;
using Portal.Consultoras.ServiceContracts;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Service
{
    public class ODSService : IODSService
    {
        private readonly IProductoBusinessLogic BLProducto;
        private readonly IProgramaNuevasBusinessLogic BLProgramaNuevas;
        private readonly IArmaTuPackBusinessLogic BLArmaTuPack;
        private readonly ILimiteVentaBusinessLogic BLLimiteVenta;
        private readonly BLMensajeCUV BLMensajeCUV;
        private readonly BLConsultora BLConsultora;
        private readonly BLTipoMeta BLTipoMeta;
        private readonly BLUbigeo BLUbigeo;
        private readonly ICaminoBrillanteBusinessLogic caminoBrillanteBusinessLogic;

        public ODSService()
        {
            BLProducto = new BLProducto();
            BLProgramaNuevas = new BLProgramaNuevas();
            BLLimiteVenta = new BLLimiteVenta();
            BLMensajeCUV = new BLMensajeCUV();
            BLConsultora = new BLConsultora();
            BLTipoMeta = new BLTipoMeta();
            BLUbigeo = new BLUbigeo();
            BLArmaTuPack = new BLArmaTuPack();
            caminoBrillanteBusinessLogic = new BLCaminoBrillante();
        }

        public IList<BEMensajeCUV> GetMensajesCUVsByPaisAndCampania(int CampaniaID, int paisID)
        {
            return BLMensajeCUV.GetMensajesCUVsByPaisAndCampania(CampaniaID, paisID);
        }

        public bool SetMensajesCUVsByPaisAndCampania(int parametroID, int paisID, int campaniaID, string mensaje, string cuvs)
        {
            return BLMensajeCUV.SetMensajesCUVsByPaisAndCampania(parametroID, paisID, campaniaID, mensaje, cuvs);
        }

        public void DeleteMensajesCUVsByPaisAndCampania(int parametroID, int paisID)
        {
            BLMensajeCUV.DeleteMensajesCUVsByPaisAndCampania(parametroID, paisID);
        }

        public BEMensajeCUV GetMensajeByCUV(int paisID, int campaniaID, string cuv)
        {
            return BLMensajeCUV.GetMensajeByCUV(paisID, campaniaID, cuv);
        }

        public IList<BEProductoDescripcion> GetProductoComercialByPaisAndCampania(int CampaniaID, string codigo, int paisID, int rowCount)
        {
            return BLProducto.GetProductoComercialByPaisAndCampania(CampaniaID, codigo, paisID, rowCount);
        }

        public IList<BEProducto> SelectProductoByCodigoDescripcion(int paisID, int campaniaID, string codigoDescripcion, int criterio, int rowCount)
        {
            return BLProducto.SelectProductoByCodigoDescripcionSearch(paisID, campaniaID, codigoDescripcion, criterio, rowCount);
        }

        public IList<BEConsultoraCodigo> SelectConsultoraCodigo(int paisID, int regionID, int zonaID, string codigo, int rowCount)
        {
            var blConsultora = new BLConsultora();
            return blConsultora.SelectConsultoraCodigo(paisID, regionID, zonaID, codigo, rowCount);
        }

        public IList<BEConsultoraCodigo> SelectConsultoraCodigo_A(int paisID, string codigo, int rowCount)
        {
            var blConsultora = new BLConsultora();
            return blConsultora.SelectConsultoraCodigo(paisID, codigo, rowCount);
        }

        public IList<BEConsultoraCodigo> SelectConsultoraByCodigo(int paisID, string codigo)
        {
            var blConsultora = new BLConsultora();
            return blConsultora.SelectConsultoraCodigo(paisID, codigo);
        }

        public IList<BEConsultora> SelectConsultoraByID(int paisID, Int64 ConsultoraID)
        {
            var blConsultora = new BLConsultora();
            return blConsultora.SelectConsultoraByID(paisID, ConsultoraID);
        }

        public void LoadConsultoraCodigo(int paisID)
        {
            var blConsultora = new BLConsultora();
            blConsultora.LoadConsultoraCodigo(paisID);
        }

        public IList<BEComprobantePercepcion> SelectComprobantePercepcion(int paisID, long ConsultoraID)
        {
            var blComprobantePercepcion = new BLComprobantePercepcion();
            return blComprobantePercepcion.SelectComprobantePercepcion(paisID, ConsultoraID);
        }

        public IList<BEComprobantePercepcionDetalle> SelectComprobantePercepcionDetalle(int paisID, int IdComprobantePercepcion)
        {
            var blComprobantePercepcion = new BLComprobantePercepcion();
            return blComprobantePercepcion.SelectComprobantePercepcionDetalle(paisID, IdComprobantePercepcion);
        }

        public decimal GetSaldoActualConsultora(int paisID, string Codigo)
        {
            return new BLConsultora().GetSaldoActualConsultora(paisID, Codigo);
        }

        public IList<BEProducto> SelectProductoByCodigoDescripcionSearchRegionZona(BEProductoBusqueda busqueda)
        {
            return BLProducto.SelectProductoByCodigoDescripcionSearchRegionZona(busqueda);
        }

        public IList<BEProducto> SearchListProductoChatbotByCampaniaRegionZona(string paisISO, int campaniaID,
            int regionID, int zonaID, string codigoRegion, string codigoZona, string textoBusqueda, int criterio, int rowCount)
        {
            return BLProducto.SearchListProductoChatbotByCampaniaRegionZona(paisISO, campaniaID,
                regionID, zonaID, codigoRegion, codigoZona, textoBusqueda, criterio, rowCount);
        }

        public IList<BEProducto> SearchSmartListProductoByCampaniaRegionZonaDescripcion(string paisISO, int campaniaID,
            int zonaID, string codigoRegion, string codigoZona, string textoBusqueda, int rowCount)
        {
            return BLProducto.SearchSmartListProductoByCampaniaRegionZonaDescripcion(paisISO, campaniaID,
                zonaID, codigoRegion, codigoZona, textoBusqueda, rowCount);
        }

        public IList<BEProducto> SelectProductoByListaCuvSearchRegionZona(int paisID, int campaniaID,
            string listaCuv, int regionID, int zonaID, string codigoRegion, string codigoZona, bool validarOpt)
        {
            return BLProducto.SelectProductoByListaCuvSearchRegionZona(paisID, campaniaID, listaCuv,
                regionID, zonaID, codigoRegion, codigoZona, validarOpt);
        }

        public long GetConsultoraIdByCodigo(int paisID, string CodigoConsultora)
        {
            return BLConsultora.GetConsultoraIdByCodigo(paisID, CodigoConsultora);
        }

        [Obsolete("Migrado PL50-50")]
        public IList<BEProducto> GetProductoComercialByListaCuv(int paisID, int campaniaID, int regionID, int zonaID, string codigoRegion, string codigoZona, string listaCuv)
        {
            return BLProducto.GetProductoComercialByListaCuv(paisID, campaniaID, regionID, zonaID, codigoRegion, codigoZona, listaCuv);
        }

        #region Digitacion Distribuida

        #region Consultoras

        public IList<BEConsultoraDD> SelectConsultoraDatos(int paisID, string codigoZona, string codigoSeccion, string codigoConsultora, string nombreConsultora)
        {
            return BLConsultora.SelectConsultoraDatos(paisID, codigoZona, codigoSeccion, codigoConsultora, nombreConsultora);
        }

        public BEConsultoraDD GetConsultoraByCodigo(int paisID, string codigo)
        {
            return BLConsultora.GetConsultoraByCodigo(paisID, codigo);
        }

        public BEConsultoraDD GetConsultoraByCodigoByZona(int paisID, string codigo, string codigoZona)
        {
            return BLConsultora.GetConsultoraByCodigo(paisID, codigo, codigoZona);
        }

        public BEConsultoraDD GetConsultoraByNumeroDocumento(int paisID, string numeroDocumento)
        {
            return BLConsultora.GetConsultoraByCodigo(paisID, null, null, numeroDocumento);
        }

        #endregion

        #region Producto Comercial

        public IList<BEProductoDescripcion> GetProductosByCampaniaCuv(int paisID, int anioCampania, string codigoVenta)
        {
            return BLProducto.GetProductosByCampaniaCuv(paisID, anioCampania, codigoVenta);
        }

        public BEProductoDescripcion GetProductoByCampaniaCuv(int paisID, int anioCampania, string codigoZona, string codigoVenta)
        {
            return BLProducto.GetProductoByCampaniaCuv(paisID, anioCampania, codigoZona, codigoVenta);
        }

        #endregion

        #region Tipo de Meta

        public List<BETipoMeta> GetTipoMeta(int paisID)
        {
            return BLTipoMeta.GetTipoMeta(paisID);
        }

        public BETipoMeta GetTipoMetaPorCodigo(int paisID, string codigoMeta)
        {
            return BLTipoMeta.GetTipoMetaPorCodigo(paisID, codigoMeta);
        }

        #endregion

        #region Ubigeo

        public BEUbigeo GetUbigeoPorCodigoTerritorio(int paisID, string codigoZona, string codigoTerritorio)
        {
            return BLUbigeo.GetUbigeoPorCodigoTerritorio(paisID, codigoZona, codigoTerritorio);
        }


        public BEUbigeo GetUbigeoPorCodigoUbigeo(int paisID, string codigoUbigeo)
        {
            return BLUbigeo.GetUbigeoPorCodigoUbigeo(paisID, codigoUbigeo);
        }

        #endregion

        #endregion

        #region Producto Sugerido

        public IList<BEProducto> GetProductoSugeridoByCUV(int paisID, int campaniaID, int consultoraID, string cuv, int regionID, int zonaID, string codigoRegion, string codigoZona)
        {
            return BLProducto.GetProductoSugeridoByCUV(paisID, campaniaID, consultoraID, cuv, regionID, zonaID, codigoRegion, codigoZona);
        }

        public IList<BEProducto> GetValidarCUVMisPedidos(int PaisID, int Campania, string InputCUV, int RegionID, int ZonaID, string CodigoRegion, string CodigoZona)
        {
            var blMisPedidos = new BLConsultoraOnline();
            return blMisPedidos.GetValidarCUVMisPedidos(PaisID, Campania, InputCUV, RegionID, ZonaID, CodigoRegion, CodigoZona);
        }

        #endregion

        public IList<BEProducto> SelectProductoToKitInicio(int paisID, int campaniaID, string cuv)
        {
            return BLProducto.SelectProductoToKitInicio(paisID, campaniaID, cuv);
        }

        public string GetNombreProducto048ByCuv(int paisID, int campaniaId, string cuv)
        {
            return BLProducto.GetNombreProducto048ByCuv(paisID, campaniaId, cuv);
        }

        public IList<BEProductoAppCatalogo> GetNombreProducto048ByListaCUV(int paisID, int campaniaId, string listaCUV)
        {
            return BLProducto.GetNombreProducto048ByListaCUV(paisID, campaniaId, listaCUV);
        }

        public BEProductoCompartidoResult InsProductoCompartido(BEProductoCompartido ProComp)
        {
            return BLProducto.InsProductoCompartido(ProComp);
        }

        public BEProductoCompartido GetProductoCompartido(int paisID, int ProCompID)
        {
            return BLProducto.GetProductoCompartido(paisID, ProCompID);
        }

        public IList<BEProducto> GetListBrothersByCUV(int paisID, int codCampania, string cuv)
        {
            return BLProducto.GetListBrothersByCUV(paisID, codCampania, cuv);
        }

        #region Programa Nuevas Activo
        public Enumeradores.ValidacionProgramaNuevas ValidarBusquedaProgramaNuevas(int paisID, int campaniaID, string codigoPrograma, int consecutivoNueva, string cuv)
        {
            return BLProgramaNuevas.ValidarBusquedaCuv(paisID, campaniaID, codigoPrograma, consecutivoNueva, cuv);
        }
        public Dictionary<string, Enumeradores.ValidacionProgramaNuevas> ValidarBusquedaProgramaNuevasList(int paisID, int campaniaID, string codigoPrograma, int consecutivoNueva, List<string> listCuv)
        {
            return BLProgramaNuevas.ValidarBusquedaListCuv(paisID, campaniaID, codigoPrograma, consecutivoNueva, listCuv);
        }

        public int ValidarCantidadMaximaProgramaNuevas(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma, int cantidadEnPedido, string cuvIngresado, int cantidadIngresada)
        {
            return BLProgramaNuevas.ValidarCantidadMaxima(paisID, campaniaID, consecutivoNueva, codigoPrograma, cantidadEnPedido, cuvIngresado, cantidadIngresada);
        }

        public BERespValidarElectivos ValidaCuvElectivo(int paisID, int campaniaID, string cuvIngresado, int consecutivoNueva, string codigoPrograma, List<string> lstCuvPedido)
        {
            return BLProgramaNuevas.ValidaCuvElectivo(paisID, campaniaID, cuvIngresado, consecutivoNueva, codigoPrograma, lstCuvPedido);
        }

        public bool EsCuvElecMultiple(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma, string cuv)
        {
            return BLProgramaNuevas.EsCuvElecMultiple(paisID, campaniaID, consecutivoNueva, codigoPrograma, cuv);
        }

        public bool TieneListaEstrategiaElecMultiple(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma, List<string> lstCuv)
        {
            return BLProgramaNuevas.TieneListaEstrategiaElecMultiple(paisID, campaniaID, consecutivoNueva, codigoPrograma, lstCuv);
        }

        public int GetLimElectivosProgNuevas(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma)
        {
            return BLProgramaNuevas.GetLimElectivos(paisID, campaniaID, consecutivoNueva, codigoPrograma);
        }

        public List<BEProductoEstraProgNuevas> GetListCuvProgNuevasEstrategia(BEConsultoraProgramaNuevas consultoraNueva)
        {
            return BLProgramaNuevas.GetListCuvEstrategia(consultoraNueva);
        }
        #endregion

        #region VentaExclusiva
        public Enumeradores.ValidacionVentaExclusiva ValidarVentaExclusiva(int paisID, int campaniaID, string codigoConsultora, string cuv)
        {
            return BLProducto.ValidarVentaExclusiva(paisID, campaniaID, codigoConsultora, cuv);
        }
        #endregion

        #region ArmaTuPack
        public bool CuvArmaTuPackEstaEnLimite(int paisID, int campaniaID, string zona, string cuv, int cantidadIngresada, int cantidadActual)
        {
            return BLArmaTuPack.CuvEstaEnLimite(paisID, campaniaID, zona, cuv, cantidadIngresada, cantidadActual);
        }
        #endregion
        
        #region LimiteVenta
        public BERespValidarLimiteVenta CuvTieneLimiteVenta(int paisID, int campaniaID, string region, string zona, string cuv, int cantidadIngresada, int cantidadActual)
        {
            return BLLimiteVenta.CuvTieneLimiteVenta(paisID, campaniaID, region, zona, cuv, cantidadIngresada, cantidadActual);
        }
        #endregion

        public List<BEPremioNuevas> ListarPremioNuevasPaginado(BEPremioNuevas premio)
        {
            return BLProgramaNuevas.ListarPremioNuevasPaginado(premio);
        }

        public BEPremioNuevas Insertar(BEPremioNuevas premio)
        {
            return BLProgramaNuevas.Insertar(premio);
        }
        public BEPremioNuevas Editar(BEPremioNuevas premio)
        {
            return BLProgramaNuevas.Editar(premio);
        }

        #region ProgramaNuevas
        public BEValidacionCaminoBrillante ValidarBusquedaCaminoBrillante(BEUsuario entidad, string cuv) {
            return caminoBrillanteBusinessLogic.ValidarBusquedaCaminoBrillante(entidad, cuv);
        }
        #endregion

    }
}