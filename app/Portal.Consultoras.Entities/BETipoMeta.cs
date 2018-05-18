namespace Portal.Consultoras.Entities
{
    using Common;
    using System;
    using System.Data;
    using System.Runtime.Serialization;

    [DataContract]
    public class BETipoMeta
    {
        [DataMember]
        public int IdTipoMeta { get; set; }

        [DataMember]
        public string CodigoMeta { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public int EstadoActivo { get; set; }

        [DataMember]
        public decimal MontoMinimo { get; set; }

        [DataMember]
        public decimal MontoMaximo { get; set; }

        [DataMember]
        public int PaisID { get; set; }

        public BETipoMeta()
        { }

        public BETipoMeta(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "IdTipoMeta"))
                IdTipoMeta = Convert.ToInt32(row["IdTipoMeta"]);
            if (DataRecord.HasColumn(row, "CodigoMeta"))
                CodigoMeta = Convert.ToString(row["CodigoMeta"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "EstadoActivo"))
                EstadoActivo = Convert.ToInt32(row["EstadoActivo"]);
            if (DataRecord.HasColumn(row, "MontoMinimo"))
                MontoMinimo = Convert.ToDecimal(row["MontoMinimo"]);
            if (DataRecord.HasColumn(row, "MontoMaximo"))
                MontoMaximo = Convert.ToDecimal(row["MontoMaximo"]);
            if (DataRecord.HasColumn(row, "PaisID"))
                PaisID = Convert.ToInt32(row["PaisID"]);
        }
    }
}
