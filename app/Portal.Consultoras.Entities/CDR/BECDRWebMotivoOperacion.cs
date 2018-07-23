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
            CodigoOperacion = row.ToString("CodigoOperacion");
            CodigoReclamo = row.ToString("CodigoReclamo");
            Prioridad = row.ToInt32("Prioridad");
            Estado = row.ToInt32("Estado");
        }
    }
}
