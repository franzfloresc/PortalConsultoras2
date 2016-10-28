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
    public class DAHPedidoDetalle
    {
        public List<BEPedidoFacturado> GetPedidoDetalle(int paisId, int pedidoId)
        {
            var listBE = new List<BEPedidoFacturado>();
            var listaHana = new List<PedidoDetalleHana>();

            try
            {
                string rutaServiceHana = ConfigurationManager.AppSettings.Get("RutaServiceHana");
                var codigoIsoHana = Util.GetCodigoIsoHana(paisId);

                string urlConParametros = rutaServiceHana + "ObtenerDetallePedidoFacturado/" + codigoIsoHana + "/" +
                                          pedidoId;

                string responseFromServer = Util.ObtenerJsonServicioHana(urlConParametros);

                listaHana = JsonConvert.DeserializeObject<List<PedidoDetalleHana>>(responseFromServer);

                foreach (var pedidoDetalleHana in listaHana)
                {
                    var bePedidoFacturado = new BEPedidoFacturado();
                    bePedidoFacturado.CodigoConsultora = ""; //el servicio no lo trae
                    bePedidoFacturado.MontoDescuento = pedidoDetalleHana.montoDescuento;
                    bePedidoFacturado.CodigoTerritorio = ""; //el servicio no lo trae
                    bePedidoFacturado.CUV = pedidoDetalleHana.cuv;
                    bePedidoFacturado.CodigoProducto = ""; //el servicio no lo trae
                    bePedidoFacturado.Descripcion = string.IsNullOrEmpty(pedidoDetalleHana.DESPROD)
                        ? "Sin Descripción"
                        : pedidoDetalleHana.DESPROD;
                    bePedidoFacturado.Cantidad = pedidoDetalleHana.cantidad;
                    bePedidoFacturado.PrecioUnidad = pedidoDetalleHana.precioUnidad;
                    bePedidoFacturado.ImporteTotal = pedidoDetalleHana.precioTotal;
                    bePedidoFacturado.CodigoTipoOferta = ""; //el servicio no lo trae
                    bePedidoFacturado.Origen = pedidoDetalleHana.tipoSolicitud;
                    bePedidoFacturado.FechaUltimaActualizacion = new DateTime(); //el servicio no lo trae

                    listBE.Add(bePedidoFacturado);
                }
            }
            catch (Exception ex)
            {
                listBE = new List<BEPedidoFacturado>();
            }

            return listBE;
        }
    }
}
