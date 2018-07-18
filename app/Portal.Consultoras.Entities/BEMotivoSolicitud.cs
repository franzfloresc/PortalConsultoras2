using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEMotivoSolicitud
    {
        [DataMember]
        public int MotivoSolicitudID { get; set; }
        [DataMember]
        public string Motivo { get; set; }
        [DataMember]
        public int Tipo { get; set; }
        [DataMember]
        public short Estado { get; set; }

        public BEMotivoSolicitud()
        {
        }

        public BEMotivoSolicitud(IDataRecord row)
        {
            MotivoSolicitudID = Convert.ToInt32(row["MotivoSolicitudID"]);
            Motivo = Convert.ToString(row["Motivo"]);

            if (DataRecord.HasColumn(row, "Tipo"))
                Tipo = Convert.ToInt32(row["Tipo"]);
            if (DataRecord.HasColumn(row, "Estado"))
                Estado = Convert.ToInt16(row["Estado"]);
        }
    }
}
