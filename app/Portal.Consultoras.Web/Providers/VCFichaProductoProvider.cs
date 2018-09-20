using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Providers
{
    public class VCFichaProductoProvider
    {
        private readonly EstrategiaComponenteProvider _estrategiaComponente;
        private readonly OfertaPersonalizadaProvider _ofertaPersonalizada;
        protected ISessionManager sessionManager;
        private int _paisId
        {
            get
            {
                return sessionManager.GetUserData().PaisID;
            }
        }
        private string _paisISO
        {
            get
            {
                return sessionManager.GetUserData().CodigoISO;
            }
        }

        public VCFichaProductoProvider()
        {
            _estrategiaComponente = new EstrategiaComponenteProvider();
            _ofertaPersonalizada = new OfertaPersonalizadaProvider();
            sessionManager = SessionManager.SessionManager.Instance;
        }

        public List<FichaProductoModel> ConsultarFichaProductoPorCuv(List<BEPedidoWebDetalle> listaPedido, string cuv = "", int campanaId = 0)
        {
            var userData = sessionManager.GetUserData();
            var entidad = new BEFichaProducto
            {
                PaisID = _paisId,
                CampaniaID = campanaId > 0 ? campanaId : userData.CampaniaID,
                ConsultoraID = userData.GetConsultoraId().ToString(),
                CUV2 = Util.Trim(cuv),
                Zona = userData.ZonaID.ToString(),
                ZonaHoraria = userData.ZonaHoraria,
                FechaInicioFacturacion = userData.FechaFinCampania,
                ValidarPeriodoFacturacion = true,
                Simbolo = userData.Simbolo,
                CodigoAgrupacion = Util.Trim("")
            };

            List<BEFichaProducto> listFichaProducto;
            using (var sv = new PedidoServiceClient())
            {
                listFichaProducto = sv.GetFichaProducto(entidad).ToList();
            }

            listFichaProducto = listFichaProducto.Where(e => e.Precio2 > 0).ToList();

            listFichaProducto.Where(e => (e.Precio <= e.Precio2) && e.FlagNueva != 1).ToList().ForEach(e =>
            {
                e.Precio = 0;
                e.PrecioTachado = Util.DecimalToStringFormat(e.Precio, _paisISO);
            });
            
            var listaProductoModel = FichaProductoModelFormato(listFichaProducto, listaPedido, userData.CampaniaID);

            return listaProductoModel;
        }

        public List<FichaProductoDetalleModel> FichaProductoFormatearModelo(List<FichaProductoModel> listaProductoModel, List<BEPedidoWebDetalle> listaPedido)
        {
            var listaRetorno = new List<FichaProductoDetalleModel>();
            if (!listaProductoModel.Any())
                return listaRetorno;
            
            listaProductoModel.ForEach(fichaProducto =>
            {
                var prodModel = new FichaProductoDetalleModel
                {
                    CampaniaID = fichaProducto.CampaniaID,
                    EstrategiaID = fichaProducto.EstrategiaID,
                    CUV2 = fichaProducto.CUV2,
                    TipoEstrategiaImagenMostrar = fichaProducto.TipoEstrategiaImagenMostrar,
                    CodigoEstrategia = fichaProducto.TipoEstrategia.Codigo,
                    CodigoVariante = fichaProducto.CodigoEstrategia,
                    FotoProducto01 = fichaProducto.FotoProducto01,
                    ImagenURL = fichaProducto.ImagenURL,
                    DescripcionMarca = fichaProducto.DescripcionMarca,
                    DescripcionResumen = fichaProducto.DescripcionResumen,
                    DescripcionCortada = fichaProducto.DescripcionCortada,
                    DescripcionDetalle = fichaProducto.DescripcionDetalle,
                    DescripcionCompleta = fichaProducto.DescripcionCUV2.Split('|')[0],
                    Precio = fichaProducto.Precio,
                    Precio2 = fichaProducto.Precio2,
                    PrecioTachado = fichaProducto.PrecioTachado,
                    PrecioVenta = fichaProducto.PrecioString,

                    TipoEstrategiaID = fichaProducto.TipoEstrategiaID,
                    FlagNueva = fichaProducto.FlagNueva,
                    IsAgregado = listaPedido.Any(p => p.CUV == fichaProducto.CUV2.Trim()),
                    ArrayContenidoSet = fichaProducto.FlagNueva == 1 ? fichaProducto.DescripcionCUV2.Split('|').Skip(1).ToList() : new List<string>(),
                    ListaDescripcionDetalle = fichaProducto.ListaDescripcionDetalle ?? new List<string>(),
                    TextoLibre = Util.Trim(fichaProducto.TextoLibre),

                    MarcaID = fichaProducto.MarcaID,

                    TienePaginaProducto = fichaProducto.PuedeVerDetalle,
                    TienePaginaProductoMob = fichaProducto.PuedeVerDetalleMob,

                    TipoAccionAgregar = _ofertaPersonalizada.TipoAccionAgregar(fichaProducto.TieneVariedad, fichaProducto.TipoEstrategia.Codigo),
                    LimiteVenta = fichaProducto.LimiteVenta
                };
                listaRetorno.Add(prodModel);
            });

            return listaRetorno;
        }

        private List<FichaProductoModel> FichaProductoModelFormato(List<BEFichaProducto> listaProducto, List<BEPedidoWebDetalle> listaPedido, int campaniaId)
        {
            listaProducto = listaProducto ?? new List<BEFichaProducto>();
            var listaProductoModel = Mapper.Map<List<BEFichaProducto>, List<FichaProductoModel>>(listaProducto);
            return FichaProductoModelFormato(listaProductoModel, listaPedido, campaniaId);
        }

        private List<FichaProductoModel> FichaProductoModelFormato(List<FichaProductoModel> listaProductoModel, List<BEPedidoWebDetalle> listaPedido, int campaniaId)
        {
            if (!listaProductoModel.Any())
                return listaProductoModel;
            
            var claseBloqueada = "btn_desactivado_general";

            listaProductoModel.ForEach(ficha =>
            {
                ficha.ClaseBloqueada = ficha.CampaniaID > 0 && ficha.CampaniaID != campaniaId ? claseBloqueada : "";
                ficha.IsAgregado = ficha.ClaseBloqueada != claseBloqueada && listaPedido.Any(p => p.CUV == ficha.CUV2.Trim());
                ficha.DescripcionResumen = "";
                ficha.DescripcionDetalle = "";
                if (ficha.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento)
                {
                    var listadescr = ficha.DescripcionCUV2.Split('|');
                    ficha.DescripcionResumen = listadescr.Length > 0 ? listadescr[0] : "";
                    ficha.DescripcionCortada = listadescr.Length > 1 ? listadescr[1] : "";
                    if (listadescr.Length > 2)
                    {
                        ficha.ListaDescripcionDetalle = new List<string>(listadescr.Skip(2));
                        ficha.DescripcionDetalle = string.Join("<br />", listadescr.Skip(2));
                    }
                    ficha.DescripcionCortada = Util.SubStrCortarNombre(ficha.DescripcionCortada, 40);
                }
                else if (ficha.FlagNueva == 1)
                {
                    ficha.DescripcionCortada = ficha.DescripcionCUV2.Split('|')[0];
                    ficha.DescripcionDetalle = ficha.DescripcionCUV2.Split('|')[1];
                    ficha.DescripcionResumen = "";
                }
                else
                {
                    ficha.DescripcionCortada = Util.SubStrCortarNombre(ficha.DescripcionCUV2, 40);
                }

                ficha.ImagenURL = ficha.FlagMostrarImg == 1 ? "/Content/Images/oferta-ultimo-minuto.png" : "";

                ficha.ID = ficha.EstrategiaID;
                if (ficha.FlagMostrarImg == 1)
                {
                    if (ficha.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.OfertaParaTi)
                    {
                        if (ficha.FlagEstrella == 1)
                        {
                            ficha.ImagenURL = "/Content/Images/oferta-ultimo-minuto.png";
                        }
                    }
                    else if (!(ficha.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.PackNuevas
                        || ficha.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.Lanzamiento))
                    {
                        ficha.ImagenURL = "";
                    }
                }
                else
                {
                    ficha.ImagenURL = "";
                }

                ficha.PuedeCambiarCantidad = 1;
                if (ficha.TieneVariedad == 0 && ficha.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.PackNuevas)
                    ficha.PuedeCambiarCantidad = 0;

                ficha.PuedeAgregar = 1;
                ficha.PuedeVerDetalle = false;
                ficha.PuedeVerDetalleMob = false;
            });

            return listaProductoModel;
        }

        public FichaProductoDetalleModel FichaProductoHermanos(FichaProductoDetalleModel fichaProductoModelo, List<BEPedidoWebDetalle> listaPedido, int campaniaId)
        {
            try
            {
                if (fichaProductoModelo == null)
                    return null;

                fichaProductoModelo.Hermanos = new List<EstrategiaComponenteModel>();
                fichaProductoModelo.TextoLibre = Util.Trim(fichaProductoModelo.TextoLibre);
                fichaProductoModelo.CodigoVariante = Util.Trim(fichaProductoModelo.CodigoVariante);
                
                fichaProductoModelo.IsAgregado = listaPedido.Any(p => p.CUV == fichaProductoModelo.CUV2);

                if (fichaProductoModelo.CodigoVariante == "")
                    return fichaProductoModelo;

                fichaProductoModelo.CampaniaID = fichaProductoModelo.CampaniaID > 0 ? fichaProductoModelo.CampaniaID : campaniaId;

                var estrategiaModelo = new EstrategiaPersonalizadaProductoModel
                {
                    CodigoVariante = fichaProductoModelo.CodigoVariante,
                    EstrategiaID = fichaProductoModelo.EstrategiaID
                };

                bool esMultimarca = false;
                string mensaje = "";
                fichaProductoModelo.Hermanos = _estrategiaComponente.GetListaComponentes(estrategiaModelo, string.Empty, out esMultimarca, out mensaje);
            }
            catch (Exception ex)
            {
                fichaProductoModelo = new FichaProductoDetalleModel();
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", _paisISO);
            }
            return fichaProductoModelo;
        }

    }
}