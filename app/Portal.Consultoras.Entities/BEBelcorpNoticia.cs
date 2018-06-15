using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEBelcorpNoticia
    {
        [DataMember]
        public int BelcorpNoticiaID { set; get; }
        [DataMember]
        public int PaisID { set; get; }
        [DataMember]
        public string PaisNombre { set; get; }
        [DataMember]
        public int CampaniaID { set; get; }
        [DataMember]
        public string NombreCorto { set; get; }
        [DataMember]
        public long ConsultoraID { set; get; }
        [DataMember]
        public string Titulo { set; get; }
        [DataMember]
        public string ArchivoPortada { set; get; }
        [DataMember]
        public string UrlPDF { set; get; }

        public BEBelcorpNoticia()
        { }

        public BEBelcorpNoticia(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "BelcorpNoticiaID"))
                BelcorpNoticiaID = Convert.ToInt32(row["BelcorpNoticiaID"]);
            if (DataRecord.HasColumn(row, "PaisID"))
                PaisID = Convert.ToInt32(row["PaisID"]);
            if (DataRecord.HasColumn(row, "Nombre"))
                PaisNombre = Convert.ToString(row["Nombre"]);
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "NombreCorto"))
                NombreCorto = Convert.ToString(row["NombreCorto"]);
            if (DataRecord.HasColumn(row, "ConsultoraID"))
                ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "Titulo"))
                Titulo = Convert.ToString(row["Titulo"]);
            if (DataRecord.HasColumn(row, "ArchivoPortada"))
                ArchivoPortada = Convert.ToString(row["ArchivoPortada"]);
            if (DataRecord.HasColumn(row, "UrlPDF"))
                UrlPDF = Convert.ToString(row["UrlPDF"]);
        }
    }
}
