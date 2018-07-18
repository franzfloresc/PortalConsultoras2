using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEBelcorpResponde
    {
        [DataMember(IsRequired = true)]
        public int PaisID { get; set; }
        [DataMember]
        public string Telefono1 { get; set; }
        [DataMember]
        public string Telefono2 { get; set; }
        [DataMember]
        public string Escribenos { get; set; }
        [DataMember]
        public string EscribenosURL { get; set; }
        [DataMember]
        public string Chat { get; set; }
        [DataMember]
        public string ChatURL { get; set; }
        [DataMember]
        public Boolean ParametroPais { get; set; }
        [DataMember]
        public Boolean ParametroCodigoConsultora { get; set; }

        [DataMember]
        public string Correo { get; set; }
        [DataMember]
        public string CorreoBcc { get; set; }

        public BEBelcorpResponde() { }
        public BEBelcorpResponde(IDataRecord row)
        {
            PaisID = row.ToInt32("PaisID");
            Telefono1 = row.ToString("Telefono1");
            Telefono2 = row.ToString("Telefono2");
            Escribenos = row.ToString("Escribenos");
            EscribenosURL = row.ToString("EscribenosURL");
            Chat = row.ToString("Chat");
            ChatURL = row.ToString("ChatURL");
            ParametroPais = row.ToBoolean("ParametroPais");
            ParametroCodigoConsultora = row.ToBoolean("ParametroCodigoConsultora");
            Correo = row.ToString("Correo");
            CorreoBcc = row.ToString("CorreoBcc");
        }
    }
}
