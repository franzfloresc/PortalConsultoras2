using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class LoginModel
    {
        public int PaisID { get; set; }
        public string CodigoISO { get; set; }
        public string CodigoUsuario { get; set; }
        public string ClaveSecreta { get; set; }
        public IEnumerable<PaisModel> ListaPaises { get; set; }
        public List<EventoFestivoModel> ListaEventos { get; set; }
        public string NombreClase { get; set; }
        public string RutaEventoEsika { get; set; }
        public string RutaEventoLBel { get; set; }
        public string PasswordCjs { get; set; }
        public string Salt { get; set; }
        public string Key { get; set; }
        public string Iv { get; set; }

        public UsuarioExternoModel UsuarioExterno { get; set; }

        public List<LoginAnalyticsModel> ListPaisAnalytics { get; set; }
    }
}