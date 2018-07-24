using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{

    [DataContract]
    public class BEConsultoraDigitales
    {
        [DataMember]
        public string IPUsuario { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }

        public BEConsultoraDigitales(IDataRecord row)
        {
            IPUsuario = row.ToString("IPUsuario");
            CampaniaID = row.ToInt32("CampaniaID");
            CodigoConsultora = row.ToString("CodigoConsultora");
        }

    }
}
