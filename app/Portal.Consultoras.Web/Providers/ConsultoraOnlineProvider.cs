using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.SessionManager;
using System.Collections.Generic;

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
                var resultServicelist = sv.GetRecomendados(recomendado);

                if (resultServicelist != null)
                {
                    resultServicelist.Each(item =>
                    {
                        var nuevo = new EstrategiaPedidoModel()
                        {
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
                            Cantidad = 1,
                            CUV2 = item.CUV2 ,
                            DescripcionMarca = item.DescripcionMarca
                            //OrigenPedidoWeb = x.OrigenPedidoWeb
                            //EsCuponNuevas = x.EsCuponNuevas
                            //pedidoDetalle.EsSugerido = model.EsSugerido;
                            //pedidoDetalle.EsKitNueva = model.EsKitNueva;
                            //pedidoDetalle.EsKitNuevaAuto = model.EsKitNuevaAuto;                            
                            //pedidoDetalle.OfertaWeb = model.OfertaWeb;                   
                            //pedidoDetalle.EsEditable = model.EsEditable;
                            //pedidoDetalle.SetID = model.SetId;
                            //  sap

                        };


                        if (item.CodigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.Lanzamiento 
                            || item.CodigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.OfertaDelDia)
                        {
                            var listadescr = item.DescripcionCUV2.Split('|');
                            nuevo.DescripcionCUV2 = listadescr.Length > 0 ? listadescr[0] : "";
                        }
                        else if (item.FlagNueva == 1)
                        {
                            nuevo.DescripcionCUV2 = item.DescripcionCUV2.Split('|')[0];
                        }
                        //else if (item.CodigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.OfertaDelDia)
                        //{
                        //    var listadescr = item.DescripcionCUV2.Split('|');
                        //    nuevo.DescripcionCUV2 = listadescr.Length > 0 ? listadescr[0] : "";
                        //}
                        else
                        {
                            nuevo.DescripcionCUV2 = Util.SubStrCortarNombre(item.DescripcionCUV2, 40);
                        }

                        response.Add(nuevo);

                    });
                }
            }
            return response;
        }
    }
}