using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BETerminosCondiciones
    {
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public bool Aceptado { get; set; }
        [DataMember]
        public short Tipo { get; set; }

        public BETerminosCondiciones(IDataRecord row)
        {
            CodigoConsultora = row.ToString("CodigoConsultora");
            Aceptado = row.ToBoolean("Aceptado");
            Tipo = row.ToInt16("Tipo");
        }

        public BETerminosCondiciones()
        {

        }
    }
}
