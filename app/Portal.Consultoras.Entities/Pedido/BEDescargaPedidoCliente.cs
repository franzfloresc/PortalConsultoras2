using System;
using System.ComponentModel.DataAnnotations.Schema;
    
namespace Portal.Consultoras.Entities.Pedido
{
    public class BEDescargaPedidoCliente
    {
        [Column("PaisISO")]
        public string PaisISO { get; set; }
        [Column("CampaniaID")]
        public int CampaniaID { get; set; }
        [Column("CodigoConsultora")]
        public string CodigoConsultora { get; set; }
        [Column("FechaFacturacion")]
        public DateTime FechaFacturacion { get; set; }
        [Column("CUV")]
        public string CUV { get; set; }
        [Column("Cantidad")]
        public int Cantidad { get; set; }
        [Column("CodigoCliente")]
        public long CodigoCliente { get; set; }
    }
}
