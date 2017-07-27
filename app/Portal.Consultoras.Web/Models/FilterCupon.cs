namespace Portal.Consultoras.Web.Models
{
    public class FilterCupon
    {
        public string SortColumn { get; set; }
        public string SortOrder { get; set; }
        public int Page { get; set; }
        public int Rows { get; set; }
        public int PaisID { get; set; }
        public int CampaniaID { get; set; }
    }
}