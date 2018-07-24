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
            CodigoReclamo = row.ToString("CodigoReclamo");
            DescripcionReclamo = row.ToString("DescripcionReclamo");
        }
    }
}
