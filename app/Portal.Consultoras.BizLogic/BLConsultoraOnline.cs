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
        public IList<BEMisPedidos> GetMisPedidos(int PaisID, long ConsultoraId, int Campania)
        {
            var DAMisPedidos = new DAConsultoraOnline(PaisID);
            var misPedidos = new List<BEMisPedidos>();
            //var miPedidoDetalles = new List<BEMisPedidosDetalle>();
            //using (IDataReader reader = DAMisPedidos.GetMisPedidosConsultoraOnlineCab(ConsultoraId))
            using (IDataReader reader = DAMisPedidos.GetSolicitudesPedido(ConsultoraId, Campania))
            {
                while (reader.Read())
                {
                    var entidad = new BEMisPedidos(reader);
                    misPedidos.Add(entidad);
                }

                /*
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
                 * */

                return misPedidos;
            }
        }

        public IList<BEMisPedidosDetalle> GetMisPedidosDetalle(int PaisID, int PedidoID)
        {
            var DAMisPedidos = new DAConsultoraOnline(PaisID);
            var miPedidoDetalles = new List<BEMisPedidosDetalle>();
            using (IDataReader reader = DAMisPedidos.GetSolicitudesPedidoDetalle(PedidoID))
            {
                while (reader.Read())
                {
                    var entidad = new BEMisPedidosDetalle(reader);
                    miPedidoDetalles.Add(entidad);
                }

                return miPedidoDetalles;
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

        public IList<BEProducto> GetValidarCUVMisPedidos(int PaisID, int Campania, string InputCUV, int RegionID, int ZonaID, string CodigoRegion, string CodigoZona)
        {
            IList<BEProducto> productos = new List<BEProducto>();
            var DAConsultoraOnline = new DAConsultoraOnline(PaisID);

            using (IDataReader reader = DAConsultoraOnline.GetValidarCUVSolicitudPedido(Campania, InputCUV, RegionID, ZonaID, CodigoRegion, CodigoZona))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProducto(reader));
                }
            }
            return productos;
        }
    }
}
