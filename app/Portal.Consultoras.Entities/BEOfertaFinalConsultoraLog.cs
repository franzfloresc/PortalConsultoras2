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

        [DataMember]
        public bool? MuestraPopup { get; set; }

        [DataMember]
        public decimal? MontoInicial { get; set; }

        public BEOfertaFinalConsultoraLog()
        {

        }

        public BEOfertaFinalConsultoraLog(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "OfertaFinalConsultoraID"))
                OfertaFinalConsultoraID = Convert.ToInt64(row["OfertaFinalConsultoraID"]);

            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);

            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);

            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);

            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);

            if (DataRecord.HasColumn(row, "Fecha"))
                Fecha = Convert.ToDateTime(row["Fecha"]);

            if (DataRecord.HasColumn(row, "TipoOfertaFinal"))
                TipoOfertaFinal = Convert.ToString(row["TipoOfertaFinal"]);

            if (DataRecord.HasColumn(row, "GAP"))
                GAP = Convert.ToDecimal(row["GAP"]);

            if (DataRecord.HasColumn(row, "TipoRegistro"))
                TipoRegistro = Convert.ToInt32(row["TipoRegistro"]);

            if (DataRecord.HasColumn(row, "DesTipoRegistro"))
                DesTipoRegistro = Convert.ToString(row["DesTipoRegistro"]);
        }
    }
}
