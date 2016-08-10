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
            if (row.HasColumn("UbigeoID") && row["UbigeoID"] != DBNull.Value)
                UbigeoID = Convert.ToInt32(row["UbigeoID"]);
            if (row.HasColumn("CodigoUbigeo") && row["CodigoUbigeo"] != DBNull.Value)
                CodigoUbigeo = Convert.ToString(row["CodigoUbigeo"]);
            if (row.HasColumn("UnidadGeografica1") && row["UnidadGeografica1"] != DBNull.Value)
                UnidadGeografica1 = Convert.ToString(row["UnidadGeografica1"]);
            if (row.HasColumn("UnidadGeografica2") && row["UnidadGeografica2"] != DBNull.Value)
                UnidadGeografica2 = Convert.ToString(row["UnidadGeografica2"]);
            if (row.HasColumn("UnidadGeografica3") && row["UnidadGeografica3"] != DBNull.Value)
                UnidadGeografica3 = Convert.ToString(row["UnidadGeografica3"]);
            if (row.HasColumn("UnidadGeografica4") && row["UnidadGeografica4"] != DBNull.Value)
                UnidadGeografica4 = Convert.ToString(row["UnidadGeografica4"]);
        }
    }
}
