using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Portal.Consultoras.Web.Models.ConsultaProl;
using Portal.Consultoras.Web.Models.Search.ResponseOferta.Estructura;
using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.PagoEnLinea;
using Portal.Consultoras.Web.Properties;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceUsuario;



namespace Portal.Consultoras.Web.Providers
{
    public class ConsultoraOnlineProvider
    {

        protected ISessionManager sessionManager;

        public ConsultoraOnlineProvider()
        {
            sessionManager = SessionManager.SessionManager.Instance;
        }
         



        public List<EstrategiaPedidoModel> GetRecomendados(RecomendadoRequest recomendado)
        {

            var response = new List<EstrategiaPedidoModel>(); 

            using (var sv = new UsuarioServiceClient())
            {
                var resultServicelist =  sv.GetRecomendados(recomendado);

                if (resultServicelist != null)
                {
                    resultServicelist.Each(x=> {

                        response.Add(new EstrategiaPedidoModel() {
                            DescripcionCUV2 = x.DescripcionCUV2,
                            PrecioString = x.PrecioString,
                            Precio2 = x.Precio2,
                            Ganancia = x.Ganancia,
                            FotoProducto01 = ConfigCdn.GetUrlFileCdnMatriz(recomendado.codigoPais, x.FotoProducto01),
                             EstrategiaID = x.EstrategiaID,
                             TipoEstrategiaID = x.TipoEstrategiaID,
                               TipoOfertaSisID = 0,
                            //ConfiguracionOfertaID = x.ConfiguracionOfertaID
                            //pedidoDetalle.Producto.CUV = Util.Trim(model.CuvTonos);
                            IndicadorMontoMinimo = x.IndicadorMontoMinimo,
                            FlagNueva = x.FlagNueva,
                          Cantidad =x.Cantidad,
                            //OrigenPedidoWeb = x.OrigenPedidoWeb
                            //EsCuponNuevas = x.EsCuponNuevas
                            //pedidoDetalle.EsSugerido = model.EsSugerido;
                            //pedidoDetalle.EsKitNueva = model.EsKitNueva;
                            //pedidoDetalle.EsKitNuevaAuto = model.EsKitNuevaAuto;                            
                            //pedidoDetalle.OfertaWeb = model.OfertaWeb;                   
                            //pedidoDetalle.EsEditable = model.EsEditable;
                            //pedidoDetalle.SetID = model.SetId;
                          //  sap

                        });

                    });

                }

                
            }

            return response;
        }

    }
}