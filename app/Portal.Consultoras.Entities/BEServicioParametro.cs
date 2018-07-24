using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEServicioParametro
    {
        [DataMember]
        public int ParametroId { get; set; }
        [DataMember]
        public int ServicioId { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string Abreviatura { get; set; }
        [DataMember]
        public string Correlativo { get; set; }

        public BEServicioParametro()
        {
        }

        public BEServicioParametro(IDataRecord row)
        {
            ParametroId = row.ToInt32("ParametroId");
            ServicioId = row.ToInt32("ServicioId");
            Descripcion = row.ToString("Descripcion");
            Abreviatura = row.ToString("Abreviatura");
            Correlativo = row.ToString("Correlativo");
        }
    }
}
