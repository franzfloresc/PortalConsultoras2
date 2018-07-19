using System.Collections.Generic;

namespace Portal.Consultoras.Entities
{
    using Portal.Consultoras.Common;
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

            if (DataRecord.HasColumn(row, "UnidadGeografica1"))
                Descripcion = Convert.ToString(row["UnidadGeografica1"]);

            if (DataRecord.HasColumn(row, "UnidadGeografica2"))
                Descripcion = Convert.ToString(row["UnidadGeografica2"]);

            if (DataRecord.HasColumn(row, "UnidadGeografica3"))
                Descripcion = Convert.ToString(row["UnidadGeografica3"]);

        }
    }
}
