using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class RVDigitalPaqueteDocumentarioModel
    {
        public int PaisID { get; set; }
        public IEnumerable<PaisModel> listaPaises { get; set; }
    }
}