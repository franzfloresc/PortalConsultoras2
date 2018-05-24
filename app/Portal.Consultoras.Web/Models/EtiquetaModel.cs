using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class EtiquetaModel
    {
        public int EtiquetaID { set; get; }
        public string Descripcion { set; get; }
        public string UsuarioCreacion { set; get; }
        public string UsuarioModificacion { set; get; }
        public int Estado { set; get; }
        public int PaisID { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
        public int CodigoGeneral { get; set; }
    }
}