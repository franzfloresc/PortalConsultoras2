using Portal.Consultoras.Web.ServiceSeguridad;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class UsuarioRolModel
    {
        public string RolDescripcion { get; set; }
        public string CodigoUsuario { get; set; }
        public string UsuarioNombre { get; set; }
        public int RolID { get; set; }
        public List<BERol> DropDownListRol { get; set; }
        public IEnumerable<PaisModel> listaPaises { get; set; }
        public Int32 PaisID { get; set; }
    }
}