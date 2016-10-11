using Portal.Consultoras.BizLogic;
using Portal.Consultoras.Entities;
using Portal.Consultoras.ServiceContracts;
using System.Collections.Generic;

namespace Portal.Consultoras.Service
{
    public class PedidoRechazadoService : IPedidoRechazadoService
    {
        public int SetPedidoRechazado(string PaisISO, List<BEPedidoRechazado> lista)
        {
            var BLPedidoRechazado = new BLPedidoRechazado();
            return BLPedidoRechazado.InsertarPedidoRechazadoXML(PaisISO,lista);
        }

        public BELogGPRValidacion GetBELogGPRValidacionByGetLogGPRValidacionId(int paisID, long logGPRValidacionId)
        {
            var BLPedidoRechazado = new BLPedidoRechazado();
            return BLPedidoRechazado.GetBELogGPRValidacionByGetLogGPRValidacionId(paisID, logGPRValidacionId);
        }

        public List<BELogGPRValidacionDetalle> GetListBELogGPRValidacionDetalleBELogGPRValidacionByLogGPRValidacionId(int paisID, long logGPRValidacionId)
        {
            var BLPedidoRechazado = new BLPedidoRechazado();
            return BLPedidoRechazado.GetListBELogGPRValidacionDetalleBELogGPRValidacionByLogGPRValidacionId(paisID, logGPRValidacionId);
        }
    }
}
