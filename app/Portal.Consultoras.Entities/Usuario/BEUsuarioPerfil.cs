using Portal.Consultoras.Common;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Usuario
{
    [DataContract]
    public class BEUsuarioPerfil
    {
        [DataMember]
        public string TipoEnvio { get; set; }
        [DataMember]
        public string DatoNuevo { get; set; }

        public BEUsuarioPerfil()
        { }

        public BEUsuarioPerfil(IDataRecord row)
        {
            TipoEnvio = row.ToString("TipoEnvio");
            DatoNuevo = row.ToString("DatoNuevo");
        }
    }

    [DataContract]
    public class BEMensajeToolTip
    {
        public BEMensajeToolTip()
        { }

        [DataMember]
        public string MensajeCelular { get; set; }
        [DataMember]
        public string MensajeEmail { get; set; }
        [DataMember]
        public string MensajeAmbos { get; set; }
        [DataMember]
        public List<BEUsuarioPerfil> oDatosPerfil { get; set; }
    }
}
