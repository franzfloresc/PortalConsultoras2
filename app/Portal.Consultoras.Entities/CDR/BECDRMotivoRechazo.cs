using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CDR
{
    public class BECDRMotivoRechazo
    {
        [DataMember]
        public string CodigoRechazo { get; set; }
        [DataMember]
        public string DescripcionRechazo { get; set; }

        public BECDRMotivoRechazo()
        { }

        public BECDRMotivoRechazo(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoRechazo")) CodigoRechazo = Convert.ToString(row["CodigoRechazo"]);
            if (DataRecord.HasColumn(row, "DescripcionRechazo")) DescripcionRechazo = Convert.ToString(row["DescripcionRechazo"]);
        }
    }
}
