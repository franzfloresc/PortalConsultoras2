using Portal.Consultoras.BizLogic;
using Portal.Consultoras.Entities;
using Portal.Consultoras.ServiceContracts;
using System.Collections.Generic;

namespace Portal.Consultoras.Service
{
    public class PedidoRechazadoService : IPedidoRechazadoService
    {
        public int setPedidoRechazado(string PaisISO, List<BEPedidoRechazado> lista)
        {
            var BLPedidoRechazado = new BLPedidoRechazado();
            return BLPedidoRechazado.InsertarPedidoRechazadoXML(PaisISO,lista);
        }
    }
}
