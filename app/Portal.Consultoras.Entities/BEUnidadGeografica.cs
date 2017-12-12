using System.Collections.Generic;

namespace Portal.Consultoras.Entities
{
    using System;
    using System.Data;
    using System.Runtime.Serialization;

    [DataContract]
    public class BEUnidadGeografica
    {
        [DataMember]
        public string CodigoUbigeo { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        public int NivelUbigeo { get; set; }

        [DataMember]
        public List<BEUnidadGeografica> Ubigeo { get; set; }

        public BEUnidadGeografica()
        { }

        public BEUnidadGeografica(IDataRecord row)
        {
            CodigoUbigeo = Convert.ToString(row["CodigoUbigeo"]);
            NivelUbigeo = Convert.ToInt32(row["Nivel"]);
            if (row["UnidadGeografica1"].ToString() != "")
                Descripcion = Convert.ToString(row["UnidadGeografica1"]);

            if (row["UnidadGeografica2"].ToString() != "")
                Descripcion = Convert.ToString(row["UnidadGeografica2"]);

            if (row["UnidadGeografica3"].ToString() != "")
                Descripcion = Convert.ToString(row["UnidadGeografica3"]);

        }
    }
}
