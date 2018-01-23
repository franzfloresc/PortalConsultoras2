using Portal.Consultoras.Data.PagoEnLinea;
using Portal.Consultoras.Entities.PagoEnLinea;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic.PagoEnlinea
{
    public class BLPagoEnLinea
    {         
        public int InsertPagoEnLineaResultadoLog(int paisId, BEPagoEnLineaResultadoLog entidad)
        {
            var dataAccess = new DAPagoEnLinea(paisId);
            return dataAccess.InsertPagoEnLineaResultadoLog(entidad);
        }
    }
}
