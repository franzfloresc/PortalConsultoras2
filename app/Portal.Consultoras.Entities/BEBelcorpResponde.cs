using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using OpenSource.Library.DataAccess;

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
        //R20150906
        [DataMember]
        public string Correo { get; set; }
        [DataMember]
        public string CorreoBcc { get; set; }

        public BEBelcorpResponde() { }
        public BEBelcorpResponde(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "PaisID") && row["PaisID"] != DBNull.Value)
                PaisID = Convert.ToInt32(row["PaisID"]);
            if (DataRecord.HasColumn(row, "Telefono1") && row["Telefono1"] != DBNull.Value)
                Telefono1 = Convert.ToString(row["Telefono1"]);
            if (DataRecord.HasColumn(row, "Telefono2") && row["Telefono2"] != DBNull.Value)
                Telefono2 = Convert.ToString(row["Telefono2"]);
            if (DataRecord.HasColumn(row, "Escribenos") && row["Escribenos"] != DBNull.Value)
                Escribenos = Convert.ToString(row["Escribenos"]);
            if (DataRecord.HasColumn(row, "EscribenosURL") && row["EscribenosURL"] != DBNull.Value)
                EscribenosURL = Convert.ToString(row["EscribenosURL"]);
            if (DataRecord.HasColumn(row, "Chat") && row["Chat"] != DBNull.Value)
                Chat = Convert.ToString(row["Chat"]);
            if (DataRecord.HasColumn(row, "ChatURL") && row["ChatURL"] != DBNull.Value)
                ChatURL = Convert.ToString(row["ChatURL"]);
            if (DataRecord.HasColumn(row, "ParametroPais") && row["ParametroPais"] != DBNull.Value)
                ParametroPais = Convert.ToBoolean(row["ParametroPais"]);
            if (DataRecord.HasColumn(row, "ParametroCodigoConsultora") && row["ParametroCodigoConsultora"] != DBNull.Value)
                ParametroCodigoConsultora = Convert.ToBoolean(row["ParametroCodigoConsultora"]);
            //R20150609
            if (DataRecord.HasColumn(row, "Correo") && row["Correo"] != DBNull.Value)
                Correo = Convert.ToString(row["Correo"]);
            if (DataRecord.HasColumn(row, "CorreoBcc") && row["CorreoBcc"] != DBNull.Value)
                CorreoBcc = Convert.ToString(row["CorreoBcc"]);
        }
    }
}
