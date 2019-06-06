using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.DetalleEstrategia;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;

namespace Portal.Consultoras.Web.Providers
{
    public class EstrategiaComponenteProvider
    {
        private readonly ConfiguracionManagerProvider _configuracionManagerProvider;

        private int _paisId
        {
            get
            {
                return SessionManager.GetUserData().PaisID;
            }
        }
        private string _paisISO
        {
            get
            {
                return SessionManager.GetUserData().CodigoISO;
            }
        }
        protected OfertaBaseProvider _ofertaBaseProvider;
        protected ISessionManager _sessionManager;
        protected ConsultaProlProvider _consultaProlProvider;
        protected TablaLogicaProvider _tablaLogicaProvider;
        public virtual ISessionManager SessionManager
        {
            get { return _sessionManager; }
            private set { _sessionManager = value; }
        }

        public EstrategiaComponenteProvider() : this(
            Web.SessionManager.SessionManager.Instance,
            new OfertaBaseProvider(),
            new ConfiguracionManagerProvider(),
            new ConsultaProlProvider(),
            new TablaLogicaProvider())
        {
        }

        public EstrategiaComponenteProvider(ISessionManager sessionManager,
            OfertaBaseProvider ofertaBaseProvider,
            ConfiguracionManagerProvider configuracionManagerProvider,
            ConsultaProlProvider consultaProlProvider,
            TablaLogicaProvider tablaLogicaProvider)
        {
            _configuracionManagerProvider = configuracionManagerProvider;
            _ofertaBaseProvider = ofertaBaseProvider;
            this.SessionManager = sessionManager;
            _consultaProlProvider = consultaProlProvider;
            _tablaLogicaProvider = tablaLogicaProvider;
        }

        public List<EstrategiaComponenteModel> GetListaComponentes(EstrategiaPersonalizadaProductoModel estrategiaModelo, string codigoTipoEstrategia, out bool esMultimarca, out string mensaje)
        {
            esMultimarca = false;
            mensaje = "";

            var userData = SessionManager.GetUserData();
            List<EstrategiaComponenteModel> listaEstrategiaComponente;

            if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, codigoTipoEstrategia))
            {
                mensaje += "SiMongo|";
                estrategiaModelo.CodigoEstrategia = Util.GetTipoPersonalizacionByCodigoEstrategia(codigoTipoEstrategia);
                var estrategia = _ofertaBaseProvider.ObtenerModeloOfertaDesdeApi(estrategiaModelo, userData.CodigoISO);

                listaEstrategiaComponente = estrategia.Hermanos;
                esMultimarca = estrategia.EsMultimarca;

                listaEstrategiaComponente.ForEach(c =>
                {
                    c.TieneDetalleSeccion = (c.Secciones ?? new List<EstrategiaComponenteSeccionModel>()).Any() && c.Cabecera != null;
                });

                mensaje += "ObtenerModeloOfertaDesdeApi = " + listaEstrategiaComponente.Count;
            }
            else
            {
                mensaje += "NoMongo|";

                List<BEEstrategiaProducto> listaBeEstrategiaProductos;
                if (codigoTipoEstrategia == "36" || codigoTipoEstrategia == "35")
                    return estrategiaModelo.Hermanos;
                else
                    listaBeEstrategiaProductos = GetEstrategiaProductos(estrategiaModelo);

                if (!listaBeEstrategiaProductos.Any()) return new List<EstrategiaComponenteModel>();

                mensaje += "GetEstrategiaProductos = " + listaBeEstrategiaProductos.Count + "|";

                listaEstrategiaComponente = GetEstrategiaDetalleCompuesta(estrategiaModelo, listaBeEstrategiaProductos);
                mensaje += "GetEstrategiaDetalleCompuesta = " + listaEstrategiaComponente.Count + "|";

                listaEstrategiaComponente = OrdenarComponentesPorMarca(listaEstrategiaComponente, out esMultimarca);
                mensaje += "OrdenarComponentesPorMarca = " + listaEstrategiaComponente.Count + "|";
            }

            listaEstrategiaComponente = FormatterEstrategiaComponentes(listaEstrategiaComponente, estrategiaModelo.CUV2, estrategiaModelo.CampaniaID);

            return listaEstrategiaComponente;
        }

        public List<EstrategiaComponenteModel> FormatterEstrategiaComponentes(List<EstrategiaComponenteModel> listaEstrategiaComponente, string cuv2, int campania, bool esApiFicha = false)
        {
            var userData = SessionManager.GetUserData();

            if (listaEstrategiaComponente.Any())
            {
                listaEstrategiaComponente.ForEach(x =>
                {
                    x.TieneStock = true;
                    if (x.Hermanos != null && x.Hermanos.Any())
                    {
                        x.Hermanos.ForEach(y => y.TieneStock = true);

                        if (esApiFicha)
                        {
                            //Temporal mientras se utiliza el Grupo como identificador en vez del Cuv
                            x.Cuv = x.Hermanos[0].Cuv;
                        }
                    }
                });

                var validarDias = _consultaProlProvider.GetValidarDiasAntesStock(userData);
                _consultaProlProvider.ActualizarComponenteStockPROL(listaEstrategiaComponente, cuv2, userData.CodigoISO, campania, userData.GetCodigoConsultora(), validarDias);
            }

            return listaEstrategiaComponente;
        }

        public virtual List<BEEstrategiaProducto> GetEstrategiaProducto(int PaisID, int EstrategiaID)
        {
            List<BEEstrategiaProducto> listaProducto;
            using (var svc = new PedidoServiceClient())
            {
                var parameters = new BEEstrategia { PaisID = PaisID, EstrategiaID = EstrategiaID };
                listaProducto = svc.GetEstrategiaProducto(parameters).ToList();
            }

            return listaProducto;
        }


        private List<BEEstrategiaProducto> GetEstrategiaProductos(EstrategiaPersonalizadaProductoModel estrategiaModelo)
        {
            var listaProducto = new List<BEEstrategiaProducto>();

            if (string.IsNullOrEmpty(estrategiaModelo.CodigoVariante)) return listaProducto;

            listaProducto = GetEstrategiaProducto(_paisId, estrategiaModelo.EstrategiaID);

            var codigoIsoPais = SessionManager.GetUserData().CodigoISO;
            var codigoIsoAppCatalogo = System.Configuration.ConfigurationManager.AppSettings.Get("AppCatalogo_" + codigoIsoPais);
            codigoIsoPais = (codigoIsoAppCatalogo == null) ? codigoIsoPais : codigoIsoAppCatalogo;

            var urlApp = _configuracionManagerProvider.GetRutaImagenesAppCatalogo();
            var urlAppB = _configuracionManagerProvider.GetRutaImagenesAppCatalogoBulk();

            listaProducto.ForEach(x =>
            {
                x.NombreComercial = x.NombreComercial ?? string.Empty;
                x.NombreBulk = String.IsNullOrEmpty(x.NombreBulk) ? x.NombreComercial : x.NombreBulk;
                x.ImagenProducto = x.ImagenProducto ?? string.Empty;
                x.ImagenBulk = x.ImagenBulk ?? string.Empty;
                if (string.IsNullOrWhiteSpace(x.ImagenProducto) && string.IsNullOrWhiteSpace(x.ImagenBulk)) return;
                var codigoMarca = string.Empty;
                if (x.IdMarca == Constantes.Marca.LBel) codigoMarca = "L";
                if (x.IdMarca == Constantes.Marca.Esika) codigoMarca = "E";
                if (x.IdMarca == Constantes.Marca.Cyzone) codigoMarca = "C";

                // Cuando NombreBulk igual a NombreComercial se entiende que es Tipo, caso contrario Tono
                if ((x.NombreComercial.Equals(x.NombreBulk)))
                {
                    x.ImagenBulk = string.IsNullOrEmpty(x.ImagenProducto) ? "" : string.Format(urlApp, codigoIsoPais, x.CampaniaApp, codigoMarca, x.ImagenProducto);
                }
                else
                {
                    x.ImagenBulk = string.IsNullOrEmpty(x.ImagenBulk) ? "" : string.Format(urlAppB, codigoIsoPais, x.CampaniaApp, codigoMarca, x.ImagenBulk);
                }
            });

            return listaProducto;
        }

        private List<EstrategiaComponenteModel> GetEstrategiaDetalleCompuesta(EstrategiaPersonalizadaProductoModel estrategiaModelo,
                                                                    List<BEEstrategiaProducto> listaBeEstrategiaProductos)
        {
            var listaEstrategiaComponenteProductos = new List<EstrategiaComponenteModel>();
            listaBeEstrategiaProductos = listaBeEstrategiaProductos.OrderBy(p => p.Grupo).ToList();

            foreach (var beEstrategiaProducto in listaBeEstrategiaProductos)
            {
                var componenteModel = new EstrategiaComponenteModel { };

                componenteModel.NombreComercial = GetNombreComercial(componenteModel, beEstrategiaProducto, false);

                componenteModel.Descripcion = beEstrategiaProducto.Descripcion;
                componenteModel.NombreBulk = Util.Trim(beEstrategiaProducto.NombreBulk);
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

                    var grupos = new List<EstrategiaComponenteModel>();
                    foreach (var item in listaEstrategiaComponenteProductos)
                    {
                        hermano = (EstrategiaComponenteModel)item.Clone();
                        if (!grupos.Any(g => g.Grupo == hermano.Grupo))
                        {
                            grupos.Add(hermano);
                        }
                    }

                    foreach (var item in grupos)
                    {
                        hermano = (EstrategiaComponenteModel)item.Clone();
                        hermano.Hermanos = new List<EstrategiaComponenteModel>();
                        if (hermano.Digitable == 1)
                        {
                            hermano.Hermanos = listaEstrategiaComponenteProductos
                                .Where(p => p.Grupo == hermano.Grupo && p.NombreBulk != "" && p.Digitable == 1)
                                .OrderBy(p => p.Orden).ToList();
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

        private string GetNombreComercial(EstrategiaComponenteModel componenteModel, BEEstrategiaProducto beEstrategiaProducto, bool esMs)
        {
            beEstrategiaProducto.NombreProducto = Util.Trim(beEstrategiaProducto.NombreProducto);
            beEstrategiaProducto.NombreBulk = Util.Trim(beEstrategiaProducto.NombreBulk);
            beEstrategiaProducto.Volumen = Util.Trim(beEstrategiaProducto.Volumen);

            componenteModel.NombreComercial = Util.Trim(componenteModel.NombreComercial);
            componenteModel.NombreBulk = Util.Trim(componenteModel.NombreBulk);
            componenteModel.Volumen = Util.Trim(componenteModel.Volumen);

            componenteModel.NombreBulk = beEstrategiaProducto.NombreBulk == "" ? componenteModel.NombreBulk : beEstrategiaProducto.NombreBulk;
            componenteModel.Volumen = beEstrategiaProducto.Volumen == "" ? componenteModel.Volumen : beEstrategiaProducto.Volumen;

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

            if (componenteModel.NombreComercial == null)
            {
                componenteModel.NombreComercial = string.Empty;
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

        private List<EstrategiaComponenteModel> OrdenarComponentesPorMarca(List<EstrategiaComponenteModel> listaComponentesPorOrdenar, out bool esMultimarca)
        {
            esMultimarca = false;
            var listaComponentesOrdenados = new List<EstrategiaComponenteModel>();
            if (!listaComponentesPorOrdenar.Any())
            {
                return listaComponentesOrdenados;
            }

            var listaComponentesCyzone = listaComponentesPorOrdenar.Where(x => x.IdMarca == Constantes.Marca.Cyzone);
            var listaComponentesEzika = listaComponentesPorOrdenar.Where(x => x.IdMarca == Constantes.Marca.Esika);
            var listaComponentesLbel = listaComponentesPorOrdenar.Where(x => x.IdMarca == Constantes.Marca.LBel);
            var listaComponentesOtraMarca = !listaComponentesPorOrdenar.Any() ? new List<EstrategiaComponenteModel>()
                : listaComponentesPorOrdenar.Where(x =>
                    x.IdMarca != Constantes.Marca.Cyzone &&
                    x.IdMarca != Constantes.Marca.Esika &&
                    x.IdMarca != Constantes.Marca.LBel);

            int contador = 0;
            contador += listaComponentesCyzone.Any().ToInt();
            contador += listaComponentesEzika.Any().ToInt();
            contador += listaComponentesLbel.Any().ToInt();

            esMultimarca = contador > 1;

            var soyPaisEsika = SoyPaisEsika(_paisISO);
            var soyPaisLbel = PaisesLBel(_paisISO);

            var ordenESIKA = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.ORDEN_COMPONENTES_FICHA_ESIKA);
            var ordenLBEL = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.ORDEN_COMPONENTES_FICHA_LBEL);
            var aordenESIKA = ordenESIKA.Split(',');
            var aordenLBEL = ordenLBEL.Split(',');

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
            else if (soyPaisLbel)
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

            listaComponentesOrdenados.AddRange(listaComponentesOtraMarca);

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
