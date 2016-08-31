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
            if (DataRecord.HasColumn(row, "CiudadID"))
                CiudadID = Convert.ToInt32(row["CiudadID"]);
            if (DataRecord.HasColumn(row, "CodigoRegion"))
                CodigoRegion = Convert.ToString(row["CodigoRegion"]);
            if (DataRecord.HasColumn(row, "CodigoCiudad"))
                CodigoCiudad = Convert.ToString(row["CodigoCiudad"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
        }
    }
}
