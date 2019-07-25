using System.Collections.Generic;
using Portal.Consultoras.Web.ServiceUsuario;
using System.Linq;
using System;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.Models;
using AutoMapper;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.CaminoBrillante;
using Portal.Consultoras.Web.ServiceODS;
using AutoMapper.Internal;

namespace Portal.Consultoras.Web.Providers
{
    public class CaminoBrillanteProvider
    {
        protected ISessionManager sessionManager = SessionManager.SessionManager.Instance;
        private UsuarioModel usuarioModel { get { return sessionManager.GetUserData(); } }

        #region Validación y Carga

        /// <summary>
        /// Validación si puede acceder a Camino Brillante
        /// </summary>
        public bool ValidacionCaminoBrillante()
        {
            var informacion = GetConsultoraNivelCaminoBrillante();
            if (informacion == null || informacion.NivelConsultora == null || usuarioModel == null || !informacion.NivelConsultora.Any()) return false;
            return usuarioModel.CaminoBrillante;
        }

        /// <summary>
        /// Carga Inicial de Camino Brillante
        /// </summary>
        public bool LoadCaminoBrillante()
        {
            try
            {
                var nivel = GetNivelActual();
                var userModel = usuarioModel;
                userModel.NivelCaminoBrillante = int.Parse(nivel.CodigoNivel);
                sessionManager.SetUserData(userModel);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return false;
            }
            return true;
        }

        #endregion

        #region Niveles

        /// <summary>
        /// Obtiene la escala de niveles del programa de Camino Brillante
        /// <paramref name="matchNivelConsultora"/>
        /// </summary>
        public List<NivelCaminoBrillanteModel> GetNivelesCaminoBrillante(bool matchNivelConsultora = false)
        {
            try
            {
                var consultoraCaminoBrillante = GetConsultoraNivelCaminoBrillante();
                if (consultoraCaminoBrillante == null) return new List<NivelCaminoBrillanteModel>();

                var result = Mapper.Map<List<NivelCaminoBrillanteModel>>(consultoraCaminoBrillante.Niveles.ToList());

                if (matchNivelConsultora)
                {
                    var nivelActualConsultora = GetNivelActualConsultora();
                    if (nivelActualConsultora == null) return result;

                    int nivel = 0;
                    int nivelActual = 0;
                    if (int.TryParse(nivelActualConsultora.Nivel, out nivelActual))
                    {
                        result.Each(e =>
                        {
                            if (int.TryParse(e.CodigoNivel, out nivel))
                            {
                                e.EsPasado = nivel <= nivelActual;
                                e.EsActual = nivel == nivelActual;
                            }
                        });
                    }
                }

                return result;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return new List<NivelCaminoBrillanteModel>();
            }
        }

        /// <summary>
        /// Obtiene solamente el listado de niveles para administrador de contenidos.
        /// </summary>
        public List<NivelCaminoBrillanteModel> GetListaNiveles()
        {
            using (var svc = new UsuarioServiceClient())
            {
                return Mapper.Map<List<NivelCaminoBrillanteModel>>(svc.GetNiveles(usuarioModel.PaisID).ToList());
            }
        }

        /// <summary>
        /// Obtiene solamente el listado de Beneficos para administrador de contenidos.
        /// </summary>
        public List<NivelCaminoBrillanteModel.BeneficioCaminoBrillanteModel> GetListaBeneficiosByNivel(int paisID, string codigoNivel)
        {
            using (var svc = new UsuarioServiceClient())
            {
                return Mapper.Map<List<NivelCaminoBrillanteModel.BeneficioCaminoBrillanteModel>>(svc.GetBeneficiosCaminoBrillante(paisID, codigoNivel).ToList());  
            }
        }
        #endregion

        #region Consultora

        /// <summary>
        /// Obtiene el Nivel Actual
        /// </summary>
        public NivelCaminoBrillanteModel GetNivelActual()
        {
            try
            {
                var oConsultora = GetConsultoraNivelCaminoBrillante();
                if (oConsultora == null || oConsultora.Niveles == null) return null;

                var codigoNivel = oConsultora.NivelConsultora.Where(x => x.EsActual).Select(z => z.Nivel).FirstOrDefault();
                return Mapper.Map<NivelCaminoBrillanteModel>(oConsultora.Niveles.FirstOrDefault(x => x.CodigoNivel == codigoNivel));
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return null;
            }
        }

        /// <summary>
        /// Obtiene los niveles historico de los Consultora en el programa de Camino Brillante
        /// </summary>
        public List<BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante> GetNivelesHistoricosConsultora()
        {
            try
            {
                var consultoraCaminoBrillante = GetConsultoraNivelCaminoBrillante();
                if (consultoraCaminoBrillante == null) return new List<BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante>();

                return consultoraCaminoBrillante.NivelConsultora == null ? new List<BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante>()
                                : consultoraCaminoBrillante.NivelConsultora.ToList();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return new List<BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante>();
            }
        }

        /// <summary>
        /// Obtiene el nivel actual de la Consultora en el programa de Camino Brillante
        /// </summary>
        public BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante GetNivelActualConsultora()
        {
            try
            {
                var consultoraCaminoBrillante = GetConsultoraNivelCaminoBrillante();
                if (consultoraCaminoBrillante == null) return null;

                return consultoraCaminoBrillante.NivelConsultora.FirstOrDefault(x => x.EsActual);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return null;
            }
        }

        /// <summary>
        /// Obtiene el nivel Siguiente de la Consultora en el programa de Camino Brillante
        /// </summary>
        public NivelCaminoBrillanteModel GetNivelSiguienteConsultora()
        {
            try
            {
                var oConsultora = GetConsultoraNivelCaminoBrillante();
                if (oConsultora == null || oConsultora.Niveles == null) return null;

                var codigoNivel = oConsultora.NivelConsultora.Where(x => x.EsActual).Select(z => z.Nivel).FirstOrDefault();
                int codNivel = 0;
                if (!int.TryParse(codigoNivel, out codNivel)) return null;
                codigoNivel = string.Format("{0}", codNivel + 1);

                return Mapper.Map<NivelCaminoBrillanteModel>(oConsultora.Niveles.FirstOrDefault(x => x.CodigoNivel == codigoNivel));
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return null;
            }
        }

        /// <summary>
        /// Obtiene Logros Consultora
        /// </summary>
        public LogroCaminoBrillanteModel GetLogroCaminoBrillante(string key)
        {
            try
            {
                var consultoraCaminoBrillante = GetConsultoraNivelCaminoBrillante();
                if (consultoraCaminoBrillante == null) return null;

                if (key == Constantes.CaminoBrillante.Logros.RESUMEN) return Mapper.Map<LogroCaminoBrillanteModel>(consultoraCaminoBrillante.ResumenLogros);
                if (consultoraCaminoBrillante.Logros == null) return null;

                return Mapper.Map<LogroCaminoBrillanteModel>(consultoraCaminoBrillante.Logros.FirstOrDefault(e => e.Id == key));
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return null;
            }
        }

        /// <summary>
        /// Obtiene el Flag si tiene ofertas especiales
        /// </summary>
        public bool TieneOfertasEspeciales()
        {
            return (GetNivelActual() ?? new NivelCaminoBrillanteModel()).TieneOfertasEspeciales;
        }

        private BEConsultoraCaminoBrillante GetConsultoraNivelCaminoBrillante()
        {
            var resumen = sessionManager.GetConsultoraCaminoBrillante();
            if (resumen == null)
            {
                using (var svc = new UsuarioServiceClient())
                {
                    var beUsuario = Mapper.Map<ServiceUsuario.BEUsuario>(usuarioModel);
                    beUsuario.Zona = usuarioModel.CodigoZona;
                    beUsuario.Region = usuarioModel.CodigorRegion;
                    resumen = svc.GetConsultoraNivelCaminoBrillante(beUsuario);
                }
                sessionManager.SetConsultoraCaminoBrillante(resumen);
            }
            return resumen;
        }

        #endregion

        #region Kits

        /// <summary>
        /// Obtiene Kits disponibles para la consultora
        /// </summary>
        public List<KitCaminoBrillanteModel> GetKitsCaminoBrillante()
        {
            try
            {
                var kits = sessionManager.GetKitCaminoBrillante();
                if (kits != null) return Format(Mapper.Map<List<KitCaminoBrillanteModel>>(kits));

                int nivel = 0;
                var nivelConsultora = GetNivelActualConsultora();
                if (nivelConsultora != null)
                {
                    int.TryParse(nivelConsultora.Nivel, out nivel);
                }

                using (var svc = new PedidoServiceClient())
                {
                    var usuario = new ServicePedido.BEUsuario()
                    {
                        PaisID = usuarioModel.PaisID,
                        CampaniaID = usuarioModel.CampaniaID,
                        ConsultoraID = usuarioModel.ConsultoraID,
                        CodigoConsultora = usuarioModel.CodigoConsultora,
                        NivelCaminoBrillante = usuarioModel.NivelCaminoBrillante,
                    };
                    kits = (svc.GetKitsCaminoBrillante(usuario) ?? new BEKitCaminoBrillante[] { }).ToList();
                }
                if (kits != null && kits.Any(e => e.FlagHistorico))
                {
                    sessionManager.SetKitCaminoBrillante(kits);
                }
                return Format(Mapper.Map<List<KitCaminoBrillanteModel>>(kits));
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return new List<KitCaminoBrillanteModel>();
            }
        }

        #endregion

        #region Demostradores

        /// <summary>
        /// Obtiene Demostradores disponibles para la consultora
        /// </summary>
        public DemostradoresPaginadoModel GetDesmostradoresCaminoBrillante(int cantRegistros = 0, int regMostrados = 0, string codOrdenar = "", string codFiltro = "")
        {
            try
            {
                int nivel = 0;
                var nivelConsultora = GetNivelActualConsultora();
                if (nivelConsultora != null)
                {
                    int.TryParse(nivelConsultora.Nivel, out nivel);
                }

                var usuario = new ServicePedido.BEUsuario()
                {
                    PaisID = usuarioModel.PaisID,
                    CampaniaID = usuarioModel.CampaniaID,
                    ConsultoraID = usuarioModel.ConsultoraID,
                    CodigoConsultora = usuarioModel.CodigoConsultora,
                    NivelCaminoBrillante = usuarioModel.NivelCaminoBrillante,
                };

                BEDemostradoresPaginado demostradores;
                using (var svc = new PedidoServiceClient())
                {
                    demostradores = svc.GetDemostradoresCaminoBrillante(usuario, cantRegistros, regMostrados, codOrdenar, codFiltro);
                }

                var oDemostradores = new DemostradoresPaginadoModel();
                oDemostradores.LstDemostradores = Format(Mapper.Map<List<DemostradorCaminoBrillanteModel>>(demostradores.LstDemostradores));
                oDemostradores.Total = demostradores.Total;
                return oDemostradores;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return new DemostradoresPaginadoModel();
            }
        }

        #endregion

        #region Util Format

        private List<DemostradorCaminoBrillanteModel> Format(List<DemostradorCaminoBrillanteModel> items)
        {
            if (items != null && usuarioModel != null)
            {
                items.Update(e =>
                {
                    e.PaisISO = usuarioModel.CodigoISO;
                    e.CampaniaID = usuarioModel.CampaniaID;
                });
            }
            return items;
        }

        private List<KitCaminoBrillanteModel> Format(List<KitCaminoBrillanteModel> items)
        {
            if (items != null && usuarioModel != null)
            {
                items.Update(e =>
                {
                    e.PaisISO = usuarioModel.CodigoISO;
                    e.CampaniaID = usuarioModel.CampaniaID;
                });
            }
            return items;
        }

        private CarruselCaminoBrillanteModel Format(CarruselCaminoBrillanteModel carrusel)
        {
            if (carrusel == null || usuarioModel == null)
            {
                return carrusel;
            }

            if (carrusel.Items != null)
            {
                carrusel.Items.Update(e =>
                {
                    e.PaisISO = usuarioModel.CodigoISO;
                    e.CampaniaID = usuarioModel.CampaniaID;
                });
            }

            return carrusel;
        }

        #endregion

        #region Busqueda CUV

        /// <summary>
        /// Validación CUV Camino Brillante
        /// </summary>
        public BEValidacionCaminoBrillante ValidarBusquedaCaminoBrillante(string cuv)
        {
            try
            {
                using (var svc = new ServiceODS.ODSServiceClient())
                {
                    var usuario = new ServiceODS.BEUsuario()
                    {
                        PaisID = usuarioModel.PaisID,
                        CampaniaID = usuarioModel.CampaniaID,
                        ConsultoraID = usuarioModel.ConsultoraID,
                        CodigoConsultora = usuarioModel.CodigoConsultora,
                        NivelCaminoBrillante = usuarioModel.NivelCaminoBrillante,
                    };

                    return svc.ValidarBusquedaCaminoBrillante(usuario, cuv);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return new BEValidacionCaminoBrillante() { Validacion = Enumeradores.ValidacionCaminoBrillante.ProductoNoExiste };
            }
        }

        #endregion

        #region Orden y Filtros

        /// <summary>
        /// Filtros del Landing de Ofertas de Camino Brillante
        /// </summary>
        public FiltrosCaminoBrillanteModel GetDatosOrdenFiltros()
        {
            try
            {
                var entidad = sessionManager.GetFiltrosCaminoBrillante();
                if (entidad == null)
                {
                    using (var svc = new PedidoServiceClient())
                        entidad = svc.GetFiltrosCaminoBrillante(usuarioModel.PaisID, false);

                    if (entidad == null) return null;
                    sessionManager.SetFiltrosCaminoBrillante(entidad);
                }

                var oFiltro = new FiltrosCaminoBrillanteModel();
                if (entidad.Filtros.Length > 0)
                    oFiltro.DatosFiltros = Mapper.Map<List<FiltrosDatosCaminoBrillante>>(entidad.Filtros[0].Opciones);
                if (entidad.Ordenamientos.Length > 0)
                    oFiltro.DatosOrden = Mapper.Map<List<OrdenDatosCaminoBrillante>>(entidad.Ordenamientos[0].Opciones);

                return oFiltro;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return null;
            }
        }

        #endregion

        #region Carrusel

        /// <summary>
        /// Carrusel de Camino Brillante
        /// </summary>
        public CarruselCaminoBrillanteModel GetCarruselCaminoBrillante()
        {
            try
            {
                using (var svc = new PedidoServiceClient())
                {
                    var usuario = new ServicePedido.BEUsuario()
                    {
                        PaisID = usuarioModel.PaisID,
                        CampaniaID = usuarioModel.CampaniaID,
                        ConsultoraID = usuarioModel.ConsultoraID,
                        CodigoConsultora = usuarioModel.CodigoConsultora,
                        NivelCaminoBrillante = usuarioModel.NivelCaminoBrillante,
                    };

                    return Format(Mapper.Map<CarruselCaminoBrillanteModel>(svc.GetCarruselCaminoBrillante(usuario)));
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return null;
            }
        }

        #endregion

        #region Mis Ganancias

        /// <summary>
        /// Mis Ganancia de Camino Brillante
        /// </summary>
        public MisGananciasCaminoBrillante GetMisGananciasCaminoBrillante()
        {
            var niveles = GetNivelesHistoricosConsultora() ?? new List<BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante>();
            var funcCampania = FuncToCampaniaShort();
            var misGanancias = new MisGananciasCaminoBrillante()
            {
                SubTitulo = "Campañas",
                Titulo = GetMisGananciasCaminoBrillante_Title(niveles, funcCampania),
                MisGanancias = niveles.OrderBy(e => e.Campania)
                            .Select(e => new MisGananciasCaminoBrillante.GananciaCampaniaCaminoBrillante()
                            {
                                LabelSerie = funcCampania(e.Campania),
                                ValorSerie = decimal.Parse(e.MontoPedido),
                                ValorSerieFormat = Util.DecimalToStringFormat(e.MontoPedido, usuarioModel.CodigoISO),
                                GananciaCampania = e.GananciaCampania,
                                GananciaCampaniaFormat = Util.DecimalToStringFormat(e.GananciaCampania, usuarioModel.CodigoISO),
                                GananciaPeriodo = e.GananciaPeriodo,
                                GananciaPeriodoFormat = Util.DecimalToStringFormat(e.GananciaPeriodo, usuarioModel.CodigoISO),
                                FlagSeleccionMisGanancias = e.FlagSeleccionMisGanancias.HasValue ? e.FlagSeleccionMisGanancias.Value : false
                            }).ToList()
            };
            return misGanancias;
        }

        private string GetMisGananciasCaminoBrillante_Title(List<BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante> niveles, Func<string, string> funcCampania)
        {
            var nivelesOrdenados = niveles.OrderBy(e => e.Campania).ToList();
            if (!nivelesOrdenados.Any()) return string.Empty;
            string end = nivelesOrdenados.Count > 1 ? " a " + funcCampania(nivelesOrdenados[nivelesOrdenados.Count - 1].Campania) : string.Empty;
            return string.Format("Monto de mi pedido {0}{1}", funcCampania(nivelesOrdenados[0].Campania), end);
        }

        private Func<string, string> FuncToCampaniaShort()
        {
            string format = "C{0}";
            return (campania) =>
            {
                if (campania == null) return string.Empty;
                if (campania.Length < 6) return string.Empty;
                return string.Format(format, campania.Substring(4, 2));
            };
        }

        #endregion

        #region Ficha Producto

        /// <summary>
        /// Obtener las Ofertas de Camino Brillante
        /// </summary>
        public List<EstrategiaPersonalizadaProductoModel> ObtenerOfertasCaminoBrillante(int tipoOferta = -1)
        {
            try
            {
                var ofertas = new List<EstrategiaPersonalizadaProductoModel>();
                if (tipoOferta == -1 || tipoOferta == Constantes.CaminoBrillante.TipoOferta.Kit)
                {
                    var kits = GetKitsCaminoBrillante() ?? new List<KitCaminoBrillanteModel>();
                    ofertas.AddRange(kits.Select(e => ToEstrategiaPersonalizadaProductoModel(e)).ToList());
                }
                if (tipoOferta == -1 || tipoOferta == Constantes.CaminoBrillante.TipoOferta.Demostrador)
                {
                    var demostradores = (GetDesmostradoresCaminoBrillante() ?? new DemostradoresPaginadoModel()).LstDemostradores ?? new List<DemostradorCaminoBrillanteModel>();
                    ofertas.AddRange(demostradores.Select(e => ToEstrategiaPersonalizadaProductoModel(e)).ToList());
                }
                return ofertas;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return null;
            }
        }

        /// <summary>
        /// Obtener la estragia necesaria para la ficha Producto
        /// </summary>
        public DetalleEstrategiaFichaDisenoModel GetDetalleEstrategiaFichaModel(string cuv)
        {
            try
            {
                using (var svc = new PedidoServiceClient())
                {
                    var usuario = new ServicePedido.BEUsuario()
                    {
                        PaisID = usuarioModel.PaisID,
                        CampaniaID = usuarioModel.CampaniaID,
                        ConsultoraID = usuarioModel.ConsultoraID,
                        CodigoConsultora = usuarioModel.CodigoConsultora,
                        NivelCaminoBrillante = usuarioModel.NivelCaminoBrillante,
                    };

                    return ToDetalleEstrategiaFichaDisenoModel(svc.GetOfertaCaminoBrillante(usuario, cuv));
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return null;
            }
        }

        private DetalleEstrategiaFichaDisenoModel ToDetalleEstrategiaFichaDisenoModel(BEOfertaCaminoBrillante e, bool loadDetalle = true)
        {
            return new DetalleEstrategiaFichaDisenoModel()
            {
                CodigoEstrategia = e.TipoOferta == 1 ? "036" : "035",
                TipoOfertaCaminoBrillante = e.TipoOferta,
                CodigoPalanca = "0",
                FotoProducto01 = e.FotoProductoMedium,
                TieneStock = true,
                CampaniaID = usuarioModel.CampaniaID,
                CodigoProducto = e.CUV,
                CUV2 = e.CUV,
                DescripcionCompleta = e.DescripcionCUV,
                DescripcionCortada = e.DescripcionCUV,
                DescripcionDetalle = e.DescripcionCUV,
                DescripcionMarca = e.DescripcionMarca,
                DescripcionResumen = e.DescripcionCUV,
                DescripcionCategoria = e.DescripcionCUV,
                EsMultimarca = e.TipoOferta == 1,
                EsOfertaIndependiente = false,
                EsSubcampania = false,
                EstrategiaID = e.EstrategiaID.ToInt(),
                FlagNueva = 0,
                Ganancia = e.PrecioCatalogo - e.PrecioValorizado,
                GananciaString = Util.DecimalToStringFormat(e.PrecioCatalogo - e.PrecioValorizado, usuarioModel.CodigoISO),
                ImagenURL = e.FotoProductoMedium,
                MarcaID = e.MarcaID,
                Precio = e.PrecioCatalogo,
                Precio2 = e.PrecioValorizado,
                PrecioTachado = Util.DecimalToStringFormat(e.PrecioCatalogo, usuarioModel.CodigoISO),
                PrecioVenta = Util.DecimalToStringFormat(e.PrecioValorizado, usuarioModel.CodigoISO),
                TienePaginaProducto = false,
                TienePaginaProductoMob = false,
                TipoAccionAgregar = 2,
                Hermanos = GetHermanos(e, loadDetalle)

            };
        }

        private List<EstrategiaComponenteModel> GetHermanos(BEOfertaCaminoBrillante e, bool loadDetalle)
        {
            if (!loadDetalle) return null;
            switch (e.TipoOferta)
            {
                case Constantes.CaminoBrillante.TipoOferta.Kit:
                    return e.Detalle != null ? e.Detalle.Select(d => ToEstrategiaComponenteModel(d)).ToList() : null;
                case Constantes.CaminoBrillante.TipoOferta.Demostrador:
                    return e.Detalle != null ? e.Detalle.Select(d => ToEstrategiaComponenteModel(d)).ToList() : new List<EstrategiaComponenteModel>() { ToEstrategiaComponenteModel(e) };
            }
            return null;
        }

        private EstrategiaComponenteModel ToEstrategiaComponenteModel(BEOfertaCaminoBrillante e)
        {
            return new EstrategiaComponenteModel()
            {
                TieneStock = true,
                CodigoProducto = e.CUV,
                IdMarca = e.MarcaID,
                DescripcionMarca = e.DescripcionMarca,
                Descripcion = e.DescripcionCUV,
                Cantidad = 1,
                NombreComercial = e.DescripcionCUV,
            };
        }

        private EstrategiaComponenteModel ToEstrategiaComponenteModel(KitCaminoBrillanteModel e)
        {
            return new EstrategiaComponenteModel()
            {
                TieneStock = true,
                CodigoProducto = e.CUV,
                DescripcionMarca = e.DescripcionMarca,
                IdMarca = e.MarcaID,
                Descripcion = e.DescripcionCUV,
                Cantidad = 1,
                NombreComercial = e.DescripcionCUV,
                FactorCuadre = 1
            };
        }

        private EstrategiaPersonalizadaProductoModel ToEstrategiaPersonalizadaProductoModel(KitCaminoBrillanteModel e, bool loadDetalle = true)
        {
            return new EstrategiaPersonalizadaProductoModel()
            {
                TipoOfertaCaminoBrillante = Constantes.CaminoBrillante.TipoOferta.Kit,
                CodigoPalanca = "0",
                FotoProducto01 = e.FotoProductoMedium,
                TieneStock = true,
                CampaniaID = usuarioModel.CampaniaID,
                ClaseBloqueada = "",
                ClaseEstrategia = "",
                CodigoCategoria = "",
                CodigoEstrategia = "036",
                CodigoProducto = e.CUV,
                CodigoVariante = "2002",
                CUV2 = e.CUV,
                DescripcionCompleta = e.DescripcionCUV,
                DescripcionCortada = e.DescripcionCUV,
                DescripcionDetalle = e.DescripcionCUV,
                DescripcionMarca = e.DescripcionMarca,
                DescripcionResumen = e.DescripcionCUV,
                DescripcionCategoria = e.DescripcionCUV,
                EsMultimarca = true,
                EsOfertaIndependiente = false,
                EsSubcampania = false,
                EstrategiaID = 0,
                FlagNueva = 0,
                Ganancia = e.PrecioValorizado - e.PrecioCatalogo,
                GananciaString = Util.DecimalToStringFormat(e.PrecioValorizado - e.PrecioCatalogo, usuarioModel.CodigoISO),
                ImagenURL = e.FotoProductoMedium,
                MarcaID = e.MarcaID,
                Precio = e.PrecioCatalogo,
                Precio2 = e.PrecioValorizado,
                PrecioTachado = e.PrecioValorizadoFormat,
                PrecioVenta = e.PrecioCatalogoFormat,
                TextoLibre = "",
                TienePaginaProducto = false,
                TienePaginaProductoMob = false,
                TipoAccionAgregar = 1,
                Hermanos = (loadDetalle && e.Detalle != null) ? e.Detalle.Select(d => ToEstrategiaComponenteModel(d)).ToList() : null,

            };
        }

        private EstrategiaComponenteModel ToEstrategiaComponenteModel(DemostradorCaminoBrillanteModel e)
        {
            return new EstrategiaComponenteModel()
            {
                TieneStock = true,
                CodigoProducto = e.CUV,
                DescripcionMarca = e.DescripcionMarca,
                Descripcion = e.DescripcionCUV,
                Cantidad = 1,
                NombreComercial = e.DescripcionCUV,
                FactorCuadre = 1
            };
        }

        private List<EstrategiaComponenteModel> ToEstrategiaComponenteModelList(DemostradorCaminoBrillanteModel e)
        {
            var result = new List<EstrategiaComponenteModel>() { ToEstrategiaComponenteModel(e) };
            if (e.Detalle!= null) {
                result.AddRange(e.Detalle.Select(d=> ToEstrategiaComponenteModel(d)));
            }
            return result;
        }

        private EstrategiaPersonalizadaProductoModel ToEstrategiaPersonalizadaProductoModel(DemostradorCaminoBrillanteModel e)
        {
            return new EstrategiaPersonalizadaProductoModel()
            {
                TipoOfertaCaminoBrillante = Constantes.CaminoBrillante.TipoOferta.Demostrador,
                CodigoPalanca = "0",
                FotoProducto01 = e.FotoProductoMedium,
                TieneStock = true,
                CampaniaID = usuarioModel.CampaniaID,
                ClaseBloqueada = "",
                ClaseEstrategia = "",
                CodigoCategoria = "",
                CodigoEstrategia = "035",
                CodigoProducto = e.CUV,
                CodigoVariante = "2002",
                CUV2 = e.CUV2,
                DescripcionCompleta = e.DescripcionCUV,
                DescripcionCortada = e.DescripcionCUV,
                DescripcionDetalle = e.DescripcionCUV,
                DescripcionMarca = e.DescripcionMarca,
                DescripcionResumen = e.DescripcionCUV,
                DescripcionCategoria = e.DescripcionCUV,
                EsMultimarca = false,
                EsOfertaIndependiente = false,
                EsSubcampania = false,
                EstrategiaID = e.EstrategiaID.ToInt(),
                FlagNueva = 0,
                Ganancia = 0,
                GananciaString = "0",
                ImagenURL = e.FotoProductoMedium,
                MarcaID = e.MarcaID,
                Precio = e.PrecioCatalogo,
                Precio2 = e.PrecioValorizado,
                PrecioTachado = e.PrecioValorizadoFormat,
                PrecioVenta = e.PrecioCatalogoFormat,
                TextoLibre = "",
                TienePaginaProducto = false,
                TienePaginaProductoMob = false,
                TipoAccionAgregar = 2,
                Hermanos = ToEstrategiaComponenteModelList(e)
            };
        }

        /// <summary>
        /// Validar si el Origen de Pedido Web Pertenece a Camino Brillante
        /// Nota: Alinear con BLCaminoBrillante.IsOrigenPedidoCaminoBrillante
        /// </summary>
        //public bool IsOrigenPedidoCaminoBrillante(int origenPedidoWeb) {
        //    return origenPedidoWeb == Constantes.OrigenPedidoWeb.CaminoBrillanteDesktopPedido ||
        //            origenPedidoWeb == Constantes.OrigenPedidoWeb.CaminoBrillanteMobilePedido ||
        //            origenPedidoWeb == Constantes.OrigenPedidoWeb.CaminoBrillanteMobilePedido_Ficha ||
        //            origenPedidoWeb == Constantes.OrigenPedidoWeb.CaminoBrillanteDesktopPedido_Ficha ||
        //            origenPedidoWeb == Constantes.OrigenPedidoWeb.CaminoBrillanteAppMobilePedido_Ficha ||
        //            origenPedidoWeb == Constantes.OrigenPedidoWeb.CaminoBrillanteAppMobilePedido_Carrusel ||
        //            origenPedidoWeb == Constantes.OrigenPedidoWeb.CaminoBrillanteAppMobilePedido_Home ||
        //            origenPedidoWeb == Constantes.OrigenPedidoWeb.CaminoBrillanteDesktopPedido_Carrusel_Ficha ||
        //            origenPedidoWeb == Constantes.OrigenPedidoWeb.CaminoBrillanteMobilePedido_Carrusel_Ficha ||
        //            origenPedidoWeb == Constantes.OrigenPedidoWeb.CaminoBrillanteAppConsultorasPedido ||
        //            origenPedidoWeb == Constantes.OrigenPedidoWeb.CaminoBrillanteDesktopPedido_Carrusel ||
        //            origenPedidoWeb == Constantes.OrigenPedidoWeb.CaminoBrillanteMobilePedido_Carrusel
        //            ;
        //}

        #endregion

        #region Configuracion
        public List<BEConfiguracionCaminoBrillante> GetCaminoBrillanteConfiguracion()
        {
            var lst = sessionManager.GetConfiguracionCaminoBrillante();
            if (lst == null || lst.Count == 0)
            {
                using (var svc = new UsuarioServiceClient())
                    lst = svc.GetCaminoBrillanteConfiguracion(usuarioModel.PaisID, "0").ToList();

                if (lst != null) sessionManager.SetConfiguracionCaminoBrillante(lst);
            }
            return lst;
        }

        public NivelCaminoBrillanteModel GetNivelGranBrillante() {
            var configuracion = GetCaminoBrillanteConfiguracion() ?? new List<BEConfiguracionCaminoBrillante>();
            var config = configuracion.Where(e => e.Codigo == "sb_granBrillante").FirstOrDefault();
            if (config != null) {
                return new NivelCaminoBrillanteModel() {
                    DescripcionNivel = config.Descripcion,
                    MontoMinimo = config.Valor
                };
            }
            return null;
        }
        #endregion

        #region Mantenedor Beneficios
        public void InsBeneficioCaminoBrillante(NivelCaminoBrillanteModel.BeneficioCaminoBrillanteModel model)
        {
            var entidad = Mapper.Map<BEBeneficioCaminoBrillante>(model) ?? new BEBeneficioCaminoBrillante();
            using (var svc = new UsuarioServiceClient())
            {
                svc.InsBeneficioCaminoBrillante(usuarioModel.PaisID, entidad);
            }
        }
        #endregion

        #region Configuracion Consultora

        /// <summary>
        /// Obtiene Monto de Incentivo Configurado para la consultora
        /// </summary>
        public bool GetMontoIncentivo(out double montoIncentivo) {
            montoIncentivo = 0;
            try
            {
                var oConsultora = GetConsultoraNivelCaminoBrillante();
                if (oConsultora == null || oConsultora.Configuracion == null) return false;

                var config = oConsultora.Configuracion.Where(e => e.Codigo == "CB_MONTO_INCENTIVO").FirstOrDefault() ?? new BEConfiguracionCaminoBrillante();                
                return double.TryParse(config.Valor, out montoIncentivo);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return false;
            }
        }

        /// <summary>
        /// Flag Animacion Onboarding
        /// </summary>
        public bool TieneOnboardingAnim()
        {
            try
            {
                var oConsultora = GetConsultoraNivelCaminoBrillante();
                if (oConsultora == null || oConsultora.Configuracion == null) return false;

                var config = oConsultora.Configuracion.Where(e => e.Codigo == "CB_CON_ONBOARDING_ANIM").FirstOrDefault() ?? new BEConfiguracionCaminoBrillante();
                return config.Valor == "1";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return false;
            }
        }

        /// <summary>
        /// Flag Animacion Ganancias
        /// </summary>
        public bool TieneGananciaAnim()
        {
            try
            {
                var oConsultora = GetConsultoraNivelCaminoBrillante();
                if (oConsultora == null || oConsultora.Configuracion == null) return false;

                var config = oConsultora.Configuracion.Where(e => e.Codigo == "CB_CON_GANANCIA_ANIM").FirstOrDefault() ?? new BEConfiguracionCaminoBrillante();
                return config.Valor == "1";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return false;
            }
        }

        /// <summary>
        /// Flag Animación Cambio Nivel
        /// </summary>
        public bool TieneCambioNivelAnim()
        {
            try
            {
                var oConsultora = GetConsultoraNivelCaminoBrillante();
                if (oConsultora == null || oConsultora.Configuracion == null) return false;

                var config = oConsultora.Configuracion.Where(e => e.Codigo == "CB_CON_CAMB_NIVEL_ANIM").FirstOrDefault() ?? new BEConfiguracionCaminoBrillante();
                return config.Valor == "1" && CambioNivelConsultora().HasValue;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return false;
            }
        }

        /// <summary>
        /// Value Cambio de Nivel Consultora
        /// </summary>
        public int? CambioNivelConsultora()
        {
            try
            {
                var oConsultora = GetConsultoraNivelCaminoBrillante();
                if (oConsultora == null || oConsultora.Configuracion == null) return null;

                var config = oConsultora.Configuracion.Where(e => e.Codigo == "CB_CON_CAMB_NIVEL_VAL").FirstOrDefault() ?? new BEConfiguracionCaminoBrillante();
                var valor = 0;
                if (int.TryParse(config.Valor, out valor)) {
                    return valor;
                }
                return null;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return null;
            }
        }

        #endregion

    }
}