using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public enum ETipoFormulario : int
    {
        [EnumMember]
        Login = 1101,
        
        [EnumMember]
        Belcenter = 1102,

        [EnumMember]
        Telefonos = 1103,

        [EnumMember]
        Politicas = 1104,

        [EnumMember]
        Contratos = 1105,

        [EnumMember]
        LugaresPago = 1106
    }

    [DataContract]
    public enum EGrupoBanner : int
    {
        [EnumMember]
        Principal = 1,

        [EnumMember]
        SeccionIntermedia1 = 2,

        [EnumMember]
        SeccionIntermedia2 = 3,

        [EnumMember]
        SeccionIntermedia3 = 4,

        [EnumMember]
        SeccionIntermedia4 = 5,

        [EnumMember]
        SeccionBaja1 = 6,

        [EnumMember]
        SeccionBaja2 = 7,

        [EnumMember]
        SeccionBaja3 = 8,

        [EnumMember]
        SeccionBaja4 = 9
    }

    [DataContract]
    public enum EAplicacionOrigen : int
    {
        [EnumMember]
        BienvenidaConsultora = 1,

        [EnumMember]
        MisDatosConsultora = 2,

        [EnumMember]
        ActualizarClaveSAC = 3,

        [EnumMember]
        RecuperarClave = 4,

        [EnumMember]
        ConsultoraFicticia = 5,
    }
}