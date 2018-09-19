using Portal.Consultoras.Common;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Usuario
{
    [DataContract]
    public class BEUsuarioDireccion
    {
        [DataMember]
        public string Ciudad { get; set; }
        [DataMember]
        public string Direccion { get; set; }

        public BEUsuarioDireccion()
        {
        }

        public BEUsuarioDireccion(IDataRecord row)
        {
            Ciudad = row.ToString("Ciudad");
            Direccion = row.ToString("Direccion");
        }
    }
}
