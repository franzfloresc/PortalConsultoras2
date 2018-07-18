using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
            if (DataRecord.HasColumn(row, "Cuv"))
                Cuv = Convert.ToString(row["Cuv"]);
            if (DataRecord.HasColumn(row, "RutaImagen"))
                RutaImagen = Convert.ToString(row["RutaImagen"]);
        }
    }
}
