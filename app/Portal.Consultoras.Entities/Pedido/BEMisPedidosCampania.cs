using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities.Pedido
{
    /// <summary>
    /// Entidad mis pedidos campania
    /// </summary>
    [DataContract]
    public class BEMisPedidosCampania
    {
        /// <summary>
        /// Numero de la campania
        /// </summary>
        [DataMember]
        [Column("CampaniaID")]
        public int CampaniaID { get; set; }
        /// <summary>
        /// Codigo del estado de pedido (1: Ingresado, 2: Facturado)
        /// </summary>
        [DataMember]
        [Column("CodigoEstadoPedido")]
        public short CodigoEstadoPedido { get; set; }

        public BEMisPedidosCampania()
        {

        }
    }
}
