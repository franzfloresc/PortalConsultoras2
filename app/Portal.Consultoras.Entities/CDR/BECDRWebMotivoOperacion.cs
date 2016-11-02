using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CDR
{
    public class BECDRWebMotivoOperacion
    {
        [DataMember]
        public int OperacionCDRID { get; set; }
        [DataMember]
        public int MotivoCDRID { get; set; }
        [DataMember]
        public int Prioridad { get; set; }
        [DataMember]
        public int Estado { get; set; }
        [DataMember]
        public BECDRMotivo CDRMotivo { get; set; }
        [DataMember]
        public BECDROperacion CDROperacion { get; set; }

        public BECDRWebMotivoOperacion()
        { }

        public BECDRWebMotivoOperacion(IDataRecord row)
        {
            OperacionCDRID = DataRecord.GetColumn(DbType.Int32, row, "OperacionCDRID");
            if (DataRecord.HasColumn(row, "MotivoCDRID")) MotivoCDRID = Convert.ToInt32(row["MotivoCDRID"]);
            if (DataRecord.HasColumn(row, "Prioridad")) Prioridad = Convert.ToInt32(row["Prioridad"]);
            if (DataRecord.HasColumn(row, "Estado")) Estado = Convert.ToInt32(row["Estado"]);
        }
    }
}
