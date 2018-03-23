using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Pedido
{
    /// <summary>
    /// Entidad mis pedidos facturados detalle
    /// </summary>
    public class BEMisPedidosFacturadosDetalle
    {
        /// <summary>
        /// Codigo del cliente
        /// </summary>
        [DataMember]
        [Column("ClienteID")]
        public int ClienteID { get; set; }
        /// <summary>
        /// Codigo de CUV
        /// </summary>
        [DataMember]
        [Column("CUV")]
        public string CUV { get; set; }
        /// <summary>
        /// Descripcion del producto
        /// </summary>
        [DataMember]
        [Column("DescripcionProducto")]
        public string DescripcionProducto { get; set; }
        /// <summary>
        /// Cantidad del CUV
        /// </summary>
        [DataMember]
        [Column("Cantidad")]
        public int Cantidad { get; set; }
        /// <summary>
        /// Precio por unidad del CUV
        /// </summary>
        [DataMember]
        [Column("PrecioUnidad")]
        public decimal PrecioUnidad { get; set; }
        /// <summary>
        /// Importe total del CUV (Cantidad * PrecioUnidad)
        /// </summary>
        [DataMember]
        [Column("ImporteTotal")]
        public decimal ImporteTotal { get; set; }

        public BEMisPedidosFacturadosDetalle()
        {

        }
    }
}
