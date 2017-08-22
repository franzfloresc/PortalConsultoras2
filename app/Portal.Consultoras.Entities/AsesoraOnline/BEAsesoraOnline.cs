using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.AsesoraOnline
{
    [DataContract]
    public class BEAsesoraOnline
    {
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string FechaCreacion { get; set; }
        [DataMember]
        public string Origen { get; set; }
        [DataMember]
        public int Respuesta1 { get; set; }
        [DataMember]
        public int Respuesta2 { get; set; }
        [DataMember]
        public int Respuesta3 { get; set; }
        [DataMember]
        public int Respuesta4 { get; set; }

        public BEAsesoraOnline(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoConsultora") && row["CodigoConsultora"] != DBNull.Value)
                CodigoConsultora = row["CodigoConsultora"] == null ? String.Empty : Convert.ToString(row["CodigoConsultora"]);

            if (DataRecord.HasColumn(row, "Respuesta1") && row["Respuesta1"] != DBNull.Value)
                Respuesta1 = row["Respuesta1"] == null ? 0 : Convert.ToInt32(row["Respuesta1"]);

            if (DataRecord.HasColumn(row, "Respuesta2") && row["Respuesta2"] != DBNull.Value)
                Respuesta2 = row["Respuesta2"] == null ? 0 : Convert.ToInt32(row["Respuesta2"]);

            if (DataRecord.HasColumn(row, "Respuesta3") && row["Respuesta3"] != DBNull.Value)
                Respuesta3 = row["Respuesta3"] == null ? 0 : Convert.ToInt32(row["Respuesta3"]);

            if (DataRecord.HasColumn(row, "Respuesta4") && row["Respuesta4"] != DBNull.Value)
                Respuesta4 = row["Respuesta4"] == null ? 0 : Convert.ToInt32(row["Respuesta4"]);

        }
    }
}
