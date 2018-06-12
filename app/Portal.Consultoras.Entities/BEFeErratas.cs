using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEFeErratas
    {
        [DataMember]
        public int FeErratasID { set; get; }
        [DataMember]
        public int PaisID { set; get; }
        [DataMember]
        public string PaisNombre { set; get; }
        [DataMember]
        public int CampaniaID { set; get; }
        [DataMember]
        public string NombreCorto { set; get; }
        [DataMember]
        public string Titulo { set; get; }
        [DataMember]
        public int Pagina { set; get; }
        [DataMember]
        public string Dice { set; get; }
        [DataMember]
        public string DebeDecir { set; get; }

        public BEFeErratas()
        { }

        public BEFeErratas(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "FeErratasID"))
                FeErratasID = Convert.ToInt32(row["FeErratasID"]);
            if (DataRecord.HasColumn(row, "PaisID"))
                PaisID = Convert.ToInt32(row["PaisID"]);
            if (DataRecord.HasColumn(row, "PaisNombre"))
                PaisNombre = Convert.ToString(row["PaisNombre"]);
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "NombreCorto"))
                NombreCorto = Convert.ToString(row["NombreCorto"]);
            if (DataRecord.HasColumn(row, "Titulo"))
                Titulo = Convert.ToString(row["Titulo"]);
            else
                Titulo = string.Empty;
            if (DataRecord.HasColumn(row, "Pagina"))
                Pagina = Convert.ToInt32(row["Pagina"]);
            if (DataRecord.HasColumn(row, "Dice"))
                Dice = Convert.ToString(row["Dice"]);
            if (DataRecord.HasColumn(row, "DebeDecir"))
                DebeDecir = Convert.ToString(row["DebeDecir"]);
        }
    }
}
