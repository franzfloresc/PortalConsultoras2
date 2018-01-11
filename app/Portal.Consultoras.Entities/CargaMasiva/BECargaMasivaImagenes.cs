using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.CargaMasiva
{
    [DataContract]
    public class BECargaMasivaImagenes
    {
        [DataMember]
        public string Cuv { get; set; }
        [DataMember]
        public string RutaImagen { get; set; }

        public BECargaMasivaImagenes(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "Cuv") && row["Cuv"] != DBNull.Value)
                Cuv = row["Cuv"].ToString();
            if (DataRecord.HasColumn(row, "RutaImagen") && row["RutaImagen"] != DBNull.Value)
                RutaImagen = row["RutaImagen"].ToString();
        }
    }
}
