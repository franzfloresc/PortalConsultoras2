using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLTracking
    {
        public List<BETracking> GetPedidosByConsultora(int paisID, string codigoConsultora)
        {
            var pedidos = new List<BETracking>();
            var DATracking = new DATracking(paisID);

            using (IDataReader reader = DATracking.GetPedidosByConsultora(codigoConsultora))
            {
                while (reader.Read())
                {
                    var entidad = new BETracking(reader);
                    entidad.PaisID = paisID;
                    pedidos.Add(entidad);
                }
            }

            return pedidos;
        }
        
        public BETracking GetPedidoByConsultoraAndCampania(int paisID,string codigoConsultora, int campania)
        {
            var pedido = new BETracking();
            var DATracking = new DATracking(paisID);

            using (IDataReader reader = DATracking.GetPedidoByConsultoraAndCampania(codigoConsultora, campania))
            {
                if (reader.Read())
                {
                    pedido = new BETracking(reader);
                    pedido.PaisID = paisID;
                }
            }

            return pedido;
        }

        public List<BETracking> GetTrackingByPedido(int paisID, string codigo, string campana, string nropedido)
        {
            var pedidos = new List<BETracking>();
            var DATracking = new DATracking(paisID);

            using (IDataReader reader = DATracking.GetTrackingByPedido(codigo, campana, nropedido))
            {
                while (reader.Read())
                {
                    var entidad = new BETracking(reader);
                    entidad.PaisID = paisID;
                    pedidos.Add(entidad);
                }
            }

            return pedidos;
        }

        //1793
        public List<BENovedadTracking> GetNovedadesTracking(int paisID, string NumeroPedido)
        {
            var novedades = new List<BENovedadTracking>();
            var DATracking = new DATracking(paisID);

            using (IDataReader reader = DATracking.GetNovedadesTracking(NumeroPedido))
            {
                while (reader.Read())
                {
                    var entidad = new BENovedadTracking(reader);
                    novedades.Add(entidad);
                }
            }

            return novedades;
        }


        // Req. 1717 - Inicio
        public int InsConfirmacionEntrega(int paisID, BEConfirmacionEntrega oBEConfirmacionEntrega)
        {
            var DATracking = new DATracking(paisID);

            int Result = 0;
            try
            {
                Result = DATracking.InsConfirmacionEntrega(oBEConfirmacionEntrega);
            }
            catch { }

            return Result;
        }

        public int UpdConfirmacionEntrega(int paisID, BEConfirmacionEntrega oBEConfirmacionEntrega)
        {
            var DATracking = new DATracking(paisID);

            int Result = 0;
            try
            {
                Result = DATracking.UpdConfirmacionEntrega(oBEConfirmacionEntrega);
            }
            catch { }

            return Result;
        }

        //R2004
        public BENovedadFacturacion GetPedidoRechazadoByConsultora(int PaisID, string CampaniaId, string CodigoConsultora, DateTime Fecha)
        {
            BENovedadFacturacion entidad = null;
            var DATracking = new DATracking(PaisID);

            using (IDataReader reader = DATracking.GetPedidoRechazadoByConsultora(CampaniaId, CodigoConsultora, Fecha))
            {
                if (reader.Read())
                {
                    entidad = new BENovedadFacturacion(reader);
                }
            }

            return entidad;
        }

        //R2004
        public BENovedadFacturacion GetPedidoAnuladoByConsultora(int PaisID, string CampaniaId, string CodigoConsultora, DateTime Fecha, string NumeroPedido)
        {
            BENovedadFacturacion entidad = null;
            var DATracking = new DATracking(PaisID);

            using (IDataReader reader = DATracking.GetPedidoAnuladoByConsultora(CampaniaId, CodigoConsultora, Fecha, NumeroPedido))
            {
                if (reader.Read())
                {
                    entidad = new BENovedadFacturacion(reader);
                }
            }

            return entidad;
        }

        //RQ 20150711 - Inicio
        public int InsConfirmacionRecojo(int paisID, BEConfirmacionRecojo oBEConfirmacionRecoja)
        {
            var DATracking = new DATracking(paisID);

            int Result = 0;
            try
            {
                Result = DATracking.InsConfirmacionRecojo(oBEConfirmacionRecoja);
            }
            catch { }

            return Result;
        }


        public List<BEPostVenta> GetMisPostVentaByConsultora(int paisID, string codigoConsultora)
        {
            var recojos = new List<BEPostVenta>();
            var DATracking = new DATracking(paisID);

            using (IDataReader reader = DATracking.GetMisPostVentaByConsultora(codigoConsultora))
            {
                while (reader.Read())
                {
                    var entidad = new BEPostVenta(reader);
                    recojos.Add(entidad);
                }
            }

            return recojos;
        }

        public List<BEPostVenta> GetSeguimientoPostVenta(int paisID, string numeroRecojo, int estadoRecojoID)
        {
            var recojos = new List<BEPostVenta>();
            var DATracking = new DATracking(paisID);

            using (IDataReader reader = DATracking.GetSeguimientoPostVenta(numeroRecojo, estadoRecojoID))
            {
                while (reader.Read())
                {
                    var entidad = new BEPostVenta(reader);
                    recojos.Add(entidad);
                }
            }

            return recojos;
        }

        public List<BEPostVenta> GetNovedadPostVenta(int paisID, string numeroRecojo)
        {
            var recojos = new List<BEPostVenta>();
            var DATracking = new DATracking(paisID);

            using (IDataReader reader = DATracking.GetNovedadPostVenta(numeroRecojo))
            {
                while (reader.Read())
                {
                    var entidad = new BEPostVenta(reader);
                    recojos.Add(entidad);
                }
            }

            return recojos;
        }
        //RQ 20150711 - Fin

    }
}
