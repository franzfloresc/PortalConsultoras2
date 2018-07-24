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
            IdTipoMeta = row.ToInt32("IdTipoMeta");
            CodigoMeta = row.ToString("CodigoMeta");
            Descripcion = row.ToString("Descripcion");
            EstadoActivo = row.ToInt32("EstadoActivo");
            MontoMinimo = row.ToDecimal("MontoMinimo");
            MontoMaximo = row.ToDecimal("MontoMaximo");
            PaisID = row.ToInt32("PaisID");
        }
    }
}
