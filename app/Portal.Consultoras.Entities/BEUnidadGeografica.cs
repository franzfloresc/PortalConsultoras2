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
            CodigoUbigeo = row.ToString("CodigoUbigeo");
            NivelUbigeo = row.ToInt32("Nivel");

            Descripcion = row.ToString("UnidadGeografica1");
            Descripcion = row.ToString("UnidadGeografica2", Descripcion);
            Descripcion = row.ToString("UnidadGeografica3", Descripcion);
        }
    }
}
