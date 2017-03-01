using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ShowRoomOfertaDetalleModel
    {
        public int OfertaShowRoomDetalleID { get; set; }

        public int CampaniaID { get; set; }

        public string CUV { get; set; }

        public string NombreSet { get; set; }

        public string NombreProducto { get; set; }

        public string Descripcion1 { get; set; }

        public string Descripcion2 { get; set; }

        public string Descripcion3 { get; set; }

        public string Imagen { get; set; }

        public DateTime FechaCreacion { get; set; }

        public string UsuarioCreacion { get; set; }

        public DateTime FechaModificacion { get; set; }

        public string UsuarioModificacion { get; set; }

        public string ImagenAnterior { get; set; }

        public string MarcaProducto { get; set; }
    }
}