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
            MotivoSolicitudID = row.ToInt32("MotivoSolicitudID");
            Motivo = row.ToString("Motivo");
            Tipo = row.ToInt32("Tipo");
            Estado = row.ToInt16("Estado");
        }
    }
}
