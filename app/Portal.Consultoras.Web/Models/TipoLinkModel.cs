namespace Portal.Consultoras.Web.Models
{
    public class TipoLinkModel
    {
        public int PaisID { get; set; }
        public int TipoLinkID { get; set; }
        public string Url { get; set; }

        public TipoLinkModel()
        {
            this.Url = string.Empty;
        }
    }
}