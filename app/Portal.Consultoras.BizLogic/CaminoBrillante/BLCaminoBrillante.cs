using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data.CaminoBrillante;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.CaminoBrillante;
using Microsoft.Practices.EnterpriseLibrary.Common.Utility;
using System.Globalization;
using Portal.Consultoras.Common.Serializer;
using Portal.Consultoras.Entities.Pedido;
using Portal.Consultoras.BizLogic.CaminoBrillante.Rest;
using Portal.Consultoras.Entities.OrdenYFiltros;

namespace Portal.Consultoras.BizLogic.CaminoBrillante
{
    public class BLCaminoBrillante : ICaminoBrillanteBusinessLogic
    {
        private readonly ITablaLogicaDatosBusinessLogic _tablaLogicaDatosBusinessLogic;
        private readonly IEscalaDescuentoBusinessLogic _escalaDescuentoBusinessLogic;
        private CaminoBrillanteProvider _providerCaminoBrillante;

        public BLCaminoBrillante() : this(new BLTablaLogicaDatos(), new BLEscalaDescuento())
        {
        }

        public BLCaminoBrillante(ITablaLogicaDatosBusinessLogic tablaLogicaDatosBusinessLogic, IEscalaDescuentoBusinessLogic escalaDescuentoBusinessLogic)
        {
            _tablaLogicaDatosBusinessLogic = tablaLogicaDatosBusinessLogic;
            _escalaDescuentoBusinessLogic = escalaDescuentoBusinessLogic;
        }

        #region Niveles

        public List<BENivelCaminoBrillante> GetNiveles(int paisId)
        {
            return GetNivelesCache(paisId);
        }

        private List<BENivelCaminoBrillante> GetNivelesProvider(int paisId)
        {
            _providerCaminoBrillante = _providerCaminoBrillante ?? GetCaminoBrillanteProvider(paisId);
            if (_providerCaminoBrillante == null) return null;

            var lstBeneficios = GetBeneficiosCaminoBrillante(paisId) ?? new List<BEBeneficioCaminoBrillante>();
            var lstNiveles = _providerCaminoBrillante.GetNivel(Util.GetPaisIsoHanna(paisId)).Result;

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteOfertasEspeciales) ?? new List<BETablaLogicaDatos>());
            var tablaLogicaDatosDV = tablaLogicaDatos.FirstOrDefault(e => e.TablaLogicaDatosID == Constantes.CaminoBrillante.Niveles.OfertasEspeciales_TablaLogicaDatos) ?? new BETablaLogicaDatos();
            var TieneOfertasEspecialesDV = "1".Equals(tablaLogicaDatosDV.Valor);

            var tablaLogicaDatosEnterateMas = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteEnterateMas) ?? new List<BETablaLogicaDatos>());

            return lstNiveles.Select(e => Niveles_EnterateMas(new BENivelCaminoBrillante()
            {
                CodigoNivel = e.CodigoNivel,
                DescripcionNivel = e.DescripcionNivel,
                MontoMaximo = e.MontoMaximo,
                MontoMinimo = e.MontoMinimo,
                Puntaje = e.Puntaje,
                TieneOfertasEspeciales = Niveles_TIeneOfertasEspeciales(tablaLogicaDatos, e.CodigoNivel, TieneOfertasEspecialesDV),
                Beneficios = lstBeneficios.Where(b => b.CodigoNivel == e.CodigoNivel && !(string.IsNullOrEmpty(b.NombreBeneficio) && string.IsNullOrEmpty(b.Descripcion))).ToList()
            }, tablaLogicaDatosEnterateMas, e.CodigoNivel)).ToList();
        }

        private bool Niveles_TIeneOfertasEspeciales(List<BETablaLogicaDatos> bETablaLogicaDatos, string codNivel, bool defValor)
        {
            var bETablaLogicaDato = bETablaLogicaDatos.FirstOrDefault(e => e.Codigo == codNivel);
            return bETablaLogicaDato != null ? "1".Equals(bETablaLogicaDato.Valor) : defValor;
        }

        private BENivelCaminoBrillante Niveles_EnterateMas(BENivelCaminoBrillante beNivelCaminoBrillante, List<BETablaLogicaDatos> bETablaLogicaDatos, string codNivel, string defValor = null)
        {
            var bETablaLogicaDato = bETablaLogicaDatos.FirstOrDefault(e => e.Codigo == codNivel);
            if (bETablaLogicaDato == null) return beNivelCaminoBrillante;
            if (string.IsNullOrEmpty(bETablaLogicaDato.Valor)) return beNivelCaminoBrillante;
            var parts = bETablaLogicaDato.Valor.Split('|');
            int tipoEnterateMas = 0;
            if (int.TryParse(parts[0], out tipoEnterateMas))
            {
                beNivelCaminoBrillante.EnterateMas = tipoEnterateMas;
                beNivelCaminoBrillante.EnterateMasParam = (parts.Length == 2 ? parts[1] : string.Empty);
            }
            return beNivelCaminoBrillante;
        }

        private List<BENivelCaminoBrillante> GetNivelesCache(int paisId)
        {
            return CacheManager<List<BENivelCaminoBrillante>>.ValidateDataElement(paisId, ECacheItem.CaminoBrillanteNiveles, () => GetNivelesProvider(paisId));
        }

        private List<BEBeneficioCaminoBrillante> GetBeneficiosCaminoBrillante(int paisId)
        {
            return new DACaminoBrillante(paisId).GetBeneficiosCaminoBrillante().MapToCollection<BEBeneficioCaminoBrillante>(closeReaderFinishing: true);
        }

        #endregion

        #region Periodos

        public BEPeriodoCaminoBrillante GetPeriodo(int paisId, int campaniaId)
        {
            var periodos = GetPeriodosCache(paisId) ?? new List<BEPeriodoCaminoBrillante>();
            return periodos.FirstOrDefault(e => e.CampanaInicial <= campaniaId && campaniaId <= e.CampanaFinal);
        }

        private List<BEPeriodoCaminoBrillante> GetPeriodos(int paisId)
        {
            _providerCaminoBrillante = _providerCaminoBrillante ?? GetCaminoBrillanteProvider(paisId);
            return _providerCaminoBrillante == null
                ? null
                : (_providerCaminoBrillante.GetPeriodo(Util.GetPaisIsoHanna(paisId)).Result ?? new List<PeriodoCaminoBrillante>())
                    .Select(e => new BEPeriodoCaminoBrillante()
                    {
                        CampanaFinal = int.Parse(e.CampanaFinal),
                        CampanaInicial = int.Parse(e.CampanaInicial),
                        IsoPais = e.IsoPais,
                        NroCampana = e.NroCampana,
                        Periodo = int.Parse(e.Periodo)
                    }).ToList();
        }

        private List<BEPeriodoCaminoBrillante> GetPeriodosCache(int paisId)
        {
            return CacheManager<List<BEPeriodoCaminoBrillante>>.ValidateDataElement(paisId, ECacheItem.CaminoBrillantePeriodos, () => GetPeriodos(paisId));
        }

        #endregion

        #region Consultora

        public BEConsultoraCaminoBrillante GetConsultoraNivel(BEUsuario entidad)
        {
            _providerCaminoBrillante = _providerCaminoBrillante ?? GetCaminoBrillanteProvider(entidad.PaisID);
            if (_providerCaminoBrillante == null) return null;

            var periodo = GetPeriodo(entidad.PaisID, entidad.CampaniaID);
            if (periodo == null) return null;

            var nivelesConsultora = _providerCaminoBrillante.GetNivelConsultora(Util.GetPaisIsoHanna(entidad.PaisID), entidad.CodigoConsultora, periodo.NroCampana).Result;
            if (nivelesConsultora == null) return null;

            var nivelConsultora = (nivelesConsultora.FirstOrDefault(e => ((e.Campania == entidad.CampaniaID.ToString()) || (e.Campania == entidad.Campania))) ?? (nivelesConsultora.Count > 0 ? nivelesConsultora.First() : new NivelConsultoraCaminoBrillante()));
            var niveles = GetNiveles(entidad.PaisID);
            var logros = GetConsultoraLogros(entidad, niveles, nivelConsultora, nivelesConsultora, periodo);

            return new BEConsultoraCaminoBrillante()
            {
                NivelConsultora = nivelesConsultora.Select(e => new BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante()
                {
                    Campania = e.Campania,
                    FechaIngreso = e.FechaIngreso,
                    GananciaAnual = e.GananciaAnual,
                    GananciaCampania = e.GananciaCampania,
                    GananciaPeriodo = e.GananciaPeriodo,
                    KitSolicitado = e.KitSolicitado,
                    MontoPedido = e.MontoPedido,
                    Nivel = e.NivelActual,
                    PeriodoCae = e.PeriodoCae,
                    EsActual = (e == nivelConsultora),
                    PuntajeAcumulado = e.PuntajeAcumulado
                }).OrderByDescending(e => e.Campania).ToList(),
                Niveles = CalcularCuantoFalta(niveles, periodo, nivelConsultora, nivelesConsultora),
                ResumenLogros = GetResumenLogros(entidad.PaisID, logros),
                Logros = logros
            };
        }

        private List<BENivelCaminoBrillante> CalcularCuantoFalta(List<BENivelCaminoBrillante> niveles, BEPeriodoCaminoBrillante periodo, NivelConsultoraCaminoBrillante nivelActualConsutora, List<NivelConsultoraCaminoBrillante> consultoraHistoricos)
        {
            if (niveles != null && periodo != null && nivelActualConsutora != null)
            {
                int nivel = 0;
                if (int.TryParse(nivelActualConsutora.NivelActual, out nivel))
                {
                    nivel = nivel + 1;

                    decimal montoPedido = 0;
                    decimal _montoPedido = 0;
                    if (consultoraHistoricos != null)
                    {
                        var peridoStr = periodo.Periodo.ToString();
                        montoPedido = consultoraHistoricos.Where(h => decimal.TryParse(h.MontoPedido, out _montoPedido) && h.PeriodoCae == peridoStr).Sum(h => decimal.Parse(h.MontoPedido));
                    }

                    niveles.Where(e => e.CodigoNivel == nivel.ToString()).Update(e =>
                    {
                        decimal montoMinimo = 0;
                        if (decimal.TryParse(e.MontoMinimo, out montoMinimo) && e.CodigoNivel != "6")
                        {
                            e.MontoFaltante = montoMinimo - montoPedido;
                        }
                    });

                    niveles.Where(e => e.CodigoNivel == "6").Update(e => {
                        if (nivelActualConsutora.PuntajeAcumulado.HasValue)
                        {
                            e.PuntajeAcumulado = nivelActualConsutora.PuntajeAcumulado;
                        }
                    });
 
                }
            }
            return niveles;
        }

        private List<BELogroCaminoBrillante> GetConsultoraLogros(BEUsuario entidad, List<BENivelCaminoBrillante> nivelesCaminoBrillantes,
            NivelConsultoraCaminoBrillante nivelConsultora, List<NivelConsultoraCaminoBrillante> nivelesConsultora, BEPeriodoCaminoBrillante periodoActual)
        {
            return new List<BELogroCaminoBrillante> {
                GetConsultoraLogrosCrecimiento(entidad.PaisID, entidad, nivelesCaminoBrillantes, nivelConsultora, nivelesConsultora, periodoActual),
                GetConsultoraLogrosCompromiso(entidad.PaisID, entidad, nivelConsultora) };
        }

        private BELogroCaminoBrillante GetResumenLogros(int paisId, List<BELogroCaminoBrillante> logros)
        {
            var funcCopyMedalla = GetFunCopyMedalla();
            var funcUltimaMedalla = GetFunUltimaMedalla(logros);
            var funcResumenCompromiso = GetResumenCompromiso(funcUltimaMedalla, logros);

            var medallaEscala = funcCopyMedalla(funcUltimaMedalla(Constantes.CaminoBrillante.Logros.CRECIMIENTO, Constantes.CaminoBrillante.Logros.Indicadores.ESCALA, true),
                                                Constantes.CaminoBrillante.Logros.Indicadores.Titulos[Constantes.CaminoBrillante.Logros.Indicadores.ESCALA], 0);
            var medallaContancia = funcCopyMedalla(funcUltimaMedalla(Constantes.CaminoBrillante.Logros.CRECIMIENTO, Constantes.CaminoBrillante.Logros.Indicadores.CONSTANCIA, false),
                                                Constantes.CaminoBrillante.Logros.Indicadores.Titulos[Constantes.CaminoBrillante.Logros.Indicadores.CONSTANCIA], 1);
            var medallaIncremento = funcCopyMedalla(funcUltimaMedalla(Constantes.CaminoBrillante.Logros.CRECIMIENTO, Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO_PEDIDO, true),
                                                Constantes.CaminoBrillante.Logros.Indicadores.Titulos[Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO_PEDIDO], 2);

            if (medallaContancia != null) medallaContancia.Estado = true;

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteLogros) ?? new List<BETablaLogicaDatos>())
                                    .FirstOrDefault(e => e.Codigo == Constantes.CaminoBrillante.Logros.RESUMEN) ?? new BETablaLogicaDatos();
            var tablaLogicaDatos_Crecimiento = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteLogros) ?? new List<BETablaLogicaDatos>())
                                                .FirstOrDefault(e => e.Codigo == Constantes.CaminoBrillante.Logros.CRECIMIENTO) ?? new BETablaLogicaDatos();
            var tablaLogicaDatos_Compromiso = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteLogros) ?? new List<BETablaLogicaDatos>())
                                                .FirstOrDefault(e => e.Codigo == Constantes.CaminoBrillante.Logros.COMPROMISO) ?? new BETablaLogicaDatos();

            return new BELogroCaminoBrillante()
            {
                Id = Constantes.CaminoBrillante.Logros.RESUMEN,
                Titulo = tablaLogicaDatos.Valor,
                Descripcion = tablaLogicaDatos.Descripcion,
                Indicadores = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante>{
                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante() {
                        Orden = 0,
                        Titulo = tablaLogicaDatos_Crecimiento.Valor,
                        Descripcion = tablaLogicaDatos_Crecimiento.Descripcion,
                        Codigo = Constantes.CaminoBrillante.Logros.CRECIMIENTO,
                        Medallas = (new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>{
                            medallaEscala,
                            medallaContancia,
                            medallaIncremento
                        }).Where(e => e != null).ToList()
                    },
                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante() {
                        Orden = 1,
                        Titulo = tablaLogicaDatos_Compromiso.Valor,
                        Descripcion = tablaLogicaDatos_Compromiso.Descripcion,
                        Codigo = Constantes.CaminoBrillante.Logros.COMPROMISO,
                        Medallas = funcResumenCompromiso()
                    }
                }
            };
        }

        private Func<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante, string, int, BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante> GetFunCopyMedalla()
        {
            Func<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante, string, int, BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante> funcCopyMedalla = (medalla, title, index) =>
            {
                return medalla == null
                    ? null
                    : new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante()
                    {
                        Estado = medalla.Estado,
                        Valor = medalla.Valor,
                        Orden = index,
                        Tipo = medalla.Tipo,
                        Titulo = title
                    };
            };
            return funcCopyMedalla;
        }

        private Func<string, string, bool, BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante> GetFunUltimaMedalla(List<BELogroCaminoBrillante> logros)
        {
            Func<string, string, bool, BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante> funcUltimaMedalla = (logro, indicador, estado) =>
            {
                var _logro = logros.FirstOrDefault(e => e.Id == logro) ?? new BELogroCaminoBrillante();
                var _indicador = _logro.Indicadores.FirstOrDefault(e => e.Codigo == indicador) ?? new BELogroCaminoBrillante.BEIndicadorCaminoBrillante();
                if (_indicador.Medallas != null)
                    return _indicador.Medallas.OrderByDescending(e => e.Orden).FirstOrDefault(e => e.Estado == estado) ?? _indicador.Medallas.OrderBy(e => e.Orden).FirstOrDefault();
                return null;
            };
            return funcUltimaMedalla;
        }

        private Func<List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>> GetResumenCompromiso(Func<string, string, bool, BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante> funcUltimaMedalla, List<BELogroCaminoBrillante> logros)
        {
            Func<List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>> funcResumenCompromiso = () =>
            {
                var lastMedallaProgramaNuevas = funcUltimaMedalla(Constantes.CaminoBrillante.Logros.COMPROMISO, Constantes.CaminoBrillante.Logros.Indicadores.PROGRAMA_NUEVAS, true);
                var lastMedallaTiempoJuntos = funcUltimaMedalla(Constantes.CaminoBrillante.Logros.COMPROMISO, Constantes.CaminoBrillante.Logros.Indicadores.TIEMPO_JUNTOS, true);
                var medallas = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>();

                Action<string, string, BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante> addSerieMedalla = (logro, indicador, medalla) =>
                {
                    if (medalla != null)
                    {
                        var _logro = logros.FirstOrDefault(e => e.Id == logro) ?? new BELogroCaminoBrillante();
                        var _indicador = _logro.Indicadores.FirstOrDefault(e => e.Codigo == indicador) ?? new BELogroCaminoBrillante.BEIndicadorCaminoBrillante();
                        var index = _indicador.Medallas.IndexOf(medalla);

                        var start = Math.Min(Math.Max(index - 1, 0), index);
                        var elements = Math.Min(Math.Max(3 - medallas.Count, 0), _indicador.Medallas.Count);
                        medallas.AddRange(_indicador.Medallas.Skip(start).Take(elements));
                    }
                };

                if (lastMedallaProgramaNuevas != null)
                    addSerieMedalla(Constantes.CaminoBrillante.Logros.COMPROMISO, Constantes.CaminoBrillante.Logros.Indicadores.PROGRAMA_NUEVAS, lastMedallaProgramaNuevas);

                if (medallas.Count < 3 && lastMedallaTiempoJuntos != null)
                    addSerieMedalla(Constantes.CaminoBrillante.Logros.COMPROMISO, Constantes.CaminoBrillante.Logros.Indicadores.TIEMPO_JUNTOS, lastMedallaTiempoJuntos);

                return medallas.Select(e => new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante()
                {
                    Estado = e.Estado,
                    Valor = e.Valor,
                    Orden = e.Orden,
                    Tipo = e.Tipo,
                    Titulo = e.Titulo
                }).Take(3).ToList();
            };

            return funcResumenCompromiso;
        }

        private BELogroCaminoBrillante GetConsultoraLogrosCrecimiento(int paisId, BEUsuario entidad, List<BENivelCaminoBrillante> nivelesCaminoBrillantes, NivelConsultoraCaminoBrillante nivelConsutora, List<NivelConsultoraCaminoBrillante> nivelesConsultora, BEPeriodoCaminoBrillante periodoActual)
        {
            var _cambioEscalaDescuento = GetConsultoraLogrosCrecimiento_CambioEscalaDescuento(paisId, entidad, nivelConsutora);
            var _cambioNivel = GetConsultoraLogrosCrecimiento_CambioNivel(paisId, entidad, nivelConsutora, nivelesCaminoBrillantes);
            var _constancia = GetConsultoraLogrosCrecimiento_Constancia(paisId, entidad, nivelesConsultora, periodoActual);
            var _incrementoPedido = GetConsultoraLogrosCrecimiento_IncrementoPedido(paisId, nivelConsutora);

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteLogros) ?? new List<BETablaLogicaDatos>())
                                    .FirstOrDefault(e => e.Codigo == Constantes.CaminoBrillante.Logros.CRECIMIENTO) ?? new BETablaLogicaDatos();

            return new BELogroCaminoBrillante()
            {
                Id = Constantes.CaminoBrillante.Logros.CRECIMIENTO,
                Titulo = tablaLogicaDatos.Valor,
                Descripcion = tablaLogicaDatos.Descripcion,
                Indicadores = (new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante>{
                            _cambioEscalaDescuento,
                            _cambioNivel,
                            _constancia,
                            _incrementoPedido
                        })
                        .Where(e => e != null).ToList()
            };
        }

        private BELogroCaminoBrillante.BEIndicadorCaminoBrillante GetConsultoraLogrosCrecimiento_CambioEscalaDescuento(int paisId, BEUsuario entidad, NivelConsultoraCaminoBrillante nivelConsultora)
        {
            var escalasDescuento = GetEscalaDescuento(paisId, entidad);
            var configsMedalla = (GetGetConfiguracionMedallaCaminoBrillanteCache(paisId) ?? new List<BEConfiguracionMedallaCaminoBrillante>())
                                 .Where(e => e.Logro == Constantes.CaminoBrillante.Logros.CRECIMIENTO && e.Indicador == Constantes.CaminoBrillante.Logros.Indicadores.ESCALA);
            var TieneEscalaValida = !escalasDescuento.Any(e => e.MontoDesde == 0);
            var idx = 0;
            var medallaEscalas = escalasDescuento.Select(e => new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante()
            {
                Orden = idx++,
                Tipo = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.CIRC,
                Estado = TieneEscalaValida && (e.PorDescuento <= nivelConsultora.CambioEscala),
                Valor = e.PorDescuento + string.Empty,
                MontoSuperior = e.MontoDesde,
            }).ToList();

            medallaEscalas.ForEach(e =>
            {
                var configMedalla = configsMedalla.FirstOrDefault(p => p.Codigo == e.Valor);
                if (configMedalla != null)
                {
                    e.Valor = string.Format(configMedalla.Valor ?? string.Empty, e.Valor);
                    e.ModalTitulo = configMedalla.ComoLograrlo_Estado && TieneEscalaValida ? configMedalla.ComoLograrlo_Titulo.Replace("{0}", e.Valor) : string.Empty;
                    e.ModalDescripcion = configMedalla.ComoLograrlo_Estado && TieneEscalaValida ? (configMedalla.ComoLograrlo_Descripcion).Replace("{0}", string.Format("<b>{0} {1}</b>", entidad.Simbolo, Util.DecimalToStringFormat(Convert.ToDecimal(e.MontoSuperior), entidad.CodigoISO))) : string.Empty;
                }
                else e.Valor = string.Format("{0}%", e.Valor);

                e.Subtitulo = e.Estado ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo;
            });

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteIndicadores) ?? new List<BETablaLogicaDatos>())
                                    .FirstOrDefault(e => e.Codigo == Constantes.CaminoBrillante.Logros.Indicadores.ESCALA) ?? new BETablaLogicaDatos();

            return new BELogroCaminoBrillante.BEIndicadorCaminoBrillante()
            {
                Codigo = Constantes.CaminoBrillante.Logros.Indicadores.ESCALA,
                Titulo = tablaLogicaDatos.Valor,
                Medallas = medallaEscalas.ToList()
            };
        }

        private List<BEEscalaDescuento> GetEscalaDescuento(int paisId, BEUsuario entidad)
        {
            var escalas = _escalaDescuentoBusinessLogic.GetEscalaDescuento(paisId, entidad.CampaniaID, entidad.Region, entidad.Zona) ?? new List<BEEscalaDescuento>();
            if (escalas.Any())
            {
                var montoMinimo = (new DACaminoBrillante(paisId)).GetMontoMinimoEscala(entidad.ConsultoraID);
                foreach (var item in escalas)
                {
                    item.MontoDesde = montoMinimo;
                    montoMinimo = item.MontoHasta;
                }
            }
            return escalas;
        }

        private BELogroCaminoBrillante.BEIndicadorCaminoBrillante GetConsultoraLogrosCrecimiento_CambioNivel(int paisId, BEUsuario entidad, NivelConsultoraCaminoBrillante nivelConsultora, List<BENivelCaminoBrillante> nivelesCaminoBrillantes)
        {
            short nivelActual = 0; short nivelCodigo = 0; var idx = 0; var estado = false;

            short.TryParse(nivelConsultora.NivelActual, out nivelActual);
            var configsMedalla = (GetGetConfiguracionMedallaCaminoBrillanteCache(paisId) ?? new List<BEConfiguracionMedallaCaminoBrillante>()).Where(e => e.Logro == Constantes.CaminoBrillante.Logros.CRECIMIENTO && e.Indicador == Constantes.CaminoBrillante.Logros.Indicadores.NIVEL);
            var medallaNiveles = nivelesCaminoBrillantes.Select(e => new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante()
            {
                Orden = idx++,
                Tipo = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.NIV,
                Estado = short.TryParse(e.CodigoNivel, out nivelCodigo) ? nivelCodigo <= nivelActual : estado,
                Subtitulo = (nivelCodigo <= nivelActual ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo),
                Valor = e.CodigoNivel,
                DescripcionNivel = e.DescripcionNivel,
                MontoAcumulado = e.MontoMinimo,
            }).ToList();

            medallaNiveles.ForEach(e =>
            {
                var configMedalla = configsMedalla.FirstOrDefault(p => p.Codigo == e.Valor);
                if (configMedalla == null) return;

                e.Subtitulo = e.Estado ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo;
                e.ModalTitulo = configMedalla.ComoLograrlo_Estado ? configMedalla.ComoLograrlo_Titulo.Replace("{0}", e.DescripcionNivel) : string.Empty;
                e.ModalDescripcion = configMedalla.ComoLograrlo_Estado ? configMedalla.ComoLograrlo_Descripcion.Replace("{0}", e.DescripcionNivel).Replace("{1}", string.Format("<b>{0} {1}</b>", entidad.Simbolo, Util.DecimalToStringFormat(Convert.ToDecimal(e.MontoAcumulado), entidad.CodigoISO))) : string.Empty;
            });

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteIndicadores) ?? new List<BETablaLogicaDatos>())
                                    .FirstOrDefault(e => e.Codigo == Constantes.CaminoBrillante.Logros.Indicadores.NIVEL) ?? new BETablaLogicaDatos();

            return new BELogroCaminoBrillante.BEIndicadorCaminoBrillante()
            {
                Codigo = Constantes.CaminoBrillante.Logros.Indicadores.NIVEL,
                Titulo = tablaLogicaDatos.Valor,
                Medallas = medallaNiveles.ToList()
            };
        }

        private BELogroCaminoBrillante.BEIndicadorCaminoBrillante GetConsultoraLogrosCrecimiento_Constancia(int paisId, BEUsuario entidad, List<NivelConsultoraCaminoBrillante> nivelesHistoricosConsultora, BEPeriodoCaminoBrillante periodoActual)
        {
            var medallaConstancia = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>();
            var periodos = GetPeriodos(entidad.PaisID);

            var configMedalla = (GetGetConfiguracionMedallaCaminoBrillanteCache(paisId) ?? new List<BEConfiguracionMedallaCaminoBrillante>())
                                .FirstOrDefault(e => e.Logro == Constantes.CaminoBrillante.Logros.CRECIMIENTO && e.Indicador == Constantes.CaminoBrillante.Logros.Indicadores.CONSTANCIA);
            if (configMedalla == null) return null;

            var builderMedallaConstancia = GetBuilderMedallaContancia(periodos, medallaConstancia, periodoActual ?? new BEPeriodoCaminoBrillante(), configMedalla);

            nivelesHistoricosConsultora.ForEach(e =>
            {
                builderMedallaConstancia(e.Periodo1, e.Constancia1);
                builderMedallaConstancia(e.Periodo2, e.Constancia2);
                builderMedallaConstancia(e.Periodo3, e.Constancia3);
                builderMedallaConstancia(e.Periodo4, e.Constancia4);
                builderMedallaConstancia(e.Periodo5, e.Constancia5);
            });

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteIndicadores) ?? new List<BETablaLogicaDatos>())
                                    .FirstOrDefault(e => e.Codigo == Constantes.CaminoBrillante.Logros.Indicadores.CONSTANCIA) ?? new BETablaLogicaDatos();

            if (periodoActual != null && (medallaConstancia.Count == 0 || !medallaConstancia.Any(e => e.Valor.StartsWith(periodoActual.Periodo.ToString()))))
            {
                medallaConstancia.Add(new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante()
                {
                    Tipo = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.PIE,
                    Titulo = string.Format(configMedalla.Valor ?? string.Empty, (periodoActual.CampanaInicial % 100), (periodoActual.CampanaFinal % 100)),
                    Subtitulo = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo,
                    ModalTitulo = configMedalla.ComoLograrlo_Estado ? configMedalla.ComoLograrlo_Titulo : string.Empty,
                    ModalDescripcion = configMedalla.ComoLograrlo_Estado ? configMedalla.ComoLograrlo_Descripcion : string.Empty,
                    Valor = string.Format("{0}-{1}-{2}", periodoActual.Periodo, periodoActual.NroCampana, 0),
                    Estado = true
                });
            }

            if (periodoActual != null)
            {
                medallaConstancia.Where(e => e.Valor.StartsWith(periodoActual.Periodo.ToString()))
                    .Update(e =>
                    {
                        e.Estado = false;
                    });
            }

            var orden = 0;
            medallaConstancia = medallaConstancia.OrderBy(e => e.Valor).ToList();
            medallaConstancia.ForEach(e => { e.Orden = orden++; });

            return new BELogroCaminoBrillante.BEIndicadorCaminoBrillante()
            {
                Titulo = tablaLogicaDatos.Valor,
                Codigo = Constantes.CaminoBrillante.Logros.Indicadores.CONSTANCIA,
                Medallas = medallaConstancia
            };
        }

        private Action<string, int> GetBuilderMedallaContancia(List<BEPeriodoCaminoBrillante> periodos, List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante> medallaConstancia,
            BEPeriodoCaminoBrillante _periodoActual, BEConfiguracionMedallaCaminoBrillante configMedalla)
        {
            var _periodo = 0;

            Action<string, int> builderMedallaConstancia = (periodo, constancia) =>
            {
                if (!int.TryParse(periodo, out _periodo)) return;

                var periodoCaminoBrillante = periodos.FirstOrDefault(e => e.Periodo == _periodo);
                if (periodoCaminoBrillante == null) return;

                var valor = string.Format("{0}-{1}-{2}", periodoCaminoBrillante.Periodo, periodoCaminoBrillante.NroCampana, constancia);
                if (medallaConstancia.Any(e => e.Valor == valor)) return;

                var estado = (configMedalla.ComoLograrlo_Estado && _periodoActual.Periodo == _periodo);
                medallaConstancia.Add(new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante()
                {
                    Tipo = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.PIE,
                    Estado = true,
                    Titulo = string.Format(configMedalla.Valor ?? string.Empty, (periodoCaminoBrillante.CampanaInicial % 100), (periodoCaminoBrillante.CampanaFinal % 100)),
                    Subtitulo = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo,
                    ModalTitulo = configMedalla.ComoLograrlo_Estado && estado ? configMedalla.ComoLograrlo_Titulo : string.Empty,
                    ModalDescripcion = configMedalla.ComoLograrlo_Estado && estado ? configMedalla.ComoLograrlo_Descripcion : string.Empty,
                    Valor = valor,
                });
            };
            return builderMedallaConstancia;
        }

        private BELogroCaminoBrillante.BEIndicadorCaminoBrillante GetConsultoraLogrosCrecimiento_IncrementoPedido(int paisId, NivelConsultoraCaminoBrillante nivelConsultora)
        {
            var idx = 0;
            int incremento = 0;

            var configMedalla = (GetGetConfiguracionMedallaCaminoBrillanteCache(paisId) ?? new List<BEConfiguracionMedallaCaminoBrillante>())
                                .Where(e => e.Logro == Constantes.CaminoBrillante.Logros.CRECIMIENTO && e.Indicador == Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO_PEDIDO);

            var medallaIncrementoPedido = configMedalla
                .Where(e => int.TryParse(e.Codigo, out incremento))
                .Select(e => new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante()
                {
                    Orden = idx++,
                    Tipo = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.CIRC,
                    Estado = (int.Parse(e.Codigo) <= (nivelConsultora.PorcentajeIncremento.HasValue ? nivelConsultora.PorcentajeIncremento : 0)),
                    Subtitulo = (int.Parse(e.Codigo) <= (nivelConsultora.PorcentajeIncremento.HasValue ? nivelConsultora.PorcentajeIncremento : 0)) ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo,
                    Valor = string.Format(e.Valor ?? string.Empty, e.Codigo),
                    ModalTitulo = e.ComoLograrlo_Estado ? e.ComoLograrlo_Titulo.Replace("{0}", string.Format("{0}%", e.Codigo)) : string.Empty,
                    ModalDescripcion = e.ComoLograrlo_Estado ? e.ComoLograrlo_Descripcion.Replace("{0}", string.Format("{0}%", e.Codigo)) : string.Empty,
                }).ToList();

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteIndicadores) ?? new List<BETablaLogicaDatos>())
                                    .FirstOrDefault(e => e.Codigo == Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO_PEDIDO) ?? new BETablaLogicaDatos();

            return new BELogroCaminoBrillante.BEIndicadorCaminoBrillante()
            {
                Titulo = tablaLogicaDatos.Valor,
                Codigo = Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO_PEDIDO,
                Medallas = medallaIncrementoPedido
            };
        }

        private BELogroCaminoBrillante GetConsultoraLogrosCompromiso(int paisId, BEUsuario entidad, NivelConsultoraCaminoBrillante nivelConsultora)
        {
            var medallasProgramaNuevas = GetConsultoraLogrosCompromiso_ProgramaNuevas(paisId, entidad);
            var medallasTiempoJuntos = GetConsultoraLogrosCompromiso_TiempoJuntos(paisId, nivelConsultora);

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteLogros) ?? new List<BETablaLogicaDatos>())
                                    .FirstOrDefault(e => e.Codigo == Constantes.CaminoBrillante.Logros.COMPROMISO) ?? new BETablaLogicaDatos();

            return new BELogroCaminoBrillante()
            {
                Id = Constantes.CaminoBrillante.Logros.COMPROMISO,
                Titulo = tablaLogicaDatos.Valor,
                Descripcion = tablaLogicaDatos.Descripcion,
                Indicadores = (new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante> { medallasProgramaNuevas, medallasTiempoJuntos })
                              .Where(e => e != null).ToList()
            };
        }

        private BELogroCaminoBrillante.BEIndicadorCaminoBrillante GetConsultoraLogrosCompromiso_ProgramaNuevas(int paisId, BEUsuario entidad)
        {
            var listEstadosValidos = new List<int> { Constantes.EstadoActividadConsultora.Registrada, Constantes.EstadoActividadConsultora.Retirada, Constantes.EstadoActividadConsultora.Ingreso_Nueva };
            var showMedallasNuevas = listEstadosValidos.Contains(entidad.ConsultoraNueva);

            if (showMedallasNuevas)
            {
                var configMedalla = (GetGetConfiguracionMedallaCaminoBrillanteCache(paisId) ?? new List<BEConfiguracionMedallaCaminoBrillante>())
                                    .Where(e => e.Logro == Constantes.CaminoBrillante.Logros.COMPROMISO && e.Indicador == Constantes.CaminoBrillante.Logros.Indicadores.PROGRAMA_NUEVAS);

                int valPedido = 0;
                int orden = 0;
                var tablaLogicaDatos = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteIndicadores) ?? new List<BETablaLogicaDatos>())
                                        .FirstOrDefault(e => e.Codigo == Constantes.CaminoBrillante.Logros.Indicadores.PROGRAMA_NUEVAS) ?? new BETablaLogicaDatos();

                return new BELogroCaminoBrillante.BEIndicadorCaminoBrillante()
                {
                    Titulo = tablaLogicaDatos.Valor,
                    Codigo = Constantes.CaminoBrillante.Logros.Indicadores.PROGRAMA_NUEVAS,
                    Medallas = configMedalla.Where(e => int.TryParse(e.Codigo, out valPedido))
                               .Select(e => new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante()
                               {
                                   Orden = orden++,
                                   Estado = (int.Parse(e.Codigo) <= entidad.ConsecutivoNueva),
                                   Tipo = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.PED,
                                   Valor = e.Codigo,
                                   Titulo = string.Format(e.Valor, e.Codigo),
                                   Subtitulo = (int.Parse(e.Codigo) <= entidad.ConsecutivoNueva) ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo,
                                   ModalTitulo = e.ComoLograrlo_Estado ? e.ComoLograrlo_Titulo : string.Empty,
                                   ModalDescripcion = e.ComoLograrlo_Estado ? e.ComoLograrlo_Descripcion : string.Empty
                               }).ToList()
                };
            }
            return null;
        }

        private BELogroCaminoBrillante.BEIndicadorCaminoBrillante GetConsultoraLogrosCompromiso_TiempoJuntos(int paisId, NivelConsultoraCaminoBrillante nivelConsultora)
        {
            var aniosConsultora = -1;
            if (!string.IsNullOrEmpty(nivelConsultora.FechaIngreso))
            {
                var strFechaIngreso = nivelConsultora.FechaIngreso.Substring(0, Math.Min(19, nivelConsultora.FechaIngreso.Length));
                var format = Constantes.Formatos.FechaHoraUTC;
                DateTime anioIngreso;

                if (DateTime.TryParseExact(strFechaIngreso, format, CultureInfo.InvariantCulture, DateTimeStyles.None, out anioIngreso))
                {
                    aniosConsultora = Math.Max(0, DateTime.Today.AddTicks(-anioIngreso.Ticks).Year - 1);
                }
            }

            var configMedalla = (GetGetConfiguracionMedallaCaminoBrillanteCache(paisId) ?? new List<BEConfiguracionMedallaCaminoBrillante>())
                                .Where(e => e.Logro == Constantes.CaminoBrillante.Logros.COMPROMISO && e.Indicador == Constantes.CaminoBrillante.Logros.Indicadores.TIEMPO_JUNTOS);

            int anios = 0;
            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteIndicadores) ?? new List<BETablaLogicaDatos>())
                                    .FirstOrDefault(e => e.Codigo == Constantes.CaminoBrillante.Logros.Indicadores.TIEMPO_JUNTOS) ?? new BETablaLogicaDatos();

            var orden = 0;
            var tiempoJuntos = new BELogroCaminoBrillante.BEIndicadorCaminoBrillante()
            {
                Titulo = tablaLogicaDatos.Valor,
                Codigo = Constantes.CaminoBrillante.Logros.Indicadores.TIEMPO_JUNTOS,
                Medallas = configMedalla
                .Where(e => int.TryParse(e.Codigo, out anios))
                .Select(e => new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante()
                {
                    Orden = orden++,
                    Tipo = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.TIM,
                    Estado = (anios <= aniosConsultora && aniosConsultora != -1),
                    Titulo = string.Format(e.Valor ?? string.Empty, anios),
                    ModalTitulo = e.ComoLograrlo_Estado ? e.ComoLograrlo_Titulo : string.Empty,
                    ModalDescripcion = e.ComoLograrlo_Estado ? e.ComoLograrlo_Descripcion : string.Empty,
                    Valor = e.Codigo
                }).ToList()
            };

            return tiempoJuntos;
        }

        #endregion

        #region Kits

        public List<BEKitCaminoBrillante> GetKits(BEUsuario entidad)
        {
            var periodo = GetPeriodo(entidad.PaisID, entidad.CampaniaID);
            if (periodo == null) return null;

            var kits = GetKits(entidad.PaisID, entidad.CampaniaID, periodo.Periodo, entidad.NivelCaminoBrillante);
            if (kits == null) return null;

            var ofertasHistoricos = GeOfertasHistoricos(entidad.PaisID, entidad.ConsultoraID, entidad.CodigoConsultora, entidad.CampaniaID, periodo.Periodo);

            /* Deshabilitamos de acuerdo al Historico de la Consultora */
            if (ofertasHistoricos != null && ofertasHistoricos.Any(e => kits.Any(k => k.CUV == e.CUV)))
            {
                var codKits = ofertasHistoricos.Select(e => e.CUV);
                var codKitsProviders = ofertasHistoricos.Where(e => e.FlagHistorico).Select(e => e.CUV);

                kits.ForEach(e =>
                {
                    e.FlagHabilitado = false;
                    e.FlagSeleccionado = codKits.Contains(e.CUV);
                    e.FlagHistorico = codKitsProviders.Contains(e.CUV);
                });
            }

            return kits.OrderBy(e => e.CodigoNivel).ToList();
        }

        private List<BEKitCaminoBrillante> GetKits(int paisId, int campaniaId, int periodoId, int nivelId)
        {
            var nivelKit = 0;
            var kits = GetKitsCache(paisId, periodoId, campaniaId);
            if (kits == null) return new List<BEKitCaminoBrillante>();

            /* Deshabilitamos de acuerdo al Nievel */
            kits.Where(e => int.TryParse(e.CodigoNivel, out nivelKit)).ForEach(e =>
            {
                e.FlagHabilitado = int.Parse(e.CodigoNivel) <= nivelId && nivelId != 0;
            });

            return kits.OrderBy(e => e.CodigoNivel).ToList();
        }

        private List<BEKitCaminoBrillante> GetKitsProvider(int paisId, int periodoId, int campaniaId)
        {
            _providerCaminoBrillante = _providerCaminoBrillante ?? GetCaminoBrillanteProvider(paisId);
            if (_providerCaminoBrillante == null) return null;

            var kitsProvider = _providerCaminoBrillante.GetOfertas(Util.GetPaisIsoHanna(paisId), campaniaId).Result;
            var niveles = GetNiveles(paisId) ?? new List<BENivelCaminoBrillante>();

            if (kitsProvider.Any())
            {

                var cuvsStringList = kitsProvider.Select(e => e.Cuv).Distinct().ToList().Serialize();
                var kits = new DACaminoBrillante(paisId).GetKitsCaminoBrillante(periodoId, campaniaId, cuvsStringList).MapToCollection<BEKitCaminoBrillante>(closeReaderFinishing: true);
                var paisISO = Util.GetPaisISO(paisId);
                kits.ForEach(kit =>
                {
                    var _kitProvider = kitsProvider.FirstOrDefault(e => e.Cuv == kit.CUV);
                    if (_kitProvider != null)
                    {
                        kit.CodigoKit = _kitProvider.CodigoKit;
                        kit.CodigoSap = _kitProvider.CodigoSap;
                        kit.DescripcionCUV = _kitProvider.Descripcion;
                        kit.DescripcionCortaCUV = _kitProvider.Descripcion;
                        kit.PrecioCatalogo = _kitProvider.Precio;
                        kit.FlagDigitable = _kitProvider.Digitable;
                        kit.CodigoNivel = _kitProvider.Nivel;
                        kit.FlagDigitable = _kitProvider.Digitable;
                        kit.DescripcionNivel = niveles.Where(e => e.CodigoNivel == _kitProvider.Nivel).Select(e => e.DescripcionNivel).SingleOrDefault();
                        kit.FotoProductoSmall = !string.IsNullOrEmpty(kit.FotoProductoSmall) ? ConfigCdn.GetUrlFileCdnMatriz(paisISO, kit.FotoProductoSmall) : string.Empty;
                        kit.FotoProductoMedium = !string.IsNullOrEmpty(kit.FotoProductoMedium) ? ConfigCdn.GetUrlFileCdnMatriz(paisISO, kit.FotoProductoMedium) : string.Empty;
                    }
                });

                var kitsResult = kits.Where(e => e.FlagDigitable == 1).ToList();

                kitsResult.ForEach(e =>
                {
                    e.DescripcionCUV = string.Format("Kit {0}", e.DescripcionNivel);
                    e.DescripcionCortaCUV = e.DescripcionCUV;
                    e.PrecioValorizado = kits.Where(d => d.CodigoKit == e.CodigoKit).Sum(d => d.PrecioValorizado);
                    e.PrecioCatalogo = kits.Where(d => d.CodigoKit == e.CodigoKit).Sum(d => d.PrecioCatalogo);
                    e.Ganancia = e.PrecioValorizado - e.PrecioCatalogo;
                });
                return kitsResult;
            }

            return null;
        }

        private List<BEKitCaminoBrillante> GetKitsCache(int paisId, int periodoId, int campaniaId)
        {
            return CacheManager<List<BEKitCaminoBrillante>>.ValidateDataElement(paisId, ECacheItem.CaminoBrillanteOfertas, string.Format("{0}-{1}", periodoId, campaniaId), () => GetKitsProvider(paisId, periodoId, campaniaId));
        }

        private List<BEKitsHistoricoConsultora> GeOfertasHistoricos(int paisId, long consultoraId, string codigoConsultora, int CampaniaId, int periodoId)
        {
            _providerCaminoBrillante = _providerCaminoBrillante ?? GetCaminoBrillanteProvider(paisId);
            if (_providerCaminoBrillante == null) return null;

            var kitsHistoricos = _providerCaminoBrillante.GetKitHistoricoConsultora(Util.GetPaisIsoHanna(paisId), codigoConsultora, periodoId).Result ?? new List<KitsHistoricoConsultora>();
            var kitsEnPedido = new DACaminoBrillante(paisId).GetPedidoWebDetalleCaminoBrillante(periodoId, CampaniaId, consultoraId).MapToCollection<BEKitsHistoricoConsultora>(closeReaderFinishing: true) ?? new List<BEKitsHistoricoConsultora>();
            kitsEnPedido.AddRange(kitsHistoricos.Select(e => new BEKitsHistoricoConsultora() { CodigoKit = e.CodigoKit, CampaniaAtencion = e.CampaniaAtencion, CampaniaID = CampaniaId, FlagHistorico = true }));

            return kitsEnPedido;
        }

        #endregion

        #region Demostradores

        public BEDemostradoresPaginado GetDemostradores(BEUsuario entidad, int cantRegistros, int regMostrados, string codOrdenar, string codFiltro)
        {
            var objDemostradores = new BEDemostradoresPaginado();
            var demostradores = GetDemostradoresCaminoBrillanteCache(entidad.PaisID, entidad.CampaniaID, entidad.NivelCaminoBrillante);
            var demostradoresEnPedido = new DACaminoBrillante(entidad.PaisID).GetPedidoWebDetalleCaminoBrillante(entidad.CampaniaID, entidad.CampaniaID, entidad.ConsultoraID).MapToCollection<BEKitsHistoricoConsultora>(closeReaderFinishing: true) ?? new List<BEKitsHistoricoConsultora>();
            var paisISO = Util.GetPaisISO(entidad.PaisID);

            if (codOrdenar == Constantes.CaminoBrillante.CodigosOrdenamiento.SinOrden) codOrdenar = Constantes.CaminoBrillante.CodigosOrdenamiento.PorCategoria;
            demostradores = GetOrdenarDemostradores(demostradores, codOrdenar);
            if (codFiltro != Constantes.CaminoBrillante.CodigoFiltros.SinFiltro) demostradores = GetFiltrarDemostradores(demostradores, codFiltro);
            objDemostradores.Total = demostradores.Count();
            if (cantRegistros != 0) demostradores = GetDesmostradoresByCantidad(demostradores, regMostrados, cantRegistros);

            objDemostradores.LstDemostradores = demostradores.Select(e => new BEDemostradoresCaminoBrillante()
            {
                CodigoEstrategia = e.CodigoEstrategia,
                CUV = e.CUV,
                DescripcionCortaCUV = e.DescripcionCortaCUV,
                DescripcionCUV = e.DescripcionCUV,
                DescripcionMarca = e.DescripcionMarca,
                EstrategiaID = e.EstrategiaID,
                FotoProductoMedium = e.FotoProductoMedium,
                FotoProductoSmall = e.FotoProductoSmall,
                MarcaID = e.MarcaID,
                CodigoMarca = e.CodigoMarca,
                PrecioCatalogo = e.PrecioCatalogo,
                PrecioValorizado = e.PrecioValorizado,
                TipoEstrategiaID = e.TipoEstrategiaID,
                FlagSeleccionado = demostradoresEnPedido.Any(h => h.CUV == e.CUV)
            }).ToList();

            return objDemostradores;
        }

        private List<BEDemostradoresCaminoBrillante> GetOrdenarDemostradores(List<BEDemostradoresCaminoBrillante> demostradores, string ordenar)
        {
            switch (ordenar)
            {
                case Constantes.CaminoBrillante.CodigosOrdenamiento.PorCategoria:
                    return demostradores.OrderByDescending(a => a.EsCatalogo).ToList();
                case Constantes.CaminoBrillante.CodigosOrdenamiento.PorNombre:
                    return demostradores.OrderBy(a => a.DescripcionCUV).ToList();
                default:
                    return demostradores.OrderByDescending(a => a.EsCatalogo).ToList();
            }
        }

        private List<BEDemostradoresCaminoBrillante> GetFiltrarDemostradores(List<BEDemostradoresCaminoBrillante> demostradores, string codFiltro)
        {
            switch (codFiltro)
            {
                case Constantes.CaminoBrillante.CodigoFiltros.Lbel:
                    return demostradores.Where(x => x.CodigoMarca == Constantes.CaminoBrillante.CodigoFiltros.Lbel).ToList();
                case Constantes.CaminoBrillante.CodigoFiltros.Esika:
                    return demostradores.Where(x => x.CodigoMarca == Constantes.CaminoBrillante.CodigoFiltros.Esika).ToList();
                case Constantes.CaminoBrillante.CodigoFiltros.Cyzone:
                    return demostradores.Where(x => x.CodigoMarca == Constantes.CaminoBrillante.CodigoFiltros.Cyzone).ToList();
                default:
                    return demostradores;
            }
        }

        private List<BEDemostradoresCaminoBrillante> GetDesmostradoresByCantidad(List<BEDemostradoresCaminoBrillante> demostradores, int cantMostrados, int cantidad)
        {
            return demostradores.Skip(cantMostrados).Take(cantidad).ToList();
        }

        public List<BEDemostradoresCaminoBrillante> GetDemostradores(int paisId, int campaniaId, int nivelId)
        {
            return GetDemostradoresCaminoBrillanteCache(paisId, campaniaId, nivelId);
        }

        private List<BEDemostradoresCaminoBrillante> GetDemostradoresCaminoBrillanteBD(int paisId, int campaniaId, int nivelId)
        {
            var demostradores = new DACaminoBrillante(paisId).GetDemostradoresCaminoBrillante(campaniaId, nivelId).MapToCollection<BEDemostradoresCaminoBrillante>(closeReaderFinishing: true);

            if (demostradores != null)
            {
                var paisISO = Util.GetPaisISO(paisId);

                demostradores.ForEach(e =>
                {
                    e.FotoProductoSmall = !string.IsNullOrEmpty(e.FotoProductoSmall) ? ConfigCdn.GetUrlFileCdnMatriz(paisISO, e.FotoProductoSmall) : string.Empty;
                    e.FotoProductoMedium = !string.IsNullOrEmpty(e.FotoProductoMedium) ? ConfigCdn.GetUrlFileCdnMatriz(paisISO, e.FotoProductoMedium) : string.Empty;
                });
            }

            return demostradores;
        }

        private List<BEDemostradoresCaminoBrillante> GetDemostradoresCaminoBrillanteCache(int paisId, int campaniaId, int nivelId)
        {
            return CacheManager<List<BEDemostradoresCaminoBrillante>>.ValidateDataElement(paisId, ECacheItem.CaminoBrillanteDemostradores, string.Format("{0}-{1}", campaniaId, nivelId), () => GetDemostradoresCaminoBrillanteBD(paisId, campaniaId, nivelId));
        }

        #endregion

        #region Carrusel

        public BECarruselCaminoBrillante GetCarruselCaminoBrillante(BEUsuario entidad)
        {
            return GetCarrusel(entidad, 6);
        }

        private BECarruselCaminoBrillante GetCarrusel(BEUsuario entidad, int size)
        {
            var kits = GetKits(entidad); var demostradores = GetDemostradores(entidad, size, 0, string.Empty, string.Empty);
            if (kits == null && demostradores == null) return null;

            var carrusel = new BECarruselCaminoBrillante(); var iSize = size;
            /* Agregar el Kit Actual */
            if (kits != null)
            {
                var kitsTop = kits.Where(e => e.FlagHabilitado).OrderByDescending(e => e.CodigoNivel);
                if (kitsTop.Any())
                {
                    carrusel.Items.Add(new BEItemCarruselCaminoBrillante() { Kit = kits.First() });
                    iSize -= carrusel.Items.Count;
                }
            }

            /* Agregar los Demostradores */
            if (demostradores != null)
            {
                if (demostradores.LstDemostradores.Any())
                    carrusel.Items.AddRange(demostradores.LstDemostradores.Take(iSize).Select(e => new BEItemCarruselCaminoBrillante() { Demostrador = e }));                
            }

            return carrusel;
        }

        #endregion

        #region Validar Busqueda de Cuvs

        public BEValidacionCaminoBrillante ValidarBusquedaCaminoBrillante(BEUsuario entidad, string cuv)
        {
            var producto = GetCuvsCaminoBrillante(entidad.PaisID, entidad.CampaniaID).SingleOrDefault(e => e.CUV == cuv);
            if (producto == null) return new BEValidacionCaminoBrillante() { Validacion = Enumeradores.ValidacionCaminoBrillante.ProductoNoExiste };

            //Validación por Nivel
            Func<Enumeradores.ValidacionCaminoBrillante, int?, BEValidacionCaminoBrillante> buildMessage = (validacion, nivel) =>
            {
                if (nivel.HasValue)
                    return BuildBEValidacionCaminoBrillante(validacion, Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_BLOQUEADO_NIVEL_CAMINO_BRILLANTE, GetNiveles(entidad.PaisID).Where(n => n.CodigoNivel == nivel.ToString()).Select(e => e.DescripcionNivel).FirstOrDefault());
                return BuildBEValidacionCaminoBrillante(validacion, Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_BLOQUEADO_CAMINO_BRILLANTE);
            };

            if (producto.Nivel.HasValue)
            {
                if (entidad.NivelCaminoBrillante < producto.Nivel.Value)
                    return buildMessage(Enumeradores.ValidacionCaminoBrillante.CuvBloqueadoNivel, producto.Nivel.Value);
            }

            if (producto.Tipo == 1)
            {
                var kits = GetKits(entidad);
                if (kits.Any(e => e.FlagHistorico || e.FlagSeleccionado))
                    return BuildBEValidacionCaminoBrillante(Enumeradores.ValidacionCaminoBrillante.CuvYaAgregadoEnPeriodo, Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_USADO_CAMINO_BRILLANTE);
                if (producto.Nivel.HasValue)
                {
                    var kit = kits.Where(e => e.CodigoNivel == producto.Nivel.Value.ToString()).FirstOrDefault();
                    if (kit == null)
                        return BuildBEValidacionCaminoBrillante(Enumeradores.ValidacionCaminoBrillante.ProductoNoExiste);
                    if (!kit.FlagHabilitado)
                        buildMessage(Enumeradores.ValidacionCaminoBrillante.CuvBloqueadoNivel, producto.Nivel.Value);
                }
            }

            return BuildBEValidacionCaminoBrillante(Enumeradores.ValidacionCaminoBrillante.CuvPertenecePrograma, Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_IR_CAMINO_BRILLANTE);
        }

        private BEValidacionCaminoBrillante BuildBEValidacionCaminoBrillante(Enumeradores.ValidacionCaminoBrillante validacion, string code = null, string param = null)
        {
            return new BEValidacionCaminoBrillante()
            {
                Validacion = validacion,
                Code = code,
                Mensaje = Constantes.PedidoValidacion.Configuracion.ContainsKey(code) ? (
                    param != null ? string.Format(Constantes.PedidoValidacion.Configuracion[code].Mensaje, param)
                                    : Constantes.PedidoValidacion.Configuracion[code].Mensaje
                ) : string.Empty
            };
        }

        private List<BEProductoCaminoBrillante> GetCuvsCaminoBrillante(int PaisID, int CampaniaID)
        {
            return GetCuvsCaminoBrillanteCache(PaisID, CampaniaID);
        }

        private List<BEProductoCaminoBrillante> GetCuvsCaminoBrillanteCache(int PaisID, int CampaniaID)
        {
            return CacheManager<List<BEProductoCaminoBrillante>>.ValidateDataElement(PaisID, ECacheItem.CaminoBrillanteCuvs, string.Format("{0}", CampaniaID), () => GetCuvsCaminoBrillanteBD(PaisID, CampaniaID));
        }

        private List<BEProductoCaminoBrillante> GetCuvsCaminoBrillanteBD(int PaisID, int CampaniaID)
        {
            var productos = new DACaminoBrillante(PaisID).GetCuvsCaminoBrillante(CampaniaID).MapToCollection<BEProductoCaminoBrillante>(closeReaderFinishing: true) ?? new List<BEProductoCaminoBrillante>();

            try
            {
                var valProducto = ValProductoInList(productos);
                var kits = GetKitsCache(PaisID, 0, CampaniaID) ?? new List<BEKitCaminoBrillante>();
                kits.ForEach(e => valProducto(e, 1));
            }
            catch (Exception ex)
            {

            }

            return productos;
        }

        private Action<BEKitCaminoBrillante, int> ValProductoInList(List<BEProductoCaminoBrillante> productos)
        {
            int nivel = 0;

            Action<BEKitCaminoBrillante, int> validatorProductoInList = (kit, tipo) =>
            {
                if (!productos.Any(e => e.CUV == kit.CUV))
                {
                    productos.Add(new BEProductoCaminoBrillante()
                    {
                        CUV = kit.CUV,
                        Descripcion = kit.DescripcionCUV,
                        IndicadorDigitable = true,
                        Nivel = int.TryParse(kit.CodigoNivel, out nivel) ? nivel : 0,
                        Tipo = 1
                    });
                }
                else
                {
                    productos.Where(e => e.CUV == kit.CUV)
                        .Update(e =>
                        {
                            e.Descripcion = kit.DescripcionCUV;
                            e.IndicadorDigitable = true;
                            e.Nivel = int.TryParse(kit.CodigoNivel, out nivel) ? nivel : 0;
                            e.Tipo = 1;
                        });
                }
            };
            return validatorProductoInList;
        }

        #endregion

        #region Medallas

        private List<BEConfiguracionMedallaCaminoBrillante> GetGetConfiguracionMedallaCaminoBrillanteCache(int paisId)
        {
            return CacheManager<List<BEConfiguracionMedallaCaminoBrillante>>.ValidateDataElement(paisId, ECacheItem.CaminoBrillanteMedallas, () => GetGetConfiguracionMedallaCaminoBrillante(paisId));
        }

        private List<BEConfiguracionMedallaCaminoBrillante> GetGetConfiguracionMedallaCaminoBrillante(int paisId)
        {
            return new DACaminoBrillante(paisId).GetConfiguracionMedallaCaminoBrillante().MapToCollection<BEConfiguracionMedallaCaminoBrillante>(closeReaderFinishing: true);
        }

        #endregion

        #region Pedido

        public void UpdFlagsKitsOrDemostradores(BEPedidoWebDetalle bEPedidoWebDetalle, int paisId, int campaniaId, int nivelId)
        {
            if (nivelId == 0) return;

            var demostradores = GetDemostradores(paisId, campaniaId, nivelId) ?? new List<BEDemostradoresCaminoBrillante>();
            bEPedidoWebDetalle.EsDemCaminoBrillante = demostradores.Any(k => k.CUV == bEPedidoWebDetalle.CUV);
            if (!bEPedidoWebDetalle.EsDemCaminoBrillante)
            {
                var periodo = GetPeriodo(paisId, campaniaId);
                if (periodo != null)
                {
                    var kits = GetKitsCache(paisId, periodo.Periodo, campaniaId) ?? new List<BEKitCaminoBrillante>();
                    var kit = kits.FirstOrDefault(k => k.CUV == bEPedidoWebDetalle.CUV);
                    if (kit != null)
                    {
                        bEPedidoWebDetalle.EsKitCaminoBrillante = true;
                        bEPedidoWebDetalle.DescripcionCortadaProd = kit.DescripcionCUV;
                        bEPedidoWebDetalle.DescripcionProd = kit.DescripcionCUV;
                    }
                }
            }
        }

        public bool UpdEstragiaCaminiBrillante(BEEstrategia estrategia, int paisId, int campaniaId, int nivelId, string cuv)
        {
            if (nivelId == 0) return false;
            try
            {
                var demostradores = GetDemostradoresCaminoBrillanteCache(paisId, campaniaId, nivelId) ?? new List<BEDemostradoresCaminoBrillante>();
                var demostrador = demostradores.FirstOrDefault(e => e.CUV == cuv);
                if (demostrador != null)
                {
                    estrategia.CUV2 = demostrador.CUV;
                    estrategia.DescripcionCUV2 = demostrador.DescripcionCUV;
                    estrategia.Precio2 = demostrador.PrecioCatalogo;
                    estrategia.LimiteVenta = 99;
                    return true;
                }

                var periodo = GetPeriodo(paisId, campaniaId);
                if (periodo == null) return false;

                //Producto comercial obtener la info
                var kits = GetKits(paisId, campaniaId, periodo.Periodo, -1);
                if (kits == null) return false;

                var kit = kits.FirstOrDefault(e => e.CUV == cuv);
                if (kit == null) return false;

                estrategia.CUV2 = kit.CUV;
                estrategia.DescripcionCUV2 = kit.DescripcionCUV;
                estrategia.Precio2 = kit.PrecioCatalogo;
                estrategia.LimiteVenta = 1;

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public string ValAgregarCaminiBrillante(BEEstrategia estrategia, BEUsuario usuario, BEPedidoDetalle pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle)
        {
            if (pedidoDetalle.Cantidad > estrategia.LimiteVenta) return Constantes.PedidoValidacion.Code.ERROR_CANTIDAD_LIMITE;
            var cantidad = lstDetalle.Where(e => e.CUV == pedidoDetalle.Producto.CUV).Sum(e => e.Cantidad) + pedidoDetalle.Cantidad;
            if (cantidad > estrategia.LimiteVenta) return Constantes.PedidoValidacion.Code.ERROR_CANTIDAD_LIMITE;

            var periodo = GetPeriodo(usuario.PaisID, usuario.CampaniaID);
            if (periodo == null) return Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_NOEXISTE;

            if (estrategia.LimiteVenta == 1)
            {

                var kits = GetKits(usuario.PaisID, usuario.CampaniaID, periodo.Periodo, 6);
                if (kits == null) return Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_NOEXISTE;

                var ofertasHistoricos = GeOfertasHistoricos(usuario.PaisID, usuario.ConsultoraID, usuario.CodigoConsultora, usuario.CampaniaID, periodo.Periodo);
                if (ofertasHistoricos != null && ofertasHistoricos.Any(e => kits.Any(k => k.CUV == e.CUV)))
                {
                    return Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_KIT_CAMINO_BRILLANTE_USADO;
                }
            }

            return null;
        }

        #endregion

        #region Tabla Logica Datos

        private List<BETablaLogicaDatos> GetDatosTablaLogica(int paisId, short tablaLogicaId)
        {
            return _tablaLogicaDatosBusinessLogic.GetListCache(paisId, tablaLogicaId);
        }

        #endregion

        #region Provider Comercial

        private CaminoBrillanteProvider GetCaminoBrillanteProvider(int paisId)
        {
            return GetCaminoBrillanteProvider(GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteInfoComercial));
        }

        private CaminoBrillanteProvider GetCaminoBrillanteProvider(List<BETablaLogicaDatos> datosTablaLogica)
        {
            if (datosTablaLogica == null || datosTablaLogica.Count == 0) return null;

            var url = datosTablaLogica.Where(a => a.Codigo == Constantes.CaminoBrillante.ServicioComercial.TablaLogicaDatosKey.UrlInformacionComercial).Select(e => e.Valor).FirstOrDefault();
            var usuario = datosTablaLogica.Where(a => a.Codigo == Constantes.CaminoBrillante.ServicioComercial.TablaLogicaDatosKey.UsuarioInformacionComercial).Select(e => e.Valor).FirstOrDefault();
            var clave = datosTablaLogica.Where(a => a.Codigo == Constantes.CaminoBrillante.ServicioComercial.TablaLogicaDatosKey.ClaveInformacionComercial).Select(e => e.Valor).FirstOrDefault();

            if (string.IsNullOrEmpty(url)) return null;

            return new CaminoBrillanteProvider(url, usuario, clave);
        }

        #endregion

        #region Orden y Filtros

        public BEOrdenFiltroConfiguracion GetFiltrosCaminoBrillante(int paisId, bool isApp)
        {
            return GetFiltrosCache(paisId, isApp);
        }

        private BEOrdenFiltroConfiguracion GetFiltros(int paisId, bool isApp)
        {
            return new BEOrdenFiltroConfiguracion()
            {
                Ordenamientos = GetOrden(paisId, isApp),
                Filtros = GetFiltro(paisId, isApp)
            };
        }

        private List<BEOrdenGrupo> GetOrden(int paisId, bool isApp)
        {
            var tablaLogicaDatos = _tablaLogicaDatosBusinessLogic.GetList(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteOrden) ?? new List<BETablaLogicaDatos>();
            if (tablaLogicaDatos.Count == 0) return null;

            var opciones = tablaLogicaDatos.Where(e => (e.Codigo != "00" && isApp) || !isApp)
                            .Select(e => new BEOrden() { Codigo = e.Codigo, Descripcion = e.Descripcion }).ToList();

            return new List<BEOrdenGrupo>() { new BEOrdenGrupo() {
                NombreGrupo = tablaLogicaDatos.Where(e => e.Codigo == "00").Select(e => e.Valor).FirstOrDefault(),
                Opciones = opciones
            }};
        }

        private List<BEFiltroGrupo> GetFiltro(int paisId, bool isApp)
        {
            var tablaLogicaDatos = _tablaLogicaDatosBusinessLogic.GetList(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteFiltro) ?? new List<BETablaLogicaDatos>();
            if (tablaLogicaDatos.Count == 0) return null;

            var opciones = tablaLogicaDatos.Where(e => (e.Codigo != "00" && isApp) || !isApp)
                            .Select(e => new BEFiltro() { Codigo = e.Codigo, Descripcion = e.Descripcion }).ToList();
            if (!isApp) {
                var filtrar = opciones.Where(e => e.Codigo == "00").SingleOrDefault();
                opciones = opciones.Where(e => e.Codigo != "00").OrderBy(e => e.Descripcion).ToList();
                if(filtrar!= null) opciones.Insert(0, filtrar);
            }

            return new List<BEFiltroGrupo>() { new BEFiltroGrupo() {
                Excluyente = true,
                NombreGrupo = tablaLogicaDatos.Where(e => e.Codigo == "00").Select(e => e.Valor).FirstOrDefault(),
                Opciones = opciones
            }};
        }

        private BEOrdenFiltroConfiguracion GetFiltrosCache(int paisId, bool isApp)
        {
            return CacheManager<BEOrdenFiltroConfiguracion>.ValidateDataElement(paisId, ECacheItem.CaminoBrillanteFiltros, isApp ? "APP":"WEB" , () => GetFiltros(paisId, isApp));
        }

        #endregion

        #region Carrusel Camino Brillante
        public List<BEDemostradoresCaminoBrillante> GetProductosCarruselCaminoBrillante(BEUsuario entidad, int nivelId)
        {
            if (nivelId == 1) return new List<BEDemostradoresCaminoBrillante>();
            var kits = GetKits(entidad);
            //OBTENIENDO SOLO EL KIT DE LA CONSULTORA
            //var oCarrusel = new BEDemostradoresCaminoBrillante({
                
            //});
            var Demostradores = GetDemostradores(entidad.PaisID, entidad.CampaniaID, nivelId);

            return null;
        }
        #endregion
    }
}
