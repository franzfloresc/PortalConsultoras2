namespace Portal.Consultoras.Entities
{
    using Common;
    using System;
    using System.Data;
    using System.Runtime.Serialization;

    [DataContract]
    public class BEUbigeo
    {
        [DataMember]
        public int UbigeoID { get; set; }

        [DataMember]
        public string CodigoUbigeo { get; set; }

        [DataMember]
        public string UnidadGeografica1 { get; set; }

        [DataMember]
        public string UnidadGeografica2 { get; set; }

        [DataMember]
        public string UnidadGeografica3 { get; set; }

        [DataMember]
        public string UnidadGeografica4 { get; set; }


        public BEUbigeo()
        { }

        public BEUbigeo(IDataRecord row)
        {
            if (row.HasColumn("UbigeoID"))
                UbigeoID = Convert.ToInt32(row["UbigeoID"]);
            if (row.HasColumn("CodigoUbigeo"))
                CodigoUbigeo = Convert.ToString(row["CodigoUbigeo"]);
            if (row.HasColumn("UnidadGeografica1"))
                UnidadGeografica1 = Convert.ToString(row["UnidadGeografica1"]);
            if (row.HasColumn("UnidadGeografica2"))
                UnidadGeografica2 = Convert.ToString(row["UnidadGeografica2"]);
            if (row.HasColumn("UnidadGeografica3"))
                UnidadGeografica3 = Convert.ToString(row["UnidadGeografica3"]);
            if (row.HasColumn("UnidadGeografica4"))
                UnidadGeografica4 = Convert.ToString(row["UnidadGeografica4"]);
        }
    }
}
