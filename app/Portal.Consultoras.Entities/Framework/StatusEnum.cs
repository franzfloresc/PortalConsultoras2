using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Framework
{
    /// <summary>
    /// Accion/Estado del objeto
    /// </summary>
    [DataContract(Name = "Status")]
    public enum StatusEnum : int
    {
        /// <summary>
        /// Elimina
        /// </summary>
        [EnumMember]
        Delete = -1,

        /// <summary>
        /// Crea
        /// </summary>
        [EnumMember]
        Create = 0,

        /// <summary>
        /// Actualiza
        /// </summary>
        [EnumMember]
        Update = 1
    }
}
