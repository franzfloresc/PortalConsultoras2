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
            CodigoRechazo = row.ToString("CodigoRechazo");
            DescripcionRechazo = row.ToString("DescripcionRechazo");
        }
    }
}
