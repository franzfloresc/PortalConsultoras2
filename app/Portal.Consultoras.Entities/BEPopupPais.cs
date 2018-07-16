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

            PopupPaisID = Convert.ToInt32(row["PopupPaisID"]);
            CodigoPopup = Convert.ToInt32(row["CodigoPopup"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "Orden"))
                Orden = Convert.ToInt32(row["Orden"]);
        }
    }
}
