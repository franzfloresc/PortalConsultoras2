namespace Portal.Consultoras.Web.Models.DetalleEstrategia
{
    public class DetalleEstrategiaBreadCrumbsModel
    {
        public DetalleEstrategiaBreadCrumbsModel()
        {
            Inicio = new BreadCrumbModel();
            Ofertas = new BreadCrumbModel();
            Palanca = new BreadCrumbModel();
            Producto = new BreadCrumbModel();
        }

        public bool Visible
        {
            get
            {
                return true;
            }
        }

        public BreadCrumbModel Inicio { get; set; }
        public BreadCrumbModel Ofertas { get; set; }
        public BreadCrumbModel Palanca { get; set; }
        public BreadCrumbModel Producto { get; set; }
    }
}