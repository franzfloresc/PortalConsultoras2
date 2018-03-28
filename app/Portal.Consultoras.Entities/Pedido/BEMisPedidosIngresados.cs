using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Pedido
{
    /// <summary>
    /// Entidad mis pedidos ingresados
    /// </summary>
    [DataContract]
    public class BEMisPedidosIngresados
    {
        /// <summary>
        /// Codigo de la campania
        /// </summary>
        [DataMember]
        [Column("CampaniaID")]
        public int CampaniaID { get; set; }
        /// <summary>
        /// Codigo del cliente
        /// </summary>
        [DataMember]
        [Column("ClienteID")]
        public int ClienteID { get; set; }
        /// <summary>
        /// Nombre del cliente
        /// </summary>
        [DataMember]
        [Column("NombreCliente")]
        public string NombreCliente { get; set; }
        /// <summary>
        /// Cantidad del pedido
        /// </summary>
        [DataMember]
        [Column("CantidadPedido")]
        public int CantidadPedido { get; set; }
        /// <summary>
        /// Importe total del pedido
        /// </summary>
        [DataMember]
        [Column("ImportePedido")]
        public decimal ImportePedido { get; set; }
        /// <summary>
        /// detalle del pedido ingresado
        /// </summary>
        [DataMember]
        public List<BEMisPedidosIngresadosDetalle> Detalle { get; set; }

        public BEMisPedidosIngresados()
        {

        }
    }
}
