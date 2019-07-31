﻿using Microsoft.Practices.EnterpriseLibrary.Common.Utility;
using Portal.Consultoras.BizLogic.CaminoBrillante.Rest;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.Serializer;
using Portal.Consultoras.Data.CaminoBrillante;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.CaminoBrillante;
using Portal.Consultoras.Entities.OrdenYFiltros;
using Portal.Consultoras.Entities.Pedido;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;

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

        private bool Niveles_TIeneOfertasEspeciales(List<BETablaLogicaDatos> beTablaLogicaDatos, string codNivel, bool defValor)
        {
            var bETablaLogicaDato = beTablaLogicaDatos.FirstOrDefault(e => e.Codigo == codNivel);
            return bETablaLogicaDato != null ? "1".Equals(bETablaLogicaDato.Valor) : defValor;
        }

        private BENivelCaminoBrillante Niveles_EnterateMas(BENivelCaminoBrillante beNivelCaminoBrillante, List<BETablaLogicaDatos> bETablaLogicaDatos, string codNivel)
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

        public List<BEBeneficioCaminoBrillante> GetBeneficiosCaminoBrillante(int paisId, string codigoNivel = "")
        {
            return new DACaminoBrillante(paisId).GetBeneficiosCaminoBrillante(codigoNivel).MapToCollection<BEBeneficioCaminoBrillante>(closeReaderFinishing: true);
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

        public BEConsultoraCaminoBrillante GetConsultoraNivel(BEUsuario entidad, int version)
        {
            _providerCaminoBrillante = _providerCaminoBrillante ?? GetCaminoBrillanteProvider(entidad.PaisID);
            if (_providerCaminoBrillante == null) return null;

            var periodo = GetPeriodo(entidad.PaisID, entidad.CampaniaID);
            if (periodo == null) return null;

            var nivelesConsultora = _providerCaminoBrillante.GetNivelConsultora(Util.GetPaisIsoHanna(entidad.PaisID), entidad.CodigoConsultora, periodo.NroCampana).Result;
            if (nivelesConsultora == null) return null;

            var nivelConsultora = (nivelesConsultora.FirstOrDefault(e => ((e.Campania == entidad.CampaniaID.ToString()) || (e.Campania == entidad.Campania))) ?? (nivelesConsultora.Count > 0 ? nivelesConsultora.First() : new NivelConsultoraCaminoBrillante()));
            var niveles = GetNiveles(entidad.PaisID);
            var logros = GetConsultoraLogros(entidad, niveles, nivelConsultora, nivelesConsultora, periodo, version);

            return new BEConsultoraCaminoBrillante()
            {
                NivelConsultora = CalcularMisGanancias(nivelesConsultora.Select(e => new BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante()
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
                }).OrderByDescending(e => e.Campania).ToList()),
                Niveles = CalcularCuantoFalta(niveles, periodo, nivelConsultora, nivelesConsultora),
                ResumenLogros = GetResumenLogros(entidad.PaisID, logros, nivelesConsultora, periodo, version),
                Logros = logros,
                Configuracion = GetConfiguracionConsultoraCaminoBrillante(entidad, periodo, nivelConsultora)
            };
        }

        private List<BEConfiguracionCaminoBrillante> GetConfiguracionConsultoraCaminoBrillante(BEUsuario entidad, BEPeriodoCaminoBrillante periodo, NivelConsultoraCaminoBrillante nivelConsultora) {

            var periodoActual = (periodo != null ? periodo.Periodo : 0);
            var nivelActual = 0;
            if (nivelConsultora != null) int.TryParse(nivelConsultora.NivelActual, out nivelActual);
            
            var consultoraMeta = (new DACaminoBrillante(entidad.PaisID).GetConsultoraCaminoBrillante(entidad.ConsultoraID, periodoActual, entidad.CampaniaID, nivelActual).MapToCollection<BEConsultoraCaminoBrillanteMeta>(closeReaderFinishing: true) ?? new List<BEConsultoraCaminoBrillanteMeta>()).FirstOrDefault();
            var configs = new List<BEConfiguracionCaminoBrillante>();

            if (consultoraMeta != null)
            {
                if (consultoraMeta.FlagOnboardingAnim.HasValue) {
                    if (consultoraMeta.FlagOnboardingAnim.Value)
                    {
                        configs.Add(new BEConfiguracionCaminoBrillante()
                        {
                            Codigo = "CB_CON_ONBOARDING_ANIM",
                            Descripcion = "Flag de Onboarding",
                            Valor = "1",
                        });
                    }
                }


                if (consultoraMeta.FlagGananciaAnim.HasValue)
                {
                    if (consultoraMeta.FlagGananciaAnim.Value)
                    {
                        configs.Add(new BEConfiguracionCaminoBrillante()
                        {
                            Codigo = "CB_CON_GANANCIA_ANIM",
                            Descripcion = "Flag de Ganancias",
                            Valor = "1",
                        });
                    }
                }


                if (consultoraMeta.FlagCambioNivelAnim.HasValue)
                {
                    if (consultoraMeta.FlagCambioNivelAnim.Value)
                    {
                        configs.Add(new BEConfiguracionCaminoBrillante()
                        {
                            Codigo = "CB_CON_CAMB_NIVEL_ANIM",
                            Descripcion = "Flag de Ganancias",
                            Valor = "1",
                        });
                    }
                }


                configs.Add(new BEConfiguracionCaminoBrillante()
                {
                    Codigo = "CB_CON_CAMB_NIVEL_VAL",
                    Descripcion = "Flag de Ganancias",
                    Valor = "+1",
                });

                configs.Add(new BEConfiguracionCaminoBrillante()
                {
                    Codigo = "CB_MONTO_INCENTIVO",
                    Descripcion = "Monto Incentivo",
                    Valor = "500",
                });

            }


            /*
            return new List<BEConfiguracionCaminoBrillante>() {
                new BEConfiguracionCaminoBrillante(){
                    Codigo = "CB_CON_ONBOARDING_ANIM",
                    Descripcion = "Flag de Onboarding",
                    Valor = "1",
                },
                new BEConfiguracionCaminoBrillante(){
                    Codigo = "CB_CON_GANANCIA_ANIM",
                    Descripcion = "Flag de Ganancias",
                    Valor = "1",
                },
                new BEConfiguracionCaminoBrillante(){
                    Codigo = "CB_CON_CAMB_NIVEL_ANIM",
                    Descripcion = "Flag de Ganancias",
                    Valor = "1",
                },
                new BEConfiguracionCaminoBrillante(){
                    Codigo = "CB_CON_CAMB_NIVEL_VAL",
                    Descripcion = "Flag de Ganancias",
                    Valor = "+1",
                },
                new BEConfiguracionCaminoBrillante(){
                    Codigo = "CB_MONTO_INCENTIVO",
                    Descripcion = "Monto Incentivo",
                    Valor = "500",
                },
            };
            */

            return configs;
        }

        private List<BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante> CalcularMisGanancias(List<BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante> nivelesHistoricosConsultora)
        {
            if (!nivelesHistoricosConsultora.Any()) return nivelesHistoricosConsultora;
            /* Marcamos la Ultima Campania */
            decimal montoPedido = 0;
            var ultimoNivel = nivelesHistoricosConsultora.Where(e => decimal.TryParse(e.MontoPedido, out montoPedido) && montoPedido > 0).OrderByDescending(e => e.Campania).FirstOrDefault();
            if (ultimoNivel != null) ultimoNivel.FlagSeleccionMisGanancias = true;
            return nivelesHistoricosConsultora;
        }

        private List<BENivelCaminoBrillante> CalcularCuantoFalta(List<BENivelCaminoBrillante> niveles, BEPeriodoCaminoBrillante periodo, NivelConsultoraCaminoBrillante nivelActualConsutora, List<NivelConsultoraCaminoBrillante> consultoraHistoricos)
        {
            if (niveles == null || periodo == null || nivelActualConsutora == null) return niveles;

            int nivel = 0;
            if (!int.TryParse(nivelActualConsutora.NivelActual, out nivel)) return niveles;

            nivel = nivel + 1;
            decimal montoPedido = 0; decimal _montoPedido = 0; decimal montoMinimo = 0;

            /* Calcular el Monto total */
            if (consultoraHistoricos != null)
            {
                var peridoStr = periodo.Periodo.ToString();
                montoPedido = consultoraHistoricos.Where(h => decimal.TryParse(h.MontoPedido, out _montoPedido) && h.PeriodoCae == peridoStr).Sum(h => decimal.Parse(h.MontoPedido));
            }

            /* Calcular cuanto Falta */
            if (nivel.ToString() == Constantes.CaminoBrillante.CodigoNiveles.Brillante)
            {
                niveles.Where(e => e.CodigoNivel == (nivel - 1).ToString()).Update(e =>
                {
                    if (decimal.TryParse(e.MontoMinimo, out montoMinimo) && montoMinimo > montoPedido)
                    {
                        e.MontoFaltante = montoMinimo - montoPedido;
                    }
                    e.MontoAcumulado = montoPedido;
                });
            }
            else
            {
                niveles.Where(e => e.CodigoNivel == nivel.ToString() && e.CodigoNivel != Constantes.CaminoBrillante.CodigoNiveles.Brillante).Update(e =>
                {
                    e.MontoFaltante = decimal.TryParse(e.MontoMinimo, out montoMinimo) ? (montoMinimo - montoPedido) : e.MontoFaltante;
                    e.MontoAcumulado = montoPedido;
                });
            }

            /* Puntaje Acumulado en Nivel 6 */
            niveles.Where(e => e.CodigoNivel == Constantes.CaminoBrillante.CodigoNiveles.Brillante).Update(e =>
            {
                e.PuntajeAcumulado = nivelActualConsutora.PuntajeAcumulado.HasValue ? nivelActualConsutora.PuntajeAcumulado : e.PuntajeAcumulado;
            });

            return niveles;
        }

        private List<BELogroCaminoBrillante> GetConsultoraLogros(BEUsuario entidad, List<BENivelCaminoBrillante> nivelesCaminoBrillantes, NivelConsultoraCaminoBrillante nivelConsultora, List<NivelConsultoraCaminoBrillante> nivelesConsultora, BEPeriodoCaminoBrillante periodoActual, int version)
        {
            switch (version)
            {
                case Constantes.CaminoBrillante.Version.VER_01:
                    return (new List<BELogroCaminoBrillante> {
                        GetConsultoraLogrosCrecimiento(entidad.PaisID, entidad, nivelesCaminoBrillantes, nivelConsultora, nivelesConsultora, periodoActual, version),
                        GetConsultoraLogrosCompromiso(entidad.PaisID, entidad, nivelConsultora, version)
                    }).Where(e => e != null).ToList();
                case Constantes.CaminoBrillante.Version.VER_02:
                    return (new List<BELogroCaminoBrillante> {
                        GetConsultoraLogrosCrecimiento(entidad.PaisID, entidad, nivelesCaminoBrillantes, nivelConsultora, nivelesConsultora, periodoActual, version),
                        GetConsultoraLogroDetallado(entidad.PaisID,entidad, nivelesCaminoBrillantes, nivelConsultora, periodoActual, nivelesConsultora)
                    }).Where(e => e != null).ToList();
                default:
                    return null;
            }
        }

        private BELogroCaminoBrillante GetConsultoraLogroDetallado(int paisId, BEUsuario entidad, List<BENivelCaminoBrillante> nivelesCaminoBrillantes, NivelConsultoraCaminoBrillante nivelConsultora, BEPeriodoCaminoBrillante periodoActual, List<NivelConsultoraCaminoBrillante> nivelesHistoricosConsultora)
        {
            var medallaConstancia = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>();
            var periodos = GetPeriodos(entidad.PaisID);

            var configMedalla = (GetGetConfiguracionMedallaCaminoBrillanteCache(paisId) ?? new List<BEConfiguracionMedallaCaminoBrillante>())
                                .FirstOrDefault(e => e.Logro == Constantes.CaminoBrillante.Logros.CRECIMIENTO && e.Indicador == Constantes.CaminoBrillante.Logros.Indicadores.CONSTANCIA_DETALLADA);
            if (configMedalla == null || periodos == null) return null;

            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteIndicadores) ?? new List<BETablaLogicaDatos>())
                                   .FirstOrDefault(e => e.Codigo == Constantes.CaminoBrillante.Logros.Indicadores.CONSTANCIA) ?? new BETablaLogicaDatos();

            /* Calculamos los periodos Validos */
            var periodosValidos = new List<string>() { periodoActual.Periodo.ToString() };
            nivelesHistoricosConsultora.ForEach(e =>
            {
                periodosValidos.Add(e.Periodo1);
                periodosValidos.Add(e.Periodo2);
                periodosValidos.Add(e.Periodo3);
                periodosValidos.Add(e.Periodo4);
                periodosValidos.Add(e.Periodo5);
            });
            periodosValidos = periodosValidos.Distinct().ToList();
            periodosValidos = periodosValidos.Where(e => e != null).ToList();

            /* Agregamos los Periodos = Indicadores */
            var indicadores = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante>();
            var campanias = new List<string> { "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18" };
            Func<int, string> funCampania = (campania) =>
            {
                var res = (campania % 10);
                return res >= 10 ? res.ToString() : "0" + res.ToString();
            };
            Func<BEPeriodoCaminoBrillante, List<string>> funGetCampaniasPeriodo = (periodo) =>
            {
                var nroCampania = 0;
                if (int.TryParse(periodo.NroCampana, out nroCampania))
                {
                    var idx = campanias.IndexOf(funCampania(periodo.CampanaInicial));
                    var result = campanias.Skip(idx).Take(nroCampania).ToList();
                    if (result.Count < nroCampania)
                    {
                        result.AddRange(campanias.Take(nroCampania - result.Count));
                    }
                    return result;
                }
                return null;
            };

            Func<BEPeriodoCaminoBrillante, List<string>, List<string>> funGetEstadoCampaniasInPeriodo = (periodo, campaniasInPeriodo) =>
            {
                var result = new List<string>();
                /* Check si Paso en el Periodo */
                var perTxt = periodo.Periodo.ToString();
                var nivelHistorico = nivelesHistoricosConsultora.FirstOrDefault(e => e.Periodo1 == perTxt || e.Periodo2 == perTxt || e.Periodo3 == perTxt || e.Periodo4 == perTxt || e.Periodo5 == perTxt);
                if (nivelHistorico != null) {
                    var constancia = nivelHistorico.Periodo1 == perTxt ? nivelHistorico.Constancia1 :
                                     nivelHistorico.Periodo2 == perTxt ? nivelHistorico.Constancia2 :
                                     nivelHistorico.Periodo3 == perTxt ? nivelHistorico.Constancia3 :
                                     nivelHistorico.Periodo4 == perTxt ? nivelHistorico.Constancia4 :
                                     nivelHistorico.Periodo5 == perTxt ? nivelHistorico.Constancia5 : 0;
                    result.AddRange(campaniasInPeriodo.Take(constancia));
                }
                return result;
            };

            periodos.ForEach(p =>
            {
                if (periodosValidos.Contains(p.Periodo.ToString()))
                {
                    var indicador = new BELogroCaminoBrillante.BEIndicadorCaminoBrillante()
                    {
                        Codigo = p.Periodo.ToString(),
                        Titulo = string.Format("C{0} a C{1}", funCampania(p.CampanaInicial), funCampania(p.CampanaFinal)),
                        Medallas = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>()
                    };

                    var campaniasInPeriodo = (funGetCampaniasPeriodo(p) ?? new List<string>());
                    var campaniasPedidoINPeriodo = (funGetEstadoCampaniasInPeriodo(p, campaniasInPeriodo) ?? new List<string>());

                    /* Agregamos las Medallas */
                    campaniasInPeriodo.ForEach(m =>
                    {
                        var estado = campaniasPedidoINPeriodo.Contains(m);
                        var subTitulo = periodoActual.Periodo != p.Periodo || estado ? string.Format("C{0}", m) :  "Obtener";

                        indicador.Medallas.Add(new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante()
                        {
                            Tipo = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.PED,
                            Titulo = string.Format(configMedalla.Valor ?? string.Empty, (p.CampanaInicial % 100), (p.CampanaFinal % 100)),
                            Subtitulo = subTitulo,
                            ModalTitulo = configMedalla.ComoLograrlo_Estado ? configMedalla.ComoLograrlo_Titulo : string.Empty,
                            ModalDescripcion = configMedalla.ComoLograrlo_Estado ? string.Format(configMedalla.ComoLograrlo_Descripcion, string.Format("C{0}", m)) : string.Empty,
                            Valor = string.Format("C{0}", m),
                            Estado = estado
                        });
                    });
                    indicadores.Add(indicador);
                }
            });

            var orden = 0;
            indicadores.OrderByDescending(e => e.Codigo).ForEach(e => e.Orden = orden++);

            return new BELogroCaminoBrillante()
            {
                Id = Constantes.CaminoBrillante.Logros.CONSTANCIA_DETALLADA,
                Titulo = "Constancia del periodo:",
                Indicadores = indicadores.OrderBy(e => e.Orden).ToList()
            };
        }

        private BELogroCaminoBrillante GetResumenLogros(int paisId, List<BELogroCaminoBrillante> logros, List<NivelConsultoraCaminoBrillante> nivelesConsultora, BEPeriodoCaminoBrillante periodo, int version)
        {
            switch (version)
            {
                case Constantes.CaminoBrillante.Version.VER_01:
                    return GetResumenLogros_I(paisId, logros, nivelesConsultora, periodo);
                case Constantes.CaminoBrillante.Version.VER_02:
                    return GetResumenLogros_II(paisId, logros, nivelesConsultora, periodo);
                default:
                    return null;
            }
        }

        private BELogroCaminoBrillante GetResumenLogros_I(int paisId, List<BELogroCaminoBrillante> logros, List<NivelConsultoraCaminoBrillante> nivelesConsultora, BEPeriodoCaminoBrillante periodo)
        {
            var funcCopyMedalla = GetFunCopyMedalla_I();
            var funcUltimaMedalla = GetFunUltimaMedalla_I(logros);
            var funcResumenCompromiso = GetResumenCompromiso(funcUltimaMedalla, logros);

            var medallaEscala = funcCopyMedalla(funcUltimaMedalla(Constantes.CaminoBrillante.Logros.CRECIMIENTO, Constantes.CaminoBrillante.Logros.Indicadores.ESCALA, true),
                                                Constantes.CaminoBrillante.Logros.Indicadores.Titulos[Constantes.CaminoBrillante.Logros.Indicadores.ESCALA], 0);
            var medallaContancia = funcCopyMedalla(funcUltimaMedalla(Constantes.CaminoBrillante.Logros.CRECIMIENTO, Constantes.CaminoBrillante.Logros.Indicadores.CONSTANCIA, false),
                                                Constantes.CaminoBrillante.Logros.Indicadores.Titulos[Constantes.CaminoBrillante.Logros.Indicadores.CONSTANCIA], 1);
            var medallaIncremento = funcCopyMedalla(funcUltimaMedalla(Constantes.CaminoBrillante.Logros.CRECIMIENTO, Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO_PEDIDO, true),
                                                Constantes.CaminoBrillante.Logros.Indicadores.Titulos[Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO_PEDIDO], 2);

            if (medallaContancia != null) medallaContancia.Estado = true;

            var tablaLogicaDatos_Resumen = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteLogros) ?? new List<BETablaLogicaDatos>())
                                            .FirstOrDefault(e => e.Codigo == Constantes.CaminoBrillante.Logros.RESUMEN) ?? new BETablaLogicaDatos();
            var tablaLogicaDatos_Crecimiento = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteLogros) ?? new List<BETablaLogicaDatos>())
                                                .FirstOrDefault(e => e.Codigo == Constantes.CaminoBrillante.Logros.CRECIMIENTO) ?? new BETablaLogicaDatos();
            var tablaLogicaDatos_Compromiso = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteLogros) ?? new List<BETablaLogicaDatos>())
                                                .FirstOrDefault(e => e.Codigo == Constantes.CaminoBrillante.Logros.COMPROMISO) ?? new BETablaLogicaDatos();

            var funcResumenLogros = GetFuncResumenLogros_I(tablaLogicaDatos_Resumen, tablaLogicaDatos_Crecimiento, tablaLogicaDatos_Compromiso, medallaEscala, medallaContancia, medallaIncremento, funcResumenCompromiso);

            return funcResumenLogros();
        }

        private BELogroCaminoBrillante GetResumenLogros_II(int paisId, List<BELogroCaminoBrillante> logros, List<NivelConsultoraCaminoBrillante> nivelesConsultora, BEPeriodoCaminoBrillante periodo)
        {
            var funcCopyMedalla = GetFunCopyMedalla_II();
            var funcUltimaMedalla = GetFunUltimaMedalla_II(logros, true);
            var medallaEscala = funcCopyMedalla(funcUltimaMedalla(Constantes.CaminoBrillante.Logros.CRECIMIENTO, Constantes.CaminoBrillante.Logros.Indicadores.ESCALA, true),
                                                Constantes.CaminoBrillante.Logros.Indicadores.Titulos[Constantes.CaminoBrillante.Logros.Indicadores.ESCALA], 0);
            var medallaContancia = GetMedallaConstancia(logros, periodo, true);
            var medallaIncremento = funcCopyMedalla(funcUltimaMedalla(Constantes.CaminoBrillante.Logros.CRECIMIENTO, Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO_PEDIDO, true),
                                                Constantes.CaminoBrillante.Logros.Indicadores.Titulos[Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO_PEDIDO], 2);

            if (medallaContancia != null) medallaContancia.Estado = true;

            var tablaLogicaDatos_Resumen = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteLogros) ?? new List<BETablaLogicaDatos>())
                                            .FirstOrDefault(e => e.Codigo == Constantes.CaminoBrillante.Logros.RESUMEN) ?? new BETablaLogicaDatos();
            var tablaLogicaDatos_ResumenUnificado = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteLogros) ?? new List<BETablaLogicaDatos>())
                                                    .FirstOrDefault(e => e.Codigo == Constantes.CaminoBrillante.Logros.RESUMEN_UNIFICADO) ?? new BETablaLogicaDatos();

            var funcResumenLogros = GetFuncResumenLogros_II(tablaLogicaDatos_Resumen, tablaLogicaDatos_ResumenUnificado, medallaEscala, medallaContancia, medallaIncremento, nivelesConsultora);

            return funcResumenLogros();
        }

        private BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante GetMedallaConstancia(List<BELogroCaminoBrillante> logros, BEPeriodoCaminoBrillante periodo, bool destacar)
        {
            var logro = logros.FirstOrDefault(e => e.Id == Constantes.CaminoBrillante.Logros.CONSTANCIA_DETALLADA);
            var medalla = new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante()
            {
                Tipo = "TXT",
                Titulo = "Constancia del Periodo",
                Valor = "-"
            };
            if (logro != null)
            {
                var indicadorCampania = logro.Indicadores.FirstOrDefault(e => e.Codigo == periodo.Periodo.ToString());
                var count = 0;
                if (indicadorCampania != null)
                {
                    count = indicadorCampania.Medallas.Where(e => e.Estado).Count();
                }
                if (count > 0 && destacar)
                {
                    var destacada = indicadorCampania.Medallas.OrderByDescending(e => e.Valor).FirstOrDefault();
                    destacada.Destacar = true;
                }
                medalla.Valor = string.Format("{0} de {1}", count, periodo.NroCampana);
            }
            return medalla;
        }

        private Func<BELogroCaminoBrillante> GetFuncResumenLogros_I(BETablaLogicaDatos tablaLogicaDatos_Resumen, BETablaLogicaDatos tablaLogicaDatos_Crecimiento, BETablaLogicaDatos tablaLogicaDatos_Compromiso,
            BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante medallaEscala, BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante medallaContancia, BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante medallaIncremento,
            Func<List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>> funcResumenCompromiso)
        {
            Func<BELogroCaminoBrillante> funcResumenLogros = () =>
            {
                return new BELogroCaminoBrillante()
                {
                    Id = Constantes.CaminoBrillante.Logros.RESUMEN,
                    Titulo = tablaLogicaDatos_Resumen.Valor,
                    Descripcion = tablaLogicaDatos_Resumen.Descripcion,
                    Indicadores = (new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante>{
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
                }).Where(e => e != null).ToList()
                };
            };
            return funcResumenLogros;
        }

        private Func<BELogroCaminoBrillante> GetFuncResumenLogros_II(BETablaLogicaDatos tablaLogicaDatos_Resumen, BETablaLogicaDatos tablaLogicaDatos_ResumenUnificado,
            BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante medallaEscala, BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante medallaContancia, BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante medallaIncremento,
            List<NivelConsultoraCaminoBrillante> nivelesConsultora)
        {
            Func<BELogroCaminoBrillante> funcResumenLogros = () =>
            {
                return new BELogroCaminoBrillante()
                {
                    Id = Constantes.CaminoBrillante.Logros.RESUMEN,
                    Titulo = tablaLogicaDatos_Resumen.Valor,
                    Descripcion = tablaLogicaDatos_Resumen.Descripcion,
                    Indicadores = (new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante>{
                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante() {
                        Orden = 0,
                        Titulo =  buildTiempoJuntos(tablaLogicaDatos_ResumenUnificado.Valor,nivelesConsultora),
                        Descripcion = tablaLogicaDatos_ResumenUnificado.Descripcion,
                        Codigo = Constantes.CaminoBrillante.Logros.RESUMEN_UNIFICADO,
                        Medallas = (new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>{
                            medallaEscala,
                            medallaContancia,
                            medallaIncremento
                        }).Where(e => e != null).ToList()
                    }
                }).Where(e => e != null).ToList()
                };
            };
            return funcResumenLogros;
        }

        private string buildTiempoJuntos(string format, List<NivelConsultoraCaminoBrillante> nivelesConsultora)
        {
            var nivelConsultora = nivelesConsultora.FirstOrDefault();
            if (nivelConsultora == null) return string.Empty;
            if (!string.IsNullOrEmpty(nivelConsultora.FechaIngreso))
            {
                var strFechaIngreso = nivelConsultora.FechaIngreso.Substring(0, Math.Min(19, nivelConsultora.FechaIngreso.Length));
                var formatFecha = Constantes.Formatos.FechaHoraUTC;
                DateTime anioIngreso;
                int aniosConsultora = 0;

                if (DateTime.TryParseExact(strFechaIngreso, formatFecha, CultureInfo.InvariantCulture, DateTimeStyles.None, out anioIngreso))
                {
                    aniosConsultora = Math.Max(0, DateTime.Today.AddTicks(-anioIngreso.Ticks).Year - 1);
                }

                if (aniosConsultora > 0)
                {
                    return string.Format(format, aniosConsultora) + (aniosConsultora == 1 ? " año" : " años");
                }
            }
            return string.Empty;
        }

        private Func<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante, string, int, BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante> GetFunCopyMedalla_I()
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

        private Func<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante, string, int, BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante> GetFunCopyMedalla_II()
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
                        Titulo = medalla.Titulo
                    };
            };
            return funcCopyMedalla;
        }

        [Obsolete("Método en desuso, utilice el Método GetFunUltimaMedalla_II.")]
        private Func<string, string, bool, BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante> GetFunUltimaMedalla_I(List<BELogroCaminoBrillante> logros)
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

        private Func<string, string, bool, BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante> GetFunUltimaMedalla_II(List<BELogroCaminoBrillante> logros, bool destacar)
        {
            var _funcUltimaMedalla = GetFunUltimaMedalla_I(logros);
            var _funcCopyMedalla = GetFunCopyMedalla_I();

            Func<string, string, bool, BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante> funcUltimaMedalla = (logro, indicador, estado) =>
            {
                var _ultimaMedalla = _funcUltimaMedalla(logro, indicador, estado);
                if (_ultimaMedalla != null && destacar) _ultimaMedalla.Destacar = true;                
                var _logro = _funcCopyMedalla(_ultimaMedalla, string.Empty, 0);
                if (_logro != null)
                {
                    switch (indicador)
                    {
                        case Constantes.CaminoBrillante.Logros.Indicadores.ESCALA:
                            _logro.Tipo = "TXT";
                            _logro.Titulo = "Escala Máxima";
                            break;
                        case Constantes.CaminoBrillante.Logros.Indicadores.CONSTANCIA:
                            _logro.Tipo = "TXT";
                            _logro.Titulo = "Constancia del Periodo";
                            var parts = _logro.Valor.Split('-');
                            if (parts.Length == 3)
                            {
                                _logro.Valor = parts[2] + " de " + parts[1];
                                if ("0" == parts[2])
                                {
                                    _logro.Valor = "-";
                                }
                            }
                            _logro.Estado = true;
                            break;
                        case Constantes.CaminoBrillante.Logros.Indicadores.INCREMENTO_PEDIDO:
                            _logro.Tipo = "TXT";
                            _logro.Titulo = "Incremento Máxima";
                            break;
                    }
                    if (!_logro.Estado)
                    {
                        _logro.Valor = "-";
                    }
                }
                return _logro;
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

        private BELogroCaminoBrillante GetConsultoraLogrosCrecimiento(int paisId, BEUsuario entidad, List<BENivelCaminoBrillante> nivelesCaminoBrillantes, NivelConsultoraCaminoBrillante nivelConsutora,
            List<NivelConsultoraCaminoBrillante> nivelesConsultora, BEPeriodoCaminoBrillante periodoActual, int version)
        {
            switch (version)
            {
                case Constantes.CaminoBrillante.Version.VER_01:
                    return GetConsultoraLogrosCrecimiento_I(paisId, entidad, nivelesCaminoBrillantes, nivelConsutora, nivelesConsultora, periodoActual);
                case Constantes.CaminoBrillante.Version.VER_02:
                    return GetConsultoraLogrosCrecimiento_II(paisId, entidad, nivelesCaminoBrillantes, nivelConsutora, nivelesConsultora, periodoActual);
                default:
                    return null;
            }
        }

        [Obsolete("Método en desuso, utilice el Método GetConsultoraLogrosCrecimiento_II.")]
        private BELogroCaminoBrillante GetConsultoraLogrosCrecimiento_I(int paisId, BEUsuario entidad, List<BENivelCaminoBrillante> nivelesCaminoBrillantes, NivelConsultoraCaminoBrillante nivelConsutora,
            List<NivelConsultoraCaminoBrillante> nivelesConsultora, BEPeriodoCaminoBrillante periodoActual)
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
                        }).Where(e => e != null).ToList()
            };
        }

        private BELogroCaminoBrillante GetConsultoraLogrosCrecimiento_II(int paisId, BEUsuario entidad, List<BENivelCaminoBrillante> nivelesCaminoBrillantes, NivelConsultoraCaminoBrillante nivelConsutora,
            List<NivelConsultoraCaminoBrillante> nivelesConsultora, BEPeriodoCaminoBrillante periodoActual)
        {
            var _cambioEscalaDescuento = GetConsultoraLogrosCrecimiento_CambioEscalaDescuento(paisId, entidad, nivelConsutora);
            var _incrementoPedido = GetConsultoraLogrosCrecimiento_IncrementoPedido(paisId, nivelConsutora);
            var tablaLogicaDatos = (GetDatosTablaLogica(paisId, ConsTablaLogica.CaminoBrillante.CaminoBrillanteLogros) ?? new List<BETablaLogicaDatos>())
                                    .FirstOrDefault(e => e.Codigo == Constantes.CaminoBrillante.Logros.CRECIMIENTO) ?? new BETablaLogicaDatos();

            if (_incrementoPedido != null)
            {
                if(_cambioEscalaDescuento.Medallas != null)
                {
                    _cambioEscalaDescuento.Medallas.Where(e => e.Estado).ForEach(e => e.Subtitulo = "");
                    _cambioEscalaDescuento.Medallas.Where(e => !e.Estado).ForEach(e => e.Subtitulo = "Obtener");

                }
            }
            if (_incrementoPedido != null)
            {
                if(_incrementoPedido.Medallas != null)
                {
                    _incrementoPedido.Medallas.Where(e => e.Estado).ForEach(e => e.Subtitulo = "");
                    _incrementoPedido.Medallas.Where(e => !e.Estado).ForEach(e => e.Subtitulo = "Obtener");
                }
            }

            return new BELogroCaminoBrillante()
            {
                Id = Constantes.CaminoBrillante.Logros.CRECIMIENTO,
                Titulo = tablaLogicaDatos.Valor,
                Descripcion = tablaLogicaDatos.Descripcion,
                Indicadores = (new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante>{
                            _cambioEscalaDescuento,
                            _incrementoPedido}).Where(e => e != null).ToList()
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

        private Action<string, int> GetBuilderMedallaContancia(List<BEPeriodoCaminoBrillante> periodos, List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante> medallaConstancia, BEPeriodoCaminoBrillante _periodoActual, BEConfiguracionMedallaCaminoBrillante configMedalla)
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

        private BELogroCaminoBrillante GetConsultoraLogrosCompromiso(int paisId, BEUsuario entidad, NivelConsultoraCaminoBrillante nivelConsultora, int version)
        {
            var medallasProgramaNuevas = GetConsultoraLogrosCompromiso_ProgramaNuevas(paisId, entidad);
            var medallasTiempoJuntos = version == 1 ? GetConsultoraLogrosCompromiso_TiempoJuntos(paisId, nivelConsultora) : null;

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
                var comparator = getOrderFunc(paisId);
                kits.ForEach(kit =>
                {
                    var _kitProvider = kitsProvider.FirstOrDefault(e => e.Cuv == kit.CUV);
                    if (_kitProvider != null)
                    {
                        kit.CodigoKit = _kitProvider.CodigoKit;
                        kit.CodigoSap = _kitProvider.CodigoSap;
                        kit.DescripcionCortaCUV = kit.DescripcionCUV;
                        kit.PrecioCatalogo = _kitProvider.Precio;
                        kit.FlagDigitable = _kitProvider.Digitable;
                        kit.CodigoNivel = _kitProvider.Nivel;
                        kit.FlagDigitable = _kitProvider.Digitable;
                        kit.DescripcionNivel = niveles.Where(e => e.CodigoNivel == _kitProvider.Nivel).Select(e => e.DescripcionNivel).SingleOrDefault();
                        kit.FotoProductoSmall = !string.IsNullOrEmpty(kit.FotoProductoSmall) ? ConfigCdn.GetUrlFileCdnMatriz(paisISO, kit.FotoProductoSmall) : string.Empty;
                        kit.FotoProductoMedium = !string.IsNullOrEmpty(kit.FotoProductoMedium) ? ConfigCdn.GetUrlFileCdnMatriz(paisISO, kit.FotoProductoMedium) : string.Empty;
                        kit.Detalle = _kitProvider.Digitable == 1 ? GetDetalleKit(kits, kitsProvider.Where(e => e.Nivel == _kitProvider.Nivel).Select(e => e.Cuv).ToList(), comparator) ?? new List<BEKitCaminoBrillante>() : null;
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

        private List<BEKitsHistoricoConsultora> GeOfertasHistoricos(int paisId, long consultoraId, string codigoConsultora, int campaniaId, int periodoId)
        {
            _providerCaminoBrillante = _providerCaminoBrillante ?? GetCaminoBrillanteProvider(paisId);
            if (_providerCaminoBrillante == null) return null;

            var kitsHistoricos = _providerCaminoBrillante.GetKitHistoricoConsultora(Util.GetPaisIsoHanna(paisId), codigoConsultora, periodoId).Result ?? new List<KitsHistoricoConsultora>();
            var kitsEnPedido = new DACaminoBrillante(paisId).GetPedidoWebDetalleCaminoBrillante(periodoId, campaniaId, consultoraId).MapToCollection<BEKitsHistoricoConsultora>(closeReaderFinishing: true) ?? new List<BEKitsHistoricoConsultora>();
            kitsEnPedido.AddRange(kitsHistoricos.Select(e => new BEKitsHistoricoConsultora() { CodigoKit = e.CodigoKit, CampaniaAtencion = e.CampaniaAtencion, CampaniaID = campaniaId, FlagHistorico = true }));

            return kitsEnPedido;
        }

        private List<BEKitCaminoBrillante> GetDetalleKit(List<BEKitCaminoBrillante> kits, List<string> cuvs, Comparison<BEKitCaminoBrillante> comparator)
        {
            if (cuvs == null) return null;
            var detalle = kits.Where(e => cuvs.Contains(e.CUV)).Select(e => new BEKitCaminoBrillante()
            {
                CodigoEstrategia = e.CodigoEstrategia,
                CodigoKit = e.CodigoKit,
                CodigoNivel = e.CodigoNivel,
                CodigoSap = e.CodigoSap,
                CUV = e.CUV,
                DescripcionCortaCUV = e.DescripcionCortaCUV,
                DescripcionCUV = e.DescripcionCUV,
                DescripcionMarca = e.DescripcionMarca,
                DescripcionNivel = e.DescripcionNivel,
                EstrategiaID = e.EstrategiaID,
                Detalle = null,
                FlagDigitable = e.FlagDigitable,
                FlagHabilitado = e.FlagHabilitado,
                FlagHistorico = e.FlagHistorico,
                FlagSeleccionado = e.FlagSeleccionado,
                FotoProductoMedium = e.FotoProductoMedium,
                FotoProductoSmall = e.FotoProductoSmall,
                Ganancia = e.Ganancia,
                MarcaID = e.MarcaID,
                OrigenPedidoWebFicha = e.OrigenPedidoWebFicha,
                PrecioCatalogo = e.PrecioCatalogo,
                PrecioValorizado = e.PrecioValorizado,
                TipoEstrategiaID = e.TipoEstrategiaID
            }).ToList();
            detalle.Sort(comparator);
            return detalle;
        }

        private Comparison<BEKitCaminoBrillante> getOrderFunc(int paisId)
        {
            var paisISO = Util.GetPaisIsoHanna(paisId);
            var isPaisEsika = Common.Settings.ServiceSettings.Instance.PaisesEsika.Contains(paisISO);
            var orden = isPaisEsika ? new int[] { 1, 2, 3 } : new int[] { 2, 1, 3 }; //Buscar en el Config
            return (a, b) =>
            {
                var valA = orden.Contains(a.MarcaID) ? Array.IndexOf(orden, a.MarcaID) : -1;
                var valB = orden.Contains(b.MarcaID) ? Array.IndexOf(orden, b.MarcaID) : -1;
                if (valA == valB) return 0;
                return (valA > valB) ? 1 : -1;
            };
        }

        #endregion

        #region Demostradores

        public BEDemostradoresPaginado GetDemostradores(BEUsuario entidad, int cantRegistros, int regMostrados, string codOrdenar, string codFiltro)
        {
            var objDemostradores = new BEDemostradoresPaginado();
            var demostradores = GetDemostradoresCaminoBrillanteCache(entidad.PaisID, entidad.CampaniaID, entidad.NivelCaminoBrillante);
            var demostradoresEnPedido = new DACaminoBrillante(entidad.PaisID).GetPedidoWebDetalleCaminoBrillante(entidad.CampaniaID, entidad.CampaniaID, entidad.ConsultoraID).MapToCollection<BEKitsHistoricoConsultora>(closeReaderFinishing: true) ?? new List<BEKitsHistoricoConsultora>();

            if (codOrdenar == Constantes.CaminoBrillante.CodigosOrdenamiento.SinOrden) codOrdenar = Constantes.CaminoBrillante.CodigosOrdenamiento.PorCategoria;
            demostradores = GetOrdenarDemostradores(demostradores, codOrdenar);
            if (codFiltro != Constantes.CaminoBrillante.CodigoFiltros.SinFiltro) demostradores = GetFiltrarDemostradores(demostradores, codFiltro);
            objDemostradores.Total = demostradores.Count;
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
                FlagSeleccionado = demostradoresEnPedido.Any(h => h.CUV == e.CUV),
                EsCatalogo = e.EsCatalogo,
                Detalle = e.Detalle != null ? e.Detalle.Select(sd => new BEDemostradoresCaminoBrillante()
                {
                    CodigoEstrategia = sd.CodigoEstrategia,
                    CUV = sd.CUV,
                    DescripcionCortaCUV = sd.DescripcionCortaCUV,
                    DescripcionCUV = sd.DescripcionCUV,
                    DescripcionMarca = sd.DescripcionMarca,
                    EstrategiaID = sd.EstrategiaID,
                    FotoProductoMedium = sd.FotoProductoMedium,
                    FotoProductoSmall = sd.FotoProductoSmall,
                    MarcaID = sd.MarcaID,
                    CodigoMarca = sd.CodigoMarca,
                    PrecioCatalogo = sd.PrecioCatalogo,
                    PrecioValorizado = sd.PrecioValorizado,
                    TipoEstrategiaID = sd.TipoEstrategiaID,
                    EsCatalogo = sd.EsCatalogo,
                }).ToList() : null
            }).ToList();

            return objDemostradores;
        }

        private List<BEDemostradoresCaminoBrillante> GetDemostradores(BEUsuario entidad)
        {
            return GetDemostradoresCaminoBrillanteCache(entidad.PaisID, entidad.CampaniaID, entidad.NivelCaminoBrillante);
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

                /* Agrupación */
                var _demostradores = demostradores.Where(e => e.EsCompuesta != 1).ToList();
                var _ofertas = demostradores.Where(e => e.EsCompuesta == 1).GroupBy(p => p.CodigoOferta, p => p, (key, g) => new { key = key, grupo = g.ToList() });
                _ofertas.ForEach(e =>
                {
                    var padre = e.grupo.Where(d => d.EsDigitable).SingleOrDefault() ?? e.grupo.FirstOrDefault();
                    if (e.grupo.Count > 1)
                    {
                        padre.Detalle = e.grupo.Where(g => g != padre).ToList();
                        padre.PrecioCatalogo = e.grupo.Sum(i => i.PrecioCatalogo);
                        padre.PrecioValorizado = e.grupo.Sum(i => i.PrecioValorizado);
                    }
                    _demostradores.Add(padre);
                });
                demostradores = _demostradores;
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
            var kits = GetKits(entidad);
            var demostradores = GetDemostradores(entidad, 0, 0, string.Empty, string.Empty);
            if (kits == null && demostradores == null) return null;

            var carrusel = new BECarruselCaminoBrillante(); var iSize = size;

            /* Agregar el Kit Actual */
            if (kits != null)
            {
                var kitsTop = kits.Where(e => e.FlagHabilitado).OrderByDescending(e => e.CodigoNivel);
                if (kitsTop.Any())
                {
                    carrusel.Items.Add(ToBEOfertaCaminoBrillante(kitsTop.First()));
                    iSize -= carrusel.Items.Count;
                }
            }

            /* Agregar los Demostradores */
            if (demostradores != null && demostradores.LstDemostradores.Any())
            {
                /* Catalogos */
                var catalogos = demostradores.LstDemostradores.Where(e => e.EsCatalogo == 1).Take(2).Select(e => ToBEOfertaCaminoBrillante(e));
                iSize = size - (carrusel.Items.Count + catalogos.Count());
                /* Demostradores */
                carrusel.Items.AddRange(demostradores.LstDemostradores.Where(e => e.EsCatalogo != 1).Take(iSize).Select(e => ToBEOfertaCaminoBrillante(e)));
                carrusel.Items.AddRange(catalogos);
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
            var buildMessage = ValidarBusquedaCaminoBrillante_ValidacionNivel(entidad);

            if (producto.Nivel.HasValue && (entidad.NivelCaminoBrillante < producto.Nivel.Value))
            {
                return buildMessage(Enumeradores.ValidacionCaminoBrillante.CuvBloqueadoNivel, producto.Nivel.Value);
            }

            if (producto.Tipo == 1)
            {
                var result = ValidarBusquedaCaminoBrillante_Kits(entidad, producto, buildMessage);
                if (result != null) return result;
            }

            return BuildBEValidacionCaminoBrillante(Enumeradores.ValidacionCaminoBrillante.CuvPertenecePrograma, Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_IR_CAMINO_BRILLANTE);
        }

        private BEValidacionCaminoBrillante ValidarBusquedaCaminoBrillante_Kits(BEUsuario entidad, BEProductoCaminoBrillante producto, Func<Enumeradores.ValidacionCaminoBrillante, int?, BEValidacionCaminoBrillante> buildMessage)
        {
            var kits = GetKits(entidad);
            if (kits.Any(e => e.FlagHistorico || e.FlagSeleccionado))
                return BuildBEValidacionCaminoBrillante(Enumeradores.ValidacionCaminoBrillante.CuvYaAgregadoEnPeriodo, Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_USADO_CAMINO_BRILLANTE);
            if (producto.Nivel.HasValue)
            {
                var kit = kits.FirstOrDefault(e => e.CodigoNivel == producto.Nivel.Value.ToString());
                if (kit == null)
                    return BuildBEValidacionCaminoBrillante(Enumeradores.ValidacionCaminoBrillante.ProductoNoExiste);
                if (!kit.FlagHabilitado)
                    buildMessage(Enumeradores.ValidacionCaminoBrillante.CuvBloqueadoNivel, producto.Nivel.Value);
            }
            return null;
        }

        private Func<Enumeradores.ValidacionCaminoBrillante, int?, BEValidacionCaminoBrillante> ValidarBusquedaCaminoBrillante_ValidacionNivel(BEUsuario entidad)
        {
            Func<Enumeradores.ValidacionCaminoBrillante, int?, BEValidacionCaminoBrillante> buildMessage = (validacion, nivel) =>
            {
                if (nivel.HasValue)
                    return BuildBEValidacionCaminoBrillante(validacion, Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_BLOQUEADO_NIVEL_CAMINO_BRILLANTE, GetNiveles(entidad.PaisID).Where(n => n.CodigoNivel == nivel.ToString()).Select(e => e.DescripcionNivel).FirstOrDefault());
                return BuildBEValidacionCaminoBrillante(validacion, Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_BLOQUEADO_CAMINO_BRILLANTE);
            };
            return buildMessage;
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

        private List<BEProductoCaminoBrillante> GetCuvsCaminoBrillante(int paisId, int campaniaId)
        {
            return GetCuvsCaminoBrillanteCache(paisId, campaniaId);
        }

        private List<BEProductoCaminoBrillante> GetCuvsCaminoBrillanteCache(int paisId, int campaniaId)
        {
            return CacheManager<List<BEProductoCaminoBrillante>>.ValidateDataElement(paisId, ECacheItem.CaminoBrillanteCuvs, string.Format("{0}", campaniaId), () => GetCuvsCaminoBrillanteBD(paisId, campaniaId));
        }

        private List<BEProductoCaminoBrillante> GetCuvsCaminoBrillanteBD(int paisId, int campaniaId)
        {
            var productos = new DACaminoBrillante(paisId).GetCuvsCaminoBrillante(campaniaId).MapToCollection<BEProductoCaminoBrillante>(closeReaderFinishing: true) ?? new List<BEProductoCaminoBrillante>();

            try
            {
                var valProducto = ValProductoInList(productos);
                var kits = GetKitsCache(paisId, 0, campaniaId) ?? new List<BEKitCaminoBrillante>();
                kits.ForEach(e => valProducto(e, 1));
            }
            catch (Exception)
            {
                //
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

        /// <summary>
        /// Validar si el Origen de Pedido Web Pertenece a Camino Brillante
        /// Nota: Alinear con CaminoBrillanteProvider.IsOrigenPedidoCaminoBrillante
        /// </summary>
        //public bool IsOrigenPedidoCaminoBrillante(int origenPedidoWeb)
        //{
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

        private List<BEOrdenGrupo> GetOrden(int paisID, bool isApp)
        {
            var tablaLogicaDatos = _tablaLogicaDatosBusinessLogic.GetList(paisID, ConsTablaLogica.CaminoBrillante.CaminoBrillanteOrden) ?? new List<BETablaLogicaDatos>();
            if (tablaLogicaDatos.Count == 0) return null;

            return new List<BEOrdenGrupo>() { new BEOrdenGrupo() {
                NombreGrupo = tablaLogicaDatos.Where(e => e.Codigo == Constantes.CaminoBrillante.CodigoFiltros.SinFiltro).Select(e => e.Valor).FirstOrDefault(),
                Opciones = tablaLogicaDatos.Where(e => (e.Codigo != Constantes.CaminoBrillante.CodigoFiltros.SinFiltro && isApp) || !isApp ).Select(e => new BEOrden() { Codigo = e.Codigo, Descripcion = e.Descripcion }).ToList()
            }};
        }

        private List<BEFiltroGrupo> GetFiltro(int paisID, bool isApp)
        {
            var tablaLogicaDatos = _tablaLogicaDatosBusinessLogic.GetList(paisID, ConsTablaLogica.CaminoBrillante.CaminoBrillanteFiltro) ?? new List<BETablaLogicaDatos>();
            if (tablaLogicaDatos.Count == 0) return null;

            if (!isApp)
            {
                tablaLogicaDatos = tablaLogicaDatos.OrderBy(e => e.Descripcion).ToList();
                var titulo = tablaLogicaDatos.FirstOrDefault(e => e.Codigo == Constantes.CaminoBrillante.CodigoFiltros.SinFiltro);
                if (titulo != null)
                {
                    tablaLogicaDatos.Remove(titulo);
                    tablaLogicaDatos.Insert(0, titulo);
                }
            }

            return new List<BEFiltroGrupo>() { new BEFiltroGrupo() {
                Excluyente = true,
                NombreGrupo = tablaLogicaDatos.Where(e => e.Codigo == Constantes.CaminoBrillante.CodigoFiltros.SinFiltro).Select(e => e.Valor).FirstOrDefault(),
                Opciones = tablaLogicaDatos.Where(e => (e.Codigo != Constantes.CaminoBrillante.CodigoFiltros.SinFiltro &&isApp) || !isApp ).Select(e => new BEFiltro() { Codigo = e.Codigo, Descripcion = e.Descripcion }).ToList()
            }};
        }

        private BEOrdenFiltroConfiguracion GetFiltrosCache(int paisId, bool isApp)
        {
            return CacheManager<BEOrdenFiltroConfiguracion>.ValidateDataElement(paisId, ECacheItem.CaminoBrillanteFiltros, isApp ? "APP" : "WEB", () => GetFiltros(paisId, isApp));
        }

        #endregion

        #region Ficha Producto

        public BEOfertaCaminoBrillante GetOfertaCaminoBrillante(BEUsuario entidad, string CUV)
        {
            var demostradores = GetDemostradores(entidad) ?? new List<BEDemostradoresCaminoBrillante>();
            if (demostradores.Any(e => e.CUV == CUV))
            {
                return demostradores.Where(e => e.CUV == CUV).Select(e => ToBEOfertaCaminoBrillante(e)).First();
            }
            var kits = GetKits(entidad);
            if (kits.Any(e => e.CUV == CUV))
            {
                return kits.Where(e => e.CUV == CUV).Select(e => ToBEOfertaCaminoBrillante(e)).First();
            }
            return null;
        }

        private BEOfertaCaminoBrillante ToBEOfertaCaminoBrillante(BEDemostradoresCaminoBrillante demostrador, bool loadDetalle = true)
        {
            return new BEOfertaCaminoBrillante()
            {
                TipoOferta = Constantes.CaminoBrillante.TipoOferta.Demostrador,
                EstrategiaID = demostrador.EstrategiaID,
                CodigoEstrategia = demostrador.CodigoEstrategia,
                TipoEstrategiaID = demostrador.TipoEstrategiaID,
                CUV = demostrador.CUV,
                DescripcionCUV = demostrador.DescripcionCUV,
                DescripcionCortaCUV = demostrador.DescripcionCortaCUV,
                MarcaID = demostrador.MarcaID,
                CodigoMarca = demostrador.CodigoMarca,
                DescripcionMarca = demostrador.DescripcionMarca,
                PrecioValorizado = demostrador.PrecioValorizado,
                PrecioCatalogo = demostrador.PrecioCatalogo,
                FotoProductoSmall = demostrador.FotoProductoSmall,
                FotoProductoMedium = demostrador.FotoProductoMedium,
                FlagSeleccionado = demostrador.FlagSeleccionado,
                EsCatalogo = demostrador.EsCatalogo,
                Detalle = loadDetalle ? ToBEOfertaCaminoBrillanteList(demostrador) : null
            };
        }

        private List<BEOfertaCaminoBrillante> ToBEOfertaCaminoBrillanteList(BEDemostradoresCaminoBrillante demostrador)
        {
            var result = new List<BEOfertaCaminoBrillante>() { ToBEOfertaCaminoBrillante(demostrador, false) };
            if (demostrador.Detalle != null)
            {
                result.AddRange(demostrador.Detalle.Select(e => ToBEOfertaCaminoBrillante(e, false)));
            }
            return result;
        }

        private BEOfertaCaminoBrillante ToBEOfertaCaminoBrillante(BEKitCaminoBrillante kit, bool loadDetale = true)
        {
            return new BEOfertaCaminoBrillante()
            {
                TipoOferta = Constantes.CaminoBrillante.TipoOferta.Kit,
                EstrategiaID = kit.EstrategiaID,
                CodigoEstrategia = kit.CodigoEstrategia,
                TipoEstrategiaID = kit.TipoEstrategiaID,
                CUV = kit.CUV,
                DescripcionCUV = kit.DescripcionCUV,
                DescripcionCortaCUV = kit.DescripcionCortaCUV,
                MarcaID = kit.MarcaID,
                DescripcionMarca = kit.DescripcionMarca,
                CodigoNivel = kit.CodigoNivel,
                DescripcionNivel = kit.DescripcionNivel,
                PrecioValorizado = kit.PrecioValorizado,
                PrecioCatalogo = kit.PrecioCatalogo,
                Ganancia = kit.Ganancia,
                FotoProductoSmall = kit.FotoProductoSmall,
                FotoProductoMedium = kit.FotoProductoMedium,
                FlagSeleccionado = kit.FlagSeleccionado,
                FlagDigitable = kit.FlagDigitable,
                FlagHabilitado = kit.FlagHabilitado,
                FlagHistorico = kit.FlagHistorico,
                Detalle = (loadDetale && kit.Detalle != null) ? kit.Detalle.Select(e => ToBEOfertaCaminoBrillante(e, false)).ToList() : new List<BEOfertaCaminoBrillante>()
            };
        }

        #endregion

        #region Configuracion

        public List<BEConfiguracionCaminoBrillante> GetCaminoBrillanteConfiguracion(int paisID, string esApp)
        {
            //var oTablaLogica = GetCaminoBrillanteConfiguracionCache(paisID);
            var oTablaLogica = _tablaLogicaDatosBusinessLogic.GetListCache(paisID, ConsTablaLogica.CaminoBrillante.CaminoBrillanteConfigurar) ?? new List<BETablaLogicaDatos>();
            if (oTablaLogica == null) return null;
            if (esApp == "1") oTablaLogica = oTablaLogica.Where(a => a.Codigo.Contains(Constantes.CaminoBrillante.Configuracion.App)).ToList();
            else oTablaLogica = oTablaLogica.Where(a => a.Codigo.Contains(Constantes.CaminoBrillante.Configuracion.SomosBelcorp)).ToList();
            /* Cargar Configuración de Gran Brillante */
            //oTablaLogica.AddRange(_tablaLogicaDatosBusinessLogic.GetListCache(paisID, ConsTablaLogica.CaminoBrillante.CaminoBrillanteGranBrillante) ?? new List<BETablaLogicaDatos>());

            return oTablaLogica.Select(x => new BEConfiguracionCaminoBrillante()
            {
                Codigo = x.Codigo,
                Descripcion = x.Descripcion,
                Valor = x.Valor
            }).ToList();
        }

        /*
        private List<BETablaLogicaDatos> GetCaminoBrillanteConfiguracionCache(int paisID)
        {
            return _tablaLogicaDatosBusinessLogic.GetListCache(paisID, ConsTablaLogica.CaminoBrillante.CaminoBrillanteConfigurar) ?? new List<BETablaLogicaDatos>();
        }
        */

        #endregion

        #region Administrador Contenido
        public void InsBeneficioCaminoBrillante(int paisId, BEBeneficioCaminoBrillante entidad)
        {
            new DACaminoBrillante(paisId).InsBeneficioCaminoBrillante(entidad);
        }

        public void DelBeneficioCaminoBrillante(int paisId, string CodigoNivel, string CodigoBeneficio)
        {
            new DACaminoBrillante(paisId).DelBeneficioCaminoBrillante(CodigoNivel, CodigoBeneficio);
        } 
        
        public List<BEIncentivosMontoExigencia> GetIncentivosMontoExigencia(int paisId, BEIncentivosMontoExigencia entidad)
        {
            return new DACaminoBrillante(paisId).GetIncentivosMontoExigencia(entidad).MapToCollection<BEIncentivosMontoExigencia>(closeReaderFinishing: true);
        }
        public void InsIncentivosMontoExigencia(int paisId, BEIncentivosMontoExigencia entidad)
        {
            new DACaminoBrillante(paisId).InsIncentivosMontoExigencia(entidad);
        }       
        #endregion

    }
}
