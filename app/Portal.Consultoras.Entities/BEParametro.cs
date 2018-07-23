using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEParametro
    {
        [DataMember]
        public int ParametroId { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string Abreviatura { get; set; }

        public BEParametro()
        {
        }

        public BEParametro(IDataRecord row)
        {
            ParametroId = row.ToInt32("ParametroId");
            Descripcion = row.ToString("Descripcion");
            Abreviatura = row.ToString("Abreviatura");
        }
    }
}
