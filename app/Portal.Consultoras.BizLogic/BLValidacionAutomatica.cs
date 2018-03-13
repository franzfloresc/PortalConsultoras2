using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLValidacionAutomatica
    {
        public BEValidacionMovil InsValidacionMovilPROLLog(BEValidacionMovil oBEValidacionMovil)
        {
            BEValidacionMovil result = null;
            var daValidacionMovil = new DAValidacionAutomatica(oBEValidacionMovil.PaisId);

            using (IDataReader reader = daValidacionMovil.InsValidacionMovilPROLLog(oBEValidacionMovil))
            {
                if (reader.Read())
                {
                    result = new BEValidacionMovil(reader);
                }
            }

            return result;
        }

        public void UpdValidacionMovilPROLLog(BEValidacionMovil oBEValidacionMovil)
        {
            var daValidacionMovil = new DAValidacionAutomatica(oBEValidacionMovil.PaisId);
            daValidacionMovil.UpdValidacionMovilPROLLog(oBEValidacionMovil);
        }

        public string GetValidacionMovilPROLLog(BEValidacionMovil oBEValidacionMovil)
        {
            var daValidacionMovil = new DAValidacionAutomatica(oBEValidacionMovil.PaisId);
            return daValidacionMovil.GetValidacionMovilPROLLog(oBEValidacionMovil);
        }

        public void UpdValAutoPROLPedidoWeb(int PaisId, int CampaniaId, int PedidoId, int EstadoPedido, bool ItemsEliminados, decimal montoTotalProl, decimal descuentoProl)
        {
            var daValidacionMovil = new DAValidacionAutomatica(PaisId);
            daValidacionMovil.UpdValAutoPROLPedidoWeb(CampaniaId, PedidoId, EstadoPedido, ItemsEliminados, montoTotalProl, descuentoProl);
        }

        public void InsPedidoWebAccionesPROLAuto(int PaisId, BEAccionesPROL oBEAccionesPROL)
        {
            var daValidacionMovil = new DAValidacionAutomatica(PaisId);
            daValidacionMovil.InsPedidoWebAccionesPROLAuto(oBEAccionesPROL);
        }

        public void DelPedidoWebDetalleValAuto(int PaisId, int CampaniaID, int PedidoID, int PedidoDetalleID, long ConsultoraID, int MarcaID, string CUV, int Cantidad, decimal PrecioUnidad, DateTime FechaCreacion)
        {
            var daValidacionMovil = new DAValidacionAutomatica(PaisId);
            daValidacionMovil.DelPedidoWebDetalleValAuto(CampaniaID, PedidoID, PedidoDetalleID, ConsultoraID, MarcaID, CUV, Cantidad, PrecioUnidad, FechaCreacion);
        }

        public void UpdPedidoWebDetalleObsPROL(int PaisId, int CampaniaId, int PedidoId, int PedidoDetalleId, string ObservacionPROL, bool Tipo)
        {
            var daValidacionMovil = new DAValidacionAutomatica(PaisId);
            daValidacionMovil.UpdPedidoWebDetalleObsPROL(CampaniaId, PedidoId, PedidoDetalleId, ObservacionPROL, Tipo);
        }

        public List<BEPedidoWebDetalle> GetPedidoWebDetalleValidacionPROL(int PaisId, int CampaniaId, int PedidoId)
        {
            var daValidacionMovil = new DAValidacionAutomatica(PaisId);
            return daValidacionMovil.GetPedidoWebDetalleValidacionPROL(CampaniaId, PedidoId);
        }

        public void InsPedidoWebCorreoPROL(int PaisId, long ValAutomaticaPROLLogId, int CampaniaID, int PedidoID)
        {
            var daValidacionMovil = new DAValidacionAutomatica(PaisId);
            daValidacionMovil.InsPedidoWebCorreoPROL(ValAutomaticaPROLLogId, CampaniaID, PedidoID);
        }

        public int GetEstadoProcesoPROLAuto(int paisID, DateTime FechaHoraFacturacion)
        {
            var daPedidoWeb = new DAValidacionAutomatica(paisID);
            return daPedidoWeb.GetEstadoProcesoPROLAuto(FechaHoraFacturacion);
        }

        public List<BEValidacionAutomatica> GetEstadoProcesoPROLAutoDetalle(int paisID)
        {
            var lista = new List<BEValidacionAutomatica>();
            var daPedidoWeb = new DAValidacionAutomatica(paisID);

            using (IDataReader reader = daPedidoWeb.GetEstadoProcesoPROLAutoDetalle())
                while (reader.Read())
                {
                    var entidad = new BEValidacionAutomatica(reader);
                    lista.Add(entidad);
                }
            return lista;
        }
    }
}
