using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public class BLValidacionAutomatica
    {
        public BEValidacionMovil InsValidacionMovilPROLLog(BEValidacionMovil oBEValidacionMovil)
        {
            BEValidacionMovil Result = null;
            var DAValidacionMovil = new DAValidacionAutomatica(oBEValidacionMovil.PaisId);

            using (IDataReader reader = DAValidacionMovil.InsValidacionMovilPROLLog(oBEValidacionMovil))
            {
                if (reader.Read())
                {
                    Result = new BEValidacionMovil(reader);
                }
            }

            return Result;
        }

        public void UpdValidacionMovilPROLLog(BEValidacionMovil oBEValidacionMovil)
        {
            var DAValidacionMovil = new DAValidacionAutomatica(oBEValidacionMovil.PaisId);
            DAValidacionMovil.UpdValidacionMovilPROLLog(oBEValidacionMovil);
        }

        public string GetValidacionMovilPROLLog(BEValidacionMovil oBEValidacionMovil)
        {
            var DAValidacionMovil = new DAValidacionAutomatica(oBEValidacionMovil.PaisId);
            return DAValidacionMovil.GetValidacionMovilPROLLog(oBEValidacionMovil);
        }

        public void UpdValAutoPROLPedidoWeb(int PaisId, int CampaniaId, int PedidoId, int EstadoPedido, bool ItemsEliminados, decimal montoTotalProl, decimal descuentoProl)
        {
            var DAValidacionMovil = new DAValidacionAutomatica(PaisId);
            DAValidacionMovil.UpdValAutoPROLPedidoWeb(CampaniaId, PedidoId, EstadoPedido, ItemsEliminados, montoTotalProl, descuentoProl);
        }

        public void InsPedidoWebAccionesPROLAuto(int PaisId, BEAccionesPROL oBEAccionesPROL)
        {
            var DAValidacionMovil = new DAValidacionAutomatica(PaisId);
            DAValidacionMovil.InsPedidoWebAccionesPROLAuto(oBEAccionesPROL);
        }

        public void DelPedidoWebDetalleValAuto(int PaisId, int CampaniaID, int PedidoID, int PedidoDetalleID, long ConsultoraID, int MarcaID, string CUV, int Cantidad, decimal PrecioUnidad, DateTime FechaCreacion)
        {
            var DAValidacionMovil = new DAValidacionAutomatica(PaisId);
            DAValidacionMovil.DelPedidoWebDetalleValAuto(CampaniaID, PedidoID, PedidoDetalleID, ConsultoraID, MarcaID, CUV, Cantidad, PrecioUnidad, FechaCreacion);
        }

        public void UpdPedidoWebDetalleObsPROL(int PaisId, int CampaniaId, int PedidoId, int PedidoDetalleId, string ObservacionPROL, bool Tipo)
        {
            var DAValidacionMovil = new DAValidacionAutomatica(PaisId);
            DAValidacionMovil.UpdPedidoWebDetalleObsPROL(CampaniaId, PedidoId, PedidoDetalleId, ObservacionPROL, Tipo);
        }

        public List<BEPedidoWebDetalle> GetPedidoWebDetalleValidacionPROL(int PaisId, int CampaniaId, int PedidoId)
        {
            var DAValidacionMovil = new DAValidacionAutomatica(PaisId);
            return DAValidacionMovil.GetPedidoWebDetalleValidacionPROL(CampaniaId, PedidoId);
        }

        public void InsPedidoWebCorreoPROL(int PaisId, long ValAutomaticaPROLLogId, int CampaniaID, int PedidoID)
        {
            var DAValidacionMovil = new DAValidacionAutomatica(PaisId);
            DAValidacionMovil.InsPedidoWebCorreoPROL(ValAutomaticaPROLLogId, CampaniaID, PedidoID);
        }

        public int GetEstadoProcesoPROLAuto(int paisID, DateTime FechaHoraFacturacion)
        {
            var DAPedidoWeb = new DAValidacionAutomatica(paisID);
            return DAPedidoWeb.GetEstadoProcesoPROLAuto(FechaHoraFacturacion);
        }

        public List<BEValidacionAutomatica> GetEstadoProcesoPROLAutoDetalle(int paisID)
        {
            var lista = new List<BEValidacionAutomatica>();
            var DAPedidoWeb = new DAValidacionAutomatica(paisID);

            using (IDataReader reader = DAPedidoWeb.GetEstadoProcesoPROLAutoDetalle())
                while (reader.Read())
                {
                    var entidad = new BEValidacionAutomatica(reader);
                    lista.Add(entidad);
                }
            return lista;
        }
    }
}
