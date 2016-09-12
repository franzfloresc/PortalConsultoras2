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
                CampaniaID = DbConvert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "NombreCorto"))
                NombreCorto = DbConvert.ToString(row["NombreCorto"]);
            if (DataRecord.HasColumn(row, "Titulo"))
                Titulo = DbConvert.ToString(row["Titulo"]);
            else
                Titulo = string.Empty;
            if (DataRecord.HasColumn(row, "Pagina"))
                Pagina = DbConvert.ToInt32(row["Pagina"]);
            if (DataRecord.HasColumn(row, "Dice"))
                Dice = DbConvert.ToString(row["Dice"]);
            if (DataRecord.HasColumn(row, "DebeDecir"))
                DebeDecir = DbConvert.ToString(row["DebeDecir"]);
        }
    }
}
