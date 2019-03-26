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
        private CaminoBrillanteProvider _providerCaminoBrillante;

        public BLCaminoBrillante() : this(new BLTablaLogicaDatos())
        {

        }

        public BLCaminoBrillante(ITablaLogicaDatosBusinessLogic tablaLogicaDatosBusinessLogic)
        {
            _tablaLogicaDatosBusinessLogic = tablaLogicaDatosBusinessLogic;
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
            if (_providerCaminoBrillante == null || datosTablaLogica == null || datosTablaLogica.Count == 0) return null;

            //Llamar a comercial para obtener los parametros de Numero de Campana
            var numeroCampania = "6";

            //Hacer LLamadas Async

            //Llamar al servicio para obtener la Informacion de la consultora
            var nivel = _providerCaminoBrillante.GetNivelConsultora(Util.GetPaisIsoHanna(paisId), entidad.CodigoConsultora, numeroCampania).Result;

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
                ResumenLogros = GetResumenLogros(paisId, entidad, nivel)
            };
        }

        public List<BELogroCaminoBrillante> GetConsultoraLogros(int paisId, BEUsuario entidad)
        {
            return new List<BELogroCaminoBrillante> {
                    new BELogroCaminoBrillante() {
                        Id = "CRECIMIENTO",
                        Titulo = "Crecimiento",
                        Descripcion = "Estos son los logros que obtienes por ser constante con los pedidos y las ventas.",
                        Indicadores = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante>{
                            new BELogroCaminoBrillante.BEIndicadorCaminoBrillante() {
                                Titulo = "Cambio de escala",                                
                                Medallas = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>{
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "CIR",
                                        Estado = true,
                                        Subtitulo = "¿Cómo lograrlo",
                                        Valor = "25%",
                                    },
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "CIR",
                                        Estado = true,
                                        Subtitulo = "¿Cómo lograrlo",
                                        Valor = "28%",
                                    },
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "CIR",
                                        Estado = true,
                                        Subtitulo = "¿Cómo lograrlo",
                                        Valor = "30%",
                                    },
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "CIR",
                                        Estado = true,
                                        Subtitulo = "¿Cómo lograrlo",
                                        Valor = "35%",
                                    }
                                }
                            },
                            new BELogroCaminoBrillante.BEIndicadorCaminoBrillante() {
                                Titulo = "Cambio de nivel",
                                Medallas = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>{
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "NIV",
                                        Estado = true,
                                        Titulo = "¡Ya lo tienes!",
                                        Valor = "1",
                                    },
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "NIV",
                                        Estado = false,
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "2",
                                    },
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "NIV",
                                        Estado = false,
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "3",
                                    },
                                     new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "NIV",
                                        Estado = false,
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "4",
                                    },
                                      new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "NIV",
                                        Estado = false,
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "5",
                                    },
                                       new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "NIV",
                                        Estado = false,
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "6",
                                    }
                                }
                            },
                            new BELogroCaminoBrillante.BEIndicadorCaminoBrillante() {
                                Titulo = "Constancia",
                                Medallas = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>{
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "PIE",
                                        Estado = true,
                                        Titulo = "De C15 a C02",
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "1-6",
                                    },
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "PIE",
                                        Estado = false,
                                        Titulo = "De C03 a C08",
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "0-6",
                                    },
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "PIE",
                                        Estado = false,
                                        Titulo = "De C09 a C14",
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "0-6",
                                    }
                                }
                            },
                            new BELogroCaminoBrillante.BEIndicadorCaminoBrillante() {
                                Titulo = "Incremento en monto de pedidos",
                                Medallas = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>{
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "CIR",
                                        Estado = true,
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "5%",
                                    },
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "CIR",
                                        Estado = false,
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "10%",
                                    },
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "CIR",
                                        Estado = false,
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "15%",
                                    },
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "CIR",
                                        Estado = false,
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "20%",
                                    },
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "CIR",
                                        Estado = false,
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "30%",
                                    },
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "CIR",
                                        Estado = false,
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "40%",
                                    },
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "CIR",
                                        Estado = false,
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "100%",
                                    }
                                }
                            }
                        }
                    },
                    new BELogroCaminoBrillante() {
                        Id = "COMPROMISO",
                        Titulo = "Crompromiso",
                        Descripcion = "Estos son los logros que obtienes por ser constante con los pedidos y las ventas.",
                        Indicadores = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante>{
                            new BELogroCaminoBrillante.BEIndicadorCaminoBrillante() {
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
                            },
                            new BELogroCaminoBrillante.BEIndicadorCaminoBrillante() {
                                Titulo = "Tiempo juntos",
                                Medallas = new List<BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante>{
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "TIM",
                                        Estado = true,
                                        Titulo = "1 año",
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "1",
                                    },
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "TIM",
                                        Estado = false,
                                        Titulo = "2 años",
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "2",
                                    },
                                    new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "TIM",
                                        Estado = false,
                                        Titulo = "3 años",
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "3",
                                    },
                                     new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "TIM",
                                        Estado = false,
                                        Titulo = "4 años",
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "4",
                                    },
                                      new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "TIM",
                                        Estado = false,
                                        Titulo = "5 años",
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "5",
                                    },
                                       new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "TIM",
                                        Estado = false,
                                        Titulo = "10 años",
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "10",
                                    },
                                       new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "TIM",
                                        Estado = false,
                                        Titulo = "15 años",
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "15",
                                    },
                                       new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "TIM",
                                        Estado = false,
                                        Titulo = "20 años",
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "20",
                                    },
                                       new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "TIM",
                                        Estado = false,
                                        Titulo = "30 años",
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "30",
                                    },
                                       new BELogroCaminoBrillante.BEIndicadorCaminoBrillante.BEMedallaCaminoBrillante(){
                                        Orden = 0,
                                        Tipo = "TIM",
                                        Estado = false,
                                        Titulo = "40 años",
                                        Subtitulo = "¿Cómo lograrlo?",
                                        Valor = "40",
                                    }
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

        private BELogroCaminoBrillante GetResumenLogros(int paisId, BEUsuario entidad, List<NivelConsultoraCaminoBrillante> niveles)
        {
            return new BELogroCaminoBrillante() {
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
