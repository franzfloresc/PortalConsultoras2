using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEEtiqueta
    {
        [DataMember]
        public int EtiquetaID { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public string UsuarioCreacion { get; set; }

        [DataMember]
        public string UsuarioModificacion { get; set; }

        [DataMember]
        public int Estado { get; set; }

        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public int CodigoGeneral { get; set; }

        public BEEtiqueta(IDataRecord row)
        {
            EtiquetaID = row.ToInt32("EtiquetaID");
            Descripcion = row.ToString("Descripcion");
            Estado = row.ToInt32("Estado");
            CodigoGeneral = row.ToInt32("CodigoGeneral");
        }
    }

}
