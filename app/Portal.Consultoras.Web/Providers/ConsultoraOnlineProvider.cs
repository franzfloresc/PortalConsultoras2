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
                    resultServicelist.Each(item=> {

                        response.Add(new EstrategiaPedidoModel() {
                            DescripcionCUV2 = item.DescripcionCUV2,
                            CantidadPack = item.CantidadPack,
                            PrecioString = item.PrecioString,
                            Precio2 = item.Precio2,
                            Ganancia = item.Ganancia,
                            ImagenURL = ConfigCdn.GetUrlFileCdnMatriz(recomendado.codigoPais, item.FotoProducto01),
                             EstrategiaID = item.EstrategiaID,
                             TipoEstrategiaID = item.TipoEstrategiaID,
                               TipoOfertaSisID = 0,
                               MarcaID = item.MarcaID,
                            //ConfiguracionOfertaID = x.ConfiguracionOfertaID
                            //pedidoDetalle.Producto.CUV = Util.Trim(model.CuvTonos);
                            IndicadorMontoMinimo = item.IndicadorMontoMinimo,
                            FlagNueva = item.FlagNueva,
                          Cantidad =1,
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