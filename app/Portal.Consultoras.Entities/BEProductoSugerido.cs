using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEProductoSugerido
    {
        [DataMember]
        public int ProductoSugeridoID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string CUVSugerido { get; set; }
        [DataMember]
        public int Orden { get; set; }
        [DataMember]
        public string ImagenProducto { get; set; }
        [DataMember]
        public int Estado { get; set; }
        [DataMember]
        public string UsuarioRegistro { get; set; }
        [DataMember]
        public DateTime FechaRegistro { get; set; }
        [DataMember]
        public string UsuarioModificacion { get; set; }
        [DataMember]
        public DateTime FechaModificacion { get; set; }
        [DataMember]
        public int MostrarAgotado { get; set; }

        [DataMember]
        public int ConsultoraID { get; set; }
        [DataMember]
        public bool CuvEsAceptado { get; set; }
        [DataMember]
        public decimal PrecioUnidad { get; set; }

        public BEProductoSugerido(IDataRecord row)
        {
            ProductoSugeridoID = row.ToInt32("ProductoSugeridoID");
            CampaniaID = row.ToInt32("CampaniaID");
            CUV = row.ToString("CUV");
            CUVSugerido = row.ToString("CUVSugerido");
            Orden = row.ToInt32("Orden");
            ImagenProducto = row.ToString("ImagenProducto");
            Estado = row.ToInt32("Estado");
            FechaRegistro = row.ToDateTime("FechaRegistro");
            UsuarioRegistro = row.ToString("UsuarioRegistro");
            FechaModificacion = row.ToDateTime("FechaModificacion");
            UsuarioModificacion = row.ToString("UsuarioModificacion");
            MostrarAgotado = row.ToInt32("MostrarAgotado");
        }
    }
}
