using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

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
        /// Codigo del estado de pedido (1: INGRESADO, 2: FACTURADO)
        /// </summary>
        [DataMember]
        [Column("CodigoEstadoPedido")]
        public short CodigoEstadoPedido { get; set; }
        /// <summary>
        /// Descripcion del estado de pedido ('INGRESADO', 'FACTURADO')
        /// </summary>
        [DataMember]
        [Column("DescripcionEstadoPedido")]
        public string DescripcionEstadoPedido { get; set; }

        public BEMisPedidosCampania()
        {

        }
    }
}
