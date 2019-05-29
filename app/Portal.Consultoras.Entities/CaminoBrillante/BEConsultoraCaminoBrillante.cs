using System.Collections.Generic;

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
        }

    }
}
