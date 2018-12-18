using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.Usuario
{
    [DataContract]
    public class BEUsuarioOpciones
    {
        [DataMember]
        public string CodigoUsuario { get; set; }
        [DataMember]
        public byte OpcionesUsuarioId { get; set; }
        [DataMember]
        public string Opcion { get; set; }
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public bool CheckBox { get; set; }
        [DataMember]
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
