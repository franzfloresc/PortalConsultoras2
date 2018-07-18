using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEDatosBelcorp
    {
        [DataMember]
        public string RazonSocial { get; set; }
        [DataMember]
        public string NombreComercial { get; set; }
        [DataMember]
        public string RUC { get; set; }
        [DataMember]
        public string Direccion { get; set; }

        public BEDatosBelcorp()
        { }

        public BEDatosBelcorp(IDataRecord row)
        {
            RazonSocial = row.ToString("RazonSocial");
            NombreComercial = row.ToString("NombreComercial");
            RUC = row.ToString("RUC");
            Direccion = row.ToString("Direccion");
        }
    }
}
