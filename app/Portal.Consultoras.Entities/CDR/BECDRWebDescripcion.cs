using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CDR
{
    public class BECDRWebDescripcion
    {
        [DataMember]
        public int CDRWebDescripcionID { get; set; }
        [DataMember]
        public string CodigoSSIC { get; set; }
        [DataMember]
        public string EntidadSSIC { get; set; }
        [DataMember]
        public string Tipo { get; set; }
        [DataMember]
        public string Descripcion { get; set; }

        public BECDRWebDescripcion()
        { }

        public BECDRWebDescripcion(IDataRecord row)
        {
            CDRWebDescripcionID = row.ToInt32("CDRWebDescripcionID");
            CodigoSSIC = row.ToString("CodigoSSIC");
            EntidadSSIC = row.ToString("EntidadSSIC");
            Tipo = row.ToString("Tipo");
            Descripcion = row.ToString("Descripcion");
        }
    }
}
