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

        public List<BENivelCaminoBrillante> GetNiveles(int paisId)
        {
            _providerCaminoBrillante = _providerCaminoBrillante ?? getCaminoBrillanteProvider(paisId);
            if (_providerCaminoBrillante == null) return null;

            return GetNivelesCaminoBrillanteMantenedor(paisId);
        }

        public List<BENivelCaminoBrillante> GetNivelesCache(int paisId)
        {
            return CacheManager<List<BENivelCaminoBrillante>>.ValidateDataElement(paisId, ECacheItem.CaminoBrillanteNiveles, () => GetNiveles(paisId));
        }

        public BEConsultoraCaminoBrillante GetConsultoraNivel(BEUsuario entidad)
        {
            _providerCaminoBrillante = _providerCaminoBrillante ?? getCaminoBrillanteProvider(entidad.PaisID);
            if (_providerCaminoBrillante == null) return null;

            var periodo = GetPeriodosCache(entidad.PaisID).Where(e => e.CampanaInicial >= entidad.CampaniaID && entidad.CampaniaID <= e.CampanaFinal).FirstOrDefault();
            if (periodo == null) return null;

            var nivelesConsultora = _providerCaminoBrillante.GetNivelConsultora(Util.GetPaisIsoHanna(entidad.PaisID), entidad.CodigoConsultora, periodo.NroCampana).Result;
            if (nivelesConsultora == null) return null;

            var nivelConsultora = (nivelesConsultora.Where(e => ((e.Campania == "" + entidad.CampaniaID) || (e.Campania == entidad.Campania))).FirstOrDefault() ?? (nivelesConsultora.Count > 0 ? nivelesConsultora[0] : new NivelConsultoraCaminoBrillante()));
            var logros = GetConsultoraLogros(entidad, GetNivelesCaminoBrillanteMantenedor(entidad.PaisID), nivelConsultora, nivelesConsultora, periodo);

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
                Niveles = GetNivelesCaminoBrillanteMantenedor(entidad.PaisID),
                ResumenLogros = GetResumenLogros(entidad.PaisID, logros),
                Logros = logros
            };
        }
        
        private List<BELogroCaminoBrillante> GetConsultoraLogros(BEUsuario entidad, List<BENivelCaminoBrillante> nivelesCaminoBrillantes, NivelConsultoraCaminoBrillante nivelConsultora, List<NivelConsultoraCaminoBrillante> nivelesConsultora, BEPeriodoCaminoBrillante periodoActual)
        {
            return new List<BELogroCaminoBrillante> {
                GetConsultoraLogrosCrecimiento(entidad.PaisID, entidad, nivelesCaminoBrillantes, nivelConsultora, nivelesConsultora, periodoActual),
                GetConsultoraLogrosCompromiso(entidad.PaisID, entidad, nivelConsultora) };
        }
        

        public List<BEKitCaminoBrillante> GetKit(BEUsuario entidad, int periodoId, int nivelId)
        {
            periodoId = 201903; //Para Prueba quitar luego
            //var kits =  GetKitCache(paisId, campania);
            //var kits = GetKitProvider(paisId, periodoId, entidad.CampaniaID);
            //var codNivel = "4";
            var nivel = nivelId;
            var nivelKit = 0;
            //int.TryParse(codNivel, out nivel); 

            //Si es null reintentar la llamada al servicio
            var kits = GetKitCache(entidad.PaisID, periodoId, entidad.CampaniaID) ?? new List<BEKitCaminoBrillante>();
            //var historicoKits = nivelId != 6 ? GetConsultoraKitHistorico(entidad, periodoId) : new List<BEKitsHistoricoConsultora>();
            var historicoKits = GetConsultoraKitHistorico(entidad, periodoId);

            /* Deshabilitamos de acuerdo al Nievel */
            kits.Where(e => int.TryParse(e.CodigoNivel, out nivelKit)).ForEach(e => {
                e.FlagHabilitado = int.Parse(e.CodigoNivel) <= nivel && nivel != 0;
            });

            /* Deshabilitamos de acuerdo al Historico */
            if (historicoKits != null) {
                var codKits = historicoKits.Select(e => e.CodigoKit).ToList();
                kits.Where(e => codKits.Contains(e.CodigoKit))
                    .ForEach(e => {
                        e.FlagSeleccionado = true;
                        e.FlagHabilitado = false;
                    });
            }

            return kits.OrderBy(e => e.CodigoNivel).ToList();
        }

        public List<BEKitCaminoBrillante> GetKit(int paisId, int campaniaId, int periodoId, int nivelId)
        {
            periodoId = 201903; //Para Prueba quitar luego
            //var kits =  GetKitCache(paisId, campania);
            //var kits = GetKitProvider(paisId, periodoId, entidad.CampaniaID);
            //var codNivel = "4";
            var nivel = nivelId;
            var nivelKit = 0;
            //int.TryParse(codNivel, out nivel); 

            //Si es null reintentar la llamada al servicio
            var kits = GetKitCache(paisId, periodoId, campaniaId) ?? new List<BEKitCaminoBrillante>();
            //var historicoKits = nivelId != 6 ? GetConsultoraKitHistorico(entidad, periodoId) : new List<BEKitsHistoricoConsultora>();
            //var historicoKits = GetConsultoraKitHistorico(entidad, periodoId);
            var historicoKits = new List<BEKitsHistoricoConsultora>();

            /* Deshabilitamos de acuerdo al Nievel */
            kits.Where(e => int.TryParse(e.CodigoNivel, out nivelKit)).ForEach(e => {
                e.FlagHabilitado = int.Parse(e.CodigoNivel) <= nivel && nivel != 0;
            });

            /* Deshabilitamos de acuerdo al Historico */
            if (historicoKits != null)
            {
                var codKits = historicoKits.Select(e => e.CodigoKit).ToList();
                kits.Where(e => codKits.Contains(e.CodigoKit))
                    .ForEach(e => {
                        e.FlagSeleccionado = true;
                        e.FlagHabilitado = false;
                    });
            }

            return kits.OrderBy(e => e.CodigoNivel).ToList();
        }

        public List<BEKitCaminoBrillante> GetKits(int paisId, int campaniaId, int nivelId) {
            var periodos = GetPeriodosCache(paisId) ?? new List<BEPeriodoCaminoBrillante>();
            var periodo = periodos.Where(e => e.CampanaInicial >= campaniaId && e.CampanaFinal <= campaniaId).FirstOrDefault();
            if (periodo == null) return null;
            return GetKit(paisId, campaniaId, periodo.Periodo, nivelId);
        }

        /*
        private List<BEKitCaminoBrillante> GetKit(int paisId, int campaniaId, int periodoId, int nivelId) {
            return null;
        }
        */

        private List<BEKitCaminoBrillante> GetKitCache(int paisId, int periodoId, int campaniaId)
        {
            return CacheManager<List<BEKitCaminoBrillante>>.ValidateDataElement(paisId, ECacheItem.CaminoBrillanteOfertas, string.Format("{0}-{1}", periodoId, campaniaId) , () => GetKitProvider(paisId, periodoId, campaniaId));
        }

        //Pendiente cargar imagenes
        private List<BEKitCaminoBrillante> GetKitProvider(int paisId, int periodoId, int campaniaId)
        {
            _providerCaminoBrillante = _providerCaminoBrillante ?? getCaminoBrillanteProvider(paisId);
            if (_providerCaminoBrillante == null) return null;

            var ofertas = _providerCaminoBrillante.GetOfertas(Util.GetPaisIsoHanna(paisId), periodoId).Result;
            var niveles = GetNiveles(paisId) ?? new List<BENivelCaminoBrillante>();

            if (ofertas.Any()) {
                var cuvsStringList = ofertas.Select(e => e.Cuv).Distinct().ToList().Serialize();
                var kits = new DACaminoBrillante(paisId).GetKitsCaminoBrillante(periodoId, campaniaId, cuvsStringList).MapToCollection<BEKitCaminoBrillante>(closeReaderFinishing: true);

                kits.ForEach(kit => {
                    var _kitProvider = ofertas.Where(e => e.Cuv == kit.CUV).FirstOrDefault();
                    if (_kitProvider != null) {
                        kit.CodigoKit = _kitProvider.CodigoKit;
                        kit.CodigoSap = _kitProvider.CodigoSap;
                        kit.DescripcionCUV = _kitProvider.Descripcion;
                        kit.DescripcionCortaCUV = _kitProvider.Descripcion;
                        kit.PrecioCatalogo = _kitProvider.Precio;
                        kit.Ganancia = kit.PrecioValorizado - kit.PrecioCatalogo;
                        kit.Digitable = _kitProvider.Digitable;
                        kit.CodigoNivel = _kitProvider.Nivel;
                        kit.FlagDigitable = _kitProvider.Digitable;
                        kit.DescripcionNivel = niveles.Where(e => e.CodigoNivel == _kitProvider.Nivel).Select(e => e.DescripcionNivel).SingleOrDefault();
                    }
                });

                return kits;
            }

            return null;
        }

        private List<BEKitsHistoricoConsultora> GetConsultoraKitHistorico(BEUsuario entidad, int periodoId)
        {
            _providerCaminoBrillante = _providerCaminoBrillante ?? getCaminoBrillanteProvider(entidad.PaisID);
            if (_providerCaminoBrillante == null) return null;

            var kitsHistoricos = _providerCaminoBrillante.GetKitHistoricoConsultora(Util.GetPaisIsoHanna(entidad.PaisID), entidad.CodigoConsultora, periodoId).Result;
            var kitsEnPedido = new DACaminoBrillante(entidad.PaisID).GetPedidoWebDetalleCaminoBrillante(periodoId, entidad.CampaniaID, entidad.ConsultoraID)
                                   .MapToCollection<BEKitsHistoricoConsultora>(closeReaderFinishing: true) ?? new List<BEKitsHistoricoConsultora>();

            if (kitsHistoricos != null)
                kitsEnPedido.AddRange(kitsHistoricos.Select( e => new BEKitsHistoricoConsultora() {
                    CodigoKit = e.CodigoKit,
                    CampaniaAtencion = e.CampaniaAtencion,
                }));

            return kitsEnPedido;
        }

        //Constantes
        //Validar Nuevas
        private BELogroCaminoBrillante GetResumenLogros(int paisId, List<BELogroCaminoBrillante> logros)
        {
            Func<BEMedallaCaminoBrillante, string, int, BEMedallaCaminoBrillante> funcCopyMedalla = (medalla, title, index) =>
            {
                if (medalla != null)
                {
                    return new BEMedallaCaminoBrillante()
                    {
                        Estado = medalla.Estado,
                        Valor = medalla.Valor,
                        Orden = index,
                        Tipo = medalla.Tipo,
                        Titulo = title
                    };
                }
                return medalla;
            };

            Func<string, string, BEMedallaCaminoBrillante> funcUltimaMedalla = (logro, indicador) =>
            {
                var _logro = logros.Where(e => e.Id == logro).FirstOrDefault() ?? new BELogroCaminoBrillante();
                var _indicador = _logro.Indicadores.Where(e => e.Codigo == indicador).FirstOrDefault() ?? new BEIndicadorCaminoBrillante();
                if(_indicador.Medallas != null)
                    return _indicador.Medallas.OrderByDescending(e => e.Orden).Where(e => e.Estado).FirstOrDefault() ??
                                _indicador.Medallas.OrderBy(e => e.Orden).FirstOrDefault();
                return null;
            };

            var medallaEscala = funcCopyMedalla(funcUltimaMedalla(Constantes.CaminoBrillante.Logros.CRECIMIENTO, Constantes.CaminoBrillante.Logros.Indicadores.ESCALA), "Escala", 0);
            var medallaContancia = funcCopyMedalla(funcUltimaMedalla(Constantes.CaminoBrillante.Logros.CRECIMIENTO, Constantes.CaminoBrillante.Logros.Indicadores.CONSTANCIA), "Constancia", 1);
            var medallaIncremento = funcCopyMedalla(funcUltimaMedalla(Constantes.CaminoBrillante.Logros.CRECIMIENTO, Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO_PEDIDO), "Incremento", 2);

            Func<List<BEMedallaCaminoBrillante>> funcResumenCompromiso = () =>
            {
                var lastMedallaProgramaNuevas = funcUltimaMedalla(Constantes.CaminoBrillante.Logros.COMPROMISO, Constantes.CaminoBrillante.Logros.Indicadores.PROGRAMA_NUEVAS);
                var lastMedallaTiempoJuntos = funcUltimaMedalla(Constantes.CaminoBrillante.Logros.COMPROMISO, Constantes.CaminoBrillante.Logros.Indicadores.TIEMPO_JUNTOS);
                var medallas = new List<BEMedallaCaminoBrillante>();

                Action<string, string, BEMedallaCaminoBrillante> addSerieMedalla = (logro, indicador, medalla) =>
                {
                    if (medalla != null) {
                        var _logro = logros.Where(e => e.Id == logro).FirstOrDefault() ?? new BELogroCaminoBrillante();
                        var _indicador = _logro.Indicadores.Where(e => e.Codigo == indicador).FirstOrDefault() ?? new BEIndicadorCaminoBrillante();
                        var index = _indicador.Medallas.IndexOf(medalla);

                        if (index - 1 >= 0 && medallas.Count < 3) medallas.Add(_indicador.Medallas[index - 1]);
                        if (medallas.Count < 3) medallas.Add(medalla);
                        if (index + 1 < _indicador.Medallas.Count && medallas.Count < 3) medallas.Add(_indicador.Medallas[index + 1]);
                        if (medallas.Count < 3 && index + 2 < _indicador.Medallas.Count) {
                            medallas.Add(_indicador.Medallas[index + 2]);
                        }

                    }
                };

                if (lastMedallaProgramaNuevas != null)
                    addSerieMedalla(Constantes.CaminoBrillante.Logros.COMPROMISO, Constantes.CaminoBrillante.Logros.Indicadores.PROGRAMA_NUEVAS, lastMedallaProgramaNuevas);                    
                
                if (medallas.Count < 3) {
                    if (lastMedallaTiempoJuntos != null)
                        addSerieMedalla(Constantes.CaminoBrillante.Logros.COMPROMISO, Constantes.CaminoBrillante.Logros.Indicadores.TIEMPO_JUNTOS, lastMedallaTiempoJuntos);
                }

                return medallas.Select(e => new BEMedallaCaminoBrillante() {
                    Estado = e.Estado,
                    Valor = e.Valor,
                    Orden = e.Orden,
                    Tipo = e.Tipo,
                    Titulo = e.Titulo
                }).Take(3).ToList();
            };
            
            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, Constantes.TablaLogica.CaminoBrillanteLogros) ?? new List<BETablaLogicaDatos>())
                .Where(e => e.Codigo == Constantes.CaminoBrillante.Logros.RESUMEN).FirstOrDefault() ?? new BETablaLogicaDatos();
            var tablaLogicaDatos_Crecimiento = (GetDatosTablaLogica(paisId, Constantes.TablaLogica.CaminoBrillanteLogros) ?? new List<BETablaLogicaDatos>())
                .Where(e => e.Codigo == Constantes.CaminoBrillante.Logros.CRECIMIENTO).FirstOrDefault() ?? new BETablaLogicaDatos();
            var tablaLogicaDatos_Compromiso = (GetDatosTablaLogica(paisId, Constantes.TablaLogica.CaminoBrillanteLogros) ?? new List<BETablaLogicaDatos>())
                .Where(e => e.Codigo == Constantes.CaminoBrillante.Logros.COMPROMISO).FirstOrDefault() ?? new BETablaLogicaDatos();

            return new BELogroCaminoBrillante()
            {
                Id = Constantes.CaminoBrillante.Logros.RESUMEN,
                Titulo = tablaLogicaDatos.Valor,
                Descripcion = tablaLogicaDatos.Descripcion,
                Indicadores = new List<BEIndicadorCaminoBrillante>{
                    new BEIndicadorCaminoBrillante() {
                        Orden = 0,
                        Titulo = tablaLogicaDatos_Crecimiento.Valor,
                        Descripcion = tablaLogicaDatos_Crecimiento.Descripcion,
                        Codigo = Constantes.CaminoBrillante.Logros.CRECIMIENTO,
                        Medallas = (new List<BEMedallaCaminoBrillante>{
                            medallaEscala,
                            medallaContancia,
                            medallaIncremento
                        }).Where(e => e != null).ToList()
                    },
                    new BEIndicadorCaminoBrillante() {
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
            var _incrementoPedido = GetConsultoraLogrosCrecimiento_IncrementoPedido(paisId, entidad, nivelConsutora);

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, Constantes.TablaLogica.CaminoBrillanteLogros) ?? new List<BETablaLogicaDatos>())
                .Where(e => e.Codigo == Constantes.CaminoBrillante.Logros.CRECIMIENTO).FirstOrDefault() ?? new BETablaLogicaDatos();

            return new BELogroCaminoBrillante()
            {
                Id = Constantes.CaminoBrillante.Logros.CRECIMIENTO,
                Titulo = tablaLogicaDatos.Valor,
                Descripcion = tablaLogicaDatos.Descripcion,
                Indicadores = (new List<BEIndicadorCaminoBrillante>{
                            _cambioEscalaDescuento,
                            _cambioNivel,
                            _constancia,
                            _incrementoPedido
                        })
                        .Where(e => e != null).ToList()
            };

        }

        private BEIndicadorCaminoBrillante GetConsultoraLogrosCrecimiento_CambioEscalaDescuento(int paisId, BEUsuario entidad, NivelConsultoraCaminoBrillante nivelConsultora)
        {
            var escalasDescuento = _escalaDescuentoBusinessLogic.GetEscalaDescuento(paisId, entidad.CampaniaID, entidad.Region, entidad.Zona) ?? new List<BEEscalaDescuento>();

            var configsMedalla = (GetGetConfiguracionMedallaCaminoBrillanteCache(paisId) ?? new List<BEConfiguracionMedallaCaminoBrillante>())
                .Where(e => e.Logro == Constantes.CaminoBrillante.Logros.CRECIMIENTO && e.Indicador == Constantes.CaminoBrillante.Logros.Indicadores.ESCALA)
                .ToList();

            var idx = 0;
            var medallaEscalas = escalasDescuento.Select(e => new BEMedallaCaminoBrillante()
            {
                Orden = idx++,
                Tipo = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.CIRC,
                Estado = (e.PorDescuento <= nivelConsultora.CambioEscala),
                Valor = e.PorDescuento + string.Empty,
            }).ToList();

            medallaEscalas.ForEach(e =>
            {
                var configMedalla = configsMedalla.Where(p => p.Codigo == e.Valor).FirstOrDefault();
                if (configMedalla != null)
                {
                    e.Subtitulo = e.Estado ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo;
                    e.Valor = string.Format(configMedalla.Valor ?? string.Empty, e.Valor);
                    e.ModalTitulo = configMedalla.ComoLograrlo_Estado ? configMedalla.ComoLograrlo_Titulo : string.Empty;
                    e.ModalDescripcion = configMedalla.ComoLograrlo_Estado ? configMedalla.ComoLograrlo_Descripcion : string.Empty;
                }
                else
                {
                    e.Valor = string.Format("{0}%", e.Valor);
                    e.Subtitulo = e.Estado ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo;
                }
            });

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, Constantes.TablaLogica.CaminoBrillanteIndicadores) ?? new List<BETablaLogicaDatos>())
                .Where(e => e.Codigo == Constantes.CaminoBrillante.Logros.Indicadores.ESCALA).FirstOrDefault() ?? new BETablaLogicaDatos();

            return new BEIndicadorCaminoBrillante()
            {
                Codigo = Constantes.CaminoBrillante.Logros.Indicadores.ESCALA,
                Titulo = tablaLogicaDatos.Valor,
                Medallas = medallaEscalas
            };
        }

        private BEIndicadorCaminoBrillante GetConsultoraLogrosCrecimiento_CambioNivel(int paisId, BEUsuario entidad, NivelConsultoraCaminoBrillante nivelConsultora, List<BENivelCaminoBrillante> nivelesCaminoBrillantes)
        {
            short nivelActual = 0;
            short nivelCodigo = 0;
            short.TryParse(nivelConsultora.NivelActual, out nivelActual);

            var configsMedalla = (GetGetConfiguracionMedallaCaminoBrillanteCache(paisId) ?? new List<BEConfiguracionMedallaCaminoBrillante>())
                .Where(e => e.Logro == Constantes.CaminoBrillante.Logros.CRECIMIENTO && e.Indicador == Constantes.CaminoBrillante.Logros.Indicadores.NIVEL)
                .ToList();

            var idx = 0;
            var medallaNiveles = nivelesCaminoBrillantes.Select(e => new BEMedallaCaminoBrillante()
            {
                Orden = idx++,
                Tipo = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.NIV,
                //Titulo = e.DescripcionNivel,
                Estado = (short.TryParse(e.CodigoNivel, out nivelCodigo) ? nivelCodigo <= nivelActual : false),
                Subtitulo = (nivelCodigo <= nivelActual ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo),
                Valor = e.CodigoNivel,
            }).ToList();

            medallaNiveles.ForEach(e =>
            {
                var configMedalla = configsMedalla.Where(p => p.Valor == e.Valor).FirstOrDefault();
                if (configMedalla != null)
                {
                    e.Subtitulo = e.Estado ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo;
                    e.ModalTitulo = configMedalla.ComoLograrlo_Estado ? configMedalla.ComoLograrlo_Titulo : string.Empty;
                    e.ModalDescripcion = configMedalla.ComoLograrlo_Estado ? configMedalla.ComoLograrlo_Descripcion : string.Empty;
                }
            });

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, Constantes.TablaLogica.CaminoBrillanteIndicadores) ?? new List<BETablaLogicaDatos>())
                .Where(e => e.Codigo == Constantes.CaminoBrillante.Logros.Indicadores.NIVEL).FirstOrDefault() ?? new BETablaLogicaDatos();

            return new BEIndicadorCaminoBrillante()
            {
                Codigo = Constantes.CaminoBrillante.Logros.Indicadores.NIVEL,
                Titulo = tablaLogicaDatos.Valor,
                Medallas = medallaNiveles
            };
        }

        private BEIndicadorCaminoBrillante GetConsultoraLogrosCrecimiento_Constancia(int paisId, BEUsuario entidad, NivelConsultoraCaminoBrillante nivelConsultora, List<NivelConsultoraCaminoBrillante> nivelesHistoricosConsultora, BEPeriodoCaminoBrillante periodoActual)
        {
            var medallaConstancia = new List<BEMedallaCaminoBrillante>();
            var periodos = GetPeriodos(entidad.PaisID);

            var nivelActual = 0;
            var _periodo = 0;
            int.TryParse(nivelConsultora.NivelActual, out nivelActual);

            var configMedalla = (GetGetConfiguracionMedallaCaminoBrillanteCache(paisId) ?? new List<BEConfiguracionMedallaCaminoBrillante>())
                .Where(e => e.Logro == Constantes.CaminoBrillante.Logros.CRECIMIENTO && e.Indicador == Constantes.CaminoBrillante.Logros.Indicadores.CONSTANCIA)
                .FirstOrDefault();

            if (configMedalla == null) return null;

            Action<string, int> builderMedallaConstancia = (periodo, constancia) =>
            {
                if (!string.IsNullOrEmpty(periodo))
                {
                    if (int.TryParse(periodo, out _periodo))
                    {
                        var periodoCaminoBrillante = periodos.Where(e => e.Periodo == _periodo).FirstOrDefault();
                        if (periodoCaminoBrillante != null)
                        {
                            var valor = string.Format("{0}-{1}-{2}", periodoCaminoBrillante.Periodo, periodoCaminoBrillante.NroCampana, constancia);
                            if (!medallaConstancia.Any(e => e.Valor == valor))
                            {
                                medallaConstancia.Add(new BEMedallaCaminoBrillante()
                                {
                                    Tipo = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.PIE,
                                    Estado = (constancia > 0),
                                    Titulo = string.Format(configMedalla.Valor ?? string.Empty, (periodoCaminoBrillante.CampanaInicial % 100), (periodoCaminoBrillante.CampanaFinal % 100)),
                                    Subtitulo = (""+constancia == periodoCaminoBrillante.NroCampana) ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo,
                                    ModalTitulo = configMedalla.ComoLograrlo_Estado ? configMedalla.ComoLograrlo_Titulo : string.Empty,
                                    ModalDescripcion = configMedalla.ComoLograrlo_Estado ? configMedalla.ComoLograrlo_Descripcion : string.Empty,
                                    Valor = valor,
                                });
                            }
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

            var orden = 0;
            medallaConstancia.OrderByDescending(e => e.Valor).ForEach(e => { e.Orden = orden++; });

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, Constantes.TablaLogica.CaminoBrillanteIndicadores) ?? new List<BETablaLogicaDatos>())
                .Where(e => e.Codigo == Constantes.CaminoBrillante.Logros.Indicadores.CONSTANCIA).FirstOrDefault() ?? new BETablaLogicaDatos();

            if (medallaConstancia.Count == 0 && periodoActual != null) {
                medallaConstancia.Add(new BEMedallaCaminoBrillante()
                {
                    Tipo = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.PIE,
                    Estado = false,
                    Titulo = string.Format(configMedalla.Valor ?? string.Empty, (periodoActual.CampanaInicial % 100), (periodoActual.CampanaFinal % 100)),
                    Subtitulo = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo,
                    ModalTitulo = configMedalla.ComoLograrlo_Estado ? configMedalla.ComoLograrlo_Titulo : string.Empty,
                    ModalDescripcion = configMedalla.ComoLograrlo_Estado ? configMedalla.ComoLograrlo_Descripcion : string.Empty,
                    Valor = string.Format("{0}-{1}-{2}", periodoActual.Periodo, periodoActual.NroCampana, 0),
                });
            }

            return new BEIndicadorCaminoBrillante()
            {
                Titulo = tablaLogicaDatos.Valor,
                Codigo = Constantes.CaminoBrillante.Logros.Indicadores.CONSTANCIA,
                Medallas = medallaConstancia
            };
        }

        private BEIndicadorCaminoBrillante GetConsultoraLogrosCrecimiento_IncrementoPedido(int paisId, BEUsuario entidad, NivelConsultoraCaminoBrillante nivelConsultora)
        {
            var idx = 0;
            int incremento = 0;

            var configMedalla = (GetGetConfiguracionMedallaCaminoBrillanteCache(paisId) ?? new List<BEConfiguracionMedallaCaminoBrillante>())
                .Where(e => e.Logro == Constantes.CaminoBrillante.Logros.CRECIMIENTO && e.Indicador == Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO_PEDIDO).ToList();

            var medallaIncrementoPedido = configMedalla
                .Where(e => int.TryParse(e.Codigo, out incremento))
                .Select(e => new BEMedallaCaminoBrillante()
                {
                    Orden = idx++,
                    Tipo = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.CIRC,
                    Estado = (nivelConsultora.PorcentajeIncremento <= int.Parse(e.Codigo)),
                    Subtitulo = (nivelConsultora.PorcentajeIncremento <= int.Parse(e.Codigo)) ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo,
                    Valor = string.Format(e.Valor ?? string.Empty, e.Codigo),                    
                    ModalTitulo = e.ComoLograrlo_Estado ? e.ComoLograrlo_Titulo : string.Empty,
                    ModalDescripcion = e.ComoLograrlo_Estado ? e.ComoLograrlo_Descripcion : string.Empty,
                }).ToList();

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, Constantes.TablaLogica.CaminoBrillanteIndicadores) ?? new List<BETablaLogicaDatos>())
                .Where(e => e.Codigo == Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO_PEDIDO).FirstOrDefault() ?? new BETablaLogicaDatos();

            return new BEIndicadorCaminoBrillante()
            {
                Titulo = tablaLogicaDatos.Valor,
                Codigo = Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO_PEDIDO,
                Medallas = medallaIncrementoPedido
            };
        }

        private BELogroCaminoBrillante GetConsultoraLogrosCompromiso(int paisId, BEUsuario entidad, NivelConsultoraCaminoBrillante nivelConsultora)
        {
            var medallasProgramaNuevas = GetConsultoraLogrosCompromiso_ProgramaNuevas(paisId, entidad);
            var medallasTiempoJuntos = GetConsultoraLogrosCompromiso_TiempoJuntos(paisId, entidad, nivelConsultora);

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, Constantes.TablaLogica.CaminoBrillanteLogros) ?? new List<BETablaLogicaDatos>())
                .Where(e => e.Codigo == Constantes.CaminoBrillante.Logros.COMPROMISO).FirstOrDefault() ?? new BETablaLogicaDatos();

            return new BELogroCaminoBrillante()
            {
                Id = Constantes.CaminoBrillante.Logros.COMPROMISO,
                Titulo = tablaLogicaDatos.Valor,
                Descripcion = tablaLogicaDatos.Descripcion,
                Indicadores = (new List<BEIndicadorCaminoBrillante> { medallasProgramaNuevas, medallasTiempoJuntos })
                              .Where(e => e != null).ToList()
            };
        }

        //Pendiente calcular el flag para mostrar y validar el campo consecutivo nuevas
        private BEIndicadorCaminoBrillante GetConsultoraLogrosCompromiso_ProgramaNuevas(int paisId, BEUsuario entidad)
        {
            var listEstadosValidos = new List<int> { Constantes.EstadoActividadConsultora.Registrada, Constantes.EstadoActividadConsultora.Retirada, Constantes.EstadoActividadConsultora.Ingreso_Nueva };
            //Calcular este Flag
            //var showMedallasNuevas = (entidad.EsConsultoraNueva && true);
            var showMedallasNuevas = listEstadosValidos.Contains(entidad.ConsultoraNueva);

            if (showMedallasNuevas)
            {
                var configMedalla = (GetGetConfiguracionMedallaCaminoBrillanteCache(paisId) ?? new List<BEConfiguracionMedallaCaminoBrillante>())
                                    .Where(e => e.Logro == Constantes.CaminoBrillante.Logros.COMPROMISO && e.Indicador == Constantes.CaminoBrillante.Logros.Indicadores.PROGRAMA_NUEVAS).ToList();
                
                int valPedido = 0;
                int orden = 0;
                var tablaLogicaDatos = (GetDatosTablaLogica(paisId, Constantes.TablaLogica.CaminoBrillanteIndicadores) ?? new List<BETablaLogicaDatos>())
                                        .Where(e => e.Codigo == Constantes.CaminoBrillante.Logros.Indicadores.PROGRAMA_NUEVAS).FirstOrDefault() ?? new BETablaLogicaDatos();

                return new BEIndicadorCaminoBrillante()
                { 
                    Titulo = tablaLogicaDatos.Valor,
                    Codigo = Constantes.CaminoBrillante.Logros.Indicadores.PROGRAMA_NUEVAS,
                    Medallas = configMedalla.Where( e => int.TryParse(e.Codigo, out valPedido))
                               .Select(e => new BEMedallaCaminoBrillante() {
                                   Orden = orden ++,
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

        private BEIndicadorCaminoBrillante GetConsultoraLogrosCompromiso_TiempoJuntos(int paisId, BEUsuario entidad, NivelConsultoraCaminoBrillante nivelConsultora)
        {
            var aniosConsultora = -1;
            if (!string.IsNullOrEmpty(nivelConsultora.FechaIngreso)) {
                DateTime anioIngreso = DateTime.MinValue;
                //var format = Constantes.Formatos.FechaHoraUTC;
                var format = "yyyy-MM-ddThh:mm:ss";
                if (nivelConsultora.FechaIngreso != null) {
                    //Corregir 
                    nivelConsultora.FechaIngreso = nivelConsultora.FechaIngreso.Substring(0, Math.Min(19, nivelConsultora.FechaIngreso.Length));
                }
                if (DateTime.TryParseExact(nivelConsultora.FechaIngreso, format, CultureInfo.InvariantCulture, DateTimeStyles.None, out anioIngreso)) {
                    aniosConsultora = Math.Max(0,DateTime.Now.Year - anioIngreso.Year);
                }
            }

            var configMedalla = (GetGetConfiguracionMedallaCaminoBrillanteCache(paisId) ?? new List<BEConfiguracionMedallaCaminoBrillante>())
                .Where(e => e.Logro == Constantes.CaminoBrillante.Logros.COMPROMISO && e.Indicador == Constantes.CaminoBrillante.Logros.Indicadores.TIEMPO_JUNTOS).ToList();

            int anios = 0;
            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, Constantes.TablaLogica.CaminoBrillanteIndicadores) ?? new List<BETablaLogicaDatos>())
                .Where(e => e.Codigo == Constantes.CaminoBrillante.Logros.Indicadores.TIEMPO_JUNTOS).FirstOrDefault() ?? new BETablaLogicaDatos();

            var orden = 0;
            var tiempoJuntos = new BEIndicadorCaminoBrillante()
            {
                Titulo = tablaLogicaDatos.Valor,
                Codigo = Constantes.CaminoBrillante.Logros.Indicadores.TIEMPO_JUNTOS,
                Medallas = configMedalla
                .Where(e => int.TryParse(e.Codigo, out anios))
                .Select(e => new BEMedallaCaminoBrillante()
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

        private List<BEPeriodoCaminoBrillante> GetPeriodos(int paisId)
        {
            _providerCaminoBrillante = _providerCaminoBrillante ?? getCaminoBrillanteProvider(paisId);
            if (_providerCaminoBrillante == null) return null;

            return (_providerCaminoBrillante.GetPeriodo(Util.GetPaisIsoHanna(paisId)).Result ?? new List<PeriodoCaminoBrillante>())
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

        private List<BEConfiguracionMedallaCaminoBrillante> GetGetConfiguracionMedallaCaminoBrillanteCache(int paisId)
        {
            return CacheManager<List<BEConfiguracionMedallaCaminoBrillante>>.ValidateDataElement(paisId, ECacheItem.CaminoBrillanteMedallas, () => GetGetConfiguracionMedallaCaminoBrillante(paisId));
        }

        private List<BEConfiguracionMedallaCaminoBrillante> GetGetConfiguracionMedallaCaminoBrillante(int paisId)
        {
            return new DACaminoBrillante(paisId).GetConfiguracionMedallaCaminoBrillante()
                .MapToCollection<BEConfiguracionMedallaCaminoBrillante>(closeReaderFinishing: true);
        }

        //Pendiente Quitar la Data Simulada de los beneficios
        //Leer Flags de tiene ofertas especiales
        private List<BENivelCaminoBrillante> GetNivelesCaminoBrillanteMantenedor(int paisId)
        {
            var lstBeneficios = GetBeneficiosCaminoBrillante(paisId) ?? new List<BEBeneficioCaminoBrillante>();
            var lstNiveles = _providerCaminoBrillante.GetNivel(Util.GetPaisIsoHanna(paisId)).Result;
            
            return lstNiveles.Select(e => new BENivelCaminoBrillante()
            {
                CodigoNivel = e.CodigoNivel,
                DescripcionNivel = e.DescripcionNivel,
                MontoMaximo = e.MontoMaximo,
                MontoMinimo = e.MontoMinimo,
                TieneOfertasEspeciales = !("1" == e.CodigoNivel), //Usar Configuracion
                Beneficios = lstBeneficios.Where(b => b.CodigoNivel == e.CodigoNivel && !(string.IsNullOrEmpty(b.NombreBeneficio)
                                                      && Constantes.CaminoBrillante.CodigoBeneficio.Beneficios.Contains(b.CodigoBeneficio))
                                                      ).ToList()
            }).ToList();
        }

        private List<BEBeneficioCaminoBrillante> GetBeneficiosCaminoBrillante(int paisId)
        {
            return new DACaminoBrillante(paisId).GetBeneficiosCaminoBrillante()
                .MapToCollection<BEBeneficioCaminoBrillante>(closeReaderFinishing:true);
        }

        private List<BETablaLogicaDatos> GetDatosTablaLogica(int paisId, short tablaLogicaId)
        {
            return _tablaLogicaDatosBusinessLogic.GetListCache(paisId, tablaLogicaId);
        }

        private CaminoBrillanteProvider getCaminoBrillanteProvider(int paisId)
        {
            return getCaminoBrillanteProvider(paisId, GetDatosTablaLogica(paisId, Constantes.TablaLogica.CaminoBrillanteInfoComercial));
        }

        private CaminoBrillanteProvider getCaminoBrillanteProvider(int paisID, List<BETablaLogicaDatos> datosTablaLogica)
        {
            if (datosTablaLogica == null || datosTablaLogica.Count == 0) return null;

            var url = datosTablaLogica.Where(a => a.Codigo == Constantes.CaminoBrillante.ServicioComercial.TablaLogicaDatosKey.UrlInformacionComercial).Select(e => e.Valor).FirstOrDefault();
            var usuario = datosTablaLogica.Where(a => a.Codigo == Constantes.CaminoBrillante.ServicioComercial.TablaLogicaDatosKey.UsuarioInformacionComercial).Select(e => e.Valor).FirstOrDefault();
            var clave = datosTablaLogica.Where(a => a.Codigo == Constantes.CaminoBrillante.ServicioComercial.TablaLogicaDatosKey.ClaveInformacionComercial).Select(e => e.Valor).FirstOrDefault();

            return new CaminoBrillanteProvider(url, usuario, clave);
        }

        public List<BEDesmostradoresCaminoBrillante> GetDemostradoresCaminoBrillante(int paisID, string campaniaID)
        {            
            return new DACaminoBrillante(paisID).GetDemostradoresCaminoBrillante(campaniaID)
                        .MapToCollection<BEDesmostradoresCaminoBrillante>(closeReaderFinishing: true);
        }

        private List<BEDesmostradoresCaminoBrillante> GetDemostradoresCaminoBrillanteCache(int paisID, string campaniaID)
        {
            return CacheManager<List<BEDesmostradoresCaminoBrillante>>.ValidateDataElement(paisID, ECacheItem.CaminoBrillanteDemostradores, campaniaID, () => GetDemostradoresCaminoBrillante(paisID, campaniaID));
        }

    }
}
