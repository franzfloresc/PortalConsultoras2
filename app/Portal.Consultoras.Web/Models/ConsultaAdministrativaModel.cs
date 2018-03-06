using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ConsultaAdministrativaModel
    {
        public IEnumerable<PaisModel> listaPaises { set; get; }
        public int PaisID { get; set; }
    }
}