using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CDR
{
    public class BECDRWebMotivoOperacion
    {
        [DataMember]
        public string CodigoOperacion { get; set; }
        [DataMember]
        public string CodigoReclamo { get; set; }
        [DataMember]
        public int Prioridad { get; set; }
        [DataMember]
        public int Estado { get; set; }
        [DataMember]
        public BECDRMotivoReclamo CDRMotivoReclamo { get; set; }
        [DataMember]
        public BECDRTipoOperacion CDRTipoOperacion { get; set; }

        public BECDRWebMotivoOperacion()
        { }

        public BECDRWebMotivoOperacion(IDataRecord row)
        {
            if (row.HasColumn("CodigoOperacion")) CodigoOperacion = Convert.ToString(row["CodigoOperacion"]);
            if (row.HasColumn("CodigoReclamo")) CodigoReclamo = Convert.ToString(row["CodigoReclamo"]);
            if (row.HasColumn("Prioridad")) Prioridad = Convert.ToInt32(row["Prioridad"]);
            if (row.HasColumn("Estado")) Estado = Convert.ToInt32(row["Estado"]);
        }
    }
}
