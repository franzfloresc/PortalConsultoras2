using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Cupon
{
    [DataContract]
    public class BECupon
    {
        [DataMember]
        public int CuponId { get; set; }
        [DataMember]
        public string Tipo { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public int CampaniaId { get; set; }
        [DataMember]
        public bool Estado { get; set; }
        [DataMember]
        public DateTime FechaCreacion { get; set; }
        [DataMember]
        public DateTime FechaModificacion { get; set; }
        [DataMember]
        public string UsuarioCreacion { get; set; }
        [DataMember]
        public string UsuarioModificacion { get; set; }

        public BECupon(IDataRecord row)
        {
            CuponId = row.ToInt32("CuponId");
            Tipo = row.ToString("Tipo");
            Descripcion = row.ToString("Descripcion");
            CampaniaId = row.ToInt32("CampaniaId");
            Estado = row.ToBoolean("Estado");
            FechaCreacion = row.ToDateTime("FechaCreacion");
            FechaModificacion = row.ToDateTime("FechaModificacion");
            UsuarioCreacion = row.ToString("UsuarioCreacion");
            UsuarioModificacion = row.ToString("UsuarioModificacion");
        }
    }
}
