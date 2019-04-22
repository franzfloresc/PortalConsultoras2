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

            var lstBeneficios = GetBeneficiosCaminoBrillante(paisId) ?? new List<BENivelCaminoBrillante.BEBeneficioCaminoBrillante>();
            var lstNiveles = _providerCaminoBrillante.GetNivel(Util.GetPaisIsoHanna(paisId)).Result;

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteOfertasEspeciales) ?? new List<BETablaLogicaDatos>());
            var tablaLogicaDatosDV = tablaLogicaDatos.FirstOrDefault(e => e.TablaLogicaDatosID == Constantes.CaminoBrillante.Niveles.OfertasEspeciales_TablaLogicaDatos) ?? new BETablaLogicaDatos();
            var TieneOfertasEspecialesDV = "1".Equals(tablaLogicaDatosDV.Valor);

            return lstNiveles.Select(e => new BENivelCaminoBrillante()
            {
                CodigoNivel = e.CodigoNivel,
                DescripcionNivel = e.DescripcionNivel,
                MontoMaximo = e.MontoMaximo,
                MontoMinimo = e.MontoMinimo,
                TieneOfertasEspeciales = Niveles_TIeneOfertasEspeciales(tablaLogicaDatos,e.CodigoNivel, TieneOfertasEspecialesDV),
                Beneficios = lstBeneficios.Where(b => b.CodigoNivel == e.CodigoNivel && !(string.IsNullOrEmpty(b.NombreBeneficio) && string.IsNullOrEmpty(b.Descripcion) )).ToList()
            }).ToList();
        }

        private bool Niveles_TIeneOfertasEspeciales(List<BETablaLogicaDatos> bETablaLogicaDatos, string codNivel, bool defValor) {
            var bETablaLogicaDato = bETablaLogicaDatos.FirstOrDefault(e => e.Codigo == codNivel);
            return bETablaLogicaDato != null ? "1".Equals(bETablaLogicaDato.Valor) : defValor;
        }

        private List<BENivelCaminoBrillante> GetNivelesCache(int paisId)
        {
            return CacheManager<List<BENivelCaminoBrillante>>.ValidateDataElement(paisId, ECacheItem.CaminoBrillanteNiveles, () => GetNivelesProvider(paisId));
        }

        private List<BENivelCaminoBrillante.BEBeneficioCaminoBrillante> GetBeneficiosCaminoBrillante(int paisId)
        {
            return new DACaminoBrillante(paisId).GetBeneficiosCaminoBrillante().MapToCollection<BENivelCaminoBrillante.BEBeneficioCaminoBrillante>(closeReaderFinishing: true);
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

        //Where X FirstOrDefault
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
                    EsActual = (e == nivelConsultora)
                }).OrderByDescending(e => e.Campania).ToList(),
                Niveles = CalcularCuantoFalta(niveles,periodo, nivelConsultora, nivelesConsultora),
                ResumenLogros = GetResumenLogros(entidad.PaisID, logros),
                Logros = logros
            };
        }

        private List<BENivelCaminoBrillante> CalcularCuantoFalta(List<BENivelCaminoBrillante> niveles, BEPeriodoCaminoBrillante periodo, NivelConsultoraCaminoBrillante nivelActualConsutora, List<NivelConsultoraCaminoBrillante> consultoraHistoricos) {
            if (niveles != null && periodo != null && nivelActualConsutora != null) {
                int nivel = 0;
                if (int.TryParse(nivelActualConsutora.NivelActual, out nivel)) {
                    nivel = nivel + 1;

                    /*
                    decimal montoFaltante = 0;
                    if (consultoraHistoricos != null){
                        var montoPedido = consultoraHistoricos.Where(h => decimal.TryParse(h.MontoPedido, out _montoPedido)).Sum(h => decimal.Parse(h.MontoPedido));
                    }
                    */
                    /*
                    niveles.Where(e => e.CodigoNivel == nivel.ToString()).Update(e => {
                        e.MontoFaltante = montoFaltante;
                    });
                    */
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

        //Constantes
        //Optimizar
        private BELogroCaminoBrillante GetResumenLogros(int paisId, List<BELogroCaminoBrillante> logros)
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

            Func<string, string, BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante> funcUltimaMedalla = (logro, indicador) =>
            {
                var _logro = logros.FirstOrDefault(e => e.Id == logro) ?? new BELogroCaminoBrillante();
                var _indicador = _logro.Indicadores.FirstOrDefault(e => e.Codigo == indicador) ?? new BELogroCaminoBrillante.BEIndicadorCaminoBrillante();
                if (_indicador.Medallas != null)
                    return _indicador.Medallas.OrderByDescending(e => e.Orden).FirstOrDefault(e => e.Estado) ?? _indicador.Medallas.OrderBy(e => e.Orden).FirstOrDefault();
                return null;
            };

            var medallaEscala = funcCopyMedalla(funcUltimaMedalla(Constantes.CaminoBrillante.Logros.CRECIMIENTO, Constantes.CaminoBrillante.Logros.Indicadores.ESCALA),
                                                Constantes.CaminoBrillante.Logros.Indicadores.Titulos[Constantes.CaminoBrillante.Logros.Indicadores.ESCALA], 0);
            var medallaContancia = funcCopyMedalla(funcUltimaMedalla(Constantes.CaminoBrillante.Logros.CRECIMIENTO, Constantes.CaminoBrillante.Logros.Indicadores.CONSTANCIA),
                                                Constantes.CaminoBrillante.Logros.Indicadores.Titulos[Constantes.CaminoBrillante.Logros.Indicadores.CONSTANCIA], 1);
            var medallaIncremento = funcCopyMedalla(funcUltimaMedalla(Constantes.CaminoBrillante.Logros.CRECIMIENTO, Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO_PEDIDO),
                                                Constantes.CaminoBrillante.Logros.Indicadores.Titulos[Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO_PEDIDO], 2);

            Func<List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>> funcResumenCompromiso = () =>
            {
                var lastMedallaProgramaNuevas = funcUltimaMedalla(Constantes.CaminoBrillante.Logros.COMPROMISO, Constantes.CaminoBrillante.Logros.Indicadores.PROGRAMA_NUEVAS);
                var lastMedallaTiempoJuntos = funcUltimaMedalla(Constantes.CaminoBrillante.Logros.COMPROMISO, Constantes.CaminoBrillante.Logros.Indicadores.TIEMPO_JUNTOS);
                var medallas = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>();

                Action<string, string, BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante> addSerieMedalla = (logro, indicador, medalla) =>
                {
                    if (medalla != null)
                    {
                        var _logro = logros.FirstOrDefault(e => e.Id == logro) ?? new BELogroCaminoBrillante();
                        var _indicador = _logro.Indicadores.FirstOrDefault(e => e.Codigo == indicador) ?? new BELogroCaminoBrillante.BEIndicadorCaminoBrillante();
                        var index = _indicador.Medallas.IndexOf(medalla);

                        //Optimizar
                        if (index - 1 >= 0 && medallas.Count < 3) medallas.Add(_indicador.Medallas[index - 1]);
                        if (medallas.Count < 3) medallas.Add(medalla);
                        if (index + 1 < _indicador.Medallas.Count && medallas.Count < 3) medallas.Add(_indicador.Medallas[index + 1]);
                        if (medallas.Count < 3 && index + 2 < _indicador.Medallas.Count)
                        {
                            medallas.Add(_indicador.Medallas[index + 2]);
                        }
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

        private BELogroCaminoBrillante GetConsultoraLogrosCrecimiento(int paisId, BEUsuario entidad, List<BENivelCaminoBrillante> nivelesCaminoBrillantes, NivelConsultoraCaminoBrillante nivelConsutora, List<NivelConsultoraCaminoBrillante> nivelesConsultora, BEPeriodoCaminoBrillante periodoActual)
        {

            var _cambioEscalaDescuento = GetConsultoraLogrosCrecimiento_CambioEscalaDescuento(paisId, entidad, nivelConsutora);
            var _cambioNivel = GetConsultoraLogrosCrecimiento_CambioNivel(paisId, entidad, nivelConsutora, nivelesCaminoBrillantes);
            var _constancia = GetConsultoraLogrosCrecimiento_Constancia(paisId, entidad, nivelConsutora, nivelesConsultora, periodoActual);
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
            var escalasDescuento = _escalaDescuentoBusinessLogic.GetEscalaDescuento(paisId, entidad.CampaniaID, entidad.Region, entidad.Zona) ?? new List<BEEscalaDescuento>();
            var configsMedalla = (GetGetConfiguracionMedallaCaminoBrillanteCache(paisId) ?? new List<BEConfiguracionMedallaCaminoBrillante>())
                                 .Where(e => e.Logro == Constantes.CaminoBrillante.Logros.CRECIMIENTO && e.Indicador == Constantes.CaminoBrillante.Logros.Indicadores.ESCALA);

            var idx = 0;
            var medallaEscalas = escalasDescuento.Select(e => new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante()
            {
                Orden = idx++,
                Tipo = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.CIRC,
                Estado = (e.PorDescuento <= nivelConsultora.CambioEscala),
                Valor = e.PorDescuento + string.Empty,
                MontoSuperior = e.MontoHasta,
            }).ToList();

            medallaEscalas.ForEach(e =>
            {
                var configMedalla = configsMedalla.FirstOrDefault(p => p.Codigo == e.Valor);
                if (configMedalla != null)
                {
                    e.Subtitulo = e.Estado ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo;
                    e.Valor = string.Format(configMedalla.Valor ?? string.Empty, e.Valor);
                    e.ModalTitulo = configMedalla.ComoLograrlo_Estado ? configMedalla.ComoLograrlo_Titulo.Replace("{0}", e.Valor) : string.Empty;
                    e.ModalDescripcion = configMedalla.ComoLograrlo_Estado ? (configMedalla.ComoLograrlo_Descripcion).Replace("{0}", string.Format("<b>{0} {1}</b>", entidad.Simbolo, Util.DecimalToStringFormat(Convert.ToDecimal(e.MontoSuperior),entidad.CodigoISO))) : string.Empty;
                }
                else
                {
                    e.Valor = string.Format("{0}%", e.Valor);
                    e.Subtitulo = e.Estado ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo;
                }
            });

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteIndicadores) ?? new List<BETablaLogicaDatos>())
                                    .FirstOrDefault(e => e.Codigo == Constantes.CaminoBrillante.Logros.Indicadores.ESCALA) ?? new BETablaLogicaDatos();

            return  new BELogroCaminoBrillante.BEIndicadorCaminoBrillante()
            {
                Codigo = Constantes.CaminoBrillante.Logros.Indicadores.ESCALA,
                Titulo = tablaLogicaDatos.Valor,
                Medallas = medallaEscalas.ToList()
            };
        }

        private BELogroCaminoBrillante.BEIndicadorCaminoBrillante GetConsultoraLogrosCrecimiento_CambioNivel(int paisId, BEUsuario entidad, NivelConsultoraCaminoBrillante nivelConsultora, List<BENivelCaminoBrillante> nivelesCaminoBrillantes)
        {
            short nivelActual = 0;
            short nivelCodigo = 0;
            short.TryParse(nivelConsultora.NivelActual, out nivelActual);

            var configsMedalla = (GetGetConfiguracionMedallaCaminoBrillanteCache(paisId) ?? new List<BEConfiguracionMedallaCaminoBrillante>())
                                .Where(e => e.Logro == Constantes.CaminoBrillante.Logros.CRECIMIENTO && e.Indicador == Constantes.CaminoBrillante.Logros.Indicadores.NIVEL);

            var idx = 0;
            var medallaNiveles = nivelesCaminoBrillantes.Select(e => new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante()
            {
                Orden = idx++,
                Tipo = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.NIV,
                Estado = short.TryParse(e.CodigoNivel, out nivelCodigo) ? nivelCodigo <= nivelActual : false,
                Subtitulo = (nivelCodigo <= nivelActual ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo),
                Valor = e.CodigoNivel,
                DescripcionNivel = e.DescripcionNivel,
                MontoAcumulado = e.MontoMinimo,
            }).ToList();


            medallaNiveles.ForEach(e =>
            {
                var configMedalla = configsMedalla.FirstOrDefault(p => p.Codigo == e.Valor);
                if (configMedalla != null)
                {
                    e.Subtitulo = e.Estado ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo;
                    e.ModalTitulo = configMedalla.ComoLograrlo_Estado ? configMedalla.ComoLograrlo_Titulo.Replace("{0}", e.DescripcionNivel) : string.Empty;
                    e.ModalDescripcion = configMedalla.ComoLograrlo_Estado ? configMedalla.ComoLograrlo_Descripcion.Replace("{0}", e.DescripcionNivel).Replace("{1}", string.Format("<b>{0} {1}</b>", entidad.Simbolo, Util.DecimalToStringFormat(Convert.ToDecimal(e.MontoAcumulado), entidad.CodigoISO))) : string.Empty;
                }
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

        private BELogroCaminoBrillante.BEIndicadorCaminoBrillante GetConsultoraLogrosCrecimiento_Constancia(int paisId, BEUsuario entidad, NivelConsultoraCaminoBrillante nivelConsultora, List<NivelConsultoraCaminoBrillante> nivelesHistoricosConsultora, BEPeriodoCaminoBrillante periodoActual)
        {
            var medallaConstancia = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>();
            var periodos = GetPeriodos(entidad.PaisID);
            var _periodoActual = periodoActual ?? new BEPeriodoCaminoBrillante();

            var nivelActual = 0;
            var _periodo = 0;
            int.TryParse(nivelConsultora.NivelActual, out nivelActual);

            var configMedalla = (GetGetConfiguracionMedallaCaminoBrillanteCache(paisId) ?? new List<BEConfiguracionMedallaCaminoBrillante>())
                                .FirstOrDefault(e => e.Logro == Constantes.CaminoBrillante.Logros.CRECIMIENTO && e.Indicador == Constantes.CaminoBrillante.Logros.Indicadores.CONSTANCIA);

            if (configMedalla == null) return null;

            Action<string, int> builderMedallaConstancia = (periodo, constancia) =>
            {
                if (int.TryParse(periodo, out _periodo))
                {
                    var periodoCaminoBrillante = periodos.FirstOrDefault(e => e.Periodo == _periodo);
                    if (periodoCaminoBrillante != null)
                    {
                        var valor = string.Format("{0}-{1}-{2}", periodoCaminoBrillante.Periodo, periodoCaminoBrillante.NroCampana, constancia);
                        if (!medallaConstancia.Any(e => e.Valor == valor))
                        {
                            var estado = _periodoActual.Periodo == _periodo;
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
                        }
                    }
                }
            };

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
                    //Estado = true,
                    Titulo = string.Format(configMedalla.Valor ?? string.Empty, (periodoActual.CampanaInicial % 100), (periodoActual.CampanaFinal % 100)),
                    Subtitulo = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo,
                    ModalTitulo = configMedalla.ComoLograrlo_Estado ? configMedalla.ComoLograrlo_Titulo : string.Empty,
                    ModalDescripcion = configMedalla.ComoLograrlo_Estado ? configMedalla.ComoLograrlo_Descripcion : string.Empty,
                    Valor = string.Format("{0}-{1}-{2}", periodoActual.Periodo, periodoActual.NroCampana, 0),
                });
            }

            if (periodoActual != null )
            {
                medallaConstancia.Where(e => e.Valor.StartsWith(periodoActual.Periodo.ToString()))
                    .Update(e => {
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
                    Estado = (int.Parse(e.Codigo) <= nivelConsultora.PorcentajeIncremento),
                    Subtitulo = (int.Parse(e.Codigo) <= nivelConsultora.PorcentajeIncremento) ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo,
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

        //Pendiente calcular el flag para mostrar y validar el campo consecutivo nuevas (Alexis)
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

        //Formato de fecha
        private BELogroCaminoBrillante.BEIndicadorCaminoBrillante GetConsultoraLogrosCompromiso_TiempoJuntos(int paisId, NivelConsultoraCaminoBrillante nivelConsultora)
        {
            var aniosConsultora = -1;
            if (!string.IsNullOrEmpty(nivelConsultora.FechaIngreso))
            {
                DateTime anioIngreso = DateTime.MinValue;
                //var format = Constantes.Formatos.FechaHoraUTC;
                var format = "yyyy-MM-ddThh:mm:ss";
                if (nivelConsultora.FechaIngreso != null)
                {
                    //Corregir 
                    nivelConsultora.FechaIngreso = nivelConsultora.FechaIngreso.Substring(0, Math.Min(19, nivelConsultora.FechaIngreso.Length));
                }
                if (DateTime.TryParseExact(nivelConsultora.FechaIngreso, format, CultureInfo.InvariantCulture, DateTimeStyles.None, out anioIngreso))
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

        //Pendiente cargar imagenes
        #region Kits

        public List<BEKitCaminoBrillante> GetKits(BEUsuario entidad, int nivelId)
        {
            var periodo = GetPeriodo(entidad.PaisID, entidad.CampaniaID);
            if (periodo == null) return null;

            //Quitar 
            periodo.Periodo = 201903;

            var kits = GetKits(entidad.PaisID, entidad.CampaniaID, periodo.Periodo, nivelId);
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

        //Pendiente cargar imagenes
        private List<BEKitCaminoBrillante> GetKitsProvider(int paisId, int periodoId, int campaniaId)
        {
            _providerCaminoBrillante = _providerCaminoBrillante ?? GetCaminoBrillanteProvider(paisId);
            if (_providerCaminoBrillante == null) return null;

            var kitsProvider = _providerCaminoBrillante.GetOfertas(Util.GetPaisIsoHanna(paisId), periodoId).Result;
            var niveles = GetNiveles(paisId) ?? new List<BENivelCaminoBrillante>();

            if (kitsProvider.Any())
            {
                var paisISO = Util.GetPaisISO(paisId);
                var cuvsStringList = kitsProvider.Select(e => e.Cuv).Distinct().ToList().Serialize();
                var kits = new DACaminoBrillante(paisId).GetKitsCaminoBrillante(periodoId, campaniaId, cuvsStringList).MapToCollection<BEKitCaminoBrillante>(closeReaderFinishing: true);

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
                        kit.Ganancia = kit.PrecioValorizado - kit.PrecioCatalogo;
                        kit.FlagDigitable = _kitProvider.Digitable;
                        kit.CodigoNivel = _kitProvider.Nivel;
                        kit.FlagDigitable = _kitProvider.Digitable;
                        kit.DescripcionNivel = niveles.Where(e => e.CodigoNivel == _kitProvider.Nivel).Select(e => e.DescripcionNivel).SingleOrDefault();
                        kit.FotoProductoSmall = !string.IsNullOrEmpty(kit.FotoProductoSmall) ? ConfigCdn.GetUrlFileCdnMatriz(paisISO, kit.FotoProductoSmall) : string.Empty;
                        kit.FotoProductoMedium = !string.IsNullOrEmpty(kit.FotoProductoMedium) ? ConfigCdn.GetUrlFileCdnMatriz(paisISO, kit.FotoProductoMedium) : string.Empty;
                    }
                });

                return kits;
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

        //Pendiente cargar imagenes
        #region Demostradores

        public List<BEDesmostradoresCaminoBrillante> GetDemostradores(int paisId, int campaniaId)
        {
            return GetDemostradoresCaminoBrillanteCache(paisId, campaniaId);
        }

        private List<BEDesmostradoresCaminoBrillante> GetDemostradoresCaminoBrillanteBD(int paisId, int campaniaId)
        {
            var demostradores = new DACaminoBrillante(paisId).GetDemostradoresCaminoBrillante(campaniaId).MapToCollection<BEDesmostradoresCaminoBrillante>(closeReaderFinishing: true);

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

        private List<BEDesmostradoresCaminoBrillante> GetDemostradoresCaminoBrillanteCache(int paisId, int campaniaId)
        {
            return CacheManager<List<BEDesmostradoresCaminoBrillante>>.ValidateDataElement(paisId, ECacheItem.CaminoBrillanteDemostradores, string.Format("{0}", campaniaId), () => GetDemostradoresCaminoBrillanteBD(paisId, campaniaId));
        }

        #endregion

        //Guardar en el Log
        #region Pedido

        public void UpdFlagsKitsOrDemostradores(BEPedidoWebDetalle bEPedidoWebDetalle, int paisId, int campaniaId)
        {
            var demostradores = GetDemostradores(paisId, campaniaId) ?? new List<BEDesmostradoresCaminoBrillante>();
            bEPedidoWebDetalle.EsDemCaminoBrillante = demostradores.Any(k => k.CUV == bEPedidoWebDetalle.CUV);
            if (!bEPedidoWebDetalle.EsDemCaminoBrillante)
            {
                bEPedidoWebDetalle.EsKitCaminoBrillante = true;
            }
        }

        public bool UpdEstragiaCaminiBrillante(BEEstrategia estrategia, int paisId, int campaniaId, string cuv)
        {
            try
            {
                var demostradores = GetDemostradoresCaminoBrillanteCache(paisId, campaniaId) ?? new List<BEDesmostradoresCaminoBrillante>();
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

                //Quitar 
                periodo.Periodo = 201903;

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
            catch (Exception ex)
            {
                //LogManager.SaveLog .LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
            }
            return false;
        }

        public string ValAgregarCaminiBrillante(BEEstrategia estrategia, BEUsuario usuario, BEPedidoDetalle pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle) {
            if (pedidoDetalle.Cantidad > estrategia.LimiteVenta ) return Constantes.PedidoValidacion.Code.ERROR_CANTIDAD_LIMITE;
            var cantidad = lstDetalle.Where(e => e.CUV == pedidoDetalle.Producto.CUV).Sum( e => e.Cantidad) + pedidoDetalle.Cantidad;
            if (cantidad > estrategia.LimiteVenta) return Constantes.PedidoValidacion.Code.ERROR_CANTIDAD_LIMITE;

            var periodo = GetPeriodo(usuario.PaisID, usuario.CampaniaID);
            if (periodo == null) return Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_NOEXISTE;

            //Detectar que es un Kit
            if (estrategia.LimiteVenta == 1) {
                //Quitar 
                periodo.Periodo = 201903;

                //Agregar al objeto Usuario el Nievel de COnsultora
                //Pendiente el nivel de la consultora
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

            return new CaminoBrillanteProvider(url, usuario, clave);
        }

        #endregion

    }
}
