using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class TipoEstrategiaModel
    {
        public int TipoEstrategiaID { set; get; }
        public string Descripcion { set; get; }
        public string UsuarioCreacion { set; get; }
        public string UsuarioModificacion { set; get; }
        public int Estado { set; get; }
        public int PaisID { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
        public int FlagNueva { get; set; }
        public int FlagRecoPerfil { get; set; }
        public int FlagRecoProduc { get; set; }
        public string Imagen { get; set; }
        public string Simbolo { get; set; }
        public string CodigoPrograma { get; set; }
        public int CodigoGeneral { get; set; }
    }
}