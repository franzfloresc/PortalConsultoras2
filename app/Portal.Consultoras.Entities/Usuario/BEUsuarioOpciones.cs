using Portal.Consultoras.Common;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Usuario
{
    [DataContract]
    public class BEUsuarioOpciones
    {
        [DataMember]
        [Column("CodigoUsuario")]
        public string CodigoUsuario { get; set; }
        [DataMember]
        [Column("OpcionesUsuarioId")]
        public byte OpcionesUsuarioId { get; set; }
        [DataMember]
        [Column("Opcion")]
        public string Opcion { get; set; }
        [DataMember]
        [Column("Codigo")]
        public string Codigo { get; set; }
        [DataMember]
        [Column("CheckBox")]
        public bool CheckBox { get; set; }
        [DataMember]
        [Column("Activo")]
        public bool Activo { get; set; }
        public BEUsuarioOpciones()
        { }

        public BEUsuarioOpciones(IDataRecord row)
        {
            CodigoUsuario = row.ToString("CodigoUsuario");
            OpcionesUsuarioId = row.ToByte("OpcionesUsuarioId");
            Opcion = row.ToString("Opcion");
            Codigo = row.ToString("Codigo");
            CheckBox = row.ToBoolean("CheckBox");
            Activo = row.ToBoolean("Activo");
        }
    }
}
