using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data.CaminoBrillante;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.CaminoBrillante;
using Microsoft.Practices.EnterpriseLibrary.Common.Utility;

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

        public List<BENivelCaminoBrillante> GetNivelesCache(int paisId, bool isWeb) {
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

            var nivelConsultora = (nivelesConsultora.Where(e => ((e.Campania == "" + entidad.CampaniaID) || (e.Campania == entidad.Campania))).FirstOrDefault() ?? (nivelesConsultora.Count > 0 ? nivelesConsultora[0] : new CaminoBrillanteProvider.NivelConsultoraCaminoBrillante()));
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

        //Pendiente Implementar 
        public List<BELogroCaminoBrillante> GetConsultoraLogros(int paisId, BEUsuario entidad, bool isWeb)
        {
            return null;
        }

        public List<BELogroCaminoBrillante> GetConsultoraLogros(int paisId, BEUsuario entidad, List<BENivelCaminoBrillante> nivelesCaminoBrillantes, CaminoBrillanteProvider.NivelConsultoraCaminoBrillante nivelConsultora, List<CaminoBrillanteProvider.NivelConsultoraCaminoBrillante> nivelesConsultora) {
            return new List<BELogroCaminoBrillante> {
                GetConsultoraLogrosCrecimiento(paisId, entidad, nivelesCaminoBrillantes, nivelConsultora, nivelesConsultora),
                GetConsultoraLogrosCompromiso(paisId, entidad) };
        }

        //Pendiente Optimizar 
        public void GetConsultoraOfertas(int paisId, BEUsuario entidad, bool isWeb)
        {
            throw new NotImplementedException();
        }

        //Pendiente Optimizar 
        public void GetConsultoraKits(int paisId, BEUsuario entidad, bool isWeb)
        {
            throw new NotImplementedException();
        }

        //Pendiente Optimizar 
        private BELogroCaminoBrillante GetResumenLogros(int paisId, List<BELogroCaminoBrillante> logros)
        {
            Func<string, string, BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante> funcUltimaMedalla = (logro, indicador) => {
                var _logro = logros.Where(e => e.Id == logro).FirstOrDefault() ?? new BELogroCaminoBrillante();
                var _indicador = _logro.Indicadores.Where(e => e.Codigo == indicador).FirstOrDefault() ?? new BELogroCaminoBrillante.BEIndicadorCaminoBrillante();                
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
                Indicadores = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante>{
                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante() {
                        Titulo = "Creciminto",
                        Descripcion = "Tu progreso tiene recompensas",
                        Medallas = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>{
                            medallaEscala, 
                            medallaContancia,
                            medallaIncremento
                        }
                    },
                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante() {
                        Titulo = "Compromiso",
                        Descripcion = "Lorem Ipsum Dolor",
                        Medallas = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>{
                            new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                Orden = 0,
                                Tipo = "PED",
                                Estado = true,
                                Titulo = "1er Pedido",
                                Valor = "1",
                            },
                            new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                Orden = 0,
                                Tipo = "PED",
                                Estado = true,
                                Titulo = "2er Pedido",
                                Valor = "2",
                            },
                            new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
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

        private BELogroCaminoBrillante GetConsultoraLogrosCrecimiento(int paisId, BEUsuario entidad, List<BENivelCaminoBrillante> nivelesCaminoBrillantes,
            CaminoBrillanteProvider.NivelConsultoraCaminoBrillante nivelConsutora, List<CaminoBrillanteProvider.NivelConsultoraCaminoBrillante> nivelesConsultora) {

            var _cambioEscalaDescuento  = GetConsultoraLogrosCrecimiento_CambioEscalaDescuento(paisId, entidad, nivelConsutora);
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
                Indicadores = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante>{
                            _cambioEscalaDescuento,
                            _cambioNivel,
                            _constancia,
                            _incrementoPedido
                        }
            };
        }

        //Pendiente Optimizar 
        private BELogroCaminoBrillante.BEIndicadorCaminoBrillante GetConsultoraLogrosCrecimiento_CambioEscalaDescuento(int paisId, BEUsuario entidad, CaminoBrillanteProvider.NivelConsultoraCaminoBrillante nivelConsultora)
        {
            var escalasDescuento = _escalaDescuentoBusinessLogic.GetEscalaDescuento(paisId, entidad.CampaniaID, entidad.Region, entidad.Zona) ?? new List<BEEscalaDescuento>();

            var idx = 0;
            var medallaEscalas = escalasDescuento.Select(e => new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante()
            {
                Orden = idx++,
                Tipo = "CIR",
                Estado = (e.PorDescuento <= nivelConsultora.CambioEscala),
                Subtitulo = "¿Cómo lograrlo?",
                ModalTitulo = "Lorem Ipsum is simply",
                ModalDescripcion = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                Valor = e.PorDescuento + "%",
            }).ToList();

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, Constantes.TablaLogica.CaminoBrillanteIndicadores) ?? new List<BETablaLogicaDatos>())
                .Where(e => e.Codigo == Constantes.CaminoBrillante.Logros.Indicadores.ESCALA).FirstOrDefault() ?? new BETablaLogicaDatos();

            return new BELogroCaminoBrillante.BEIndicadorCaminoBrillante()
            {
                Codigo = Constantes.CaminoBrillante.Logros.Indicadores.ESCALA,
                Titulo = tablaLogicaDatos.Valor,
                Medallas = medallaEscalas
            };
        }

        //Pendiente Optimizar 
        private BELogroCaminoBrillante.BEIndicadorCaminoBrillante GetConsultoraLogrosCrecimiento_CambioNivel(int paisId, BEUsuario entidad, CaminoBrillanteProvider.NivelConsultoraCaminoBrillante nivelConsultora, List<BENivelCaminoBrillante> nivelesCaminoBrillantes)
        {
            short nivelActual = 0;
            short nivelCodigo = 0;
            short.TryParse(nivelConsultora.NivelActual, out nivelActual);

            var idx = 0;
            var medallaNiveles = nivelesCaminoBrillantes.Select(e => new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante()
            {
                Orden = idx++,
                Tipo = "NIV",
                Estado = (short.TryParse(e.CodigoNivel, out nivelCodigo) ? nivelCodigo <= nivelActual : false),
                Titulo = "¡Ya lo tienes!",
                ModalTitulo = "Lorem Ipsum is simply",
                ModalDescripcion = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                Valor = e.CodigoNivel,
            }).ToList();

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, Constantes.TablaLogica.CaminoBrillanteIndicadores) ?? new List<BETablaLogicaDatos>())
                .Where(e => e.Codigo == Constantes.CaminoBrillante.Logros.Indicadores.NIVEL).FirstOrDefault() ?? new BETablaLogicaDatos();

            return new BELogroCaminoBrillante.BEIndicadorCaminoBrillante()
            {
                Codigo = Constantes.CaminoBrillante.Logros.Indicadores.NIVEL,
                Titulo = tablaLogicaDatos.Valor,
                Medallas = medallaNiveles
            };
        }

        //Pendiente Optimizar 
        private BELogroCaminoBrillante.BEIndicadorCaminoBrillante GetConsultoraLogrosCrecimiento_Constancia(int paisId, BEUsuario entidad,
            CaminoBrillanteProvider.NivelConsultoraCaminoBrillante nivelConsultora, List<CaminoBrillanteProvider.NivelConsultoraCaminoBrillante> nivelesHistoricosConsultora)
        {
            var medallaConstancia = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>();
            var periodos = GetPeriodos(entidad.PaisID);

            var nivelActual = 0;
            var _periodo = 0;
            Int32.TryParse(nivelConsultora.NivelActual, out nivelActual);
            
            Action<string, int> builderMedallaConstancia = (periodo, constancia) => {
                if (!string.IsNullOrEmpty(periodo))
                {
                    if (Int32.TryParse(periodo, out _periodo)) {
                        var periodoCaminoBrillante = periodos.Where(e => e.Periodo == _periodo).FirstOrDefault();
                        if (periodoCaminoBrillante != null)
                        {
                            var valor = periodoCaminoBrillante.Periodo + "-" + periodoCaminoBrillante.NroCampana + "-" + constancia;
                            if (!medallaConstancia.Any(e => e.Valor == valor))
                            {
                                medallaConstancia.Add(new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante()
                                {
                                    Tipo = "PIE",
                                    Estado = (constancia > 0),
                                    Titulo = "De C" + (periodoCaminoBrillante.CampanaInicial % 100) + " a C" + (periodoCaminoBrillante.CampanaFinal % 100),
                                    Subtitulo = "¿Cómo lograrlo?",
                                    ModalTitulo = "Lorem Ipsum is simply",
                                    ModalDescripcion = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                                    Valor = valor,
                                });
                            }
                        }
                    }                   
                }
            };

            nivelesHistoricosConsultora.ForEach(e => {
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

            return new BELogroCaminoBrillante.BEIndicadorCaminoBrillante()
            {
                Titulo = tablaLogicaDatos.Valor,
                Codigo = Constantes.CaminoBrillante.Logros.Indicadores.CONSTANCIA,
                Medallas = medallaConstancia
            };
        }

        //Pendiente Optimizar 
        private BELogroCaminoBrillante.BEIndicadorCaminoBrillante GetConsultoraLogrosCrecimiento_IncrementoPedido(int paisId, BEUsuario entidad, CaminoBrillanteProvider.NivelConsultoraCaminoBrillante nivelConsultora)
        {
            var idx = 0;
            var incrementosPedido = new List<int> { 5, 10, 15, 20, 30, 40, 100 };

            var medallaIncrementoPedido = incrementosPedido.Select(e => new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante()
            {
                Orden = idx++,
                Tipo = "CIR",
                Estado = (nivelConsultora.PorcentajeIncremento <= e),
                Subtitulo = "¿Cómo lograrlo?",
                ModalTitulo = "Lorem Ipsum is simply",
                ModalDescripcion = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                Valor = e + "%",
            }).ToList();

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, Constantes.TablaLogica.CaminoBrillanteIndicadores) ?? new List<BETablaLogicaDatos>())
                .Where(e => e.Codigo == Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO).FirstOrDefault() ?? new BETablaLogicaDatos();

            return new BELogroCaminoBrillante.BEIndicadorCaminoBrillante()
            {
                Titulo = tablaLogicaDatos.Valor,
                Codigo = Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO,
                Medallas = medallaIncrementoPedido
            };
        }

        private BELogroCaminoBrillante GetConsultoraLogrosCompromiso(int paisId, BEUsuario entidad)
        {            
            var medallasProgramaNuevas = GetConsultoraLogrosCompromiso_ProgramaNuevas(paisId, entidad);
            var medallasTiempoJuntos = GetConsultoraLogrosCompromiso_TiempoJuntos(paisId, entidad);

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, Constantes.TablaLogica.CaminoBrillanteLogros) ?? new List<BETablaLogicaDatos>())
                .Where(e => e.Codigo == Constantes.CaminoBrillante.Logros.COMPROMISO).FirstOrDefault() ?? new BETablaLogicaDatos();

            return new BELogroCaminoBrillante()
            {
                Id = Constantes.CaminoBrillante.Logros.COMPROMISO,
                Titulo = tablaLogicaDatos.Valor,
                Descripcion = tablaLogicaDatos.Descripcion,
                Indicadores = (medallasProgramaNuevas != null ? 
                                new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante> { medallasProgramaNuevas, medallasTiempoJuntos } 
                                :new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante> { medallasTiempoJuntos })
            };
        }

        //Pendiente Optimizar
        private BELogroCaminoBrillante.BEIndicadorCaminoBrillante GetConsultoraLogrosCompromiso_ProgramaNuevas(int paisId, BEUsuario entidad)
        {
            if (entidad.ConsecutivoNueva < 10 && entidad.EsConsultoraNueva)
            {
                var pedidosProgramaNuevas = new List<int> { 1, 2, 3, 4, 5, 6 };
                //Tabla ODS
                return  new BELogroCaminoBrillante.BEIndicadorCaminoBrillante()
                {
                    Titulo = "Programa de nuevas",
                    Medallas = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>{
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "PED",
                                        Estado = true,
                                        Titulo ="1er pedido",
                                        Subtitulo = "¿Cómo lograrlo",
                                        Valor = "1",
                                    },
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "PED",
                                        Estado = true,
                                        Titulo ="2do pedido",
                                        Subtitulo = "¿Cómo lograrlo",
                                        Valor = "2",
                                    },
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "PED",
                                        Estado = true,
                                        Titulo ="3er pedido",
                                        Subtitulo = "¿Cómo lograrlo",
                                        Valor = "3",
                                    },
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "PED",
                                        Estado = true,
                                        Titulo ="4to pedido",
                                        Subtitulo = "¿Cómo lograrlo",
                                        Valor = "4",
                                    },
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "PED",
                                        Estado = true,
                                        Titulo ="5to pedido",
                                        Subtitulo = "¿Cómo lograrlo",
                                        Valor = "5",
                                    },
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "PED",
                                        Estado = true,
                                        Titulo ="6to pedido",
                                        Subtitulo = "¿Cómo lograrlo",
                                        Valor = "6",
                                    }
                                }
                };
            }
            return null;
        }

        //Pendiente de Optimizar
        private BELogroCaminoBrillante.BEIndicadorCaminoBrillante GetConsultoraLogrosCompromiso_TiempoJuntos(int paisId, BEUsuario entidad)
        {
            var aniosConsultora = 10;
            var medallasAnios = new List<int> { 1, 2, 3, 4, 5, 10, 15, 20, 30, 40 };

            var configMedalla = (GetGetConfiguracionMedallaCaminoBrillanteCache(paisId) ?? new List<BEConfiguracionMedallaCaminoBrillante>())
                .Where(e => e.Logro == Constantes.CaminoBrillante.Logros.COMPROMISO && e.Indicador == Constantes.CaminoBrillante.Logros.Indicadores.TIEMPO_JUNTOS).ToList();
            
            int anios = 0;
            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, Constantes.TablaLogica.CaminoBrillanteIndicadores) ?? new List<BETablaLogicaDatos>())
                .Where(e => e.Codigo == Constantes.CaminoBrillante.Logros.Indicadores.TIEMPO_JUNTOS).FirstOrDefault() ?? new BETablaLogicaDatos();

            var orden = 0;
            var tiempoJuntos = new BELogroCaminoBrillante.BEIndicadorCaminoBrillante()
            {
                Titulo = tablaLogicaDatos.Valor,
                Codigo = Constantes.CaminoBrillante.Logros.Indicadores.TIEMPO_JUNTOS,
                /*
                Medallas = configMedalla
                .Where(e => Int32.TryParse(e.Valor,out anios))
                .Select( e => new BEMedallaCaminoBrillante()
                {
                    Orden = orden++,
                    Tipo = "TIM",
                    Estado = anios <= aniosConsultora,
                    Titulo = string.Format(e.SubTitulo??string.Empty, anios),  //e + (1 == 1 ? " año" : " años"),
                    Subtitulo = "¿Cómo lograrlo?",
                    Valor = e.Valor, //"" + e,
                    //ModalTitulo = "Lorem Ipsum is simply",
                    ModalDescripcion = e.Descripcion //"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                }).ToList()
                */

                
                Medallas = medallasAnios.Select(e => new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante()
                {
                    Orden = orden++,
                    Tipo = "TIM",
                    Estado = e <= anios,
                    Titulo = e + (1 == 1 ? " año" : " años"),
                    Subtitulo = "¿Cómo lograrlo?",
                    Valor = "" + e,
                    ModalTitulo = "Lorem Ipsum is simply",
                    ModalDescripcion = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                }).ToList()
                

            };

            return tiempoJuntos;
        }
        
        private List<BEPeriodoCaminoBrillante> GetPeriodos(int paisId) {
            _providerCaminoBrillante = _providerCaminoBrillante ?? getCaminoBrillanteProvider(paisId);
            if (_providerCaminoBrillante == null) return null;

            return (_providerCaminoBrillante.GetPeriodo(Util.GetPaisIsoHanna(paisId)).Result ?? new List<CaminoBrillanteProvider.PeriodoCaminoBrillante>())
                .Select(e => new BEPeriodoCaminoBrillante() {
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
        
        private List<BEConfiguracionMedallaCaminoBrillante> GetGetConfiguracionMedallaCaminoBrillante(int paisId) {
            return new DACaminoBrillante(paisId).GetConfiguracionMedallaCaminoBrillante()
                .MapToCollection<BEConfiguracionMedallaCaminoBrillante>();
        }

        //Pendiente Quitar la Data Simulada de los beneficios
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
                                                      && Constantes.CaminoBrillante.CodigoBeneficio.Beneficios.Contains(b.CodigoBeneficio))).ToList()
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
