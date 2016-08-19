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
    public class BLConsultoraOnline
    {
        public IList<BEMisPedidos> GetMisPedidos(int PaisID, long ConsultoraId)
        {
            var DAMisPedidos = new DAConsultoraOnline(PaisID);
            var misPedidos = new List<BEMisPedidos>();
            var miPedidoDetalles = new List<BEMisPedidosDetalle>();
            using (IDataReader reader = DAMisPedidos.GetMisPedidosConsultoraOnline(ConsultoraId))
            {
                while (reader.Read())
                {
                    var entidadPadre = new BEMisPedidos(reader);
                    misPedidos.Add(entidadPadre);
                }

                reader.NextResult();

                while (reader.Read())
                {
                    var entidadHijo = new BEMisPedidosDetalle(reader);
                    miPedidoDetalles.Add(entidadHijo);
                }

                foreach (var pedido in misPedidos)
                {
                    pedido.DetallePedido = miPedidoDetalles.Where(p => p.PedidoId == pedido.PedidoId).ToList();
                }

                return misPedidos;
            }
        }

        public int GetCantidadPedidosConsultoraOnline(int PaisID, long ConsultoraId)
        {
            var cantidad = -1;
            var DAConsultoraOnline = new DAConsultoraOnline(PaisID);

            using (IDataReader reader = DAConsultoraOnline.GetCantidadPedidosConsultoraOnline(ConsultoraId))
            {
                while (reader.Read())
                {
                    cantidad = reader.GetInt32(reader.GetOrdinal("Cantidad"));
                }
            }
            return cantidad;
        }
    }
}
