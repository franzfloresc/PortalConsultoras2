using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEOfertaFinalConsultoraLog
    {
        [DataMember]
        public long OfertaFinalConsultoraID { get; set; }

        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public string CodigoConsultora { get; set; }

        [DataMember]
        public string CUV { get; set; }

        [DataMember]
        public int Cantidad { get; set; }

        [DataMember]
        public DateTime Fecha { get; set; }

        [DataMember]
        public string TipoOfertaFinal { get; set; }

        [DataMember]
        public decimal GAP { get; set; }

        [DataMember]
        public int TipoRegistro { get; set; }

        [DataMember]
        public string DesTipoRegistro { get; set; }

        public BEOfertaFinalConsultoraLog()
        {

        }

        public BEOfertaFinalConsultoraLog(IDataRecord row)
        {
            OfertaFinalConsultoraID = row.ToInt64("OfertaFinalConsultoraID");
            CampaniaID = row.ToInt32("CampaniaID");
            CodigoConsultora = row.ToString("CodigoConsultora");
            CUV = row.ToString("CUV");
            Cantidad = row.ToInt32("Cantidad");
            Fecha = row.ToDateTime("Fecha");
            TipoOfertaFinal = row.ToString("TipoOfertaFinal");
            GAP = row.ToDecimal("GAP");
            TipoRegistro = row.ToInt32("TipoRegistro");
            DesTipoRegistro = row.ToString("DesTipoRegistro");
        }
    }
}
