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

        public List<BEOfertaCaminoBrillante> GetOfertas(int paisId, string campania)
        {
            return GetOfertasCache(paisId, campania);
        }

        public List<BEOfertaCaminoBrillante> GetOfertasCache(int paisId, string campania)
        {
            return CacheManager<List<BEOfertaCaminoBrillante>>.ValidateDataElement(paisId, ECacheItem.CaminoBrillanteOfertas, campania, () => GetOfertasProvider(paisId, campania));
        }

        //Pendiente cargar imagenes
        public List<BEOfertaCaminoBrillante> GetOfertasProvider(int paisId, string campania)
        {
            _providerCaminoBrillante = _providerCaminoBrillante ?? getCaminoBrillanteProvider(paisId);
            if (_providerCaminoBrillante == null) return null;

            var ofertas = _providerCaminoBrillante.GetOfertas(Util.GetPaisIsoHanna(paisId), campania).Result;

            return ofertas.Select(e => new BEOfertaCaminoBrillante()
            {
                CodigoKit = e.CodigoKit,
                CodigoSap = e.CodigoSap,
                Cuv = e.Cuv,
                Descripcion = e.Descripcion,
                DescripcionOferta = e.DescripcionOferta,
                Digitable = e.Digitable,
                Marca = e.Marca,
                Nivel = e.Nivel,
                Precio = e.Precio,
                Imagen = "https://cdn1-prd.somosbelcorp.com/Matriz/PE/PE_2019345307_zvcbmzibzx.png"
            }).ToList();
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

        public List<BEKitsHistoricoConsultora> GetConsultoraKitHistorico(int paisId, BEUsuario entidad, bool isWeb)
        {
            _providerCaminoBrillante = _providerCaminoBrillante ?? getCaminoBrillanteProvider(paisId);
            if (_providerCaminoBrillante == null) return null;

            var kitsHistoricos = _providerCaminoBrillante.GetKitHistoricoConsultora(Util.GetPaisIsoHanna(paisId), entidad.CodigoConsultora, entidad.Campania).Result;

            return kitsHistoricos.Select( e => new BEKitsHistoricoConsultora() {
                CodigoKit = e.CodigoKit,
                CampaniaAtencion = e.CampaniaAtencion
            }).ToList();
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
            var medallaIncremento = funcCopyMedalla(funcUltimaMedalla(Constantes.CaminoBrillante.Logros.CRECIMIENTO, Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO), "Incremento", 2);

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

                        if (index - 1 > 0 && medallas.Count < 3) medallas.Add(_indicador.Medallas[index - 1]);
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
                        Medallas = funcResumenCompromiso()
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
                var configMedalla = configsMedalla.Where(p => p.Codigo == e.Valor).FirstOrDefault();
                if (configMedalla != null)
                {
                    e.Subtitulo = e.Estado ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes;
                    e.Valor = string.Format(configMedalla.Valor ?? string.Empty, e.Valor);
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
                    Subtitulo = (nivelConsultora.PorcentajeIncremento <= int.Parse(e.Codigo)) ? Constantes.CaminoBrillante.Logros.Indicadores.Medallas.ComoLograrlo : Constantes.CaminoBrillante.Logros.Indicadores.Medallas.YaLoTienes,
                    Valor = string.Format(e.Valor ?? string.Empty, e.Codigo),                    
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
            var showMedallasNuevas = (entidad.EsConsultoraNueva || (entidad.ConsecutivoNueva > 0));

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

        public List<BEDesmostradoresCaminoBrillante> GetDemostradoresCaminoBrillante(int paisID, string campaniaID)
        {            
            var demostradores = new List<BEDesmostradoresCaminoBrillante>();
            var daCaminoBrillante = new DACaminoBrillante(paisID);

            using (IDataReader reader = daCaminoBrillante.GetDemostradoresCaminoBrillante(campaniaID))
                while (reader.Read())
                {
                    demostradores.Add(new BEDesmostradoresCaminoBrillante(reader));
                }

            return demostradores;
        }
    }
}
