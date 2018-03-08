using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Portal.Consultoras.Web.Models
{
    public class ProductoComentarioModel
    {
        [Required]
        public int PaisID { get; set; }

        public IEnumerable<PaisModel> Paises { set; get; }

        public int EstadoComentarioID { get; set; }

        public IEnumerable<EstadoProductoComentarioModel> EstadosComentario { set; get; }

        public int TipoComentarioID { get; set; }

        public IEnumerable<TipoProductoComentarioModel> TiposComentario { get; set; }

        public string SAP { get; set; }


        public int CampaniaID { get; set; }
        public IEnumerable<CampaniaModel> Campanias { set; get; }

        public string CUV { get; set; }
    }
}