using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class MatrizComercialResultadoModel
    {
        public string CodigoSAP { get; set; }
        public string Descripcion { get; set; }
        public string DescripcionOriginal { get; set; }
        public string DescripcionProductoComercial { get; set; }
        public int IdMatrizComercial { get; set; }
        public string FotoProductoAppCatalogo { get; set; }
        public List<MatrizComercialImagen> Imagenes { get; set; }
    }
}