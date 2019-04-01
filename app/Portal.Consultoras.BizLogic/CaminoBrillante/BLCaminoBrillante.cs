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

        public List<BENivelCaminoBrillante> GetNiveles(int paisId, bool isWeb)
        {
            _providerCaminoBrillante = _providerCaminoBrillante ?? getCaminoBrillanteProvider(paisId);
            if (_providerCaminoBrillante == null) return null;

            return GetNivelesCaminoBrillanteMantenedor(paisId, isWeb);
        }

        public List<BENivelCaminoBrillante> GetNivelesCache(int paisId, bool isWeb)
        {
            return CacheManager<List<BENivelCaminoBrillante>>.ValidateDataElement(paisId, ECacheItem.CaminoBrillanteNiveles, isWeb ? "SB" : "APP", () => GetNiveles(paisId, isWeb));
        }

        public BEConsultoraCaminoBrillante GetConsultoraNivel(int paisId, BEUsuario entidad, bool isWeb)
        {
            _providerCaminoBrillante = _providerCaminoBrillante ?? getCaminoBrillanteProvider(paisId);
            if (_providerCaminoBrillante == null) return null;

            var periodo = GetPeriodosCache(paisId).Where(e => e.CampanaInicial >= entidad.CampaniaID && entidad.CampaniaID <= e.CampanaFinal).FirstOrDefault();
            if (periodo == null) return null;

            var nivelesConsultora = _providerCaminoBrillante.GetNivelConsultora(Util.GetPaisIsoHanna(paisId), entidad.CodigoConsultora, periodo.NroCampana).Result;
            if (nivelesConsultora == null) return null;

            var nivelConsultora = (nivelesConsultora.Where(e => ((e.Campania == "" + entidad.CampaniaID) || (e.Campania == entidad.Campania))).FirstOrDefault() ?? (nivelesConsultora.Count > 0 ? nivelesConsultora[0] : new NivelConsultoraCaminoBrillante()));
            var logros = GetConsultoraLogros(paisId, entidad, GetNivelesCaminoBrillanteMantenedor(paisId, isWeb), nivelConsultora, nivelesConsultora);

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
                Niveles = GetNivelesCaminoBrillanteMantenedor(paisId, isWeb),
                ResumenLogros = GetResumenLogros(paisId, logros),
                Logros = logros
            };
        }

        //Pendiente Implementar - Eliminar
        public List<BELogroCaminoBrillante> GetConsultoraLogros(int paisId, BEUsuario entidad, bool isWeb)
        {
            return null;
        }

        public List<BELogroCaminoBrillante> GetConsultoraLogros(int paisId, BEUsuario entidad, List<BENivelCaminoBrillante> nivelesCaminoBrillantes, NivelConsultoraCaminoBrillante nivelConsultora, List<NivelConsultoraCaminoBrillante> nivelesConsultora)
        {
            return new List<BELogroCaminoBrillante> {
                GetConsultoraLogrosCrecimiento(paisId, entidad, nivelesCaminoBrillantes, nivelConsultora, nivelesConsultora),
                GetConsultoraLogrosCompromiso(paisId, entidad, nivelConsultora) };
        }

        //Pendiente Implementar 
        public void GetConsultoraOfertas(int paisId, BEUsuario entidad, bool isWeb)
        {
            throw new NotImplementedException();
        }

        //Pendiente Implementar 
        public void GetConsultoraKits(int paisId, BEUsuario entidad, bool isWeb)
        {
            throw new NotImplementedException();
        }

        //Pendiente Optimizar 
        private BELogroCaminoBrillante GetResumenLogros(int paisId, List<BELogroCaminoBrillante> logros)
        {
            Func<string, string, BEMedallaCaminoBrillante> funcUltimaMedalla = (logro, indicador) =>
            {
                var _logro = logros.Where(e => e.Id == logro).FirstOrDefault() ?? new BELogroCaminoBrillante();
                var _indicador = _logro.Indicadores.Where(e => e.Codigo == indicador).FirstOrDefault() ?? new BEIndicadorCaminoBrillante();
                return _indicador.Medallas.OrderByDescending(e => e.Orden).Where(e => e.Estado).FirstOrDefault() ??
                            _indicador.Medallas.OrderBy(e => e.Orden).Where(e => e.Estado).FirstOrDefault();
            };

            var medallaEscala = funcUltimaMedalla(Constantes.CaminoBrillante.Logros.CRECIMIENTO, Constantes.CaminoBrillante.Logros.Indicadores.ESCALA);
            var medallaContancia = funcUltimaMedalla(Constantes.CaminoBrillante.Logros.CRECIMIENTO, Constantes.CaminoBrillante.Logros.Indicadores.CONSTANCIA);
            var medallaIncremento = funcUltimaMedalla(Constantes.CaminoBrillante.Logros.CRECIMIENTO, Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO);

            var compromiso = logros.Where(e => e.Id == Constantes.CaminoBrillante.Logros.COMPROMISO).FirstOrDefault();

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, Constantes.TablaLogica.CaminoBrillanteLogros) ?? new List<BETablaLogicaDatos>())
                .Where(e => e.Codigo == Constantes.CaminoBrillante.Logros.RESUMEN).FirstOrDefault() ?? new BETablaLogicaDatos();

            return new BELogroCaminoBrillante()
            {
                Id = Constantes.CaminoBrillante.Logros.RESUMEN,
                Titulo = tablaLogicaDatos.Valor,
                Descripcion = tablaLogicaDatos.Descripcion,
                Indicadores = new List<BEIndicadorCaminoBrillante>{
                    new BEIndicadorCaminoBrillante() {
                        Titulo = "Creciminto",
                        Descripcion = "Tu progreso tiene recompensas",
                        Medallas = (new List<BEMedallaCaminoBrillante>{
                            medallaEscala,
                            medallaContancia,
                            medallaIncremento
                        }).Where(e => e != null).ToList()
                    },
                    new BEIndicadorCaminoBrillante() {
                        Titulo = "Compromiso",
                        Descripcion = "Lorem Ipsum Dolor",
                        Medallas = new List<BEMedallaCaminoBrillante>{
                            new BEMedallaCaminoBrillante(){
                                Orden = 0,
                                Tipo = "PED",
                                Estado = true,
                                Titulo = "1er Pedido",
                                Valor = "1",
                            },
                            new BEMedallaCaminoBrillante(){
                                Orden = 0,
                                Tipo = "PED",
                                Estado = true,
                                Titulo = "2er Pedido",
                                Valor = "2",
                            },
                            new BEMedallaCaminoBrillante(){
                                Orden = 0,
                                Tipo = "PED",
                                Estado = true,
                                Titulo = "3er Pedido",
                                Valor = "3",
                            }
                        }
                    }
                }
            };
        }

        private BELogroCaminoBrillante GetConsultoraLogrosCrecimiento(int paisId, BEUsuario entidad, List<BENivelCaminoBrillante> nivelesCaminoBrillantes, NivelConsultoraCaminoBrillante nivelConsutora, List<NivelConsultoraCaminoBrillante> nivelesConsultora)
        {

            var _cambioEscalaDescuento = GetConsultoraLogrosCrecimiento_CambioEscalaDescuento(paisId, entidad, nivelConsutora);
            var _cambioNivel = GetConsultoraLogrosCrecimiento_CambioNivel(paisId, entidad, nivelConsutora, nivelesCaminoBrillantes);
            var _constancia = GetConsultoraLogrosCrecimiento_Constancia(paisId, entidad, nivelConsutora, nivelesConsultora);
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
                var configMedalla = configsMedalla.Where(p => p.Valor == e.Valor).FirstOrDefault();
                if (configMedalla != null)
                {
                    e.Subtitulo = e.Estado ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes;
                    e.ModalDescripcion = e.ModalDescripcion;
                    e.Valor = string.Format(e.Subtitulo ?? string.Empty, e.Valor);
                    e.ModalTitulo = configMedalla.ComoLograrlo_Estado ? configMedalla.ComoLograrlo_Titulo : string.Empty;
                    e.ModalDescripcion = configMedalla.ComoLograrlo_Estado ? configMedalla.ComoLograrlo_Descripcion : string.Empty;
                }
                else
                {
                    e.Valor = string.Format("{0}%", e.Valor);
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
                Estado = (short.TryParse(e.CodigoNivel, out nivelCodigo) ? nivelCodigo <= nivelActual : false),
                Valor = e.CodigoNivel,
            }).ToList();

            medallaNiveles.ForEach(e =>
            {
                var configMedalla = configsMedalla.Where(p => p.Valor == e.Valor).FirstOrDefault();
                if (configMedalla != null)
                {
                    e.Subtitulo = e.Estado ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes;
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

        private BEIndicadorCaminoBrillante GetConsultoraLogrosCrecimiento_Constancia(int paisId, BEUsuario entidad, NivelConsultoraCaminoBrillante nivelConsultora, List<NivelConsultoraCaminoBrillante> nivelesHistoricosConsultora)
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
                                    Subtitulo = (constancia > 0) ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes,
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
                .Where(e => e.Logro == Constantes.CaminoBrillante.Logros.CRECIMIENTO && e.Indicador == Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO).ToList();

            var medallaIncrementoPedido = configMedalla
                .Where(e => int.TryParse(e.Codigo, out incremento))
                .Select(e => new BEMedallaCaminoBrillante()
                {
                    Orden = idx++,
                    Tipo = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.CIRC,
                    Estado = (nivelConsultora.PorcentajeIncremento <= int.Parse(e.Codigo)),
                    Titulo = string.Format(e.Valor ?? string.Empty, nivelConsultora.PorcentajeIncremento),
                    Subtitulo = (nivelConsultora.PorcentajeIncremento <= int.Parse(e.Codigo)) ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes,
                    Valor = e.Valor,
                    ModalTitulo = e.ComoLograrlo_Estado ? e.ComoLograrlo_Titulo : string.Empty,
                    ModalDescripcion = e.ComoLograrlo_Estado ? e.ComoLograrlo_Descripcion : string.Empty,
                }).ToList();

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, Constantes.TablaLogica.CaminoBrillanteIndicadores) ?? new List<BETablaLogicaDatos>())
                .Where(e => e.Codigo == Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO).FirstOrDefault() ?? new BETablaLogicaDatos();

            return new BEIndicadorCaminoBrillante()
            {
                Titulo = tablaLogicaDatos.Valor,
                Codigo = Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO,
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
            //Calcular este Flag
            //var showMedallasNuevas = (entidad.EsConsultoraNueva && true);
            var showMedallasNuevas = true;

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
                if (DateTime.TryParseExact(nivelConsultora.FechaIngreso, Constantes.Formatos.FechaHoraUTC, CultureInfo.InvariantCulture, DateTimeStyles.None, out anioIngreso)) {
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
                    Subtitulo = (anios <= aniosConsultora) ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes,
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
                .MapToCollection<BEConfiguracionMedallaCaminoBrillante>();
        }

        //Pendiente Quitar la Data Simulada de los beneficios
        //Leer Flags de tiene ofertas especiales
        private List<BENivelCaminoBrillante> GetNivelesCaminoBrillanteMantenedor(int paisId, bool isWeb)
        {
            var lstBeneficios = GetBeneficiosCaminoBrillante(paisId) ?? new List<BEBeneficioCaminoBrillante>();
            var lstNiveles = _providerCaminoBrillante.GetNivel(Util.GetPaisIsoHanna(paisId)).Result;
            var pattern = (isWeb ? "http://somosbelcorpqa.s3.amazonaws.com/Iconos/CAMINOBRILLANTE/NIVELES/NIVEL_{KEY}_{STATE}.png"
                                  : "http://somosbelcorpqa.s3.amazonaws.com/Iconos/CAMINOBRILLANTE/NIVELES/{DIMEN}/NIVEL_{KEY}_{STATE}.png");

            //Simular Data
            #region Data Simulada
            foreach (var item in lstNiveles)
            {
                switch (item.CodigoNivel)
                {
                    case "1":
                        item.Beneficio1 = "Revista Mi Negocio L’Bel";
                        item.Beneficio2 = "1 catálogo gratis de Ésika, L’Bel, Cyzone";
                        item.Beneficio3 = "Regalo por pedido y constancia";
                        item.Beneficio4 = "Servicio Callcenter";
                        item.Beneficio5 = "Asesor guía por whatsapp y en persona";
                        break;
                    case "2":
                        item.Beneficio1 = "Revista Mi Negocio L’Bel";
                        item.Beneficio2 = "1 catálogo gratis de Ésika, L’Bel, Cyzone";
                        item.Beneficio3 = "20% de descuento en la compra de catálogos y demostradores";
                        item.Beneficio4 = "Regalo por pedido y constancia";
                        item.Beneficio5 = "Kit de productos a bajo precio";
                        break;
                    case "3":
                        item.Beneficio1 = "Revista Mi Negocio L’Bel";
                        item.Beneficio2 = "1 catálogo gratis de Ésika, L’Bel, Cyzone";
                        item.Beneficio3 = "25% de descuento en la compra de catálogos y demostradores";
                        item.Beneficio4 = "Regalo por pedido y constancia";
                        item.Beneficio5 = "Kit de productos a bajo precio";
                        break;
                    case "4":
                        item.Beneficio1 = "Kit de productos a bajo precio";
                        item.Beneficio2 = "1 catálogo gratis de Ésika, L’Bel, Cyzone";
                        item.Beneficio3 = "30% de descuento en la compra de catálogos y demostradores";
                        item.Beneficio4 = "Regalo por pedido y constancia";
                        item.Beneficio5 = "Kit de productos a bajo precio";
                        break;
                    case "5":
                        item.Beneficio1 = "Revista Mi Negocio L’Bel";
                        item.Beneficio2 = "1 catálogo gratis de Ésika, L’Bel, Cyzone";
                        item.Beneficio3 = "30% de descuento en la compra de catálogos y demostradores";
                        item.Beneficio4 = "Regalo por pedido y constancia";
                        item.Beneficio5 = "Kit de productos a bajo precio";
                        break;
                    case "6":
                        item.Beneficio1 = "Beneficios de topacio";
                        item.Beneficio2 = "Programa brillante según tu nivel";
                        item.Beneficio3 = "";
                        item.Beneficio4 = "";
                        item.Beneficio5 = "";
                        break;
                }
            }
            #endregion

            lstBeneficios.Where(e => Constantes.CaminoBrillante.CodigoBeneficio.Beneficios.Contains(e.CodigoBeneficio)).ForEach(e =>
            {
                switch (e.CodigoBeneficio)
                {
                    case Constantes.CaminoBrillante.CodigoBeneficio.BENEFICIO01:
                        e.NombreBeneficio = lstNiveles.Where(n => n.CodigoNivel == e.CodigoNivel).Select(n => n.Beneficio1).SingleOrDefault();
                        break;
                    case Constantes.CaminoBrillante.CodigoBeneficio.BENEFICIO02:
                        e.NombreBeneficio = lstNiveles.Where(n => n.CodigoNivel == e.CodigoNivel).Select(n => n.Beneficio2).SingleOrDefault();
                        break;
                    case Constantes.CaminoBrillante.CodigoBeneficio.BENEFICIO03:
                        e.NombreBeneficio = lstNiveles.Where(n => n.CodigoNivel == e.CodigoNivel).Select(n => n.Beneficio3).SingleOrDefault();
                        break;
                    case Constantes.CaminoBrillante.CodigoBeneficio.BENEFICIO04:
                        e.NombreBeneficio = lstNiveles.Where(n => n.CodigoNivel == e.CodigoNivel).Select(n => n.Beneficio4).SingleOrDefault();
                        break;
                    case Constantes.CaminoBrillante.CodigoBeneficio.BENEFICIO05:
                        e.NombreBeneficio = lstNiveles.Where(n => n.CodigoNivel == e.CodigoNivel).Select(n => n.Beneficio5).SingleOrDefault();
                        break;
                }
            });

            return lstNiveles.Select(e => new BENivelCaminoBrillante()
            {
                CodigoNivel = e.CodigoNivel,
                DescripcionNivel = e.DescripcionNivel,
                MontoMaximo = e.MontoMaximo,
                MontoMinimo = e.MontoMinimo,
                TieneOfertasEspeciales = !("1" == e.CodigoNivel),
                UrlImagenNivel = pattern.Replace("{KEY}", (e.CodigoNivel ?? "").Length == 1 ? "0" + e.CodigoNivel : e.CodigoNivel),
                Beneficios = lstBeneficios.Where(b => b.CodigoNivel == e.CodigoNivel && !(string.IsNullOrEmpty(b.NombreBeneficio)
                                                      && Constantes.CaminoBrillante.CodigoBeneficio.Beneficios.Contains(b.CodigoBeneficio))
                                                      ).ToList()
            }).ToList();
        }

        private List<BEBeneficioCaminoBrillante> GetBeneficiosCaminoBrillante(int paisId)
        {
            return new DACaminoBrillante(paisId).GetBeneficiosCaminoBrillante()
                .MapToCollection<BEBeneficioCaminoBrillante>();
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

    }
}
