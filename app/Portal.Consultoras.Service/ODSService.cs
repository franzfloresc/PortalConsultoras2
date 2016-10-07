﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Entities;
using Portal.Consultoras.BizLogic;
using Portal.Consultoras.ServiceContracts;

namespace Portal.Consultoras.Service
{
    public class ODSService : IODSService
    {
        private BLProducto BLProducto;
        private BLMensajeCUV BLMensajeCUV;
        private BLConsultora BLConsultora;
        private BLTipoMeta BLTipoMeta;
        private BLUbigeo BLUbigeo;

        public ODSService()
        {
            BLProducto = new BLProducto();
            BLMensajeCUV = new BLMensajeCUV();
            BLConsultora = new BLConsultora();
            BLTipoMeta = new BLTipoMeta();
            BLUbigeo = new BLUbigeo();
        }

        // Nueva funcionalidad para la parametrización de CUVs
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
            //return BLProducto.SelectProductoByCodigoDescripcion(paisID, campaniaID, codigoDescripcion, criterio, rowCount);
            return BLProducto.SelectProductoByCodigoDescripcionSearch(paisID, campaniaID, codigoDescripcion, criterio, rowCount);
        }

        public IList<BEConsultoraCodigo> SelectConsultoraCodigo(int paisID, int regionID, int zonaID, string codigo, int rowCount)
        {
            var BLConsultora = new BLConsultora();
            return BLConsultora.SelectConsultoraCodigo(paisID, regionID, zonaID, codigo, rowCount);
        }

        public IList<BEConsultoraCodigo> SelectConsultoraCodigo_A(int paisID, string codigo, int rowCount)
        {
            var BLConsultora = new BLConsultora();
            return BLConsultora.SelectConsultoraCodigo(paisID, codigo, rowCount);
        }

        public IList<BEConsultoraCodigo> SelectConsultoraByCodigo(int paisID, string codigo)
        {
            var BLConsultora = new BLConsultora();
            return BLConsultora.SelectConsultoraCodigo(paisID, codigo);
        }

        public IList<BEConsultora> SelectConsultoraByID(int paisID, Int64 ConsultoraID)
        {
            var BLConsultora = new BLConsultora();
            return BLConsultora.SelectConsultoraByID(paisID, ConsultoraID);
        }

        public void LoadConsultoraCodigo(int paisID)
        {
            var BLConsultora = new BLConsultora();
            BLConsultora.LoadConsultoraCodigo(paisID);
        }

        public IList<BEComprobantePercepcion> SelectComprobantePercepcion(int paisID, long ConsultoraID)
        {
            var BLComprobantePercepcion = new BLComprobantePercepcion();
            return BLComprobantePercepcion.SelectComprobantePercepcion(paisID, ConsultoraID);
        }

        public IList<BEComprobantePercepcionDetalle> SelectComprobantePercepcionDetalle(int paisID, int IdComprobantePercepcion)
        {
            var BLComprobantePercepcion = new BLComprobantePercepcion();
            return BLComprobantePercepcion.SelectComprobantePercepcionDetalle(paisID, IdComprobantePercepcion);
        }

        public decimal GetSaldoActualConsultora(int paisID, string Codigo)
        {
            return new BLConsultora().GetSaldoActualConsultora(paisID, Codigo);
        }


        public IList<BEProducto> SelectProductoByCodigoDescripcionSearchRegionZona(int paisID, int campaniaID, string codigoDescripcion, int RegionID, int ZonaID, string CodigoRegion, string CodigoZona, int criterio, int rowCount)
        {
            return BLProducto.SelectProductoByCodigoDescripcionSearchRegionZona(paisID, campaniaID, codigoDescripcion, RegionID, ZonaID, CodigoRegion, CodigoZona, criterio, rowCount);
        }

        public long GetConsultoraIdByCodigo(int paisID, string CodigoConsultora)
        {
            return BLConsultora.GetConsultoraIdByCodigo(paisID, CodigoConsultora);
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
            var BLMisPedidos = new BLConsultoraOnline();
            return BLMisPedidos.GetValidarCUVMisPedidos(PaisID, Campania, InputCUV, RegionID, ZonaID, CodigoRegion, CodigoZona);
        }

        #endregion

        public IList<BEProducto> SelectProductoToKitInicio(int paisID, int campaniaID, string cuv)
        {
            return BLProducto.SelectProductoToKitInicio(paisID, campaniaID, cuv);
        }
    }
}
