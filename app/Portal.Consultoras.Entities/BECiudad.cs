namespace Portal.Consultoras.Entities
{
    using Common;
    using System;
    using System.Data;
    using System.Runtime.Serialization;

    [DataContract]
    public class BECiudad
    {
        [DataMember]
        public int CiudadID { get; set; }
        [DataMember]
        public string CodigoRegion { get; set; }
        [DataMember]
        public string CodigoCiudad { get; set; }
        [DataMember]
        public string Descripcion { get; set; }

        public BECiudad()
        { }

        public BECiudad(IDataRecord row)
        {
            CiudadID = row.ToInt32("CiudadID");
            CodigoRegion = row.ToString("CodigoRegion");
            CodigoCiudad = row.ToString("CodigoCiudad");
            Descripcion = row.ToString("Descripcion");
        }
    }
}
