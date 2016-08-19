namespace Portal.Consultoras.Web.GestionPasos
{
    public class ZonaParameter
    {
        public string Zona { get; set; }
        public bool EsPreferencial { get; set; }

        public ZonaParameter(string zona, bool esPreferencial)
        {
            Zona = zona;
            EsPreferencial = esPreferencial;
        }
    }
}