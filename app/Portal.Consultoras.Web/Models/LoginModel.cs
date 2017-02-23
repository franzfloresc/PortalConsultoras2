using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class LoginModel
    {
        public int PaisID { get; set; }
        public string CodigoISO { get; set; }
        public string CodigoUsuario { get; set; }
        public string ClaveSecreta { get; set; }
        public IEnumerable<PaisModel> ListaPaises { get; set; }
    }
}