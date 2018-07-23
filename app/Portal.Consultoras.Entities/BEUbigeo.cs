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
            UbigeoID = row.ToInt32("UbigeoID");
            CodigoUbigeo = row.ToString("CodigoUbigeo");
            UnidadGeografica1 = row.ToString("UnidadGeografica1");
            UnidadGeografica2 = row.ToString("UnidadGeografica2");
            UnidadGeografica3 = row.ToString("UnidadGeografica3");
            UnidadGeografica4 = row.ToString("UnidadGeografica4");
        }
    }
}
