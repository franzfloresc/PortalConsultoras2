using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic
{
    public class BLProcesoPedidoRechazado
    {
        public BEProcesoPedidoRechazado ObtenerProcesoPedidoRechazadoGPR(int paisID, int campaniaID, long consultoraID)
        {
            IList<BEProcesoPedidoRechazado> listaBEPedidoWebDetalle = new List<BEProcesoPedidoRechazado>();
            var da = new DAProcesoPedidoRechazado(paisID);
            var cant = 0;
            var beEntidad = new BEProcesoPedidoRechazado();
            using (IDataReader reader = da.ObtenerProcesoPedidoRechazadoGPR(campaniaID, consultoraID))
            {                
                while (reader.Read())
                {
                    if (cant == 0)
                    {
                        cant++;
                        beEntidad = new BEProcesoPedidoRechazado(reader);
                        beEntidad.olstBEPedidoRechazado = beEntidad.olstBEPedidoRechazado ?? new List<BEPedidoRechazado>();
                    }
                    var beEntidadDetalle = new BEPedidoRechazado(reader);
                    if (beEntidadDetalle.IdPedidoRechazado > 0)
                        beEntidad.olstBEPedidoRechazado.Add(beEntidadDetalle);
                    
                }
            }

            return beEntidad;
        }
    }
}
