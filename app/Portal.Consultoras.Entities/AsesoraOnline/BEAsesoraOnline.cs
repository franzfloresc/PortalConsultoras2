using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
        [DataMember]
        public int Respuesta5 { get; set; }
        [DataMember]
        public int ConfirmacionInscripcion { get; set; }

        public BEAsesoraOnline(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);

            if (DataRecord.HasColumn(row, "Respuesta1"))
                Respuesta1 = Convert.ToInt32(row["Respuesta1"]);

            if (DataRecord.HasColumn(row, "Respuesta2"))
                Respuesta2 = Convert.ToInt32(row["Respuesta2"]);

            if (DataRecord.HasColumn(row, "Respuesta3"))
                Respuesta3 = Convert.ToInt32(row["Respuesta3"]);

            if (DataRecord.HasColumn(row, "Respuesta4"))
                Respuesta4 = Convert.ToInt32(row["Respuesta4"]);

        }
    }
}
