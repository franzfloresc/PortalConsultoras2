using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPopupPais
    {
        [DataMember]
        public int PopupPaisID { get; set; }

        [DataMember]
        public int CodigoPopup { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public int Orden { get; set; }

        public BEPopupPais()
        {
        }

        public BEPopupPais(IDataRecord record)
        {
            PopupPaisID = Convert.ToInt32(record["PopupPaisID"]);
            CodigoPopup = Convert.ToInt32(record["CodigoPopup"]);
            Descripcion = record["Descripcion"] != DBNull.Value ? Convert.ToString(record["Descripcion"]) : string.Empty;
            Orden = record["Orden"] != DBNull.Value ? Convert.ToInt32(record["Orden"]) : 0;
        }
    }
}
