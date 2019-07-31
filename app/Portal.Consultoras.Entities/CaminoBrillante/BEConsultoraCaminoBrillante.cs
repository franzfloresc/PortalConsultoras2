using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    public class BEConsultoraCaminoBrillante
    {
        /// <summary>
        /// Obtiene la información del nivel de la Consultora
        /// </summary>
        public List<BENivelConsultoraCaminoBrillante> NivelConsultora { get; set; }
        /// <summary>
        /// Obtiene el resumen de los niveles
        /// </summary>
        public List<BENivelCaminoBrillante> Niveles { get; set; }
        /// <summary>
        /// Obtiene el resumen de los logros
        /// </summary>
        public BELogroCaminoBrillante ResumenLogros { get; set; }
        /// <summary>
        /// Obtiene el Logros de Camino Brillante
        /// </summary>
        public List<BELogroCaminoBrillante> Logros { get; set; }
        /// <summary>
        /// Consultora Configuración de Camino Brillante
        /// </summary>
        public List<BEConfiguracionCaminoBrillante> Configuracion { get; set; }

        public class BENivelConsultoraCaminoBrillante
        {

            /// <summary>
            /// Obtiene el periodo al que pertence la consultora de acuerdo a su campaña
            /// </summary>
            public string PeriodoCae { get; set; }
            /// <summary>
            /// Obtiene la campaña de la consultora
            /// </summary>
            public string Campania { get; set; }
            /// <summary>
            /// Obtiene el nivel de la consultora en su camino brillante 
            /// </summary>
            public string Nivel { get; set; }
            /// <summary>
            /// Monto total que facturo la consultora
            /// </summary>
            public string MontoPedido { get; set; }
            /// <summary>
            /// Obtiene la fecha de Ingreso desde que inicio como consultora.
            /// </summary>
            public string FechaIngreso { get; set; }
            /// <summary>
            /// 
            /// </summary>
            public string KitSolicitado { get; set; }
            /// <summary>
            /// Ganancia total de cada campaña
            /// </summary>
            public decimal GananciaCampania { get; set; }
            /// <summary>
            /// Suma de todas las ganacias de todas las campañias que pertenecen a un periodo
            /// </summary>
            public decimal GananciaPeriodo { get; set; }
            /// <summary>
            /// Ganancia total del año 
            /// </summary>
            public decimal GananciaAnual { get; set; }
            /// <summary>
            /// Flag Nivel Actual 
            /// </summary>
            public bool EsActual { get; set; }
            /// <summary>
            /// Puntaje Acumulado 
            /// </summary>
            public int? PuntajeAcumulado { get; set; }
            /// <summary>
            /// Flag de Auto Seleccion de Mis Ganancias
            /// </summary>
            public bool? FlagSeleccionMisGanancias { get; set; }
        }

    }

    [DataContract]
    public class BEConsultoraCaminoBrillanteMeta {

        [DataMember]
        [Column("ConsultoraID")]
        public long ConsultoraId { get; set; }
        [DataMember]
        [Column("PeriodoCB")]
        public int? PeriodoCB { get; set; }
        [DataMember]
        [Column("Campania")]
        public int? Campania { get; set; }
        [DataMember]
        [Column("NivelCB")]
        public int? NivelCB { get; set; }
        [DataMember]
        [Column("CambioNivelCB")]
        public int? CambioNivelCB { get; set; }
        [DataMember]
        [Column("FlagOnboardingAnim")]
        public bool? FlagOnboardingAnim { get; set; }
        [DataMember]
        [Column("FlagOnboardingAnimRepeat")]
        public bool? FlagOnboardingAnimRepeat { get; set; }
        [DataMember]
        [Column("FlagGananciaAnim")]
        public bool? FlagGananciaAnim { get; set; }
        [DataMember]
        [Column("FlagCambioNivelAnim")]
        public bool? FlagCambioNivelAnim { get; set; }

    }
}
