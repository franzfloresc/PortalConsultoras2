namespace Portal.Consultoras.Web.Models.Estrategia.Response
{
    public class EstrategiaDetalle
    {
        public string _id { get; set; }
        public int EstrategiaId { get; set; }
        public int TablaLogicaDatosID { get; set; }
        public int TablaLogicaID { get; set; }
        public string Codigo { get; set; }
        public string Descripcion { get; set; }
        public string Valor { get; set; }
        public bool Estado { get; set; }
    }
}