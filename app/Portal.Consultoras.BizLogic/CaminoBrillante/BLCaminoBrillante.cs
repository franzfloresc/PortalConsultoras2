using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data.CaminoBrillante;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.CaminoBrillante;
using Microsoft.Practices.EnterpriseLibrary.Common.Utility;
using static Portal.Consultoras.BizLogic.CaminoBrillante.CaminoBrillanteProvider;

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

        public List<BENivelCaminoBrillante> GetNivelesCache(int paisId) {
            return CacheManager<List<BENivelCaminoBrillante>>.ValidateDataElement(paisId, ECacheItem.CaminoBrillanteNiveles, () => GetNiveles(paisId));
        }

        public BEConsultoraCaminoBrillante GetConsultoraNivel(int paisId, BEUsuario entidad)
        {
            var datosTablaLogica = GetDatosTablaLogica(paisId);

            _providerCaminoBrillante = _providerCaminoBrillante ?? getCaminoBrillanteProvider(paisId, datosTablaLogica);
            if (_providerCaminoBrillante == null || datosTablaLogica == null || datosTablaLogica.Count == 0 || entidad.CampaniaID == 0) return null;
            
            var periodo = GetPeriodosCache(paisId).Where(e => e.CampanaInicial >= entidad.CampaniaID && entidad.CampaniaID <= e.CampanaFinal).FirstOrDefault();
            if (periodo == null) return null;

            var nivel = _providerCaminoBrillante.GetNivelConsultora(Util.GetPaisIsoHanna(paisId), entidad.CodigoConsultora, periodo.NroCampana).Result;

            return new BEConsultoraCaminoBrillante()
            {
                NivelConsultora = nivel.Select(e => new BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante()
                {
                    Campania = e.Campania,
                    FechaIngreso = e.FechaIngreso,
                    GananciaAnual = e.GananciaAnual,
                    GananciaCampania = e.GananciaCampania,
                    GananciaPeriodo = e.GananciaPeriodo,
                    KitSolicitado = e.KitSolicitado,
                    MontoPedido = e.MontoPedido,
                    NivelActual = e.NivelActual,
                    PeriodoCae = e.PeriodoCae
                }).OrderByDescending(e => e.Campania).ToList(),
                Niveles = GetNivelesCaminoBrillanteMantenedor(paisId),
                ResumenLogros = GetResumenLogros(GetConsultoraLogros(paisId, entidad, GetNivelesCaminoBrillanteMantenedor(paisId), nivel))
            };
        }

        public List<BELogroCaminoBrillante> GetConsultoraLogros(int paisId, BEUsuario entidad)
        {
            return null;
        }

        public List<BELogroCaminoBrillante> GetConsultoraLogros(int paisId, BEUsuario entidad, List<BENivelCaminoBrillante> nivelesCaminoBrillantes, 
            List<NivelConsultoraCaminoBrillante> nivelesConsultora)
        {
            return new List<BELogroCaminoBrillante> {
                    GetConsultoraLogrosCrecimiento(paisId, entidad, nivelesCaminoBrillantes, nivelesConsultora),
                    GetConsultoraLogrosCompromiso(paisId, entidad)
            };
        }

        private BELogroCaminoBrillante GetConsultoraLogrosCrecimiento(int paisId, BEUsuario entidad, List<BENivelCaminoBrillante> nivelesCaminoBrillantes, 
            List<NivelConsultoraCaminoBrillante> nivelesConsultora) {

            var escalasDescuento = _escalaDescuentoBusinessLogic.GetEscalaDescuento(paisId, entidad.CampaniaID, entidad.Region, entidad.Zona) ?? new List<BEEscalaDescuento>();

            var nivelConsultora = nivelesConsultora[0];
            short nivelActual = 0;
            short nivelCodigo = 0;
            Int16.TryParse(nivelConsultora.NivelActual, out nivelActual);

            var idx = 0;

            var medallaEscalas = escalasDescuento.Select(e => new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante() {
                Orden = idx++,
                Tipo = "CIR",
                Estado = (e.PorDescuento <= nivelConsultora.CambioEscala),
                Subtitulo = "¿Cómo lograrlo?",
                ModalTitulo = "Lorem Ipsum is simply",
                ModalDescripcion = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                Valor = e.PorDescuento+"%",
            }).ToList();

            idx = 0;
            var medallaNiveles = nivelesCaminoBrillantes.Select(e => new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante()
            {
                Orden = idx++,
                Tipo = "NIV",
                Estado = (Int16.TryParse(e.CodigoNivel, out nivelCodigo) ? nivelCodigo <= nivelActual : false),
                Titulo = "¡Ya lo tienes!",
                ModalTitulo = "Lorem Ipsum is simply",
                ModalDescripcion = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                Valor = e.CodigoNivel,
            }).ToList();

            var incrementosPedido = new List<int> { 5, 10, 15, 20, 30, 40, 100 };
            idx = 0;

            var medallaIncrementoPedido = incrementosPedido.Select(e => new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante() {
                Orden = idx++,
                Tipo = "CIR",
                Estado = (nivelConsultora.PorcentajeIncremento <= e),
                Subtitulo = "¿Cómo lograrlo?",
                ModalTitulo = "Lorem Ipsum is simply",
                ModalDescripcion = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                Valor = e+"%",
            }).ToList();

            var medallaConstancia = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>();

            var periodos = GetPeriodos(paisId);

            Action<string, int> delegado = (periodo, constancia) => {
                if (!string.IsNullOrEmpty(periodo))
                {
                    var periodoCaminoBrillante = periodos.Where(e => "" + e.Periodo == periodo).FirstOrDefault();
                    if (periodoCaminoBrillante != null) {
                        var valor = periodoCaminoBrillante.Periodo +"-" + periodoCaminoBrillante.NroCampana + "-" + constancia;
                        if (!medallaConstancia.Any(e => e.Valor == valor)) {
                            var inicio = "" + periodoCaminoBrillante.CampanaInicial;
                            var fin = "" + periodoCaminoBrillante.CampanaFinal;

                            inicio = (inicio.Length >= 6 ? inicio.Substring(inicio.Length - 2, 2) : inicio);
                            fin = (fin.Length >= 6 ? fin.Substring(fin.Length - 2, 2) : fin);

                            medallaConstancia.Add(new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante()
                            {
                                Tipo = "PIE",
                                Estado = (constancia > 0),
                                Titulo = "De C" + inicio + " a C" + fin,
                                Subtitulo = "¿Cómo lograrlo?",
                                ModalTitulo = "Lorem Ipsum is simply",
                                ModalDescripcion = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                                Valor = valor,
                            });
                        }
                    }
                }
            };

            nivelesConsultora.ForEach(e =>
            {
                delegado(e.Periodo1, e.Constancia1);
                delegado(e.Periodo2, e.Constancia2);
                delegado(e.Periodo3, e.Constancia3);
                delegado(e.Periodo4, e.Constancia4);
                delegado(e.Periodo5, e.Constancia5);
            });

            idx = 0;
            medallaConstancia.OrderByDescending(e => e.Valor).ForEach(e =>
            {
                e.Orden = idx++;
            });

            return new BELogroCaminoBrillante()
            {
                Id = "CRECIMIENTO",
                Titulo = "Crecimiento",
                Descripcion = "Estos son los logros que obtienes por ser constante con los pedidos y las ventas.",
                Indicadores = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante>{
                            new BELogroCaminoBrillante.BEIndicadorCaminoBrillante() {
                                Titulo = "Cambio de escala",
                                Medallas = medallaEscalas
                            },
                            new BELogroCaminoBrillante.BEIndicadorCaminoBrillante() {
                                Titulo = "Cambio de nivel",
                                Medallas = medallaNiveles                                
                            },
                            new BELogroCaminoBrillante.BEIndicadorCaminoBrillante() {
                                Titulo = "Constancia",
                                Medallas = medallaConstancia
                            },
                            new BELogroCaminoBrillante.BEIndicadorCaminoBrillante() {
                                Titulo = "Incremento en monto de pedidos",
                                Medallas = medallaIncrementoPedido
                            }
                        }
            };
        }

        private BELogroCaminoBrillante GetConsultoraLogrosCompromiso(int paisId, BEUsuario entidad)
        {
            //Saber si pasaron los 6 pedidos de nuevas
            BELogroCaminoBrillante.BEIndicadorCaminoBrillante medallasProgramaNuevas = null;
            if (entidad.ConsecutivoNueva < 10 && entidad.EsConsultoraNueva) {
                var pedidosProgramaNuevas = new List<int> { 1, 2, 3, 4, 5, 6 };
                //Tabla ODS
                medallasProgramaNuevas = new BELogroCaminoBrillante.BEIndicadorCaminoBrillante()
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

            var anios = 10;

            var medallasAnios = new List<int> { 1, 2, 3, 4, 5, 10, 15, 20, 30, 40 };

            var orden = 0;

            var tiempoJuntos = new BELogroCaminoBrillante.BEIndicadorCaminoBrillante()
            {
                Titulo = "Tiempo juntos",
                Medallas = medallasAnios.Select(e => new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante() {
                    Orden = orden++,
                    Tipo = "TIM",
                    Estado = e <= anios,
                    Titulo = e+(1 == 1 ? "año" : " años"),
                    Subtitulo = "¿Cómo lograrlo?",
                    Valor = ""+ e,
                    ModalTitulo = "Lorem Ipsum is simply",
                    ModalDescripcion = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                }).ToList()
            };

            return new BELogroCaminoBrillante()
            {
                Id = "COMPROMISO",
                Titulo = "Crompromiso",
                Descripcion = "Estos son los logros que obtienes por ser constante con los pedidos y las ventas.",
                Indicadores = (medallasProgramaNuevas != null ? 
                                new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante> { medallasProgramaNuevas, tiempoJuntos } 
                                :new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante> { tiempoJuntos })
            };
        }

        private BELogroCaminoBrillante GetResumenLogros(List<BELogroCaminoBrillante> logros)
        {
            //if (logros != null) return logros[1];

            return new BELogroCaminoBrillante()
            {
                Id = "MIS_LOGROS",
                Titulo = "Mis logros",
                Descripcion = "Estos son los logros que obtienes por ser constante con los pedidos y las ventas.",
                Indicadores = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante>{
                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante() {
                        Titulo = "Creciminto",
                        Descripcion = "Tu progreso tiene recompensas",
                        Medallas = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>{
                            new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                Orden = 0,
                                Tipo = "CIR",
                                Estado = true,
                                Titulo = "Escala",
                                Valor = "25%",
                            },
                            new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                Orden = 0,
                                Tipo = "PIE",
                                Estado = true,
                                Titulo = "Constancia",
                                Valor = "1-6",
                            },
                            new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                Orden = 0,
                                Tipo = "CIR",
                                Estado = true,
                                Titulo = "Incremento",
                                Valor = "5",
                            }
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

        public void GetConsultoraOfertas(int paisId, BEUsuario entidad)
        {
            throw new NotImplementedException();
        }

        public void GetConsultoraKits(int paisId, BEUsuario entidad)
        {
            throw new NotImplementedException();
        }
        
        private List<BEPeriodoCaminoBrillante> GetPeriodos(int paisId) {
            _providerCaminoBrillante = _providerCaminoBrillante ?? getCaminoBrillanteProvider(paisId);
            if (_providerCaminoBrillante == null) return null;

            return (_providerCaminoBrillante.GetPeriodo(Util.GetPaisIsoHanna(paisId)).Result ?? new List<PeriodoCaminoBrillante>())
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

        private List<BENivelCaminoBrillante> GetNivelesCaminoBrillanteMantenedor(int paisId)
        {
            var lstBeneficios = GetBeneficiosCaminoBrillante(paisId) ?? new List<BEBeneficioCaminoBrillante>();
            var lstNiveles = _providerCaminoBrillante.GetNivel(Util.GetPaisIsoHanna(paisId)).Result;
            var pattern = "http://somosbelcorpqa.s3.amazonaws.com/Iconos/CAMINOBRILLANTE/NIVELES/{DIMEN}/NIVEL_{KEY}_{STATE}.png";

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

        private List<BETablaLogicaDatos> GetDatosTablaLogica(int paisId)
        {
            return _tablaLogicaDatosBusinessLogic.GetListCache(paisId, Constantes.TablaLogica.CaminoBrillanteInfoComercial);
        }

        private CaminoBrillanteProvider getCaminoBrillanteProvider(int paisId)
        {
            return getCaminoBrillanteProvider(paisId, GetDatosTablaLogica(paisId));
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
