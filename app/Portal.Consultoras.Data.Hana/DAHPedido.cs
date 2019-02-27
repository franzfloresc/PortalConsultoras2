using Newtonsoft.Json;
using Portal.Consultoras.Data.Hana.Entities;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;

namespace Portal.Consultoras.Data.Hana
{
    public class DAHPedido
    {
        public List<BEPedidoWeb> GetPedidosIngresadoFacturado(int paisId, string codigoConsultora)
        {
            var listBe = new List<BEPedidoWeb>();

            try
            {
                string rutaServiceHana = ConfigurationManager.AppSettings.Get("RutaServiceHana");
                var codigoIsoHana = Common.Util.GetPaisIsoHanna(paisId);

                string urlConParametros = rutaServiceHana + "ObtenerPedidoConsultora/" + codigoIsoHana + "/" +
                                          codigoConsultora;

                string responseFromServer = Util.ObtenerJsonServicioHana(urlConParametros);

                var listaHana = JsonConvert.DeserializeObject<List<PedidoHana>>(responseFromServer);

                foreach (var pedidoHana in listaHana)
                {
                    var bePedidoWeb = new BEPedidoWeb();
                    int campaniaId;
                    bool esCampania = Int32.TryParse(pedidoHana.codPeri, out campaniaId);

                    if (esCampania)
                        bePedidoWeb.CampaniaID = campaniaId;

                    bePedidoWeb.ImporteTotal = pedidoHana.montoPedido;
                    bePedidoWeb.Flete = pedidoHana.MONTOFLETE;
                    bePedidoWeb.ImporteCredito = 0;

                    bePedidoWeb.MotivoCreditoID = 0;
                    bePedidoWeb.PaisID = 0;
                    bePedidoWeb.Clientes = 0;
                    bePedidoWeb.EstadoPedidoDesc = pedidoHana.estadoPedido;
                    bePedidoWeb.ConsultoraID = 0;
                    bePedidoWeb.PedidoID = pedidoHana.oidPedido;
                    bePedidoWeb.FechaRegistro = pedidoHana.fechaFacturacion;
                    bePedidoWeb.CanalIngreso = pedidoHana.origen;
                    bePedidoWeb.CantidadProductos = pedidoHana.NUMUNIDATEN;

                    listBe.Add(bePedidoWeb);
                }
            }
            catch (Exception)
            {
                listBe = new List<BEPedidoWeb>();
            }

            return listBe;
        }
    }
}