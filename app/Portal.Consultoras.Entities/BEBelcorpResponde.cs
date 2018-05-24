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
            if (DataRecord.HasColumn(row, "PaisID"))
                PaisID = Convert.ToInt32(row["PaisID"]);
            if (DataRecord.HasColumn(row, "Telefono1"))
                Telefono1 = Convert.ToString(row["Telefono1"]);
            if (DataRecord.HasColumn(row, "Telefono2"))
                Telefono2 = Convert.ToString(row["Telefono2"]);
            if (DataRecord.HasColumn(row, "Escribenos"))
                Escribenos = Convert.ToString(row["Escribenos"]);
            if (DataRecord.HasColumn(row, "EscribenosURL"))
                EscribenosURL = Convert.ToString(row["EscribenosURL"]);
            if (DataRecord.HasColumn(row, "Chat"))
                Chat = Convert.ToString(row["Chat"]);
            if (DataRecord.HasColumn(row, "ChatURL"))
                ChatURL = Convert.ToString(row["ChatURL"]);
            if (DataRecord.HasColumn(row, "ParametroPais"))
                ParametroPais = Convert.ToBoolean(row["ParametroPais"]);
            if (DataRecord.HasColumn(row, "ParametroCodigoConsultora"))
                ParametroCodigoConsultora = Convert.ToBoolean(row["ParametroCodigoConsultora"]);

            if (DataRecord.HasColumn(row, "Correo"))
                Correo = Convert.ToString(row["Correo"]);
            if (DataRecord.HasColumn(row, "CorreoBcc"))
                CorreoBcc = Convert.ToString(row["CorreoBcc"]);
        }
    }
}
