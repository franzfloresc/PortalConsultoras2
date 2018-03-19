using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class FormularioInformativoModel
    {
        public int PaisID { set; get; }
        public int FormularioDatoID { set; get; }
        public string NombreArchivoPdf { set; get; }
        public string URL { set; get; }
        public string Descripcion { set; get; }

        public IEnumerable<PaisModel> listaPaises { set; get; }
    }
}