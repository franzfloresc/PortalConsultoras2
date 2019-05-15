using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    public class BEKitsHistoricoConsultora
    {        
        public string CodigoKit { get; set; }
        public string CampaniaAtencion { get; set; }
        [Column("CUV")]
        public string CUV { get; set; }
        [Column("CampaniaID")]
        public int CampaniaID { get; set; }
        [Column("PedidoID")]
        public int PedidoID { get; set; }
        [Column("PedidoDetalleID")]
        public int PedidoDetalleID { get; set; }
        public bool FlagHistorico { get; set; }
    }
}
