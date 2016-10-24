using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Portal.Consultoras.Data.Hana.Entities;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data.Hana
{
    public class DAHPedido
    {
        public List<BEPedidoWeb> GetPedidosIngresadoFacturado(int paisId, string codigoConsultora)
        {
            var listBE = new List<BEPedidoWeb>();
            var listaHana = new List<PedidoHana>();

            try
            {
                string rutaServiceHana = ConfigurationManager.AppSettings.Get("RutaServiceHana");
                var codigoIsoHana = Util.GetCodigoIsoHana(paisId);

                string urlConParametros = rutaServiceHana + "ObtenerPedidoConsultora/" + codigoIsoHana + "/" +
                                          codigoConsultora;

                string responseFromServer = Util.ObtenerJsonServicioHana(urlConParametros);

                listaHana = JsonConvert.DeserializeObject<List<PedidoHana>>(responseFromServer);

                foreach (var pedidoHana in listaHana)
                {
                    var bePedidoWeb = new BEPedidoWeb();
                    int campaniaId;
                    bool esCampania = Int32.TryParse(pedidoHana.codPeri, out campaniaId);

                    if (esCampania)
                        bePedidoWeb.CampaniaID = campaniaId;

                    bePedidoWeb.ImporteTotal = pedidoHana.montoPedido;
                    bePedidoWeb.Flete = 0; //falta calcular, el servicio no lo trae
                    bePedidoWeb.ImporteCredito = 0; //por defecto cero

                    //short motivoCredito;
                    //bool esMotivo = short.TryParse(pedidoHana.motivoEstado, out motivoCredito);
                    //if (esMotivo)
                        //bePedidoWeb.MotivoCreditoID = motivoCredito;
                    bePedidoWeb.MotivoCreditoID = 0; //por defecto cero
                    bePedidoWeb.PaisID = 0; //por defecto cero
                    bePedidoWeb.Clientes = 0; //por defecto cero
                    bePedidoWeb.EstadoPedidoDesc = pedidoHana.estadoPedido;
                    bePedidoWeb.ConsultoraID = 0; //por defecto cero
                    bePedidoWeb.PedidoID = pedidoHana.oidPedido;                  
                    bePedidoWeb.FechaRegistro = pedidoHana.fechaFacturacion;
                    bePedidoWeb.CanalIngreso = pedidoHana.origen;
                    bePedidoWeb.CantidadProductos = 0; //falta calcular, el servicio no lo trae

                    listBE.Add(bePedidoWeb);
                }
            }
            catch (Exception ex)
            {
                listBE = new List<BEPedidoWeb>();
            }

            return listBE;
        }
    }
}
