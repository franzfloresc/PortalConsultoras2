using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConsultoraFicticia
    {
        [DataMember]
        public string CodigoUsuario { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string CodigoConsultoraFicticia { get; set; }
        [DataMember]
        public string PrimerNombre { get; set; }
        [DataMember]
        public string SegundoNombre { get; set; }
        [DataMember]
        public string PrimerApellido { get; set; }
        [DataMember]
        public string SegundoApellido { get; set; }
        [DataMember]
        public string NombreCompleto { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string ActualizarClave { get; set; }
        [DataMember]
        public string ConfirmarClave { get; set; }
        [DataMember]
        public string PaisNombre { get; set; }
        [DataMember]
        public string ZonaNombre { get; set; }
        [DataMember]
        public Int64 ConsultoraID { get; set; }

        public BEConsultoraFicticia()
        {
        }

        public BEConsultoraFicticia(IDataRecord row)
        {
            CodigoUsuario = row.ToString("CodigoUsuario");
            CodigoConsultora = row.ToString("CodigoConsultora");
            CodigoConsultoraFicticia = row.ToString("CodigoConsultoraFicticia");
            PrimerNombre = row.ToString("PrimerNombre");
            SegundoNombre = row.ToString("SegundoNombre");
            PrimerApellido = row.ToString("PrimerApellido");
            SegundoApellido = row.ToString("SegundoApellido");
            NombreCompleto = row.ToString("NombreCompleto");
            PaisNombre = row.ToString("PaisNombre");
            ZonaNombre = row.ToString("ZonaNombre");
            ConsultoraID = row.ToInt64("ConsultoraID");
        }
    }
}
