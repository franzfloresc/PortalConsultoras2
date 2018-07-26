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
            CodigoConsultora = row.ToString("CodigoConsultora");
            Respuesta1 = row.ToInt32("Respuesta1");
            Respuesta2 = row.ToInt32("Respuesta2");
            Respuesta3 = row.ToInt32("Respuesta3");
            Respuesta4 = row.ToInt32("Respuesta4");
        }
    }
}
