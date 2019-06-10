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
                var demostradores = new BEDemostradoresPaginado();

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
            if (carrusel != null && usuarioModel != null)
            {
                if (carrusel.Items != null)
                {
                    carrusel.Items.Update(e =>
                    {
                        e.PaisISO = usuarioModel.CodigoISO;
                        e.CampaniaID = usuarioModel.CampaniaID;
                    });
                }
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
            var misGanancias = new MisGananciasCaminoBrillante()
            {
                SubTitulo = "Campañas",
                Titulo = "Monto de mi pedido CXX-CYY",
                MisGanancias = niveles.OrderBy(e => e.Campania)
                            .Select(e => new MisGananciasCaminoBrillante.GananciaCampaniaCaminoBrillante()
                            {
                                LabelSerie = "C" + e.Campania.Substring(4, 2),
                                ValorSerie = decimal.Parse(e.MontoPedido),
                                ValorSerieFormat = Util.DecimalToStringFormat(e.MontoPedido, usuarioModel.CodigoISO),
                                GananciaCampania = e.GananciaCampania,
                                GananciaCampaniaFormat = Util.DecimalToStringFormat(e.GananciaCampania, usuarioModel.CodigoISO),
                                GananciaPeriodo = e.GananciaPeriodo,
                                GananciaPeriodoFormat = Util.DecimalToStringFormat(e.GananciaPeriodo, usuarioModel.CodigoISO),
                            }).ToList()
            };
            return misGanancias;
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
                if (tipoOferta == -1 || tipoOferta == Constantes.CaminoBrillante.TipoOferta.Kit) {
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

        private DetalleEstrategiaFichaDisenoModel ToDetalleEstrategiaFichaDisenoModel(BEOfertaCaminoBrillante e, bool loadDetalle = true) {
            return new DetalleEstrategiaFichaDisenoModel()
            {
                CodigoEstrategia = "036",
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
                EsMultimarca = false,
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

        private List<EstrategiaComponenteModel> GetHermanos(BEOfertaCaminoBrillante e, bool loadDetalle) {
            if (!loadDetalle) return null;
            switch (e.TipoOferta) {
                case Constantes.CaminoBrillante.TipoOferta.Kit:
                    return e.Detalle != null ? e.Detalle.Select(d => ToEstrategiaComponenteModel(d)).ToList() : null;
                case Constantes.CaminoBrillante.TipoOferta.Demostrador:
                    return new List<EstrategiaComponenteModel>() { ToEstrategiaComponenteModel(e) };
            }
            return null;
        }

        private EstrategiaComponenteModel ToEstrategiaComponenteModel(BEOfertaCaminoBrillante e) {
            return new EstrategiaComponenteModel() {
                TieneStock = true,
                CodigoProducto = e.CUV,
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
                Descripcion = e.DescripcionCUV,
                Cantidad = 1,
                NombreComercial = e.DescripcionCUV, 
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
                EsMultimarca = false,
                EsOfertaIndependiente = false,
                EsSubcampania = false,
                //EstrategiaID = e.EstrategiaID.ToInt(),
                EstrategiaID = 0,
                FlagNueva = 0,
                Ganancia = e.PrecioCatalogo - e.PrecioValorizado,
                GananciaString = (e.PrecioCatalogo - e.PrecioValorizado).ToString(),
                ImagenURL = e.FotoProductoMedium,
                MarcaID = e.MarcaID,
                Precio = e.PrecioCatalogo,
                Precio2 = e.PrecioValorizado,
                PrecioTachado = e.PrecioCatalogoFormat,
                PrecioVenta = e.PrecioValorizadoFormat,
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
            };
        }

        private EstrategiaPersonalizadaProductoModel ToEstrategiaPersonalizadaProductoModel(DemostradorCaminoBrillanteModel e) {
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
                CodigoVariante = "",
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
                PrecioTachado = e.PrecioCatalogoFormat,
                PrecioVenta = e.PrecioValorizadoFormat,
                TextoLibre = "",
                TienePaginaProducto = false,
                TienePaginaProductoMob = false,
                TipoAccionAgregar = 2,
                Hermanos = new List<EstrategiaComponenteModel>() { ToEstrategiaComponenteModel(e) }
            };
        }

        #endregion

    }
}