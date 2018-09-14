using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.SessionManager;

namespace Portal.Consultoras.Web.Providers
{
    public class EstrategiaComponenteProvider
    {
        private readonly ConfiguracionManagerProvider _configuracionManagerProvider;
        private readonly int _paisId;
        private readonly string _paisISO;
        protected OfertaBaseProvider _ofertaBaseProvider;
        protected ISessionManager sessionManager;

        public EstrategiaComponenteProvider(int paisId, string paisIso)
        {
            _configuracionManagerProvider = new ConfiguracionManagerProvider();
            _paisId = paisId;
            _paisISO = paisIso;
            _ofertaBaseProvider = new OfertaBaseProvider();
            sessionManager = SessionManager.SessionManager.Instance;
        }

        public List<EstrategiaComponenteModel> GetListaComponentes(EstrategiaPersonalizadaProductoModel estrategiaModelo, string codigoTipoEstrategia, out bool esMultimarca, out string mensaje)
        {
            string joinCuv = string.Empty;
            List<BEEstrategiaProducto> listaBeEstrategiaProductos;
            esMultimarca = false;
            mensaje = "";

            var userData = sessionManager.GetUserData();
            if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, codigoTipoEstrategia))
            {
                mensaje += "SiMongo|";
                string pathComponente = string.Format(Constantes.PersonalizacionOfertasService.UrlObtenerComponente,
                        userData.CodigoISO,
                        estrategiaModelo.CampaniaID,
                        estrategiaModelo.CUV2);
                var taskApi = Task.Run(() => _ofertaBaseProvider.ObtenerComponenteDesdeApi(pathComponente));
                Task.WhenAll(taskApi);
                listaBeEstrategiaProductos = taskApi.Result;

                if (listaBeEstrategiaProductos != null)
                {
                    joinCuv = String.Join("|", listaBeEstrategiaProductos.Distinct().Select(o => o.SAP));
                }

                if (joinCuv == "") return new List<EstrategiaComponenteModel>();


                mensaje += "EstrategiaProductos= " + listaBeEstrategiaProductos.Count + "|";

                var listaProductos = GetAppProductoBySap(estrategiaModelo, joinCuv);
                if (!listaProductos.Any()) return new List<EstrategiaComponenteModel>();

                mensaje += "GetAppProductoBySap = " + listaProductos.Count + "|";

                var listaEstrategiaComponente = GetEstrategiaDetalleCompuestaMs(estrategiaModelo, listaBeEstrategiaProductos, listaProductos, codigoTipoEstrategia);
                mensaje += "GetEstrategiaDetalleCompuestaMs = " + listaEstrategiaComponente.Count + "|";
                //estrategiaModelo.CodigoVariante = "";
                //var listaComponentesPorOrdenar = GetEstrategiaDetalleFactorCuadre(listaEstrategiaComponente);
                listaEstrategiaComponente = OrdenarComponentesPorMarca(listaEstrategiaComponente, out esMultimarca);
                mensaje += "OrdenarComponentesPorMarca = " + listaEstrategiaComponente.Count + "|";
                return listaEstrategiaComponente;

            }
            else
            {
                mensaje += "NoMongo|";

                listaBeEstrategiaProductos = GetEstrategiaProductos(estrategiaModelo);

                if (!listaBeEstrategiaProductos.Any()) return new List<EstrategiaComponenteModel>();

                mensaje += "GetEstrategiaProductos = " + listaBeEstrategiaProductos.Count + "|";

                var listaEstrategiaComponente = GetEstrategiaDetalleCompuesta(estrategiaModelo, listaBeEstrategiaProductos, codigoTipoEstrategia);
                mensaje += "GetEstrategiaDetalleCompuesta = " + listaEstrategiaComponente.Count + "|";
                //var listaComponentesPorOrdenar = GetEstrategiaDetalleFactorCuadre(listaEstrategiaComponente);
                var listaComponentesPorOrdenar = OrdenarComponentesPorMarca(listaEstrategiaComponente, out esMultimarca);
                mensaje += "OrdenarComponentesPorMarca = " + listaComponentesPorOrdenar.Count + "|";
                return listaComponentesPorOrdenar;
            }

        }

        //public List<BEEstrategiaProducto> GetEstrategiaProductosList(EstrategiaPersonalizadaProductoModel estrategiaModelo, out string codigoSap)
        //{
        //    codigoSap = "";
        //    const string separador = "|";
        //    var txtBuil = new StringBuilder();
        //    txtBuil.Append(separador);

        //    var listaProducto = new List<BEEstrategiaProducto>();
        //    if (!string.IsNullOrEmpty(estrategiaModelo.CodigoVariante))
        //    {

        //        var estrategiaX = new BEEstrategia { PaisID = _paisId, EstrategiaID = estrategiaModelo.EstrategiaID };
        //        using (var svc = new PedidoServiceClient())
        //        {
        //            listaProducto = svc.GetEstrategiaProducto(estrategiaX).ToList();
        //        }

        //        foreach (var item in listaProducto)
        //        {
        //            item.SAP = Util.Trim(item.SAP);
        //            if (item.SAP != "" && !txtBuil.ToString().Contains(separador + item.SAP + separador))
        //                txtBuil.Append(item.SAP + separador);
        //        }
        //    }


        //    return listaProducto;
        //}


        private List<BEEstrategiaProducto> GetEstrategiaProductos(EstrategiaPersonalizadaProductoModel estrategiaModelo)
        {
            var listaProducto = new List<BEEstrategiaProducto>();

            if (string.IsNullOrEmpty(estrategiaModelo.CodigoVariante)) return listaProducto;

            using (var svc = new PedidoServiceClient())
            {
                var parameters = new BEEstrategia { PaisID = _paisId, EstrategiaID = estrategiaModelo.EstrategiaID };
                listaProducto = svc.GetEstrategiaProducto(parameters).ToList();
            }

            listaProducto.ForEach(x =>
            {
                x.NombreComercial = x.NombreComercial ?? string.Empty;
                x.NombreBulk = String.IsNullOrEmpty(x.NombreBulk) ? x.NombreComercial : x.NombreBulk;
                x.ImagenProducto = x.ImagenProducto ?? string.Empty;
                x.ImagenBulk = x.ImagenBulk ?? string.Empty;
                if (string.IsNullOrWhiteSpace(x.ImagenProducto) && string.IsNullOrWhiteSpace(x.ImagenBulk)) return;
                var codigoIsoPais = SessionManager.SessionManager.Instance.GetUserData().CodigoISO;
                var campaniaId = estrategiaModelo.CampaniaID;//SessionManager.SessionManager.Instance.GetUserData().CampaniaID;
                var codigoMarca = string.Empty;
                if (x.IdMarca == Constantes.Marca.LBel) codigoMarca = "L";
                if (x.IdMarca == Constantes.Marca.Esika) codigoMarca = "E";
                if (x.IdMarca == Constantes.Marca.Cyzone) codigoMarca = "C";
                x.ImagenBulk = string.IsNullOrWhiteSpace(x.ImagenBulk) ?
                    string.Format(_configuracionManagerProvider.GetRutaImagenesAppCatalogo(), codigoIsoPais, campaniaId, codigoMarca, x.ImagenProducto) :
                    string.Format(_configuracionManagerProvider.GetRutaImagenesAppCatalogoBulk(), codigoIsoPais, campaniaId, codigoMarca, x.ImagenBulk);
            });

            return listaProducto;
        }

        private List<Producto> GetAppProductoBySap(EstrategiaPersonalizadaProductoModel estrategiaModelo, string joinSap)
        {
            List<Producto> listaAppCatalogo;
            try
            {
                var numeroCampanias = Convert.ToInt32(_configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.NumeroCampanias));
                using (var svc = new ProductoServiceClient())
                {
                    listaAppCatalogo = svc.ObtenerProductosPorCampaniasBySap(_paisISO, estrategiaModelo.CampaniaID, joinSap, numeroCampanias).ToList();
                }
                listaAppCatalogo = listaAppCatalogo.Any() ? listaAppCatalogo : new List<Producto>();

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", _paisISO, "EstrategiaComponenteProvider.GetAppProductoBySap");
                listaAppCatalogo = new List<Producto>();
            }
            return listaAppCatalogo;
        }

        private List<EstrategiaComponenteModel> GetEstrategiaDetalleCompuestaMs(EstrategiaPersonalizadaProductoModel estrategiaModelo,
                                                                   List<BEEstrategiaProducto> listaBeEstrategiaProductos,
                                                                   List<Producto> listaProductos,
                                                                   string codigoTipoEstrategia)
        {
            var listaEstrategiaComponenteProductos = Mapper.Map<List<Producto>, List<EstrategiaComponenteModel>>(listaProductos);

            var listaComponentesTemporal = new List<EstrategiaComponenteModel>();
            listaBeEstrategiaProductos = listaBeEstrategiaProductos.OrderBy(p => p.Grupo).ToList();
            listaEstrategiaComponenteProductos = listaEstrategiaComponenteProductos.OrderBy(p => p.CodigoProducto).ToList();

            var idPk = 1;
            listaEstrategiaComponenteProductos.ForEach(h => h.Id = idPk++);

            idPk = 0;
            foreach (var beEstrategiaProducto in listaBeEstrategiaProductos)
            {
                var componenteModel = (EstrategiaComponenteModel)
                    (listaEstrategiaComponenteProductos.FirstOrDefault(p => beEstrategiaProducto.SAP == p.CodigoProducto)
                    ?? new EstrategiaComponenteModel()).Clone();

                if (Util.Trim(componenteModel.CodigoProducto) == "" &&
                    estrategiaModelo.CodigoVariante != Constantes.TipoEstrategiaSet.CompuestaFija)
                    continue;

                if (listaEstrategiaComponenteProductos.Count(p => beEstrategiaProducto.SAP == p.CodigoProducto) > 1)
                {
                    componenteModel = (EstrategiaComponenteModel)
                        (listaEstrategiaComponenteProductos.FirstOrDefault(p => beEstrategiaProducto.SAP == p.CodigoProducto && p.Id > idPk)
                        ?? new EstrategiaComponenteModel()).Clone();
                }

                componenteModel.NombreComercial = GetNombreComercial(componenteModel, beEstrategiaProducto, codigoTipoEstrategia, true);

                if (!string.IsNullOrEmpty(beEstrategiaProducto.ImagenProducto))
                {
                    componenteModel.Imagen = ConfigCdn.GetUrlFileCdn(Globals.UrlMatriz + "/" + _paisISO, beEstrategiaProducto.ImagenProducto);
                }

                componenteModel.DescripcionMarca = beEstrategiaProducto.NombreMarca;
                componenteModel.IdMarca = beEstrategiaProducto.IdMarca;
                componenteModel.Orden = beEstrategiaProducto.Orden;
                componenteModel.Grupo = beEstrategiaProducto.Grupo;
                componenteModel.PrecioCatalogo = beEstrategiaProducto.Precio;
                componenteModel.PrecioCatalogoString = Util.DecimalToStringFormat(beEstrategiaProducto.Precio, _paisISO);
                componenteModel.Digitable = beEstrategiaProducto.Digitable;
                componenteModel.Cuv = Util.Trim(beEstrategiaProducto.CUV);
                componenteModel.Cantidad = beEstrategiaProducto.Cantidad;
                componenteModel.FactorCuadre = beEstrategiaProducto.FactorCuadre > 0 ? beEstrategiaProducto.FactorCuadre : 1;

                listaComponentesTemporal.Add(componenteModel);
                idPk = componenteModel.Id;
            }

            listaEstrategiaComponenteProductos = EstrategiaComponenteLimpieza(estrategiaModelo.CodigoVariante, listaComponentesTemporal);

            return listaEstrategiaComponenteProductos;
        }

        private List<EstrategiaComponenteModel> GetEstrategiaDetalleCompuesta(EstrategiaPersonalizadaProductoModel estrategiaModelo,
                                                                    List<BEEstrategiaProducto> listaBeEstrategiaProductos,
                                                                    string codigoTipoEstrategia)
        {
            var listaEstrategiaComponenteProductos = new List<EstrategiaComponenteModel>();
            listaBeEstrategiaProductos = listaBeEstrategiaProductos.OrderBy(p => p.Grupo).ToList();

            //var idPk = 0;
            foreach (var beEstrategiaProducto in listaBeEstrategiaProductos)
            {
                var componenteModel = new EstrategiaComponenteModel { };

                componenteModel.NombreComercial = GetNombreComercial(componenteModel, beEstrategiaProducto, codigoTipoEstrategia, false);

                componenteModel.Descripcion = beEstrategiaProducto.Descripcion;
                componenteModel.NombreBulk = beEstrategiaProducto.NombreBulk;
                componenteModel.ImagenBulk = beEstrategiaProducto.ImagenBulk;
                componenteModel.DescripcionMarca = beEstrategiaProducto.NombreMarca;
                componenteModel.IdMarca = beEstrategiaProducto.IdMarca;
                componenteModel.Orden = beEstrategiaProducto.Orden;
                componenteModel.Grupo = beEstrategiaProducto.Grupo;
                componenteModel.PrecioCatalogo = beEstrategiaProducto.Precio;
                componenteModel.PrecioCatalogoString = Util.DecimalToStringFormat(beEstrategiaProducto.Precio, _paisISO);
                componenteModel.Digitable = beEstrategiaProducto.Digitable;
                componenteModel.Cuv = Util.Trim(beEstrategiaProducto.CUV);
                componenteModel.Cantidad = beEstrategiaProducto.Cantidad;
                componenteModel.FactorCuadre = beEstrategiaProducto.FactorCuadre > 0 ? beEstrategiaProducto.FactorCuadre : 1;

                listaEstrategiaComponenteProductos.Add(componenteModel);
                //idPk = componenteModel.Id;
            }

            listaEstrategiaComponenteProductos = EstrategiaComponenteLimpieza(estrategiaModelo.CodigoVariante, listaEstrategiaComponenteProductos);

            return listaEstrategiaComponenteProductos;
        }

        private List<EstrategiaComponenteModel> EstrategiaComponenteLimpieza(string codigoVariante, List<EstrategiaComponenteModel> listaEstrategiaComponenteProductos)
        {
            switch (codigoVariante)
            {
                case Constantes.TipoEstrategiaSet.CompuestaFija:
                    listaEstrategiaComponenteProductos.ForEach(h => { h.Digitable = 0; });
                    listaEstrategiaComponenteProductos = listaEstrategiaComponenteProductos.Where(h => h.NombreComercial != "").ToList();
                    break;
                case Constantes.TipoEstrategiaSet.IndividualConTonos:
                    if (listaEstrategiaComponenteProductos.Any())
                    {
                        listaEstrategiaComponenteProductos.ForEach(h => { h.Digitable = 0; h.FactorCuadre = 1; });
                        listaEstrategiaComponenteProductos = listaEstrategiaComponenteProductos
                            .Where(h => h.NombreComercial != "")
                            .OrderBy(h => h.Orden).ToList();
                    }
                    break;
                default:
                    var listaComponentes = new List<EstrategiaComponenteModel>();
                    EstrategiaComponenteModel hermano;
                    foreach (var item in listaEstrategiaComponenteProductos)
                    {
                        hermano = (EstrategiaComponenteModel)item.Clone();
                        hermano.Hermanos = new List<EstrategiaComponenteModel>();
                        if (hermano.Digitable == 1)
                        {
                            var existe = false;
                            foreach (var itemR in listaComponentes)
                            {
                                existe = itemR.Hermanos.Any(h => h.Cuv == hermano.Cuv);
                                if (existe) break;
                            }
                            if (existe) continue;

                            hermano.Hermanos = listaEstrategiaComponenteProductos.Where(p => p.Grupo == hermano.Grupo).OrderBy(p => p.Orden).ToList();
                        }

                        if (hermano.Hermanos.Any())
                        {
                            hermano.NombreComercial = GetNombreComercialSinBulk(hermano);
                        }

                        listaComponentes.Add(hermano);
                    }

                    listaEstrategiaComponenteProductos = listaComponentes.OrderBy(p => p.Orden).ToList();
                    break;
            }

            return listaEstrategiaComponenteProductos;
        }

        private string GetNombreComercial(EstrategiaComponenteModel componenteModel, BEEstrategiaProducto beEstrategiaProducto, string codigoTipoEstrategia, bool esMs)
        {
            beEstrategiaProducto.NombreProducto = Util.Trim(beEstrategiaProducto.NombreProducto);
            beEstrategiaProducto.NombreBulk = Util.Trim(beEstrategiaProducto.NombreBulk);
            beEstrategiaProducto.Volumen = Util.Trim(beEstrategiaProducto.Volumen);

            componenteModel.NombreComercial = Util.Trim(componenteModel.NombreComercial);
            componenteModel.NombreBulk = Util.Trim(componenteModel.NombreBulk);
            componenteModel.Volumen = Util.Trim(componenteModel.Volumen);

            componenteModel.NombreBulk = beEstrategiaProducto.NombreBulk == "" ? componenteModel.NombreBulk : beEstrategiaProducto.NombreBulk;
            componenteModel.Volumen = beEstrategiaProducto.Volumen == "" ? componenteModel.Volumen : beEstrategiaProducto.Volumen;

            if (codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.ShowRoom)
            {
                componenteModel.NombreComercial = beEstrategiaProducto.NombreProducto == "" ?
                    beEstrategiaProducto.NombreComercial : beEstrategiaProducto.NombreProducto;
            }
            else
            {
                if (esMs)
                {
                    if (componenteModel.NombreComercial == "")
                    {
                        componenteModel.NombreComercial = beEstrategiaProducto.NombreProducto;
                    }
                }
                else
                {
                    componenteModel.NombreComercial = beEstrategiaProducto.NombreComercial == "" ?
                        beEstrategiaProducto.NombreProducto : beEstrategiaProducto.NombreComercial;
                }
            }

            if (componenteModel.NombreBulk != "" && !(" " + componenteModel.NombreComercial.ToLower() + " ").Contains(" " + componenteModel.NombreBulk.ToLower() + " "))
            {
                componenteModel.NombreComercial = string.Concat(componenteModel.NombreComercial, " ", componenteModel.NombreBulk);
            }

            if (componenteModel.Volumen != "" && !(" " + componenteModel.NombreComercial.ToLower() + " ").Contains(" " + componenteModel.Volumen.ToLower() + " "))
            {
                componenteModel.NombreComercial = string.Concat(componenteModel.NombreComercial, " ", componenteModel.Volumen);
            }

            return Util.Trim(componenteModel.NombreComercial);
        }

        private string GetNombreComercialSinBulk(EstrategiaComponenteModel hermano)
        {
            string NombreComercialCompleto = Util.Trim(hermano.NombreComercial);
            string NombreComercial = NombreComercialCompleto.ToUpper();
            string Bulk = Util.Trim(hermano.NombreBulk).ToUpper();
            int pos = NombreComercial.IndexOf(Bulk);
            if (pos >= 0)
            {
                int longitudBulk = Bulk.Length;
                NombreComercialCompleto = hermano.NombreComercial.Substring(0, pos);
                NombreComercialCompleto += " " + hermano.NombreComercial.Substring(pos + longitudBulk);
            }

            if (NombreComercialCompleto.Trim().ToLower() == hermano.Volumen.Trim().ToLower() || NombreComercialCompleto.Trim() == "")
            {
                NombreComercialCompleto = Util.Trim(hermano.NombreComercial);
            }

            return NombreComercialCompleto.Trim();
        }

        //private List<EstrategiaComponenteModel> GetEstrategiaDetalleFactorCuadre(List<EstrategiaComponenteModel> listaHermanos)
        //{
        //    var listaHermanosCuadre = new List<EstrategiaComponenteModel>();

        //    listaHermanos = listaHermanos ?? new List<EstrategiaComponenteModel>();
        //    foreach (var hermano in listaHermanos)
        //    {
        //        listaHermanosCuadre.Add((EstrategiaComponenteModel)hermano.Clone());

        //        if (hermano.FactorCuadre <= 1) continue;
        //        for (var i = 0; i < hermano.FactorCuadre - 1; i++)
        //        {
        //            listaHermanosCuadre.Add((EstrategiaComponenteModel)hermano.Clone());
        //        }
        //    }

        //    return listaHermanosCuadre;
        //}

        private List<EstrategiaComponenteModel> OrdenarComponentesPorMarca(List<EstrategiaComponenteModel> listaComponentesPorOrdenar, out bool esMultimarca)
        {
            var ordenESIKA = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.ORDEN_COMPONENTES_FICHA_ESIKA);
            var ordenLBEL = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.ORDEN_COMPONENTES_FICHA_LBEL);
            var aordenESIKA = ordenESIKA.Split(',');
            var aordenLBEL = ordenLBEL.Split(',');

            var soyPaisEsika = SoyPaisEsika(_paisISO);
            var soyPaisLbel = PaisesLBel(_paisISO);
            int contador = 0;
            var listaComponentesOrdenados = new List<EstrategiaComponenteModel>();
            var listaComponentesCyzone = !listaComponentesPorOrdenar.Any() ? new List<EstrategiaComponenteModel>() : listaComponentesPorOrdenar.Where(x => x.IdMarca == Constantes.Marca.Cyzone);
            var listaComponentesEzika = !listaComponentesPorOrdenar.Any() ? new List<EstrategiaComponenteModel>() : listaComponentesPorOrdenar.Where(x => x.IdMarca == Constantes.Marca.Esika);
            var listaComponentesLbel = !listaComponentesPorOrdenar.Any() ? new List<EstrategiaComponenteModel>() : listaComponentesPorOrdenar.Where(x => x.IdMarca == Constantes.Marca.LBel);
            contador += listaComponentesCyzone.Any() ? 1 : 0;
            contador += listaComponentesEzika.Any() ? 1 : 0;
            contador += listaComponentesLbel.Any() ? 1 : 0;
            esMultimarca = contador > 1;
            if (soyPaisEsika)
            {
                foreach (string s in aordenESIKA)
                {
                    if (Convert.ToInt16(s) == Constantes.Marca.LBel)
                        listaComponentesOrdenados.AddRange(listaComponentesLbel);
                    if (Convert.ToInt16(s) == Constantes.Marca.Esika)
                        listaComponentesOrdenados.AddRange(listaComponentesEzika);
                    if (Convert.ToInt16(s) == Constantes.Marca.Cyzone)
                        listaComponentesOrdenados.AddRange(listaComponentesCyzone);
                }
            }
            if (soyPaisLbel)
            {
                foreach (string s in aordenLBEL)
                {
                    if (Convert.ToInt16(s) == Constantes.Marca.LBel)
                        listaComponentesOrdenados.AddRange(listaComponentesLbel);
                    if (Convert.ToInt16(s) == Constantes.Marca.Esika)
                        listaComponentesOrdenados.AddRange(listaComponentesEzika);
                    if (Convert.ToInt16(s) == Constantes.Marca.Cyzone)
                        listaComponentesOrdenados.AddRange(listaComponentesCyzone);
                }
            }

            return listaComponentesOrdenados;
        }
        private bool SoyPaisEsika(string _paisISO)
        {
            var paisesEsika = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesEsika);
            string[] _paisEsika = paisesEsika.Split(';');
            return _paisEsika.Any(x => x == _paisISO);
        }

        private bool PaisesLBel(string _paisISO)
        {
            var paiseLBel = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesLBel);
            string[] _paiseLBel = paiseLBel.Split(';');
            return _paiseLBel.Any(x => x == _paisISO);
        }
    }
}