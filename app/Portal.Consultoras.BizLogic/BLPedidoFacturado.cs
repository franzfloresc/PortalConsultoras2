using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;

// R2073 - Toda la clase
namespace Portal.Consultoras.BizLogic
{
    public class BLPedidoFacturado
    {
        public List<BEPedidoFacturado> GetPedidosFacturadosCabecera(int PaisId, string CodigoConsultora)
        {
            var lista = new List<BEPedidoFacturado>();

            var BLPais = new BLPais();

            if (!BLPais.EsPaisHana(PaisId)) // Validar si informacion de pais es de origen Normal o Hana
            {
                var DAPedidoFacturado = new DAPedidoFacturado(PaisId);

                using (IDataReader reader = DAPedidoFacturado.GetPedidosFacturadosCabecera(CodigoConsultora))
                    while (reader.Read())
                    {
                        var entidad = new BEPedidoFacturado(reader, 1);

                        lista.Add(entidad);
                    }
            }
            else
            {
                var DAHPedido = new DAHPedido();

                var listaPedidoHana = DAHPedido.GetPedidosIngresadoFacturado(PaisId, CodigoConsultora);

                listaPedidoHana = listaPedidoHana.OrderByDescending(p => p.CampaniaID).Take(3).ToList();

                foreach (var pedidoHana in listaPedidoHana)
                {
                    var bePedidoFacturado = new BEPedidoFacturado();
                    bePedidoFacturado.PedidoId = pedidoHana.PedidoID;
                    bePedidoFacturado.Campania = pedidoHana.CampaniaID;
                    bePedidoFacturado.ImporteTotal = pedidoHana.ImporteTotal;

                    string origen = string.IsNullOrEmpty(pedidoHana.CanalIngreso) ? "" : pedidoHana.CanalIngreso;
                    string flete = pedidoHana.Flete.ToString();
                    string fecha = pedidoHana.FechaRegistro.ToShortDateString();

                    string estadoPedido = origen + ";" + flete + ";" + fecha;

                    bePedidoFacturado.EstadoPedido = estadoPedido;
                    bePedidoFacturado.Cantidad = pedidoHana.CantidadProductos;

                    lista.Add(bePedidoFacturado);
                }
            }            

            return lista;
        }

        public List<BEPedidoFacturado> GetPedidosFacturadosDetalle(int PaisId, string Campania, string Region, string Zona, string CodigoConsultora, int pedidoId)
        {
            var lista = new List<BEPedidoFacturado>();

            var BLPais = new BLPais();

            if (!BLPais.EsPaisHana(PaisId)) // Validar si informacion de pais es de origen Normal o Hana
            {
                var DAPedidoFacturado = new DAPedidoFacturado(PaisId);
                using (IDataReader reader = DAPedidoFacturado.GetPedidosFacturadosDetalle(Campania, Region, Zona, CodigoConsultora))
                    while (reader.Read())
                    {
                        var entidad = new BEPedidoFacturado(reader);

                        lista.Add(entidad);
                    }
            }
            else
            {
                var DAHPedidoDetalle = new DAHPedidoDetalle();

                lista = DAHPedidoDetalle.GetPedidoDetalle(PaisId, pedidoId);
            }

            return lista;
        }
    }
}
