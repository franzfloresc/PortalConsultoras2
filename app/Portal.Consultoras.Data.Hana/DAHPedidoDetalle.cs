using Newtonsoft.Json;
using Portal.Consultoras.Data.Hana.Entities;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;

namespace Portal.Consultoras.Data.Hana
{
    public class DAHPedidoDetalle
    {
        public List<BEPedidoFacturado> GetPedidoDetalle(int paisId, int pedidoId)
        {
            var listBe = new List<BEPedidoFacturado>();

            try
            {
                string rutaServiceHana = ConfigurationManager.AppSettings.Get("RutaServiceHana");
                var codigoIsoHana = Common.Util.GetPaisIsoHanna(paisId);

                string urlConParametros = rutaServiceHana + "ObtenerDetallePedidoFacturado/" + codigoIsoHana + "/" +
                                          pedidoId;

                string responseFromServer = Util.ObtenerJsonServicioHana(urlConParametros);

                var listaHana = JsonConvert.DeserializeObject<List<PedidoDetalleHana>>(responseFromServer);

                foreach (var pedidoDetalleHana in listaHana)
                {
                    var bePedidoFacturado = new BEPedidoFacturado
                    {
                        CodigoConsultora = "",
                        MontoDescuento = pedidoDetalleHana.montoDescuento,
                        CodigoTerritorio = "",
                        CUV = pedidoDetalleHana.cuv,
                        CodigoProducto = "",
                        Descripcion = string.IsNullOrEmpty(pedidoDetalleHana.DESPROD)
                            ? "Sin Descripción"
                            : pedidoDetalleHana.DESPROD,
                        Cantidad = pedidoDetalleHana.cantidad,
                        PrecioUnidad = pedidoDetalleHana.precioUnidad,
                        ImporteTotal = pedidoDetalleHana.precioTotal,
                        CodigoTipoOferta = "",
                        Origen = pedidoDetalleHana.tipoSolicitud,
                        FechaUltimaActualizacion = new DateTime()
                    };


                    listBe.Add(bePedidoFacturado);
                }
            }
            catch (Exception)
            {
                listBe = new List<BEPedidoFacturado>();
            }

            return listBe;
        }
    }
}