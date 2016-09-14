using Portal.Consultoras.BizLogic;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;
using Portal.Consultoras.ServiceContracts;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;

namespace Portal.Consultoras.Service
{
    public class WS_GPR : IWS_GPR
    {
        public int setPedidoRechazado(string PaisISO, List<BEPedidoRechazado> lista)
        {
            var BLPedidoRechazado = new BLPedidoRechazado();
            return BLPedidoRechazado.InsertarPedidoRechazadoXML(PaisISO,lista);
        }
    }
}
