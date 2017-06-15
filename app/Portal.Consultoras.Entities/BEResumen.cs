using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    /// <summary>
    /// Resumen de activos de la consutora
    /// </summary>
    [DataContract]
    public class BEResumen
    {
        /// <summary>
        /// Incentivos y/o premios
        /// </summary>
        [DataMember]
        public IncentivosModel Incentivos { get; set; }

        /// <summary>
        /// Deudas de clientes
        /// </summary>
        [DataMember]
        public DeudasModel Deudas { get; set; }

        /// <summary>
        /// Pedidos
        /// </summary>
        [DataMember]
        public PedidosModel Pedidos { get; set; }

        /// <summary>
        /// Total Clientes
        /// </summary>
        [DataMember]
        public ClientesModel Clientes { get; set; }

        /// <summary>
        /// Clientes model
        /// </summary>
        public class ClientesModel
        {
            /// <summary>
            /// Cantidad total de clientes
            /// </summary>
            [DataMember]
            public int Total { get; set; }

            /// <summary>
            /// Mensaje de validacion en caso clientes = 0,
            /// </summary>
            [DataMember]
            public string Mensaje { get; set; }
        }

        /// <summary>
        /// Pedidos
        /// </summary>
        [DataContract]
        public class PedidosModel
        {
            /// <summary>
            /// Cantidad de clientes que tienen un pedido, 
            /// si el monto es 0, se debe mostrar el mensaje
            /// </summary>
            [DataMember]
            public int ClientesCampana { get; set; }

            /// <summary>
            /// Mensaje de validacion
            /// </summary>
            [DataMember]
            public string Mensaje { get; set; }
        }

        /// <summary>
        /// Deudas totales
        /// </summary>
        [DataContract]
        public class DeudasModel
        {
            /// <summary>
            /// Monto sumatorio de todas las deudas de clientes
            /// </summary>
            [DataMember]
            public decimal MontoCobro { get; set; }

            /// <summary>
            /// Cantidad de deudores a la fecha
            /// </summary>
            [DataMember]
            public int Deudores { get; set; }

            /// <summary>
            /// Mensaje de validacion, en caso deudores=0
            /// </summary>
            [DataMember]
            public string Mensaje { get; set; }
        }

        /// <summary>
        /// Incentivos
        /// </summary>
        [DataContract]
        public class IncentivosModel
        {
            /// <summary>
            /// Puntos faltantes para el proximo premio, 
            /// En caso puntosFaltantes = 0, entonces premio="Te ganaste el perfume y la olla arrocera."
            /// </summary>
            [DataMember]
            public int PuntosFaltantes { get; set; }

            /// <summary>
            /// Nombre del premio
            /// </summary>
            [DataMember]
            public string PremioNombre { get; set; }

            /// <summary>
            /// Indica si hay o no incetivos configurados para la consultora en la campaña actual, 
            /// En caso false, se debe mostrar el mensaje
            /// </summary>
            [DataMember]
            public bool HayIncentivos { get; set; }

            /// <summary>
            /// Mensaje en caso de que no haya Incentivos
            /// </summary>
            [DataMember]
            public string Mensaje { get; set; }
        }
    }
}
