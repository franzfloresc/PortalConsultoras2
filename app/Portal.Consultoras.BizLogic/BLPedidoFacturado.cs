using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLPedidoFacturado
    {
        public List<BEPedidoFacturado> GetPedidosFacturadosCabecera(int PaisId, string CodigoConsultora)
        {
            var lista = new List<BEPedidoFacturado>();

            var blPais = new BLPais();

            if (!blPais.EsPaisHana(PaisId)) // Validar si informacion de pais es de origen Normal o Hana
            {
                var daPedidoFacturado = new DAPedidoFacturado(PaisId);

                using (IDataReader reader = daPedidoFacturado.GetPedidosFacturadosCabecera(CodigoConsultora))
                    while (reader.Read())
                    {
                        var entidad = new BEPedidoFacturado(reader, 1);

                        lista.Add(entidad);
                    }
            }
            else
            {
                var dahPedido = new DAHPedido();

                var listaPedidoHana = dahPedido.GetPedidosIngresadoFacturado(PaisId, CodigoConsultora);

                listaPedidoHana = listaPedidoHana.Where(p => p.EstadoPedidoDesc.ToUpper() == "FACTURADO").OrderByDescending(p => p.CampaniaID).Take(3).ToList();

                foreach (var pedidoHana in listaPedidoHana)
                {
                    var bePedidoFacturado = new BEPedidoFacturado
                    {
                        PedidoId = pedidoHana.PedidoID,
                        Campania = pedidoHana.CampaniaID,
                        ImporteTotal = pedidoHana.ImporteTotal
                    };

                    string origen = string.IsNullOrEmpty(pedidoHana.CanalIngreso) ? "" : pedidoHana.CanalIngreso;
                    string flete = pedidoHana.Flete.ToString();
                    string fecha = pedidoHana.FechaRegistro.ToString("dd/MM/yyyy");

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

            var blPais = new BLPais();

            if (!blPais.EsPaisHana(PaisId)) // Validar si informacion de pais es de origen Normal o Hana
            {
                var daPedidoFacturado = new DAPedidoFacturado(PaisId);
                using (IDataReader reader = daPedidoFacturado.GetPedidosFacturadosDetalle(Campania, Region, Zona, CodigoConsultora, pedidoId))
                    while (reader.Read())
                    {
                        var entidad = new BEPedidoFacturado(reader);

                        lista.Add(entidad);
                    }
            }
            else
            {
                var dahPedidoDetalle = new DAHPedidoDetalle();

                lista = dahPedidoDetalle.GetPedidoDetalle(PaisId, pedidoId);
            }

            return lista;
        }

        public List<BEPedidoFacturado> GetPedidosFacturadosDetalleMobile(int PaisId, int CampaniaID, long ConsultoraID, short ClienteID, string CodigoConsultora)
        {
            var lista = new List<BEPedidoFacturado>();

            var blPais = new BLPais();

            if (!blPais.EsPaisHana(PaisId)) // Validar si informacion de pais es de origen Normal o Hana
            {
                var daPedidoFacturado = new DAPedidoFacturado(PaisId);
                using (IDataReader reader = daPedidoFacturado.GetPedidosFacturadosDetalleMobile(CampaniaID, ConsultoraID, ClienteID))
                    while (reader.Read())
                    {
                        var entidad = new BEPedidoFacturado(reader);

                        lista.Add(entidad);
                    }
            }
            else
            {
                var dahPedido = new DAHPedido();

                var listaPedidoHana = dahPedido.GetPedidosIngresadoFacturado(PaisId, CodigoConsultora);
                var pedidoHana = listaPedidoHana.FirstOrDefault(p => p.EstadoPedidoDesc.ToUpper() == "FACTURADO" && p.CampaniaID == CampaniaID);

                if (pedidoHana != null)
                {
                    var dahPedidoDetalle = new DAHPedidoDetalle();
                    lista = dahPedidoDetalle.GetPedidoDetalle(PaisId, pedidoHana.PedidoID);
                    if (ClienteID > 0) lista = lista.Where(x => x.ClienteID == ClienteID).ToList();
                }
            }

            return lista;
        }

        public int UpdateClientePedidoFacturado(int paisID, int codigoPedido, int ClienteID)
        {
            var daPedidoWeb = new DAPedidoFacturado(paisID);
            return daPedidoWeb.UpdateClientePedidoFacturado(codigoPedido, ClienteID);
        }
    }
}
