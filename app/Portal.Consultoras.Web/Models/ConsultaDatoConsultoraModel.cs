namespace Portal.Consultoras.Web.Models
{
    using System.Collections.Generic;

    public class ConsultaDatoConsultoraModel
    {
        public IEnumerable<PaisModel> listaPaises { set; get; }
        public int PaisID { set; get; }
        public IEnumerable<CampaniaModel> listaCampania { set; get; }
    }
}