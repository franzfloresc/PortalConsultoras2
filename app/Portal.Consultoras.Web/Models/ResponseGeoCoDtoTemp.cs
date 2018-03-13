namespace Portal.Consultoras.Web.Models
{
    public class ResponseGeoCoDtoTemp
    {
        public bool success { get; set; }
        public string message { get; set; }
        public ResponseDataTemp data { get; set; }
    }

    public class ResponseDataTemp
    {
        public string pais { get; set; }
        public string dirAlterna { get; set; }
        public string dirtrad { get; set; }
        public string localidad { get; set; }
        public string barrio { get; set; }
        public string latitude { get; set; }
        public string longitude { get; set; }
        public string zona1 { get; set; }
        public string zonapostal { get; set; }
        public string estado { get; set; }
    }
}