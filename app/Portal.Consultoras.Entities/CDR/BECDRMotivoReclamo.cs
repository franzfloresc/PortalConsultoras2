using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CDR
{
    public class BECDRMotivoReclamo
    {
        [DataMember]
        public string CodigoReclamo { get; set; }
        [DataMember]
        public string DescripcionReclamo { get; set; }

        public BECDRMotivoReclamo()
        { }

        public BECDRMotivoReclamo(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoReclamo")) CodigoReclamo = Convert.ToString(row["CodigoReclamo"]);
            if (DataRecord.HasColumn(row, "DescripcionReclamo")) DescripcionReclamo = Convert.ToString(row["DescripcionReclamo"]);
        }
    }
}
