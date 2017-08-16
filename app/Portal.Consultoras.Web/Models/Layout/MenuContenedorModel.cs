namespace Portal.Consultoras.Web.Models.Layout
{
    public class MenuContenedorModel
    {
        public int CampaniaID { get; set; }
        public string Logo { get; set; }
        public string TituloMenu { get; set; }
        public string SubTituloMenu { get; set; }
        public int Orden { get; set; }

        public string LogoBanner { get; set; }
        public string FondoBanner { get; set; }
        public string TituloBanner { get; set; }
        public string SubTituloBanner { get; set; }

        public bool IsMenuCampania { get; set; }
        public bool IsActiva { get; set; }
    }
}