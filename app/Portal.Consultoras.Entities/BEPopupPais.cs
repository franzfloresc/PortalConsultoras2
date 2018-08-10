using Portal.Consultoras.Common;
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

        public BEPopupPais(IDataRecord row)
        {
            Descripcion = string.Empty;
            PopupPaisID = row.ToInt32("PopupPaisID");
            CodigoPopup = row.ToInt32("CodigoPopup");
            Descripcion = row.ToString("Descripcion");
            Orden = row.ToInt32("Orden");
        }
    }
}
